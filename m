Return-Path: <linux-fsdevel+bounces-10095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B560847A9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0BE285A43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC68173E;
	Fri,  2 Feb 2024 20:39:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4B48788
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906398; cv=none; b=vGq//D+Qgk7XixhzLdiPUp+eePrW2Z/Ulqao1EFcL7L5+g1xZ6xfw2uFNw3W9KbobqrBv4thWE68Cwq+yLLQhmG04ogbnxNjN/ljRP3Zrur5xkp++8uS0Lw2wep51+iUp3yh7CQE2Q1Ie2PvJlW/b7EVdKU4vTOKMXvlHejIAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906398; c=relaxed/simple;
	bh=L41fARirgn/wpv0HQOnGJFpqwe9PbkfjMM0eV6TIcoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGE3h44oPWBZa3XlJjYcZW77d3yERTzLteMoZeb7tzfQ9GOckCrNmObO/42e6qVUG9VjdaCaddaZZ9cUD4FyG1Hqt+B+6RxrEUqyc+3SYnBz42f3PnxphSnxzYbeV+U1XUIoum3uNMs7TbPQY4znqqKqqeeW6ICtXLWvcMpuBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso2095781b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906396; x=1707511196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgOcNYI3tDvpYYgg4ArGvQYp6ynf6FHn8ecqLAA6XjY=;
        b=Wlg9vhUvuw4cHVG8ewN3kUhlOXbpk3zXx2bWX0LoEJyMBICfIQhUqpjkakdOtcenaC
         8L9hitgk/oPLlOc9xxpzWG2W6jh8dEyd/n5Xcs8E/7EELxzKyQIU7G+C63m8Km9A/cXx
         698Wp7VQBwHyxMuMPfk9+9eMxdWBtGZtVohhl3D7TUJrivmKSMKelF5Yq4flRj3cJCkK
         V3ZCL5+dJbvtsUSPHZY1BSUGqxJhiiu7S72iGjFK6oX0lfz8khGa2ZM5hqtyAc2tq0o5
         laf846exDDZDHUBxrvrBctq3N5npCv0viFPf4k99vuAIhw44P3+NSCQ7KE2iOoPyqley
         yHLw==
X-Gm-Message-State: AOJu0YyKLU2BBGmD9WtX9LAmDCjLPcnEhAkODsNlSpLO/VRyHtsX8m9r
	VK0XjvcZZBzqsIlwd3slqIoZLKZS7YtLqImgUji4HTC5xv4UDOUi
X-Google-Smtp-Source: AGHT+IFRBccei7Oqds+FaxYrlx1H5uJBR0HaGEBYCTkfYYm8yNrIeTAvARw60uvuq+63SxvLjr+W4A==
X-Received: by 2002:a05:6a21:2c82:b0:19c:9d4d:7d7 with SMTP id ua2-20020a056a212c8200b0019c9d4d07d7mr8085928pzb.41.1706906395802;
        Fri, 02 Feb 2024 12:39:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUD6ME7O/gsSnfMH6DcM3VX+e7/v0vHcB8z5qJ32d7JBGAnh5NTILImRcSVnYTzJPhsivPljWin/rHZhG4E3HeRKeXwrveREiZEFHGi0iTHRDnSugYUe1whlHMqFA9cJbTxOSBVqNhs4njjkV6ZbMv5fDnypV5VnLHN5+GVtz+Z+is7oSM5aRDcjc7o1DXMpSqYlyETYhL7VNz5hKTu/L03PYBd8vJnIyxZ
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:4cc3:4ab5:7d2:ddc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm2239678pgg.73.2024.02.02.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:39:55 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 6/6] block, fs: Restore the per-bio/request data lifetime fields
Date: Fri,  2 Feb 2024 12:39:25 -0800
Message-ID: <20240202203926.2478590-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202203926.2478590-1-bvanassche@acm.org>
References: <20240202203926.2478590-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restore support for passing data lifetime information from filesystems to
block drivers. This patch reverts commit b179c98f7697 ("block: Remove
request.write_hint") and commit c75e707fe1aa ("block: remove the
per-bio/request write hint").

This patch does not modify the size of struct bio because the new
bi_write_hint member fills a hole in struct bio. pahole reports the
following for struct bio on an x86_64 system with this patch applied:

        /* size: 112, cachelines: 2, members: 20 */
        /* sum members: 110, holes: 1, sum holes: 2 */
        /* last cacheline: 48 bytes */

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bio.c                 |  2 ++
 block/blk-crypto-fallback.c |  1 +
 block/blk-merge.c           |  8 ++++++++
 block/blk-mq.c              |  2 ++
 block/bounce.c              |  1 +
 block/fops.c                |  3 +++
 fs/buffer.c                 | 12 ++++++++----
 fs/direct-io.c              |  2 ++
 fs/iomap/buffered-io.c      |  1 +
 fs/iomap/direct-io.c        |  1 +
 fs/mpage.c                  |  1 +
 include/linux/blk-mq.h      |  2 ++
 include/linux/blk_types.h   |  2 ++
 13 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b9642a41f286..c9223e9d31da 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -251,6 +251,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	bio->bi_opf = opf;
 	bio->bi_flags = 0;
 	bio->bi_ioprio = 0;
+	bio->bi_write_hint = 0;
 	bio->bi_status = 0;
 	bio->bi_iter.bi_sector = 0;
 	bio->bi_iter.bi_size = 0;
@@ -813,6 +814,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
+	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e6468eab2681..b1e7415f8439 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -172,6 +172,7 @@ static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
+	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2d470cf2173e..2a06fd33039d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -810,6 +810,10 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (rq_data_dir(req) != rq_data_dir(next))
 		return NULL;
 
+	/* Don't merge requests with different write hints. */
+	if (req->write_hint != next->write_hint)
+		return NULL;
+
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
@@ -937,6 +941,10 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
 
+	/* Don't merge requests with different write hints. */
+	if (rq->write_hint != bio->bi_write_hint)
+		return false;
+
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..34ceb15d2ea4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2585,6 +2585,7 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		rq->cmd_flags |= REQ_FAILFAST_MASK;
 
 	rq->__sector = bio->bi_iter.bi_sector;
+	rq->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
 
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
@@ -3185,6 +3186,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
 	}
 	rq->nr_phys_segments = rq_src->nr_phys_segments;
 	rq->ioprio = rq_src->ioprio;
