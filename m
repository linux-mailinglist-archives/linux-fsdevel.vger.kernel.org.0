Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEDD36B45D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhDZN4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbhDZN4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:56:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADA3C061574;
        Mon, 26 Apr 2021 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=c6JrJQ0KHxFhLhxxsJhW7DwSDvDpmNej4l7yU0zgCb0=; b=h7QO0N3l5ndVoHi27BGixVgf/r
        dSQeR0g91KA5a7ODVnd72epa5WzQviOJosXRQGVWRkOnb5QfmL5l1CZLEQIscdwQRSAl5UhWiJQQ8
        DXUlvi8m0FKNROHx66XM26umOB/F2JsqVnlPHDZBbWRjbqnXwTEWHnowOxgIUjw1nDGp3qt4j/sST
        GbxMBmUqDlYH9PrfURE9oMllSifW2kJ4fuSRIAalea9i/JZd9Q9Cfx2+AS0Kkt9OJpI+98W2VP/zc
        t6+uEJfM0QGkUoBC7Vw7AN3MemUrSVqQwGkuWmxZY3FO3I3y7IfFLby2KZyt5m5ghO/ehOmbuIHy5
        m6ptXf9A==;
Received: from [2001:4bb8:18c:28b2:8b12:7453:9423:67a4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1hm-00Fzor-H6; Mon, 26 Apr 2021 13:55:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/12] block: rename REQ_HIPRI to REQ_POLLED
Date:   Mon, 26 Apr 2021 15:48:18 +0200
Message-Id: <20210426134821.2191160-10-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210426134821.2191160-1-hch@lst.de>
References: <20210426134821.2191160-1-hch@lst.de>
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
 block/blk-wbt.c           | 4 ++--
 drivers/nvme/host/core.c  | 2 +-
 include/linux/bio.h       | 2 +-
 include/linux/blk_types.h | 4 ++--
 mm/page_io.c              | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

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
index ffb4aa0ea68b..ef54c2e68657 100644
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
index 8ea96d83d599..cd1b34e2c6e7 100644
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
index 40b20f7986c1..c252d42b456f 100644
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
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 42aed0160f86..75787460726d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -445,7 +445,7 @@ static bool close_io(struct rq_wb *rwb)
 		time_before(now, rwb->last_comp + HZ / 10);
 }
 
-#define REQ_HIPRIO	(REQ_SYNC | REQ_META | REQ_PRIO)
+#define REQ_POLLEDO	(REQ_SYNC | REQ_META | REQ_PRIO)
 
 static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 {
@@ -469,7 +469,7 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 	 * the idle limit, or go to normal if we haven't had competing
 	 * IO for a bit.
 	 */
-	if ((rw & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())
+	if ((rw & REQ_POLLEDO) || wb_recent_wait(rwb) || current_is_kswapd())
 		limit = rwb->rq_depth.max_depth;
 	else if ((rw & REQ_BACKGROUND) || close_io(rwb)) {
 		/*
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642be..723a4c382385 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -958,7 +958,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 
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
index c493ce9ebcf5..dd86ea217da2 100644
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

