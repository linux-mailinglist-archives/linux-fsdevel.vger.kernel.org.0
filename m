Return-Path: <linux-fsdevel+bounces-18295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC388B6923
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE33B21DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A0F11733;
	Tue, 30 Apr 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byrrU24b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5510965;
	Tue, 30 Apr 2024 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448464; cv=none; b=rV2knmKDisbrmXQwpcVMra4dUTZ6ZUNujRTTBn2YOPNIwNJbZlNRl9cG2kVVm8dqLWUnJmJp8de53GNgkqcXWFsKNnbcec2Rt9GjPbl/mFFkwYaGYboq0IAL1klHfrsbYeiWRBsKKk7uQnQR9MjzwwS/d2w8OAiPf7J85H/3KfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448464; c=relaxed/simple;
	bh=iIsxbFH63ITqGDeXQxaMqJbJnq0+YrKoGIQSE3YOw+Y=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlIk+8HKwzoV5NWD5lG7GwbAYB1nb35OB5tA2XFuvcNK3yvA+NiqrlYrHA7jA/Jmlw+uTp68726fJWP1UEMqUy95kUC5+uYBGA4gK7cS/HrIA8+fjrs40XTn1A5/3iow5QJ3doSs7HFAVN/ZRoFe9TPUgxaDzN8kMe9PmG/iH6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byrrU24b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA1AC116B1;
	Tue, 30 Apr 2024 03:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448463;
	bh=iIsxbFH63ITqGDeXQxaMqJbJnq0+YrKoGIQSE3YOw+Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=byrrU24bOYKeONrglv2pPtHp8NOopZqAOAY0fhBu4Tz9LsRglo2a4c/FkFxAFG/Js
	 mfp/eIS//m6MqlgNNN57frvDY4C0JVi/tbNCC5KfpvWwRqtRgMV05VMlyKqfRsMzMV
	 rFUD6UVgJk3U4RoaBCDaS1GttUGwWazM0QoJoj2LOR/UgxKGJ1UkdAetVe/Kfjpczl
	 eOgFttYU0AlvnMWvkyfc3fFf75a0XvsmUjG827TJHKLvrW9u1peztZdX7vPtwdCheY
	 EFy00BqbYL2RtWb614VpOb/HQsE6vlf8fSNLNa+RgkgaT0NfJpc570xImONWvnpsaj
	 gxgmqoWsNMzxQ==
Date: Mon, 29 Apr 2024 20:41:03 -0700
Subject: [PATCH 1/6] common/verity: enable fsverity for XFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, zlang@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org
Cc: Andrey Albershteyn <andrey.albershteyn@gmail.com>,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <171444687994.962488.5112127418406573234.stgit@frogsfrogsfrogs>
In-Reply-To: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

XFS supports verity and can be enabled for -g verity group.

Signed-off-by: Andrey Albershteyn <andrey.albershteyn@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/verity |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)


diff --git a/common/verity b/common/verity
index 59b67e1201..20408c8c0e 100644
--- a/common/verity
+++ b/common/verity
@@ -43,7 +43,16 @@ _require_scratch_verity()
 
 	# The filesystem may be aware of fs-verity but have it disabled by
 	# CONFIG_FS_VERITY=n.  Detect support via sysfs.
-	if [ ! -e /sys/fs/$fstyp/features/verity ]; then
+	case $FSTYP in
+	xfs)
+		_scratch_unmount
+		_check_scratch_xfs_features VERITY &>>$seqres.full
+		_scratch_mount
+	;;
+	*)
+		test -e /sys/fs/$fstyp/features/verity
+	esac
+	if [ ! $? ]; then
 		_notrun "kernel $fstyp isn't configured with verity support"
 	fi
 
@@ -201,6 +210,9 @@ _scratch_mkfs_verity()
 	ext4|f2fs)
 		_scratch_mkfs -O verity
 		;;
+	xfs)
+		_scratch_mkfs -i verity
+		;;
 	btrfs)
 		_scratch_mkfs
 		;;
@@ -334,12 +346,19 @@ _fsv_scratch_corrupt_bytes()
 	local lstart lend pstart pend
 	local dd_cmds=()
 	local cmd
+	local device=$SCRATCH_DEV
 
 	sync	# Sync to avoid unwritten extents
 
 	cat > $tmp.bytes
 	local end=$(( offset + $(_get_filesize $tmp.bytes ) ))
 
+	# If this is an xfs realtime file, switch @device to the rt device
+	if [ $FSTYP = "xfs" ]; then
+		$XFS_IO_PROG -r -c 'stat -v' "$file" | grep -q -w realtime && \
+			device=$SCRATCH_RTDEV
+	fi
+
 	# For each extent that intersects the requested range in order, add a
 	# command that writes the next part of the data to that extent.
 	while read -r lstart lend pstart pend; do
@@ -355,7 +374,7 @@ _fsv_scratch_corrupt_bytes()
 		elif (( offset < lend )); then
 			local len=$((lend - offset))
 			local seek=$((pstart + (offset - lstart)))
-			dd_cmds+=("head -c $len | dd of=$SCRATCH_DEV oflag=seek_bytes seek=$seek status=none")
+			dd_cmds+=("head -c $len | dd of=$device oflag=seek_bytes seek=$seek status=none")
 			(( offset += len ))
 		fi
 	done < <($XFS_IO_PROG -r -c "fiemap $offset $((end - offset))" "$file" \
@@ -408,6 +427,22 @@ _fsv_scratch_corrupt_merkle_tree()
 		done
 		_scratch_mount
 		;;
+	xfs)
+		local ino=$(stat -c '%i' $file)
+		local attr_offset=$(( $offset % $FSV_BLOCK_SIZE ))
+		local attr_index=$(printf "%08d" $(( offset - attr_offset )))
+		_scratch_unmount
+		# Attribute name is 8 bytes long (byte position of Merkle tree block)
+		_scratch_xfs_db -x -c "inode $ino" \
+			-c "attr_modify -f -m 8 -o $attr_offset $attr_index \"BUG\"" \
+			-c "ablock 0" -c "print" \
+			>>$seqres.full
+		# In case bsize == 4096 and merkle block size == 1024, by
+		# modifying attribute with 'attr_modify we can corrupt quota
+		# account. Let's repair it
+		_scratch_xfs_repair >> $seqres.full 2>&1
+		_scratch_mount
+		;;
 	*)
 		_fail "_fsv_scratch_corrupt_merkle_tree() unimplemented on $FSTYP"
 		;;


