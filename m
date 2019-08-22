Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F0A99F06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbfHVSk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 14:40:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45908 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390955AbfHVSk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:40:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so4511736pfq.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IA8z/5AqtCHFT32SY+cIXSmPc0kaoD29PlyZ57NhalY=;
        b=BgB5KJgRI2OAMFO3lQmNArPftpDtD+nVUiJaoL/PL/14HemQ//f8oXX5mmTLwZrVeM
         UpdaOWdFUaGyxjitCmu4G6tGH22q5Ilv8GjvfFNAiukCsGLnKENYAmgPzQfNG76hKWON
         znl1GkmY7IAARq4+4slXfINLE8Of4Aji/+3EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IA8z/5AqtCHFT32SY+cIXSmPc0kaoD29PlyZ57NhalY=;
        b=moY/jkVNvt0oFwVKmuO0cMudx2P1EJwQ91LenLka1TChrf53S51mnr0ScXdGIE1f22
         eCr2g59X4vOifq0C7fryozFzzDt/8CxEr15DZpQCKF+oV5m0s7iFxi/rd/dpC4o1Efxh
         /fD6fmuK01c3R8UaWNeo/VpswBnv6F4A1qtDxnlgMfoaJel/40r23b5OPrLR/897EnN7
         W4w/oA4J5bvkfvnba+sEeks1tCvyzkSl/ZL29ep8QHMKUelZxvBdVDjXfjCZu5NmBkAE
         WbJIV6mFzwo0KDs5nivyItPmYPijn309p/osSvctKOK9qR7d8cLcoSknoZP2qXCcIMHZ
         3mDA==
X-Gm-Message-State: APjAAAWmpwqula6oT9V2BpC278ZuYV8NLrDyuSx6qPxAI5Tw4gjBwC+N
        M9RAOIQN10gzrgLxY2TVo28BbQ==
X-Google-Smtp-Source: APXvYqzSMdvmuGNbJy/sI3mS9i6KFKJnX0SBbijQnHdu2yhzqHbRk47dNRYki3R7ggqlt+YvXbkscQ==
X-Received: by 2002:a17:90a:86c2:: with SMTP id y2mr1144374pjv.46.1566499226035;
        Thu, 22 Aug 2019 11:40:26 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z19sm51056pgv.35.2019.08.22.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 11:40:25 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v2 2/2] selftests: firmware: Add request_firmware_into_buf tests
Date:   Thu, 22 Aug 2019 11:40:05 -0700
Message-Id: <20190822184005.901-3-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822184005.901-1-scott.branden@broadcom.com>
References: <20190822184005.901-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tests cases for checking request_firmware_into_buf api.
API was introduced into kernel with no testing present previously.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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

