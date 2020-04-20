Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4B1B11CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 18:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgDTQkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726686AbgDTQkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:40:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E1C08E859
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f13so12942592wrm.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2020 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=fQU+AuwN78dS8p/RffRsQD3zEibMPtZpaQi8xF9V558f5Ma++tNgxW/ul2pOIsxnpw
         ELYOUcKGMdWB8FGbdUepTObNu813OUKjITPCNmwJif28FoUo4vVjflykZGB8le7+MCug
         zpWNV7+Bn+bx0y5c574pwjj33mLlm+hXsbu1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=gJwtiHPN45/QmjGU3d+9uzrtQh0ncHdYXQn1ynPwHOe1g9vrZsL38NN62tcDsIEvzK
         6jAOqBjm5mcrYUQ6whq7Yq9mOK1ez66tMIjFnFCzlw2tZH5Gs7QXr+VMgg/7kS+/STWK
         VU3P0g3c3vpJeoH3XkygGhEfejGXYdwsym3X1OvjQgmpN486Gjyyd00W7IibmH7vN1uT
         Z5TBOhVlIBm85PtI1UfIESfYiVgEnCSB7N4p77WuU0ZLZ6B53dgPcqkKZuuFMAjadxqE
         YxBoNi+VRJpWhXJxUvoyLzjXjjTNkxKDwUsGziS9L7VzOFgp37nqWa7sMLgaDau9KTva
         qM7w==
X-Gm-Message-State: AGi0PuYGMFUfkG47r8qt2NMO0ewStSuO0Tt0PMQzidQsxcPGYbUSixPC
        lpnuVMSs3Ut8SK4ZD7AkMlUIcw==
X-Google-Smtp-Source: APiQypJE17U7UjlhO0thwtwB3HRo9flqpaUhjXQ8JAYBeWvA+eexDk49NW2eFLMN0aesHLyAfKfb/Q==
X-Received: by 2002:a05:6000:1044:: with SMTP id c4mr21032922wrx.57.1587400130857;
        Mon, 20 Apr 2020 09:28:50 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 36sm14882wrc.35.2020.04.20.09.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 09:28:50 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3 4/7] firmware: test partial file reads of request_firmware_into_buf
Date:   Mon, 20 Apr 2020 09:28:06 -0700
Message-Id: <20200420162809.17529-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420162809.17529-1-scott.branden@broadcom.com>
References: <20200420162809.17529-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add firmware tests for partial file reads of request_firmware_into_buf.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../selftests/firmware/fw_filesystem.sh       | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index fcc281373b4d..38e89ba1b4d3 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -149,6 +149,26 @@ config_unset_into_buf()
 	echo 0 >  $DIR/config_into_buf
 }
 
+config_set_buf_size()
+{
+	echo $1 >  $DIR/config_buf_size
+}
+
+config_set_file_offset()
+{
+	echo $1 >  $DIR/config_file_offset
+}
+
+config_set_partial()
+{
+	echo 1 >  $DIR/config_partial
+}
+
+config_unset_partial()
+{
+	echo 0 >  $DIR/config_partial
+}
+
 config_set_sync_direct()
 {
 	echo 1 >  $DIR/config_sync_direct
@@ -207,6 +227,35 @@ read_firmwares()
 	done
 }
 
+read_firmwares_partial()
+{
+	if [ "$(cat $DIR/config_into_buf)" == "1" ]; then
+		fwfile="${FW_INTO_BUF}"
+	else
+		fwfile="${FW}"
+	fi
+
+	if [ "$1" = "xzonly" ]; then
+		fwfile="${fwfile}-orig"
+	fi
+
+	# Strip fwfile down to match partial offset and length
+	partial_data="$(cat $fwfile)"
+	partial_data="${partial_data:$2:$3}"
+
+	for i in $(seq 0 3); do
+		config_set_read_fw_idx $i
+
+		read_firmware="$(cat $DIR/read_firmware)"
+
+		# Verify the contents are what we expect.
+		if [ $read_firmware != $partial_data ]; then
+			echo "request #$i: partial firmware was not loaded" >&2
+			exit 1
+		fi
+	done
+}
+
 read_firmwares_expect_nofile()
 {
 	for i in $(seq 0 3); do
@@ -319,6 +368,21 @@ test_batched_request_firmware_into_buf()
 	echo "OK"
 }
 
+test_batched_request_firmware_into_buf_partial()
+{
+	echo -n "Batched request_firmware_into_buf_partial() $2 off=$3 size=$4 try #$1: "
+	config_reset
+	config_set_name $TEST_FIRMWARE_INTO_BUF_FILENAME
+	config_set_into_buf
+	config_set_partial
+	config_set_buf_size $4
+	config_set_file_offset $3
+	config_trigger_sync
+	read_firmwares_partial $2 $3 $4
+	release_all_firmware
+	echo "OK"
+}
+
 test_batched_request_firmware_direct()
 {
 	echo -n "Batched request_firmware_direct() $2 try #$1: "
@@ -371,6 +435,22 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware_into_buf $i normal
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 0 10
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 0 5
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 1 6
+done
+
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_partial $i normal 2 10
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i normal
 done
-- 
2.17.1

