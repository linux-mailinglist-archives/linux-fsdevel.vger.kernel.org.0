Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED0492024
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiARHVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245147AbiARHUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:20:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BAC061401;
        Mon, 17 Jan 2022 23:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n+SGsohM60cq+fLGHc5ijGdJnd672X25O1+AlD3fwoU=; b=E5qQ7cHCOB8E5bse+tfL2AKcZK
        r+SfsD7Dse7W4376XjX/QMJ3A15ruK5ZcxbJcXmMEYkcE3n1zgc/FbS+E78yMDWaDo7TjSLed4zHS
        UX8TKNFcL7+8tC5b0P0ZCbplAUzHZL17b6Votek9v8psQp4i37B4UiesYYjdetvfMgwbwI3VXoNEx
        Ly2I/tz0F2Q6gikjx+gTbistLA4dF+KwUu75WyYYUmhPJPAH+44s66SgzcfaVpZ9L08+q/GLDWM8l
        y4oJ2U73CDZnNUsIRRFFFPQthdNAAweAsRtQqFmobRBqBabHbc3WIaMe/oOMesrFh/+6qGdvosiOW
        Voei4a8g==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9inH-000Zhx-H9; Tue, 18 Jan 2022 07:20:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 16/19] block: pass a block_device and opf to bio_alloc_kiocb
Date:   Tue, 18 Jan 2022 08:19:49 +0100
Message-Id: <20220118071952.1243143-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the block_device and operation that we plan to use this bio for to
bio_alloc_kiocb to optimize the assigment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 12 ++++++++----
 block/fops.c        | 17 ++++++++---------
 include/linux/bio.h |  4 ++--
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a58bc82d3c85f..8853ed6260cfd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1729,7 +1729,9 @@ EXPORT_SYMBOL(bioset_init_from_src);
 /**
  * bio_alloc_kiocb - Allocate a bio from bio_set based on kiocb
  * @kiocb:	kiocb describing the IO
+ * @bdev:	block device to allocate the bio for (can be %NULL)
  * @nr_vecs:	number of iovecs to pre-allocate
+ * @opf:	operation and flags for bio
  * @bs:		bio_set to allocate from
  *
  * Description:
@@ -1740,14 +1742,14 @@ EXPORT_SYMBOL(bioset_init_from_src);
  *    MUST be done from process context, not hard/soft IRQ.
  *
  */
-struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
-			    struct bio_set *bs)
+struct bio *bio_alloc_kiocb(struct kiocb *kiocb, struct block_device *bdev,
+		unsigned short nr_vecs, unsigned int opf, struct bio_set *bs)
 {
 	struct bio_alloc_cache *cache;
 	struct bio *bio;
 
 	if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE) || nr_vecs > BIO_INLINE_VECS)
-		return bio_alloc_bioset(NULL, nr_vecs, 0, GFP_KERNEL, bs);
+		return bio_alloc_bioset(bdev, nr_vecs, opf, GFP_KERNEL, bs);
 
 	cache = per_cpu_ptr(bs->cache, get_cpu());
 	if (cache->free_list) {
@@ -1756,12 +1758,14 @@ struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
 		cache->nr--;
 		put_cpu();
 		bio_init(bio, nr_vecs ? bio->bi_inline_vecs : NULL, nr_vecs);
+		bio_set_dev(bio, bdev);
+		bio->bi_opf = opf;
 		bio->bi_pool = bs;
 		bio_set_flag(bio, BIO_PERCPU_CACHE);
 		return bio;
 	}
 	put_cpu();
-	bio = bio_alloc_bioset(NULL, nr_vecs, 0, GFP_KERNEL, bs);
+	bio = bio_alloc_bioset(bdev, nr_vecs, opf, GFP_KERNEL, bs);
 	bio_set_flag(bio, BIO_PERCPU_CACHE);
 	return bio;
 }
diff --git a/block/fops.c b/block/fops.c
index 26bf15c770d21..3a62b8b912750 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -190,6 +190,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	unsigned int opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	loff_t pos = iocb->ki_pos;
 	int ret = 0;
 
@@ -197,7 +198,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
+	bio = bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	atomic_set(&dio->ref, 1);
@@ -223,7 +224,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	blk_start_plug(&plug);
 
 	for (;;) {
-		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
@@ -238,11 +238,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		if (is_read) {
-			bio->bi_opf = REQ_OP_READ;
 			if (dio->flags & DIO_SHOULD_DIRTY)
 				bio_set_pages_dirty(bio);
 		} else {
-			bio->bi_opf = dio_bio_write_op(iocb);
 			task_io_account_write(bio->bi_iter.bi_size);
 		}
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -259,6 +257,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		atomic_inc(&dio->ref);
 		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		bio_set_dev(bio, bdev);
+		bio->bi_opf = opf;
 	}
 
 	blk_finish_plug(&plug);
@@ -311,6 +311,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 					unsigned int nr_pages)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
+	bool is_read = iov_iter_rw(iter) == READ;
+	unsigned int opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
 	struct bio *bio;
 	loff_t pos = iocb->ki_pos;
@@ -320,11 +322,10 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
+	bio = bio_alloc_kiocb(iocb, bdev, nr_pages, opf, &blkdev_dio_pool);
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->flags = 0;
 	dio->iocb = iocb;
-	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio->bi_write_hint = iocb->ki_hint;
 	bio->bi_end_io = blkdev_bio_end_io_async;
@@ -347,14 +348,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	}
 	dio->size = bio->bi_iter.bi_size;
 
-	if (iov_iter_rw(iter) == READ) {
-		bio->bi_opf = REQ_OP_READ;
+	if (is_read) {
 		if (iter_is_iovec(iter)) {
 			dio->flags |= DIO_SHOULD_DIRTY;
 			bio_set_pages_dirty(bio);
 		}
 	} else {
-		bio->bi_opf = dio_bio_write_op(iocb);
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2f63ae9a71e1a..5c5ada2ebb270 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -408,8 +408,8 @@ extern int bioset_init_from_src(struct bio_set *bs, struct bio_set *src);
 struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 			     unsigned int opf, gfp_t gfp_mask,
 			     struct bio_set *bs);
-struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
-		struct bio_set *bs);
+struct bio *bio_alloc_kiocb(struct kiocb *kiocb, struct block_device *bdev,
+		unsigned short nr_vecs, unsigned int opf, struct bio_set *bs);
 struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned short nr_iovecs);
 extern void bio_put(struct bio *);
 
-- 
2.30.2

