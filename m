Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD068362C1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhDPX70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 19:59:26 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:50763 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbhDPX7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:59:24 -0400
Received: by mail-pj1-f41.google.com with SMTP id u11so11183499pjr.0;
        Fri, 16 Apr 2021 16:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhnRxlz4JLtLESfnZ47Vgal4vyfaQvpBuxO51xcHTDs=;
        b=Kfh87OKSdl0ouwLEO+M6mdBshgrxVTqttc2lTD+bhVOCqr8I6VUkhWuBxx92aUZEPr
         EjSV1dbLI+MX9g/hUdl+Vp2K4HnvKCuJaKxLtax20+1ZUsPxhN7LFhBA3PykALRq5eI1
         d2CqhY+iaM4GIZD5K3Mb3Hq8gNSB4DxhV1kn6p9GOETF3b0PFJV5YM46oALKkGb0kxvy
         3k/Q9wbz2BZhmfY+6sBz1zIAszyg3JNtwrqwOjk2kbJ5DC6VgVsk66NFoDZ4vXKq3JbS
         PKkSO27xEAyhq2Z6u27koiV+I7IcQppigfbQk/1K5T8P1gh/WMinI/zLMHAJfg0LWmS4
         UWaA==
X-Gm-Message-State: AOAM5303aPmrv4G5UH2YkuBQmCrYLj3cfGKclaNnT/OFIlLTQ9faJK82
        ePmpA6uj0Y0gsLVWR+Hj8zE=
X-Google-Smtp-Source: ABdhPJyfmUYf7UD9MFIbpnqkH0bVfyk6fh+FhROoBBh29coDd2E4aCfcNHUm4F97ia0Wu/kXqBOB4w==
X-Received: by 2002:a17:90a:d812:: with SMTP id a18mr12497557pjv.192.1618617537515;
        Fri, 16 Apr 2021 16:58:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k127sm5788023pfd.63.2021.04.16.16.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:58:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DCAF54063E; Fri, 16 Apr 2021 23:58:54 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/2] test_firmware: add suspend support to test buggy drivers
Date:   Fri, 16 Apr 2021 23:58:49 +0000
Message-Id: <20210416235850.23690-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210416235850.23690-1-mcgrof@kernel.org>
References: <20210416235850.23690-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lukas Middendorf reported a situation where a driver's
request_firmware() call on resume caused a stall. Upon
inspection the issue was that the driver in question was
calling request_firmware() only on resume, and since we
currently do not have a generic kernel VFS freeze / thaw
solution in place we are allowing races for filesystems
to race against the disappearance of a block device, and
this is presently an issue which can lead to a stall.

It is difficult to reproduce this unless you have hardware
which mimics this setup. So to test this setup, let's just
implement support for doing these wacky things. This lets
us test that corner case easily as follows.

echo N > /sys/module/printk/parameters/console_suspend
modprobe test_firmware
echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test
systemctl suspend

Then call virsh dompmwakeup guest-id, on the guest and you
can reproduce the issue easily. The issue is reprodicible
with xfs and btrfs, and using a new partition for /lib/firmware
with a files created first as follows:

for n in {1..1000}; do
  dd if=/dev/urandom of=/lib/firmware/file$( printf %03d "$n" ).bin bs=1 count=$((RANDOM + 1024 ))
done

Cc: rafael@kernel.org
Cc: jack@suse.cz
Cc: bvanassche@acm.org
Cc: kernel@tuxforce.de
Cc: mchehab@kernel.org
Cc: keescook@chromium.org
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_firmware.c                           | 136 ++++++++++++++++--
 tools/testing/selftests/firmware/fw_lib.sh    |   8 +-
 .../selftests/firmware/fw_test_resume.sh      |  80 +++++++++++
 3 files changed, 211 insertions(+), 13 deletions(-)
 create mode 100755 tools/testing/selftests/firmware/fw_test_resume.sh

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index b6fe89add9fe..47ba6f4380ab 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -18,6 +18,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -35,6 +36,8 @@ MODULE_IMPORT_NS(TEST_FIRMWARE);
 static DEFINE_MUTEX(test_fw_mutex);
 static const struct firmware *test_firmware;
 
