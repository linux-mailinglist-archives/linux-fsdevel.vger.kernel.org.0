Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E405C1A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfGARCr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:02:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGARCo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnVMP184038;
        Mon, 1 Jul 2019 17:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=71OhFHe7hdTvA1Mx3viztfmiiPoJ3oCLQPPHJGJ5zPE=;
 b=f0yPuh8Rg87VQ5AUTffTM4h/WtPsf+LPVMVZE8ecvmJaJ5LRuVAarttQbaSZz5B86ZoM
 5v0WNVZI8un5wmLitGVVbk+GIQDZo3CKGaH/H4oFWkkJMNrOl8QTSI2vmke4jqin824d
 o/YN+5DF8mqIaKQTMZtnRv0UCi1VtZ5cONPMpZ8hugzDCKwdBCl0KXwQDHTs52Dbpxrx
 enfgzae+kqqxWYnW09SMJc7kkRTO2neLvdzefN/mSdeUhw6rXg8No24LqUXHVml3y2Oa
 XF1U5lkh3MFoaO8LAYiUC9NF7cA+OnUafypCdwH1KtFqrtvmJlmkYun0vfGXTRZ0fA6D xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2te61dxuac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmMlf154137;
        Mon, 1 Jul 2019 17:02:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tebqg1h01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61H2XGa032345;
        Mon, 1 Jul 2019 17:02:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:33 -0700
Subject: [PATCH 05/11] iomap: move the direct IO code into a separate file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:32 -0700
Message-ID: <156200055235.1790352.1363115993194082170.stgit@magnolia>
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the direct IO code into a separate file so that we can group
related functions in a single file instead of having a single enormous
source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c                |  557 --------------------------------------------
 fs/iomap/Makefile         |    1 
 fs/iomap/direct-io.c      |  569 +++++++++++++++++++++++++++++++++++++++++++++
 fs/iomap/iomap_internal.h |   11 +
 4 files changed, 583 insertions(+), 555 deletions(-)
 create mode 100644 fs/iomap/direct-io.c
 create mode 100644 fs/iomap/iomap_internal.h


diff --git a/fs/iomap.c b/fs/iomap.c
index 471fcb8170e6..550bde00ae34 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -24,6 +24,7 @@
 #include <linux/sched/signal.h>
 
 #include "internal.h"
