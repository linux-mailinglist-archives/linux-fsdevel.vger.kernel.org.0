Return-Path: <linux-fsdevel+bounces-14587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6749A87DE62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF951F21A04
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8CC1CD13;
	Sun, 17 Mar 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swpRlvi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36661CA96;
	Sun, 17 Mar 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710692761; cv=none; b=Ktk0fv+dTvW5Cj9a1K/MBCbXKGQrp9S0/m0P0JK3nGbHnFK9L8S5Nb9KxBhu1Ki8kpyIQXWN0uAkimnJlYqcEUlCi4CFs55HUg4RiJvJZ3yghL1Xsb/WXxj5ZSBJbqCFwzDqh5UUuX+aCn54PwOZCmZPgYkhh0JFX2hNq42ldRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710692761; c=relaxed/simple;
	bh=8uxd87nDK26U75DT/QB9AwLkCWL2IwnONr4z5q81X38=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jftauzkGxaC6LBlCOHwyCBskGslU+W+ceEjW2l4JV25iQDNkr+uDKboi4vED5jc7kehkEZVn2zkVUG/XpWRlUr/WSZ1zO40T5F0w+N/0G6/fHyp3dtRWTZrOa6W7KH9JhJDCoovT93EEjuipJwRMx1MXrQ4/YdwHX4OENXErRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swpRlvi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C508FC433C7;
	Sun, 17 Mar 2024 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710692760;
	bh=8uxd87nDK26U75DT/QB9AwLkCWL2IwnONr4z5q81X38=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=swpRlvi9g/mDv4wdGEEts48igsmFQrfDKD8C+BGTQH0/8oqBYlbrUBH1EmC+hhRFX
	 H77n1kgZEUSIOMlUt7m3VwnqsiDkNtPZoa9tB56NF+JYh12Vpxk/KLUemy6Uc5Uikd
	 nPyjav4LVzuEjhf9kXmbT3ZYRRU/nK7qNegLFGR4/Ncm1t/gHaizzscO9rMhFstgBa
	 jwOWNKzWgDi7ap/nLQOTQxuVEsVsdWPwyE/iba4lZTnCa5EHMnCZ+vS0m06f60JU2c
	 wUJcRdcXyvWruG2fxKA5oAw5oUXHklZLDScA4Pyz07qKCkCbOMljG9mD7z7PSiWF28
	 B9jGJIyMWOYUg==
Date: Sun, 17 Mar 2024 09:26:00 -0700
Subject: [PATCH 10/40] fsverity: fix "support block-based Merkle tree caching"
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
 linux-xfs@vger.kernel.org
Message-ID: <171069246075.2684506.7773764773347292529.stgit@frogsfrogsfrogs>
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

Various fixes recommended by the maintainer.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/fsverity_private.h |   36 ++++++++++-
 fs/verity/open.c             |    9 +--
 fs/verity/read_metadata.c    |   63 ++++++-------------
 fs/verity/verify.c           |  141 ++++++++++++++++++++++++------------------
 include/linux/fsverity.h     |   24 +++++--
 5 files changed, 151 insertions(+), 122 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index fd8f5a8d1f6a..0a4381acb394 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -154,13 +154,41 @@ static inline void fsverity_init_signature(void)
 
 void __init fsverity_init_workqueue(void);
 
+static inline bool fsverity_caches_blocks(const struct inode *inode)
+{
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+
+	WARN_ON_ONCE(vops->read_merkle_tree_block &&
+		     !vops->drop_merkle_tree_block);
+
+	return vops->read_merkle_tree_block != NULL;
+}
+
+static inline bool fsverity_uses_bitmap(const struct fsverity_info *vi,
+					const struct inode *inode)
+{
+	/*
+	 * If fs uses block-based Merkle tree caching, then fs-verity must use
+	 * hash_block_verified bitmap as there's no page to mark it with
+	 * PG_checked.
+	 */
+	if (vi->tree_params.block_size != PAGE_SIZE)
+		return true;
+	return fsverity_caches_blocks(inode);
+}
+
+int fsverity_read_merkle_tree_block(struct inode *inode,
+				    const struct merkle_tree_params *params,
+				    u64 pos, unsigned long ra_bytes,
+				    struct fsverity_blockbuf *block);
+
 /*
  * Drop 'block' obtained with ->read_merkle_tree_block(). Calls out back to
- * filesystem if ->drop_block() is set, otherwise, drop the reference in the
- * block->context.
+ * filesystem if ->drop_merkle_tree_block() is set, otherwise, drop the
+ * reference in the block->context.
  */
