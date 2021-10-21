Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16268436710
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 17:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhJUQBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhJUQBT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:01:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A322C061764;
        Thu, 21 Oct 2021 08:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y5FBc8qS1stSEUraOLslgljnraTtrP2CYc9ccR7SUvM=; b=nVBV4dniNzDQeQ3BID45o7KFYg
        7nZxBzCQVfIodyTYL22EVrm+ZO/COckKRz82exODPpLbeSRKkUfi1+wLiNsooUie+E++PJ4H92Qyk
        c4PPjg2WeolI2ylfb+sMqBt6QeHT2QyLuvSW3XX/6FMlwzBysusUbXgRu0ts2k2PifljjxQ9sBz+g
        tPGAPVOc8L2R5mdSBsvLlI7+N0CrmLtBfsbgf3xBH0PPuTkaE+yls6XHIB6mWkkucT0Id7P46eWM+
        +tIeVqCYZxT4T8MOETHtAaqXjooIlOavxChHiBZic+7YlEFnfyZNvd6mm4xwnViAZ5CTumORKD2Vi
        ZxeMe5Cw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaSq-008GMN-RV; Thu, 21 Oct 2021 15:58:44 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 10/10] test_firmware: add support for testing built-in firmware
Date:   Thu, 21 Oct 2021 08:58:43 -0700
Message-Id: <20211021155843.1969401-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021155843.1969401-1-mcgrof@kernel.org>
References: <20211021155843.1969401-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

This adds some basic knobs to let us test built-in firmware
support. We test to ensure built-in firmware is indeed used,
and that it matches the contents we expect. Likewise we test
that a file that should not be built-in was not present.

For older kernels with older test_firmware drivers (yes some
folks do test selftests this way and we support it), the new
built-in test will simply bail out early.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/Makefile         |  1 +
 drivers/base/firmware_loader/builtin/Makefile |  1 +
 .../firmware_loader/test-builtin/.gitignore   |  3 +
 .../firmware_loader/test-builtin/Makefile     | 18 +++++
 lib/Kconfig.debug                             | 33 +++++++++
 lib/test_firmware.c                           | 52 +++++++++++++-
 .../testing/selftests/firmware/fw_builtin.sh  | 69 +++++++++++++++++++
 tools/testing/selftests/firmware/fw_lib.sh    |  7 ++
 .../selftests/firmware/fw_run_tests.sh        |  2 +
 9 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/firmware_loader/test-builtin/.gitignore
 create mode 100644 drivers/base/firmware_loader/test-builtin/Makefile
 create mode 100755 tools/testing/selftests/firmware/fw_builtin.sh

diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
index e87843408fe6..dbeba0fa315d 100644
--- a/drivers/base/firmware_loader/Makefile
+++ b/drivers/base/firmware_loader/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for the Linux firmware loader
 
+obj-$(CONFIG_TEST_FIRMWARE_BUILTIN) += test-builtin/
 obj-$(CONFIG_FW_LOADER_USER_HELPER) += fallback_table.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 firmware_class-objs := main.o
diff --git a/drivers/base/firmware_loader/builtin/Makefile b/drivers/base/firmware_loader/builtin/Makefile
index 9b0dc193f6c7..baad7777974b 100644
--- a/drivers/base/firmware_loader/builtin/Makefile
+++ b/drivers/base/firmware_loader/builtin/Makefile
@@ -2,6 +2,7 @@
 include $(srctree)/drivers/base/firmware_loader/builtin/lib.Makefile
 
 obj-y  += main.o
+obj-$(CONFIG_TEST_BUILTIN_FIRMWARE)  += test-builtin-firmware.bin.gen.o
 
 # Create $(fwdir) from $(CONFIG_FW_LOADER_BUILTIN_DIR) -- if it doesn't have a
 # leading /, it's relative to $(srctree).
diff --git a/drivers/base/firmware_loader/test-builtin/.gitignore b/drivers/base/firmware_loader/test-builtin/.gitignore
new file mode 100644
index 000000000000..1d46553f50a0
--- /dev/null
+++ b/drivers/base/firmware_loader/test-builtin/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+*.gen.S
+*.bin
diff --git a/drivers/base/firmware_loader/test-builtin/Makefile b/drivers/base/firmware_loader/test-builtin/Makefile
new file mode 100644
index 000000000000..04204ad7ede1
--- /dev/null
+++ b/drivers/base/firmware_loader/test-builtin/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+include $(srctree)/drivers/base/firmware_loader/builtin/lib.Makefile
+
+extra-y := test-builtin-firmware.bin
+$(obj)/test-builtin-firmware.bin: FORCE
+	@$(kecho) "  GEN     $@"
+	@(set -e;			\
+	(				\
+		echo 'ABCD0123';	\
+	) > $@)
+
+# Create $(fwdir) from $(CONFIG_TEST_FIRMWARE_BUILTIN_DIR) -- if it doesn't
+# have a leading /, it's relative to $(srctree).
+fwdir := $(subst $(quote),,$(CONFIG_TEST_FIRMWARE_BUILTIN_DIR))
+fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter /%,$(fwdir))
+
+firmware  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_TEST_FIRMWARE_BUILTIN_FILES)))
+obj-y += $(firmware)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3266fef7cb53..b8af41619fc3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2333,6 +2333,39 @@ config TEST_FIRMWARE
 
 	  If unsure, say N.
 
