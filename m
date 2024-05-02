Return-Path: <linux-fsdevel+bounces-18471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758738B93F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 06:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E3EB21948
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD701CA9E;
	Thu,  2 May 2024 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xww+pwET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E619BBA;
	Thu,  2 May 2024 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624931; cv=none; b=MBHl4KVTg0qwItDsIburi5266Vr8BWNsXGZAvM8DruInr4TVCczkX25eD6QEq/pDgiBA2x/iAiuNbk6f439vqFpZJ0qyn3PuJi1unjvSyn7N0/v5KeCMTyS17wKvw7XPuyRCtWMoAzhh/JZ1SsykCvMqgbEDDlx+cpbEO5BJtEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624931; c=relaxed/simple;
	bh=B1x67HiBknRQiTHBiFuIC4mTbCiPHBZG3VHAZv988n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9L2quuyVf7MHsAL8vHHvrE2z+5hYm0OC1hjKEOT/naDu10D7fQJnQ4vtgez6BEcNG2ZxPaN4EBSdN0P7Ktje6QtW/OMg/48qUGY4bv4ltGGBFPeOpk3dzscoJTl8Dtn1FVLqhXNaX+VcPxnZ1LI5CxhlHWMmEZH+EnuhFo12+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xww+pwET; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YibHzwSIkkMNCGZCDCKVosxiFB3JitpPRRNGyxYCybA=; b=xww+pwETAq9EMsxTv7eP62KAtu
	R9Gd47e/ge9EPxaWbqJYDVwHYDHt/YFGIRgUyuvjOD5xFYsoe4E72vikjKomSo4biiPD3+AAjvuvh
	asevIjbVHEZaZ+kbDG/j6rpQjZbAVZ3EQcWXikpt8dUwpm6GbpHGeH9s1jzQIL1gNzh+brK/efeQX
	WtNYBSWqC5tSyCMRMVbZfTn5zNqs90fo4L8Ej57+baDDep+g29kYq1ZA9rq3zhwUFlbAxqmX6mpN8
	XH2J6MEMsiOYIoZlVFFBt6tAoTu9iygrAq4vGdD2ulEmOTFZNzlHhPHNnI3wX0fR3f0dvCCQNbOW0
	/RdWNrLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2OGl-0000000BRfw-3ZtG;
	Thu, 02 May 2024 04:42:07 +0000
Date: Wed, 1 May 2024 21:42:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	ebiggers@kernel.org, linux-xfs@vger.kernel.org, alexl@redhat.com,
	walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/18] fsverity: support block-based Merkle tree caching
Message-ID: <ZjMZnxgFZ_X6c9aB@infradead.org>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
 <171444679658.955480.4637262867075831070.stgit@frogsfrogsfrogs>
 <ZjHw6wt3K164hOBr@infradead.org>
 <20240501223519.GG360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501223519.GG360919@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 01, 2024 at 03:35:19PM -0700, Darrick J. Wong wrote:
> Got a link?  This is the first I've heard of this, but TBH I've been
> ignoring a /lot/ of things trying to get online repair merged (thank
> you!) over the past months...

This was long before I got involved with repair :)

Below is what I found in my local tree.  It doesn't have a proper commit
log, so I probably only sent it out as a RFC in reply to a patch series
posting, most likely untested:

commit c11dcbe101a240c7a9e9bae7efaff2779d88b292
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Oct 16 14:14:11 2023 +0200

    fsverity block interface

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index af889512c6ac99..c616d530a89086 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -648,7 +648,7 @@ which verifies data that has been read into the pagecache of a verity
 inode.  The containing folio must still be locked and not Uptodate, so
 it's not yet readable by userspace.  As needed to do the verification,
 fsverity_verify_blocks() will call back into the filesystem to read
-hash blocks via fsverity_operations::read_merkle_tree_page().
+hash blocks via fsverity_operations::read_merkle_tree_block().
 
 fsverity_verify_blocks() returns false if verification failed; in this
 case, the filesystem must not set the folio Uptodate.  Following this,
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 2b34796f68d349..4b6134923232e7 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -713,20 +713,20 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  *
  * Returns the page we read, or an ERR_PTR on error.
  */