-void fsverity_drop_block(struct inode *inode,
-			 struct fsverity_blockbuf *block);
+void fsverity_drop_merkle_tree_block(struct inode *inode,
+				     struct fsverity_blockbuf *block);
 
 #include <trace/events/fsverity.h>
 
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 6e6922b4b014..9603b3a404f7 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -214,12 +214,11 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 		goto fail;
 
 	/*
-	 * If fs passes Merkle tree blocks to fs-verity (e.g. XFS), then
-	 * fs-verity should use hash_block_verified bitmap as there's no page
-	 * to mark it with PG_checked.
+	 * If fs uses block-based Merkle tree cachin, then fs-verity must use
+	 * hash_block_verified bitmap as there's no page to mark it with
+	 * PG_checked.
 	 */
-	if (vi->tree_params.block_size != PAGE_SIZE ||
-			inode->i_sb->s_vop->read_merkle_tree_block) {
+	if (fsverity_uses_bitmap(vi, inode)) {
 		/*
 		 * When the Merkle tree block size and page size differ, we use
 		 * a bitmap to keep track of which hash blocks have been
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 5da40b5a81af..94fffa060f82 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -14,76 +14,53 @@
 
 static int fsverity_read_merkle_tree(struct inode *inode,
 				     const struct fsverity_info *vi,
-				     void __user *buf, u64 offset, int length)
+				     void __user *buf, u64 pos, int length)
 {
-	const struct fsverity_operations *vops = inode->i_sb->s_vop;
-	u64 end_offset;
-	unsigned int offs_in_block;
-	pgoff_t index, last_index;
+	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
+	const struct merkle_tree_params *params = &vi->tree_params;
+	unsigned int offs_in_block = pos & (params->block_size - 1);
 	int retval = 0;
 	int err = 0;
-	const unsigned int block_size = vi->tree_params.block_size;
-	const u8 log_blocksize = vi->tree_params.log_blocksize;
 
-	end_offset = min(offset + length, vi->tree_params.tree_size);
-	if (offset >= end_offset)
+	if (pos >= end_pos)
 		return 0;
-	offs_in_block = offset & (block_size - 1);
-	last_index = (end_offset - 1) >> log_blocksize;
 
 	/*
 	 * Iterate through each Merkle tree block in the requested range and
 	 * copy the requested portion to userspace. Note that we are returning
 	 * a byte stream.
 	 */
-	for (index = offset >> log_blocksize; index <= last_index; index++) {
-		unsigned long num_ra_pages =
-			min_t(unsigned long, last_index - index + 1,
-			      inode->i_sb->s_bdi->io_pages);
-		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
-						   block_size - offs_in_block);
+	while (pos < end_pos) {
+		unsigned long ra_bytes;
+		unsigned int bytes_to_copy;
 		struct fsverity_blockbuf block = {
-			.size = block_size,
+			.size = params->block_size,
 		};
 
-		if (!vops->read_merkle_tree_block) {
-			unsigned int blocks_per_page =
-				vi->tree_params.blocks_per_page;
-			unsigned long page_idx =
-				round_down(index, blocks_per_page);
-			struct page *page = vops->read_merkle_tree_page(inode,
-					page_idx, num_ra_pages);
-
-			if (IS_ERR(page)) {
-				err = PTR_ERR(page);
-			} else {
-				block.kaddr = kmap_local_page(page) +
-					((index - page_idx) << log_blocksize);
-				block.context = page;
-			}
-		} else {
-			err = vops->read_merkle_tree_block(inode,
-					index << log_blocksize,
-					&block, log_blocksize, num_ra_pages);
-		}
+		ra_bytes = min_t(unsigned long, end_pos - pos + 1,
+				 inode->i_sb->s_bdi->io_pages << PAGE_SHIFT);
+		bytes_to_copy = min_t(u64, end_pos - pos,
+				      params->block_size - offs_in_block);
 
+		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
+				pos - offs_in_block, ra_bytes, &block);
 		if (err) {
 			fsverity_err(inode,
-				     "Error %d reading Merkle tree block %lu",
-				     err, index << log_blocksize);
+				     "Error %d reading Merkle tree block %llu",
+				     err, pos);
 			break;
 		}
 
 		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
-			fsverity_drop_block(inode, &block);
+			fsverity_drop_merkle_tree_block(inode, &block);
 			err = -EFAULT;
 			break;
 		}
