Return-Path: <linux-fsdevel+bounces-66158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE67C17E73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22523B81D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24D2D9ED8;
	Wed, 29 Oct 2025 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HybsuUht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB922097;
	Wed, 29 Oct 2025 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701139; cv=none; b=o0Mm9QdbINGC5Q8fbcDJhctXyHvLcS9KAaiJChH9yug/Ps363lp9IVcfRW1jTUDvTbCXc0b4dqz8dVvUAoshujfwXID5Tv0yQ+i94VwhoflsRIc/1KLjlLSsENetJb7AnhfBoR7TtfuGWMpcdv1VMt9M/uMbcA0M2xqrHZ8iAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701139; c=relaxed/simple;
	bh=FbgnOnjDBcZ1XZOL+0FsyPdjYIE350bjWDmygwOWpao=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQYz2zj/LhswS5JUw8ZS5P0BLWMs/ll+DZy5SLxc9/rN+DP29S6nd0v9RojupvN0lHdCXuFcz5TuOT3WD3dFZMp0i1gzs+bWZ7fl7hqnf9d3RWH726MkVsSdSywshU3w7+SCAlsldGFlrCgbypIRrWPE8fhQDCvB3Z+ClfDu9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HybsuUht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0496C4CEE7;
	Wed, 29 Oct 2025 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701138;
	bh=FbgnOnjDBcZ1XZOL+0FsyPdjYIE350bjWDmygwOWpao=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HybsuUhtO8zUV1gJRj1qrU/oEoILh4CtKWosHnvAzDTLgOdSh8MDCqYASU4OLEzz1
	 k/ChDqaqrp5wb7n96825XAOtQCA2mJHH98GvdrCrBT/AjmF5pBUV/51BT8q4kAMjGm
	 3FzjXLhv7I7bnqVrZfcF5MrWVK2pwjIO4b+yc2pVVicU57yoCpDMdl+Yxok8wXaGQn
	 wRrQw3E5+pOG+aIYgUtrKu8nJWmbv/U8s8ZTShj8y5NYBztT7rVXX3LVXn9LZ4rva4
	 URt02QhJeDrdAbAvyNd4XY2jJ7mChsxlN5wmJEnmN+LJKSkzwkXobarLAVdzt7H0fW
	 DeleA3pgk7YPg==
Date: Tue, 28 Oct 2025 18:25:38 -0700
Subject: [PATCH 20/33] misc: use a larger buffer size for pwrites
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820352.1433624.1023619401305112936.stgit@frogsfrogsfrogs>
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

Use a larger buffer size for pagecache pwrite to reduce the number of
write calls made to the kernel for large writes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc         |    2 +-
 tests/btrfs/139   |    2 +-
 tests/btrfs/193   |    2 +-
 tests/btrfs/259   |    2 +-
 tests/ext4/306    |    4 ++--
 tests/generic/027 |    4 ++--
 tests/generic/286 |    8 ++++----
 tests/generic/323 |    2 +-
 tests/generic/361 |    2 +-
 tests/generic/449 |    2 +-
 tests/generic/511 |    2 +-
 tests/generic/536 |    2 +-
 tests/xfs/014     |    2 +-
 tests/xfs/196     |    2 +-
 tests/xfs/291     |    2 +-
 tests/xfs/423     |    4 ++--
 16 files changed, 22 insertions(+), 22 deletions(-)


diff --git a/common/rc b/common/rc
index 41d717cf473431..f5b10a280adec9 100644
--- a/common/rc
+++ b/common/rc
@@ -157,7 +157,7 @@ _pwrite_byte() {
 	local file="$4"
 	local xfs_io_args="$5"
 
-	$XFS_IO_PROG $xfs_io_args -f -c "pwrite -S $pattern $offset $len" "$file"
+	$XFS_IO_PROG $xfs_io_args -f -c "pwrite -b 1m -S $pattern $offset $len" "$file"
 }
 
 _round_up_to_page_boundary()
diff --git a/tests/btrfs/139 b/tests/btrfs/139
index aa39eea3c4be89..c6593dd9284e30 100755
--- a/tests/btrfs/139
+++ b/tests/btrfs/139
@@ -34,7 +34,7 @@ _btrfs qgroup limit -e 1G $SUBVOL
 # Write and delete files within 1G limits, multiple times
 for i in $(seq 1 5); do
 	for j in $(seq 1 240); do