+static struct platform_device *pdev;
+
 struct test_batched_req {
 	u8 idx;
 	int rc;
@@ -58,6 +61,9 @@ struct test_batched_req {
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
+ * @enable_resume_test: if @senable_resume is true this will enable a test to
+ *	issue a request_firmware() upon resume. This is useful to test resume
+ *	after suspend filesystem races.
  * @num_requests: number of requests to try per test case. This is trigger
  *	specific.
  * @reqs: stores all requests information
@@ -99,6 +105,7 @@ struct test_config {
 	bool partial;
 	bool sync_direct;
 	bool send_uevent;
+	bool enable_resume_test;
 	u8 num_requests;
 	u8 read_fw_idx;
 
@@ -195,6 +202,7 @@ static int __test_firmware_config_init(void)
 	test_fw_config->file_offset = 0;
 	test_fw_config->partial = false;
 	test_fw_config->sync_direct = false;
+	test_fw_config->enable_resume_test = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
 	test_fw_config->reqs = NULL;
@@ -275,6 +283,9 @@ static ssize_t config_show(struct device *dev,
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"sync_direct:\t\t%s\n",
 			test_fw_config->sync_direct ? "true" : "false");
+	len += scnprintf(buf+len, PAGE_SIZE - len,
+			"enable_resume_test:\t\t%s\n",
+			test_fw_config->enable_resume_test ? "true" : "false");
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			"read_fw_idx:\t%u\n", test_fw_config->read_fw_idx);
 
@@ -538,6 +549,22 @@ static ssize_t config_sync_direct_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(config_sync_direct);
 
+static ssize_t config_enable_resume_test_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	return test_dev_config_update_bool(buf, count,
+					   &test_fw_config->enable_resume_test);
+}
+
+static ssize_t config_enable_resume_test_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	return test_dev_config_show_bool(buf, test_fw_config->enable_resume_test);
+}
+static DEVICE_ATTR_RW(config_enable_resume_test);
+
 static ssize_t config_send_uevent_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
@@ -1065,6 +1092,7 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(config_partial),
 	TEST_FW_DEV_ATTR(config_sync_direct),
 	TEST_FW_DEV_ATTR(config_send_uevent),
+	TEST_FW_DEV_ATTR(config_enable_resume_test),
 	TEST_FW_DEV_ATTR(config_read_fw_idx),
 
 	/* These don't use the config at all - they could be ported! */
@@ -1094,6 +1122,81 @@ static struct miscdevice test_fw_misc_device = {
 	.groups 	= test_dev_groups,
 };
 
+static int __maybe_unused test_firmware_suspend(struct device *dev)
+{
+	return 0;
+}
+
+
+static int __maybe_unused test_firmware_resume(struct device *dev)
+{
+	int rc;
+
+	if (!test_fw_config->enable_resume_test)
+		return 0;
+
+	pr_info("resume test, loading '%s'\n", test_fw_config->name);
+
+	mutex_lock(&test_fw_mutex);
+	release_firmware(test_firmware);
+	test_firmware = NULL;
+	rc = request_firmware(&test_firmware, test_fw_config->name, dev);
+	if (rc) {
+		mutex_unlock(&test_fw_mutex);
+		pr_info("load of '%s' failed: %d\n", test_fw_config->name, rc);
+		goto out;
+	}
+
+	pr_info("loaded: %zu\n", test_firmware->size);
+	mutex_unlock(&test_fw_mutex);
+	pr_info("resume test, completed successfully\n");
+out:
+	return rc;
+}
+
+static SIMPLE_DEV_PM_OPS(test_dev_pm_ops, test_firmware_suspend, test_firmware_resume);
+
+static int test_firmware_probe(struct platform_device *dev)
+{
+	int rc;
+
+	rc = misc_register(&test_fw_misc_device);
+	if (rc) {
+		kfree(test_fw_config);
+		pr_err("could not register misc device: %d\n", rc);
+		return rc;
+	}
+
+	pr_info("interface ready\n");
+
+	return 0;
+}
+
+static int test_firmware_remove(struct platform_device *dev)
+{
+	mutex_lock(&test_fw_mutex);
+	release_firmware(test_firmware);
+	misc_deregister(&test_fw_misc_device);
+	mutex_unlock(&test_fw_mutex);
+
+	return 0;
+}
+
+static void test_firmware_shutdown(struct platform_device *dev)
+{
+}
+
+static struct platform_driver test_firmware_driver = {
+	.driver		= {
+		.name	= "test_firmware",
+		.pm	= &test_dev_pm_ops,
+	},
+	.probe		= test_firmware_probe,
+	.remove		= test_firmware_remove,
+	.shutdown	= test_firmware_shutdown,
+};
+
+
 static int __init test_firmware_init(void)
 {
 	int rc;
@@ -1109,28 +1212,39 @@ static int __init test_firmware_init(void)
 		return rc;
 	}
 