+config TEST_FIRMWARE_BUILTIN
+	bool "Allow building built-in test firmware"
+	depends on TEST_FIRMWARE
+	help
+	  If enabled, firmware will be built into to the kernel so that
+	  loading it with the test_firmware driver can be tested. Disabling
+	  this will just mean the test firmware scripts won't find any
+	  built-in firmware. Enabling this will make the kernel generate the
+	  file test-builtin-firmware.bin inside local directory
+	  drivers/base/firmware_loader/test-builtin. This file will then
+	  be available whenever the request firmware API is used.
+
+	  Enabling this functionlity essentially overrides the location where
+	  you specify to find built-in firmware, and so should only be enabled
+	  if you don't need to build firmware into your kernel for full
+	  funcionality.
+
+	  This should be disabled on production kernels as otherwise you'll
+	  end up with a test firmware stuck into your final kernel image and
+	  with default built-in firmware support.
+
+	  If unsure, say N.
+
+config TEST_FIRMWARE_BUILTIN_FILES
+	string
+	depends on TEST_FIRMWARE_BUILTIN
+	default "test-builtin-firmware.bin"
+
+config TEST_FIRMWARE_BUILTIN_DIR
+	string
+	depends on TEST_FIRMWARE_BUILTIN
+	default "drivers/base/firmware_loader/test-builtin"
+
 config TEST_SYSCTL
 	tristate "sysctl test driver"
 	depends on PROC_SYSCTL
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 1bccd6cd5f48..134f8c78d2d4 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -34,6 +34,7 @@ MODULE_IMPORT_NS(TEST_FIRMWARE);
 
 static DEFINE_MUTEX(test_fw_mutex);
 static const struct firmware *test_firmware;
