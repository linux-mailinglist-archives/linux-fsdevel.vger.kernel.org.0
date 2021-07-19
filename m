Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57F73CD2D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 13:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbhGSKN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbhGSKN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 06:13:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A16C061574;
        Mon, 19 Jul 2021 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tOZ1yrLYC3hfxKSEfkuUuVlklih/z1z0MLvrhaXKrgA=; b=T/Fat5IA0M4zCtimrfrZQD4re1
        OiacN5gwztxDm0KHzMwTx7TXHMVEqXisY/gOKpuV/SxmwN6nf+09bvIV6cDR6GJJ9RQtxaZuLoKHt
        G3Nc5Hy/D6/UG+6cQ+9Yt2oOnZQDXZ9ehEFtqeCYHcd03Oartcx8wMxuwvxmybwi9wB5hObrwxl+h
        yPBk65CN0mQ2HNKP6LX7Emx5PRBIOqsNy+8pWTgk6kyAGLYsCz+5Neoi9IKtICr+8T+1lNX9qczs0
        R99f38uP3pHik698BD8GSjPy2dj660C4B/7SVzIMMQSsUCLSzgbrF3rmkO/v6DqxW5UrmYuxOl79s
        vo73xMMw==;
Received: from [2001:4bb8:193:7660:d2a4:8d57:2e55:21d0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5QsI-006leK-H1; Mon, 19 Jul 2021 10:52:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: [PATCH 14/27] iomap: switch __iomap_dio_rw to use iomap_iter
Date:   Mon, 19 Jul 2021 12:35:07 +0200
Message-Id: <20210719103520.495450-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719103520.495450-1-hch@lst.de>
References: <20210719103520.495450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch __iomap_dio_rw to use iomap_iter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c      |   5 +-
 fs/iomap/direct-io.c  | 162 +++++++++++++++++++++---------------------
 include/linux/iomap.h |   4 +-
 3 files changed, 85 insertions(+), 86 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f60314c36c55e..12b18fdf86dcfa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8194,9 +8194,10 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	return dip;
 }
 
-static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
+static blk_qc_t btrfs_submit_direct(const struct iomap_iter *iter,
 		struct bio *dio_bio, loff_t file_offset)
 {
+	struct inode *inode = iter->inode;
 	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
@@ -8212,7 +8213,7 @@ static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
 	int ret;
 	blk_status_t status;
 	struct btrfs_io_geometry geom;
-	struct btrfs_dio_data *dio_data = iomap->private;
+	struct btrfs_dio_data *dio_data = iter->iomap.private;
 	struct extent_map *em = NULL;
 
 	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323b3..b77e4416527c7b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 Red Hat, Inc.
- * Copyright (c) 2016-2018 Christoph Hellwig.
+ * Copyright (c) 2016-2021 Christoph Hellwig.
  */
 #include <linux/module.h>
 #include <linux/compiler.h>
@@ -59,19 +59,17 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
 }
 EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
 
-static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
-		struct bio *bio, loff_t pos)
+static void iomap_dio_submit_bio(const struct iomap_iter *iter,
+		struct iomap_dio *dio, struct bio *bio, loff_t pos)
 {
 	atomic_inc(&dio->ref);
 
 	if (dio->iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(bio, dio->iocb);
 
-	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
+	dio->submit.last_queue = bdev_get_queue(iter->iomap.bdev);
 	if (dio->dops && dio->dops->submit_io)
-		dio->submit.cookie = dio->dops->submit_io(
-				file_inode(dio->iocb->ki_filp),
-				iomap, bio, pos);
+		dio->submit.cookie = dio->dops->submit_io(iter, bio, pos);
 	else
 		dio->submit.cookie = submit_bio(bio);
 }
@@ -181,24 +179,23 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 	}
 }
 
-static void
-iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
-		unsigned len)
+static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
+		loff_t pos, unsigned len)
 {
 	struct page *page = ZERO_PAGE(0);
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
 	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, iomap->bdev);
-	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+	bio_set_dev(bio, iter->iomap.bdev);
+	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-	iomap_dio_submit_bio(dio, iomap, bio, pos);
+	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
 
 /*
@@ -206,8 +203,8 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
  * mapping, and whether or not we want FUA.  Note that we can end up
  * clearing the WRITE_FUA flag in the dio request.
  */
-static inline unsigned int
-iomap_dio_bio_opflags(struct iomap_dio *dio, struct iomap *iomap, bool use_fua)
+static inline unsigned int iomap_dio_bio_opflags(struct iomap_dio *dio,
+		const struct iomap *iomap, bool use_fua)
 {
 	unsigned int opflags = REQ_SYNC | REQ_IDLE;
 
@@ -229,13 +226,16 @@ iomap_dio_bio_opflags(struct iomap_dio *dio, struct iomap *iomap, bool use_fua)
 	return opflags;
 }
 