-	rc = misc_register(&test_fw_misc_device);
-	if (rc) {
-		kfree(test_fw_config);
-		pr_err("could not register misc device: %d\n", rc);
-		return rc;
-	}
+	rc = platform_driver_register(&test_firmware_driver);
+	if (rc)
+		goto err_alloc;
+
+	pdev = platform_device_alloc("test_firmware", -1);
+	if (!pdev)
+		goto err_driver_unregister;
 
-	pr_warn("interface ready\n");
+	rc = platform_device_add(pdev);
+	if (rc)
+		goto err_free_device;
 
 	return 0;
+
+ err_free_device:
+	platform_device_put(pdev);
+ err_driver_unregister:
+	platform_driver_unregister(&test_firmware_driver);
+ err_alloc:
+	__test_firmware_config_free();
+	kfree(test_fw_config);
+	return rc;
 }
 
 module_init(test_firmware_init);
 
 static void __exit test_firmware_exit(void)
 {
-	mutex_lock(&test_fw_mutex);
-	release_firmware(test_firmware);
-	misc_deregister(&test_fw_misc_device);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&test_firmware_driver);
+
 	__test_firmware_config_free();
 	kfree(test_fw_config);
-	mutex_unlock(&test_fw_mutex);
 
 	pr_warn("removed interface\n");
 }
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 5b8c0fedee76..adba33f78cb3 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -119,9 +119,13 @@ setup_tmp_file()
 {
 	FWPATH=$(mktemp -d)
 	FW="$FWPATH/test-firmware.bin"
-	echo "ABCD0123" >"$FW"
+	if [[ "$1" != "--skip-file-creation" ]]; then
+		echo "ABCD0123" >"$FW"
+	fi
 	FW_INTO_BUF="$FWPATH/$TEST_FIRMWARE_INTO_BUF_FILENAME"
-	echo "EFGH4567" >"$FW_INTO_BUF"
+	if [[ "$1" != "--skip-file-creation" ]]; then
+		echo "EFGH4567" >"$FW_INTO_BUF"
+	fi
 	NAME=$(basename "$FW")
 	if [ "$TEST_REQS_FW_SET_CUSTOM_PATH" = "yes" ]; then
 		echo -n "$FWPATH" >/sys/module/firmware_class/parameters/path
diff --git a/tools/testing/selftests/firmware/fw_test_resume.sh b/tools/testing/selftests/firmware/fw_test_resume.sh
new file mode 100755
index 000000000000..159483297166
--- /dev/null
+++ b/tools/testing/selftests/firmware/fw_test_resume.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This will enable the resume firmware request call. Since we have no
+# control over a guest / hypervisor, the caller is in charge of the
+# actual suspend / resume cycle. This only enables the test to be triggered
+# upon resume.
+set -e
+
+TEST_REQS_FW_SYSFS_FALLBACK="no"
+TEST_REQS_FW_SET_CUSTOM_PATH="yes"
+TEST_DIR=$(dirname $0)
+FWPATH=""
+source $TEST_DIR/fw_lib.sh
+
+check_mods
+check_setup
+verify_reqs
+#setup_tmp_file --skip-file-creation
+
+test_resume()
+{
+	if [ ! -f $DIR/reset ]; then
+		echo "Configuration triggers not present, ignoring test"
+		exit $ksft_skip
+	fi
+}
+
+release_all_firmware()
+{
+	echo 1 >  $DIR/release_all_firmware
+}
+
+config_enable_resume_test()
+{
+	echo 1 >  $DIR/config_enable_resume_test
+	if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
+		# Turn down the timeout so failures don't take so long.
+		echo 1 >/sys/class/firmware/timeout
+	fi
+}
+
+config_disable_resume_test()
+{
+	echo 0 >  $DIR/config_enable_resume_test
+}
+
+usage()
+{
+	echo "Usage: $0 [ -v ] | [ -h | --help]"
+	echo ""
+	echo "    --check-resume-test   Verify resume test"
+	echo "    -h|--help             Help"
+	echo
+	echo "Without any arguments this will enable the resume firmware test"
+	echo "after suspend. To verify that the test went well, run with -v".
+	echo
+	exit 1
+}
+
+verify_resume_test()
+{
+	trap "test_finish" EXIT
+}
+
+parse_args()
+{
+	if [ $# -eq 0 ]; then
+		config_enable_resume_test
+	else
+		if [[ "$1" = "--check-resume-test" ]]; then
+			config_disable_resume_test
+			verify_resume_test
+		else
+			usage
+		fi
+	fi
+}
+
+exit 0
-- 
2.29.2