+	rq->write_hint = rq_src->write_hint;
 
 	if (rq->bio && blk_crypto_rq_bio_prep(rq, rq->bio, gfp_mask) < 0)
 		goto free_and_out;
diff --git a/block/bounce.c b/block/bounce.c
index 7cfcb242f9a1..d6a5219f29dd 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -169,6 +169,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
 	bio->bi_ioprio		= bio_src->bi_ioprio;
+	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
 
diff --git a/block/fops.c b/block/fops.c
index 93bae17ce660..63566a3db186 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
 	}
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
+	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
 	bio.bi_ioprio = iocb->ki_ioprio;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
@@ -203,6 +204,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 	for (;;) {
 		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
+		bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
@@ -321,6 +323,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	dio->flags = 0;
 	dio->iocb = iocb;
 	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
+	bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
diff --git a/fs/buffer.c b/fs/buffer.c
index b55dea034a5d..d6b64124977a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -55,7 +55,7 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  struct writeback_control *wbc);
+			  enum rw_hint hint, struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1889,7 +1889,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
+				      inode->i_write_hint, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -1944,7 +1945,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
+				      inode->i_write_hint, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -2756,6 +2758,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 }
 
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
+			  enum rw_hint write_hint,
 			  struct writeback_control *wbc)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
@@ -2783,6 +2786,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_write_hint = write_hint;
 
 	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 
@@ -2802,7 +2806,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 {
-	submit_bh_wbc(opf, bh, NULL);
+	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 60456263a338..62c97ff9e852 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -410,6 +410,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 		bio->bi_end_io = dio_bio_end_io;
 	if (dio->is_pinned)
 		bio_set_flag(bio, BIO_PAGE_PINNED);
+	bio->bi_write_hint = file_inode(dio->iocb->ki_filp)->i_write_hint;
+
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2ad0e287c704..7f3ee4112e2a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1689,6 +1689,7 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_end_io = iomap_writepage_end_bio;
+	bio->bi_write_hint = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);
 
 	ioend = iomap_ioend_from_bio(bio);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..f3b43d223a46 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -380,6 +380,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 					  GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+		bio->bi_write_hint = inode->i_write_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
diff --git a/fs/mpage.c b/fs/mpage.c
index 738882e0766d..fa8b99a199fa 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -605,6 +605,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				GFP_NOFS);
 		bio->bi_iter.bi_sector = first_block << (blkbits - 9);
 		wbc_init_bio(wbc, bio);
+		bio->bi_write_hint = inode->i_write_hint;
 	}
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7a8150a5f051..492b0128b5d9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -8,6 +8,7 @@
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
+#include <linux/rw_hint.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -135,6 +136,7 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
 
+	enum rw_hint write_hint;
 	unsigned short ioprio;
 
 	enum mq_rq_state state;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f288c94374b3..12d87cef2c03 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,6 +10,7 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
+#include <linux/rw_hint.h>
 
 struct bio_set;
 struct bio;
@@ -269,6 +270,7 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
+	enum rw_hint		bi_write_hint;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
 

