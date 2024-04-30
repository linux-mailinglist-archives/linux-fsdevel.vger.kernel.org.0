Return-Path: <linux-fsdevel+bounces-18214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE68B6852
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97BD1C21737
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D403FC12;
	Tue, 30 Apr 2024 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkLdvOm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297FDDDA;
	Tue, 30 Apr 2024 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447212; cv=none; b=QU4iVHb3J6TEFIx84OHNcEOdCfpH3BeKXecR31woSXFOG8VwzvjalDd9RmkraWtu+SINlwAvumONkHWKyp9HxXiiM5Vd+FjIeTLRKWGnoc14GYo+HgX77viQAxQDgAbmYoZpPVYd3TmjeClWJAg8KcF+ocwu5Q0TSCTj5YZAvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447212; c=relaxed/simple;
	bh=wS3PJGJAlJkIgqTjH6WHFoGNPaOSkR8DTnrBF6TVQ7E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSNP2Yesr7tmZJuzHM2I2uZ8C8PTA8uoN5UmBO/l8/GxQviILqMidaWux9/MjnuAPrlWb7QGh9m4H9zQ2Y272vZv9AP4d7KbCpvALTmcNr6QAn8ZLU6XHZfyxEMumvKNcSmIt8yKybqSv42UndceMG6fIsuAcLToxt74NB55cU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkLdvOm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575DFC116B1;
	Tue, 30 Apr 2024 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447212;
	bh=wS3PJGJAlJkIgqTjH6WHFoGNPaOSkR8DTnrBF6TVQ7E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AkLdvOm3wHOcDIx4wkDIajMx/2354Vch5OjJKjXLbH7RJEmUT4d6pbq3tHOJWJMyO
	 urepbTxAxZGxSiIjGe30h0anevwZZsCds2PaVviok8uuuQ/DVz9NLqkfKPJZ9BprXV
	 dGfspRM1ikuWoLHgCuEO3oQUqO1BFqgB6HQSj1rpkI6svIEwyoAMiU/mEEA7EeOTUH
	 gCZ7yyak84/4zDUZIVlG2Q0skBspTgp45ZA7ua7EgCeGCK6GdyotahA5W6PY45pDT2
	 eHEp17g3nerkG8jM8Y5Oi4+5L6+r+XoX1OjM22sXcTNFf5ziu2uzRKuD8n7pr8mpFL
	 JEBvdWVDqatmQ==
Date: Mon, 29 Apr 2024 20:20:11 -0700
Subject: [PATCH 03/18] fsverity: convert verification to use byte instead of
 page offsets
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679642.955480.14668034329027994356.stgit@frogsfrogsfrogs>
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

Convert all the hash verification code to use byte offsets instead of
page offsets so that fsverity can support implementations that supply
merkle tree information in units of merkle tree blocks instead of pages.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/fsverity_private.h |    8 ++
 fs/verity/read_metadata.c    |   65 ++++++++-----------
 fs/verity/verify.c           |  145 ++++++++++++++++++++++++++++--------------
 include/linux/fsverity.h     |   19 ++++++
 4 files changed, 152 insertions(+), 85 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180b..8a41e27413284 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -154,4 +154,12 @@ static inline void fsverity_init_signature(void)
 
 void __init fsverity_init_workqueue(void);
 
