Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321122EA2C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 02:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhAEBGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 20:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbhAEBAl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:00:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDB56225AA;
        Tue,  5 Jan 2021 00:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609808366;
        bh=ZieGW3Et/wQUMZmGqWV7pv9/jbVeskaboo7z3aGg9o8=;
        h=From:To:Cc:Subject:Date:From;
        b=CvzIms4HkPnUFfJjuIdaKwwV4sT2TsQkN6U6J0de/eVKQSXkSjsraaf+nOkhBuuDk
         9Z0vfgYlL3vSmDgs2p419yMAEVe15/DuKPvNP0sAguFfr7JGfBBxVGHywap4WLp2K/
         LWESIn9maybFZ7Wyh3f5D5SDXPY7l0rN+I+qCBNAO7N2mJOMfhHraZ5ySnM+0DzY0u
         FtwtvUsQuyphJGPUt/yB3oh2Ej2zuqB9HPN2ERmhX9WdMS/fg4BEnCocsbgqffBKXw
         l0Z4xTrYb50jf4s/eLyxP6/5sqnYhERc6+n/YB5fUS0Ojs12jEznmPyQez987YauOq
         aeQNUA7K6wPPw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: [xfstests RFC PATCH] generic: test for lazytime timestamp updates
Date:   Mon,  4 Jan 2021 16:58:18 -0800
Message-Id: <20210105005818.92978-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Test that when the lazytime mount option is enabled, updates to atime,
mtime, and ctime get persisted in the cases when they should be.

Note that this doesn't test that updates aren't persisted when they
shouldn't be, as that would be harder to do.  (This also means that we
don't have to check whether the filesystem supports lazytime before
running the test.  If lazytime is ignored, the test will pass.)

As this test requires support for the shutdown ioctl, it currently runs
only on ext4, f2fs, and xfs.  It passes on ext4 and f2fs, but it fails
on xfs because xfs has a bug where it doesn't persist lazytime timestamp
updates on user-triggered syncs or after dirtytime_expire_seconds has
elapsed.  I've sent out patches to fix this bug.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---

