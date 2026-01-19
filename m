Return-Path: <linux-fsdevel+bounces-74368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27737D39E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A29930552E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9626C38C;
	Mon, 19 Jan 2026 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JaPm8BH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1C26ED59;
	Mon, 19 Jan 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768803813; cv=none; b=L5UjTMOtHhGL3U2Sk4fSVr88FVWKz8a1UFRWNj9OiniC2BhrDAU7AuyX31qeKAnBY1wDvTMQ9y9sTp4UY6DgDfVDOIoBBXhnRXGq5h9jb+ehVaJs8VP3pQvpsuG8rIzSslcDr1+ewSS/3JMbfYTGH8A1y7yfNXbTPQHVmHNqpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768803813; c=relaxed/simple;
	bh=FzRw6KSrZTjv/vDsOrm5f6xDnqWqgH5/6Q6oM8zAonE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyEDKiDiYZgMN+1CfpBdVVXCPQ8TBEZT/4F7TTXrqkWdTBl4X1tRUlF3b0dC10CS1n5tmlschgySl43H4UE/Iy0+MWGy8K1rD9v9ORgG/q/z+cE44zEC9ex7UovHVOGFKeFsRGtgsHX1VsgZZ7eXoUYEKlQojjzqo4ZfyU3Qoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JaPm8BH+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=u3E6xwvibxSvZ4EuYAJN4E1io6j4fxFKnMP4NXWmVc4=; b=JaPm8BH+xZlGBsYFlapxHmEwqJ
	r/VhPgJSO7qIs6chXbUq2dXq2ERdpDpQyqAAhgK2epdwsV86yEmC5oJrAwuDeNmBu+FZr3Xw3SR4V
	OONGM1Cb7Ru2fQuPWkYCLm56+ov3w0B6JNyKX9xgee9UfXEt36QaDsh8tlPjClj3pF0qyzifW5aUW
	zNE9r0jXVE/cQLmryHDAv+Im/fk0JcXgQxeLUv3JEnEGA4v51VqorKPPnv4GaiTzqYkJEanve6vhm
	+CQV2Se2SYMNLuEO3ie3Y65jGJXSPckGYRdoRFmzY7Kk7FngZ9yYrt3dVlJX8ka+TjVG8lc/4Yq/n
	V+9kVSNg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhifg-00000001Op7-2wSF;
	Mon, 19 Jan 2026 06:23:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 6/6] fsverity: kick off hash readahead at data I/O submission time
Date: Mon, 19 Jan 2026 07:22:47 +0100
Message-ID: <20260119062250.3998674-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119062250.3998674-1-hch@lst.de>
References: <20260119062250.3998674-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently all reads of the fsverity hashes is kicked off from the data
I/O completion handler, leading to needlessly dependent I/O.  This is
worked around a bit by performing readahead on the level 0 nodes, but
still fairly ineffective.

Switch to a model where the ->read_folio and ->readahead methods instead
kick off explicit readahead of the fsverity hashed so they are usually
available at I/O completion time.

For 64k sequential reads on my test VM this improves read performance
from 2.4GB/s - 2.6GB/s to 3.5GB/s - 3.9GB/s.  The improvements for
random reads are likely to be even bigger.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/verity.c         |  4 +-
 fs/ext4/readpage.c        |  4 ++
 fs/ext4/verity.c          | 26 +++++------
 fs/f2fs/data.c            |  4 ++
 fs/f2fs/verity.c          | 26 +++++------
 fs/verity/read_metadata.c | 10 ++---
 fs/verity/verify.c        | 92 ++++++++++++++++++++++++++++-----------
 include/linux/fsverity.h  | 34 ++++++++++++---
 8 files changed, 132 insertions(+), 68 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 8a4426f8b5fb..cd96fac4739f 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -697,7 +697,6 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  *
  * @inode:         inode to read a merkle tree page for
  * @index:         page index relative to the start of the merkle tree
- * @num_ra_pages:  number of pages to readahead. Optional, we ignore it
  *
  * The Merkle tree is stored in the filesystem btree, but its pages are cached
  * with a logical position past EOF in the inode's mapping.
