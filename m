Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19C13A7EDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFONQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 09:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhFONQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:16:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2465C061574;
        Tue, 15 Jun 2021 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4AJHuabwZbAx4k/MvJNAp/pK/y48NSs1yk3HXkV1xfU=; b=oAvcwy/u++6FMQ8ONqgnVOC+Ef
        DMfOEm5rkf7xTca3/RyEo6RQGgqlyxEH/dlp4Uiqrq9I/ro/q46SlioQJYWi0M7T3RW+hq9Q2gj2c
        z5PIgNsgNilCBozSaicMyLTuZh/1r6GoxrDYu5168+A6sEdtkGgWSxWrgUfyWogTMPwcCDL9PGLqe
        EF/GuT8vIay8ogBYv9YqxRsBg+bwc+24jhC2C35TmazKlwL9LRsvfp5VXBsIPHi4oRDej4A4YdZNO
        hBguiD05S8XYOxEIEpKPijcvehnLu2+s/oh9DM/nGe0ynkwEK/j4wdaP4e6+ylr/1XPQL3ruzPZMQ
        1UU9kWMA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lt8sX-006nLV-4Z; Tue, 15 Jun 2021 13:13:19 +0000
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
Subject: [PATCH 09/16] io_uring: don't sleep when polling for I/O
Date:   Tue, 15 Jun 2021 15:10:27 +0200
Message-Id: <20210615131034.752623-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
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
index c2b2c7abd712..86e59ffcca44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4002,7 +4002,8 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	if (q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+	if (!(flags & BLK_POLL_NOSLEEP) &&
+	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
 	}
diff --git a/fs/io_uring.c b/fs/io_uring.c
index de8d39e9a154..6ce1e5b60725 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2290,7 +2290,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			long min)
 {
-	unsigned int poll_flags = 0;
+	unsigned int poll_flags = BLK_POLL_NOSLEEP;
 	struct io_kiocb *req, *tmp;
 	LIST_HEAD(done);
 	int ret = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c7061f25ee5f..821d721f78e7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -948,6 +948,8 @@ blk_status_t errno_to_blk_status(int errno);
 
 /* only poll the hardware once, don't continue until a completion was found */
 #define BLK_POLL_ONESHOT		(1 << 0)
+/* do not sleep to wait for the expected completion time */
+#define BLK_POLL_NOSLEEP		(1 << 1)
 int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-- 
2.30.2

