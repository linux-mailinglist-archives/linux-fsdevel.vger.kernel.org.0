Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D41A13B9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgDGSbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 14:31:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:47795 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDGSbS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:31:18 -0400
IronPort-SDR: AHb7KEouitRVp0Iu9+KB8C4Z8lauJCdDRCXGimB8F1MNmXrjmwHiNjVb4ncGIafKpovXssnPzG
 AQRnq9XPGVNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:31:09 -0700
IronPort-SDR: mZWWrPhcUfWsZoVHmBmgdX9nFhfkAqYok3LKO+y4wHl7uWIAqD6Q22EhNRXwlGyz/S8vorCoYb
 /zIHD6Y3Iw1A==
X-IronPort-AV: E=Sophos;i="5.72,356,1580803200"; 
   d="scan'208";a="242147137"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 11:31:07 -0700
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
Date:   Tue,  7 Apr 2020 11:30:59 -0700
Message-Id: <20200407183059.568653-1-ira.weiny@intel.com>
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

 - Applications must call statx to discover the current S_DAX state.

 - There exists an advisory file inode flag FS_XFLAG_DAX that is set based on
   the parent directory FS_XFLAG_DAX inode flag.  (There is no way to change
   this flag after file creation.)

   If FS_XFLAG_DAX is set and the fs is on pmem then it will enable S_DAX at
   inode load time; if FS_XFLAG_DAX is not set, it will not enable S_DAX.
   Unless overridden...

 - There exists a dax= mount option.

   "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
   "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
	"-o dax" (old option) by itself means "dax=always"
   "-o dax=iflag" means "follow FS_XFLAG_DAX" and is the default

 - There exists an advisory directory inode flag FS_XFLAG_DAX that can be
   changed at any time.  The flag state is copied into any files or
   subdirectories when they are created within that directory.  If programs
   require file access runs in S_DAX mode, they must create those files
   inside a directory with FS_XFLAG_DAX set, or mount the fs with an
   appropriate dax mount option.

[*] https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tests/xfs/999     | 231 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/999.out |  21 +++++
 tests/xfs/group   |   1 +
 3 files changed, 253 insertions(+)
 create mode 100755 tests/xfs/999
 create mode 100644 tests/xfs/999.out

diff --git a/tests/xfs/999 b/tests/xfs/999
new file mode 100755
index 000000000000..4d3048616715
--- /dev/null
+++ b/tests/xfs/999
@@ -0,0 +1,231 @@
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
+data_file=$TEST_DIR/data-file
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
+# '-o dax=iflag'
+# '-o dax'
+# '-o dax=always'
+function remount_w_option {
+	mnt_opt=$1
+	export MOUNT_OPTIONS=""
+	export TEST_FS_MOUNT_OPTS=""
+	_test_unmount
+	_test_mount $mnt_opt
+}
+
+function check_dax_mount_option {
+	mnt_opt=$1
+	_fs_options $TEST_DEV | grep -qw '$mnt_opt'
+	if [ "$?" == "0" ]; then
+		echo "FAILED: to mount FS with option '$mnt_opt'"
+		status=1; exit
+	fi
+}
+
+function check_xflag_dax {
+	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
+	if [ "$?" != "0" ]; then
+		echo "FAILED: Did NOT find FS_XFLAG_DAX on $1"
+		status=1; exit
+	fi
+}
+
+function check_s_dax {
+	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
+	masked=$(( $attr & 0x2000 ))
+	if [ "$masked" != "8192" ]; then
+		echo "FAILED: Did NOT find S_DAX flag on $1"
+		status=1; exit
+	fi
+}
+
+function check_no_xflag_dax {
+	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
+	if [ "$?" == "0" ]; then
+		echo "FAILED: Found FS_XFLAG_DAX on $1"
+		status=1; exit
+	fi
+}
+
+function check_no_s_dax {
+	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
+	masked=$(( $attr & 0x2000 ))
+	if [ "$masked" == "8192" ]; then
+		echo "FAILED: Found S_DAX flag on $1"
+		status=1; exit
+	fi
+}
+
+echo "running tests..."
+
+remount_w_option ""
+check_dax_mount_option "dax=iflag"
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
+echo "   *** Check '-o dax=iflag'"
+remount_w_option "-o dax=iflag"
+check_dax_mount_option "dax=iflag"
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
+echo "   *** Verify setting FS_XFLAG_DAX flag fails"
+$XFS_IO_PROG -f -c "pwrite 0 10000" $data_file > /dev/null
+xfs_io -c 'chattr +x' $data_file
+check_no_xflag_dax $data_file
+check_no_s_dax $data_file
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
+echo "   *** Check '-o dax=garbage'"
+remount_w_option "-o dax=garbage"
+
+status=0 ; exit
diff --git a/tests/xfs/999.out b/tests/xfs/999.out
new file mode 100644
index 000000000000..3b204d4643a5
--- /dev/null
+++ b/tests/xfs/999.out
@@ -0,0 +1,21 @@
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
+   *** Check '-o dax=iflag'
+   *** Verify setting FS_XFLAG_DAX flag fails
+xfs_io: cannot set flags on /mnt/xfstests_test/data-file: Invalid argument
+   *** check making 'data' dax with cp
+   *** check making 'data' non-dax with cp
+   *** Moved files 'don't inherit'
+   *** Check '-o dax=garbage'
+mount: /mnt/xfstests_test: wrong fs type, bad option, bad superblock on /dev/pmem0p1, missing codepage or helper program, or other error.
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

