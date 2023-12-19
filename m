Return-Path: <linux-fsdevel+bounces-6442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC84817E77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 01:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D76285A22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 00:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A121842;
	Tue, 19 Dec 2023 00:08:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49015AB;
	Tue, 19 Dec 2023 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b7df7d14dso1547721a91.3;
        Mon, 18 Dec 2023 16:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702944520; x=1703549320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AA8Mkk3eDGI+RdBAttjzB4kOhjXaYRt5p8RBULSiN0=;
        b=ZkDBBZ9Xle0qCd0IvipQXh+gNpwsBw5TE0nb0H0vwzswFhZi2d7tjYMJ97PAKZWBUp
         8zu1YYXxw2265DV8oGZd8tsc2MF6J8rL/+QwGFqCy9nOSOqKZvADc8Z2T0SgngR9E/1m
         avJfCsEXIxwFz+DeIazOn6sCIXF4rjueX2WoP/CKNIULHu/QtJXTPrbp7Vq5WKpnfmn9
         DlhaWpW4v7CWi0Q5QHPLrRl21ZP6yHjSKg/tBFbJ+By4KvP+72xYV3AlO8ISNtE7nu6o
         tvSR9xq9/BgJKOU4tEt5/m3LghKgUlehZbR9JwfJ9/bRoTngrFhceZ1gOqP4oRd1/YvF
         kbug==
X-Gm-Message-State: AOJu0Yz0cnSJd2nTdAnwj8YfsmNMT/VgS3RSfRupM0rRlmTCBrOW6wsD
	0UqzD4G8B4p9PTXL1yiAPrY=
X-Google-Smtp-Source: AGHT+IEwMmDonzJKIN3mnZ7LxDtgf+5zCzeQ5joLJzsyllU5k7y5uLrQC598CPm5aZbKMyIQtzkL4Q==
X-Received: by 2002:a17:90a:b10c:b0:28b:2f13:d519 with SMTP id z12-20020a17090ab10c00b0028b2f13d519mr3342598pjq.78.1702944520050;
        Mon, 18 Dec 2023 16:08:40 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:e67:7ba6:36a9:8cd5])
        by smtp.gmail.com with ESMTPSA id x17-20020a17090a531100b0028b050e8297sm118630pjh.18.2023.12.18.16.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:08:39 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v8 05/19] block, fs: Restore the per-bio/request data lifetime fields
Date: Mon, 18 Dec 2023 16:07:38 -0800
Message-ID: <20231219000815.2739120-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
References: <20231219000815.2739120-1-bvanassche@acm.org>
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
 fs/iomap/buffered-io.c      |  2 ++
 fs/iomap/direct-io.c        |  1 +
 fs/mpage.c                  |  1 +
 include/linux/blk-mq.h      |  2 ++
 include/linux/blk_types.h   |  2 ++
 13 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..755fcde5cb66 100644
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
index 65e75efa9bd3..65bbbf6cf1fe 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -814,6 +814,10 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (rq_data_dir(req) != rq_data_dir(next))
 		return NULL;
 
+	/* Don't merge requests with different write hints. */
+	if (req->write_hint != next->write_hint)
+		return NULL;
+
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
@@ -941,6 +945,10 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!bio_crypt_rq_ctx_compatible(rq, bio))
 		return false;
 
+	/* Don't merge requests with different write hints. */
+	if (rq->write_hint != bio->bi_write_hint)
+		return false;
+
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..081df9faf499 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2551,6 +2551,7 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
 		rq->cmd_flags |= REQ_FAILFAST_MASK;
 
 	rq->__sector = bio->bi_iter.bi_sector;
+	rq->write_hint = bio->bi_write_hint;
 	blk_rq_bio_prep(rq, bio, nr_segs);
 
 	/* This can't fail, since GFP_NOIO includes __GFP_DIRECT_RECLAIM. */
@@ -3143,6 +3144,7 @@ int blk_rq_prep_clone(struct request *rq, struct request *rq_src,
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
index 0abaac705daf..787ce52bc2c6 100644
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
index 967f34b70aa8..76834398e713 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -55,7 +55,7 @@
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
-			  struct writeback_control *wbc);
+			  enum rw_hint hint, struct writeback_control *wbc);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
@@ -1903,7 +1903,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 	do {
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
+				      inode->i_write_hint, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -1957,7 +1958,8 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
 		struct buffer_head *next = bh->b_this_page;
 		if (buffer_async_write(bh)) {
 			clear_buffer_dirty(bh);
-			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh, wbc);
+			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
+				      inode->i_write_hint, wbc);
 			nr_underway++;
 		}
 		bh = next;
@@ -2777,6 +2779,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
 }
 
 static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
+			  enum rw_hint write_hint,
 			  struct writeback_control *wbc)
 {
 	const enum req_op op = opf & REQ_OP_MASK;
@@ -2804,6 +2807,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_write_hint = write_hint;
 
 	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
 
@@ -2823,7 +2827,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 void submit_bh(blk_opf_t opf, struct buffer_head *bh)
 {
-	submit_bh_wbc(opf, bh, NULL);
+	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
 }
 EXPORT_SYMBOL(submit_bh);
 
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 20533266ade6..5261ab8bcdaa 100644
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
index f72df2babe56..191eb575485e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1677,6 +1677,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = sector;
+	bio->bi_write_hint = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
@@ -1707,6 +1708,7 @@ iomap_chain_bio(struct bio *prev)
 	new = bio_alloc(prev->bi_bdev, BIO_MAX_VECS, prev->bi_opf, GFP_NOFS);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
+	new->bi_write_hint = prev->bi_write_hint;
 
 	bio_chain(prev, new);
 	bio_get(prev);		/* for iomap_finish_ioend */
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
index ffb064ed9d04..268785f2bb53 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -611,6 +611,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 				GFP_NOFS);
 		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 		wbc_init_bio(wbc, bio);
+		bio->bi_write_hint = inode->i_write_hint;
 	}
 
 	/*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1ab3081c82ed..479f26af76bd 100644
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
index d5c5e59ddbd2..8410957f4313 100644
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
 