RFC for now, since the XFS fix
(https://lore.kernel.org/r/20210105005452.92521-14-ebiggers@kernel.org)
hasn't been merged yet.

 tests/generic/900     | 235 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out |  37 +++++++
 tests/generic/group   |   1 +
 3 files changed, 273 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out

diff --git a/tests/generic/900 b/tests/generic/900
new file mode 100755
index 00000000..cbd4b12a
--- /dev/null
+++ b/tests/generic/900
@@ -0,0 +1,235 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright 2021 Google LLC
+#
+# FS QA Test No. 900
+#
+# Test that when the lazytime mount option is enabled, updates to atime, mtime,
+# and ctime are persisted in (at least) the four cases when they should be:
+#
+# - the inode needs to be updated for some change unrelated to file timestamps
+# - userspace calls fsync(), syncfs(), or sync()
+# - the inode is evicted from memory
+# - more than dirtytime_expire_seconds have elapsed
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+DIRTY_EXPIRE_CENTISECS_ORIG=$(</proc/sys/vm/dirty_expire_centisecs)
+DIRTY_WRITEBACK_CENTISECS_ORIG=$(</proc/sys/vm/dirty_writeback_centisecs)
+DIRTYTIME_EXPIRE_SECONDS_ORIG=$(</proc/sys/vm/dirtytime_expire_seconds)
+
+restore_expiration_settings()
+{
+	echo "$DIRTY_EXPIRE_CENTISECS_ORIG" > /proc/sys/vm/dirty_expire_centisecs
+	echo "$DIRTY_WRITEBACK_CENTISECS_ORIG" > /proc/sys/vm/dirty_writeback_centisecs
+	echo "$DIRTYTIME_EXPIRE_SECONDS_ORIG" > /proc/sys/vm/dirtytime_expire_seconds
+}
+
+# Enable continuous writeback of dirty inodes, so that we don't have to wait
+# for the typical 30 seconds default.
+__expire_inodes()
+{
+	echo 1 > /proc/sys/vm/dirty_expire_centisecs
+	echo 1 > /proc/sys/vm/dirty_writeback_centisecs
+}
+
+# Trigger and wait for writeback of any dirty inodes (not dirtytime inodes).
+expire_inodes()
+{
+	__expire_inodes
+	# Userspace doesn't have direct visibility into when inodes are dirty,
+	# so the best we can do is sleep for a couple seconds.
+	sleep 2
+	restore_expiration_settings
+}
+
+# Trigger and wait for writeback of any dirtytime inodes.
+expire_timestamps()
+{
+	# Enable immediate expiration of lazytime timestamps, so that we don't
+	# have to wait for the typical 24 hours default.  This should quickly
+	# turn dirtytime inodes into regular dirty inodes.
+	echo 1 > /proc/sys/vm/dirtytime_expire_seconds
+
+	# Enable continuous writeback of dirty inodes.
+	__expire_inodes
+
+	# Userspace doesn't have direct visibility into when inodes are dirty,
+	# so the best we can do is sleep for a couple seconds.
+	sleep 2
+	restore_expiration_settings
+}
+
+_cleanup()
+{
+	restore_expiration_settings
+	rm -f $tmp.*
+}
+
+. ./common/rc
+. ./common/filter
+
+rm -f $seqres.full
+
+_supported_fs generic
+# This test uses the shutdown command, so it has to use the scratch filesystem
+# rather than the test filesystem.
+_require_scratch
+_require_scratch_shutdown
+_require_xfs_io_command "pwrite"
+_require_xfs_io_command "fsync"
+_require_xfs_io_command "syncfs"
+# This test doesn't have to check that the filesystem supports "lazytime", since
+# "lazytime" is a VFS-level option, and at worst it just will be ignored.  This
+# test will still pass in that case, as it only tests that timestamp updates are
+# persisted when they should be; it doesn't test that timestamp updates aren't
+# persisted when they shouldn't be.
+
+_scratch_mkfs &>> $seqres.full
+_scratch_mount
+
+# Create the test file for which we'll update and check the timestamps.
+file=$SCRATCH_MNT/file
+$XFS_IO_PROG -f $file -c "pwrite 0 100" > /dev/null
+
+# Get the specified timestamp of $file in nanoseconds since the epoch.
+get_timestamp()
+{
+	local timestamp_type=$1
+
+	local arg
+	case $timestamp_type in
+	atime)	arg=X ;;
+	mtime)	arg=Y ;;
+	ctime)	arg=Z ;;
+	*)	_fail "Unhandled timestamp_type: $timestamp_type" ;;
+	esac
+	stat -c "%.9${arg}" $file | tr -d '.'
+}
+
+do_test()
+{
+	local timestamp_type=$1
+	local persist_method=$2
+
+	echo -e "\n# Testing that lazytime $timestamp_type update is persisted by $persist_method"
+
+	# Mount the filesystem with lazytime.  If atime is being tested, then
+	# also use strictatime, since otherwise the filesystem may default to
+	# relatime and not do the atime updates.
+	if [[ $timestamp_type == atime ]]; then
+		_scratch_cycle_mount lazytime,strictatime
+	else
+		_scratch_cycle_mount lazytime
+	fi
+
+	# Update the specified timestamp on the file.
+	local orig_time=$(get_timestamp $timestamp_type)
+	sleep 0.1
+	case $timestamp_type in
+	atime)
+		# Read from the file to update its atime.
+		cat $file > /dev/null
+		;;
+	mtime)
+		# Write to the file to update its mtime.  Make sure to not write
+		# past the end of the file, as that would change i_size, which
+		# would be an inode change which would cause the timestamp to
+		# always be written -- thus making the test not detect bugs
+		# where the timestamp doesn't get written.
+		#
+		# Also do the write twice, since XFS updates i_version the first
+		# time, which likewise causes mtime to be written.  We want the
+		# last thing done to just update mtime.
+		$XFS_IO_PROG -f $file -c "pwrite 0 100" > /dev/null
+		$XFS_IO_PROG -f $file -c "pwrite 0 100" > /dev/null
+		;;
+	ctime)
+		# It isn't possible to update just ctime, so use 'touch -a'
+		# to update both atime and ctime.
+		touch -a $file
+		;;
+	esac
+	local expected_time=$(get_timestamp $timestamp_type)
+	if (( expected_time <= orig_time )); then
+		echo "FAIL: $timestamp_type didn't increase after updating it (in-memory)"
+	fi
+
+	# Do something that should cause the timestamp to be persisted.
+	case $persist_method in
+	other_inode_change)
+		# Make a non-timestamp-related change to the inode.
+		chmod 777 $file
+		if [[ $timestamp_type == ctime ]]; then
+			# The inode change will have updated ctime again.
+			expected_time=$(get_timestamp ctime)
+		fi
+		# The inode may have been marked dirty but not actually written
+		# yet.  Expire it by tweaking the VM settings and waiting.
+		expire_inodes
+		;;
+	sync)
+		# Execute the sync() system call.
+		sync
+		;;
+	fsync)
+		# Execute the fsync() system call on the file.
+		$XFS_IO_PROG -r $file -c fsync
+		;;
+	syncfs)
+		# Execute the syncfs() system call on the filesystem.
+		$XFS_IO_PROG $SCRATCH_MNT -c syncfs
+		;;
+	eviction)
+		# Evict the inode from memory.  In theory, drop_caches should do
+		# the trick by itself.  But that actually just dirties the
+		# inodes that need a lazytime update.  So we still need to wait
+		# for inode writeback too.
+		echo 2 > /proc/sys/vm/drop_caches
+		expire_inodes
+		;;
+	expiration)
+		# Expire the lazy timestamps via dirtytime_expire_seconds.
+		expire_timestamps
+		;;
+	*)
+		_fail "Unhandled persist_method: $persist_method"
+	esac
+
+	# Use the shutdown ioctl to abort the filesystem.
+	#
+	# The timestamp might have just been written to the log and not *fully*
+	# persisted yet, so use -f to ensure the log gets flushed.
+	_scratch_shutdown -f
+
+	# Now remount the filesystem and verify that the timestamp really got
+	# updated as expected.
+	_scratch_cycle_mount
+	local ondisk_time=$(get_timestamp $timestamp_type)
+	if (( ondisk_time != expected_time )); then
+		# Fail the test by printing unexpected output rather than by
+		# calling _fail(), since we can still run the other test cases.
+		echo "FAIL: lazytime $timestamp_type wasn't persisted by $persist_method"
+		echo "ondisk_time ($ondisk_time) != expected_time ($expected_time)"
+	fi
+}
+
+for timestamp_type in atime mtime ctime; do
+	do_test $timestamp_type other_inode_change
+	do_test $timestamp_type sync
+	do_test $timestamp_type fsync
+	do_test $timestamp_type syncfs
+	do_test $timestamp_type eviction
+	do_test $timestamp_type expiration
+done
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/900.out b/tests/generic/900.out
new file mode 100644
index 00000000..53bd2e29
--- /dev/null
+++ b/tests/generic/900.out
@@ -0,0 +1,37 @@
+QA output created by 900
+
+# Testing that lazytime atime update is persisted by other_inode_change
+
+# Testing that lazytime atime update is persisted by sync
+
+# Testing that lazytime atime update is persisted by fsync
+
+# Testing that lazytime atime update is persisted by syncfs
+
+# Testing that lazytime atime update is persisted by eviction
+
+# Testing that lazytime atime update is persisted by expiration
+
+# Testing that lazytime mtime update is persisted by other_inode_change
+
+# Testing that lazytime mtime update is persisted by sync
+
+# Testing that lazytime mtime update is persisted by fsync
+
+# Testing that lazytime mtime update is persisted by syncfs
+
+# Testing that lazytime mtime update is persisted by eviction
+
+# Testing that lazytime mtime update is persisted by expiration
+
+# Testing that lazytime ctime update is persisted by other_inode_change
+
+# Testing that lazytime ctime update is persisted by sync
+
+# Testing that lazytime ctime update is persisted by fsync
+
+# Testing that lazytime ctime update is persisted by syncfs
+
+# Testing that lazytime ctime update is persisted by eviction
+
+# Testing that lazytime ctime update is persisted by expiration
diff --git a/tests/generic/group b/tests/generic/group
index fec35d8e..2c19381c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -624,3 +624,4 @@
 619 auto rw enospc
 620 auto mount quick
 621 auto quick encrypt
+900 auto
-- 
2.30.0

