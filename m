Return-Path: <linux-fsdevel+bounces-14592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDF87DE6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C0B1C20AC7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC431CD18;
	Sun, 17 Mar 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAqrtJo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4DA1CAB7;
	Sun, 17 Mar 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692839; cv=none; b=jLmIRHCwkitBL9ge8tc4gpBhqFAHJCZQQGNL2lHn4JetyWZvZIRfm+LNXEJoNIGl5+8lFKS/k+CZNFrMoAZYlwtuHIR01SXDUh1Y9xD3qPaArfvolZBMWRzx4m5OQkAduHuPoMR/lioln+xAnHrctVLrS8u5HHf34GlNmTl16QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692839; c=relaxed/simple;
	bh=pz1WkH8YrDy95nDuH+ySTVsbKCgRz/nDS0YNxRP4rSY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=af+FtcUgqqN+ynFcZV/snYF+rnCRN88ZACilS8RBoUQPwB7GuFFqaBqty/56qvs+T3l4Xyyv+XxViDeDtGuHfwnk+KPMySmSTvAcDxf6vyea/dqr/ues3MLHEHSSrX5tr5RX5XXizHcblIbWjwnuNyS4vHJ7rPRJBxGHoRxWFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAqrtJo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07403C433C7;
	Sun, 17 Mar 2024 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692839;
	bh=pz1WkH8YrDy95nDuH+ySTVsbKCgRz/nDS0YNxRP4rSY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YAqrtJo+N4FbpnXJ/IZhw/5r0zcS7ARcqYWjDre0NnUuy412hitvV0mLGGZZLonpY
	 fKoKi9sjaG85fMLJgDCqxXmwjz5K5z1NZmAmMER7Ik1+yGdOz1C+bvHYCa9dngudtS
	 Qh6kOrEVEiQZuemHsVRgs6wf2ymdJ03BuNxHZ4Igzdaz4YgFLYhRPAQPMAjyHC/WJG
	 IZN38Cm29uh/ymCdLCD14gpGV7wn9tU+S5LWgvqayXxZfyT623iEYj1asAtcPJS6Oz
	 SbuPny1jLV5uNjouaIQtYRFPpZyAQrirSrBdgrBkJoBbMaE3FW0RWRhCZzzTPWDeM/
	 H0817I4S/o03A==
Date: Sun, 17 Mar 2024 09:27:18 -0700
Subject: [PATCH 15/40] fsverity: box up the write_merkle_tree_block parameters
 too
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246154.2684506.12184706714215752733.stgit@frogsfrogsfrogs>
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

From: Darrick J. Wong <djwong@kernel.org>

Box up the tree write request parameters into a structure so that we can
add more in the next few patches.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/btrfs/verity.c        |    6 ++++--
 fs/ext4/verity.c         |    7 +++++--
 fs/f2fs/verity.c         |    7 +++++--
 fs/verity/enable.c       |    5 ++++-
 include/linux/fsverity.h |   21 ++++++++++++++++++---
 5 files changed, 36 insertions(+), 10 deletions(-)


diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index c52f32bd43c7..70794c608581 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -791,9 +791,11 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
  *
  * Returns 0 on success or negative error code on failure
  */
-static int btrfs_write_merkle_tree_block(struct inode *inode, const void *buf,
-					 u64 pos, unsigned int size)
+static int btrfs_write_merkle_tree_block(const struct fsverity_writemerkle *req,
+					 const void *buf, u64 pos,
+					 unsigned int size)
 {
+	struct inode *inode = req->inode;
 	loff_t merkle_pos = merkle_file_pos(inode);
 
 	if (merkle_pos < 0)
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index a8ae8c912cb5..27eb2d51cce2 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -382,9 +382,12 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 	return folio_file_page(folio, index);
 }
 
-static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
-					u64 pos, unsigned int size)
+static int ext4_write_merkle_tree_block(const struct fsverity_writemerkle *req,
+					const void *buf, u64 pos,
+					unsigned int size)
 {
+	struct inode *inode = req->inode;
+
 	pos += ext4_verity_metadata_pos(inode);
 
 	return pagecache_write(inode, buf, size, pos);
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index f6ad6523ce95..923d7a09b2f4 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -277,9 +277,12 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 	return page;
 }
 
-static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
-					u64 pos, unsigned int size)
+static int f2fs_write_merkle_tree_block(const struct fsverity_writemerkle *req,
+					const void *buf, u64 pos,
+					unsigned int size)
 {
+	struct inode *inode = req->inode;
+
 	pos += f2fs_verity_metadata_pos(inode);
 
 	return pagecache_write(inode, buf, size, pos);
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 496a361c0a81..8dcfefc848ee 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -50,10 +50,13 @@ static int write_merkle_tree_block(struct inode *inode, const u8 *buf,
 				   unsigned long index,
 				   const struct merkle_tree_params *params)
 {
+	struct fsverity_writemerkle req = {
+		.inode = inode,
+	};
 	u64 pos = (u64)index << params->log_blocksize;
 	int err;
 
-	err = inode->i_sb->s_vop->write_merkle_tree_block(inode, buf, pos,
+	err = inode->i_sb->s_vop->write_merkle_tree_block(&req, buf, pos,
 							  params->block_size);
 	if (err)
 		fsverity_err(inode, "Error %d writing Merkle tree block %lu",
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 026e4f72290e..0dded1fcf2b1 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -75,6 +75,20 @@ struct fsverity_readmerkle {
 	u8 log_blocksize;
 };
 
+/**
+ * struct fsverity_writemerkle - Request to write a Merkle Tree block buffer
+ * @inode: the inode to read
+ * @level: level of the block; level 0 are the leaves
+ * @num_levels: number of levels in the tree total
+ * @log_blocksize: log2 of the size of the block
+ */
+struct fsverity_writemerkle {
+	struct inode *inode;
+	int level;
+	int num_levels;
+	u8 log_blocksize;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 
@@ -185,7 +199,7 @@ struct fsverity_operations {
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
-	 * @inode: the inode for which the Merkle tree is being built
+	 * @req: write request; see struct fsverity_writemerkle
 	 * @buf: the Merkle tree block to write
 	 * @pos: the position of the block in the Merkle tree (in bytes)
 	 * @size: the Merkle tree block size (in bytes)
@@ -195,8 +209,9 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
-				       u64 pos, unsigned int size);
+	int (*write_merkle_tree_block)(const struct fsverity_writemerkle *req,
+				       const void *buf, u64 pos,
+				       unsigned int size);
 
 	/**
 	 * Release the reference to a Merkle tree block


