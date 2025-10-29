Return-Path: <linux-fsdevel+bounces-66147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7DC17E10
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2DA3BF000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356B2DECA1;
	Wed, 29 Oct 2025 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzirSWwA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573272773CB;
	Wed, 29 Oct 2025 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700967; cv=none; b=BWlE31KFrxCdZA3EgwYVG7lQdDx6V07uCqPD3ngJRcAlFWNmpOxa2HPwA4yed6gxrYY78hCFUoaUPWeXReO0vvkpI9P3P5OjexMlDbH7Ll4dimn8oR6ubiBuPKnarKDyp/7ODnbJAjcqNzQRys0slPG67OTJhgQlOr5UdhBbads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700967; c=relaxed/simple;
	bh=gQIOo9w4rJYwmuz9TDPYz77wS3nRLvGjQ+tVQTH2u94=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsCNGrP52YlPSvhEReqUBWXoWFE1zNH/WqnUAuj1H8cDar83RM+GobkTVLWNVYlk6TWsfJjfQD/e0eTe7Ci3N9sj3VOgk2W7l2R4FNj5oj25TSkkgNRkpTNiKzRFuddnco8968qV8VarkOZd5epFU3PBIFkwAueBN50LitDnGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzirSWwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3DDC4CEE7;
	Wed, 29 Oct 2025 01:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700967;
	bh=gQIOo9w4rJYwmuz9TDPYz77wS3nRLvGjQ+tVQTH2u94=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MzirSWwAHQIT+dONZNr1eDr0b7SxmaTTph2E5Z9jqBQcPCpz+b8HQSKfke7/+mDAB
	 rMM//13MCPZJpG2Dupvtgsrax/vFaL7pAYWHrgLpm0zbf1hNo+yIGY6C+mQRQTbgF2
	 tCVKlgWbsuRyOo3cLUYAfFtA8HGrCKTEba3JSDva3HgOLqDZ4nXIcc2SNf7g9o8v6a
	 ViBqdhkqeLZmL8+rNi4IxKnkquL6e3l89I7KNG0PEcPMhFPx/8wfhq8J978mz7/yXq
	 wzNWDHDTp0S7pWBuKR5lth4VnVyQZuhK5ePaRl5Ne66owxmoMahoyl4VKY+3mKjJJq
	 UpeF2AoH7z45A==
Date: Tue, 28 Oct 2025 18:22:46 -0700
Subject: [PATCH 09/33] misc: use explicitly $FSTYP'd mount calls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820145.1433624.8475251472993810428.stgit@frogsfrogsfrogs>
In-Reply-To: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Don't rely on mount(8) or the kernel to autodetect the filesystem type
when mounting a formatted image; if we are testing a different driver
(e.g. fuse2fs for ext4 filesystems) then the autodetection picks the
wrong driver.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc         |   12 +++++++++---
 tests/btrfs/199   |    2 +-
 tests/btrfs/219   |   12 ++++++------
 tests/ext4/032    |    2 +-
 tests/ext4/033    |    2 +-
 tests/ext4/052    |    2 +-
 tests/ext4/053    |    2 +-
 tests/generic/042 |    4 ++--
 tests/generic/067 |    4 ++--
 tests/generic/081 |    2 +-
 tests/generic/085 |    2 +-
 tests/generic/108 |    2 +-
 tests/generic/361 |    2 +-
 tests/generic/459 |    2 +-
 tests/generic/563 |    6 +++---
 tests/generic/620 |    2 +-
 tests/generic/648 |    4 ++--
 tests/generic/704 |    2 +-
 tests/generic/730 |    2 +-
 tests/generic/741 |    8 ++++++--
 tests/generic/744 |    6 +++---
 tests/generic/746 |    4 ++--
 tests/xfs/014     |    2 +-
 tests/xfs/049     |    2 +-
 tests/xfs/073     |    8 ++++----
 tests/xfs/074     |    4 ++--
 tests/xfs/078     |    2 +-
 tests/xfs/148     |    4 ++--
 tests/xfs/149     |    4 ++--
 tests/xfs/206     |    2 +-
 tests/xfs/216     |    2 +-
 tests/xfs/217     |    2 +-
 tests/xfs/250     |    2 +-
 tests/xfs/289     |    2 +-
 tests/xfs/507     |    2 +-
 tests/xfs/513     |    2 +-
 tests/xfs/606     |    2 +-
 tests/xfs/613     |    2 +-
 tests/xfs/806     |    2 +-
 39 files changed, 71 insertions(+), 61 deletions(-)


diff --git a/common/rc b/common/rc
index 182a782a16783e..ce406e104beae9 100644
--- a/common/rc
+++ b/common/rc
@@ -446,6 +446,12 @@ _supports_filetype()
 	esac
 }
 
