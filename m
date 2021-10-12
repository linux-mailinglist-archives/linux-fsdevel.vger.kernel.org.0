Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8142A2EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhJLLSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhJLLSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:18:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29215C061570;
        Tue, 12 Oct 2021 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YaEjgBUtA2vphpQF+wTXe+cEE2KjTqL1g0deqC72xfw=; b=Wuw2nnoeDoSc5/sdrwK7HU846r
        RKD4ltUY6vFVZZKPlOXpFeA763wxLA2TC1vpwO2Gp/sGw+G1Oi5SEiYZ7AUupQ20sTIeXF29fKVHd
        FHFV+fJ8w67vrTYyB7m5lGCuDF/hb63pbcGzi3Ox6nQb7hOxSq2wJhFf8ztZMCqCUz7BF290FB+gd
        xzPXt1cSrf2b0EOQZhXgkCX4B/LralYfUBCOV1D6CF2co8UPJBNN47D8rIliYlThRSN+s7E2YZCHJ
        kCmENJEkBnC6xckKE3ks3aIpBsp6xWLLGewpCpFwsOCrx1dJL5QEY9V86K9yDsmUISw35JJpy3BuC
        fh8N0ikg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFiq-006RQP-Eu; Tue, 12 Oct 2021 11:13:54 +0000
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
Subject: [PATCH 01/16] direct-io: remove blk_poll support
Date:   Tue, 12 Oct 2021 13:12:11 +0200
Message-Id: <20211012111226.760968-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The polling support in the legacy direct-io support is a little crufty.
It already doesn't support the asynchronous polling needed for io_uring
polling, and is hard to adopt to upcoming changes in the polling
interfaces.  Given that all the major file systems already use the iomap
direct I/O code, just drop the polling support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 fs/direct-io.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a1..453dcff0e7f56 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -119,7 +119,6 @@ struct dio {
 	int flags;			/* doesn't change */
 	int op;
 	int op_flags;
-	blk_qc_t bio_cookie;
 	struct gendisk *bio_disk;
 	struct inode *inode;
 	loff_t i_size;			/* i_size when submitted */
@@ -438,11 +437,10 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 
 	dio->bio_disk = bio->bi_bdev->bd_disk;
 
-	if (sdio->submit_io) {
+	if (sdio->submit_io)
 		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);
-		dio->bio_cookie = BLK_QC_T_NONE;
-	} else
-		dio->bio_cookie = submit_bio(bio);
+	else
+		submit_bio(bio);
 
 	sdio->bio = NULL;
 	sdio->boundary = 0;
@@ -481,9 +479,7 @@ static struct bio *dio_await_one(struct dio *dio)
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		dio->waiter = current;
 		spin_unlock_irqrestore(&dio->bio_lock, flags);
-		if (!(dio->iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(dio->bio_disk->queue, dio->bio_cookie, true))
-			blk_io_schedule();
+		blk_io_schedule();
 		/* wake up sets us TASK_RUNNING */
 		spin_lock_irqsave(&dio->bio_lock, flags);
 		dio->waiter = NULL;
@@ -1214,8 +1210,6 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	} else {
 		dio->op = REQ_OP_READ;
 	}
-	if (iocb->ki_flags & IOCB_HIPRI)
-		dio->op_flags |= REQ_HIPRI;
 
 	/*
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
-- 
2.30.2

