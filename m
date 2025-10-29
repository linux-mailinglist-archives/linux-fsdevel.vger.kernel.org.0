Return-Path: <linux-fsdevel+bounces-66152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8314CC17E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E56C3AE274
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD592D94B8;
	Wed, 29 Oct 2025 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/PzpVT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259217B50F;
	Wed, 29 Oct 2025 01:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761701046; cv=none; b=hpR33YLzv+0oUAywHBsxrSqmKSjMJLclXSZozPZgp0+j9dq4UZgTsPglzjPtpt9ulZAJ2tKKT4RpqfnjHwmoYD9PFs2k9fM6WJYLGiDtjpiUzWu9+Msrz7XfNaZu1xCQ7iqfMPuadbEqAutC+xPCUe4D/9wNp6fSy2bfjtS6AJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761701046; c=relaxed/simple;
	bh=L7+i8Udo6liVCRRrsquVruDGhNlt7VjA+GpG78w0cOI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VF4TYzX8sLaHHQ2GIs6lbv5wVXMnUVffrkSNA0pn5RtBh2/xHnvwKEYR/3ZDnGXySsOmvaPE3mwlBHqvjV54pfze8i6/ZBXy/BHuK5+Ezc5ggtGqG68Rud5m3ZrL+abCap9bzrBmBeKBTQ+DaDvlQlxWOLSRkcRjxUvb1/WqP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/PzpVT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A143C4CEE7;
	Wed, 29 Oct 2025 01:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761701045;
	bh=L7+i8Udo6liVCRRrsquVruDGhNlt7VjA+GpG78w0cOI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c/PzpVT9krq7IOmp5obp02yXf/+K8pH/cg+83uNw0n0t7vwA2ZTil0incaAZ1intk
	 oxrE2NsT2nK7I0W3nGTDLmjlYthBj1cgocBdBWnKEEbXHANDXlrrJh3OTq4oTeaY9Q
	 3xEnYLPN4VXoIja+ZY3AvlyEMKc8mOP/3E54i+LujTaOE6lfvus01EG+ZNMMKpcxhv
	 gU7rtB+1le16DMCvInUAPzjmS0FaHXxhpfHbdo5NfIeOEjuTG2HD1wTdN1mKj1lOrx
	 BZ5c1jOH8VAVv/yxnEZ7tIU7jynB2WK7wPQftD9WqpElzx55jyGTR9+QqLzqHGC2nZ
	 BlH+9YDXdI5wg==
Date: Tue, 28 Oct 2025 18:24:04 -0700
Subject: [PATCH 14/33] misc: explicitly require online resize support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: neal@gompa.dev, fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com
Message-ID: <176169820240.1433624.17582688231918708071.stgit@frogsfrogsfrogs>
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

Create a new helper function to skip tests on setups where online resize
is not supported.  fuse2fs does not support this, whereas Linux ext4
does, so we need some means to distinguish.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 common/rc      |    8 ++++++++
 tests/ext4/032 |    4 ++--
 tests/ext4/033 |    5 +++++
 tests/ext4/035 |    2 +-
 tests/ext4/059 |    2 +-
 tests/ext4/060 |    2 +-
 tests/ext4/306 |    1 +
 tests/xfs/606  |    2 +-
 tests/xfs/609  |    2 +-
 tests/xfs/610  |    2 +-
 10 files changed, 22 insertions(+), 8 deletions(-)


diff --git a/common/rc b/common/rc
index ce406e104beae9..41d717cf473431 100644
--- a/common/rc
+++ b/common/rc
@@ -6129,6 +6129,14 @@ __require_fio_version() {
 	esac
 }
 
+_require_scratch_online_resize() {
+	case "$FSTYP" in
+	ext[234])	_require_command "$RESIZE2FS_PROG" resize2fs;;
+	xfs)		_require_command "$XFS_GROWFS_PROG" xfs_growfs;;
+	*)		_notrun "$FSTYP: does not support online resize";;
+	esac
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
diff --git a/tests/ext4/032 b/tests/ext4/032
index 9a7cd552e195cd..5dce949a1a7327 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -56,7 +56,7 @@ ext4_online_resize()
 	$RESIZE2FS_PROG -f ${LOOP_DEVICE} $final_size >$tmp.resize2fs 2>&1
 	if [ $? -ne 0 ]; then
 		if [ $check_if_supported -eq 1 ]; then
-			grep -iq "operation not supported" $tmp.resize2fs \
+			grep -E -i -q "(operation not supported|Kernel does not support online resizing)" $tmp.resize2fs \
 				&& _notrun "online resizing not supported with bigalloc"
 		fi
 		_fail "resize failed"