@@ -705,8 +704,7 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  * Returns the page we read, or an ERR_PTR on error.
  */
 static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
-						pgoff_t index,
-						unsigned long num_ra_pages)
+						pgoff_t index)
 {
 	struct folio *folio;
 	u64 off = (u64)index << PAGE_SHIFT;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index e7f2350c725b..56b3bea657ef 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -226,6 +226,7 @@ int ext4_mpage_readpages(struct inode *inode,
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
 	unsigned int nr_pages, folio_pages;
+	unsigned int did_fsverity_readahead = 0;
 
 	map.m_pblk = 0;
 	map.m_lblk = 0;
@@ -241,6 +242,9 @@ int ext4_mpage_readpages(struct inode *inode,
 		if (rac)
 			folio = readahead_folio(rac);
 
+		if (!did_fsverity_readahead++)
+			fsverity_readahead(inode, folio->index, nr_pages);
+
 		folio_pages = folio_nr_pages(folio);
 		prefetchw(&folio->flags);
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 2cd6fe2fbf64..baa7277dcf1f 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -358,28 +358,25 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 }
 
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       pgoff_t index)
 {
 	struct folio *folio;
 
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
-	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
-		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
-
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
-	}
+	folio = read_mapping_folio(inode->i_mapping, index, NULL);
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
 	return folio_file_page(folio, index);
 }
 
+static void ext4_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
+{
+	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
+	generic_readahead_merkle_tree(inode, index, nr_pages);
+}
+
 static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
 					u64 pos, unsigned int size)
 {
@@ -393,5 +390,6 @@ const struct fsverity_operations ext4_verityops = {
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,
 	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
+	.readahead_merkle_tree	= ext4_readahead_merkle_tree,
 	.write_merkle_tree_block = ext4_write_merkle_tree_block,
 };
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c30e69392a62..c01d5b309751 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2359,6 +2359,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
+	unsigned int did_fsverity_readahead = 0;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
@@ -2383,6 +2384,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 			prefetchw(&folio->flags);
 		}
 
+		if (!did_fsverity_readahead++)
+			fsverity_readahead(inode, folio->index, nr_pages);
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		index = folio->index;
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 4326fd72cc72..1ce977937c72 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -256,28 +256,25 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 }
 
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       pgoff_t index)
 {
 	struct folio *folio;
 
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
 
-	folio = f2fs_filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
-		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
-
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
-	}
+	folio = read_mapping_folio(inode->i_mapping, index, NULL);
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
 	return folio_file_page(folio, index);
 }
 
