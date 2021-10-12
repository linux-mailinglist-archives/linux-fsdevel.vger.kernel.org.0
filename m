Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB82A42A2F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbhJLLTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLLTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:19:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF6C061570;
        Tue, 12 Oct 2021 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dfLmHdTHOwWISM4CncKHIKnO5smotSMqN/rH5FtxI78=; b=Kqxx435kkCiUFQIp4oMzCwpYRB
        K7v4Jjd3+GFd8TMk/VZV/Zn+xrOHIT2LoyeMKbE9Amrsgj2D3jXEIwnPHIm5140Ks80bkpy2NSCs8
        4NWjUAWpEO89oTT3qIQs6QzS3ZszT1fKc/Bj0cAX2nHz9CsriEZ1WWhutLnntwYntFq/53S6FaIO7
        jAUV4I15B+Lr65oTQREY3ks3+Kr1wn/VrBisn5a1hTnvEE3shIfoe4jfOuflh78FEqNDJqeIUpXFZ
        gEUU8RXWqLoWKvn3hVEzBXwLW6w1i7WquxYaXVwE6bj4q7U43oEG6z1sLbakyZZkhuj4qinOQyNVU
        klO2T7cA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFjw-006RRs-Kj; Tue, 12 Oct 2021 11:15:00 +0000
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
Subject: [PATCH 02/16] block: don't try to poll multi-bio I/Os in __blkdev_direct_IO
Date:   Tue, 12 Oct 2021 13:12:12 +0200
Message-Id: <20211012111226.760968-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an iocb is split into multiple bios we can't poll for both.  So don't
even bother to try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 7bb9581a146cf..15324f2e5a914 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -197,7 +197,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -226,7 +226,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	 * Don't plug for HIPRI/polled IO, as those should go straight
 	 * to issue
 	 */
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_start_plug(&plug);
 
 	for (;;) {
@@ -260,20 +260,13 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
 		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
-			bool polled = false;
-
-			if (iocb->ki_flags & IOCB_HIPRI) {
+			if (do_poll)
 				bio_set_polled(bio, iocb);
-				polled = true;
-			}
-
 			qc = submit_bio(bio);
-
-			if (polled)
+			if (do_poll)
 				WRITE_ONCE(iocb->ki_cookie, qc);
 			break;
 		}
-
 		if (!dio->multi_bio) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
@@ -284,6 +277,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
+			do_poll = false;
 		} else {
 			atomic_inc(&dio->ref);
 		}
@@ -292,7 +286,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_finish_plug(&plug);
 
 	if (!is_sync)
@@ -303,8 +297,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
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

