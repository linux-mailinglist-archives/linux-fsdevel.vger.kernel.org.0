Return-Path: <linux-fsdevel+bounces-15708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851689282B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D9282598
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74861860;
	Sat, 30 Mar 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaoVwK0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA415A5;
	Sat, 30 Mar 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758855; cv=none; b=K8eNHj2ElREO3R7CgXlQbfU9OA9Ix/VRYBcIWg/Al3TxuamhY2sIRww0iNtqr05et0Eb81kXkd7Rko90aai55DYdUOaIqn27tKevLw6CyEwQU9aMudTF8ygo9Q2i4U3Cod+c2qWJzpg78eGxrjLfgLo7EqZNeZMdqipD52xAza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758855; c=relaxed/simple;
	bh=w+TL+zO+c6nqQijTthaLxqD4uljZAOe7pLb/4Ci2LxU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=om65ArDoVL6bpkytkJWfA/gwK+L4ba0t0TCT9p1gfnF9p6pKaZ1O1MJoWILgS4ypDblVz6cWGTImFpaTcTjQc2o21rSyK31rMCtUWYYvyrflDIH6kI2bIAxCtD5ClSfDj60R9Y3TxL3TAd9nyh01z265A4Tg5ns3BzImP6UZSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaoVwK0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A98C433F1;
	Sat, 30 Mar 2024 00:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758855;
	bh=w+TL+zO+c6nqQijTthaLxqD4uljZAOe7pLb/4Ci2LxU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aaoVwK0QUV+g57yQbbG6adfxoTh36UgmJ1IfDTN91/Cg9WRUOxlSklahPwv9slXFa
	 ko0L4aysC8f4rZMvvVvAQjGzDMqgoW8b5PPIPaTmosznHMYPlmy12ObuMm/dycwKat
	 cAJ97LjiRNnLzDZMeohZ4OdeTHe7JQq9kqbABbpnGe1dPXQpLo8xePDg9+0tTarRe8
	 XHNe4J9oNKd5hNG1Txqmwi3HnHwDgZ7xFiN5GwtUL4A2s2/KBY35ulFukq/PEfNXgG
	 GncKFRx7fRTQ65DD3wX+JWr0VXwrVL6tZnjQQfpokLlbtqYv8RckbdHR+uRGPIDL6D
	 g8tIrqucWAA5g==
Date: Fri, 29 Mar 2024 17:34:14 -0700
Subject: [PATCH 06/13] fsverity: send the level of the merkle tree block to
 ->read_merkle_tree_block
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175867965.1987804.16949621858616176182.stgit@frogsfrogsfrogs>
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

When fsverity needs to pull in a merkle tree block for file data
verification, it knows the level of the block within the tree.  For XFS,
we will cache the blocks in memory ourselves, and it is advantageous to
make higher level nodes more resistant to memory reclamation.

