Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A867D36B450
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhDZNzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:55:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94976C061574;
        Mon, 26 Apr 2021 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ySo911+kYEoCMqOzuSDXpsYakLdJUIqMAtgpreSDWsY=; b=iaLul1OE3TsQJwcSb/APzMFtB8
        l/vQBWYF6JbcvDJLjhdLJRX3Mgn0aRdrH1ZaBABg4TveVVp79Y5/jvd2y2Lhx98NvOe+RNTvBJb0s
        utptmugrzP1OgDyYJI4za1pUto2usypGtw774l2tGz83H4idavNP5WjJHyfbpAh2p65MWlO8VNKb3
        1gUNVqYaLeqsO25vBaKFACLSb8rNdNu5cgIMmhQc5BsEojHigrXS6Oms6omNEA3KJ4Bl3TrfWDPqt
        keuoQ27aDd+xdfXlCQXjuiN4u7hr3lY/XiEHMkjlJbLonlKMezZHXKC/UG+Leq0/LPrCU2iQpDaQK
        GnVRauHA==;
Received: from 089144202077.atnat0011.highway.a1.net ([89.144.202.77] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hU-00FznV-4t; Mon, 26 Apr 2021 13:55:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/12] block: don't try to poll multi-bio I/Os in __blkdev_direct_IO
Date:   Mon, 26 Apr 2021 15:48:11 +0200
Message-Id: <20210426134821.2191160-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an iocb is split into multiple bios we can't poll for both.  So don't
bother to even try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 363015fcffdb..ea5b4617ff86 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -373,7 +373,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool is_poll = (iocb->ki_flags & IOCB_HIPRI), do_poll = false;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -433,22 +433,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		pos += bio->bi_iter.bi_size;
 
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
-		if (!nr_pages) {
-			bool polled = false;
-
-			if (iocb->ki_flags & IOCB_HIPRI) {
-				bio_set_polled(bio, iocb);
-				polled = true;
-			}
-
-			qc = submit_bio(bio);
-
-			if (polled)
-				WRITE_ONCE(iocb->ki_cookie, qc);
-			break;
-		}
-
-		if (!dio->multi_bio) {
+		if (dio->multi_bio) {
+			atomic_inc(&dio->ref);
+		} else if (nr_pages) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
 			 * structure which is embedded into the first bio
@@ -458,11 +445,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
-		} else {
-			atomic_inc(&dio->ref);
+		} else if (is_poll) {
+			bio_set_polled(bio, iocb);
+			do_poll = true;
+		}
+		qc = submit_bio(bio);
+		if (!nr_pages) {
+			if (do_poll)
+				WRITE_ONCE(iocb->ki_cookie, qc);
+			break;
 		}
-
-		submit_bio(bio);
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
@@ -477,8 +469,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.30.1