+int fsverity_read_merkle_tree_block(struct inode *inode,
+				    const struct merkle_tree_params *params,
+				    u64 pos, unsigned long ra_bytes,
+				    struct fsverity_blockbuf *block);
+
+void fsverity_drop_merkle_tree_block(struct inode *inode,
+				     struct fsverity_blockbuf *block);
+
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index f58432772d9ea..4011a02f5d32d 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -14,65 +14,54 @@
 
 static int fsverity_read_merkle_tree(struct inode *inode,
 				     const struct fsverity_info *vi,
-				     void __user *buf, u64 offset, int length)
+				     void __user *buf, u64 pos, int length)
 {
-	const struct fsverity_operations *vops = inode->i_sb->s_vop;
-	u64 end_offset;
-	unsigned int offs_in_page;
-	pgoff_t index, last_index;
+	const u64 end_pos = min(pos + length, vi->tree_params.tree_size);
+	struct backing_dev_info *bdi = inode->i_sb->s_bdi;
+	const u64 max_ra_bytes = min((u64)bdi->io_pages << PAGE_SHIFT,
+				     ULONG_MAX);
+	const struct merkle_tree_params *params = &vi->tree_params;
+	unsigned int offs_in_block = pos & (params->block_size - 1);
 	int retval = 0;
 	int err = 0;
 
-	end_offset = min(offset + length, vi->tree_params.tree_size);
-	if (offset >= end_offset)
-		return 0;
-	offs_in_page = offset_in_page(offset);
-	last_index = (end_offset - 1) >> PAGE_SHIFT;
-
 	/*
-	 * Iterate through each Merkle tree page in the requested range and copy
-	 * the requested portion to userspace.  Note that the Merkle tree block
-	 * size isn't important here, as we are returning a byte stream; i.e.,
-	 * we can just work with pages even if the tree block size != PAGE_SIZE.
+	 * Iterate through each Merkle tree block in the requested range and
+	 * copy the requested portion to userspace. Note that we are returning
+	 * a byte stream.
 	 */
-	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
-		unsigned long num_ra_pages =
-			min_t(unsigned long, last_index - index + 1,
-			      inode->i_sb->s_bdi->io_pages);
-		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
-						   PAGE_SIZE - offs_in_page);
-		struct page *page;
-		const void *virt;
+	while (pos < end_pos) {
+		unsigned long ra_bytes;
+		unsigned int bytes_to_copy;
+		struct fsverity_blockbuf block = { };
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
-			fsverity_err(inode,
-				     "Error %d reading Merkle tree page %lu",
-				     err, index);
+		ra_bytes = min_t(unsigned long, end_pos - pos, max_ra_bytes);
+		bytes_to_copy = min_t(u64, end_pos - pos,
+				      params->block_size - offs_in_block);
+
+		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
+						      pos - offs_in_block,
+						      ra_bytes, &block);
+		if (err)
 			break;
-		}
 
-		virt = kmap_local_page(page);
-		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
-			kunmap_local(virt);
-			put_page(page);
+		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
+			fsverity_drop_merkle_tree_block(inode, &block);
 			err = -EFAULT;
 			break;
 		}
-		kunmap_local(virt);
-		put_page(page);
+		fsverity_drop_merkle_tree_block(inode, &block);
 
 		retval += bytes_to_copy;
 		buf += bytes_to_copy;
-		offset += bytes_to_copy;
+		pos += bytes_to_copy;
 
 		if (fatal_signal_pending(current))  {
 			err = -EINTR;
 			break;
 		}
 		cond_resched();
-		offs_in_page = 0;
+		offs_in_block = 0;
 	}
 	return retval ? retval : err;
 }
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4fcad0825a120..1c4a7c63c0a1c 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -13,12 +13,15 @@
 static struct workqueue_struct *fsverity_read_workqueue;
 
 /*
- * Returns true if the hash block with index @hblock_idx in the tree, located in
- * @hpage, has already been verified.
+ * Returns true if the hash @block with index @hblock_idx in the merkle tree
+ * for @inode has already been verified.
  */
