#!/bin/bash

api="https://ext2.10minemail.com"
token=null
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.114 Safari/537.36"

function generate_email() {
	response=$(curl --request POST \
		--url "$api/mailbox" \
		--user-agent "$user_agent" \
		--header "content-type: application/json")
	if [ -n $(jq -r ".token" <<< "$response") ]; then
		token=$(jq -r ".token" <<< "$response")
	fi
	echo $response
}


function get_messages() {
	curl --request POST \
		--url "$api/messages" \
		--user-agent "$user_agent" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token"
}
