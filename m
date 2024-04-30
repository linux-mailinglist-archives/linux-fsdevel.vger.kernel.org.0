Return-Path: <linux-fsdevel+bounces-18221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE768B6860
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C94B21D16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96636FC02;
	Tue, 30 Apr 2024 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enJ1GPkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A6101C4;
	Tue, 30 Apr 2024 03:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447322; cv=none; b=lKfIDHmDmrhtOBTFBfHnN/6VUIwqDFMnGks9IgNlfc9RKG8bxPgJ4e0FH1ECeLioGmN1s05uHXj2XzfnlG9IuISZvh3V7ey/4AGwWKaJkQox0HD8kBxK8Lu6tdxnFVC8yBjgdw0luxRdSbmkwijRlYcNMUXPxwTGBnm51XXtUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447322; c=relaxed/simple;
	bh=qBry6RmUkGHTX6QQY2c1rG/aachVOEPhm+aKvpH5uVk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/E2j+C8QjRxuzfmSAC0gyGWHUVqX1IE9AO33oHBbfh+zVH6rvDYBI1Cun0GQIx/AxGZrzZedMBhBLIN6HYIpM1nuGZALZ32rfEcBgEwqmtY1TbUxyYscYmkdRe9052poF1WeALaICkDUkvAgy+Gwx2crYYSoG6fzUVYnNIM2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enJ1GPkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED2FC4AF14;
	Tue, 30 Apr 2024 03:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447321;
	bh=qBry6RmUkGHTX6QQY2c1rG/aachVOEPhm+aKvpH5uVk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=enJ1GPkqD++GS5QVkNbIueqHkydUk3ex8t9i+YwCuMlvqMbKklH+wUQq70GecPmKZ
	 y2io1NtyiqMiOqiu6XpeF9Ju+SSasa1ze3uQZKY6s9kZXv9uANrJMpB3W/otcY/atg
	 zQittEanVHTneuLnh0VlObHMqfbSi1g1brEP5NFrti7eaFoENaEjNLvgfaaEUr7aA7
	 Z/WX39vSDcj8fK/8tPS6ArT1yntoIqBRbxE0WPNd/oMvhIO8NxBowmWtVAdnuiP5WW
	 TqNl2dRGz1aKH6doBthRWEYy2eTcGD9pfpE2YvpbWlsnDAaLZlYgM1qaDMovO9cyO3
	 KdSBzzmp9ItoA==
Date: Mon, 29 Apr 2024 20:22:01 -0700
Subject: [PATCH 10/18] fsverity: box up the write_merkle_tree_block parameters
 too
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679759.955480.7982738929684385945.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
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
 include/linux/fsverity.h |   15 ++++++++++++---
 5 files changed, 30 insertions(+), 10 deletions(-)


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
index a3a5b68bed0d3..710006552804d 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -73,6 +73,14 @@ struct fsverity_readmerkle {
 
 #define FSVERITY_STREAMING_READ	(-1)
 
+/**
+ * struct fsverity_writemerkle - Request to write a Merkle Tree block buffer
+ * @inode: the inode to read
+ */
+struct fsverity_writemerkle {
+	struct inode *inode;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 
@@ -183,7 +191,7 @@ struct fsverity_operations {
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
-	 * @inode: the inode for which the Merkle tree is being built
+	 * @req: write request; see struct fsverity_writemerkle
 	 * @buf: the Merkle tree block to write
 	 * @pos: the position of the block in the Merkle tree (in bytes)
 	 * @size: the Merkle tree block size (in bytes)
@@ -193,8 +201,9 @@ struct fsverity_operations {
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


