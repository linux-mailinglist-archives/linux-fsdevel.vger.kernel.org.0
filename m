Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5609B3A7EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFONNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFONNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:13:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC7FC061574;
        Tue, 15 Jun 2021 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UhccBBYCc1ZiWlTYjKkEiiEHgVybsbHZcY8gPohuFNg=; b=Rx/Ht22g1Nhl49WZC4qXze76n9
        MgctLwG5ZbOfh40lYWZz6u7QVvU/2Ymqrjwx6Pnxru+vzKb0KMzsW/NXyUpowLsI7I4HfHjahQFxQ
        Rry9JxKz1gCzTguYY6Ua/E7fDNX1xcCi/7K13yrhsMzn+2MFDvGt6+04xysp9cOssSy8yh+EEeZtO
        ZbzcIIM/u0oW+G3SswwOn1ul0676URkj/Bus9NZxJBODf9PcvGb5bZdssTt8RdEzb4/GeKPCx4s6n
        e6PynuwBJjsBwd0r4r+wsgDi46Kd5o0GynhiFN1rU6RDOLc3HW12icvloYtPAbgFJpKi8vgPzSYHO
        NuGXiyKA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8qP-006n8E-NH; Tue, 15 Jun 2021 13:11:09 +0000
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
Date:   Tue, 15 Jun 2021 15:10:20 +0200
Message-Id: <20210615131034.752623-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If an iocb is split into multiple bios we can't poll for both.  So don't
bother to even try to poll in that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ac9b3c158a77..8600c651b0b0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -375,7 +375,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
 	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
@@ -404,7 +404,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	 * Don't plug for HIPRI/polled IO, as those should go straight
 	 * to issue
 	 */
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_start_plug(&plug);
 
 	for (;;) {
@@ -438,20 +438,13 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 
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
@@ -462,6 +455,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 				bio_get(bio);
 			dio->multi_bio = true;
 			atomic_set(&dio->ref, 2);
+			do_poll = false;
 		} else {
 			atomic_inc(&dio->ref);
 		}
@@ -470,7 +464,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		bio = bio_alloc(GFP_KERNEL, nr_pages);
 	}
 
-	if (!is_poll)
+	if (!(iocb->ki_flags & IOCB_HIPRI))
 		blk_finish_plug(&plug);
 
 	if (!is_sync)
@@ -481,8 +475,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
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

