Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9423A0CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 23:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfH1Vyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 17:54:47 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46556 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbfH1Vyp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:54:45 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35to-00071m-Bo; Wed, 28 Aug 2019 15:54:44 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35tj-0001DD-5C; Wed, 28 Aug 2019 15:54:35 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 28 Aug 2019 15:54:27 -0600
Message-Id: <20190828215429.4572-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828215429.4572-1-logang@deltatee.com>
References: <20190828215429.4572-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v8 11/13] block: don't check blk_rq_is_passthrough() in blk_do_io_stat()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of checking blk_rq_is_passthruough() for every call to
blk_do_io_stat(), don't set RQF_IO_STAT for passthrough requests.
This should be equivalent, and opens the possibility of passthrough
requests specifically requesting statistics tracking.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-mq.c | 2 +-
 block/blk.h    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0835f4d8d42e..8e38491dfbf8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -318,7 +318,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->cmd_flags = op;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)
 		rq->rq_flags |= RQF_PREEMPT;
-	if (blk_queue_io_stat(data->q))
+	if (blk_queue_io_stat(data->q) && !blk_rq_is_passthrough(rq))
 		rq->rq_flags |= RQF_IO_STAT;
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_HLIST_NODE(&rq->hash);
diff --git a/block/blk.h b/block/blk.h
index de6b2e146d6e..554efa769bfe 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -234,13 +234,12 @@ int blk_dev_init(void);
  *
  *	a) it's attached to a gendisk, and
  *	b) the queue had IO stats enabled when this request was started, and
- *	c) it's a file system request
+ *	c) it's a file system request (RQF_IO_STAT will not be set otherwise)
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
 	return rq->rq_disk &&
-	       (rq->rq_flags & RQF_IO_STAT) &&
-		!blk_rq_is_passthrough(rq);
+	       (rq->rq_flags & RQF_IO_STAT);
 }
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
-- 
2.20.1