+# Mount with FSTYP explicitly set.
+_mount_fstyp()
+{
+	_mount -t $FSTYP$FUSE_SUBTYP "$@"
+}
+
 # mount scratch device with given options but don't check mount status
 _try_scratch_mount()
 {
@@ -455,7 +461,7 @@ _try_scratch_mount()
 		_overlay_scratch_mount $*
 		return $?
 	fi
-	_mount -t $FSTYP$FUSE_SUBTYP `_scratch_mount_options $*`
+	_mount_fstyp `_scratch_mount_options $*`
 	mount_ret=$?
 	[ $mount_ret -ne 0 ] && return $mount_ret
 	_idmapped_mount $SCRATCH_DEV $SCRATCH_MNT
@@ -715,7 +721,7 @@ _test_mount()
     fi
 
     _test_options mount
-    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _mount_fstyp $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
     mount_ret=$?
     [ $mount_ret -ne 0 ] && return $mount_ret
     _idmapped_mount $TEST_DEV $TEST_DIR
@@ -3541,7 +3547,7 @@ _mount_or_remount_rw()
 
 	if [ $USE_REMOUNT -eq 0 ]; then
 		if [ "$FSTYP" != "overlay" ]; then
-			_mount -t $FSTYP$FUSE_SUBTYP $mount_opts $device $mountpoint
+			_mount_fstyp $mount_opts $device $mountpoint
 			_idmapped_mount $device $mountpoint
 		else
 			_overlay_mount $device $mountpoint
diff --git a/tests/btrfs/199 b/tests/btrfs/199
index f161e55057ff27..5d34413007b450 100755
--- a/tests/btrfs/199
+++ b/tests/btrfs/199
@@ -70,7 +70,7 @@ mkdir -p $loop_mnt
 #   Disabling datasum could reduce the margin caused by metadata to minimal
 # - discard
 #   What we're testing
-_mount $(_btrfs_no_v1_cache_opt) -o nodatasum,discard $loop_dev $loop_mnt
+_mount_fstyp $(_btrfs_no_v1_cache_opt) -o nodatasum,discard $loop_dev $loop_mnt
 
 # Craft the following extent layout:
 #         |  BG1 |      BG2        |       BG3            |
diff --git a/tests/btrfs/219 b/tests/btrfs/219
index 052f61a399ae66..c90a1490d54d77 100755
--- a/tests/btrfs/219
+++ b/tests/btrfs/219
@@ -64,7 +64,7 @@ loop_dev1=`_create_loop_device $fs_img1`
 loop_dev2=`_create_loop_device $fs_img2`
 
 # Normal single device case, should pass just fine
-_mount $loop_dev1 $loop_mnt1 > /dev/null  2>&1 || \
+_mount_fstyp $loop_dev1 $loop_mnt1 > /dev/null  2>&1 || \
 	_fail "Couldn't do initial mount"
 $UMOUNT_PROG $loop_mnt1
 
@@ -73,15 +73,15 @@ _btrfs_forget_or_module_reload
 # Now mount the new version again to get the higher generation cached, umount
 # and try to mount the old version.  Mount the new version again just for good
 # measure.
-_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
+_mount_fstyp $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
 $UMOUNT_PROG $loop_mnt1
 
-_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 || \
+_mount_fstyp $loop_dev2 $loop_mnt2 > /dev/null 2>&1 || \
 	_fail "We couldn't mount the old generation"
 $UMOUNT_PROG $loop_mnt2
 
-_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
+_mount_fstyp $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the second time"
 $UMOUNT_PROG $loop_mnt1
 
@@ -89,10 +89,10 @@ $UMOUNT_PROG $loop_mnt1
 # temp-fsid feature then mount will fail.
 _btrfs_forget_or_module_reload
 
-_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
+_mount_fstyp $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
 	_fail "Failed to mount the third time"
 if ! _has_btrfs_sysfs_feature_attr temp_fsid; then
-	_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
+	_mount_fstyp $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
 		_fail "We were allowed to mount when we should have failed"
 fi
 
diff --git a/tests/ext4/032 b/tests/ext4/032
index b8860422e8d3d4..9a7cd552e195cd 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -48,7 +48,7 @@ ext4_online_resize()
 		$seqres.full 2>&1 || _fail "mkfs failed"
 
 	echo "+++ mount image file" | tee -a $seqres.full
-	_mount -t ${FSTYP} ${LOOP_DEVICE} ${IMG_MNT} > \
+	_mount_fstyp ${LOOP_DEVICE} ${IMG_MNT} > \
 		/dev/null 2>&1 || _fail "mount failed"
 
 	echo "+++ resize fs to $final_size" | tee -a $seqres.full
diff --git a/tests/ext4/033 b/tests/ext4/033
index 3827ab5c52ad0a..d62210b0c183c0 100755
--- a/tests/ext4/033
+++ b/tests/ext4/033
@@ -65,7 +65,7 @@ group_count=$((limit_groups - 16))
 _mkfs_dev -N $((group_count*inodes_per_group)) -b $blksz \
 	$DMHUGEDISK_DEV $((group_count*group_blocks))
 
-_mount $DMHUGEDISK_DEV $SCRATCH_MNT
+_mount_fstyp $DMHUGEDISK_DEV $SCRATCH_MNT
 
 echo "Initial fs dump" >> $seqres.full
 $DUMPE2FS_PROG -h $DMHUGEDISK_DEV >> $seqres.full 2>&1
diff --git a/tests/ext4/052 b/tests/ext4/052
index 05dd30edf70c9b..01e77a048b6d22 100755
--- a/tests/ext4/052
+++ b/tests/ext4/052
@@ -52,7 +52,7 @@ ${MKFS_PROG} -t ${FSTYP} -b 1024 -N 400020 -O large_dir,^has_journal \
 	     $fs_img 20G >> $seqres.full 2>&1 || _fail "mkfs failed"
 
 mkdir -p $loop_mnt
-_mount -o loop $fs_img $loop_mnt > /dev/null  2>&1 || \
+_mount_fstyp -o loop $fs_img $loop_mnt > /dev/null  2>&1 || \
 	_fail "Couldn't do initial mount"
 
 # popdir.pl is much faster than creating 400k file with dirstress
diff --git a/tests/ext4/053 b/tests/ext4/053
index 55f337b4835559..d927237c2a2c2f 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -131,7 +131,7 @@ ok() {
 }
 
 simple_mount() {
-	_mount $* >> $seqres.full 2>&1
+	_mount_fstyp $* >> $seqres.full 2>&1
 }
 
 # $1 - can hold -n option, if it does argumetns are shifted
diff --git a/tests/generic/042 b/tests/generic/042
index ced145dde753e1..290d17502be310 100755
--- a/tests/generic/042
+++ b/tests/generic/042
@@ -35,7 +35,7 @@ _crashtest()
 	_mkfs_dev $img >> $seqres.full 2>&1
 
 	mkdir -p $mnt
-	_mount $img $mnt
+	_mount_fstyp $img $mnt
 
 	echo $cmd
 
@@ -45,7 +45,7 @@ _crashtest()
 	$here/src/godown -f $mnt
 
 	_unmount $mnt
-	_mount $img $mnt
+	_mount_fstyp $img $mnt
 
 	# We should /never/ see 0xCD in the file, because we wrote that pattern
 	# to the filesystem image to expose stale data.
diff --git a/tests/generic/067 b/tests/generic/067
index f8a59758668d5d..ae79d8e68e3430 100755
--- a/tests/generic/067
+++ b/tests/generic/067
@@ -34,7 +34,7 @@ mount_nonexistent_mnt()
 {
 	echo "# mount to nonexistent mount point" >>$seqres.full
 	rm -rf $TEST_DIR/nosuchdir
-	_mount $SCRATCH_DEV $TEST_DIR/nosuchdir >>$seqres.full 2>&1
+	_mount_fstyp $SCRATCH_DEV $TEST_DIR/nosuchdir >>$seqres.full 2>&1
 }
 
 # fs driver should be able to handle mounting a free loop device gracefully xfs
@@ -47,7 +47,7 @@ mount_free_loopdev()
 {
 	echo "# mount a free loop device" >>$seqres.full
 	loopdev=`losetup -f`
-	_mount $loopdev $SCRATCH_MNT >>$seqres.full 2>&1
+	_mount_fstyp $loopdev $SCRATCH_MNT >>$seqres.full 2>&1
 	_unmount $SCRATCH_MNT >> /dev/null 2>&1
 }
 
diff --git a/tests/generic/081 b/tests/generic/081
index 00280e9cff3be0..eec6bcacba683b 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -86,7 +86,7 @@ _mkfs_dev /dev/mapper/$vgname-$lvname
 $LVM_PROG lvcreate -s -L 4M -n $snapname $vgname/$lvname >>$seqres.full 2>&1 || \
 	_fail "Failed to create snapshot"
 
-_mount /dev/mapper/$vgname-$snapname $mnt
+_mount_fstyp /dev/mapper/$vgname-$snapname $mnt
 
 # write 5M data to the snapshot
 $XFS_IO_PROG -fc "pwrite 0 5m" -c fsync $mnt/testfile >>$seqres.full 2>&1
diff --git a/tests/generic/085 b/tests/generic/085
index d3fa10be9ccace..03501a46892b31 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -71,7 +71,7 @@ for ((i=0; i<100; i++)); do
 done &
 pid=$!
 for ((i=0; i<100; i++)); do
-	_mount $lvdev $SCRATCH_MNT >> $seqres.full 2>&1
+	_mount_fstyp $lvdev $SCRATCH_MNT >> $seqres.full 2>&1
 	_unmount $lvdev >> $seqres.full 2>&1
 done &
 pid="$pid $!"
diff --git a/tests/generic/108 b/tests/generic/108
index 4f86ec946511c3..db8309db3fad3c 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -67,7 +67,7 @@ _udev_wait /dev/mapper/$vgname-$lvname
 # above vgcreate/lvcreate operations
 _mkfs_dev /dev/mapper/$vgname-$lvname
 
-_mount /dev/mapper/$vgname-$lvname $SCRATCH_MNT
+_mount_fstyp /dev/mapper/$vgname-$lvname $SCRATCH_MNT
 
 # create a test file with contiguous blocks which will span across the 2 disks
 $XFS_IO_PROG -f -c "pwrite 0 16M" -c fsync $SCRATCH_MNT/testfile >>$seqres.full
diff --git a/tests/generic/361 b/tests/generic/361
index 70dba3a0ca8b75..80517564be86be 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -43,7 +43,7 @@ mkdir -p $fs_mnt
 # mount loop device and create a larger file to hit I/O errors on loop device
 loop_dev=$(_create_loop_device $fs_img)
 _mkfs_dev $loop_dev
-_mount -t $FSTYP $loop_dev $fs_mnt
+_mount_fstyp $loop_dev $fs_mnt
 if [ "$FSTYP" = "xfs" ]; then
 	# Turn off all XFS metadata IO error retries
 	dname=$(_short_dev $loop_dev)
diff --git a/tests/generic/459 b/tests/generic/459
index 48520f9f4af0ca..32f13b24e49f31 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -113,7 +113,7 @@ _udev_wait /dev/mapper/$vgname-$snapname
 
 # Catch mount failure so we don't blindly go an freeze the root filesystem
 # instead of lvm volume.
-_mount /dev/mapper/$vgname-$snapname $SCRATCH_MNT || _fail "mount failed"
+_mount_fstyp /dev/mapper/$vgname-$snapname $SCRATCH_MNT || _fail "mount failed"
 
 # Consume all space available in the volume and freeze to ensure everything
 # required to make the fs consistent is flushed to disk.
diff --git a/tests/generic/563 b/tests/generic/563
index c3705c2f90d4db..1246226d9430ce 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -85,7 +85,7 @@ reset()
 	$XFS_IO_PROG -fc "pwrite 0 $iosize" $SCRATCH_MNT/file \
 		>> $seqres.full 2>&1
 	_unmount $SCRATCH_MNT || _fail "umount failed"
-	_mount $loop_dev $SCRATCH_MNT || _fail "mount failed"
+	_mount_fstyp $loop_dev $SCRATCH_MNT || _fail "mount failed"
 	stat $SCRATCH_MNT/file > /dev/null
 }
 