-static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
-						pgoff_t index,
-						unsigned long num_ra_pages,
-						u8 log_blocksize)
+static int btrfs_read_merkle_tree_block(struct inode *inode,
+		unsigned int offset, struct fsverity_block *block,
+		unsigned long num_ra_pages)
 {
 	struct folio *folio;
+	pgoff_t index = offset >> PAGE_SHIFT;
 	u64 off = (u64)index << PAGE_SHIFT;
 	loff_t merkle_pos = merkle_file_pos(inode);
 	int ret;
 
 	if (merkle_pos < 0)
-		return ERR_PTR(merkle_pos);
+		return merkle_pos;
 	if (merkle_pos > inode->i_sb->s_maxbytes - off - PAGE_SIZE)
-		return ERR_PTR(-EFBIG);
+		return -EFBIG;
 	index += merkle_pos >> PAGE_SHIFT;
 again:
 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
@@ -739,7 +739,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 		if (!folio_test_uptodate(folio)) {
 			folio_unlock(folio);
 			folio_put(folio);
-			return ERR_PTR(-EIO);
+			return -EIO;
 		}
 		folio_unlock(folio);
 		goto out;
@@ -748,7 +748,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 	folio = filemap_alloc_folio(mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS),
 				    0);
 	if (!folio)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	ret = filemap_add_folio(inode->i_mapping, folio, index, GFP_NOFS);
 	if (ret) {
@@ -756,7 +756,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 		/* Did someone else insert a folio here? */
 		if (ret == -EEXIST)
 			goto again;
-		return ERR_PTR(ret);
+		return ret;
 	}
 
 	/*
@@ -769,7 +769,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 			     folio_address(folio), PAGE_SIZE, &folio->page);
 	if (ret < 0) {
 		folio_put(folio);
-		return ERR_PTR(ret);
+		return ret;
 	}
 	if (ret < PAGE_SIZE)
 		folio_zero_segment(folio, ret, PAGE_SIZE);
@@ -778,7 +778,8 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 	folio_unlock(folio);
 
 out:
-	return folio_file_page(folio, index);
+	return fsverity_set_block_page(block, folio_file_page(folio, index),
+				       offset);
 }
 
 /*
@@ -809,6 +810,7 @@ const struct fsverity_operations btrfs_verityops = {
 	.begin_enable_verity     = btrfs_begin_enable_verity,
 	.end_enable_verity       = btrfs_end_enable_verity,
 	.get_verity_descriptor   = btrfs_get_verity_descriptor,
-	.read_merkle_tree_page   = btrfs_read_merkle_tree_page,
+	.read_merkle_tree_block  = btrfs_read_merkle_tree_block,
 	.write_merkle_tree_block = btrfs_write_merkle_tree_block,
+	.drop_merkle_tree_block	 = fsverity_drop_page_merke_tree_block,
 };
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 4e2f01f048c09b..5623e2c1c302e8 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -358,15 +358,13 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 	return desc_size;
 }
 
-static struct page *ext4_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages,
-					       u8 log_blocksize)
+static int ext4_read_merkle_tree_block(struct inode *inode, unsigned int offset,
+		struct fsverity_block *block, unsigned long num_ra_pages)
 {
 	struct folio *folio;
+	pgoff_t index;
 
-	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
-
+	index = (ext4_verity_metadata_pos(inode) + offset) >> PAGE_SHIFT;
 	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
 	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
@@ -377,9 +375,10 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
 		folio = read_mapping_folio(inode->i_mapping, index, NULL);
 		if (IS_ERR(folio))
-			return ERR_CAST(folio);
+			return PTR_ERR(folio);
 	}
-	return folio_file_page(folio, index);
+	return fsverity_set_block_page(block, folio_file_page(folio, index),
+				       offset);
 }
 
 static int ext4_write_merkle_tree_block(struct inode *inode, const void *buf,
@@ -394,6 +393,7 @@ const struct fsverity_operations ext4_verityops = {
 	.begin_enable_verity	= ext4_begin_enable_verity,
 	.end_enable_verity	= ext4_end_enable_verity,
 	.get_verity_descriptor	= ext4_get_verity_descriptor,
-	.read_merkle_tree_page	= ext4_read_merkle_tree_page,
+	.read_merkle_tree_block	= ext4_read_merkle_tree_block,
 	.write_merkle_tree_block = ext4_write_merkle_tree_block,
+	.drop_merkle_tree_block	= fsverity_drop_page_merke_tree_block,
 };
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 601ab9f0c02492..aac9281e9c4565 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -255,15 +255,13 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 	return size;
 }
 
-static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
-					       pgoff_t index,
-					       unsigned long num_ra_pages,
-					       u8 log_blocksize)
+static int f2fs_read_merkle_tree_block(struct inode *inode, unsigned int offset,
+		struct fsverity_block *block, unsigned long num_ra_pages)
 {
 	struct page *page;
+	pgoff_t index;
 
-	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
-
+	index = (f2fs_verity_metadata_pos(inode) + offset) >> PAGE_SHIFT;
 	page = find_get_page_flags(inode->i_mapping, index, FGP_ACCESSED);
 	if (!page || !PageUptodate(page)) {
 		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
@@ -274,7 +272,7 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
 		page = read_mapping_page(inode->i_mapping, index, NULL);
 	}
-	return page;
+	return fsverity_set_block_page(block, page, offset);
 }
 
 static int f2fs_write_merkle_tree_block(struct inode *inode, const void *buf,
@@ -289,6 +287,7 @@ const struct fsverity_operations f2fs_verityops = {
 	.begin_enable_verity	= f2fs_begin_enable_verity,
 	.end_enable_verity	= f2fs_end_enable_verity,
 	.get_verity_descriptor	= f2fs_get_verity_descriptor,
-	.read_merkle_tree_page	= f2fs_read_merkle_tree_page,
+	.read_merkle_tree_block	= f2fs_read_merkle_tree_block,
 	.write_merkle_tree_block = f2fs_write_merkle_tree_block,
+	.drop_merkle_tree_block	= fsverity_drop_page_merke_tree_block,
 };
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 182bddf5dec54c..5e362f8562bd5d 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -12,10 +12,33 @@
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 
+int fsverity_set_block_page(struct fsverity_block *block,
+		struct page *page, unsigned int index)
+{
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	block->kaddr = page_address(page) + (index % PAGE_SIZE);
+	block->cached = PageChecked(page);
+	block->context = page;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_set_block_page);
+
+void fsverity_drop_page_merke_tree_block(struct fsverity_block *block)
+{
+	struct page *page = block->context;
+
+	if (block->verified)
+		SetPageChecked(page);
+	put_page(page);
+}
+EXPORT_SYMBOL_GPL(fsverity_drop_page_merke_tree_block);
+
 static int fsverity_read_merkle_tree(struct inode *inode,
 				     const struct fsverity_info *vi,
 				     void __user *buf, u64 offset, int length)
 {
+	const struct fsverity_operations *vop = inode->i_sb->s_vop;
 	u64 end_offset;
 	unsigned int offs_in_block;
 	unsigned int block_size = vi->tree_params.block_size;
@@ -45,20 +68,19 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 		struct fsverity_block block;
 
 		block.len = block_size;
-		if (fsverity_read_merkle_tree_block(inode,
-					index << vi->tree_params.log_blocksize,
-					&block, num_ra_pages)) {
-			fsverity_drop_block(inode, &block);
+		if (vop->read_merkle_tree_block(inode,
+				index << vi->tree_params.log_blocksize,
+				&block, num_ra_pages)) {
 			err = -EFAULT;
 			break;
 		}
 
 		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
-			fsverity_drop_block(inode, &block);
+			vop->drop_merkle_tree_block(&block);
 			err = -EFAULT;
 			break;
 		}
-		fsverity_drop_block(inode, &block);
+		vop->drop_merkle_tree_block(&block);
 		block.kaddr = NULL;
 
 		retval += bytes_to_copy;
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index dfe01f12184341..9b84262a6fa413 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -42,6 +42,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		  const void *data, u64 data_pos, unsigned long max_ra_pages)
 {
 	const struct merkle_tree_params *params = &vi->tree_params;
+	const struct fsverity_operations *vop = inode->i_sb->s_vop;
 	const unsigned int hsize = params->digest_size;
 	int level;
 	int err;
@@ -115,9 +116,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		block->len = params->block_size;
 		num_ra_pages = level == 0 ?
 			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
-		err = fsverity_read_merkle_tree_block(
-			inode, hblock_idx << params->log_blocksize, block,
-			num_ra_pages);
+		err = vop->read_merkle_tree_block(inode,
+				hblock_idx << params->log_blocksize, block,
+				num_ra_pages);
 		if (err) {
 			fsverity_err(inode,
 				     "Error %d reading Merkle tree block %lu",
@@ -127,7 +128,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		if (is_hash_block_verified(vi, hblock_idx, block->cached)) {
 			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
-			fsverity_drop_block(inode, block);
+			vop->drop_merkle_tree_block(block);
 			goto descend;
 		}
 		hblocks[level].index = hblock_idx;
@@ -157,7 +158,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		block->verified = true;
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
-		fsverity_drop_block(inode, block);
+		vop->drop_merkle_tree_block(block);
 	}
 
 	/* Finally, verify the data block. */
