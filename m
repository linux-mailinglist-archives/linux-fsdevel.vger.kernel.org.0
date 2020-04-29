Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118191BE4E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 19:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD2RJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727108AbgD2RJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:09:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C9C035494
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 10:09:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s10so1074086plr.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2020 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=TMnfK9c6OUjR3PfrRtOyEDASh2ljV1yPsKuUJbLcnpxSgD7MyTbchWSZq4gxaUJX3q
         R1BD3l1O4fFA3jt10dw8s8gDllyUZfE2KcQZ0iSc7/Yf/BAkrEblr4IVTEGsmSKRRPzC
         a8RUfkE4fCWBsk5TFTuxmT5WoVcAIF+XXXGQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JPCDjhWyTHrRtN+IrpzH/X2NJ9wHqJH6zPza8eFFddg=;
        b=iJ5iaQRdo58Alztgcv99FnFWesYWhkRwPZ/rr2+E7Bfn2wgoh8WT0Q77rqm+qPa52J
         03Z580EE6sxPncW5s/vTDe/MfH103PP8cOPOM5r71NS8+pTW8lob680WFScNpNcNLmjR
         pXycdP/URD1+aZ99E87r+P6Zzlurm9FJpyocKzmLnvpWRDnWlxIJdLxwHFPv5CLGkoIq
         ugAeL0tVLCTndwV3WK9Nejb4k2eKnOo2QOspOSLFHxbcfTJZXFfQg4qkejmUKGwCiupn
         isqAUSGsmhvbkf38TnjdMSfeQQyo9NHB6IlReKphjvsPmBGW+aiLwcd5nxQb6BTsUBoa
         n/pQ==
X-Gm-Message-State: AGi0PuZAgdbaqJnU1/clBZU0nvl0r90n99HhON1nhvLiSssyw1nUcfZp
        oUrDaDRHKZ76hlTwrhnesAk6cA==
X-Google-Smtp-Source: APiQypKtPN8uDfCF05J8fULZYrBc1saM25b2tK32573DHpSBhHgmnCjDeqgBIEFVsglLWrMFB1x+SQ==
X-Received: by 2002:a17:902:70c2:: with SMTP id l2mr8473846plt.112.1588180184158;
        Wed, 29 Apr 2020 10:09:44 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id y63sm1574456pfg.138.2020.04.29.10.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:09:43 -0700 (PDT)
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
Subject: [PATCH v4 4/7] firmware: test partial file reads of request_firmware_into_buf
Date:   Wed, 29 Apr 2020 10:09:11 -0700
Message-Id: <20200429170914.30976-5-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429170914.30976-1-scott.branden@broadcom.com>
References: <20200429170914.30976-1-scott.branden@broadcom.com>
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