-		$XFS_IO_PROG -f -c "pwrite 0 4m" $SUBVOL/file_$j > /dev/null
+		$XFS_IO_PROG -f -c "pwrite -b 1m 0 4m" $SUBVOL/file_$j > /dev/null
 	done
 	rm -f $SUBVOL/file*
 done
diff --git a/tests/btrfs/193 b/tests/btrfs/193
index 4326e188b13526..aa4338675f8ccf 100755
--- a/tests/btrfs/193
+++ b/tests/btrfs/193
@@ -40,7 +40,7 @@ rm -f "$SCRATCH_MNT/file"
 sync
 
 # We should be able to write at least 3/4 of the limit
-$XFS_IO_PROG -f -c "pwrite 0 192m" "$SCRATCH_MNT/file" | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -b 1m 0 192m" "$SCRATCH_MNT/file" | _filter_xfs_io
 
 # success, all done
 status=0
diff --git a/tests/btrfs/259 b/tests/btrfs/259
index 41c16e7a33593f..d6368b5bc0f63f 100755
--- a/tests/btrfs/259
+++ b/tests/btrfs/259
@@ -21,7 +21,7 @@ _scratch_mount -o compress
 
 # Btrfs uses 128K as max extent size for compressed extents, this would result
 # several compressed extents all at their max size
-$XFS_IO_PROG -f -c "pwrite -S 0xee 0 16m" -c sync \
+$XFS_IO_PROG -f -c "pwrite -S 0xee -b 1m 0 16m" -c sync \
 	$SCRATCH_MNT/foobar >> $seqres.full
 
 old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
diff --git a/tests/ext4/306 b/tests/ext4/306
index a67722d9555927..f48be993f278eb 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -60,9 +60,9 @@ df -h $SCRATCH_MNT >> $seqres.full
 
 # See if we can add more blocks to the files
 echo "append 2m to testfile1"
-$XFS_IO_PROG -f $SCRATCH_MNT/testfile1 -c "pwrite 1m 2m" | _filter_xfs_io
+$XFS_IO_PROG -f $SCRATCH_MNT/testfile1 -c "pwrite -b 1m 1m 2m" | _filter_xfs_io
 echo "append 2m to testfile2"
-$XFS_IO_PROG -f $SCRATCH_MNT/testfile1 -c "pwrite 512m 2m" | _filter_xfs_io
+$XFS_IO_PROG -f $SCRATCH_MNT/testfile1 -c "pwrite -b 1m 512m 2m" | _filter_xfs_io
 
 status=0
 exit
