Return-Path: <linux-fsdevel+bounces-14333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67587B094
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0069828465F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CCB144047;
	Wed, 13 Mar 2024 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1y19isz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2B58AB8;
	Wed, 13 Mar 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352527; cv=none; b=jMHjhoQLA8MQ6zT9C0i5hXXi6ewLc9t9Fro7Yd8JA9vrLu1Ebwb2Rh1NDNuB/7yKdQO54tNjVCaA4M4yyFtRN1ymK2bkCAuJ1E68kUSJb07tqUn3Jobu37TibPJzt14LfXlMDuxQHDTIXOAmvOJTd/V8U4z7oYwxx8pkmbOCAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352527; c=relaxed/simple;
	bh=1MnT1ZpW/vtlTpR5rEaheiz7VcBK8zfu40pO4zxZE80=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqCrWTnht85MSmeqATvFfU0SjdGaiffQpWHH0AxmV0LTuP2PdazesW+WMz+Lw6EerA3sjiLdz3ODOJKUClchuqYX8ZGc/w+4zmZj3BFalvk7b1jdstWdLevcfmSf6Wn4fOhyZStKqCGm03j6VSNu84JzhcxlCbsl10+SJ6YA1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1y19isz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59820C433F1;
	Wed, 13 Mar 2024 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352527;
	bh=1MnT1ZpW/vtlTpR5rEaheiz7VcBK8zfu40pO4zxZE80=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=I1y19iszyvoBhRU8wom9YBKnvD6z1n+V7R4pLgvvh+S8NssQcCwAqsjA2Hwxy2HM5
	 eq+x2y5AGELIXjRj4hJ0zH65NBLjqVkU/S9sYZnjgcNkpcr6FqKbB/5hGiiFEtKp1H
	 qAnGiO0TJYWktBLMYnb3zGGnelC/wlfYa3e+JTRYZQRjb0RWIEDihXG3JJSj8JuiES
	 AV5318zAXChqVlKVE0rtG2bMyE3+VJH1DVopKyYbAdlGR+CO2jfTTuUUlXdQ3cOkeI
	 1RYQyYs9dtipkDvBVubthXaXRJ/7wX1XLvuLgfEU9OKcReY3+TN0N2bX5WvfyrJ+6t
	 tsgLPjeGWhnTA==
Date: Wed, 13 Mar 2024 10:55:26 -0700
Subject: [PATCH 11/29] fsverity: send the level of the merkle tree block to
 ->read_merkle_tree_block
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171035223536.2613863.16457126075122515194.stgit@frogsfrogsfrogs>
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
 fs/verity/verify.c           |   25 +++++++++++++++++++------
 include/linux/fsverity.h     |   32 ++++++++++++++++++++++----------
 4 files changed, 43 insertions(+), 18 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 0a4381acb394..b01343113e8b 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -179,7 +179,7 @@ static inline bool fsverity_uses_bitmap(const struct fsverity_info *vi,
 
 int fsverity_read_merkle_tree_block(struct inode *inode,
 				    const struct merkle_tree_params *params,
-				    u64 pos, unsigned long ra_bytes,
+				    int level, u64 pos, unsigned long ra_bytes,
 				    struct fsverity_blockbuf *block);
 
 /*
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 94fffa060f82..87cc6f289663 100644
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
index 6c4c73eeccea..cd84182f5e43 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -184,8 +184,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		else
 			ra_bytes = 0;
 
-		err = fsverity_read_merkle_tree_block(inode, params, hblock_pos,
-				ra_bytes, block);
+		err = fsverity_read_merkle_tree_block(inode, params, level,
+				hblock_pos, ra_bytes, block);
 		if (err) {
 			fsverity_err(inode,
 				     "Error %d reading Merkle tree block %llu",
@@ -406,6 +406,8 @@ EXPORT_SYMBOL_GPL(fsverity_invalidate_block);
  * fsverity_read_merkle_tree_block() - read Merkle tree block
  * @inode: inode to which this Merkle tree blocks belong
  * @params: merkle tree parameters
+ * @level: expected level of the block; level 0 are the leaves, -1 means a
+ * streaming read
  * @pos: byte position within merkle tree
  * @ra_bytes: try to read ahead this many btes
  * @block: block to be loaded
@@ -414,7 +416,7 @@ EXPORT_SYMBOL_GPL(fsverity_invalidate_block);
  */
 int fsverity_read_merkle_tree_block(struct inode *inode,
 				    const struct merkle_tree_params *params,
-				    u64 pos, unsigned long ra_bytes,
+				    int level, u64 pos, unsigned long ra_bytes,
 				    struct fsverity_blockbuf *block)
 {
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
@@ -423,9 +425,20 @@ int fsverity_read_merkle_tree_block(struct inode *inode,
 	unsigned long index;
 	unsigned int offset_in_page;
 
-	if (fsverity_caches_blocks(inode))
-		return vops->read_merkle_tree_block(inode, pos, ra_bytes,
-				params->log_blocksize, block);
+	block->offset = pos;
+	block->size = params->block_size;
+
+	if (fsverity_caches_blocks(inode)) {
+		struct fsverity_readmerkle req = {
+			.inode = inode,
+			.level = level,
+			.num_levels = params->num_levels,
+			.log_blocksize = params->log_blocksize,
+			.ra_bytes = ra_bytes,
+		};
+
+		return vops->read_merkle_tree_block(&req, block);
+	}
 
 	index = pos >> params->log_blocksize;
 	page_idx = round_down(index, params->blocks_per_page);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 0af2cd1860e4..d12a95623614 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -53,6 +53,26 @@ struct fsverity_blockbuf {
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
 
@@ -139,13 +159,7 @@ struct fsverity_operations {
 
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
@@ -160,9 +174,7 @@ struct fsverity_operations {
 	 *
 	 * Return: 0 on success, -errno on failure
 	 */
-	int (*read_merkle_tree_block)(struct inode *inode,
-				      u64 pos, unsigned long ra_bytes,
-				      unsigned int log_blocksize,
+	int (*read_merkle_tree_block)(const struct fsverity_readmerkle *req,
 				      struct fsverity_blockbuf *block);
 
 	/**