-		fsverity_drop_block(inode, &block);
+		fsverity_drop_merkle_tree_block(inode, &block);
 
 		retval += bytes_to_copy;
 		buf += bytes_to_copy;
-		offset += bytes_to_copy;
+		pos += bytes_to_copy;
 
 		if (fatal_signal_pending(current))  {
 			err = -EINTR;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index aa1763e8b723..6c4c73eeccea 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -23,7 +23,18 @@ static bool is_hash_block_verified(struct inode *inode,
 	unsigned int blocks_per_page;
 	unsigned int i;
 	struct fsverity_info *vi = inode->i_verity_info;
-	struct page *hpage = (struct page *)block->context;
+	struct page *hpage;
+
+	/*
+	 * If the filesystem uses block-based caching, then
+	 * ->hash_block_verified is always used and the filesystem pushes
+	 * invalidations to it as needed.
+	 */
+	if (fsverity_caches_blocks(inode))
+		return test_bit(hblock_idx, vi->hash_block_verified);
+
+	/* Otherwise, the filesystem uses page-based caching. */
+	hpage = (struct page *)block->context;
 
 	/*
 	 * When the Merkle tree block size and page size are the same, then the
@@ -34,15 +45,9 @@ static bool is_hash_block_verified(struct inode *inode,
 	 * get evicted and re-instantiated from the backing storage, as new
 	 * pages always start out with PG_checked cleared.
 	 */
-	if (!vi->hash_block_verified)
+	if (!fsverity_uses_bitmap(vi, inode))
 		return PageChecked(hpage);
 
-	/*
-	 * Filesystems which use block based caching (e.g. XFS) always use
-	 * bitmap.
-	 */
-	if (inode->i_sb->s_vop->read_merkle_tree_block)
-		return test_bit(hblock_idx, vi->hash_block_verified);
 	/*
 	 * When the Merkle tree block size and page size differ, we use a bitmap
 	 * to indicate whether each hash block has been verified.
@@ -99,13 +104,13 @@ static bool is_hash_block_verified(struct inode *inode,
  */
 static bool
 verify_data_block(struct inode *inode, struct fsverity_info *vi,
-		  const void *data, u64 data_pos, unsigned long max_ra_pages)
+		  const void *data, u64 data_pos, unsigned long max_ra_bytes)
 {
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
 	int level;
 	int err = 0;
-	int num_ra_pages;
+	unsigned long ra_bytes;
 	u8 _want_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	const u8 *want_hash;
 	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
@@ -153,11 +158,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 	for (level = 0; level < params->num_levels; level++) {
 		unsigned long next_hidx;
 		unsigned long hblock_idx;
-		pgoff_t hpage_idx;
 		u64 hblock_pos;
-		unsigned int hblock_offset_in_page;
 		unsigned int hoffset;
-		struct page *hpage;
 		struct fsverity_blockbuf *block = &hblocks[level].block;
 
 		/*
@@ -169,47 +171,25 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Index of the hash block in the tree overall */
 		hblock_idx = params->level_start[level] + next_hidx;
 
-		/* Index of the hash page in the tree overall */
-		hpage_idx = hblock_idx >> params->log_blocks_per_page;
-
-		/* Byte offset of the hash block within the page */
-		hblock_offset_in_page =
-			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
-
-		/* Offset of the Merkle tree block into the tree */
+		/* Byte offset of the hash block in the tree overall */
 		hblock_pos = hblock_idx << params->log_blocksize;
 
 		/* Byte offset of the hash within the block */
 		hoffset = (hidx << params->log_digestsize) &
 			  (params->block_size - 1);
 
-		num_ra_pages = level == 0 ?
-			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
-
-		if (inode->i_sb->s_vop->read_merkle_tree_block) {
-			err = inode->i_sb->s_vop->read_merkle_tree_block(
-				inode, hblock_pos, block, params->log_blocksize,
-				num_ra_pages);
-		} else {
-			unsigned int blocks_per_page =
-				vi->tree_params.blocks_per_page;
-			hblock_idx = round_down(hblock_idx, blocks_per_page);
-			hpage = inode->i_sb->s_vop->read_merkle_tree_page(
-				inode, hpage_idx, (num_ra_pages << PAGE_SHIFT));
-
-			if (IS_ERR(hpage)) {
-				err = PTR_ERR(hpage);
-			} else {
-				block->kaddr = kmap_local_page(hpage) +
-					hblock_offset_in_page;
-				block->context = hpage;
-			}
-		}
+		if (level == 0)
+			ra_bytes = min(max_ra_bytes,
+				       params->tree_size - hblock_pos);
+		else
+			ra_bytes = 0;
 
+		err = fsverity_read_merkle_tree_block(inode, params, hblock_pos,
+				ra_bytes, block);
 		if (err) {
 			fsverity_err(inode,
-				     "Error %d reading Merkle tree block %lu",
-				     err, hblock_idx);
+				     "Error %d reading Merkle tree block %llu",
+				     err, hblock_pos);
 			goto error;
 		}
 
@@ -218,7 +198,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			want_hash = _want_hash;
 			trace_fsverity_merkle_tree_block_verified(inode,
 					block, FSVERITY_TRACE_DIR_ASCEND);
-			fsverity_drop_block(inode, block);
+			fsverity_drop_merkle_tree_block(inode, block);
 			goto descend;
 		}
 		hblocks[level].index = hblock_idx;
@@ -234,7 +214,6 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		const void *haddr = block->kaddr;
 		unsigned long hblock_idx = hblocks[level - 1].index;
 		unsigned int hoffset = hblocks[level - 1].hoffset;
-		struct page *hpage = (struct page *)block->context;
 
 		if (fsverity_hash_block(params, inode, haddr, real_hash) != 0)
 			goto error;
@@ -245,15 +224,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		 * idempotent, as the same hash block might be verified by
 		 * multiple threads concurrently.
 		 */
-		if (vi->hash_block_verified)
+		if (fsverity_uses_bitmap(vi, inode))
 			set_bit(hblock_idx, vi->hash_block_verified);
 		else
-			SetPageChecked(hpage);
+			SetPageChecked((struct page *)block->context);
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
 		trace_fsverity_merkle_tree_block_verified(inode, block,
 				FSVERITY_TRACE_DIR_DESCEND);
-		fsverity_drop_block(inode, block);
+		fsverity_drop_merkle_tree_block(inode, block);
 	}
 
 	/* Finally, verify the data block. */