@@ -174,9 +175,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		     params->hash_alg->name, hsize, want_hash,
 		     params->hash_alg->name, hsize, real_hash);
 error:
-	for (; level > 0; level--) {
-		fsverity_drop_block(inode, &hblocks[level - 1].block);
-	}
+	for (; level > 0; level--)
+		vop->drop_merkle_tree_block(&hblocks[level - 1].block);
 	return false;
 }
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index ce37a430bc97f2..ae9ae7719af558 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -104,27 +104,6 @@ struct fsverity_operations {
 	int (*get_verity_descriptor)(struct inode *inode, void *buf,
 				     size_t bufsize);
 
-	/**
-	 * Read a Merkle tree page of the given inode.
-	 *
-	 * @inode: the inode
-	 * @index: 0-based index of the page within the Merkle tree
-	 * @num_ra_pages: The number of Merkle tree pages that should be
-	 *		  prefetched starting at @index if the page at @index
-	 *		  isn't already cached.  Implementations may ignore this
-	 *		  argument; it's only a performance optimization.
-	 *
-	 * This can be called at any time on an open verity file.  It may be
-	 * called by multiple processes concurrently, even with the same page.
-	 *
-	 * Note that this must retrieve a *page*, not necessarily a *block*.
-	 *
-	 * Return: the page on success, ERR_PTR() on failure
-	 */
-	struct page *(*read_merkle_tree_page)(struct inode *inode,
-					      pgoff_t index,
-					      unsigned long num_ra_pages,
-					      u8 log_blocksize);
 	/**
 	 * Read a Merkle tree block of the given inode.
 	 * @inode: the inode
@@ -162,13 +141,12 @@ struct fsverity_operations {
 
 	/**
 	 * Release the reference to a Merkle tree block
-	 *
-	 * @page: the block to release
+	 * @block: the block to release
 	 *
 	 * This is called when fs-verity is done with a block obtained with
 	 * ->read_merkle_tree_block().
 	 */
-	void (*drop_block)(struct fsverity_block *block);
+	void (*drop_merkle_tree_block)(struct fsverity_block *block);
 };
 
 #ifdef CONFIG_FS_VERITY
