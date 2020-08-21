Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871FF24CF85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgHUHjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgHUHjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:39:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D29C061387
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:39:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so516792plr.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGjlHCPgCNl8dsYdLnB/xJLPDXJeL8/CZJnRuDW48M4=;
        b=QrqSMmtgOPaCRgU7HDppaDrsBLguGPZ+di5SP1qsxjvglfv9cYB/OVWzsecg/MZQ7t
         V2WgyLFzR3cPbvDhVjsLC5KUgYhmppVog9vTPTN2sc69Jdwy4blHP/O3yXrZLNBErE6t
         Uvw2oYqM/zVbctJUR/JmIUZ+c/MuOrqo8ZJaGVvC9gKktFe5ZGia5ZeL36PTTyxhg0gM
         cxTCkYfd4CRiMlp7Q8eZr7LWPLFgDSw1ryAH9KAosouCotNsxP0zIEXc2Wssd/Fvmhrf
         P24SynRi59KzrNzstjCWAS+rievulV+fANHxNx2Za9iS/IiBlzdXSnjN5/xgiF/vJOvw
         acaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGjlHCPgCNl8dsYdLnB/xJLPDXJeL8/CZJnRuDW48M4=;
        b=ZuADFiU6gxOMMxW2e59fPPROmpvYlBRnfCOXK5A0kF5PnqWqMwQAsD3YyfDt5Z5gc2
         BXtHoD0pCi+l3l+EarC2LDjlb0BqTXkNr6oOVDui81pywMxZefB4N93iggrEV/n0D5/u
         lnQloVfb26PvXr4UUmruvqOqK2PxOSbxX6abBUloz2e6peVm1gkxLnebhX9yz0IXm8HH
         kwtkbdrYJXuxhvNzLJob7sMr+cMzpZNd/R4o4/Vwi/xjet6rKTzOk3ydan9g11hNn/qB
         HVq8+0idRUs2Pinkj2c1KNGLz1KtPgmwWS5p+T8pM0kmjluP709f+c6SruYdP7ULMNzz
         tfcQ==
X-Gm-Message-State: AOAM532adM2WM6lo+qW8FV/nmTCZR38Ie2RXonHbcDCaCj7HgvA3ziqR
        lc02qZ3gk3yZKa75oNC70HAZpLSjaDdaBQ==
X-Google-Smtp-Source: ABdhPJyanS26zFnS/YAfk86Y5wFs27jPFEIEwvcKgUIIwnqfWMfPezump75sQ0XWqQGzLxxgVGkoog==
X-Received: by 2002:a17:90a:ce94:: with SMTP id g20mr1380848pju.61.1597995549371;
        Fri, 21 Aug 2020 00:39:09 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id t10sm1220867pgp.15.2020.08.21.00.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:39:08 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v5 8/9] btrfs: implement RWF_ENCODED reads
Date:   Fri, 21 Aug 2020 00:38:39 -0700
Message-Id: <a52f9e7743bb924cdfa87906295e422bc48801c7.1597993855.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597993855.git.osandov@osandov.com>
References: <cover.1597993855.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

There are 4 main cases:

1. Inline extents: we copy the data straight out of the extent buffer.
2. Hole/preallocated extents: we fill in zeroes.
3. Regular, uncompressed extents: we read the sectors we need directly
   from disk.
4. Regular, compressed extents: we read the entire compressed extent
   from disk and indicate what subset of the decompressed extent is in
   the file.

This initial implementation simplifies a few things that can be improved
in the future:

- We hold the inode lock during the operation.
- Cases 1, 3, and 4 allocate temporary memory to read into before
  copying out to userspace.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   2 +
 fs/btrfs/file.c  |  12 +-
 fs/btrfs/inode.c | 491 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 504 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 47581706a132..e7ec6fa7b2bb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3020,6 +3020,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
+ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
+
 extern const struct dentry_operations btrfs_dentry_operations;
 
 /* ioctl.c */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ed236cbe8adb..99b523aac669 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -379,6 +379,16 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	if (iocb->ki_flags & IOCB_ENCODED) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EOPNOTSUPP;
+		return btrfs_encoded_read(iocb, iter);
+	}
+	return generic_file_read_iter(iocb, iter);
+}
+
 /* simple helper to fault in pages and copy.  This should go away
  * and be replaced with calls into generic code.
  */
@@ -3571,7 +3581,7 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
-	.read_iter      = generic_file_read_iter,
+	.read_iter      = btrfs_file_read_iter,
 	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.splice_write	= iter_file_splice_write,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9b644a641b32..05024d56f9f8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9817,6 +9817,497 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
 	}
 }
 
+static int encoded_iov_compression_from_btrfs(unsigned int compress_type)
+{
+	switch (compress_type) {
+	case BTRFS_COMPRESS_NONE:
+		return ENCODED_IOV_COMPRESSION_NONE;
+	case BTRFS_COMPRESS_ZLIB:
+		return ENCODED_IOV_COMPRESSION_ZLIB;
+	case BTRFS_COMPRESS_LZO:
+		return ENCODED_IOV_COMPRESSION_LZO;
+	case BTRFS_COMPRESS_ZSTD:
+		return ENCODED_IOV_COMPRESSION_ZSTD;
+	default:
+		return -EUCLEAN;
+	}
+}
+
+static ssize_t btrfs_encoded_read_inline(struct kiocb *iocb,
+					 struct iov_iter *iter, u64 start,
+					 u64 lockend,
+					 struct extent_state **cached_state,
+					 u64 extent_start, size_t count,
+					 struct encoded_iov *encoded,
+					 bool *unlocked)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct btrfs_path *path;
+	struct extent_buffer *leaf;
+	struct btrfs_file_extent_item *item;
+	u64 ram_bytes;
+	unsigned long ptr;
+	void *tmp;
+	ssize_t ret;
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = btrfs_lookup_file_extent(NULL, BTRFS_I(inode)->root, path,
+				       btrfs_ino(BTRFS_I(inode)), extent_start,
+				       0);
+	if (ret) {
+		if (ret > 0) {
+			/* The extent item disappeared? */
+			ret = -EIO;
+		}
+		goto out;
+	}
+	leaf = path->nodes[0];
+	item = btrfs_item_ptr(leaf, path->slots[0],
+			      struct btrfs_file_extent_item);
+
+	ram_bytes = btrfs_file_extent_ram_bytes(leaf, item);
+	ptr = btrfs_file_extent_inline_start(item);
+
+	encoded->len = (min_t(u64, extent_start + ram_bytes, inode->i_size) -
+			iocb->ki_pos);
+	ret = encoded_iov_compression_from_btrfs(
+				 btrfs_file_extent_compression(leaf, item));
+	if (ret < 0)
+		goto out;
+	encoded->compression = ret;
+	if (encoded->compression) {
+		size_t inline_size;
+
+		inline_size = btrfs_file_extent_inline_item_len(leaf,
+						btrfs_item_nr(path->slots[0]));
+		if (inline_size > count) {
+			ret = -ENOBUFS;
+			goto out;
+		}
+		count = inline_size;
+		encoded->unencoded_len = ram_bytes;
+		encoded->unencoded_offset = iocb->ki_pos - extent_start;
+	} else {
+		encoded->len = encoded->unencoded_len = count =
+			min_t(u64, count, encoded->len);
+		ptr += iocb->ki_pos - extent_start;
+	}
+
+	tmp = kmalloc(count, GFP_NOFS);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	read_extent_buffer(leaf, tmp, ptr, count);
+	btrfs_free_path(path);
+	path = NULL;
+	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	inode_unlock_shared(inode);
+	*unlocked = true;
+
+	ret = copy_encoded_iov_to_iter(encoded, iter);
+	if (ret)
+		goto out_free;
+	ret = copy_to_iter(tmp, count, iter);
+	if (ret != count)
+		ret = -EFAULT;
+out_free:
+	kfree(tmp);
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+struct btrfs_encoded_read_private {
+	struct inode *inode;
+	wait_queue_head_t wait;
+	atomic_t pending;
+	blk_status_t status;
+	bool skip_csum;
+};
+
+static blk_status_t submit_encoded_read_bio(struct inode *inode,
+					    struct bio *bio, int mirror_num,
+					    unsigned long bio_flags)
+{
+	struct btrfs_encoded_read_private *priv = bio->bi_private;
+	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	blk_status_t ret;
+
+	if (!priv->skip_csum) {
+		ret = btrfs_lookup_bio_sums(inode, bio, io_bio->logical, NULL);
+		if (ret)
+			return ret;
+	}
+
+	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
+	if (ret) {
+		btrfs_io_bio_free_csum(io_bio);
+		return ret;
+	}
+
+	atomic_inc(&priv->pending);
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
+	if (ret) {
+		atomic_dec(&priv->pending);
+		btrfs_io_bio_free_csum(io_bio);
+	}
+	return ret;
+}
+
+static blk_status_t btrfs_encoded_read_check_bio(struct btrfs_io_bio *io_bio)
+{
+	const bool uptodate = io_bio->bio.bi_status == BLK_STS_OK;
+	struct btrfs_encoded_read_private *priv = io_bio->bio.bi_private;
+	struct inode *inode = priv->inode;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	u32 sectorsize = fs_info->sectorsize;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	u64 start = io_bio->logical;
+	int icsum = 0;
+
+	if (priv->skip_csum || !uptodate)
+		return io_bio->bio.bi_status;
+
+	bio_for_each_segment_all(bvec, &io_bio->bio, iter_all) {
+		unsigned int i, nr_sectors, pgoff;
+
+		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec->bv_len);
+		pgoff = bvec->bv_offset;
+		for (i = 0; i < nr_sectors; i++) {
+			ASSERT(pgoff < PAGE_SIZE);
+			if (check_data_csum(inode, io_bio, icsum, bvec->bv_page,
+					    pgoff, start, sectorsize))
+				return BLK_STS_IOERR;
+			start += sectorsize;
+			icsum++;
+			pgoff += sectorsize;
+		}
+	}
+	return BLK_STS_OK;
+}
+
+static void btrfs_encoded_read_endio(struct bio *bio)
+{
+	struct btrfs_encoded_read_private *priv = bio->bi_private;
+	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
+	blk_status_t status;
+
+	status = btrfs_encoded_read_check_bio(io_bio);
+	if (status) {
+		/*
+		 * The memory barrier implied by the atomic_dec_return() here
+		 * pairs with the memory barrier implied by the
+		 * atomic_dec_return() or io_wait_event() in
+		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
+		 * write is observed before the load of status in
+		 * btrfs_encoded_read_regular_fill_pages().
+		 */
+		WRITE_ONCE(priv->status, status);
+	}
+	if (!atomic_dec_return(&priv->pending))
+		wake_up(&priv->wait);
+	btrfs_io_bio_free_csum(io_bio);
+	bio_put(bio);
+}
+
+static int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
+						 u64 disk_io_size, struct page **pages)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_encoded_read_private priv = {
+		.inode = inode,
+		.pending = ATOMIC_INIT(1),
+		.skip_csum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM,
+	};
+	unsigned long i = 0;
+	u64 cur = 0;
+	int ret;
+
+	init_waitqueue_head(&priv.wait);
+	/*
+	 * Submit bios for the extent, splitting due to bio or stripe limits as
+	 * necessary.
+	 */
+	while (cur < disk_io_size) {
+		struct btrfs_io_geometry geom;
+		struct bio *bio = NULL;
+		u64 remaining;
+
+		ret = btrfs_get_io_geometry(fs_info, BTRFS_MAP_READ,
+					    offset + cur, disk_io_size - cur,
+					    &geom);
+		if (ret) {
+			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
+			break;
+		}
+		remaining = min(geom.len, disk_io_size - cur);
+		while (bio || remaining) {
+			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
+
+			if (!bio) {
+				bio = btrfs_bio_alloc(offset + cur);
+				bio->bi_end_io = btrfs_encoded_read_endio;
+				bio->bi_private = &priv;
+				bio->bi_opf = REQ_OP_READ;
+			}
+
+			if (!bytes ||
+			    bio_add_page(bio, pages[i], bytes, 0) < bytes) {
+				blk_status_t status;
+
+				status = submit_encoded_read_bio(inode, bio, 0,
+								 0);
+				if (status) {
+					WRITE_ONCE(priv.status, status);
+					bio_put(bio);
+					goto out;
+				}
+				bio = NULL;
+				continue;
+			}
+
+			i++;
+			cur += bytes;
+			remaining -= bytes;
+		}
+	}
+
+out:
+	if (atomic_dec_return(&priv.pending))
+		io_wait_event(priv.wait, !atomic_read(&priv.pending));
+	/* See btrfs_encoded_read_endio() for ordering. */
+	return blk_status_to_errno(READ_ONCE(priv.status));
+}
+
+static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
+					  struct iov_iter *iter,
+					  u64 start, u64 lockend,
+					  struct extent_state **cached_state,
+					  u64 offset, u64 disk_io_size,
+					  size_t count,
+					  const struct encoded_iov *encoded,
+					  bool *unlocked)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct page **pages;
+	unsigned long nr_pages, i;
+	u64 cur;
+	size_t page_offset;
+	ssize_t ret;
+
+	nr_pages = DIV_ROUND_UP(disk_io_size, PAGE_SIZE);
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		if (!pages[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = btrfs_encoded_read_regular_fill_pages(inode, offset, disk_io_size,
+						    pages);
+	if (ret)
+		goto out;
+
+	unlock_extent_cached(io_tree, start, lockend, cached_state);
+	inode_unlock_shared(inode);
+	*unlocked = true;
+
+	ret = copy_encoded_iov_to_iter(encoded, iter);
+	if (ret)
+		goto out;
+	if (encoded->compression) {
+		i = 0;
+		page_offset = 0;
+	} else {
+		i = (iocb->ki_pos - start) >> PAGE_SHIFT;
+		page_offset = (iocb->ki_pos - start) & (PAGE_SIZE - 1);
+	}
+	cur = 0;
+	while (cur < count) {
+		size_t bytes = min_t(size_t, count - cur,
+				     PAGE_SIZE - page_offset);
+
+		if (copy_page_to_iter(pages[i], page_offset, bytes,
+				      iter) != bytes) {
+			ret = -EFAULT;
+			goto out;
+		}
+		i++;
+		cur += bytes;
+		page_offset = 0;
+	}
+	ret = count;
+out:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i])
+			__free_page(pages[i]);
+	}
+	kfree(pages);
+	return ret;
+}
+
+ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	ssize_t ret;
+	size_t count;
+	u64 start, lockend, offset, disk_io_size;
+	struct extent_state *cached_state = NULL;
+	struct extent_map *em;
+	struct encoded_iov encoded = {};
+	bool unlocked = false;
+
+	ret = generic_encoded_read_checks(iocb, iter);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return copy_encoded_iov_to_iter(&encoded, iter);
+	count = ret;
+
+	file_accessed(iocb->ki_filp);
+
+	inode_lock_shared(inode);
+
+	if (iocb->ki_pos >= inode->i_size) {
+		inode_unlock_shared(inode);
+		return copy_encoded_iov_to_iter(&encoded, iter);
+	}
+	start = ALIGN_DOWN(iocb->ki_pos, fs_info->sectorsize);
+	/*
+	 * We don't know how long the extent containing iocb->ki_pos is, but if
+	 * it's compressed we know that it won't be longer than this.
+	 */
+	lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
+
+	for (;;) {
+		struct btrfs_ordered_extent *ordered;
+
+		ret = btrfs_wait_ordered_range(inode, start,
+					       lockend - start + 1);
+		if (ret)
+			goto out_unlock_inode;
+		lock_extent_bits(io_tree, start, lockend, &cached_state);
+		ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), start,
+						     lockend - start + 1);
+		if (!ordered)
+			break;
+		btrfs_put_ordered_extent(ordered);
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		cond_resched();
+	}
+
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
+			      lockend - start + 1);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto out_unlock_extent;
+	}
+
+	if (em->block_start == EXTENT_MAP_INLINE) {
+		u64 extent_start = em->start;
+
+		/*
+		 * For inline extents we get everything we need out of the
+		 * extent item.
+		 */
+		free_extent_map(em);
+		em = NULL;
+		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
+						&cached_state, extent_start,
+						count, &encoded, &unlocked);
+		goto out;
+	}
+
+	/*
+	 * We only want to return up to EOF even if the extent extends beyond
+	 * that.
+	 */
+	encoded.len = (min_t(u64, extent_map_end(em), inode->i_size) -
+		       iocb->ki_pos);
+	if (em->block_start == EXTENT_MAP_HOLE ||
+	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
+		offset = EXTENT_MAP_HOLE;
+		encoded.len = encoded.unencoded_len = count =
+			min_t(u64, count, encoded.len);
+	} else if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+		offset = em->block_start;
+		/*
+		 * Bail if the buffer isn't large enough to return the whole
+		 * compressed extent.
+		 */
+		if (em->block_len > count) {
+			ret = -ENOBUFS;
+			goto out_em;
+		}
+		disk_io_size = count = em->block_len;
+		encoded.unencoded_len = em->ram_bytes;
+		encoded.unencoded_offset = iocb->ki_pos - em->orig_start;
+		ret = encoded_iov_compression_from_btrfs(em->compress_type);
+		if (ret < 0)
+			goto out_em;
+		encoded.compression = ret;
+	} else {
+		offset = em->block_start + (start - em->start);
+		if (encoded.len > count)
+			encoded.len = count;
+		/*
+		 * Don't read beyond what we locked. This also limits the page
+		 * allocations that we'll do.
+		 */
+		disk_io_size = min(lockend + 1, iocb->ki_pos + encoded.len) - start;
+		encoded.len = encoded.unencoded_len = count =
+			start + disk_io_size - iocb->ki_pos;
+		disk_io_size = ALIGN(disk_io_size, fs_info->sectorsize);
+	}
+	free_extent_map(em);
+	em = NULL;
+
+	if (offset == EXTENT_MAP_HOLE) {
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+		inode_unlock_shared(inode);
+		unlocked = true;
+		ret = copy_encoded_iov_to_iter(&encoded, iter);
+		if (ret)
+			goto out;
+		ret = iov_iter_zero(count, iter);
+		if (ret != count)
+			ret = -EFAULT;
+	} else {
+		ret = btrfs_encoded_read_regular(iocb, iter, start, lockend,
+						 &cached_state, offset,
+						 disk_io_size, count, &encoded,
+						 &unlocked);
+	}
+
+out:
+	if (ret >= 0)
+		iocb->ki_pos += encoded.len;
+out_em:
+	free_extent_map(em);
+out_unlock_extent:
+	if (!unlocked)
+		unlock_extent_cached(io_tree, start, lockend, &cached_state);
+out_unlock_inode:
+	if (!unlocked)
+		inode_unlock_shared(inode);
+	return ret;
+}
+
 #ifdef CONFIG_SWAP
 /*
  * Add an entry indicating a block group or device which is pinned by a
-- 
2.28.0

