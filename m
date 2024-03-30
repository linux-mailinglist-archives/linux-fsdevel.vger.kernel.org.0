Return-Path: <linux-fsdevel+bounces-15705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B7B892823
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4986A2825C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BFA15C9;
	Sat, 30 Mar 2024 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaLQs9b6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D477E2;
	Sat, 30 Mar 2024 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758808; cv=none; b=SqfUclyCAXN/Zw9bkGXOqpuFL4NLXylogESNABonEoBSMSqCPO58hkciIlwnfto6TBccWaDxJtg9WvNhVoI4TG6YWf1rADDUYIdnJgAV8c3kFfifs9VEX5Ysxx1/jtHQeWkeWe80XdBbpsK/mpk6/FRMq99y4ep29AN+VSDclsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758808; c=relaxed/simple;
	bh=XmKecSYBB/1ShfGBv1o8oxx7ZiB3x6lEuMeZH7rQ46c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vg0NLojS7uuIkxdJ1DvlVQ9lgMZSMtngdl7UjsjqEvkxgz3IM2ETbg9Mwqaf6QuG/PeTTayIl7SRos/l7UYIdG6iqg2wErUQHHDrIOyOm33G7oYp7eQLfCvJewnswE6lcheZ2gULmL0KZuVA9f9wq7XSPxcD+apoHWxOtClhKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaLQs9b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48F4C433F1;
	Sat, 30 Mar 2024 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711758807;
	bh=XmKecSYBB/1ShfGBv1o8oxx7ZiB3x6lEuMeZH7rQ46c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QaLQs9b6JEyRL+dAElyPjYxRJM6fUzFQEyaFWOnB85YZT25CMY/AMsL8xv/G7gXgB
	 OUM7MLAsedlqqgP6r91L2WeWWoHEIVAcbYFeS5sGeXW2I5pSfROXiBvh5v/SYpPEeg
	 KzZgpsvart2P0m3OOP4ijXe77FNJus4UKPMsBDoobtJjZXzobLXGbBCPZsuFDrWJ4q
	 rcyXCXa727Z4l/E5ufXqNQnvqF6bUtCxFdlT1ocR0VmIHmEfv3JLEiRh3mb0UjMlg0
	 bXGnpgZv98LfYDK+u4zjSDNTq1l6JYk8L3DwVRPgLHEZgLaDnu6IapdXUwlytvCH0D
	 xBMRt+704cIkA==
Date: Fri, 29 Mar 2024 17:33:27 -0700
Subject: [PATCH 03/13] fsverity: support block-based Merkle tree caching
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175867913.1987804.4275409634176359386.stgit@frogsfrogsfrogs>
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

In the current implementation fs-verity expects filesystem to provide
PAGEs filled with Merkle tree blocks. Then, when fs-verity is done with
processing the blocks, reference to PAGE is freed. This doesn't fit well
with the way XFS manages its memory.

To allow XFS integrate fs-verity this patch adds ability to fs-verity
verification code to take Merkle tree blocks instead of PAGE reference.
This way ext4, f2fs, and btrfs are still able to pass PAGE references
and XFS can pass reference to Merkle tree blocks stored in XFS's
extended attribute infrastructure.

To achieve this, the XFS implementation will implement its own incore
merkle tree block cache.  These blocks will be passed to fsverity when
it needs to read a merkle tree block, and dropped  by fsverity when
validation completes.  The cache will keep track of whether or not a
given block has already been verified, which will improve performance on
random reads.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
[djwong: fix uninit err variable, remove dependency on bitmap, apply
 various suggestions from maintainer, tighten changelog]
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/verity/fsverity_private.h |   37 ++++++++++
 fs/verity/open.c             |    7 ++
 fs/verity/read_metadata.c    |   63 ++++++++---------
 fs/verity/verify.c           |  152 ++++++++++++++++++++++++++++++------------
 include/linux/fsverity.h     |   76 +++++++++++++++++++++
 5 files changed, 255 insertions(+), 80 deletions(-)


diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180b..c9d97c2bebd84 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -154,4 +154,41 @@ static inline void fsverity_init_signature(void)
 
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
+	if (fsverity_caches_blocks(inode))
+		return false;
+
+	/*
+	 * If fs uses block-based Merkle tree caching, then fs-verity must use
+	 * hash_block_verified bitmap as there's no page to mark it with
+	 * PG_checked.
+	 */
+	return vi->tree_params.block_size != PAGE_SIZE;
+}
+
+int fsverity_read_merkle_tree_block(struct inode *inode,
+				    const struct merkle_tree_params *params,
+				    u64 pos, unsigned long ra_bytes,
+				    struct fsverity_blockbuf *block);
+
+/*
+ * Drop 'block' obtained with ->read_merkle_tree_block(). Calls out back to
+ * filesystem if ->drop_merkle_tree_block() is set, otherwise, drop the
+ * reference in the block->context.
+ */
+void fsverity_drop_merkle_tree_block(struct inode *inode,
+				     struct fsverity_blockbuf *block);
+
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af3..9603b3a404f74 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -213,7 +213,12 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 	if (err)
 		goto fail;
 
-	if (vi->tree_params.block_size != PAGE_SIZE) {
+	/*
+	 * If fs uses block-based Merkle tree cachin, then fs-verity must use
+	 * hash_block_verified bitmap as there's no page to mark it with
+	 * PG_checked.
+	 */
+	if (fsverity_uses_bitmap(vi, inode)) {
 		/*
 		 * When the Merkle tree block size and page size differ, we use
 		 * a bitmap to keep track of which hash blocks have been
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index f58432772d9ea..94fffa060f829 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -14,65 +14,60 @@
 
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
+	const struct merkle_tree_params *params = &vi->tree_params;
+	unsigned int offs_in_block = pos & (params->block_size - 1);
 	int retval = 0;
 	int err = 0;
 
-	end_offset = min(offset + length, vi->tree_params.tree_size);
-	if (offset >= end_offset)
+	if (pos >= end_pos)
 		return 0;
-	offs_in_page = offset_in_page(offset);
-	last_index = (end_offset - 1) >> PAGE_SHIFT;
 
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
+		struct fsverity_blockbuf block = {
+			.size = params->block_size,
+		};
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
+		ra_bytes = min_t(unsigned long, end_pos - pos + 1,
+				 inode->i_sb->s_bdi->io_pages << PAGE_SHIFT);
+		bytes_to_copy = min_t(u64, end_pos - pos,
+				      params->block_size - offs_in_block);
+
+		err = fsverity_read_merkle_tree_block(inode, &vi->tree_params,
+				pos - offs_in_block, ra_bytes, &block);
+		if (err) {
 			fsverity_err(inode,
-				     "Error %d reading Merkle tree page %lu",
-				     err, index);
+				     "Error %d reading Merkle tree block %llu",
+				     err, pos);
 			break;
 		}
 
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
index 4fcad0825a120..0b5e11073e883 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -13,14 +13,27 @@
 static struct workqueue_struct *fsverity_read_workqueue;
 
 /*
- * Returns true if the hash block with index @hblock_idx in the tree, located in
- * @hpage, has already been verified.
+ * Returns true if the hash block with index @hblock_idx in the tree has
+ * already been verified.
  */
-static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
+static bool is_hash_block_verified(struct inode *inode,
+				   struct fsverity_blockbuf *block,
 				   unsigned long hblock_idx)
 {
 	unsigned int blocks_per_page;
 	unsigned int i;
+	struct fsverity_info *vi = inode->i_verity_info;
+	struct page *hpage;
+
+	/*
+	 * If the filesystem uses block-based caching, then rely on the
+	 * implementation to retain verified status.
+	 */
+	if (fsverity_caches_blocks(inode))
+		return block->verified;
+
+	/* Otherwise, the filesystem uses page-based caching. */
+	hpage = (struct page *)block->context;
 
 	/*
 	 * When the Merkle tree block size and page size are the same, then the
@@ -31,7 +44,7 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
 	 * get evicted and re-instantiated from the backing storage, as new
 	 * pages always start out with PG_checked cleared.
 	 */
-	if (!vi->hash_block_verified)
+	if (!fsverity_uses_bitmap(vi, inode))
 		return PageChecked(hpage);
 
 	/*
@@ -90,20 +103,20 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
  */
 static bool
 verify_data_block(struct inode *inode, struct fsverity_info *vi,
-		  const void *data, u64 data_pos, unsigned long max_ra_pages)
+		  const void *data, u64 data_pos, unsigned long max_ra_bytes)
 {
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
 	int level;
+	int err = 0;
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
@@ -143,11 +156,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
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
@@ -158,36 +169,34 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Index of the hash block in the tree overall */
 		hblock_idx = params->level_start[level] + next_hidx;
 
-		/* Index of the hash page in the tree overall */
-		hpage_idx = hblock_idx >> params->log_blocks_per_page;
-
-		/* Byte offset of the hash block within the page */
-		hblock_offset_in_page =
-			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
+		/* Byte offset of the hash block in the tree overall */
+		hblock_pos = hblock_idx << params->log_blocksize;
 
 		/* Byte offset of the hash within the block */
 		hoffset = (hidx << params->log_digestsize) &
 			  (params->block_size - 1);
 
-		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
-				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
-		if (IS_ERR(hpage)) {
+		if (level == 0)
+			ra_bytes = min(max_ra_bytes,
+				       params->tree_size - hblock_pos);
+		else
+			ra_bytes = 0;
+
+		err = fsverity_read_merkle_tree_block(inode, params, hblock_pos,
+				ra_bytes, block);
+		if (err) {
 			fsverity_err(inode,
-				     "Error %ld reading Merkle tree page %lu",
-				     PTR_ERR(hpage), hpage_idx);
+				     "Error %d reading Merkle tree block %llu",
+				     err, hblock_pos);
 			goto error;
 		}
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
@@ -197,8 +206,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 descend:
 	/* Descend the tree verifying hash blocks. */
 	for (; level > 0; level--) {
-		struct page *hpage = hblocks[level - 1].page;
-		const void *haddr = hblocks[level - 1].addr;
+		struct fsverity_blockbuf *block = &hblocks[level - 1].block;
+		const void *haddr = block->kaddr;
 		unsigned long hblock_idx = hblocks[level - 1].index;
 		unsigned int hoffset = hblocks[level - 1].hoffset;
 
@@ -211,14 +220,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		 * idempotent, as the same hash block might be verified by
 		 * multiple threads concurrently.
 		 */
-		if (vi->hash_block_verified)
+		if (fsverity_caches_blocks(inode))
+			block->verified = true;
+		else if (fsverity_uses_bitmap(vi, inode))
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
@@ -235,16 +245,14 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
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
@@ -262,7 +270,7 @@ verify_data_blocks(struct folio *data_folio, size_t len, size_t offset,
 
 		data = kmap_local_folio(data_folio, offset);
 		valid = verify_data_block(inode, vi, data, pos + offset,
-					  max_ra_pages);
+					  max_ra_bytes);
 		kunmap_local(data);
 		if (!valid)
 			return false;
@@ -325,7 +333,7 @@ void fsverity_verify_bio(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
-					max_ra_pages)) {
+					max_ra_pages << PAGE_SHIFT)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
@@ -362,3 +370,57 @@ void __init fsverity_init_workqueue(void)
 	if (!fsverity_read_workqueue)
 		panic("failed to allocate fsverity_read_queue");
 }
+
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
+{
+	const struct fsverity_operations *vops = inode->i_sb->s_vop;
+	unsigned long page_idx;
+	struct page *page;
+	unsigned long index;
+	unsigned int offset_in_page;
+
+	if (fsverity_caches_blocks(inode)) {
+		block->verified = false;
+		return vops->read_merkle_tree_block(inode, pos, ra_bytes,
+				params->log_blocksize, block);
+	}
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
+		kunmap_local(block->kaddr);
+		put_page((struct page *)block->context);
+	}
+	block->kaddr = NULL;
+	block->context = NULL;
+}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index ac58b19f23d32..c3478efd67d62 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -26,6 +26,35 @@
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
 #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
 
+/**
+ * struct fsverity_blockbuf - Merkle Tree block buffer
+ * @kaddr: virtual address of the block's data
+ * @offset: block's offset into Merkle tree
+ * @size: the Merkle tree block size
+ * @context: filesystem private context
+ * @verified: has this buffer been validated?
+ *
+ * Buffer containing single Merkle Tree block. These buffers are passed
+ *  - to filesystem, when fs-verity is building merkel tree,
+ *  - from filesystem, when fs-verity is reading merkle tree from a disk.
+ * Filesystems sets kaddr together with size to point to a memory which contains
+ * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
+ * written down to disk.
+ *
+ * While reading the tree, fs-verity calls ->read_merkle_tree_block followed by
+ * ->drop_merkle_tree_block to let filesystem know that memory can be freed.
+ *
+ * The context is optional. This field can be used by filesystem to passthrough
+ * state from ->read_merkle_tree_block to ->drop_merkle_tree_block.
+ */
+struct fsverity_blockbuf {
+	void *kaddr;
+	u64 offset;
+	unsigned int verified:1;
+	unsigned int size;
+	void *context;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 
@@ -101,12 +130,43 @@ struct fsverity_operations {
 	 *
 	 * Note that this must retrieve a *page*, not necessarily a *block*.
 	 *
+	 * If this function is implemented, do not implement
+	 * ->read_merkle_tree_block or ->drop_merkle_tree_block.
+	 *
 	 * Return: the page on success, ERR_PTR() on failure
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
 					      pgoff_t index,
 					      unsigned long num_ra_pages);
 
+	/**
+	 * Read a Merkle tree block of the given inode.
+	 * @inode: the inode
+	 * @pos: byte offset of the block within the Merkle tree
+	 * @ra_bytes: The number of bytes that should be
+	 *		prefetched starting at @pos if the page at @pos
+	 *		isn't already cached.  Implementations may ignore this
+	 *		argument; it's only a performance optimization.
+	 * @log_blocksize: log2 of the size of the expected block
+	 * @block: block buffer for filesystem to point it to the block
+	 *
+	 * This can be called at any time on an open verity file.  It may be
+	 * called by multiple processes concurrently.
+	 *
+	 * Implementations may cache the @block->verified state in
+	 * ->drop_merkle_tree_block.  They must clear the @block->verified
+	 * flag for a cache miss.
+	 *
+	 * If this function is implemented, ->drop_merkle_tree_block must also
+	 * be implemented.
+	 *
+	 * Return: 0 on success, -errno on failure
+	 */
+	int (*read_merkle_tree_block)(struct inode *inode,
+				      u64 pos, unsigned long ra_bytes,
+				      unsigned int log_blocksize,
+				      struct fsverity_blockbuf *block);
+
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
@@ -122,6 +182,22 @@ struct fsverity_operations {
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Release the reference to a Merkle tree block
+	 *
+	 * @block: the block to release
+	 *
+	 * This is called when fs-verity is done with a block obtained with
+	 * ->read_merkle_tree_block().
+	 *
+	 * Implementations should cache a @block->verified==1 state to avoid
+	 * unnecessary revalidations during later accesses.
+	 *
+	 * If this function is implemented, ->read_merkle_tree_block must also
+	 * be implemented.
+	 */
+	void (*drop_merkle_tree_block)(struct fsverity_blockbuf *block);
 };
 
 #ifdef CONFIG_FS_VERITY