@@ -91,7 +91,7 @@ _require_scratch
 # We use resize_inode to make sure that block group descriptor table
 # can be extended.
 _require_scratch_ext4_feature "bigalloc,resize_inode"
-_require_command "$RESIZE2FS_PROG" resize2fs
+_require_scratch_online_resize
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
diff --git a/tests/ext4/033 b/tests/ext4/033
index d62210b0c183c0..fbcc01b329f66b 100755
--- a/tests/ext4/033
+++ b/tests/ext4/033
@@ -27,6 +27,11 @@ _cleanup()
 _exclude_fs ext2
 _exclude_fs ext3
 
+# no online resize support in fuse2fs
+_exclude_fs fuse.ext4
+_exclude_fs fuse.ext3
+_exclude_fs fuse.ext2
+
 _require_scratch_nocheck
 _require_dmhugedisk
 _require_dumpe2fs
diff --git a/tests/ext4/035 b/tests/ext4/035
index 3f4f13817e8746..4403138cba1da6 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -23,7 +23,7 @@ _exclude_fs ext2
 _exclude_fs ext3
 _require_scratch
 _exclude_scratch_mount_option dax
-_require_command "$RESIZE2FS_PROG" resize2fs
+_require_scratch_online_resize
 
 encrypt=
 if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
diff --git a/tests/ext4/059 b/tests/ext4/059
index 7ea7ff92744d11..e359e8b2bdfd30 100755
--- a/tests/ext4/059
+++ b/tests/ext4/059
@@ -17,7 +17,7 @@ _exclude_fs ext3
 _fixed_by_kernel_commit b55c3cd102a6 \
 	"ext4: add reserved GDT blocks check"
 
-_require_command "$RESIZE2FS_PROG" resize2fs
+_require_scratch_online_resize
 _require_command "$DEBUGFS_PROG" debugfs
 _require_scratch_size_nocheck $((1024 * 1024))
 
diff --git a/tests/ext4/060 b/tests/ext4/060
index 565f86014adb69..c61e1a8bfaebdb 100755
--- a/tests/ext4/060
+++ b/tests/ext4/060
@@ -24,7 +24,7 @@ fi
 _fixed_by_kernel_commit a6b3bfe176e8 \
 	"ext4: fix corruption during on-line resize"
 
-_require_command "$RESIZE2FS_PROG" resize2fs
+_require_scratch_online_resize
 _require_command "$E2FSCK_PROG" e2fsck
 _require_scratch_size_nocheck $((9* 1024 * 1024))
 
diff --git a/tests/ext4/306 b/tests/ext4/306
index 5717ec1606cc59..a67722d9555927 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -26,6 +26,7 @@ _exclude_fs ext2
 _exclude_fs ext3
 
 _require_scratch
+_require_scratch_online_resize
 _require_command "$RESIZE2FS_PROG" resize2fs
 
 # Make a small ext4 fs with extents disabled & mount it
diff --git a/tests/xfs/606 b/tests/xfs/606
index 99f433164157ce..e58e99b107a8c7 100755
--- a/tests/xfs/606
+++ b/tests/xfs/606
@@ -25,7 +25,7 @@ _fixed_by_kernel_commit 84712492e6da \
 _require_test
 _require_loop
 _require_xfs_io_command "truncate"
-_require_command "$XFS_GROWFS_PROG" xfs_growfs
+_require_scratch_online_resize
 
 LOOP_IMG=$TEST_DIR/$seq.dev
 LOOP_MNT=$TEST_DIR/$seq.mnt
diff --git a/tests/xfs/609 b/tests/xfs/609
index 88dc3c683172c4..cced409e390328 100755
--- a/tests/xfs/609
+++ b/tests/xfs/609
@@ -23,7 +23,7 @@ _stress_scratch()
 }
 
 _require_scratch
-_require_command "$XFS_GROWFS_PROG" xfs_growfs
+_require_scratch_online_resize
 
 _scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 . $tmp.mkfs	# extract blocksize and data size for scratch device
diff --git a/tests/xfs/610 b/tests/xfs/610
index 8610b912c2a61e..f429b1f6802984 100755
--- a/tests/xfs/610
+++ b/tests/xfs/610
@@ -24,7 +24,7 @@ _stress_scratch()
 
 _require_scratch
 _require_realtime
-_require_command "$XFS_GROWFS_PROG" xfs_growfs
+_require_scratch_online_resize
 
 _scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 . $tmp.mkfs	# extract blocksize and data size for scratch device


