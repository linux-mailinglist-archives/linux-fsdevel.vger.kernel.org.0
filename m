Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7436B44B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhDZNxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:53:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD10C061574;
        Mon, 26 Apr 2021 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BYDMpQF26PpFAC2I7U15u7amVaqq3e9UvM7GFYHCEY0=; b=1aOHs6UeTWJXzn4ka5/Bt2SkhT
        N4iyHsyqUsRWFHDGTVztuBjwejjGRPcQMWCOjPR19x3TWak9XbvXwCVq/fVPZC2+Gf615I/QLgy/I
        eugBDTX7Rcp3ZF52NApbeQ7gwm6XKA2fwx9HYy2r1Dl5ss41DyHfSjXVXZGkCQm+zE9YfERTrHaJT
        zh/WcjbaNZpTH+HxjOH2xKKEoZQDxtMugcFJkAhLrLIORICt7JExeb7WBVVcPwboMo9BvbXALggYf
        aTjYMSRPRgjRWmZpL489FxNmFX4XXDduArjXrrB1K9WywYapJaEFK+f+Gt/izxYWQyf4HNe8NFf7d
        aj+oEZJw==;
Received: from 089144202077.atnat0011.highway.a1.net ([89.144.202.77] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1fL-00Fzkk-0o; Mon, 26 Apr 2021 13:52:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/12] direct-io: remove blk_poll support
Date:   Mon, 26 Apr 2021 15:48:10 +0200
Message-Id: <20210426134821.2191160-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The polling support in the legacy direct-io support is a little crufty.
It already doesn't support the asynchronous polling needed for io_uring
polling, and is hard to adopt to upcoming changes in the polling
interfaces.  Given that all the major file systems already use the iomap
direct I/O code, just drop the polling support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/direct-io.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b61491bf3166..237701c7e132 100644
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
@@ -1213,8 +1209,6 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	} else {
 		dio->op = REQ_OP_READ;
 	}
-	if (iocb->ki_flags & IOCB_HIPRI)
-		dio->op_flags |= REQ_HIPRI;
 
 	/*
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
-- 
2.30.1

