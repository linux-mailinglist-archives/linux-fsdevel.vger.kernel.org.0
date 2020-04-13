Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCC81A62B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgDMFoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 01:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgDMFoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:44:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC65C008676;
        Sun, 12 Apr 2020 22:44:23 -0700 (PDT)
IronPort-SDR: K2jhMI6z8sdDtabK5XMWFuNnYfcR4DicJwevqy6O870DD2JNsttD5oRvwFeXwgaH9yREi74EG5
 m1sQ6MGhuxoA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:44:22 -0700
IronPort-SDR: jd2czqUmnSSn0Nl6BXML5V/i7YraLgR7LEYSiyZ9bkS8LVu1RUMWBgY6zIuKZwP7hVEfUuUIGa
 JFnMEddTox0g==
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="399511220"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 22:44:20 -0700
From:   ira.weiny@intel.com
To:     fstests@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] xfs/XXX: Add xfs/XXX
Date:   Sun, 12 Apr 2020 22:44:19 -0700
Message-Id: <20200413054419.1560503-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add XXX to test per file DAX operations.

The following is tested[*]

 1. There exists an in-kernel access mode flag S_DAX that is set when
    file accesses go directly to persistent memory, bypassing the page
    cache.  Applications must call statx to discover the current S_DAX
    state (STATX_ATTR_DAX).

 2. There exists an advisory file inode flag FS_XFLAG_DAX that is
    inherited from the parent directory FS_XFLAG_DAX inode flag at file
    creation time.  This advisory flag can be set or cleared at any
    time, but doing so does not immediately affect the S_DAX state.

    Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
    and the fs is on pmem then it will enable S_DAX at inode load time;
    if FS_XFLAG_DAX is not set, it will not enable S_DAX.

 3. There exists a dax= mount option.

    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."

    "-o dax=always" means "always set S_DAX (at least on pmem),
                    and ignore FS_XFLAG_DAX."

    "-o dax"        is an alias for "dax=always".

    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.

 4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
    be set or cleared at any time.  The flag state is copied into any
    files or subdirectories when they are created within that directory.

 5. Programs that require a specific file access mode (DAX or not DAX)
    can do one of the following:

    (a) Create files in directories that the FS_XFLAG_DAX flag set as
        needed; or

    (b) Have the administrator set an override via mount option; or

    (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
        must then cause the kernel to evict the inode from memory.  This
        can be done by:

        i>  Closing the file and re-opening the file and using statx to
            see if the fs has changed the S_DAX flag; and

        ii> If the file still does not have the desired S_DAX access
            mode, either unmount and remount the filesystem, or close
            the file and use drop_caches.

 6. It's not unreasonable that users who want to squeeze every last bit
    of performance out of the particular rough and tumble bits of their
    storage also be exposed to the difficulties of what happens when the
    operating system can't totally virtualize those hardware
    capabilities.  Your high performance sports car is not a Toyota
    minivan, as it were.

[*] https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v6 (kernel patch set):
	Start versions tracking the kernel patch set.
	Update for new requirements

Changes from V1 (xfstests patch):
	Add test to ensure moved files preserve their flag
	Check chattr of non-dax flags (check bug found by Darrick)
---
 tests/xfs/999     | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |  22 ++++
 tests/xfs/group   |   1 +
 3 files changed, 295 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 000000000000..3ca04b98c517
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,272 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
+#
+# FSQA Test No. 999 (temporary)
+#
+# Test setting of DAX flag
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+dax_dir=$TEST_DIR/dax-dir
+dax_sub_dir=$TEST_DIR/dax-dir/dax-sub-dir
+dax_inh_file=$dax_dir/dax-inh-file
+dax_non_inh_file=$dax_dir/dax-non-inh-file
+non_dax=$TEST_DIR/non-dax
+dax_file=$TEST_DIR/dax-dir/dax-file
+dax_file_copy=$TEST_DIR/dax-file-copy
+dax_file_move=$TEST_DIR/dax-file-move
+data_file=$TEST_DIR/non-dax-dir/data-file
+
+_cleanup() {
+	rm -rf $TEST_DIR/*
+}
+
+trap "_cleanup ; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+
+# real QA test starts here
+_supported_os Linux
+_require_xfs_io_command "lsattr"
+_require_xfs_io_command "statx"
+_require_test
+
+#
+# mnt_opt's we expect
+# ''
+# '-o dax=off'
+# '-o dax=inode'
+# '-o dax'
+# '-o dax=always'
+function remount_w_option {
+	mnt_opt=$1
+	export MOUNT_OPTIONS=""
+	export TEST_FS_MOUNT_OPTS=""
+	_test_unmount &> /dev/null
+	_test_mount $mnt_opt &> /dev/null
+}
+
+function check_dax_mount_option {
+	mnt_opt=$1
+	_fs_options $TEST_DEV | grep -qw '$mnt_opt'
+	if [ "$?" == "0" ]; then
+		echo "FAILED: to mount FS with option '$mnt_opt'"
+	fi
+}
+
+function check_xflag_dax {
+	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
+	if [ "$?" != "0" ]; then
+		echo "FAILED: Did NOT find FS_XFLAG_DAX on $1"
+	fi
+}
+
+function check_s_dax {
+	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
+	masked=$(( $attr & 0x2000 ))
+	if [ "$masked" != "8192" ]; then
+		echo "FAILED: Did NOT find S_DAX flag on $1"
+	fi
+}
+
+function check_no_xflag_dax {
+	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
+	if [ "$?" == "0" ]; then
+		echo "FAILED: Found FS_XFLAG_DAX on $1"
+	fi
+}
+
+function check_no_s_dax {
+	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
+	masked=$(( $attr & 0x2000 ))
+	if [ "$masked" == "8192" ]; then
+		echo "FAILED: Found S_DAX flag on $1"
+	fi
+}
+
+echo "running tests..."
+
+remount_w_option ""
+check_dax_mount_option "dax=inode"
+
+echo "   *** mark dax-dir as dax enabled"
+mkdir $dax_dir
+xfs_io -c 'chattr +x' $dax_dir
+check_xflag_dax $dax_dir
+
+echo "   *** check file inheritance"
+touch $dax_inh_file
+check_xflag_dax $dax_inh_file
+check_s_dax $dax_inh_file
+
+echo "   *** check directory inheritance"
+mkdir $dax_sub_dir
+check_xflag_dax $dax_sub_dir
+
+echo "   *** check changing directory"
+xfs_io -c 'chattr -x' $dax_dir
+check_no_xflag_dax $dax_dir
+check_no_s_dax $dax_dir
+
+echo "   *** check non file inheritance"
+touch $dax_non_inh_file
+check_no_xflag_dax $dax_non_inh_file
+check_no_s_dax $dax_non_inh_file
+
+echo "   *** check that previous file stays enabled"
+check_xflag_dax $dax_inh_file
+check_s_dax $dax_inh_file
+
+echo "   *** Reset the directory"
+xfs_io -c 'chattr +x' $dax_dir
+check_xflag_dax $dax_dir
+
+# Set up for next test
+touch $dax_file
+touch $non_dax
+
+#
+#                      inode flag
+# ./
+#   + dax-dir/             X
+#     + dax-sub-dir/       X
+#     + dax-inh-file       X
+#     + dax-non-inh-file
+#     + dax-file           X
+#   + non-dax
+#
+
+# check mount overrides
+# =====================
+
+echo "   *** Check '-o dax'"
+remount_w_option "-o dax"
+check_dax_mount_option "dax=always"
+
+echo "   *** non-dax inode but overrides to be effective"
+check_no_xflag_dax $non_dax
+check_s_dax $non_dax
+
+echo "   *** Check for non-dax inode to be dax with mount option"
+check_no_xflag_dax $dax_non_inh_file
+check_s_dax $dax_non_inh_file
+
+
+echo "   *** Check '-o dax=never'"
+remount_w_option "-o dax=never"
+check_dax_mount_option "dax=never"
+
+check_xflag_dax $dax_dir
+check_xflag_dax $dax_sub_dir
+check_xflag_dax $dax_inh_file
+check_no_s_dax $dax_inh_file
+check_no_xflag_dax $dax_non_inh_file
+check_no_s_dax $dax_non_inh_file
+check_no_xflag_dax $non_dax
+check_no_s_dax $non_dax
+check_xflag_dax $dax_file
+check_no_s_dax $dax_file
+
+
+echo "   *** Check '-o dax=inode'"
+remount_w_option "-o dax=inode"
+check_dax_mount_option "dax=inode"
+
+check_xflag_dax $dax_dir
+check_xflag_dax $dax_sub_dir
+check_xflag_dax $dax_inh_file
+check_s_dax $dax_inh_file
+check_no_xflag_dax $dax_non_inh_file
+check_no_s_dax $dax_non_inh_file
+check_no_xflag_dax $non_dax
+check_no_s_dax $non_dax
+check_xflag_dax $dax_file
+check_s_dax $dax_file
+
+
+# Check non-zero file operations
+# ==============================
+
+echo "   *** Verify changing FS_XFLAG_DAX flag"
+
+mkdir $TEST_DIR/non-dax-dir
+$here/ltp/fsx $options -N 20000 $data_file > $tmp.log 2>&1 &
+pid=$!
+check_no_xflag_dax $data_file
+check_no_s_dax $data_file
+
+if [ ! -n "$pid" ]; then
+	echo "FAILED to start fsx"
+else
+	# toggle inode flag back and forth.
+	# s_dax should not change while fsx is using file.
+	xfs_io -c 'chattr +x' $data_file &> /dev/null
+	check_xflag_dax $data_file
+	check_no_s_dax $data_file
+	xfs_io -c 'chattr -x' $data_file &> /dev/null
+	check_no_xflag_dax $data_file
+	check_no_s_dax $data_file
+	xfs_io -c 'chattr +x' $data_file &> /dev/null
+	check_xflag_dax $data_file
+	check_no_s_dax $data_file
+fi
+
+wait $pid
+status=$?
+if [ "$status" != "0" ]; then
+	echo "FAILED: fsx exited with status : $status"
+	head $dax_file.fsxlog
+fi
+pid=""
+
+echo 2 > /proc/sys/vm/drop_caches
+
+echo "   *** Verify S_DAX change on drop_caches"
+# s_dax should change after drop_caches
+check_xflag_dax $data_file
+check_s_dax $data_file
+
+
+# Check inheritance on cp, mv
+# ===========================
+
+echo "   *** check making 'data' dax with cp"
+cp $non_dax $dax_dir/conv-dax
+check_xflag_dax $dax_dir/conv-dax
+check_s_dax $dax_dir/conv-dax
+
+echo "   *** check making 'data' non-dax with cp"
+rm -f $data_file
+cp $dax_dir/conv-dax $data_file
+check_no_xflag_dax $data_file
+check_no_s_dax $data_file
+
+echo "   *** Moved files 'don't inherit'"
+mv $non_dax $dax_dir/move-dax
+check_no_xflag_dax $dax_dir/move-dax
+check_no_s_dax $dax_dir/move-dax
+
+echo "   *** Moved files preserve their flag"
+mv $dax_file $TEST_DIR/move-dax
+check_xflag_dax $TEST_DIR/move-dax
+check_s_dax $TEST_DIR/move-dax
+
+echo "   *** Check file chattr of non-dax flags"
+xfs_io -c 'chattr +s' $dax_inh_file
+xfs_io -c 'chattr -s' $dax_inh_file
+
+echo "   *** Check '-o dax=garbage'"
+remount_w_option "-o dax=garbage"
+_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR
+if [ "$?" == "0" ]; then
+	echo "ERROR: fs mounted with '-o dax=garbage'"
+fi
+
+status=0 ; exit
diff --git a/tests/xfs/999.out b/tests/xfs/999.out
new file mode 100644
index 000000000000..3a4f970a5073
--- /dev/null
+++ b/tests/xfs/999.out
@@ -0,0 +1,22 @@
+QA output created by 999
+running tests...
+   *** mark dax-dir as dax enabled
+   *** check file inheritance
+   *** check directory inheritance
+   *** check changing directory
+   *** check non file inheritance
+   *** check that previous file stays enabled
+   *** Reset the directory
+   *** Check '-o dax'
+   *** non-dax inode but overrides to be effective
+   *** Check for non-dax inode to be dax with mount option
+   *** Check '-o dax=never'
+   *** Check '-o dax=inode'
+   *** Verify changing FS_XFLAG_DAX flag
+   *** Verify S_DAX change on drop_caches
+   *** check making 'data' dax with cp
+   *** check making 'data' non-dax with cp
+   *** Moved files 'don't inherit'
+   *** Moved files preserve their flag
+   *** Check file chattr of non-dax flags
+   *** Check '-o dax=garbage'
diff --git a/tests/xfs/group b/tests/xfs/group
index 522d4bc44d1f..816883a268bf 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -511,3 +511,4 @@
 511 auto quick quota
 512 auto quick acl attr
 513 auto mount
+999 auto
-- 
2.25.1