@@ -99,9 +99,9 @@ _mkfs_dev $loop_dev >> $seqres.full 2>&1
 if [ $FSTYP = "xfs" ]; then
 	# Writes to the quota file are captured in cgroup metrics on XFS, so
 	# we require that quota is not enabled at all.
-	_mount $loop_dev -o noquota $SCRATCH_MNT || _fail "mount failed"
+	_mount_fstyp $loop_dev -o noquota $SCRATCH_MNT || _fail "mount failed"
 else
-	_mount $loop_dev $SCRATCH_MNT || _fail "mount failed"
+	_mount_fstyp $loop_dev $SCRATCH_MNT || _fail "mount failed"
 fi
 
 blksize=$(_get_block_size "$SCRATCH_MNT")
diff --git a/tests/generic/620 b/tests/generic/620
index 3f1ce45a55fd1d..c31f5be184985f 100755
--- a/tests/generic/620
+++ b/tests/generic/620
@@ -42,7 +42,7 @@ chunk_size=128
 
 _dmhugedisk_init $sectors $chunk_size
 _mkfs_dev $DMHUGEDISK_DEV
-_mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
+_mount_fstyp $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
 testfile=$SCRATCH_MNT/testfile-$seq
 
 $XFS_IO_PROG -fc "pwrite -S 0xaa 0 1m" -c "fsync" $testfile | _filter_xfs_io
