Return-Path: <linux-fsdevel+bounces-15711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C59B892830
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB0282657
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6F81860;
	Sat, 30 Mar 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBrcc53V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7015A5;
	Sat, 30 Mar 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758902; cv=none; b=NqXOtf9NhXIx80W8RhejZfqUyHplWYkIeYs1AKb5ZabtpQclnHYmnyaTeD6zdJK/Z6rXQ+93g1ZHNNcOC3lXycu3Y6CKeo+7qdjzv8467mWtBpc/vDoSzzwXvh4H9t/ooo1BaCBUn8n+MCyH/GUkPhivrUWPzB9Nf8Dq2Wx1hUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758902; c=relaxed/simple;
	bh=Novm5Xsymnm8HBrtcUcW0Tf22zMFU4thnehZpHYG+zs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/KW8M2Rdpwk27Y3RC/huxwHPfG3BggDZ117hbCot9xhcVmJ3AFj6Wlnptuloo8i8sWjbLR+9snzGA2A6MouupRDZNnwmh0hFIgFocW3v1a9W+sUlmcWBCsx0tOvHZgNiY7lOjPqJTmEPkTfHODExWmvf61PAfZ872dbXzMHHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBrcc53V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBDCC433F1;
	Sat, 30 Mar 2024 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758901;
	bh=Novm5Xsymnm8HBrtcUcW0Tf22zMFU4thnehZpHYG+zs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PBrcc53VsEL7URzqOCB2B6zBmLTiJAgNYkZbRbWvIuW8xRh4PyAXBCcrNe/kEvTUY
	 Y7F4XfTVQ+RSc4p5t0eLK51GIccMlM0DOz1itJa6t0jGeiwuarA6chQi7OSPjJTAih
	 /vxQwfXAWzTZ9FFM9O6yThZSHsSMsB7mfLSemiW0KPTKLPa80teYwGlGaKXlCMdqxY
	 62rjFvGzBwi2jKWjBX+ma8vJ0DaiHJ+nIogvaMpuNbrJavTFXL3+xepZ9telLUXEaa
	 i8oyxdvmwTfbgqndE02ekBzqmiaq6qUQNPbMStq2pW+0HOqRQc/96r4ICUq94up+Qo
	 1nj5Px/9av3tg==
Date: Fri, 29 Mar 2024 17:35:01 -0700
Subject: [PATCH 09/13] fsverity: box up the write_merkle_tree_block parameters
 too
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868014.1987804.14065724867005749327.stgit@frogsfrogsfrogs>
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
index a3235571bf02d..576547c0f9e54 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -790,9 +790,11 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
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
index a8ae8c912cb5d..27eb2d51cce2f 100644
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
index 595d702c2c5c4..f8d974818f3bb 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -279,9 +279,12 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 	return folio_file_page(folio, index);
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
index 1d4a6de960149..233b20fb12ff5 100644
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
index 5b1485a842983..5dacd30d65353 100644
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


