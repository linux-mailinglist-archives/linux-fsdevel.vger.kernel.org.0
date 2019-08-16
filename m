Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A28F7DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfHPAKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 20:10:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34874 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfHPAKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 20:10:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so2038654pgv.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2019 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7zlafmTbJBNGW+lqh38oB6Up9ahjGRN/b/TjtVmaIo=;
        b=cQaZ0p7pFvsd9Hr18wDI8s193SCzyMkmWBf0bj8BCv35RjctLgCw3PFGqItI9joe+q
         vzn3J+aPF6prY3CNkTXelrkr3iVerzxk5Gsyr40/FqZZKpLxOuXDVH9Tl8hWzkp3wRT/
         jI3FbiRpy9ZV4kBlN/hjOEgyayH/GtuoaxruE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7zlafmTbJBNGW+lqh38oB6Up9ahjGRN/b/TjtVmaIo=;
        b=BmYhvmhxYzFEEWf/YpVf1kKc/hS6WMJgJU76rVwPip3fb83ulW0+AL2Xv4X2YleQmg
         /bz30l9XDe/j0pPMwkuTO2/59uBmdpT97P8k2XtPFgybie5ZMEXn2mJIDb2F91hrjdlc
         3CgtYgy8R78+DiT4/dlVEBK8+S23cIQbP6pCRQd6F/B9ZxYZHR0y/YYNsw1NFkcgrWdw
         JAtP5D8IBvqzqD9Ns83L2q2l89651AouwbPNJNkyuV37qNEdpoORf/9Ug1PawTj1eYFM
         Q+IX4SGWB3rd9Ja/96HPp6vzj1qhV7ZGjItL14OTHs4KdPpNI/+BLBt1MwsoU2UDe5eA
         XOag==
X-Gm-Message-State: APjAAAVTf/K+fPMAhiMQ1ekKXhqtqM4L/EC+Wemqrwg4GKe8Gxt8SiBr
        eRaeBUqnImtgqLNNG7Aw4DtqJQ==
X-Google-Smtp-Source: APXvYqxX4LUFqRdF6+SYd0mMzhiMDnhqSixAQPO3XlYCqfi9W5hrtMv0HaYZaQ3AFS4jZ1Rh/5q9lA==
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr4609175pjq.134.1565914198446;
        Thu, 15 Aug 2019 17:09:58 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g2sm4056916pfi.26.2019.08.15.17.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 17:09:58 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org
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
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 2/3] selftest: firmware: Add request_firmware_into_buf tests
Date:   Thu, 15 Aug 2019 17:09:44 -0700
Message-Id: <20190816000945.29810-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816000945.29810-1-scott.branden@broadcom.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tests cases for checking request_firmware_into_buf api.
API was introduced into kernel with no testing present previously.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 .../selftests/firmware/fw_filesystem.sh       | 57 ++++++++++++++++++-
 tools/testing/selftests/firmware/fw_lib.sh    | 11 ++++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index f901076aa2ea..56894477c8bd 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -116,6 +116,16 @@ config_set_name()
 	echo -n $1 >  $DIR/config_name
 }
 
+config_set_into_buf()
+{
+	echo 1 >  $DIR/config_into_buf
+}
+
+config_unset_into_buf()
+{
+	echo 0 >  $DIR/config_into_buf
+}
+
 config_set_sync_direct()
 {
 	echo 1 >  $DIR/config_sync_direct
@@ -153,11 +163,14 @@ config_set_read_fw_idx()
 
 read_firmwares()
 {
-	if [ "$1" = "xzonly" ]; then
-		fwfile="${FW}-orig"
+	if [ "$(cat $DIR/config_into_buf)" == "1" ]; then
+		fwfile="$FW_INTO_BUF"
 	else
 		fwfile="$FW"
 	fi
+	if [ "$1" = "xzonly" ]; then
+		fwfile="${fwfile}-orig"
+	fi
 	for i in $(seq 0 3); do
 		config_set_read_fw_idx $i
 		# Verify the contents are what we expect.
@@ -194,6 +207,18 @@ test_batched_request_firmware_nofile()
 	echo "OK"
 }
 
+test_batched_request_firmware_into_buf_nofile()
+{
+	echo -n "Batched request_firmware_into_buf() nofile try #$1: "
+	config_reset
+	config_set_name nope-test-firmware.bin
+	config_set_into_buf
+	config_trigger_sync
+	read_firmwares_expect_nofile
+	release_all_firmware
+	echo "OK"
+}
+
 test_batched_request_firmware_direct_nofile()
 {
 	echo -n "Batched request_firmware_direct() nofile try #$1: "
@@ -259,6 +284,18 @@ test_batched_request_firmware()
 	echo "OK"
 }
 
+test_batched_request_firmware_into_buf()
+{
+	echo -n "Batched request_firmware_into_buf() $2 try #$1: "
+	config_reset
+	config_set_name $TEST_FIRMWARE_INTO_BUF_FILENAME
+	config_set_into_buf
+	config_trigger_sync
+	read_firmwares $2
+	release_all_firmware
+	echo "OK"
+}
+
 test_batched_request_firmware_direct()
 {
 	echo -n "Batched request_firmware_direct() $2 try #$1: "
@@ -307,6 +344,10 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware $i normal
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf $i normal
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i normal
 done
@@ -327,6 +368,10 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware_nofile $i
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf_nofile $i
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct_nofile $i
 done
@@ -350,6 +395,10 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware $i both
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf $i both
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i both
 done
@@ -370,6 +419,10 @@ for i in $(seq 1 5); do
 	test_batched_request_firmware $i xzonly
 done
 
+for i in $(seq 1 5); do
+	test_batched_request_firmware_into_buf $i xzonly
+done
+
 for i in $(seq 1 5); do
 	test_batched_request_firmware_direct $i xzonly
 done
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index f236cc295450..b879305a766d 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -9,6 +9,12 @@ DIR=/sys/devices/virtual/misc/test_firmware
 PROC_CONFIG="/proc/config.gz"
 TEST_DIR=$(dirname $0)
 
+# We need to load a different file to test request_firmware_into_buf
+# I believe the issue is firmware loaded cached vs. non-cached
+# with same filename is bungled.
+# To reproduce rename this to test-firmware.bin
+TEST_FIRMWARE_INTO_BUF_FILENAME=test-firmware-into-buf.bin
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -108,6 +114,8 @@ setup_tmp_file()
 	FWPATH=$(mktemp -d)
 	FW="$FWPATH/test-firmware.bin"
 	echo "ABCD0123" >"$FW"
+	FW_INTO_BUF="$FWPATH/$TEST_FIRMWARE_INTO_BUF_FILENAME"
+	echo "EFGH4567" >"$FW_INTO_BUF"
 	NAME=$(basename "$FW")
 	if [ "$TEST_REQS_FW_SET_CUSTOM_PATH" = "yes" ]; then
 		echo -n "$FWPATH" >/sys/module/firmware_class/parameters/path
@@ -175,6 +183,9 @@ test_finish()
 	if [ -f $FW ]; then
 		rm -f "$FW"
 	fi
+	if [ -f $FW_INTO_BUF ]; then
+		rm -f "$FW_INTO_BUF"
+	fi
 	if [ -d $FWPATH ]; then
 		rm -rf "$FWPATH"
 	fi
-- 
2.17.1

