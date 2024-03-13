Return-Path: <linux-fsdevel+bounces-14334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B74A187B1D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 20:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4F3B24BF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7214405B;
	Wed, 13 Mar 2024 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma9f8UYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC358AB8;
	Wed, 13 Mar 2024 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352543; cv=none; b=IC5SdNzj8v2NW+UY8waV8EkVfbX6L6b+SW/OhfnzI4gPMvQalyjaXIsOvk6ElLrWoVRN4XEXnBp16AIfd7TlHH0a/Lm0q0CB+KtmVJ8GYYh+rcNnFGdZd/67XNIjOmJ6+kwBXkhqyQQVYJE0YdMIyPVE5bRaCcx+py5tMB85XBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352543; c=relaxed/simple;
	bh=RWvS6hYxLBMDy+8cpkZisjZ45FWaV2WRXSY+F3T1zmE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kafRXGfMPykSwSgRV4N9yvnGByW3U8VeqfpcI/cjydc04wi+gTLswmvGMIrfDCGP+Zz+Mp0dx3+EbaUf6r60BTghMbnuG9OYnmpCCUUAF1QZMvxAs/IxRmbJ5gh9yUwbOptefkGT5+MPhFVQyyrifoU6DqpiKBLyf6Ijl3hCGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma9f8UYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4694C433F1;
	Wed, 13 Mar 2024 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352542;
	bh=RWvS6hYxLBMDy+8cpkZisjZ45FWaV2WRXSY+F3T1zmE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ma9f8UYjbM2p5OIKh/5OmQn5uoCCqw/1W4xM7Ia5xB1JZOlDt/8F9pQ99o8LftnBO
	 e+kOG50jhnIGE76FRoiSZEKdqIEiaWqC9hS4sN0DSco6WhUL54Ai/SCbl8viOb14WD
	 HnTzuRxuceLnwwxZPzV2XHKlDFpRNDzayKJgK52SM6vBz+FwA9EmcQWlmtXKQExBod
	 pNZsAUoPjh3QyDhirlie7wfxSNe29qge3kpKuXNqdYcvvdnAtkYQefds5joh5qyeCK
	 DPqTRqOBJmNe65T8vzZQGyMZ4wyQSMX5lKw4S+R5vbEEA0hf6oPpCqNjyOZ4NvfBLY
	 ZIaQaQJOQlg0w==
Date: Wed, 13 Mar 2024 10:55:42 -0700
Subject: [PATCH 12/29] fsverity: pass the new tree size and block size to
 ->begin_enable_verity
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223552.2613863.13214675612130115848.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

When starting up the process of enabling fsverity on a file, pass the
new size of the merkle tree and the merkle tree block size to the fs
implementation.  XFS will want this information later to try to clean
out a failed previous enablement attempt.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/verity.c        |    3 ++-
 fs/ext4/verity.c         |    3 ++-
 fs/f2fs/verity.c         |    3 ++-
 fs/verity/enable.c       |    3 ++-
 include/linux/fsverity.h |    5 ++++-
 5 files changed, 12 insertions(+), 5 deletions(-)


diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 966630523502..c52f32bd43c7 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -579,7 +579,8 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
  *
  * Returns 0 on success, negative error code on failure.
  */
-static int btrfs_begin_enable_verity(struct file *filp)
+static int btrfs_begin_enable_verity(struct file *filp, u64 merkle_tree_size,
+				     unsigned int tree_blocksize)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(filp));
 	struct btrfs_root *root = inode->root;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index da2095a81349..a8ae8c912cb5 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -99,7 +99,8 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 	return 0;
 }
 
-static int ext4_begin_enable_verity(struct file *filp)
+static int ext4_begin_enable_verity(struct file *filp, u64 merkle_tree_size,
+				    unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	const int credits = 2; /* superblock and inode for ext4_orphan_add() */
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index b4461b9f47a3..f6ad6523ce95 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -115,7 +115,8 @@ struct fsverity_descriptor_location {
 	__le64 pos;
 };
 
-static int f2fs_begin_enable_verity(struct file *filp)
+static int f2fs_begin_enable_verity(struct file *filp, u64 merkle_tree_size,
+				    unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	int err;
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 945eba0092ab..496a361c0a81 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -237,7 +237,8 @@ static int enable_verity(struct file *filp,
 	if (IS_VERITY(inode))
 		err = -EEXIST;
 	else
-		err = vops->begin_enable_verity(filp);
+		err = vops->begin_enable_verity(filp, params.tree_size,
+				      params.block_size);
 	inode_unlock(inode);
 	if (err)
 		goto out;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index d12a95623614..c5f3564f2cb8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -80,6 +80,8 @@ struct fsverity_operations {
 	 * Begin enabling verity on the given file.
 	 *
 	 * @filp: a readonly file descriptor for the file
+	 * @merkle_tree_size: total bytes the new Merkle tree will take up
+	 * @tree_blocksize: the new Merkle tree block size
 	 *
 	 * The filesystem must do any needed filesystem-specific preparations
 	 * for enabling verity, e.g. evicting inline data.  It also must return
@@ -89,7 +91,8 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*begin_enable_verity)(struct file *filp);
+	int (*begin_enable_verity)(struct file *filp, u64 merkle_tree_size,
+				   unsigned int tree_blocksize);
 
 	/**
 	 * End enabling verity on the given file.


