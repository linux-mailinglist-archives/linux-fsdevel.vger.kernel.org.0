Return-Path: <linux-fsdevel+bounces-14583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0E087DE5A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12BB21C21109
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF91CD13;
	Sun, 17 Mar 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2qI/u5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474B1CA96;
	Sun, 17 Mar 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692698; cv=none; b=YMpO47E9GGHBCcSwM8Y1TWO4VkSUBHlP/jg8AthqBFeAp09hko5tYg/uNZWwHnnAHyIiNFR/wD7R3ZaQQJZnjuIoxIl2Ea8azwZ9z1di++byH8tjlBMM1ZO4ug0hXXMuYe8FLP/XWbEDUPj0uUmK6gRDX63m2FWUThjXrrVkyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692698; c=relaxed/simple;
	bh=KcBxCsDbbHTMEwAn8JLG5V8IPCr3cER3Edi8B9kP5d4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qqt1ySO+QY0TzntO+mgLXJ8fdJ6AYQRmOg/SM8Gs3m9JclDJPXw5zzBbmxjOSizzZF7ntoxLaqyhGRaiw+srabkZT+x9/vclSs7z05NBaCNnVN+74AHacf3sH75ojLakukM7rR9EaUpaqu1EuK5vjMK/Va+QoTKpoaLD82sZySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2qI/u5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0B4C433C7;
	Sun, 17 Mar 2024 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692698;
	bh=KcBxCsDbbHTMEwAn8JLG5V8IPCr3cER3Edi8B9kP5d4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=p2qI/u5yqsbst9V3SitrSav7V7IDu1VpK/tXnGxI/VNcPJvLowG5eAPcAHDXXIEUG
	 qs0mggqndBIaZCedyISFcyYtHmnLBi1LCE4pwoKFCzoiuq33gZ6gTDuClcPjtr9k3J
	 68Kes3Yte7M6GHbM2cHjt2xbn4ILcnONphe84etq9rLa8J0RuYgtWA489MYUW7YCOr
	 1DrXIdEPjzCFEwPS5Zc0/J0+4MTQxdiNQZyNTlMyK+9GAkLecsyqr2z1stcbYauA4b
	 VXLylyozp/4Y9UyhAOtYeddoH2f+qnzV6CJKh8F3lI8Bwa7WYhkVRtCXv7BhV+wceA
	 2MSCJoE2Fx0/w==
Date: Sun, 17 Mar 2024 09:24:57 -0700
Subject: [PATCH 06/40] fsverity: pass tree_blocksize to end_enable_verity()
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246010.2684506.17931924061025315548.stgit@frogsfrogsfrogs>
In-Reply-To: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
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

XFS will need to know tree_blocksize to remove the tree in case of an
error. The size is needed to calculate offsets of particular Merkle
tree blocks.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: I put ebiggers' suggested changes in a separate patch]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/verity.c        |    4 +++-
 fs/ext4/verity.c         |    3 ++-
 fs/f2fs/verity.c         |    3 ++-
 fs/verity/enable.c       |    6 ++++--
 include/linux/fsverity.h |    4 +++-
 5 files changed, 14 insertions(+), 6 deletions(-)


diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..966630523502 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -621,6 +621,7 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * @desc:              verity descriptor to write out (NULL in error conditions)
  * @desc_size:         size of the verity descriptor (variable with signatures)
  * @merkle_tree_size:  size of the merkle tree in bytes
+ * @tree_blocksize:    the Merkle tree block size
  *
  * If desc is null, then VFS is signaling an error occurred during verity
  * enable, and we should try to rollback. Otherwise, attempt to finish verity.
@@ -628,7 +629,8 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * Returns 0 on success, negative error code on error.
  */
 static int btrfs_end_enable_verity(struct file *filp, const void *desc,
-				   size_t desc_size, u64 merkle_tree_size)
+				   size_t desc_size, u64 merkle_tree_size,
+				   unsigned int tree_blocksize)
 {
 	struct btrfs_inode *inode = BTRFS_I(file_inode(filp));
 	int ret = 0;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 2f37e1ea3955..da2095a81349 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -189,7 +189,8 @@ static int ext4_write_verity_descriptor(struct inode *inode, const void *desc,
 }
 
 static int ext4_end_enable_verity(struct file *filp, const void *desc,
-				  size_t desc_size, u64 merkle_tree_size)
+				  size_t desc_size, u64 merkle_tree_size,
+				  unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	const int credits = 2; /* superblock and inode for ext4_orphan_del() */
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 4fc95f353a7a..b4461b9f47a3 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -144,7 +144,8 @@ static int f2fs_begin_enable_verity(struct file *filp)
 }
 
 static int f2fs_end_enable_verity(struct file *filp, const void *desc,
-				  size_t desc_size, u64 merkle_tree_size)
+				  size_t desc_size, u64 merkle_tree_size,
+				  unsigned int tree_blocksize)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c284f46d1b53..04e060880b79 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -274,7 +274,8 @@ static int enable_verity(struct file *filp,
 	 * Serialized with ->begin_enable_verity() by the inode lock.
 	 */
 	inode_lock(inode);
-	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
+	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size,
+				      params.block_size);
 	inode_unlock(inode);
 	if (err) {
 		fsverity_err(inode, "%ps() failed with err %d",
@@ -300,7 +301,8 @@ static int enable_verity(struct file *filp,
 
 rollback:
 	inode_lock(inode);
-	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size);
+	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size,
+				      params.block_size);
 	inode_unlock(inode);
 	goto out;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 1eb7eae580be..ac58b19f23d3 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -51,6 +51,7 @@ struct fsverity_operations {
 	 * @desc: the verity descriptor to write, or NULL on failure
 	 * @desc_size: size of verity descriptor, or 0 on failure
 	 * @merkle_tree_size: total bytes the Merkle tree took up
+	 * @tree_blocksize: the Merkle tree block size
 	 *
 	 * If desc == NULL, then enabling verity failed and the filesystem only
 	 * must do any necessary cleanups.  Else, it must also store the given
@@ -65,7 +66,8 @@ struct fsverity_operations {
 	 * Return: 0 on success, -errno on failure
 	 */
 	int (*end_enable_verity)(struct file *filp, const void *desc,
-				 size_t desc_size, u64 merkle_tree_size);
+				 size_t desc_size, u64 merkle_tree_size,
+				 unsigned int tree_blocksize);
 
 	/**
 	 * Get the verity descriptor of the given inode.