diff --git a/tests/generic/027 b/tests/generic/027
index b7721dfbae935b..fd1075ffb36d52 100755
--- a/tests/generic/027
+++ b/tests/generic/027
@@ -41,9 +41,9 @@ _scratch_mkfs_sized $((256 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
 echo "Reserve 2M space" >>$seqres.full
-$XFS_IO_PROG -f -c "pwrite 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -b 1m 0 2m" $SCRATCH_MNT/testfile >>$seqres.full 2>&1
 echo "Fulfill the fs" >>$seqres.full
-$XFS_IO_PROG -f -c "pwrite 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -b 1m 0 254m" $SCRATCH_MNT/bigfile >>$seqres.full 2>&1
 echo "Remove reserved file" >>$seqres.full
 rm -f $SCRATCH_MNT/testfile
 
diff --git a/tests/generic/286 b/tests/generic/286
index fe3382f94f991c..e762bb01ff2af9 100755
--- a/tests/generic/286
+++ b/tests/generic/286
@@ -39,7 +39,7 @@ test01()
 	write_cmd="-c \"truncate 100m\""
 	for i in $(seq 0 5 100); do
 		offset=$(($i * $((1 << 20))))
-		write_cmd="$write_cmd -c \"pwrite $offset 1m\""
+		write_cmd="$write_cmd -c \"pwrite -b 1m $offset 1m\""
 	done
 
 	echo "*** test01() create sparse file ***" >>$seqres.full
@@ -67,7 +67,7 @@ test02()
 	write_cmd="-c \"truncate 200m\""
 	for i in $(seq 0 10 100); do
 		offset=$(($((6 << 20)) + $i * $((1 << 20))))
-		write_cmd="$write_cmd -c \"falloc $offset 3m\" -c \"pwrite $offset 1m\""
+		write_cmd="$write_cmd -c \"falloc $offset 3m\" -c \"pwrite -b 1m $offset 1m\""
 	done
 
 	echo "*** test02() create sparse file ***" >>$seqres.full
@@ -110,7 +110,7 @@ test03()
 	# |data|multiple unwritten_without_data|data| repeat...
 	for i in $(seq 0 60 180); do
 		offset=$(($((20 << 20)) + $i * $((1 << 20))))
-		write_cmd="$write_cmd -c \"pwrite $offset 10m\""
+		write_cmd="$write_cmd -c \"pwrite -b 1m $offset 10m\""
 	done
 
 	echo "*** test03() create sparse file ***" >>$seqres.full
@@ -152,7 +152,7 @@ test04()
 	# |hole|multiple unwritten_without_data|hole|data| repeat...
 	for i in $(seq 30 90 180); do
 		offset=$(($((30 << 20)) + $i * $((1 << 20))))
-		write_cmd="$write_cmd -c \"pwrite $offset 2m\""
+		write_cmd="$write_cmd -c \"pwrite -b 1m $offset 2m\""
 	done
 
 	echo "*** test04() create sparse file ***" >>$seqres.full
diff --git a/tests/generic/323 b/tests/generic/323
index 2dde04d064395a..30312fe4bdf8b8 100755
--- a/tests/generic/323
+++ b/tests/generic/323
@@ -21,7 +21,7 @@ _require_test
 _require_aiodio aio-last-ref-held-by-io
 
 testfile=$TEST_DIR/aio-testfile
-$XFS_IO_PROG -ftc "pwrite 0 10m" $testfile | _filter_xfs_io
+$XFS_IO_PROG -ftc "pwrite -b 1m 0 10m" $testfile | _filter_xfs_io
 
 # This can emit cpu affinity setting failures that aren't considered test
 # failures but cause golden image failures. Redirect the test output to
diff --git a/tests/generic/361 b/tests/generic/361
index 80517564be86be..2a299bd3cffeac 100755
--- a/tests/generic/361
+++ b/tests/generic/361
@@ -49,7 +49,7 @@ if [ "$FSTYP" = "xfs" ]; then
 	dname=$(_short_dev $loop_dev)
 	echo 0 | tee /sys/fs/xfs/$dname/error/*/*/* > /dev/null
 fi
-$XFS_IO_PROG -fc "pwrite 0 520m" $fs_mnt/testfile >>$seqres.full 2>&1
+$XFS_IO_PROG -fc "pwrite -b 1m 0 520m" $fs_mnt/testfile >>$seqres.full 2>&1
 
 # remount should not hang
 _mount -o remount,ro $fs_mnt >>$seqres.full 2>&1
diff --git a/tests/generic/449 b/tests/generic/449
index 9cf814ad326c6f..8f3f0e252221a6 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -38,7 +38,7 @@ chmod u+rwx $TFILE
 chmod go-rwx $TFILE
 
 # Try to run out of space so setfacl will fail
-$XFS_IO_PROG -c "pwrite 0 256m" $TFILE >>$seqres.full 2>&1
+$XFS_IO_PROG -c "pwrite -b 1m 0 256m" $TFILE >>$seqres.full 2>&1
 i=1
 
 # Setting acls on an xfs filesystem will succeed even after running out of
diff --git a/tests/generic/511 b/tests/generic/511
index 296859c21f28cc..c2758e830e6611 100755
--- a/tests/generic/511
+++ b/tests/generic/511
@@ -20,7 +20,7 @@ _require_xfs_io_command "fzero"
 _scratch_mkfs_sized $((1024 * 1024 * 256)) >>$seqres.full 2>&1
 _scratch_mount
 
-$XFS_IO_PROG -fc "pwrite 0 256m" -c fsync $SCRATCH_MNT/file >>$seqres.full 2>&1
+$XFS_IO_PROG -fc "pwrite -b 1m 0 256m" -c fsync $SCRATCH_MNT/file >>$seqres.full 2>&1
 rm -f $SCRATCH_MNT/file
 
 cat >> $tmp.fsxops << ENDL
diff --git a/tests/generic/536 b/tests/generic/536
index 726120e67c8e23..5e1bb34b8d7425 100755
--- a/tests/generic/536
+++ b/tests/generic/536
@@ -21,7 +21,7 @@ _require_scratch_shutdown
 # create a small fs and initialize free blocks with a unique pattern
 _scratch_mkfs_sized $((1024 * 1024 * 100)) >> $seqres.full 2>&1
 _scratch_mount
-$XFS_IO_PROG -f -c "pwrite -S 0xab 0 100m" -c fsync $SCRATCH_MNT/spc \
+$XFS_IO_PROG -f -c "pwrite -S 0xab -b 1m 0 100m" -c fsync $SCRATCH_MNT/spc \
 	>> $seqres.full 2>&1
 rm -f $SCRATCH_MNT/spc
 $XFS_IO_PROG -c fsync $SCRATCH_MNT
diff --git a/tests/xfs/014 b/tests/xfs/014
index de1eed5a9b7b17..9b5e95a64c7734 100755
--- a/tests/xfs/014
+++ b/tests/xfs/014
@@ -53,7 +53,7 @@ _spec_prealloc_file()
 
 		# write a 4k aligned amount of data to keep the calculations
 		# simple
-		$XFS_IO_PROG -c "pwrite 0 128m" $file >> $seqres.full
+		$XFS_IO_PROG -c "pwrite -b 1m 0 128m" $file >> $seqres.full
 
 		size=`_get_filesize $file`
 		blocks=`stat -c "%b" $file`
diff --git a/tests/xfs/196 b/tests/xfs/196
index 9535ce6beb99d9..1fd081d8909122 100755
--- a/tests/xfs/196
+++ b/tests/xfs/196
@@ -66,7 +66,7 @@ $XFS_IO_PROG -c 'bmap -vp' $file | _filter_bmap
 # assert failures.
 rm -f $file
 for offset in $(seq 0 100 500); do
-	$XFS_IO_PROG -fc "pwrite ${offset}m 100m" $file >> $seqres.full 2>&1
+	$XFS_IO_PROG -fc "pwrite -b 1m ${offset}m 100m" $file >> $seqres.full 2>&1
 
 	punchoffset=$((offset + 75))
 	_scratch_inject_error "drop_writes"
diff --git a/tests/xfs/291 b/tests/xfs/291
index 1a8cda4efb3357..792d6a730d8d64 100755
--- a/tests/xfs/291
+++ b/tests/xfs/291
@@ -49,7 +49,7 @@ done
 _scratch_sync
 
 # Soak up any remaining freespace
-$XFS_IO_PROG -f -c "pwrite 0 16m" -c "fsync" $SCRATCH_MNT/space_file.large >> $seqres.full 2>&1
+$XFS_IO_PROG -f -c "pwrite -b 1m 0 16m" -c "fsync" $SCRATCH_MNT/space_file.large >> $seqres.full 2>&1
 
 # Take a look at freespace for any post-mortem on the test
 _scratch_unmount
diff --git a/tests/xfs/423 b/tests/xfs/423
index 7c6aeab82e7eb1..dcc06aed77c170 100755
--- a/tests/xfs/423
+++ b/tests/xfs/423
@@ -34,8 +34,8 @@ $here/src/punch-alternating $SCRATCH_MNT/b
 _scratch_sync
 
 echo "Set up delalloc extents"
-$XFS_IO_PROG -c 'pwrite -S 0x66 10m 128k' $SCRATCH_MNT/a >> $seqres.full
-$XFS_IO_PROG -c 'pwrite -S 0x66 10m 128k' $SCRATCH_MNT/b >> $seqres.full
+$XFS_IO_PROG -c 'pwrite -S 0x66 -b 1m 10m 128k' $SCRATCH_MNT/a >> $seqres.full
+$XFS_IO_PROG -c 'pwrite -S 0x66 -b 1m 10m 128k' $SCRATCH_MNT/b >> $seqres.full
 $XFS_IO_PROG -c 'bmap -ev' $SCRATCH_MNT/a $SCRATCH_MNT/b > $SCRATCH_MNT/before
 cat $SCRATCH_MNT/before >> $seqres.full
 


