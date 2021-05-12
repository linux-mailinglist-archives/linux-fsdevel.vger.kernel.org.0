Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA737BDD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhELNR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhELNRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:17:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54530C061574;
        Wed, 12 May 2021 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ITcDnMcQEFSlEsP6OeKRIsg7UYiJLbM8pLCK5/AYNmI=; b=ilmrki/Qi7MB0JiGh4JaY+GbtD
        Wvl5thPN5GNtQT4n6fZ/vd1ZnlCChqXtapVZ1fzcXgokbddK+tGD3hS1OSM+o8Mmq06ixLFuxetlY
        tY/II5Iix77vw91F9tBajof90Tn5pBGtAYhrq9nfM6qTT+iWpdpGoaG6w+4zbB7RVMqHG90J2GNt3
        8qfbOHWL9ni3GXhfJ78X1CHeU1v6Kq1Dp2Zcspl/giETn6hZqK7DdloZoGHT0gG+T9zWtJZ+5hdb2
        +G6jvmF6P7HseN5tWsXudOUGSqP0Qhj/n6mvHWCZKieNie8Os1gZoB5e5kAPsb0T7yuqtNJLK8EHn
        Y8+8FTpw==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoiO-00AO1o-Po; Wed, 12 May 2021 13:15:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 02/15] block: don't try to poll multi-bio I/Os in __blkdev_direct_IO
Date:   Wed, 12 May 2021 15:15:32 +0200
Message-Id: <20210512131545.495160-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
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
index b8abccd03e5d..0080a3b710b4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -375,7 +375,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool is_poll = (iocb->ki_flags & IOCB_HIPRI), do_poll = false;
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -437,22 +437,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -462,11 +449,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
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
 
@@ -481,8 +473,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		if (!READ_ONCE(dio->waiter))
 			break;
 
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
+		if (!do_poll || !blk_poll(bdev_get_queue(bdev), qc, true))
 			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.30.2

