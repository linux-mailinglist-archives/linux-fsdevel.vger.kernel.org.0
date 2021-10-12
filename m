Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88242A33E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhJLL3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbhJLL3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:29:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB7C061570;
        Tue, 12 Oct 2021 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OaGMCZewZE+zY7G2BT7mb4uPRFfUuvtwtFt2LjEHfxU=; b=GhGduB3CcIwZ1CfRTP4oCGIVYo
        HOYaaGzQ42mLuj5Bxgzn5Y2Nu1sazBYI3jZrre5SbDc9Rx3HAqv+vvY6aXDXMWfJ80G8WoDhOYsY5
        NPbhyo37WUWVSTUoAEYmYe2WYdFO3dGR2jHkI732D7nFgCBw2pEQ2yb7OrNnuAeOW/SubJxnpQpBV
        mnOfPj+Womb6kMjxG540CmSHizvzt6hfmaG37SozIdlh4fCPTRojQhTFCmDeApR9qjOzjPisHMQPP
        3q60nP2rAGP17F37gT9ON1RNTr9C7yHOKdtEbxothOVM0YxpF3LOiyk8gYdTLI7f0taHXcL6nAt8Q
        I/k8MyoA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFtQ-006S3I-HD; Tue, 12 Oct 2021 11:24:36 +0000
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
Subject: [PATCH 10/16] io_uring: don't sleep when polling for I/O
Date:   Tue, 12 Oct 2021 13:12:20 +0200
Message-Id: <20211012111226.760968-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no point in sleeping for the expected I/O completion timeout
in the io_uring async polling model as we never poll for a specific
I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c         | 3 ++-
 fs/io_uring.c          | 2 +-
 include/linux/blkdev.h | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d6e0beffaa6f3..b23dc0be01889 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4072,7 +4072,8 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	if (q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+	if (!(flags & BLK_POLL_NOSLEEP) &&
+	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
 	}
diff --git a/fs/io_uring.c b/fs/io_uring.c
index dc6af04d778f3..ba02d7d43334a 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2461,7 +2461,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			long min)
 {
-	unsigned int poll_flags = 0;
+	unsigned int poll_flags = BLK_POLL_NOSLEEP;
 	struct io_kiocb *req, *tmp;
 	LIST_HEAD(done);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e177346bc0208..2b80c98fc373e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -566,6 +566,8 @@ blk_status_t errno_to_blk_status(int errno);
 
 /* only poll the hardware once, don't continue until a completion was found */
 #define BLK_POLL_ONESHOT		(1 << 0)
+/* do not sleep to wait for the expected completion time */
+#define BLK_POLL_NOSLEEP		(1 << 1)
 int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-- 
2.30.2