-static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
+static bool is_hash_block_verified(struct inode *inode,
+				   struct fsverity_blockbuf *block,
 				   unsigned long hblock_idx)
 {
+	struct fsverity_info *vi = inode->i_verity_info;
+	struct page *hpage = (struct page *)block->context;
 	unsigned int blocks_per_page;
 	unsigned int i;
 
@@ -90,20 +93,19 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
  */
 static bool
 verify_data_block(struct inode *inode, struct fsverity_info *vi,
-		  const void *data, u64 data_pos, unsigned long max_ra_pages)
+		  const void *data, u64 data_pos, unsigned long max_ra_bytes)
 {
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
 	int level;
+	unsigned long ra_bytes;
 	u8 _want_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	const u8 *want_hash;
 	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	/* The hash blocks that are traversed, indexed by level */
 	struct {
-		/* Page containing the hash block */
-		struct page *page;
-		/* Mapped address of the hash block (will be within @page) */
-		const void *addr;
+		/* Buffer containing the hash block */
+		struct fsverity_blockbuf block;
 		/* Index of the hash block in the tree overall */
 		unsigned long index;
 		/* Byte offset of the wanted hash relative to @addr */
@@ -143,11 +145,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 	for (level = 0; level < params->num_levels; level++) {
 		unsigned long next_hidx;
 		unsigned long hblock_idx;
-		pgoff_t hpage_idx;
-		unsigned int hblock_offset_in_page;
+		u64 hblock_pos;
 		unsigned int hoffset;
-		struct page *hpage;
-		const void *haddr;
+		struct fsverity_blockbuf *block = &hblocks[level].block;
 
 		/*
 		 * The index of the block in the current level; also the index
@@ -158,36 +158,29 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Index of the hash block in the tree overall */
 		hblock_idx = params->level_start[level] + next_hidx;
 
-		/* Index of the hash page in the tree overall */
-		hpage_idx = hblock_idx >> params->log_blocks_per_page;
-
-		/* Byte offset of the hash block within the page */
-		hblock_offset_in_page =
-			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
+		/* Byte offset of the hash block in the tree overall */
+		hblock_pos = (u64)hblock_idx << params->log_blocksize;
 
 		/* Byte offset of the hash within the block */
 		hoffset = (hidx << params->log_digestsize) &
 			  (params->block_size - 1);
 
-		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
-				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
-		if (IS_ERR(hpage)) {
-			fsverity_err(inode,
-				     "Error %ld reading Merkle tree page %lu",
-				     PTR_ERR(hpage), hpage_idx);
+		if (level == 0)
+			ra_bytes = min_t(u64, max_ra_bytes,
+					 params->tree_size - hblock_pos);
+		else
+			ra_bytes = 0;
+
+		if (fsverity_read_merkle_tree_block(inode, params, hblock_pos,
+						    ra_bytes, block) != 0)
 			goto error;
-		}
-		haddr = kmap_local_page(hpage) + hblock_offset_in_page;
-		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
-			memcpy(_want_hash, haddr + hoffset, hsize);
+
+		if (is_hash_block_verified(inode, block, hblock_idx)) {
+			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
-			kunmap_local(haddr);
-			put_page(hpage);
+			fsverity_drop_merkle_tree_block(inode, block);
 			goto descend;
 		}
-		hblocks[level].page = hpage;
-		hblocks[level].addr = haddr;
 		hblocks[level].index = hblock_idx;
 		hblocks[level].hoffset = hoffset;
 		hidx = next_hidx;
@@ -197,8 +190,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 descend:
 	/* Descend the tree verifying hash blocks. */
 	for (; level > 0; level--) {
-		struct page *hpage = hblocks[level - 1].page;
-		const void *haddr = hblocks[level - 1].addr;
+		struct fsverity_blockbuf *block = &hblocks[level - 1].block;
+		const void *haddr = block->kaddr;
 		unsigned long hblock_idx = hblocks[level - 1].index;
 		unsigned int hoffset = hblocks[level - 1].hoffset;
 
@@ -214,11 +207,10 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		if (vi->hash_block_verified)
 			set_bit(hblock_idx, vi->hash_block_verified);
 		else
-			SetPageChecked(hpage);
+			SetPageChecked((struct page *)block->context);
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
-		kunmap_local(haddr);
-		put_page(hpage);
+		fsverity_drop_merkle_tree_block(inode, block);
 	}
 
 	/* Finally, verify the data block. */
@@ -235,16 +227,14 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		     params->hash_alg->name, hsize, want_hash,
 		     params->hash_alg->name, hsize, real_hash);
 error:
-	for (; level > 0; level--) {
-		kunmap_local(hblocks[level - 1].addr);
-		put_page(hblocks[level - 1].page);
-	}
+	for (; level > 0; level--)
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
@@ -262,7 +252,7 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
 
 		data = kmap_local_folio(data_folio, offset);
 		valid = verify_data_block(inode, vi, data, pos + offset,
-					  max_ra_pages);
+					  max_ra_bytes);
 		kunmap_local(data);
 		if (!valid)
 			return false;
@@ -308,7 +298,7 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
 void fsverity_verify_bio(struct bio *bio)
 {
 	struct folio_iter fi;
-	unsigned long max_ra_pages = 0;
+	unsigned long max_ra_bytes = 0;
 
 	if (bio->bi_opf & REQ_RAHEAD) {
 		/*
@@ -320,12 +310,12 @@ void fsverity_verify_bio(struct bio *bio)
 		 * This improves sequential read performance, as it greatly
 		 * reduces the number of I/O requests made to the Merkle tree.
 		 */
-		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
+		max_ra_bytes = bio->bi_iter.bi_size >> 2;
 	}
 
 	bio_for_each_folio_all(fi, bio) {
 		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
-					max_ra_pages)) {
+					max_ra_bytes)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
@@ -362,3 +352,64 @@ void __init fsverity_init_workqueue(void)
 	if (!fsverity_read_workqueue)
 		panic("failed to allocate fsverity_read_queue");
 }