+static void f2fs_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
+{
+	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
+	generic_readahead_merkle_tree(inode, index, nr_pages);
+}
+
 static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
 					u64 pos, unsigned int size)
 {
@@ -291,5 +288,6 @@ const struct fsverity_operations f2fs_verityops = {
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,
 	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
+	.readahead_merkle_tree	= f2fs_readahead_merkle_tree,
 	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
 };
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index cba5d6af4e04..3abaa0a4c40e 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -28,24 +28,24 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 	if (offset >= end_offset)
 		return 0;
 	offs_in_page = offset_in_page(offset);
+	index = offset >> PAGE_SHIFT;
 	last_index = (end_offset - 1) >> PAGE_SHIFT;
 
+	__fsverity_readahead(inode, vi, index, last_index - index + 1);
+
 	/*
 	 * Iterate through each Merkle tree page in the requested range and copy
 	 * the requested portion to userspace.  Note that the Merkle tree block
 	 * size isn't important here, as we are returning a byte stream; i.e.,
 	 * we can just work with pages even if the tree block size != PAGE_SIZE.
 	 */
-	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
-		unsigned long num_ra_pages =
-			min_t(unsigned long, last_index - index + 1,
-			      inode->i_sb->s_bdi->io_pages);
+	for (; index <= last_index; index++) {
 		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
 						   PAGE_SIZE - offs_in_page);
 		struct page *page;
 		const void *virt;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
+		page = vops->read_merkle_tree_page(inode, index);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 3cc81658e4f3..9a96bad82938 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -9,6 +9,7 @@
 
 #include <linux/bio.h>
 #include <linux/export.h>
+#include <linux/pagemap.h>
 
 #define FS_VERITY_MAX_PENDING_BLOCKS 2
 
@@ -21,7 +22,6 @@ struct fsverity_pending_block {
 struct fsverity_verification_context {
 	struct inode *inode;
 	struct fsverity_info *vi;
-	unsigned long max_ra_pages;
 
 	/*
 	 * This is the queue of data blocks that are pending verification.  When
@@ -37,6 +37,65 @@ struct fsverity_verification_context {
 
 static struct workqueue_struct *fsverity_read_workqueue;
 
+/**
+ * generic_readahead_merkle_tree() - read ahead from merkle tree
+ * @inode:		inode containing fsverity hashes
+ * @index:		first data page offset to read ahead for
+ * @nr_pages:		number of data pages to read ahead for
+ *
+ * Generic fsverity hashes read implementations for file systems storing
+ * the hashes in the page cache of the data inode.  The caller needs to
+ * adjust @index for the fsverity hash offset.
+ */
+void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages)
+{
+	struct folio *folio;
+
+	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	if (PTR_ERR(folio) == -ENOENT || !folio_test_uptodate(folio)) {
+		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
+
+		page_cache_ra_unbounded(&ractl, nr_pages, 0);
+	}
+	if (!IS_ERR(folio))
+		folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
+
+void __fsverity_readahead(struct inode *inode, const struct fsverity_info *vi,
+		pgoff_t index, unsigned long nr_pages)
+{
+	const struct merkle_tree_params *params = &vi->tree_params;
+	loff_t data_start_pos = (loff_t)index << PAGE_SHIFT;
+	u64 start_hidx = data_start_pos >> params->log_blocksize;
+	u64 end_hidx = (data_start_pos + ((nr_pages - 1) << PAGE_SHIFT)) >>
+			params->log_blocksize;
+	int level;
+
+	if (!inode->i_sb->s_vop->readahead_merkle_tree)
+		return;
+	if (unlikely(data_start_pos >= inode->i_size))
+		return;
+
+	for (level = 0; level < params->num_levels; level++) {
+		unsigned long level_start = params->level_start[level];
+		unsigned long next_start_hidx = start_hidx >> params->log_arity;
+		unsigned long next_end_hidx = end_hidx >> params->log_arity;
+		unsigned long start_idx = (level_start + next_start_hidx) >>
+				params->log_blocks_per_page;
+		unsigned long end_idx = (level_start + next_end_hidx) >>
+				params->log_blocks_per_page;
+
+		inode->i_sb->s_vop->readahead_merkle_tree(inode, start_idx,
+				end_idx - start_idx + 1);
+
+		start_hidx = next_start_hidx;
+		end_hidx = next_end_hidx;
+	}
+}
+EXPORT_SYMBOL_GPL(__fsverity_readahead);
+
 /*
  * Returns true if the hash block with index @hblock_idx in the tree, located in
  * @hpage, has already been verified.
@@ -114,8 +173,7 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
  * Return: %true if the data block is valid, else %false.
  */
 static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
-			      const struct fsverity_pending_block *dblock,
-			      unsigned long max_ra_pages)
+			      const struct fsverity_pending_block *dblock)
 {
 	const u64 data_pos = dblock->pos;
 	const struct merkle_tree_params *params = &vi->tree_params;
@@ -200,8 +258,7 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			  (params->block_size - 1);
 
 		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
-				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
+				hpage_idx);
 		if (IS_ERR(hpage)) {
 			fsverity_err(inode,
 				     "Error %ld reading Merkle tree page %lu",
@@ -272,12 +329,10 @@ static bool verify_data_block(struct inode *inode, struct fsverity_info *vi,
 
 static void
 fsverity_init_verification_context(struct fsverity_verification_context *ctx,
-				   struct inode *inode,
-				   unsigned long max_ra_pages)
+				   struct inode *inode)
 {
 	ctx->inode = inode;
 	ctx->vi = fsverity_get_info(inode);
-	ctx->max_ra_pages = max_ra_pages;
 	ctx->num_pending = 0;
 	if (ctx->vi->tree_params.hash_alg->algo_id == HASH_ALGO_SHA256 &&
 	    sha256_finup_2x_is_optimized())
@@ -320,8 +375,7 @@ fsverity_verify_pending_blocks(struct fsverity_verification_context *ctx)
 	}
 
 	for (i = 0; i < ctx->num_pending; i++) {
-		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i],
-				       ctx->max_ra_pages))
+		if (!verify_data_block(ctx->inode, vi, &ctx->pending_blocks[i]))
 			return false;
 	}
 	fsverity_clear_pending_blocks(ctx);
