Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952D76D791
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjHBTPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 15:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjHBTPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:15:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472626A6;
        Wed,  2 Aug 2023 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dmglu2WcMJRNiAya+Ibgj3ODFpzydvn3LhEN/Er/Pa8=; b=Ac4MNEXrIGqRdi5Ojv4/6ne5zF
        tTfDfgM3FsAi6nlnFwNcpEi26QHWdsYPkSrMW/amu3qKg2mLbPvBO3ATSceJi+WvHUphOy+YNjwmU
        1eq/0YuexqfdR991UoQ/LltL3wVrrEj8ab58HKUJKRNHeF44bztgdWIQLSFxkYE3Lne9Nx/NkuhbM
        KZ2II1gkRil2CT+GILi62q7NgWZ7vG/Am1w7jn7oLm63N4Rrkv392n3vZOJHArYy7Ek7WW+3BrnaH
        Wdw+eoBuasSnpS5CuaEMzUegwPRJHjst3jGpbsc0TvmduoaZO65BG1II6BFXui+nR450y096EUcRM
        Z9rV+foA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qRHJn-005j7p-2S;
        Wed, 02 Aug 2023 19:15:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org, aalbersh@redhat.com,
        chandan.babu@oracle.com, amir73il@gmail.com, josef@toxicpanda.com,
        djwong@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] fstests: add helper to canonicalize devices used to enable persistent disks
Date:   Wed,  2 Aug 2023 12:15:35 -0700
Message-Id: <20230802191535.1365096-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The filesystem configuration file does not allow you to use symlinks to
real devices given the existing sanity checks verify that the target end
device matches the source. Device mapper links work but not symlinks for
real drives do not.

Using a symlink is desirable if you want to enable persistent tests
across reboots. For example you may want to use /dev/disk/by-id/nvme-eui.*
so to ensure that the same drives are used even after reboot. This
is very useful if you are testing for example with a virtualized
environment and are using PCIe passthrough with other qemu NVMe drives
with one or many NVMe drives.

To enable support just add a helper to canonicalize devices prior to
running the tests.

This allows one test runner, kdevops, which I just extended with
support to use real NVMe drives it has support now to use nvme EUI
symlinks and fallbacks to nvme model + serial symlinks as not all
NVMe drives support EUIs. The drives it uses for the filesystem
configuration optionally is with NVMe eui symlinks so to allow
the same drives to be used over reboots.

For instance this works today with real nvme drives:

mkfs.xfs -f /dev/nvme0n1
mount /dev/nvme0n1 /mnt
TEST_DIR=/mnt TEST_DEV=/dev/nvme0n1 FSTYP=xfs ./check generic/110

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 flax-mtr01 6.5.0-rc3-djwx #rc3 SMP PREEMPT_DYNAMIC Wed Jul 26 14:26:48 PDT 2023

generic/110        2s
Ran: generic/110
Passed all 1 tests

But this does not:

TEST_DIR=/mnt TEST_DEV=/dev/disk/by-id/nvme-eui.0035385411904c1e FSTYP=xfs ./check generic/110
mount: /mnt: /dev/disk/by-id/nvme-eui.0035385411904c1e already mounted on /mnt.
common/rc: retrying test device mount with external set
mount: /mnt: /dev/disk/by-id/nvme-eui.0035385411904c1e already mounted on /mnt.
common/rc: could not mount /dev/disk/by-id/nvme-eui.0035385411904c1e on /mnt

umount /mnt
TEST_DIR=/mnt TEST_DEV=/dev/disk/by-id/nvme-eui.0035385411904c1e FSTYP=xfs ./check generic/110
TEST_DEV=/dev/disk/by-id/nvme-eui.0035385411904c1e is mounted but not on TEST_DIR=/mnt - aborting
Already mounted result:
/dev/disk/by-id/nvme-eui.0035385411904c1e /mnt

This fixes this. This allows the same real drives for a test to be
used over and over after reboots.

Use readlink -e because that support exists since 2004:

https://github.com/coreutils/coreutils/commit/e0b8973bd4b146b5fb39641a4ee7984e922c3ff5

realpath is much newer than readlink, it's first commit including
support for -e dates back to 2011:

https://github.com/coreutils/coreutils/commit/77ea441f79aa115f79b47d9c1fc9c0004c5c7111

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Changes on v2:

 - Enhanced the commit log to describe the existing status quo where
   at least device mapper symlinks work but not for real drives. Also
   provide an example output of the issue and use case as implied by
   Darrick.
 - Added CANON_DEVS to disable this by default, document it
 - simplify _canonicalize_devices() with as many one liners as possible
 - use readlink -e because my history scavanging has found it has existed for
   7 years longer thjan realpath -e support. Documen this on the commit
   log as well.

 README        |  3 +++
 check         |  1 +
 common/config | 32 +++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 1ca506492bf0..97ef63d6d693 100644
--- a/README
+++ b/README
@@ -268,6 +268,9 @@ Misc:
    this option is supported for all filesystems currently only -overlay is
    expected to run without issues. For other filesystems additional patches
    and fixes to the test suite might be needed.
+ - set CANON_DEVS=yes to canonicalize device symlinks. This will let you
+   for example use something like TEST_DEV/dev/disk/by-id/nvme-* so the
+   device remains persistent between reboots. This is disabled by default.
 
 ______________________
 USING THE FSQA SUITE
diff --git a/check b/check
index 0bf5b22e061a..577e09655844 100755
--- a/check
+++ b/check
@@ -711,6 +711,7 @@ function run_section()
 	fi
 
 	get_next_config $section
+	_canonicalize_devices
 
 	mkdir -p $RESULT_BASE
 	if [ ! -d $RESULT_BASE ]; then
diff --git a/common/config b/common/config
index 6c8cb3a5ba68..7d74c285ac71 100644
--- a/common/config
+++ b/common/config
@@ -25,6 +25,9 @@
 # KEEP_DMESG -      whether to keep all dmesg for each test case.
 #                   yes: keep all dmesg
 #                   no: only keep dmesg with error/warning (default)
+# CANON_DEVS -      whether or not to canonicalize device symlinks
+#                   yes: canonicalize device symlinks
+#                   no (default) do not canonicalize device if they are symlinks
 #
 # - These can be added to $HOST_CONFIG_DIR (witch default to ./config)
 #   below or a separate local configuration file can be used (using
@@ -644,6 +647,32 @@ _canonicalize_mountpoint()
 	echo "$parent/$base"
 }
 
+# Enables usage of /dev/disk/by-id/ symlinks to persist target devices
+# over reboots
+_canonicalize_devices()
+{
+	if [ "$CANON_DEVS" != "yes" ]; then
+		return
+	fi
+	[ -L "$TEST_DEV" ]	&& TEST_DEV=$(readlink -e "$TEST_DEV")
+	[ -L $SCRATCH_DEV ]	&& SCRATCH_DEV=$(readlink -e "$SCRATCH_DEV")
+	[ -L $TEST_LOGDEV ]	&& TEST_LOGDEV=$(readlink -e "$TEST_LOGDEV")
+	[ -L $TEST_RTDEV ]	&& TEST_RTDEV=$(readlink -e "$TEST_RTDEV")
+	[ -L $SCRATCH_RTDEV ]	&& SCRATCH_RTDEV=$(readlink -e "$SCRATCH_RTDEV")
+	[ -L $LOGWRITES_DEV ]	&& LOGWRITES_DEV=$(readlink -e "$LOGWRITES_DEV")
+	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
+		NEW_SCRATCH_POOL=""
+		for i in $SCRATCH_DEV_POOL; do
+			if [ -L $i ]; then
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
+			else
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i)"
+			fi
+		done
+		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
+	fi
+}
+
 # On check -overlay, for the non multi section config case, this
 # function is called on every test, before init_rc().
 # When SCRATCH/TEST_* vars are defined in config file, config file
@@ -774,7 +803,6 @@ get_next_config() {
 	fi
 
 	parse_config_section $1
-
 	if [ ! -z "$OLD_FSTYP" ] && [ $OLD_FSTYP != $FSTYP ]; then
 		[ -z "$MOUNT_OPTIONS" ] && _mount_opts
 		[ -z "$TEST_FS_MOUNT_OPTS" ] && _test_mount_opts
@@ -890,5 +918,7 @@ else
 	fi
 fi
 
+_canonicalize_devices
+
 # make sure this script returns success
 /bin/true
-- 
2.39.2

