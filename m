Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB202137B0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2020 03:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgAKCSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 21:18:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:8008 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgAKCSt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 21:18:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 18:18:47 -0800
X-IronPort-AV: E=Sophos;i="5.69,419,1571727600"; 
   d="scan'208";a="247210761"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 18:18:47 -0800
From:   ira.weiny@intel.com
To:     fstests@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] generic/XXX: Add generic/XXX
Date:   Fri, 10 Jan 2020 18:18:42 -0800
Message-Id: <20200111021842.32447-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add XXX to test the various setting of dax flags on files.

The final fsx test was derived from Christophs test here but I wanted
more direct function tests as well so I bundled this together.

https://www.spinics.net/lists/linux-xfs/msg10124.html

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---

This is the test case I am using to test the series submitted earlier today.

https://lkml.org/lkml/2020/1/10/864

For my testing I left the fsx tests in a loop which runs for hours rather than
this.

I've also debated moving this to xfs but I intend for ext4 to support this as
well so I have left it in generic for this RFC.

---

 tests/generic/999     | 282 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/999.out |  21 ++++
 tests/generic/group   |   1 +
 3 files changed, 304 insertions(+)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 000000000000..6dd5529dbc65
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,282 @@
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
+dax_file=$TEST_DIR/dax-file
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
+_require_xfs_io_command "chattr" "x"
+_require_xfs_io_command "statx"
+_require_test
+
+function mount_no_dax {
+	# mount SCRATCH_DEV with dax option, TEST_DEV not
+	export MOUNT_OPTIONS=""
+	export TEST_FS_MOUNT_OPTS=""
+	_test_unmount
+	_test_mount
+	_fs_options $TEST_DEV | grep -qw "dax"
+	if [ "$?" == "0" ]; then
+		_notrun "we need $TEST_DEV mount without dax"
+	fi
+}
+
+function mount_dax {
+	# mount SCRATCH_DEV with dax option, TEST_DEV not
+	export MOUNT_OPTIONS=""
+	export TEST_FS_MOUNT_OPTS=""
+	_test_unmount
+	_test_mount "-o dax"
+	_fs_options $TEST_DEV | grep -qw "dax"
+	if [ "$?" != "0" ]; then
+		_notrun "we need $TEST_DEV mount with dax"
+	fi
+}
+
+function check_phys_dax {
+	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
+	if [ "$?" != "0" ]; then
+		echo "FAILED: Did NOT find DAX flag on $1"
+		status=1; exit
+	fi
+}
+
+function check_effective_dax {
+	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
+	masked=$(( $attr & 0x2000 ))
+	if [ "$masked" != "8192" ]; then
+		echo "FAILED: Did NOT find VFS DAX flag on $1"
+		status=1; exit
+	fi
+}
+
+function check_phys_no_dax {
+	xfs_io -c 'lsattr' $1 | awk -e '{ print $1 }' | grep 'x' &> /dev/null
+	if [ "$?" == "0" ]; then
+		echo "FAILED: Found DAX flag on $1"
+		status=1; exit
+	fi
+}
+
+function check_effective_no_dax {
+	attr=`xfs_io -c 'statx -r' $1 | grep 'stat.attributes' | awk -e '{ print $3 }'`
+	masked=$(( $attr & 0x2000 ))
+	if [ "$masked" == "8192" ]; then
+		echo "FAILED: Found VFS DAX flag on $1"
+		status=1; exit
+	fi
+}
+
+echo "running tests..."
+
+echo "   *** mount w/o dax flag."
+mount_no_dax
+
+echo "   *** mark dax-dir as dax enabled"
+mkdir $dax_dir
+xfs_io -c 'chattr +x' $dax_dir
+check_phys_dax $dax_dir
+check_effective_dax $dax_dir
+
+echo "   *** check file inheritance"
+touch $dax_inh_file
+check_phys_dax $dax_inh_file
+check_effective_dax $dax_inh_file
+
+echo "   *** check directory inheritance"
+mkdir $dax_sub_dir
+check_phys_dax $dax_sub_dir
+check_effective_dax $dax_sub_dir
+
+echo "   *** check changing directory"
+xfs_io -c 'chattr -x' $dax_dir
+check_phys_no_dax $dax_dir
+check_effective_no_dax $dax_dir
+
+echo "   *** check non file inheritance"
+touch $dax_non_inh_file
+check_phys_no_dax $dax_non_inh_file
+check_effective_no_dax $dax_non_inh_file
+
+echo "   *** check that previous file stays enabled"
+check_phys_dax $dax_inh_file
+check_effective_dax $dax_inh_file
+
+echo "   *** Reset the directory"
+xfs_io -c 'chattr +x' $dax_dir
+check_phys_dax $dax_dir
+check_effective_dax $dax_dir
+
+
+# check mount override
+# ====================
+
+echo "   *** Remount fs with mount flag"
+mount_dax
+touch $non_dax
+check_phys_no_dax $non_dax
+check_effective_dax $non_dax
+
+echo "   *** Check for non-dax files to be dax with mount option"
+check_effective_dax $dax_non_inh_file
+
+echo "   *** check for file dax flag 'sticky-ness' after remount"
+touch $dax_file
+xfs_io -c 'chattr +x' $dax_file
+check_phys_dax $dax_file
+check_effective_dax $dax_file
+
+echo "   *** remount w/o mount flag"
+mount_no_dax
+check_phys_dax $dax_file
+check_effective_dax $dax_file
+
+check_phys_no_dax $non_dax
+check_effective_no_dax $non_dax
+
+
+# Check non-zero file operations
+# ==============================
+
+echo "   *** file should change effective but page cache should be empty"
+$XFS_IO_PROG -f -c "pwrite 0 10000" $data_file > /dev/null
+xfs_io -c 'chattr +x' $data_file
+check_phys_dax $data_file
+check_effective_dax $data_file
+
+
+# Check inheritance on cp, mv
+# ===========================
+
+echo "   *** check inheritance on cp, mv"
+cp $non_dax $dax_dir/conv-dax
+check_phys_dax $dax_dir/conv-dax
+check_effective_dax $dax_dir/conv-dax
+
+echo "   *** Moved files 'don't inherit'"
+mv $non_dax $dax_dir/move-dax
+check_phys_no_dax $dax_dir/move-dax
+check_effective_no_dax $dax_dir/move-dax
+
+# Check preservation of phys on cp, mv
+# ====================================
+
+mv $dax_file $dax_file_move
+check_phys_dax $dax_file_move
+check_effective_dax $dax_file_move
+
+cp $dax_file_move $dax_file_copy
+check_phys_no_dax $dax_file_copy
+check_effective_no_dax $dax_file_copy
+
+
+# Verify no mode changes on mmap
+# ==============================
+
+echo "   *** check no mode change when mmaped"
+
+dd if=/dev/zero of=$dax_file bs=4096 count=10 > $tmp.log 2>&1
+
+# set known state.
+xfs_io -c 'chattr -x' $dax_file
+check_phys_no_dax $dax_file
+check_effective_no_dax $dax_file
+
+python3 - << EOF > $tmp.log 2>&1 &
+import mmap
+import time
+print ('mmaping "$dax_file"')
+f=open("$dax_file", "r+b")
+mm = mmap.mmap(f.fileno(), 0)
+print ('mmaped "$dax_file"')
+while True:
+	time.sleep(1)
+EOF
+pid=$!
+
+sleep 1
+
+# attempt to should fail
+xfs_io -c 'chattr +x' $dax_file > /dev/null 2>&1
+check_phys_no_dax $dax_file
+check_effective_no_dax $dax_file
+
+kill -TERM $pid > /dev/null 2>&1
+wait $pid > /dev/null 2>&1
+
+# after mmap released should work
+xfs_io -c 'chattr +x' $dax_file
+check_phys_dax $dax_file
+check_effective_dax $dax_file
+
+
+# Finally run the test stolen from Christoph Hellwig to test changing the mode
+# while performing a series of operations
+# =============================================================================
+
+function run_fsx {
+	options=$1
+
+	echo "   *** run 'fsx $options' racing with setting/clearing the DAX flag"
+	$here/ltp/fsx $options -N 20000 $dax_file > $tmp.log 2>&1 &
+	pid=$!
+
+	if [ ! -n "$pid" ]; then
+		echo "FAILED to start fsx"
+		exit 255
+	fi
+
+	# NOTE: fsx runs much faster than these mode changes.
+	for i in `seq 1 500`; do
+		xfs_io -c 'chattr +x' $dax_file > /dev/null 2>&1
+		xfs_io -c 'chattr -x' $dax_file > /dev/null 2>&1
+	done
+
+	wait $pid
+	status=$?
+	if [ "$status" != "0" ]; then
+		cat /sys/kernel/debug/tracing/trace > trace_output
+		echo "FAILED: fsx exited with status : $status"
+		echo "        see trace_output"
+		head $dax_file.fsxlog
+		exit $status
+	fi
+	pid=""
+}
+
+run_fsx ""
+run_fsx "-A"
+run_fsx "-Z -r 4096 -w 4096"
+
+
+status=0 ; exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 000000000000..ccb13770ca4d
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,21 @@
+QA output created by 999
+running tests...
+   *** mount w/o dax flag.
+   *** mark dax-dir as dax enabled
+   *** check file inheritance
+   *** check directory inheritance
+   *** check changing directory
+   *** check non file inheritance
+   *** check that previous file stays enabled
+   *** Reset the directory
+   *** Remount fs with mount flag
+   *** Check for non-dax files to be dax with mount option
+   *** check for file dax flag 'sticky-ness' after remount
+   *** remount w/o mount flag
+   *** file should change effective but page cache should be empty
+   *** check inheritance on cp, mv
+   *** Moved files 'don't inherit'
+   *** check no mode change when mmaped
+   *** run 'fsx ' racing with setting/clearing the DAX flag
+   *** run 'fsx -A' racing with setting/clearing the DAX flag
+   *** run 'fsx -Z -r 4096 -w 4096' racing with setting/clearing the DAX flag
diff --git a/tests/generic/group b/tests/generic/group
index 90da26c5b42c..c652494f7182 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -594,3 +594,4 @@
 589 auto mount
 590 auto prealloc preallocrw
 591 auto quick rw pipe splice
+999 auto
-- 
2.21.0