@@ -371,7 +425,7 @@ bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset)
 {
 	struct fsverity_verification_context ctx;
 
-	fsverity_init_verification_context(&ctx, folio->mapping->host, 0);
+	fsverity_init_verification_context(&ctx, folio->mapping->host);
 
 	if (fsverity_add_data_blocks(&ctx, folio, len, offset) &&
 	    fsverity_verify_pending_blocks(&ctx))
@@ -401,22 +455,8 @@ void fsverity_verify_bio(struct bio *bio)
 	struct inode *inode = bio_first_folio_all(bio)->mapping->host;
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
-	unsigned long max_ra_pages = 0;
-
-	if (bio->bi_opf & REQ_RAHEAD) {
-		/*
-		 * If this bio is for data readahead, then we also do readahead
-		 * of the first (largest) level of the Merkle tree.  Namely,
-		 * when a Merkle tree page is read, we also try to piggy-back on
-		 * some additional pages -- up to 1/4 the number of data pages.
-		 *
-		 * This improves sequential read performance, as it greatly
-		 * reduces the number of I/O requests made to the Merkle tree.
-		 */
-		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
-	}
 
-	fsverity_init_verification_context(&ctx, inode, max_ra_pages);
+	fsverity_init_verification_context(&ctx, inode);
 
 	bio_for_each_folio_all(fi, bio) {
 		if (!fsverity_add_data_blocks(&ctx, fi.folio, fi.length,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index deb6b2303d64..84aaa09e07e2 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -90,10 +90,6 @@ struct fsverity_operations {
 	 *
 	 * @inode: the inode
 	 * @index: 0-based index of the page within the Merkle tree
-	 * @num_ra_pages: The number of Merkle tree pages that should be
-	 *		  prefetched starting at @index if the page at @index
-	 *		  isn't already cached.  Implementations may ignore this
-	 *		  argument; it's only a performance optimization.
 	 *
 	 * This can be called at any time on an open verity file.  It may be
 	 * called by multiple processes concurrently, even with the same page.
@@ -103,8 +99,10 @@ struct fsverity_operations {
 	 * Return: the page on success, ERR_PTR() on failure
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
-					      pgoff_t index,
-					      unsigned long num_ra_pages);
+					      pgoff_t index);
+
+	void (*readahead_merkle_tree)(struct inode *inode, pgoff_t index,
+			unsigned long nr_pages);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
@@ -246,4 +244,28 @@ static inline bool fsverity_active(const struct inode *inode)
 	return fsverity_get_info(inode) != NULL;
 }
 
+/**
+ * fsverity_readahead() - kick off readahead on fsverity hashes
+ * @inode:		inode containing fsverity hashes
+ * @index:		first data page offset to read ahead for
+ * @nr_pages:		number of data pages to read ahead for
+ *
+ * Start readahead on fsverity hashes.  To be called from the file systems
+ * ->read_folio and ->readahead methods to ensure that the hashes are
+ * already cached on completion of the file data read if possible.
+ */
+void __fsverity_readahead(struct inode *inode, const struct fsverity_info *vi,
+		pgoff_t index, unsigned long nr_pages);
+static inline void fsverity_readahead(struct inode *inode,
+		pgoff_t index, unsigned long nr_pages)
+{
+	const struct fsverity_info *vi = fsverity_get_info(inode);
+
+	if (vi)
+		__fsverity_readahead(inode, vi, index, nr_pages);
+}
+
+void generic_readahead_merkle_tree(struct inode *inode, pgoff_t index,
+		unsigned long nr_pages);
+
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3


