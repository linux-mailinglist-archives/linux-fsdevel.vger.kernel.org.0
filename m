Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEF636C921
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhD0QT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhD0QTw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:19:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209DCC06138F;
        Tue, 27 Apr 2021 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=lVkqHvIReOfSGmbD3L2sxnze/zU0iVpfY87YMi4utY8=; b=4En+QniWZdNJCjj+qgXh64u4n8
        L0jitySbi7DUWePMBcBBQFnkczNeK5IqT/6Dp1XtB8xp5AL3Fm9hAz3FIOeIbhkbe1OqehuYCVwIn
        ZYTvxmWmmEmahxDMXHvWLCviqXNMcappo50uNu9hUpz2AKpsWixxvJ0cMZhXkN20cavmIw0wQbtvz
        IhVoMbo5Ymnxmmo9cns9Mx0tBkANGGs3FDvuXoNJttQqpzrMUml1B7FPtYn4MfaXlZwfL/io8kI9G
        Qcsq8i/H95eLTFzfvjcA3aA98fslapl4d7WiIHpKV7NkJyUb8+dygbsCJpWLyoiYZVekYx3naMfDI
        xq3pk5gw==;
Received: from [2001:4bb8:18c:28b2:c772:7205:2aa4:840d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbQQO-00Gr5I-Of; Tue, 27 Apr 2021 16:19:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/15] block: rename REQ_HIPRI to REQ_POLLED
Date:   Tue, 27 Apr 2021 18:16:13 +0200
Message-Id: <20210427161619.1294399-10-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210427161619.1294399-1-hch@lst.de>
References: <20210427161619.1294399-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlike the RWF_HIPRI userspace ABI which is intentionally kept vague,
the bio flag is specіfic to the polling implementation, so rename and
document it properly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c          | 2 +-
 block/blk-merge.c         | 2 +-
 block/blk-mq-debugfs.c    | 2 +-
 block/blk-mq.c            | 4 ++--
 block/blk-mq.h            | 4 ++--
 drivers/nvme/host/core.c  | 2 +-
 include/linux/bio.h       | 2 +-
 include/linux/blk_types.h | 4 ++--
 mm/page_io.c              | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9bcdae93f6d4..adfab5976be0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -837,7 +837,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	}
 
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		bio->bi_opf &= ~REQ_HIPRI;
+		bio->bi_opf &= ~REQ_POLLED;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4d97fb6dd226..5c9d2a4ece86 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -285,7 +285,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
-	bio->bi_opf &= ~REQ_HIPRI;
+	bio->bi_opf &= ~REQ_POLLED;
 
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2a75bc7401df..0b821b369ffd 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -286,7 +286,7 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(BACKGROUND),
 	CMD_FLAG_NAME(NOWAIT),
 	CMD_FLAG_NAME(NOUNMAP),
-	CMD_FLAG_NAME(HIPRI),
+	CMD_FLAG_NAME(POLLED),
 };
 #undef CMD_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2e8a38618ebb..b35700710ef9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -667,7 +667,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
 	 */
-	if (rq->cmd_flags & REQ_HIPRI)
+	if (rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
@@ -2201,7 +2201,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
-	hipri = bio->bi_opf & REQ_HIPRI;
+	hipri = bio->bi_opf & REQ_POLLED;
 
 	data.cmd_flags = bio->bi_opf;
 	rq = __blk_mq_alloc_request(&data);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3616453ca28c..38eac0434a52 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -108,9 +108,9 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
 	/*
-	 * The caller ensure that if REQ_HIPRI, poll must be enabled.
+	 * The caller ensure that if REQ_POLLED, poll must be enabled.
 	 */
-	if (flags & REQ_HIPRI)
+	if (flags & REQ_POLLED)
 		type = HCTX_TYPE_POLL;
 	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f736fd36147c..0a8592f916cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -963,7 +963,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 
 	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
 
-	rq->cmd_flags |= REQ_HIPRI;
+	rq->cmd_flags |= REQ_POLLED;
 	rq->end_io_data = &wait;
 	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..439a70bc42e2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -817,7 +817,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
  */
 static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 {
-	bio->bi_opf |= REQ_HIPRI;
+	bio->bi_opf |= REQ_POLLED;
 	if (!is_sync_kiocb(kiocb))
 		bio->bi_opf |= REQ_NOWAIT;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d0cf835d3b50..ac60432752e3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -392,7 +392,7 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	__REQ_HIPRI,
+	__REQ_POLLED,		/* caller polls for completion using blk_poll */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -417,7 +417,7 @@ enum req_flag_bits {
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
-#define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_POLLED		(1ULL << __REQ_POLLED)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
diff --git a/mm/page_io.c b/mm/page_io.c
index 5d5543fcefa4..ed2eded74f3a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -416,7 +416,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	 * attempt to access it in the page fault retry time check.
 	 */
 	if (synchronous) {
-		bio->bi_opf |= REQ_HIPRI;
+		bio->bi_opf |= REQ_POLLED;
 		get_task_struct(current);
 		bio->bi_private = current;
 	}
-- 
2.30.1