diff --git a/tests/generic/648 b/tests/generic/648
index 7473c9d337464c..ef8d2463b5fe5a 100755
--- a/tests/generic/648
+++ b/tests/generic/648
@@ -73,7 +73,7 @@ while _soak_loop_running $((25 * TIME_FACTOR)); do
 	touch $scratch_aliveflag
 	snap_loop_fs >> $seqres.full 2>&1 &
 
-	if ! _mount $loopimg $loopmnt -o loop; then
+	if ! _mount_fstyp $loopimg $loopmnt -o loop; then
 		rm -f $scratch_aliveflag
 		_metadump_dev $loopimg $seqres.loop.$i.md
 		_fail "iteration $SOAK_LOOPIDX loopimg mount failed"
@@ -127,7 +127,7 @@ done
 
 # Make sure the fs image file is ok
 if [ -f "$loopimg" ]; then
-	if _mount $loopimg $loopmnt -o loop; then
+	if _mount_fstyp $loopimg $loopmnt -o loop; then
 		_unmount $loopmnt &> /dev/null
 	else
 		_metadump_dev $DMERROR_DEV $seqres.scratch.final.md
diff --git a/tests/generic/704 b/tests/generic/704
index f2360c42e40dd1..7bdc92d6fcc51c 100755
--- a/tests/generic/704
+++ b/tests/generic/704
@@ -40,7 +40,7 @@ _mkfs_dev $SCSI_DEBUG_DEV || _fail "Can't make $FSTYP on scsi_debug device"
 SCSI_DEBUG_MNT="$TEST_DIR/scsi_debug_$seq"
 rm -rf $SCSI_DEBUG_MNT
 mkdir $SCSI_DEBUG_MNT