-static loff_t
-iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
-		struct iomap_dio *dio, struct iomap *iomap)
+static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
+		struct iomap_dio *dio)
 {
+	const struct iomap *iomap = &iter->iomap;
+	struct inode *inode = iter->inode;
 	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
 	unsigned int fs_block_size = i_blocksize(inode), pad;
 	unsigned int align = iov_iter_alignment(dio->submit.iter);
+	loff_t length = iomap_length(iter);
+	loff_t pos = iter->pos;
 	unsigned int bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
@@ -286,7 +286,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		/* zero out from the start of the block to the write offset */
 		pad = pos & (fs_block_size - 1);
 		if (pad)
-			iomap_dio_zero(dio, iomap, pos - pad, pad);
+			iomap_dio_zero(iter, dio, pos - pad, pad);
 	}
 
 	/*
@@ -339,7 +339,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
 						 BIO_MAX_VECS);
-		iomap_dio_submit_bio(dio, iomap, bio, pos);
+		iomap_dio_submit_bio(iter, dio, bio, pos);
 		pos += n;
 	} while (nr_pages);
 
@@ -355,7 +355,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		/* zero out from the end of the write to the end of the block */
 		pad = pos & (fs_block_size - 1);
 		if (pad)
-			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
+			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
 	}
 out:
 	/* Undo iter limitation to current extent */
@@ -365,33 +365,36 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	return ret;
 }
 
-static loff_t
-iomap_dio_hole_actor(loff_t length, struct iomap_dio *dio)
+static loff_t iomap_dio_hole_iter(const struct iomap_iter *iter,
+		struct iomap_dio *dio)
 {
-	length = iov_iter_zero(length, dio->submit.iter);
+	loff_t length = iov_iter_zero(iomap_length(iter), dio->submit.iter);
+
 	dio->size += length;
 	return length;
 }
 