+#include "iomap/iomap_internal.h"
 
 /*
  * Execute a iomap write on a segment of the mapping that spans a
@@ -90,7 +91,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	return written ? written : ret;
 }
 
-static sector_t
+sector_t
 iomap_sector(struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
@@ -1144,557 +1145,3 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 	return block_page_mkwrite_return(ret);
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
-
-/*
- * Private flags for iomap_dio, must not overlap with the public ones in
- * iomap.h:
- */
-#define IOMAP_DIO_WRITE_FUA	(1 << 28)
-#define IOMAP_DIO_NEED_SYNC	(1 << 29)
-#define IOMAP_DIO_WRITE		(1 << 30)
-#define IOMAP_DIO_DIRTY		(1 << 31)
-
-struct iomap_dio {
-	struct kiocb		*iocb;
-	iomap_dio_end_io_t	*end_io;
-	loff_t			i_size;
-	loff_t			size;
-	atomic_t		ref;
-	unsigned		flags;
-	int			error;
-	bool			wait_for_completion;
-
-	union {
-		/* used during submission and for synchronous completion: */
-		struct {
-			struct iov_iter		*iter;
-			struct task_struct	*waiter;
-			struct request_queue	*last_queue;
-			blk_qc_t		cookie;
-		} submit;
-
-		/* used for aio completion: */
-		struct {
-			struct work_struct	work;
-		} aio;
-	};
-};
-
-int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
-{
-	struct request_queue *q = READ_ONCE(kiocb->private);
-
-	if (!q)
-		return 0;
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), spin);
-}
-EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
-
-static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
-		struct bio *bio)
-{
-	atomic_inc(&dio->ref);
-
-	if (dio->iocb->ki_flags & IOCB_HIPRI)
-		bio_set_polled(bio, dio->iocb);
-
-	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-	dio->submit.cookie = submit_bio(bio);
-}
-
-static ssize_t iomap_dio_complete(struct iomap_dio *dio)
-{
-	struct kiocb *iocb = dio->iocb;
-	struct inode *inode = file_inode(iocb->ki_filp);
-	loff_t offset = iocb->ki_pos;
-	ssize_t ret;
-
-	if (dio->end_io) {
-		ret = dio->end_io(iocb,
-				dio->error ? dio->error : dio->size,
-				dio->flags);
-	} else {
-		ret = dio->error;
-	}
-
-	if (likely(!ret)) {
-		ret = dio->size;
-		/* check for short read */
-		if (offset + ret > dio->i_size &&
-		    !(dio->flags & IOMAP_DIO_WRITE))
-			ret = dio->i_size - offset;
-		iocb->ki_pos += ret;
-	}
-
-	/*
-	 * Try again to invalidate clean pages which might have been cached by
-	 * non-direct readahead, or faulted in by get_user_pages() if the source
-	 * of the write was an mmap'ed region of the file we're writing.  Either
-	 * one is a pretty crazy thing to do, so we don't support it 100%.  If
-	 * this invalidation fails, tough, the write still worked...
-	 *
-	 * And this page cache invalidation has to be after dio->end_io(), as
-	 * some filesystems convert unwritten extents to real allocations in
-	 * end_io() when necessary, otherwise a racing buffer read would cache
-	 * zeros from unwritten extents.
-	 */
-	if (!dio->error &&
-	    (dio->flags & IOMAP_DIO_WRITE) && inode->i_mapping->nrpages) {
-		int err;
-		err = invalidate_inode_pages2_range(inode->i_mapping,
-				offset >> PAGE_SHIFT,
-				(offset + dio->size - 1) >> PAGE_SHIFT);
-		if (err)
-			dio_warn_stale_pagecache(iocb->ki_filp);
-	}
-
-	/*
-	 * If this is a DSYNC write, make sure we push it to stable storage now
-	 * that we've written data.
-	 */
-	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
-		ret = generic_write_sync(iocb, ret);
-
-	inode_dio_end(file_inode(iocb->ki_filp));
-	kfree(dio);
-
-	return ret;
-}
-
-static void iomap_dio_complete_work(struct work_struct *work)
-{
-	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);
-	struct kiocb *iocb = dio->iocb;
-
-	iocb->ki_complete(iocb, iomap_dio_complete(dio), 0);
-}
-
-/*
- * Set an error in the dio if none is set yet.  We have to use cmpxchg
- * as the submission context and the completion context(s) can race to
- * update the error.
- */
-static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
-{
-	cmpxchg(&dio->error, 0, ret);
-}
-
-static void iomap_dio_bio_end_io(struct bio *bio)
-{
-	struct iomap_dio *dio = bio->bi_private;
-	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
-
-	if (bio->bi_status)
-		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
-
-	if (atomic_dec_and_test(&dio->ref)) {
-		if (dio->wait_for_completion) {
-			struct task_struct *waiter = dio->submit.waiter;
-			WRITE_ONCE(dio->submit.waiter, NULL);
-			blk_wake_io_task(waiter);
-		} else if (dio->flags & IOMAP_DIO_WRITE) {
-			struct inode *inode = file_inode(dio->iocb->ki_filp);
-
-			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
-			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
-		} else {
-			iomap_dio_complete_work(&dio->aio.work);
-		}
-	}
-
-	if (should_dirty) {
-		bio_check_pages_dirty(bio);
-	} else {
-		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
-			struct bvec_iter_all iter_all;
-			struct bio_vec *bvec;
-
-			bio_for_each_segment_all(bvec, bio, iter_all)
-				put_page(bvec->bv_page);
-		}
-		bio_put(bio);
-	}
-}
-
-static void
-iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
-		unsigned len)
-{
-	struct page *page = ZERO_PAGE(0);
-	int flags = REQ_SYNC | REQ_IDLE;
-	struct bio *bio;
-
-	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, iomap->bdev);
-	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-	bio->bi_private = dio;
-	bio->bi_end_io = iomap_dio_bio_end_io;
-
-	get_page(page);
-	__bio_add_page(bio, page, len, 0);
-	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-	iomap_dio_submit_bio(dio, iomap, bio);
-}
-
-static loff_t
-iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
-		struct iomap_dio *dio, struct iomap *iomap)
-{
-	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
-	unsigned int fs_block_size = i_blocksize(inode), pad;
-	unsigned int align = iov_iter_alignment(dio->submit.iter);
-	struct iov_iter iter;
-	struct bio *bio;
-	bool need_zeroout = false;
-	bool use_fua = false;
-	int nr_pages, ret = 0;
-	size_t copied = 0;
-
-	if ((pos | length | align) & ((1 << blkbits) - 1))
-		return -EINVAL;
-
-	if (iomap->type == IOMAP_UNWRITTEN) {
-		dio->flags |= IOMAP_DIO_UNWRITTEN;
-		need_zeroout = true;
-	}
-
-	if (iomap->flags & IOMAP_F_SHARED)
-		dio->flags |= IOMAP_DIO_COW;
-
-	if (iomap->flags & IOMAP_F_NEW) {
-		need_zeroout = true;
-	} else if (iomap->type == IOMAP_MAPPED) {
-		/*
-		 * Use a FUA write if we need datasync semantics, this is a pure
-		 * data IO that doesn't require any metadata updates (including
-		 * after IO completion such as unwritten extent conversion) and
-		 * the underlying device supports FUA. This allows us to avoid
-		 * cache flushes on IO completion.
-		 */
-		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
-		    (dio->flags & IOMAP_DIO_WRITE_FUA) &&
-		    blk_queue_fua(bdev_get_queue(iomap->bdev)))
-			use_fua = true;
-	}
-
-	/*
-	 * Operate on a partial iter trimmed to the extent we were called for.
-	 * We'll update the iter in the dio once we're done with this extent.
-	 */
-	iter = *dio->submit.iter;
-	iov_iter_truncate(&iter, length);
-
-	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-	if (nr_pages <= 0)
-		return nr_pages;
-
-	if (need_zeroout) {
-		/* zero out from the start of the block to the write offset */
-		pad = pos & (fs_block_size - 1);
-		if (pad)
-			iomap_dio_zero(dio, iomap, pos - pad, pad);
-	}
-
-	do {
-		size_t n;
-		if (dio->error) {
-			iov_iter_revert(dio->submit.iter, copied);
-			return 0;
-		}
-
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
-		bio_set_dev(bio, iomap->bdev);
-		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
-		bio->bi_write_hint = dio->iocb->ki_hint;
-		bio->bi_ioprio = dio->iocb->ki_ioprio;
-		bio->bi_private = dio;
-		bio->bi_end_io = iomap_dio_bio_end_io;
-
-		ret = bio_iov_iter_get_pages(bio, &iter);
-		if (unlikely(ret)) {
-			/*
-			 * We have to stop part way through an IO. We must fall
-			 * through to the sub-block tail zeroing here, otherwise
-			 * this short IO may expose stale data in the tail of
-			 * the block we haven't written data to.
-			 */
-			bio_put(bio);
-			goto zero_tail;
-		}
-
-		n = bio->bi_iter.bi_size;
-		if (dio->flags & IOMAP_DIO_WRITE) {
-			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
-			if (use_fua)
-				bio->bi_opf |= REQ_FUA;
-			else
-				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
-			task_io_account_write(n);
-		} else {
-			bio->bi_opf = REQ_OP_READ;
-			if (dio->flags & IOMAP_DIO_DIRTY)
-				bio_set_pages_dirty(bio);
-		}
-
-		iov_iter_advance(dio->submit.iter, n);
-
-		dio->size += n;
-		pos += n;
-		copied += n;
-
-		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-		iomap_dio_submit_bio(dio, iomap, bio);
-	} while (nr_pages);
-
-	/*
-	 * We need to zeroout the tail of a sub-block write if the extent type
-	 * requires zeroing or the write extends beyond EOF. If we don't zero
-	 * the block tail in the latter case, we can expose stale data via mmap
-	 * reads of the EOF block.
-	 */
-zero_tail:
-	if (need_zeroout ||
-	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
-		/* zero out from the end of the write to the end of the block */
-		pad = pos & (fs_block_size - 1);
-		if (pad)
-			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
-	}
-	return copied ? copied : ret;
-}
-
-static loff_t
-iomap_dio_hole_actor(loff_t length, struct iomap_dio *dio)
-{
-	length = iov_iter_zero(length, dio->submit.iter);
-	dio->size += length;
-	return length;
-}
-
-static loff_t
-iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
-		struct iomap_dio *dio, struct iomap *iomap)
-{
-	struct iov_iter *iter = dio->submit.iter;
-	size_t copied;
-
-	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
-
-	if (dio->flags & IOMAP_DIO_WRITE) {
-		loff_t size = inode->i_size;
-
-		if (pos > size)
-			memset(iomap->inline_data + size, 0, pos - size);
-		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
-		if (copied) {
-			if (pos + copied > size)
-				i_size_write(inode, pos + copied);
-			mark_inode_dirty(inode);
-		}
-	} else {
-		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
-	}
-	dio->size += copied;
-	return copied;
-}
-
-static loff_t
-iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap)
-{
-	struct iomap_dio *dio = data;
-
-	switch (iomap->type) {
-	case IOMAP_HOLE:
-		if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
-			return -EIO;
-		return iomap_dio_hole_actor(length, dio);
-	case IOMAP_UNWRITTEN:
-		if (!(dio->flags & IOMAP_DIO_WRITE))
-			return iomap_dio_hole_actor(length, dio);
-		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
-	case IOMAP_MAPPED:
-		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
-	case IOMAP_INLINE:
-		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
-	default:
-		WARN_ON_ONCE(1);
-		return -EIO;
-	}
-}
-
-/*
- * iomap_dio_rw() always completes O_[D]SYNC writes regardless of whether the IO
- * is being issued as AIO or not.  This allows us to optimise pure data writes
- * to use REQ_FUA rather than requiring generic_write_sync() to issue a
- * REQ_FLUSH post write. This is slightly tricky because a single request here
- * can be mapped into multiple disjoint IOs and only a subset of the IOs issued
- * may be pure data writes. In that case, we still need to do a full data sync
- * completion.
- */
-ssize_t
-iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops, iomap_dio_end_io_t end_io)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = file_inode(iocb->ki_filp);
-	size_t count = iov_iter_count(iter);
-	loff_t pos = iocb->ki_pos, start = pos;
-	loff_t end = iocb->ki_pos + count - 1, ret = 0;
-	unsigned int flags = IOMAP_DIRECT;
-	bool wait_for_completion = is_sync_kiocb(iocb);
-	struct blk_plug plug;
-	struct iomap_dio *dio;
-
-	lockdep_assert_held(&inode->i_rwsem);
-
-	if (!count)
-		return 0;
-
-	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
-	if (!dio)
-		return -ENOMEM;
-
-	dio->iocb = iocb;
-	atomic_set(&dio->ref, 1);
-	dio->size = 0;
-	dio->i_size = i_size_read(inode);
-	dio->end_io = end_io;
-	dio->error = 0;
-	dio->flags = 0;
-
-	dio->submit.iter = iter;
-	dio->submit.waiter = current;
-	dio->submit.cookie = BLK_QC_T_NONE;
-	dio->submit.last_queue = NULL;
-
-	if (iov_iter_rw(iter) == READ) {
-		if (pos >= dio->i_size)
-			goto out_free_dio;
-
-		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
-			dio->flags |= IOMAP_DIO_DIRTY;
-	} else {
-		flags |= IOMAP_WRITE;
-		dio->flags |= IOMAP_DIO_WRITE;
-
-		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC)
-			dio->flags |= IOMAP_DIO_NEED_SYNC;
-
-		/*
-		 * For datasync only writes, we optimistically try using FUA for
-		 * this IO.  Any non-FUA write that occurs will clear this flag,
-		 * hence we know before completion whether a cache flush is
-		 * necessary.
-		 */
-		if ((iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) == IOCB_DSYNC)
-			dio->flags |= IOMAP_DIO_WRITE_FUA;
-	}
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (filemap_range_has_page(mapping, start, end)) {
-			ret = -EAGAIN;
-			goto out_free_dio;
-		}
-		flags |= IOMAP_NOWAIT;
-	}
-
-	ret = filemap_write_and_wait_range(mapping, start, end);
-	if (ret)
-		goto out_free_dio;
-
-	/*
-	 * Try to invalidate cache pages for the range we're direct
-	 * writing.  If this invalidation fails, tough, the write will
-	 * still work, but racing two incompatible write paths is a
-	 * pretty crazy thing to do, so we don't support it 100%.
-	 */
-	ret = invalidate_inode_pages2_range(mapping,
-			start >> PAGE_SHIFT, end >> PAGE_SHIFT);
-	if (ret)
-		dio_warn_stale_pagecache(iocb->ki_filp);
-	ret = 0;
-
-	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
-	    !inode->i_sb->s_dio_done_wq) {
-		ret = sb_init_dio_done_wq(inode->i_sb);
-		if (ret < 0)
-			goto out_free_dio;
-	}
-
-	inode_dio_begin(inode);
-
-	blk_start_plug(&plug);
-	do {
-		ret = iomap_apply(inode, pos, count, flags, ops, dio,
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
-		if (iov_iter_rw(iter) == READ && pos >= dio->i_size)
-			break;
-	} while ((count = iov_iter_count(iter)) > 0);
-	blk_finish_plug(&plug);
-
-	if (ret < 0)
-		iomap_dio_set_error(dio, ret);
-
-	/*
-	 * If all the writes we issued were FUA, we don't need to flush the
-	 * cache on IO completion. Clear the sync flag for this case.
-	 */
-	if (dio->flags & IOMAP_DIO_WRITE_FUA)
-		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
-
-	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
-	WRITE_ONCE(iocb->private, dio->submit.last_queue);
-
-	/*
-	 * We are about to drop our additional submission reference, which
-	 * might be the last reference to the dio.  There are three three
-	 * different ways we can progress here:
-	 *
-	 *  (a) If this is the last reference we will always complete and free
-	 *	the dio ourselves.
-	 *  (b) If this is not the last reference, and we serve an asynchronous
-	 *	iocb, we must never touch the dio after the decrement, the
-	 *	I/O completion handler will complete and free it.
-	 *  (c) If this is not the last reference, but we serve a synchronous
-	 *	iocb, the I/O completion handler will wake us up on the drop
-	 *	of the final reference, and we will complete and free it here
-	 *	after we got woken by the I/O completion handler.
-	 */
-	dio->wait_for_completion = wait_for_completion;
-	if (!atomic_dec_and_test(&dio->ref)) {
-		if (!wait_for_completion)
-			return -EIOCBQUEUED;
-
-		for (;;) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			if (!READ_ONCE(dio->submit.waiter))
-				break;
-
-			if (!(iocb->ki_flags & IOCB_HIPRI) ||
-			    !dio->submit.last_queue ||
-			    !blk_poll(dio->submit.last_queue,
-					 dio->submit.cookie, true))
-				io_schedule();
-		}
-		__set_current_state(TASK_RUNNING);
-	}
-
-	return iomap_dio_complete(dio);
-
-out_free_dio:
-	kfree(dio);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iomap_dio_rw);
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 12dc7f844bbd..3e158f38b8e2 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -9,6 +9,7 @@ ccflags-y += -I $(srctree)/$(src)/..
 obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 
 iomap-y				+= \