@@ -217,74 +195,16 @@ static inline void fsverity_cleanup_inode(struct inode *inode)
 
 int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 
+int fsverity_set_block_page(struct fsverity_block *block,
+		struct page *page, unsigned int index);
+void fsverity_drop_page_merke_tree_block(struct fsverity_block *block);
+
 /* verify.c */
 
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
-/**
- * fsverity_drop_block() - drop block obtained with ->read_merkle_tree_block()
- * @inode: inode in use for verification or metadata reading
- * @block: block to be dropped
- *
- * Generic put_page() method. Calls out back to filesystem if ->drop_block() is
- * set, otherwise do nothing.
- *
- */
-static inline void fsverity_drop_block(struct inode *inode,
-		struct fsverity_block *block)
-{
-	if (inode->i_sb->s_vop->drop_block)
-		inode->i_sb->s_vop->drop_block(block);
-	else {
-		struct page *page = (struct page *)block->context;
-
-		if (block->verified)
-			SetPageChecked(page);
-
-		put_page(page);
-	}
-}
-
-/**
- * fsverity_read_block_from_page() - layer between fs using read page
- * and read block
- * @inode: inode in use for verification or metadata reading
- * @index: index of the block in the tree (offset into the tree)
- * @block: block to be read
- * @num_ra_pages: number of pages to readahead, may be ignored
- *
- * Depending on fs implementation use read_merkle_tree_block or
- * read_merkle_tree_page.
- */
-static inline int fsverity_read_merkle_tree_block(struct inode *inode,
-					unsigned int index,
-					struct fsverity_block *block,
-					unsigned long num_ra_pages)
-{
-	struct page *page;
-
-	if (inode->i_sb->s_vop->read_merkle_tree_block)
-		return inode->i_sb->s_vop->read_merkle_tree_block(
-			inode, index, block, num_ra_pages);
-
-	page = inode->i_sb->s_vop->read_merkle_tree_page(
-			inode, index >> PAGE_SHIFT, num_ra_pages,
-			block->len);
-
-	block->kaddr = page_address(page) + (index % PAGE_SIZE);
-	block->cached = PageChecked(page);
-	block->context = page;
-
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-	else
-		return 0;
-}
-
-
-
 #else /* !CONFIG_FS_VERITY */
 
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
@@ -362,20 +282,6 @@ static inline void fsverity_enqueue_verify_work(struct work_struct *work)
 	WARN_ON_ONCE(1);
 }
 
-static inline void fsverity_drop_page(struct inode *inode, struct page *page)
-{
-	WARN_ON_ONCE(1);
-}
-
-static inline int fsverity_read_merkle_tree_block(struct inode *inode,
-					unsigned int index,
-					struct fsverity_block *block,
-					unsigned long num_ra_pages)
-{
-	WARN_ON_ONCE(1);
-	return -EOPNOTSUPP;
-}
-
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)

