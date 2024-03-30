Return-Path: <linux-fsdevel+bounces-15704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA47892820
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BF91F222E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA815CB;
	Sat, 30 Mar 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVGvNor6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA4811;
	Sat, 30 Mar 2024 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758792; cv=none; b=kGpHWw24PfsE+jtQCuG6bfpWU62xv0nBZnynmDY0LaVX827ndhPEXm/OLkzBsb2sOeOAPD8kHJhVsOv4OkeWpJTZMxN/zLBvWG66UBhphoss9EE69si5W75p+yVCH2jWKMJtW5v3YzQwThe2IJAZ3Sbjw+9ll8BDPY7ZPiRxLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758792; c=relaxed/simple;
	bh=RsAyXo8waRT6lhUGr1W6mNDhwALTDa015MFtDJNurwk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOebu07XN+8OxwXCd02xwCBICA0lZHrQotr7lMN5H1WkTbqGrsxY9yFVD0S1M5HmMrv8CpU/Y8FQAucCGOmVYtsYMrXkSrBmSwCFx5QssyHDZfKc+lJ1mwU+0rKSRe5Rf1uiPY5+R2v9d5h/b7vTYN23dqmDy3DdRtpU6LZOhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVGvNor6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1138DC433F1;
	Sat, 30 Mar 2024 00:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758792;
	bh=RsAyXo8waRT6lhUGr1W6mNDhwALTDa015MFtDJNurwk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HVGvNor6lOB1oJsNuI1MRAmURaNyBN5wpZ8TG7KNJSjLo2lIMiM4+Z6b8axmxO5wj
	 j6S5WhduZHGOCG2e3hp7O+HWIJOxifjPu2S4lRHljxnaJ8tLHxsRdG4ridNAlKdg+P
	 /LcKzwjlUPhazFxArvdvUI3y4ZLXkQX85X9++EH+NRgKoyQb0HqYQqwfvWUjcstzM2
	 B8B7oe1eCE7Q/YBirZsbI+L5mYe4kT2AYwkk8lb+Rws49MzLB9PgK89zLd9J1sd8iR
	 NGkitW2iXjoZiyNoCROg9x39sDw4hxZjdpfhif6FpYnzzjtdULIrYikEeI4/OFYSsI
	 0qc92FfPCzkjA==
Date: Fri, 29 Mar 2024 17:33:11 -0700
Subject: [PATCH 02/13] fsverity: pass tree_blocksize to end_enable_verity()
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175867896.1987804.5238508462969286297.stgit@frogsfrogsfrogs>
In-Reply-To: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
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
index 4042dd6437aef..647a22e07748e 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -620,6 +620,7 @@ static int btrfs_begin_enable_verity(struct file *filp)
  * @desc:              verity descriptor to write out (NULL in error conditions)
  * @desc_size:         size of the verity descriptor (variable with signatures)
  * @merkle_tree_size:  size of the merkle tree in bytes
+ * @tree_blocksize:    the Merkle tree block size
  *
  * If desc is null, then VFS is signaling an error occurred during verity
  * enable, and we should try to rollback. Otherwise, attempt to finish verity.
@@ -627,7 +628,8 @@ static int btrfs_begin_enable_verity(struct file *filp)
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
index 2f37e1ea39551..da2095a813492 100644
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
index f7bb0c54502c8..8fdac653ff8e8 100644
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
index c284f46d1b535..04e060880b792 100644
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
index 1eb7eae580be7..ac58b19f23d32 100644
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