@@ -271,13 +250,13 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		     params->hash_alg->name, hsize, real_hash);
 error:
 	for (; level > 0; level--)
-		fsverity_drop_block(inode, &hblocks[level - 1].block);
+		fsverity_drop_merkle_tree_block(inode, &hblocks[level - 1].block);
 	return false;
 }
 
 static bool
 verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
-		   unsigned long max_ra_pages)
+		   unsigned long max_ra_bytes)
 {
 	struct inode *inode = data_folio->mapping->host;
 	struct fsverity_info *vi = inode->i_verity_info;
@@ -295,7 +274,7 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
 
 		data = kmap_local_folio(data_folio, offset);
 		valid = verify_data_block(inode, vi, data, pos + offset,
-					  max_ra_pages);
+					  max_ra_bytes);
 		kunmap_local(data);
 		if (!valid)
 			return false;
@@ -358,7 +337,7 @@ void fsverity_verify_bio(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
-					max_ra_pages)) {
+					max_ra_pages << PAGE_SHIFT)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
@@ -412,7 +391,7 @@ void fsverity_invalidate_block(struct inode *inode,
 
 	trace_fsverity_invalidate_block(inode, block);
 
-	if (block->offset > vi->tree_params.tree_size) {
+	if (block->offset >= vi->tree_params.tree_size) {
 		fsverity_err(inode,
 "Trying to invalidate beyond Merkle tree (tree %lld, offset %lld)",
 			     vi->tree_params.tree_size, block->offset);
@@ -423,16 +402,54 @@ void fsverity_invalidate_block(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(fsverity_invalidate_block);
 
-void fsverity_drop_block(struct inode *inode,
-		struct fsverity_blockbuf *block)
+/**
+ * fsverity_read_merkle_tree_block() - read Merkle tree block
+ * @inode: inode to which this Merkle tree blocks belong
+ * @params: merkle tree parameters
+ * @pos: byte position within merkle tree
+ * @ra_bytes: try to read ahead this many btes
+ * @block: block to be loaded
+ *
+ * This function loads data from a merkle tree.
+ */
+int fsverity_read_merkle_tree_block(struct inode *inode,
+				    const struct merkle_tree_params *params,
+				    u64 pos, unsigned long ra_bytes,
+				    struct fsverity_blockbuf *block)
 {
-	if (inode->i_sb->s_vop->drop_block)
-		inode->i_sb->s_vop->drop_block(block);
-	else {
-		struct page *page = (struct page *)block->context;
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+	unsigned long page_idx;
+	struct page *page;
+	unsigned long index;
+	unsigned int offset_in_page;
 
+	if (fsverity_caches_blocks(inode))
+		return vops->read_merkle_tree_block(inode, pos, ra_bytes,
+				params->log_blocksize, block);
+
+	index = pos >> params->log_blocksize;
+	page_idx = round_down(index, params->blocks_per_page);
+	offset_in_page = pos & ~PAGE_MASK;
+
+	page = vops->read_merkle_tree_page(inode, page_idx,
+			ra_bytes >> PAGE_SHIFT);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	block->kaddr = kmap_local_page(page) + offset_in_page;
+	block->context = page;
+	return 0;
+}
+
+void fsverity_drop_merkle_tree_block(struct inode *inode,
+				     struct fsverity_blockbuf *block)
+{
+	if (fsverity_caches_blocks(inode))  {
+		inode->i_sb->s_vop->drop_merkle_tree_block(block);
+	} else {
 		kunmap_local(block->kaddr);
-		put_page(page);
+		put_page((struct page *)block->context);
 	}
 	block->kaddr = NULL;
+	block->context = NULL;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 45b7c613148a..0af2cd1860e4 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -41,10 +41,10 @@
  * written down to disk.
  *
  * While reading the tree, fs-verity calls ->read_merkle_tree_block followed by
- * ->drop_block to let filesystem know that memory can be freed.
+ * ->drop_merkle_tree_block to let filesystem know that memory can be freed.
  *
  * The context is optional. This field can be used by filesystem to passthrough
- * state from ->read_merkle_tree_block to ->drop_block.
+ * state from ->read_merkle_tree_block to ->drop_merkle_tree_block.
  */
 struct fsverity_blockbuf {
 	void *kaddr;
@@ -128,6 +128,9 @@ struct fsverity_operations {
 	 *
 	 * Note that this must retrieve a *page*, not necessarily a *block*.
 	 *
+	 * If this function is implemented, do not implement
+	 * ->read_merkle_tree_block or ->drop_merkle_tree_block.
+	 *
 	 * Return: the page on success, ERR_PTR() on failure
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
@@ -138,12 +141,12 @@ struct fsverity_operations {
 	 * Read a Merkle tree block of the given inode.
 	 * @inode: the inode
 	 * @pos: byte offset of the block within the Merkle tree
-	 * @block: block buffer for filesystem to point it to the block
-	 * @log_blocksize: log2 of the size of the expected block
 	 * @ra_bytes: The number of bytes that should be
 	 *		prefetched starting at @pos if the page at @pos
 	 *		isn't already cached.  Implementations may ignore this
 	 *		argument; it's only a performance optimization.
+	 * @log_blocksize: log2 of the size of the expected block
+	 * @block: block buffer for filesystem to point it to the block
 	 *
 	 * This can be called at any time on an open verity file.  It may be
 	 * called by multiple processes concurrently.
@@ -152,13 +155,15 @@ struct fsverity_operations {
 	 * fsverity_invalidate_block() to let fsverity know that block's
 	 * verification state is not valid anymore.
 	 *
+	 * If this function is implemented, ->drop_merkle_tree_block must also
+	 * be implemented.
+	 *
 	 * Return: 0 on success, -errno on failure
 	 */
 	int (*read_merkle_tree_block)(struct inode *inode,
-				      u64 pos,
-				      struct fsverity_blockbuf *block,
+				      u64 pos, unsigned long ra_bytes,
 				      unsigned int log_blocksize,
-				      u64 ra_bytes);
+				      struct fsverity_blockbuf *block);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
@@ -183,8 +188,11 @@ struct fsverity_operations {
 	 *
 	 * This is called when fs-verity is done with a block obtained with
 	 * ->read_merkle_tree_block().
+	 *
+	 * If this function is implemented, ->read_merkle_tree_block must also
+	 * be implemented.
 	 */
-	void (*drop_block)(struct fsverity_blockbuf *block);
+	void (*drop_merkle_tree_block)(struct fsverity_blockbuf *block);
 };
 
 #ifdef CONFIG_FS_VERITY


