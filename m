Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F58440240
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJ2Srj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhJ2Srh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B155C061714;
        Fri, 29 Oct 2021 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=toCC9cs8J7FosIh7uJC7Ufw8/yWElGjTPymhmc9QVAM=; b=KikeCKFSSZP70jkPPxMHOTQ5Zf
        RCM9FcPMprIBXJVs6rTmggSPRPQic7/E6h45P2sX8NNtYNsRvfhQxhLDSKPKHUsYyE7OgSIY5Iea2
        NWrf8MknljdCUMEe1fwknjiTIxqj9Azto0U/0wf4RtqFQSPujhgVX+9KeuORXtgRCi4B2JvYwe9zP
        b7Ro2W9mxCc+S3UWEd3NEA212JOv6721ws5M9FiIGgFb/JtSLvVJTeJdbFZouWY4ozNldQ4Ai9pwK
        hI/cKiyh368z/oAs5qO4QgwB+ctddUd+x7ylQkDNLjNTGK+xXNJgHAFsbk2SLROMiHe04KDfWt08v
        iXAMZIng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgWsA-00Bq0X-Hw; Fri, 29 Oct 2021 18:45:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/6] test_sysfs: add support to use kernfs failure injection
Date:   Fri, 29 Oct 2021 11:44:59 -0700
Message-Id: <20211029184500.2821444-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211029184500.2821444-1-mcgrof@kernel.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This extends test_sysfs with support for using the failure injection
wait completion and knobs to force a few race conditions which
demonstrates that kernfs active reference protection is sufficient
for kobject / device protection at higher layers.

This adds 4 new tests which tries to remove the device attribute
store operation in 4 different situations:

  1) at the start of kernfs_kernfs_fop_write_iter()
  2) before the of->mutex is held in kernfs_kernfs_fop_write_iter()
  3) after the of->mutex is held in kernfs_kernfs_fop_write_iter()
  4) after the kernfs node active reference is taken with
     kernfs_get_active()

A write can fail or succeed before the kernfs node active reference
is obtained with kernfs_get_active(), and the reason is that the
del_gendisk() may happen before the write or after the write is
triggered. However, regardless of the delayed used, all writes are
gauranteed to succeed after kernfs_get_active(), and so del_gendisk()
must wait for any pending writes to complete. The fact that you cannot
remove the kernfs entry while the kenfs entry is active also implies that
a module that created the respective sysfs / kernfs entry *cannot*
be removed during a sysfs operation. Test number 32 provides us with
proof of this. If it were not true test #32 should crash.

No null dereferences are reproduced, even though this has been observed
in some complex testing cases [0]. If this issue really exists we should
have enough tools on the sysfs_test toolbox now to try to reproduce
this easily without having to poke around other drivers. It very likley
was the case that the issue reported [0] was possibly a side issue after
the first bug which was zram specific. This is why it is important to
isolate the issue and try to reproduce it in a generic form using the
test_sysfs driver.

[0] https://lkml.kernel.org/r/20210623215007.862787-1-mcgrof@kernel.org

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/Kconfig.debug                      |   1 +
 lib/test_sysfs.c                       |  19 +++
 tools/testing/selftests/sysfs/config   |   3 +
 tools/testing/selftests/sysfs/sysfs.sh | 214 +++++++++++++++++++++++++
 4 files changed, 237 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 04d2c3f53d2a..ab3052277f23 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2359,6 +2359,7 @@ config TEST_SYSFS
 	depends on SYSFS
 	depends on NET
 	depends on BLOCK
+	depends on FAIL_KERNFS_KNOBS
 	help
 	  This builds the "test_sysfs" module. This driver enables to test the
 	  sysfs file system safely without affecting production knobs which
diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
index 2a6ec072da60..6918fddb1aed 100644
--- a/lib/test_sysfs.c
+++ b/lib/test_sysfs.c
@@ -25,6 +25,9 @@
 #include <linux/rtnetlink.h>
 #include <linux/genhd.h>
 #include <linux/blkdev.h>
+#include <linux/kernfs.h>
+
+MODULE_IMPORT_NS(KERNFS_DEBUG_PRIVATE);
 
 static bool enable_lock;
 module_param(enable_lock, bool_enable_only, 0644);
@@ -69,6 +72,11 @@ static bool enable_verbose_rmmod;
 module_param(enable_verbose_rmmod, bool_enable_only, 0644);
 MODULE_PARM_DESC(enable_verbose_rmmod, "enable verbose print messages on rmmod");
 