-run_check _mount $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
+run_check _mount_fstyp $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
 
 echo "DIO read/write 512 bytes"
 # This dio write should succeed, even the physical sector size is 4096, but
diff --git a/tests/generic/730 b/tests/generic/730
index 6b5d319675f741..fb86be4ce72ecd 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -37,7 +37,7 @@ run_check _mkfs_dev $SCSI_DEBUG_DEV
 SCSI_DEBUG_MNT="$TEST_DIR/scsi_debug_$seq"
 rm -rf $SCSI_DEBUG_MNT
 mkdir $SCSI_DEBUG_MNT
-run_check _mount $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
+run_check _mount_fstyp $SCSI_DEBUG_DEV $SCSI_DEBUG_MNT
 
 # create a test file
 $XFS_IO_PROG -f -c "pwrite 0 1M" $SCSI_DEBUG_MNT/testfile >>$seqres.full
diff --git a/tests/generic/741 b/tests/generic/741
index c15dc4345b7a34..8f24bf5a52c79c 100755
--- a/tests/generic/741
+++ b/tests/generic/741
@@ -36,6 +36,10 @@ _require_dm_target flakey
 [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 2f1aeab9fca1 \
 			"btrfs: return accurate error code on open failure"
 
+if [[ "$FSTYP" =~ fuse* ]]; then
+	_notrun "fuse filesystems have their own mount error strings"
+fi
+
 _scratch_mkfs >> $seqres.full
 _init_flakey
 _mount_flakey
@@ -46,12 +50,12 @@ mkdir -p $extra_mnt
 
 # Mount must fail because the physical device has a dm created on it.
 # Filters alter the return code of the mount.
-_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
+_mount_fstyp $SCRATCH_DEV $extra_mnt 2>&1 | \
 			_filter_testdir_and_scratch | _filter_error_mount
 
 # Try again with flakey unmounted, must fail.
 _unmount_flakey
-_mount $SCRATCH_DEV $extra_mnt 2>&1 | \
+_mount_fstyp $SCRATCH_DEV $extra_mnt 2>&1 | \
 			_filter_testdir_and_scratch | _filter_error_mount
 
 # Removing dm should make mount successful.
diff --git a/tests/generic/744 b/tests/generic/744
index cda10e0f66bafb..73eec4e1f2e136 100755
--- a/tests/generic/744
+++ b/tests/generic/744
@@ -40,7 +40,7 @@ clone_filesystem()
 
 	_mkfs_dev $dev1
 
-	_mount $dev1 $mnt1
+	_mount_fstyp $dev1 $mnt1
 	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo >> $seqres.full
 	_unmount $mnt1
 
@@ -66,11 +66,11 @@ loop_dev2=$(_create_loop_device "$loop_file2")
 clone_filesystem ${loop_dev1} ${loop_dev2}
 
 # Mounting original device
-_mount $loop_dev1 $mnt1
+_mount_fstyp $loop_dev1 $mnt1
 $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $mnt1/foo | _filter_xfs_io
 
 # Mounting cloned device
-_mount $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
+_mount_fstyp $loop_dev2 $mnt2 || _fail "mount of cloned device failed"
 
 # cp reflink across two different filesystems must fail
 _cp_reflink $mnt1/foo $mnt2/bar 2>&1 | _filter_test_dir
diff --git a/tests/generic/746 b/tests/generic/746
index aa9282c66ebe06..9f990861d51c83 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -59,7 +59,7 @@ get_holes()
 	# and not the loop device like everything else
 	$XFS_IO_PROG -F -c fiemap $img_file | grep hole | \
 		$SED_PROG 's/.*\[\(.*\)\.\.\(.*\)\].*/\1 \2/'
-	_mount $loop_dev $loop_mnt
+	_mount_fstyp $loop_dev $loop_mnt
 }
 
 get_free_sectors()