+
+/**
+ * fsverity_read_merkle_tree_block() - read Merkle tree block
+ * @inode: inode to which this Merkle tree block belongs
+ * @params: merkle tree parameters
+ * @pos: byte position within merkle tree
+ * @ra_bytes: try to read ahead this many bytes
+ * @block: block to be loaded
+ *
+ * This function loads data from a merkle tree.
+ */
+int fsverity_read_merkle_tree_block(struct inode *inode,
+				    const struct merkle_tree_params *params,
+				    u64 pos, unsigned long ra_bytes,
+				    struct fsverity_blockbuf *block)
+{
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+	unsigned long page_idx;
+	struct page *page;
+	unsigned long index;
+	unsigned int offset_in_page;
+	int err;
+
+	block->pos = pos;
+	block->size = params->block_size;
+
+	index = pos >> params->log_blocksize;
+	page_idx = round_down(index, params->blocks_per_page);
+	offset_in_page = pos & ~PAGE_MASK;
+
+	page = vops->read_merkle_tree_page(inode, page_idx,
+			ra_bytes >> PAGE_SHIFT);
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		goto bad;
+	}
+
+	block->kaddr = kmap_local_page(page) + offset_in_page;
+	block->context = page;
+	return 0;
+bad:
+	fsverity_err(inode, "Error %d reading Merkle tree block %llu", err,
+			pos);
+	return err;
+}
+
+/**
+ * fsverity_drop_merkle_tree_block() - release resources acquired by
+ * fsverity_read_merkle_tree_block
+ *
+ * @inode: inode to which this Merkle tree block belongs
+ * @block: block to be released
+ */
+void fsverity_drop_merkle_tree_block(struct inode *inode,
+				     struct fsverity_blockbuf *block)
+{
+	kunmap_local(block->kaddr);
+	put_page((struct page *)block->context);
+	block->kaddr = NULL;
+	block->context = NULL;
+}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index ac58b19f23d32..05f8e89e0f470 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -26,6 +26,25 @@
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
 #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
 
+/**
+ * struct fsverity_blockbuf - Merkle Tree block buffer
+ * @context: filesystem private context
+ * @kaddr: virtual address of the block's data
+ * @pos: the position of the block in the Merkle tree (in bytes)
+ * @size: the Merkle tree block size
+ *
+ * Buffer containing a single Merkle Tree block.  When fs-verity wants to read
+ * merkle data from disk, it passes the filesystem a buffer with the @pos,
+ * @index, and @size fields filled out.  The filesystem sets @kaddr and
+ * @context.
+ */
+struct fsverity_blockbuf {
+	void *context;
+	void *kaddr;
+	loff_t pos;
+	unsigned int size;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 