-static loff_t
-iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
-		struct iomap_dio *dio, struct iomap *iomap)
+static loff_t iomap_dio_inline_iter(const struct iomap_iter *iomi,
+		struct iomap_dio *dio)
 {
+	const struct iomap *iomap = &iomi->iomap;
 	struct iov_iter *iter = dio->submit.iter;
+	loff_t length = iomap_length(iomi);
+	loff_t pos = iomi->pos;
 	size_t copied;
 
 	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
 	if (dio->flags & IOMAP_DIO_WRITE) {
-		loff_t size = inode->i_size;
+		loff_t size = iomi->inode->i_size;
 
 		if (pos > size)
 			memset(iomap->inline_data + size, 0, pos - size);
 		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
 		if (copied) {
 			if (pos + copied > size)
-				i_size_write(inode, pos + copied);
-			mark_inode_dirty(inode);
+				i_size_write(iomi->inode, pos + copied);
+			mark_inode_dirty(iomi->inode);
 		}
 	} else {
 		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
@@ -400,30 +403,27 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 	return copied;
 }
 
-static loff_t
-iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+static loff_t iomap_dio_iter(const struct iomap_iter *iter,
+		struct iomap_dio *dio)
 {
-	struct iomap_dio *dio = data;
-
-	switch (iomap->type) {
+	switch (iter->iomap.type) {
 	case IOMAP_HOLE:
 		if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
 			return -EIO;
-		return iomap_dio_hole_actor(length, dio);
+		return iomap_dio_hole_iter(iter, dio);
 	case IOMAP_UNWRITTEN:
 		if (!(dio->flags & IOMAP_DIO_WRITE))
-			return iomap_dio_hole_actor(length, dio);
-		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
+			return iomap_dio_hole_iter(iter, dio);
+		return iomap_dio_bio_iter(iter, dio);
 	case IOMAP_MAPPED:
-		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
+		return iomap_dio_bio_iter(iter, dio);
 	case IOMAP_INLINE:
-		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
+		return iomap_dio_inline_iter(iter, dio);
 	case IOMAP_DELALLOC:
 		/*
 		 * DIO is not serialised against mmap() access at all, and so
 		 * if the page_mkwrite occurs between the writeback and the
-		 * iomap_apply() call in the DIO path, then it will see the
+		 * iomap_iter() call in the DIO path, then it will see the
 		 * DELALLOC block that the page-mkwrite allocated.
 		 */
 		pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD4 Comm: %.20s\n",
@@ -454,16 +454,19 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 {
 	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
-	size_t count = iov_iter_count(iter);
-	loff_t pos = iocb->ki_pos;
-	loff_t end = iocb->ki_pos + count - 1, ret = 0;
+	struct iomap_iter iomi = {
+		.inode		= inode,
+		.pos		= iocb->ki_pos,
+		.len		= iov_iter_count(iter),
+		.flags		= IOMAP_DIRECT,
+	};
+	loff_t end = iomi.pos + iomi.len - 1, ret = 0;
 	bool wait_for_completion =
 		is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_FORCE_WAIT);
-	unsigned int iomap_flags = IOMAP_DIRECT;
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
-	if (!count)
+	if (!iomi.len)
 		return NULL;
 
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
@@ -484,29 +487,30 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.last_queue = NULL;
 
 	if (iov_iter_rw(iter) == READ) {
-		if (pos >= dio->i_size)
+		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
 
 		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_needs_writeback(mapping, pos, end)) {
+			if (filemap_range_needs_writeback(mapping, iomi.pos,
+					end)) {
 				ret = -EAGAIN;
 				goto out_free_dio;
 			}
-			iomap_flags |= IOMAP_NOWAIT;
+			iomi.flags |= IOMAP_NOWAIT;
 		}
 
 		if (iter_is_iovec(iter))
 			dio->flags |= IOMAP_DIO_DIRTY;
 	} else {
-		iomap_flags |= IOMAP_WRITE;
+		iomi.flags |= IOMAP_WRITE;
 		dio->flags |= IOMAP_DIO_WRITE;
 
 		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_has_page(mapping, pos, end)) {
+			if (filemap_range_has_page(mapping, iomi.pos, end)) {
 				ret = -EAGAIN;
 				goto out_free_dio;
 			}
-			iomap_flags |= IOMAP_NOWAIT;
+			iomi.flags |= IOMAP_NOWAIT;
 		}
 
 		/* for data sync or sync, we need sync completion processing */
@@ -525,12 +529,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
 		ret = -EAGAIN;
-		if (pos >= dio->i_size || pos + count > dio->i_size)
+		if (iomi.pos >= dio->i_size ||
+		    iomi.pos + iomi.len > dio->i_size)
 			goto out_free_dio;
-		iomap_flags |= IOMAP_OVERWRITE_ONLY;
+		iomi.flags |= IOMAP_OVERWRITE_ONLY;
 	}
 
-	ret = filemap_write_and_wait_range(mapping, pos, end);
+	ret = filemap_write_and_wait_range(mapping, iomi.pos, end);
 	if (ret)
 		goto out_free_dio;
 
@@ -540,9 +545,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		 * If this invalidation fails, let the caller fall back to
 		 * buffered I/O.
 		 */
-		if (invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
-				end >> PAGE_SHIFT)) {
-			trace_iomap_dio_invalidate_fail(inode, pos, count);
+		if (invalidate_inode_pages2_range(mapping,
+				iomi.pos >> PAGE_SHIFT, end >> PAGE_SHIFT)) {
+			trace_iomap_dio_invalidate_fail(inode, iomi.pos,
+							iomi.len);
 			ret = -ENOTBLK;
 			goto out_free_dio;
 		}
@@ -557,31 +563,23 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	inode_dio_begin(inode);
 
 	blk_start_plug(&plug);
-	do {
-		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
-				iomap_dio_actor);
-		if (ret <= 0) {
-			/* magic error code to fall back to buffered I/O */
-			if (ret == -ENOTBLK) {
-				wait_for_completion = true;
-				ret = 0;
-			}
-			break;
-		}
-		pos += ret;
-
-		if (iov_iter_rw(iter) == READ && pos >= dio->i_size) {
-			/*
-			 * We only report that we've read data up to i_size.
-			 * Revert iter to a state corresponding to that as
-			 * some callers (such as splice code) rely on it.
-			 */
-			iov_iter_revert(iter, pos - dio->i_size);
-			break;
-		}
-	} while ((count = iov_iter_count(iter)) > 0);
+	while ((ret = iomap_iter(&iomi, ops)) > 0)
+		iomi.processed = iomap_dio_iter(&iomi, dio);
 	blk_finish_plug(&plug);
 
+	/*
+	 * We only report that we've read data up to i_size.
+	 * Revert iter to a state corresponding to that as some callers (such
+	 * as the splice code) rely on it.
+	 */
+	if (iov_iter_rw(iter) == READ && iomi.pos >= dio->i_size)
+		iov_iter_revert(iter, iomi.pos - dio->i_size);
+
+	/* magic error code to fall back to buffered I/O */
+	if (ret == -ENOTBLK) {
+		wait_for_completion = true;
+		ret = 0;
+	}
 	if (ret < 0)
 		iomap_dio_set_error(dio, ret);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index a9f3f736017989..da01226886eca4 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -304,8 +304,8 @@ int iomap_writepages(struct address_space *mapping,
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
-	blk_qc_t (*submit_io)(struct inode *inode, struct iomap *iomap,
-			struct bio *bio, loff_t file_offset);
+	blk_qc_t (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
+			      loff_t file_offset);
 };
 
 /*
-- 
2.30.2