@@ -160,7 +160,7 @@ mkdir $loop_mnt
 [ "$FSTYP" = "btrfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -f -dsingle -msingle"
 
 _mkfs_dev $loop_dev
-_mount $loop_dev $loop_mnt
+_mount_fstyp $loop_dev $loop_mnt
 
 echo -n "Generating garbage on loop..."
 # Goal is to fill it up, ignore any errors.
diff --git a/tests/xfs/014 b/tests/xfs/014
index 39ea40e2a3882a..de1eed5a9b7b17 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -170,7 +170,7 @@ $MKFS_XFS_PROG -d "file=1,name=$LOOP_FILE,size=10g" >> $seqres.full 2>&1
 loop_dev=$(_create_loop_device $LOOP_FILE)
 
 mkdir -p $LOOP_MNT
-_mount -o uquota,gquota $loop_dev $LOOP_MNT || \
+_mount_fstyp -o uquota,gquota $loop_dev $LOOP_MNT || \
 	_fail "Failed to mount loop fs."
 
 _test_enospc $LOOP_MNT
diff --git a/tests/xfs/049 b/tests/xfs/049
index 5fc64c189bfd9a..46ed3ffc67c2a2 100755
--- a/tests/xfs/049
+++ b/tests/xfs/049
@@ -68,7 +68,7 @@ mkdir $SCRATCH_MNT/test $SCRATCH_MNT/test2 >> $seqres.full 2>&1 \
 
 _log "Mount xfs via loop"
 loop_dev1=$(_create_loop_device $SCRATCH_MNT/test.xfs)
-_mount $loop_dev1 $SCRATCH_MNT/test >> $seqres.full 2>&1 \
+_mount_fstyp $loop_dev1 $SCRATCH_MNT/test >> $seqres.full 2>&1 \
     || _fail "!!! failed to loop mount xfs"
 
 _log "stress"
diff --git a/tests/xfs/073 b/tests/xfs/073
index 2274079ef43b13..2a44525238a10f 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -68,10 +68,10 @@ _verify_copy()
 	mkdir $target_dir
 
 	loop_dev1=$(_create_loop_device $target)
-	_mount $loop_dev1 $target_dir 2>/dev/null
+	_mount_fstyp $loop_dev1 $target_dir 2>/dev/null
 	if [ $? -ne 0 ]; then
 		echo retrying mount with nouuid option >>$seqres.full
-		_mount -o nouuid $loop_dev1 $target_dir
+		_mount_fstyp -o nouuid $loop_dev1 $target_dir
 		if [ $? -ne 0 ]; then
 			echo mount failed - evil!
 			return
@@ -140,9 +140,9 @@ rmdir $imgs.source_dir 2>/dev/null
 mkdir $imgs.source_dir
 
 loop_dev2=$(_create_loop_device $imgs.source)
-_mount $loop_dev2 $imgs.source_dir
+_mount_fstyp $loop_dev2 $imgs.source_dir
 cp -a $here $imgs.source_dir
-_mount -o remount,ro $loop_dev2 $imgs.source_dir
+_mount_fstyp -o remount,ro $loop_dev2 $imgs.source_dir
 $XFS_COPY_PROG $loop_dev2 $imgs.image 2> /dev/null | _filter_copy '#' $imgs.image '#' '#'
 _verify_copy $imgs.image $imgs.source $imgs.source_dir
 
diff --git a/tests/xfs/074 b/tests/xfs/074
index 5df864fad3b16a..b6290fe2472f12 100755
--- a/tests/xfs/074
+++ b/tests/xfs/074
@@ -48,7 +48,7 @@ $XFS_IO_PROG -ft -c "truncate 1t" $LOOP_FILE >> $seqres.full
 loop_dev=`_create_loop_device $LOOP_FILE`
 
 _mkfs_dev -d size=260g,agcount=2 $loop_dev
-_mount $loop_dev $LOOP_MNT
+_mount_fstyp $loop_dev $LOOP_MNT
 
 BLOCK_SIZE=$(_get_file_block_size $LOOP_MNT)
 
@@ -63,7 +63,7 @@ _unmount $LOOP_MNT
 _check_xfs_filesystem $loop_dev none none
 
 _mkfs_dev -f $loop_dev
-_mount $loop_dev $LOOP_MNT
+_mount_fstyp $loop_dev $LOOP_MNT
 
 # check we trim both ends of the extent approproiately; this will fail
 # on 1k block size filesystems without the correct fixes in place.
diff --git a/tests/xfs/078 b/tests/xfs/078
index 6057aeea12abe9..203d0b9aa05d87 100755
--- a/tests/xfs/078
+++ b/tests/xfs/078
@@ -75,7 +75,7 @@ _grow_loop()
 	$XFS_IO_PROG -c "pwrite $new_size $bsize" $LOOP_IMG | _filter_io
 	loop_dev=`_create_loop_device $LOOP_IMG $bsize`
 	echo "*** mount loop filesystem"
-	_mount $loop_dev $LOOP_MNT
+	_mount_fstyp $loop_dev $LOOP_MNT
 
 	echo "*** grow loop filesystem"
 	$XFS_GROWFS_PROG $LOOP_MNT 2>&1 |  _filter_growfs 2>&1
diff --git a/tests/xfs/148 b/tests/xfs/148
index 4d2f7a80855cbb..661c414b7d96f2 100755
--- a/tests/xfs/148
+++ b/tests/xfs/148
@@ -53,7 +53,7 @@ MKFS_OPTIONS="-m crc=0 -i size=512" _mkfs_dev $loop_dev >> $seqres.full
 
 # Mount image file
 mkdir -p $mntpt
-_mount $loop_dev $mntpt
+_mount_fstyp $loop_dev $mntpt
 
 echo "creating entries" >> $seqres.full
 
@@ -102,7 +102,7 @@ test "$(md5sum < $imgfile)" != "$(md5sum < $imgfile.old)" ||
 	_fail "sed failed to change the image file?"
 
 loop_dev=$(_create_loop_device $imgfile)
-_mount $loop_dev $mntpt
+_mount_fstyp $loop_dev $mntpt
 
 # Try to access the corrupt metadata
 echo "++ ACCESSING BAD METADATA" | tee -a $seqres.full
diff --git a/tests/xfs/149 b/tests/xfs/149
index baf6e22b98e289..21f35376e88951 100755
--- a/tests/xfs/149
+++ b/tests/xfs/149
@@ -64,7 +64,7 @@ $XFS_GROWFS_PROG $loop_symlink 2>&1 | sed -e s:$loop_symlink:LOOPSYMLINK:
 # These mounted operations should pass
 
 echo "=== mount ==="
-_mount $loop_dev $mntdir || _fail "!!! failed to loopback mount"
+_mount_fstyp $loop_dev $mntdir || _fail "!!! failed to loopback mount"
 
 echo "=== xfs_growfs - check device node ==="
 $XFS_GROWFS_PROG -D 8192 $loop_dev > /dev/null
@@ -76,7 +76,7 @@ echo "=== unmount ==="
 _unmount $mntdir || _fail "!!! failed to unmount"
 
 echo "=== mount device symlink ==="
-_mount $loop_symlink $mntdir || _fail "!!! failed to loopback mount"
+_mount_fstyp $loop_symlink $mntdir || _fail "!!! failed to loopback mount"
 
 echo "=== xfs_growfs - check device symlink ==="
 $XFS_GROWFS_PROG -D 16384 $loop_symlink > /dev/null
diff --git a/tests/xfs/206 b/tests/xfs/206
index a515c6c8838cff..6e82c06e1ce10f 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -75,7 +75,7 @@ echo "=== mkfs.xfs ==="
 mkfs.xfs -f -bsize=4096 -l size=32m -dagsize=76288719b,size=3905982455b \
 	 $tmpfile  | mkfs_filter
 
-_mount -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
+_mount_fstyp -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
 
 # see what happens when we growfs it
 echo "=== xfs_growfs ==="
diff --git a/tests/xfs/216 b/tests/xfs/216
index 091c11d0864247..21a68317783f65 100755
--- a/tests/xfs/216
+++ b/tests/xfs/216
@@ -57,7 +57,7 @@ _do_mkfs()
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
 			-d size=${i}g $loop_mkfs_opts $loop_dev |grep log
-		_mount $loop_dev $LOOP_MNT
+		_mount_fstyp $loop_dev $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
 		_unmount $LOOP_MNT > /dev/null 2>&1
 	done
diff --git a/tests/xfs/217 b/tests/xfs/217
index dae6ce55f475df..6378b62413b0fb 100755
--- a/tests/xfs/217
+++ b/tests/xfs/217
@@ -35,7 +35,7 @@ _do_mkfs()
 		echo -n "fssize=${i}g "
 		$MKFS_XFS_PROG -f -b size=4096 -l version=2 \
 			-d size=${i}g $loop_dev |grep log
-		_mount $loop_dev $LOOP_MNT
+		_mount_fstyp $loop_dev $LOOP_MNT
 		echo "test write" > $LOOP_MNT/test
 		_unmount $LOOP_MNT > /dev/null 2>&1
 
diff --git a/tests/xfs/250 b/tests/xfs/250
index 0c3f6f075c1cb2..7023d99777cc4d 100755
--- a/tests/xfs/250
+++ b/tests/xfs/250
@@ -57,7 +57,7 @@ _test_loop()
 
 	echo "*** mount loop filesystem"
 	loop_dev=$(_create_loop_device $LOOP_IMG)
-	_mount $loop_dev $LOOP_MNT
+	_mount_fstyp $loop_dev $LOOP_MNT
 
 	echo "*** preallocate large file"
 	$XFS_IO_PROG -f -c "resvsp 0 $fsize" $LOOP_MNT/foo | _filter_io
diff --git a/tests/xfs/289 b/tests/xfs/289
index c2216f2826a9d1..9ef1bbcc27274f 100755
--- a/tests/xfs/289
+++ b/tests/xfs/289
@@ -56,7 +56,7 @@ echo "=== xfs_growfs - plain file - should be rejected ==="
 $XFS_GROWFS_PROG $tmpfile 2>&1 | _filter_test_dir
 
 echo "=== mount ==="
-_mount -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
+_mount_fstyp -o loop $tmpfile $tmpdir || _fail "!!! failed to loopback mount"
 
 echo "=== xfs_growfs - mounted - check absolute path ==="
 $XFS_GROWFS_PROG -D 8192 $tmpdir | _filter_test_dir > /dev/null
diff --git a/tests/xfs/507 b/tests/xfs/507
index e1450f4f8f9495..0b5ed8d653eb51 100755
--- a/tests/xfs/507
+++ b/tests/xfs/507
@@ -86,7 +86,7 @@ loop_dev=$(_create_loop_device $loop_file)
 
 _mkfs_dev -d cowextsize=$MAXEXTLEN -l size=256m $loop_dev >> $seqres.full
 mkdir $loop_mount
-_mount $loop_dev $loop_mount
+_mount_fstyp $loop_dev $loop_mount
 
 echo "Create crazy huge file"
 huge_file="$loop_mount/a"
diff --git a/tests/xfs/513 b/tests/xfs/513
index 7dbd2626d9e2eb..c775cac667e196 100755
--- a/tests/xfs/513
+++ b/tests/xfs/513
@@ -99,7 +99,7 @@ _do_test()
 	local info
 
 	# mount test
-	_mount $loop_dev $LOOP_MNT $opts 2>>$seqres.full
+	_mount_fstyp $loop_dev $LOOP_MNT $opts 2>>$seqres.full
 	rc=$?
 	if [ $rc -eq 0 ];then
 		if [ "${mounted}" = "fail" ];then
diff --git a/tests/xfs/606 b/tests/xfs/606
index b537ea145f3d61..99f433164157ce 100755
--- a/tests/xfs/606
+++ b/tests/xfs/606
@@ -40,7 +40,7 @@ $MKFS_XFS_PROG -f $LOOP_IMG >$seqres.full
 $XFS_IO_PROG -f -c "truncate 1073750016" $LOOP_IMG
 
 loop_dev=$(_create_loop_device $LOOP_IMG)
-_mount $loop_dev $LOOP_MNT
+_mount_fstyp $loop_dev $LOOP_MNT
 # A known bug shows "XFS_IOC_FSGROWFSDATA xfsctl failed: No space left on
 # device" at here, refer to _fixed_by_kernel_commit above
 $XFS_GROWFS_PROG $LOOP_MNT >$seqres.full
diff --git a/tests/xfs/613 b/tests/xfs/613
index c26a4424f4866e..ae9c99cc8ad2c0 100755
--- a/tests/xfs/613
+++ b/tests/xfs/613
@@ -93,7 +93,7 @@ _do_test()
 	local info
 
 	# mount test
-	_mount $loop_dev $LOOP_MNT $opts 2>>$seqres.full
+	_mount_fstyp $loop_dev $LOOP_MNT $opts 2>>$seqres.full
 	rc=$?
 	if [ $rc -eq 0 ];then
 		if [ "${mounted}" = "fail" ];then
diff --git a/tests/xfs/806 b/tests/xfs/806
index 09c55332cc8800..4d05fda0c2d973 100755
--- a/tests/xfs/806
+++ b/tests/xfs/806
@@ -42,7 +42,7 @@ testme() {
 	$MKFS_XFS_PROG "${mkfs_args[@]}" $dummyfile >> $seqres.full || \
 		echo "mkfs.xfs ${mkfs_args[*]} failed?"
 
-	_mount -o loop $dummyfile $dummymnt
+	_mount_fstyp -o loop $dummyfile $dummymnt
 	XFS_SCRUB_PHASE=7 $XFS_SCRUB_PROG -d -o autofsck $dummymnt 2>&1 | \
 		grep autofsck | _filter_test_dir | \
 		sed -e 's/\(directive.\).*$/\1/g'