Therefore, we need to pass the anticipated level to the
->read_merkle_tree_block functions to enable this kind of caching.
Establish level == -1 to mean streaming read (e.g. downloading the
merkle tree).

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/fsverity_private.h |    2 +-
 fs/verity/read_metadata.c    |    2 +-
 fs/verity/verify.c           |   22 +++++++++++++++++-----
 include/linux/fsverity.h     |   32 ++++++++++++++++++++++----------
 4 files changed, 41 insertions(+), 17 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index d4a9178f9e827..de8798f141d4a 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -180,7 +180,7 @@ static inline bool fsverity_uses_bitmap(const struct fsverity_info *vi,
 
 int fsverity_read_merkle_tree_block(struct inode *inode,
 				    const struct merkle_tree_params *params,
-				    u64 pos, unsigned long ra_bytes,
+				    int level, u64 pos, unsigned long ra_bytes,
 				    struct fsverity_blockbuf *block);
 
 /*
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 94fffa060f829..87cc6f2896633 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -43,7 +43,7 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 				      params->block_size - offs_in_block);
 
 		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
-				pos - offs_in_block, ra_bytes, &block);
+				-1, pos - offs_in_block, ra_bytes, &block);
 		if (err) {
 			fsverity_err(inode,
 				     "Error %d reading Merkle tree block %llu",
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 85d8d2fcce9ab..c4ebf85ba2c79 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -185,8 +185,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		else
 			ra_bytes = 0;
 
-		err = fsverity_read_merkle_tree_block(inode, params, hblock_pos,
-				ra_bytes, block);
+		err = fsverity_read_merkle_tree_block(inode, params, level,
+				hblock_pos, ra_bytes, block);
 		if (err) {
 			fsverity_err(inode,
 				     "Error %d reading Merkle tree block %llu",
@@ -403,6 +403,8 @@ void __init fsverity_init_workqueue(void)
  * fsverity_read_merkle_tree_block() - read Merkle tree block
  * @inode: inode to which this Merkle tree blocks belong
  * @params: merkle tree parameters
+ * @level: expected level of the block; level 0 are the leaves, -1 means a
+ * streaming read
  * @pos: byte position within merkle tree
  * @ra_bytes: try to read ahead this many btes
  * @block: block to be loaded
@@ -411,7 +413,7 @@ void __init fsverity_init_workqueue(void)
  */
 int fsverity_read_merkle_tree_block(struct inode *inode,
 				    const struct merkle_tree_params *params,
-				    u64 pos, unsigned long ra_bytes,
+				    int level, u64 pos, unsigned long ra_bytes,
 				    struct fsverity_blockbuf *block)
 {
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
@@ -420,10 +422,20 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 	unsigned long index;
 	unsigned int offset_in_page;
 
+	block->offset = pos;
+	block->size = params->block_size;
+
 	if (fsverity_caches_blocks(inode)) {
+		struct fsverity_readmerkle req = {
+			.inode = inode,
+			.level = level,
+			.num_levels = params->num_levels,
+			.log_blocksize = params->log_blocksize,
+			.ra_bytes = ra_bytes,
+		};
+
 		block->verified = false;
-		return vops->read_merkle_tree_block(inode, pos, ra_bytes,
-				params->log_blocksize, block);
+		return vops->read_merkle_tree_block(&req, block);
 	}
 
 	index = pos >> params->log_blocksize;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 495708fb1f26a..52de58d6f021f 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -55,6 +55,26 @@ struct fsverity_blockbuf {
 	void *context;
 };
 
+/**
+ * struct fsverity_readmerkle - Request to read a Merkle Tree block buffer
+ * @inode: the inode to read
+ * @level: expected level of the block; level 0 are the leaves, -1 means a
+ * streaming read
+ * @num_levels: number of levels in the tree total
+ * @log_blocksize: log2 of the size of the expected block
+ * @ra_bytes: The number of bytes that should be prefetched starting at pos
+ *		if the page at @block->offset isn't already cached.
+ *		Implementations may ignore this argument; it's only a
+ *		performance optimization.
+ */
+struct fsverity_readmerkle {
+	struct inode *inode;
+	unsigned long ra_bytes;
+	int level;
+	int num_levels;
+	u8 log_blocksize;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 
@@ -141,13 +161,7 @@ struct fsverity_operations {
 
 	/**
 	 * Read a Merkle tree block of the given inode.
-	 * @inode: the inode
-	 * @pos: byte offset of the block within the Merkle tree
-	 * @ra_bytes: The number of bytes that should be
-	 *		prefetched starting at @pos if the page at @pos
-	 *		isn't already cached.  Implementations may ignore this
-	 *		argument; it's only a performance optimization.
-	 * @log_blocksize: log2 of the size of the expected block
+	 * @req: read request; see struct fsverity_readmerkle
 	 * @block: block buffer for filesystem to point it to the block
 	 *
 	 * This can be called at any time on an open verity file.  It may be
@@ -162,9 +176,7 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*read_merkle_tree_block)(struct inode *inode,
-				      u64 pos, unsigned long ra_bytes,
-				      unsigned int log_blocksize,
+	int (*read_merkle_tree_block)(const struct fsverity_readmerkle *req,
 				      struct fsverity_blockbuf *block);
 
 	/**