+					direct-io.o \
 					fiemap.o \
 					seek.o
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
new file mode 100644
index 000000000000..33d303cf0e59
--- /dev/null
+++ b/fs/iomap/direct-io.c
@@ -0,0 +1,569 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/backing-dev.h>
+#include <linux/uio.h>
+#include <linux/task_io_accounting_ops.h>
+
+#include "internal.h"
+#include "iomap_internal.h"
+
+/*
+ * Private flags for iomap_dio, must not overlap with the public ones in
+ * iomap.h:
+ */
+#define IOMAP_DIO_WRITE_FUA	(1 << 28)
+#define IOMAP_DIO_NEED_SYNC	(1 << 29)
+#define IOMAP_DIO_WRITE		(1 << 30)
+#define IOMAP_DIO_DIRTY		(1 << 31)
+
+struct iomap_dio {
+	struct kiocb		*iocb;
+	iomap_dio_end_io_t	*end_io;
+	loff_t			i_size;
+	loff_t			size;
+	atomic_t		ref;
+	unsigned		flags;
+	int			error;
+	bool			wait_for_completion;
+
+	union {
+		/* used during submission and for synchronous completion: */
+		struct {
+			struct iov_iter		*iter;
+			struct task_struct	*waiter;
+			struct request_queue	*last_queue;
+			blk_qc_t		cookie;
+		} submit;
+
+		/* used for aio completion: */
+		struct {
+			struct work_struct	work;
+		} aio;
+	};
+};
+
+int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
+{
+	struct request_queue *q = READ_ONCE(kiocb->private);
+
+	if (!q)
+		return 0;
+	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), spin);
+}
+EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
+
+static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
+		struct bio *bio)
+{
+	atomic_inc(&dio->ref);
+
+	if (dio->iocb->ki_flags & IOCB_HIPRI)
+		bio_set_polled(bio, dio->iocb);
+
+	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
+	dio->submit.cookie = submit_bio(bio);
+}
+
+static ssize_t iomap_dio_complete(struct iomap_dio *dio)
+{
+	struct kiocb *iocb = dio->iocb;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	loff_t offset = iocb->ki_pos;
+	ssize_t ret;
+
+	if (dio->end_io) {
+		ret = dio->end_io(iocb,
+				dio->error ? dio->error : dio->size,
+				dio->flags);
+	} else {
+		ret = dio->error;
+	}
+
+	if (likely(!ret)) {
+		ret = dio->size;
+		/* check for short read */
+		if (offset + ret > dio->i_size &&
+		    !(dio->flags & IOMAP_DIO_WRITE))
+			ret = dio->i_size - offset;
+		iocb->ki_pos += ret;
+	}
+
+	/*
+	 * Try again to invalidate clean pages which might have been cached by
+	 * non-direct readahead, or faulted in by get_user_pages() if the source
+	 * of the write was an mmap'ed region of the file we're writing.  Either
+	 * one is a pretty crazy thing to do, so we don't support it 100%.  If
+	 * this invalidation fails, tough, the write still worked...
+	 *
+	 * And this page cache invalidation has to be after dio->end_io(), as
+	 * some filesystems convert unwritten extents to real allocations in
+	 * end_io() when necessary, otherwise a racing buffer read would cache
+	 * zeros from unwritten extents.
+	 */
+	if (!dio->error &&
+	    (dio->flags & IOMAP_DIO_WRITE) && inode->i_mapping->nrpages) {
+		int err;
+		err = invalidate_inode_pages2_range(inode->i_mapping,
+				offset >> PAGE_SHIFT,
+				(offset + dio->size - 1) >> PAGE_SHIFT);
+		if (err)
+			dio_warn_stale_pagecache(iocb->ki_filp);
+	}
+
+	/*
+	 * If this is a DSYNC write, make sure we push it to stable storage now
+	 * that we've written data.
+	 */
+	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
+		ret = generic_write_sync(iocb, ret);
+
+	inode_dio_end(file_inode(iocb->ki_filp));
+	kfree(dio);
+
+	return ret;
+}
+
+static void iomap_dio_complete_work(struct work_struct *work)
+{
+	struct iomap_dio *dio = container_of(work, struct iomap_dio, aio.work);
+	struct kiocb *iocb = dio->iocb;
+
+	iocb->ki_complete(iocb, iomap_dio_complete(dio), 0);
+}
+
+/*
+ * Set an error in the dio if none is set yet.  We have to use cmpxchg
+ * as the submission context and the completion context(s) can race to
+ * update the error.
+ */
+static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
+{
+	cmpxchg(&dio->error, 0, ret);
+}
+
+static void iomap_dio_bio_end_io(struct bio *bio)
+{
+	struct iomap_dio *dio = bio->bi_private;
+	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
+
+	if (bio->bi_status)
+		iomap_dio_set_error(dio, blk_status_to_errno(bio->bi_status));
+
+	if (atomic_dec_and_test(&dio->ref)) {
+		if (dio->wait_for_completion) {
+			struct task_struct *waiter = dio->submit.waiter;
+			WRITE_ONCE(dio->submit.waiter, NULL);
+			blk_wake_io_task(waiter);
+		} else if (dio->flags & IOMAP_DIO_WRITE) {
+			struct inode *inode = file_inode(dio->iocb->ki_filp);
+
+			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
+			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
+		} else {
+			iomap_dio_complete_work(&dio->aio.work);
+		}
+	}
+
+	if (should_dirty) {
+		bio_check_pages_dirty(bio);
+	} else {
+		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {
+			struct bvec_iter_all iter_all;
+			struct bio_vec *bvec;
+
+			bio_for_each_segment_all(bvec, bio, iter_all)
+				put_page(bvec->bv_page);
+		}
+		bio_put(bio);
+	}
+}
+
+static void
+iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
+		unsigned len)
+{
+	struct page *page = ZERO_PAGE(0);
+	int flags = REQ_SYNC | REQ_IDLE;
+	struct bio *bio;
+
+	bio = bio_alloc(GFP_KERNEL, 1);
+	bio_set_dev(bio, iomap->bdev);
+	bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+	bio->bi_private = dio;
+	bio->bi_end_io = iomap_dio_bio_end_io;
+
+	get_page(page);
+	__bio_add_page(bio, page, len, 0);
+	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
+	iomap_dio_submit_bio(dio, iomap, bio);
+}
+
+static loff_t
+iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
+		struct iomap_dio *dio, struct iomap *iomap)
+{
+	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
+	unsigned int fs_block_size = i_blocksize(inode), pad;
+	unsigned int align = iov_iter_alignment(dio->submit.iter);
+	struct iov_iter iter;
+	struct bio *bio;
+	bool need_zeroout = false;
+	bool use_fua = false;
+	int nr_pages, ret = 0;
+	size_t copied = 0;
+
+	if ((pos | length | align) & ((1 << blkbits) - 1))
+		return -EINVAL;
+
+	if (iomap->type == IOMAP_UNWRITTEN) {
+		dio->flags |= IOMAP_DIO_UNWRITTEN;
+		need_zeroout = true;
+	}
+
+	if (iomap->flags & IOMAP_F_SHARED)
+		dio->flags |= IOMAP_DIO_COW;
+
+	if (iomap->flags & IOMAP_F_NEW) {
+		need_zeroout = true;
+	} else if (iomap->type == IOMAP_MAPPED) {
+		/*
+		 * Use a FUA write if we need datasync semantics, this is a pure
+		 * data IO that doesn't require any metadata updates (including
+		 * after IO completion such as unwritten extent conversion) and
+		 * the underlying device supports FUA. This allows us to avoid
+		 * cache flushes on IO completion.
+		 */
+		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
+		    (dio->flags & IOMAP_DIO_WRITE_FUA) &&
+		    blk_queue_fua(bdev_get_queue(iomap->bdev)))
+			use_fua = true;
+	}
+
+	/*
+	 * Operate on a partial iter trimmed to the extent we were called for.
+	 * We'll update the iter in the dio once we're done with this extent.
+	 */
+	iter = *dio->submit.iter;
+	iov_iter_truncate(&iter, length);
+
+	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
+	if (nr_pages <= 0)
+		return nr_pages;
+
+	if (need_zeroout) {
+		/* zero out from the start of the block to the write offset */
+		pad = pos & (fs_block_size - 1);
+		if (pad)
+			iomap_dio_zero(dio, iomap, pos - pad, pad);
+	}
+
+	do {
+		size_t n;
+		if (dio->error) {
+			iov_iter_revert(dio->submit.iter, copied);
+			return 0;
+		}
+
+		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		bio_set_dev(bio, iomap->bdev);
+		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+		bio->bi_write_hint = dio->iocb->ki_hint;
+		bio->bi_ioprio = dio->iocb->ki_ioprio;
+		bio->bi_private = dio;
+		bio->bi_end_io = iomap_dio_bio_end_io;
+
+		ret = bio_iov_iter_get_pages(bio, &iter);
+		if (unlikely(ret)) {
+			/*
+			 * We have to stop part way through an IO. We must fall
+			 * through to the sub-block tail zeroing here, otherwise
+			 * this short IO may expose stale data in the tail of
+			 * the block we haven't written data to.
+			 */
+			bio_put(bio);
+			goto zero_tail;
+		}
+
+		n = bio->bi_iter.bi_size;
+		if (dio->flags & IOMAP_DIO_WRITE) {
+			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
+			if (use_fua)
+				bio->bi_opf |= REQ_FUA;
+			else
+				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
+			task_io_account_write(n);
+		} else {
+			bio->bi_opf = REQ_OP_READ;
+			if (dio->flags & IOMAP_DIO_DIRTY)
+				bio_set_pages_dirty(bio);
+		}
+
+		iov_iter_advance(dio->submit.iter, n);
+
+		dio->size += n;
+		pos += n;
+		copied += n;
+
+		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
+		iomap_dio_submit_bio(dio, iomap, bio);
+	} while (nr_pages);
+
+	/*
+	 * We need to zeroout the tail of a sub-block write if the extent type
+	 * requires zeroing or the write extends beyond EOF. If we don't zero
+	 * the block tail in the latter case, we can expose stale data via mmap
+	 * reads of the EOF block.
+	 */
+zero_tail:
+	if (need_zeroout ||
+	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
+		/* zero out from the end of the write to the end of the block */
+		pad = pos & (fs_block_size - 1);
+		if (pad)
+			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
+	}
+	return copied ? copied : ret;
+}
+
+static loff_t
+iomap_dio_hole_actor(loff_t length, struct iomap_dio *dio)
+{
+	length = iov_iter_zero(length, dio->submit.iter);
+	dio->size += length;
+	return length;
+}
+
+static loff_t
+iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
+		struct iomap_dio *dio, struct iomap *iomap)
+{
+	struct iov_iter *iter = dio->submit.iter;
+	size_t copied;
+
+	BUG_ON(pos + length > PAGE_SIZE - offset_in_page(iomap->inline_data));
+
+	if (dio->flags & IOMAP_DIO_WRITE) {
+		loff_t size = inode->i_size;
+
+		if (pos > size)
+			memset(iomap->inline_data + size, 0, pos - size);
+		copied = copy_from_iter(iomap->inline_data + pos, length, iter);
+		if (copied) {
+			if (pos + copied > size)
+				i_size_write(inode, pos + copied);
+			mark_inode_dirty(inode);
+		}
+	} else {
+		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
+	}
+	dio->size += copied;
+	return copied;
+}
+
+static loff_t
+iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
+		void *data, struct iomap *iomap)
+{
+	struct iomap_dio *dio = data;
+
+	switch (iomap->type) {
+	case IOMAP_HOLE:
+		if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
+			return -EIO;
+		return iomap_dio_hole_actor(length, dio);
+	case IOMAP_UNWRITTEN:
+		if (!(dio->flags & IOMAP_DIO_WRITE))
+			return iomap_dio_hole_actor(length, dio);
+		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
+	case IOMAP_MAPPED:
+		return iomap_dio_bio_actor(inode, pos, length, dio, iomap);
+	case IOMAP_INLINE:
+		return iomap_dio_inline_actor(inode, pos, length, dio, iomap);
+	default:
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+}
+
+/*
+ * iomap_dio_rw() always completes O_[D]SYNC writes regardless of whether the IO
+ * is being issued as AIO or not.  This allows us to optimise pure data writes
+ * to use REQ_FUA rather than requiring generic_write_sync() to issue a
+ * REQ_FLUSH post write. This is slightly tricky because a single request here
+ * can be mapped into multiple disjoint IOs and only a subset of the IOs issued
+ * may be pure data writes. In that case, we still need to do a full data sync
+ * completion.
+ */
+ssize_t
+iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops, iomap_dio_end_io_t end_io)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(iter);
+	loff_t pos = iocb->ki_pos, start = pos;
+	loff_t end = iocb->ki_pos + count - 1, ret = 0;
+	unsigned int flags = IOMAP_DIRECT;
+	bool wait_for_completion = is_sync_kiocb(iocb);
+	struct blk_plug plug;
+	struct iomap_dio *dio;
+
+	lockdep_assert_held(&inode->i_rwsem);
+
+	if (!count)
+		return 0;
+
+	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
+	if (!dio)
+		return -ENOMEM;
+
+	dio->iocb = iocb;
+	atomic_set(&dio->ref, 1);
+	dio->size = 0;
+	dio->i_size = i_size_read(inode);
+	dio->end_io = end_io;
+	dio->error = 0;
+	dio->flags = 0;
+
+	dio->submit.iter = iter;
+	dio->submit.waiter = current;
+	dio->submit.cookie = BLK_QC_T_NONE;
+	dio->submit.last_queue = NULL;
+
+	if (iov_iter_rw(iter) == READ) {
+		if (pos >= dio->i_size)
+			goto out_free_dio;
+
+		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
+			dio->flags |= IOMAP_DIO_DIRTY;
+	} else {
+		flags |= IOMAP_WRITE;
+		dio->flags |= IOMAP_DIO_WRITE;
+
+		/* for data sync or sync, we need sync completion processing */
+		if (iocb->ki_flags & IOCB_DSYNC)
+			dio->flags |= IOMAP_DIO_NEED_SYNC;
+
+		/*
+		 * For datasync only writes, we optimistically try using FUA for
+		 * this IO.  Any non-FUA write that occurs will clear this flag,
+		 * hence we know before completion whether a cache flush is
+		 * necessary.
+		 */
+		if ((iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) == IOCB_DSYNC)
+			dio->flags |= IOMAP_DIO_WRITE_FUA;
+	}
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (filemap_range_has_page(mapping, start, end)) {
+			ret = -EAGAIN;
+			goto out_free_dio;
+		}
+		flags |= IOMAP_NOWAIT;
+	}
+
+	ret = filemap_write_and_wait_range(mapping, start, end);
+	if (ret)
+		goto out_free_dio;
+
+	/*
+	 * Try to invalidate cache pages for the range we're direct
+	 * writing.  If this invalidation fails, tough, the write will
+	 * still work, but racing two incompatible write paths is a
+	 * pretty crazy thing to do, so we don't support it 100%.
+	 */
+	ret = invalidate_inode_pages2_range(mapping,
+			start >> PAGE_SHIFT, end >> PAGE_SHIFT);
+	if (ret)
+		dio_warn_stale_pagecache(iocb->ki_filp);
+	ret = 0;
+
+	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
+	    !inode->i_sb->s_dio_done_wq) {
+		ret = sb_init_dio_done_wq(inode->i_sb);
+		if (ret < 0)
+			goto out_free_dio;
+	}
+
+	inode_dio_begin(inode);
+
+	blk_start_plug(&plug);
+	do {
+		ret = iomap_apply(inode, pos, count, flags, ops, dio,
+				iomap_dio_actor);
+		if (ret <= 0) {
+			/* magic error code to fall back to buffered I/O */
+			if (ret == -ENOTBLK) {
+				wait_for_completion = true;
+				ret = 0;
+			}
+			break;
+		}
+		pos += ret;
+
+		if (iov_iter_rw(iter) == READ && pos >= dio->i_size)
+			break;
+	} while ((count = iov_iter_count(iter)) > 0);
+	blk_finish_plug(&plug);
+
+	if (ret < 0)
+		iomap_dio_set_error(dio, ret);
+
+	/*
+	 * If all the writes we issued were FUA, we don't need to flush the
+	 * cache on IO completion. Clear the sync flag for this case.
+	 */
+	if (dio->flags & IOMAP_DIO_WRITE_FUA)
+		dio->flags &= ~IOMAP_DIO_NEED_SYNC;
+
+	WRITE_ONCE(iocb->ki_cookie, dio->submit.cookie);
+	WRITE_ONCE(iocb->private, dio->submit.last_queue);
+
+	/*
+	 * We are about to drop our additional submission reference, which
+	 * might be the last reference to the dio.  There are three three
+	 * different ways we can progress here:
+	 *
+	 *  (a) If this is the last reference we will always complete and free
+	 *	the dio ourselves.
+	 *  (b) If this is not the last reference, and we serve an asynchronous
+	 *	iocb, we must never touch the dio after the decrement, the
+	 *	I/O completion handler will complete and free it.
+	 *  (c) If this is not the last reference, but we serve a synchronous
+	 *	iocb, the I/O completion handler will wake us up on the drop
+	 *	of the final reference, and we will complete and free it here
+	 *	after we got woken by the I/O completion handler.
+	 */
+	dio->wait_for_completion = wait_for_completion;
+	if (!atomic_dec_and_test(&dio->ref)) {
+		if (!wait_for_completion)
+			return -EIOCBQUEUED;
+
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			if (!READ_ONCE(dio->submit.waiter))
+				break;
+
+			if (!(iocb->ki_flags & IOCB_HIPRI) ||
+			    !dio->submit.last_queue ||
+			    !blk_poll(dio->submit.last_queue,
+					 dio->submit.cookie, true))
+				io_schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+	}
+
+	return iomap_dio_complete(dio);
+
+out_free_dio:
+	kfree(dio);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iomap_dio_rw);
diff --git a/fs/iomap/iomap_internal.h b/fs/iomap/iomap_internal.h
new file mode 100644
index 000000000000..2e811ca8b8ed
--- /dev/null
+++ b/fs/iomap/iomap_internal.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#ifndef _IOMAP_INTERNAL_H_
+#define _IOMAP_INTERNAL_H_
+
+sector_t iomap_sector(struct iomap *iomap, loff_t pos);
+
+#endif /* _IOMAP_INTERNAL_H_ */