+static struct firmware builtin_test_firmware;
 
 struct test_batched_req {
 	u8 idx;
@@ -58,6 +59,10 @@ struct test_batched_req {
  * @sync_direct: when the sync trigger is used if this is true
  *	request_firmware_direct() will be used instead.
  * @send_uevent: whether or not to send a uevent for async requests
+ * @is_builtin: used only internally to determine if the firmware was found
+ *	to be built-in to the kernel using only the API call
+ *	firmware_request_builtin(). We treat this specially as we are
+ *	responsible for the firmware struct.
  * @num_requests: number of requests to try per test case. This is trigger
  *	specific.
  * @reqs: stores all requests information
@@ -99,6 +104,7 @@ struct test_config {
 	bool partial;
 	bool sync_direct;
 	bool send_uevent;
+	bool is_builtin;
 	u8 num_requests;
 	u8 read_fw_idx;
 
@@ -120,7 +126,11 @@ static ssize_t test_fw_misc_read(struct file *f, char __user *buf,
 	ssize_t rc = 0;
 
 	mutex_lock(&test_fw_mutex);
-	if (test_firmware)
+	if (test_fw_config->is_builtin)
+		rc = simple_read_from_buffer(buf, size, offset,
+					     builtin_test_firmware.data,
+					     builtin_test_firmware.size);
+	else if (test_firmware)
 		rc = simple_read_from_buffer(buf, size, offset,
 					     test_firmware->data,
 					     test_firmware->size);
@@ -194,6 +204,7 @@ static int __test_firmware_config_init(void)
 	test_fw_config->buf_size = TEST_FIRMWARE_BUF_SIZE;
 	test_fw_config->file_offset = 0;
 	test_fw_config->partial = false;
+	test_fw_config->is_builtin = false;
 	test_fw_config->sync_direct = false;
 	test_fw_config->req_firmware = request_firmware;
 	test_fw_config->test_result = 0;
@@ -1051,6 +1062,44 @@ static ssize_t read_firmware_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(read_firmware);
 
+/*
+ * In order to test this, set CONFIG_FW_LOADER_BUILTIN_FILES to a firmware file
+ * which will be built into the kernel image. Then echo the name into the
+ * "trigger_request_builtin" sysfs file of this module.
+ */
+static ssize_t trigger_request_builtin_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	int rc = -ENOENT;
+
+	if (!test_fw_config->name) {
+		pr_warn("unconfigured firmware settings\n");
+		return rc;
+	}
+
+	pr_info("loading builtin '%s'\n", test_fw_config->name);
+
+	mutex_lock(&test_fw_mutex);
+
+	if (firmware_request_builtin(&builtin_test_firmware,
+				     test_fw_config->name)) {
+		/* This let's us diff against the firmware */
+		test_fw_config->is_builtin = true;
+		pr_info("loaded: %zu\n", builtin_test_firmware.size);
+		rc = count;
+		goto out;
+	}
+
+	pr_info("load of '%s' failed\n", test_fw_config->name);
+
+out:
+	mutex_unlock(&test_fw_mutex);
+
+	return rc;
+}
+static DEVICE_ATTR_WO(trigger_request_builtin);
+
 #define TEST_FW_DEV_ATTR(name)          &dev_attr_##name.attr
 
 static struct attribute *test_dev_attrs[] = {
@@ -1082,6 +1131,7 @@ static struct attribute *test_dev_attrs[] = {
 	TEST_FW_DEV_ATTR(release_all_firmware),
 	TEST_FW_DEV_ATTR(test_result),
 	TEST_FW_DEV_ATTR(read_firmware),
+	TEST_FW_DEV_ATTR(trigger_request_builtin),
 	NULL,
 };
 
diff --git a/tools/testing/selftests/firmware/fw_builtin.sh b/tools/testing/selftests/firmware/fw_builtin.sh
new file mode 100755
index 000000000000..44e4198ed88f
--- /dev/null
+++ b/tools/testing/selftests/firmware/fw_builtin.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test loading built-in firmware
+set -e
+
+TEST_REQS_FW_SYSFS_FALLBACK="no"
+TEST_REQS_FW_SET_CUSTOM_PATH="yes"
+TEST_DIR=$(dirname $0)
+source $TEST_DIR/fw_lib.sh
+
+check_mods
+check_setup
+verify_reqs
+setup_tmp_file
+
+trap "test_finish" EXIT
+
+if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
+	# Turn down the timeout so failures don't take so long.
+	echo 1 >/sys/class/firmware/timeout
+fi
+
+# built-in firmware support can be optional to test
+if [[ "$HAS_FW_LOADER_BUILTIN" != "yes" || "$HAS_TEST_FIRMWARE_BUILTIN" != "yes" ]]; then
+	exit $ksft_skip
+fi
+
+echo "Testing builtin firmware API ... "
+
+config_trigger_builtin()
+{
+	echo -n 1 > $DIR/trigger_request_builtin
+}
+
+test_builtin_firmware()
+{
+	echo -n "Testing firmware_request_builtin() ... "
+	config_reset
+	config_set_name $TEST_FIRMWARE_BUILTIN_FILENAME
+	config_trigger_builtin
+	echo OK
+	# Verify the contents are what we expect.
+	echo -n "Verifying file integrity ..."
+	if ! diff -q "$FW" /dev/test_firmware >/dev/null ; then
+		echo "$0: firmware loaded content differs" >&2
+		exit 1
+	else
+		echo "firmware content matches what we expect - OK"
+	fi
+}
+
+test_builtin_firmware_nofile()
+{
+	echo -n "Testing firmware_request_builtin() with fake file... "
+	config_reset
+	config_set_name fake-${TEST_FIRMWARE_BUILTIN_FILENAME}
+	if config_trigger_builtin 2> /dev/null; then
+		echo "$0: firmware shouldn't have loaded" >&2
+	fi
+	echo "OK"
+}
+
+test_builtin_firmware
+test_builtin_firmware_nofile
+
+# Ensure test_fw_config->is_builtin is set back to false
+# otherwise we won't be able to diff against the right target
+# firmware for other tests.
+config_reset
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 31b71fe11dc5..bbae33d9f5ed 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -15,6 +15,10 @@ TEST_DIR=$(dirname $0)
 # To reproduce rename this to test-firmware.bin
 TEST_FIRMWARE_INTO_BUF_FILENAME=test-firmware-into-buf.bin
 
+# We should use a different filename for built-in firmware otherwise
+# we'd always have the file present.
+TEST_FIRMWARE_BUILTIN_FILENAME=test-builtin-firmware.bin
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -63,6 +67,9 @@ check_setup()
 	HAS_FW_LOADER_USER_HELPER="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)"
 	HAS_FW_LOADER_USER_HELPER_FALLBACK="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)"
 	HAS_FW_LOADER_COMPRESS="$(kconfig_has CONFIG_FW_LOADER_COMPRESS=y)"
+	HAS_FW_LOADER_USER_HELPER="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)"
+	HAS_FW_LOADER_BUILTIN="$(kconfig_has CONFIG_FW_LOADER=y)"
+	HAS_TEST_FIRMWARE_BUILTIN="$(kconfig_has CONFIG_TEST_FIRMWARE_BUILTIN=y)"
 	PROC_FW_IGNORE_SYSFS_FALLBACK="0"
 	PROC_FW_FORCE_SYSFS_FALLBACK="0"
 
diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
index 777377078d5e..08a9bf043333 100755
--- a/tools/testing/selftests/firmware/fw_run_tests.sh
+++ b/tools/testing/selftests/firmware/fw_run_tests.sh
@@ -65,6 +65,8 @@ echo "Running namespace test: "
 $TEST_DIR/fw_namespace $DIR/trigger_request
 echo "OK"
 
+$TEST_DIR/fw_builtin.sh
+
 if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
 	run_test_config_0001
 	run_test_config_0002
-- 
2.30.2