+static bool enable_completion_on_rmmod;
+module_param(enable_completion_on_rmmod, bool_enable_only, 0644);
+MODULE_PARM_DESC(enable_completion_on_rmmod,
+		 "enable sending a kernfs completion on rmmod");
+
 static int sysfs_test_major;
 
 /**
@@ -251,6 +259,8 @@ static ssize_t config_show(struct device *dev,
 			     enable_debugfs ? "true" : "false");
 	len += sysfs_emit_at(buf, len, "enable_verbose_writes:\t%s\n",
 			     enable_verbose_writes ? "true" : "false");
+	len += sysfs_emit_at(buf, len, "enable_completion_on_rmmod:\t%s\n",
+			enable_completion_on_rmmod ? "true" : "false");
 
 	test_dev_config_unlock(test_dev);
 
@@ -877,10 +887,19 @@ static int __init test_sysfs_init(void)
 }
 module_init(test_sysfs_init);
 
+/* The goal is to race our device removal with a pending kernfs -> store call */
+static void test_sysfs_kernfs_send_completion_rmmod(void)
+{
+	if (!enable_completion_on_rmmod)
+		return;
+	complete(&kernfs_debug_wait_completion);
+}
+
 static void __exit test_sysfs_exit(void)
 {
 	if (enable_debugfs)
 		debugfs_remove(debugfs_dir);
+	test_sysfs_kernfs_send_completion_rmmod();
 	if (delay_rmmod_ms)
 		msleep(delay_rmmod_ms);
 	unregister_test_dev_sysfs(first_test_dev);
diff --git a/tools/testing/selftests/sysfs/config b/tools/testing/selftests/sysfs/config
index 9196f452ecd5..2876a229f95b 100644
--- a/tools/testing/selftests/sysfs/config
+++ b/tools/testing/selftests/sysfs/config
@@ -1,2 +1,5 @@
 CONFIG_SYSFS=m
 CONFIG_TEST_SYSFS=m
+CONFIG_FAULT_INJECTION=y
+CONFIG_FAULT_INJECTION_DEBUG_FS=y
+CONFIG_FAIL_KERNFS_KNOBS=y
diff --git a/tools/testing/selftests/sysfs/sysfs.sh b/tools/testing/selftests/sysfs/sysfs.sh
index 802651d78427..84093ee653c6 100755
--- a/tools/testing/selftests/sysfs/sysfs.sh
+++ b/tools/testing/selftests/sysfs/sysfs.sh
@@ -51,6 +51,10 @@ ALL_TESTS="$ALL_TESTS 0025:1:1:test_dev_y:block"
 ALL_TESTS="$ALL_TESTS 0026:1:1:test_dev_y:block"
 ALL_TESTS="$ALL_TESTS 0027:1:0:test_dev_x:block" # deadlock test
 ALL_TESTS="$ALL_TESTS 0028:1:0:test_dev_x:block" # deadlock test with rntl_lock
+ALL_TESTS="$ALL_TESTS 0029:1:1:test_dev_x:block" # kernfs race removal of store
+ALL_TESTS="$ALL_TESTS 0030:1:1:test_dev_x:block" # kernfs race removal before mutex
+ALL_TESTS="$ALL_TESTS 0031:1:1:test_dev_x:block" # kernfs race removal after mutex
+ALL_TESTS="$ALL_TESTS 0032:1:1:test_dev_x:block" # kernfs race removal after active
 
 allow_user_defaults()
 {
@@ -81,6 +85,9 @@ allow_user_defaults()
 	if [ -z $SYSFS_DEBUGFS_DIR ]; then
 		SYSFS_DEBUGFS_DIR="/sys/kernel/debug/test_sysfs"
 	fi
+	if [ -z $KERNFS_DEBUGFS_DIR ]; then
+		KERNFS_DEBUGFS_DIR="/sys/kernel/debug/fail_kernfs"
+	fi
 	if [ -z $PAGE_SIZE ]; then
 		PAGE_SIZE=$(getconf PAGESIZE)
 	fi
@@ -156,6 +163,14 @@ modprobe_reset_enable_rtnl_lock_on_rmmod()
 	unset FIRST_MODPROBE_ARGS
 }
 
+modprobe_reset_enable_completion()
+{
+	FIRST_MODPROBE_ARGS="enable_completion_on_rmmod=1 enable_verbose_writes=1"
+	FIRST_MODPROBE_ARGS="$FIRST_MODPROBE_ARGS enable_verbose_rmmod=1 delay_rmmod_ms=0"
+	modprobe_reset
+	unset FIRST_MODPROBE_ARGS
+}
+
 load_req_mod()
 {
 	modprobe_reset
@@ -186,6 +201,63 @@ debugfs_reset_first_test_dev_ignore_errors()
 	echo -n "1" >"$SYSFS_DEBUGFS_DIR"/reset_first_test_dev
 }
 
+debugfs_kernfs_kernfs_fop_write_iter_exists()
+{
+	KNOB_DIR="${KERNFS_DEBUGFS_DIR}/config_fail_kernfs_fop_write_iter"
+	if [[ ! -d $KNOB_DIR ]]; then
+		echo "kernfs debugfs does not exist $KNOB_DIR"
+		return 0;
+	fi
+	KNOB_DEBUGFS="${KERNFS_DEBUGFS_DIR}/fail_kernfs_fop_write_iter"
+	if [[ ! -d $KNOB_DEBUGFS ]]; then
+		echo -n "kernfs debugfs for coniguring fail_kernfs_fop_write_iter "
+		echo "does not exist $KNOB_DIR"
+		return 0;
+	fi
+	return 1
+}
+
+debugfs_kernfs_kernfs_fop_write_iter_set_fail_once()
+{
+	KNOB_DEBUGFS="${KERNFS_DEBUGFS_DIR}/fail_kernfs_fop_write_iter"
+	echo 1 > $KNOB_DEBUGFS/interval
+	echo 100 > $KNOB_DEBUGFS/probability
+	echo 0 > $KNOB_DEBUGFS/space
+	# Disable verbose messages on the kernel ring buffer which may
+	# confuse developers with a kernel panic.
+	echo 0 > $KNOB_DEBUGFS/verbose
+
+	# Fail only once
+	echo 1 > $KNOB_DEBUGFS/times
+}
+
+debugfs_kernfs_kernfs_fop_write_iter_set_fail_never()
+{
+	KNOB_DEBUGFS="${KERNFS_DEBUGFS_DIR}/fail_kernfs_fop_write_iter"
+	echo 0 > $KNOB_DEBUGFS/times
+}
+
+debugfs_kernfs_set_wait_ms()
+{
+	SLEEP_AFTER_WAIT_MS="${KERNFS_DEBUGFS_DIR}/sleep_after_wait_ms"
+	echo $1 > $SLEEP_AFTER_WAIT_MS
+}
+
+debugfs_kernfs_disable_wait_kernfs_fop_write_iter()
+{
+	ENABLE_WAIT_KNOB="${KERNFS_DEBUGFS_DIR}/config_fail_kernfs_fop_write_iter/wait_"
+	for KNOB in ${ENABLE_WAIT_KNOB}*; do
+		echo 0 > $KNOB
+	done
+}
+
+debugfs_kernfs_enable_wait_kernfs_fop_write_iter()
+{
+	ENABLE_WAIT_KNOB="${KERNFS_DEBUGFS_DIR}/config_fail_kernfs_fop_write_iter/wait_$1"
+	echo -n "1" > $ENABLE_WAIT_KNOB
+	return $?
+}
+
 set_orig()
 {
 	if [[ ! -z $TARGET ]] && [[ ! -z $ORIG ]]; then
@@ -961,6 +1033,144 @@ sysfs_test_0028()
 	fi
 }
 
+sysfs_race_kernfs_kernfs_fop_write_iter()
+{
+	TARGET="${DIR}/$(get_test_target $1)"
+	WAIT_AT=$2
+	EXPECT_WRITE_RETURNS=$3
+	MSDELAY=$4
+
+	modprobe_reset_enable_completion
+	ORIG=$(cat "${TARGET}")
+	TEST_STR=$(( $ORIG + 1 ))
+
+	echo -n "Test racing removal of sysfs store op with kernfs $WAIT_AT ... "
+
+	if debugfs_kernfs_kernfs_fop_write_iter_exists; then
+		echo -n "skipping test as CONFIG_FAIL_KERNFS_KNOBS "
+		echo " or CONFIG_FAULT_INJECTION_DEBUG_FS is disabled"
+		return $ksft_skip
+	fi
+
+	# Allow for failing the kernfs_kernfs_fop_write_iter call once,
+	# we'll provide exact context shortly afterwards.
+	debugfs_kernfs_kernfs_fop_write_iter_set_fail_once
+
+	# First disable all waits
+	debugfs_kernfs_disable_wait_kernfs_fop_write_iter
+
+	# Enable a wait_for_completion(&kernfs_debug_wait_completion) at the
+	# specified location inside the kernfs_fop_write_iter() routine
+	debugfs_kernfs_enable_wait_kernfs_fop_write_iter $WAIT_AT
+
+	# Configure kernfs so that after its wait_for_completion() it
+	# will msleep() this amount of time and schedule(). We figure this
+	# will be sufficient time to allow for our module removal to complete.
+	debugfs_kernfs_set_wait_ms $MSDELAY
+
+	# Now we trigger a kernfs write op, which will run kernfs_fop_write_iter,
+	# but will wait until our driver sends a respective completion
+	set_test_ignore_errors &
+	write_pid=$!
+
+	# At this point kernfs_fop_write_iter() hasn't run our op, its
+	# waiting for our completion at the specified time $WAIT_AT.
+	# We now remove our module which will send a
+	# complete(&kernfs_debug_wait_completion) right before we deregister
+	# our device and the sysfs device attributes are removed.
+	#
+	# After the completion is sent, the test_sysfs driver races with
+	# kernfs to do the device deregistration with the kernfs msleep
+	# and schedule(). This should mean we've forced trying to remove the
+	# module prior to allowing kernfs to run our store operation. If the
+	# race did happen we'll panic with a null dereference on the store op.
+	#
+	# If no race happens we should see no write operation triggered.
+	modprobe -r $TEST_DRIVER > /dev/null 2>&1
+
+	debugfs_kernfs_kernfs_fop_write_iter_set_fail_never
+
+	wait $write_pid
+
+	check_dmesg
+	if [[ $? -ne 0 ]]; then
+		echo "FAIL" >&2
+		exit 1
+	fi
+
+	# In cases where a write *can* fail or succeed, we don't care
+	# about the return code of the write, we just care we don't crash
+	# the kernel.
+	if [[ "$EXPECT_WRITE_RETURNS" == "2" ]]; then
+		echo "ok"
+		return
+	fi
+
+	if [[ $? -eq $EXPECT_WRITE_RETURNS ]]; then
+		echo "ok"
+	else
+		echo "FAIL" >&2
+	fi
+}
+
+# The test cases 0029-0032 race writes issued to sysfs files exposed by a
+# disk against del_gendisk() which removes these sysfs files. Each test case
+# forces the race to happen at different points in time where the kernfs is
+# processing a write, before the sysfs op gets called.
+#
+# The writes races against different parts of the kernfs_fop_write_iter().
+# A completion is sent by the test_sysfs driver on driver removal before
+# del_gendisk() is called so to *start* the race. The races vary by time,
+# specified in milliseconds.
+#
+# So for example test case 0029 will force the function kernfs_fop_write_iter()
+# to wait for completion *at the start* of that function. The completion is
+# issued by the test_sysfs driver on driver removal right before del_gendisk()
+# is called. However test_sysfs will also wait a configurable amount of
+# milliseconds before having del_gendisk() run. A long delay should ensure the
+# write completes.
+#
+# Test case 0030 will do the same but before mutex_lock(&of->mutex) is called
+# on kernfs_fop_write_iter(). And so on. Writes are only expected to *always*
+# succeed once kernfs_get_active() is called successfully. Before that a write
+# could succeed or fail, it will depend on what gets preempted / scheduled, and
+# so the only thing we can be sure of is we should not be crashing the kernel.
+# Before kernfs_get_active(), if an excessively long delay is used, then
+# del_gendisk() is expected to be delayed and so writes should work.
+sysfs_test_0029()
+{
+	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
+		echo "Delay-after-completion before del_gendisk(): $delay ms"
+		sysfs_race_kernfs_kernfs_fop_write_iter 0029 at_start 2 $delay
+	done
+}
+
+sysfs_test_0030()
+{
+	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
+		echo "Delay-after-completion before del_gendisk(): $delay ms"
+		sysfs_race_kernfs_kernfs_fop_write_iter 0030 before_mutex 2 $delay
+	done
+}
+
+sysfs_test_0031()
+{
+	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
+		echo "Delay-after-completion before del_gendisk(): $delay ms"
+		sysfs_race_kernfs_kernfs_fop_write_iter 0031 after_mutex 2 $delay
+	done
+}
+
+# A write only guaranteed to succeed *iff* a module removal happens *after*
+# the kernfs active reference is obtained with kernfs_get_active().
+sysfs_test_0032()
+{
+	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
+		echo "Delay-after-completion before del_gendisk(): $delay ms"
+		sysfs_race_kernfs_kernfs_fop_write_iter 0032 after_active 0 $delay
+	done
+}
+
 test_gen_desc()
 {
 	echo -n "$1 x $(get_test_count $1)"
@@ -1002,6 +1212,10 @@ list_tests()
 	echo "$(test_gen_desc 0026) - block test writing y larger delay and resetting device"
 	echo "$(test_gen_desc 0027) - test rmmod deadlock while writing x ... "
 	echo "$(test_gen_desc 0028) - test rmmod deadlock using rtnl_lock while writing x ..."
+	echo "$(test_gen_desc 0029) - racing removal of store op with kernfs at start"
+	echo "$(test_gen_desc 0030) - racing removal of store op with kernfs before mutex"
+	echo "$(test_gen_desc 0031) - racing removal of store op with kernfs after mutex"
+	echo "$(test_gen_desc 0032) - racing removal of store op with kernfs after active"
 }
 
 usage()
-- 
2.30.2

