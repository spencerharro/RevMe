# Manager versioning of files for Collaborator Reviews
Write-Host "--------------------"
Write-Host "->  RevMe v. 1.0  <-"
Write-Host "--------------------"

Write-Host "Select a file:"
# Get current directory
$ParentDir = 'C:\Users\sharro\Documents\rev-my-file\'

# Create table of current file in directory
Get-ItemProperty ($ParentDir + '*') | Format-Table -Property "Name" -HideTableHeaders

$file = Read-Host "Please Rev Me"

#Write-Host "Similar files to $file"
#Get-ItemProperty ($ParentDir + '*') | Where-Object -Property "Name" -Like ((Get-Item $ParentDir$file ).BaseName + "*") | Format-Table -Property "Name" -HideTableHeaders

$filenames_list = Get-ItemProperty("$ParentDir*") | Where-Object -Property "Name" -Like ((Get-Item $ParentDir$file).BaseName + "*")
$rev_count = $filenames_list.Count

$filename = (Get-Item $ParentDir$file ).BaseName
$FileExtension = (Get-Item $ParentDir$file ).Extension

$NewFilePath = "$ParentDir$filename" + "_" + "$rev_count$FileExtension"

# Copy file to new revised file
Copy-Item "$ParentDir$file" -Destination "$NewFilePath"

# Update new file's last write time to current time
(Get-Item $NewFilePath).LastWriteTime = (get-date)

# Confirmation
Write-Host "------------------"
Write-Host "New Rev #" + $rev_count + " created at $NewFilePath"