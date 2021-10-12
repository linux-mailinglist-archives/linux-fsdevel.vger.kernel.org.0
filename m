Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90D442A348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 13:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhJLLbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhJLLbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:31:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9973C061570;
        Tue, 12 Oct 2021 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FQ7vwZeOpRQAJ1L4QpSR1miovYWgbOxYMQuoV/N7+XI=; b=Rc9EyXBxnS8Iwro7aRdabpO8k7
        K2hfPml7uYLLTlL4qcBrGWiWRe/FibEGERa0TmbPBmBT+l6dwkotXqgqwVszx9yFXepCdGCiUvbx/
        fBggtlYZ8XIv8a6paXG/ETig1Ci8emB9cWLt1hLm/JI7N9A+Nu7nKE9yim2Pohnz8mMFfnJt9o4px
        3P2I7z5I/ap4NBaPPzo+qw5ltMg7Y5sZyvseRD5+85lQzWhfMwM6L0SR5IjXXRDu3yV0bohfmP7yH
        ltVjwuIO/QwlIIJ5NkcYHEb24ByCfCjoTIN5gkHxNH1hxShmUNoRtbUjHWzn1sU0efPjDXvowY3ku
        9glo6Rww==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFun-006S7g-K7; Tue, 12 Oct 2021 11:26:16 +0000
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
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 11/16] block: rename REQ_HIPRI to REQ_POLLED
Date:   Tue, 12 Oct 2021 13:12:21 +0200
Message-Id: <20211012111226.760968-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unlike the RWF_HIPRI userspace ABI which is intentionally kept vague,
the bio flag is specific to the polling implementation, so rename and
document it properly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-core.c          |  2 +-
 block/blk-merge.c         |  3 +--
 block/blk-mq-debugfs.c    |  2 +-
 block/blk-mq.c            |  4 ++--
 block/blk-mq.h            |  4 ++--
 block/blk.h               |  4 ++--
 drivers/nvme/host/core.c  |  2 +-
 drivers/scsi/scsi_debug.c | 10 +++++-----
 include/linux/bio.h       |  2 +-
 include/linux/blk_types.h |  4 ++--
 mm/page_io.c              |  2 +-
 11 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9b8c706701900..14559b23fbe2e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -824,7 +824,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	}
 
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		bio_clear_hipri(bio);
+		bio_clear_polled(bio);
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index bf7aedaad8f8e..762da71f9fde5 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -287,8 +287,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
-	bio_clear_hipri(bio);
-
+	bio_clear_polled(bio);
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4000376330c90..c345aef903358 100644
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
index b23dc0be01889..4dfa185f9f5b7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -702,7 +702,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
 	 */
-	if (rq->cmd_flags & REQ_HIPRI)
+	if (rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
@@ -2248,7 +2248,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
-	hipri = bio->bi_opf & REQ_HIPRI;
+	hipri = bio->bi_opf & REQ_POLLED;
 
 	plug = blk_mq_plug(q, bio);
 	if (plug && plug->cached_rq) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 5da970bb88659..a9fe01e149516 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -106,9 +106,9 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
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
diff --git a/block/blk.h b/block/blk.h
index 35ca73355f90c..afe0717b5e8e4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -396,11 +396,11 @@ extern struct device_attribute dev_attr_events;
 extern struct device_attribute dev_attr_events_async;
 extern struct device_attribute dev_attr_events_poll_msecs;
 
-static inline void bio_clear_hipri(struct bio *bio)
+static inline void bio_clear_polled(struct bio *bio)
 {
 	/* can't support alloc cache if we turn off polling */
 	bio_clear_flag(bio, BIO_PERCPU_CACHE);
-	bio->bi_opf &= ~REQ_HIPRI;
+	bio->bi_opf &= ~REQ_POLLED;
 }
 
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7fa75433c0361..56fca2cd42f03 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -632,7 +632,7 @@ static inline void nvme_init_request(struct request *req,
 
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	if (req->mq_hctx->type == HCTX_TYPE_POLL)
-		req->cmd_flags |= REQ_HIPRI;
+		req->cmd_flags |= REQ_POLLED;
 	nvme_clear_nvme_request(req);
 	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
 }
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 66f507469a31a..40b473eea357f 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5384,7 +5384,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 {
 	bool new_sd_dp;
 	bool inject = false;
-	bool hipri = scsi_cmd_to_rq(cmnd)->cmd_flags & REQ_HIPRI;
+	bool polled = scsi_cmd_to_rq(cmnd)->cmd_flags & REQ_POLLED;
 	int k, num_in_q, qdepth;
 	unsigned long iflags;
 	u64 ns_from_boot = 0;
@@ -5471,7 +5471,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (sdebug_host_max_queue)
 		sd_dp->hc_idx = get_tag(cmnd);
 
-	if (hipri)
+	if (polled)
 		ns_from_boot = ktime_get_boottime_ns();
 
 	/* one of the resp_*() response functions is called here */
@@ -5531,7 +5531,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				kt -= d;
 			}
 		}
-		if (hipri) {
+		if (polled) {
 			sd_dp->cmpl_ts = ktime_add(ns_to_ktime(ns_from_boot), kt);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
 			if (!sd_dp->init_poll) {
@@ -5562,7 +5562,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		if (unlikely((sdebug_opts & SDEBUG_OPT_CMD_ABORT) &&
 			     atomic_read(&sdeb_inject_pending)))
 			sd_dp->aborted = true;
-		if (hipri) {
+		if (polled) {
 			sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
 			if (!sd_dp->init_poll) {
@@ -7331,7 +7331,7 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 			if (kt_from_boot < sd_dp->cmpl_ts)
 				continue;
 
-		} else		/* ignoring non REQ_HIPRI requests */
+		} else		/* ignoring non REQ_POLLED requests */
 			continue;
 		devip = (struct sdebug_dev_info *)scp->device->hostdata;
 		if (likely(devip))
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 00952e92eae1b..0226a8c8fe810 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -784,7 +784,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
  */
 static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 {
-	bio->bi_opf |= REQ_HIPRI;
+	bio->bi_opf |= REQ_POLLED;
 	if (!is_sync_kiocb(kiocb))
 		bio->bi_opf |= REQ_NOWAIT;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5017ba8fc5392..f8b9fce688346 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -384,7 +384,7 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	__REQ_HIPRI,
+	__REQ_POLLED,		/* caller polls for completion using blk_poll */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -409,7 +409,7 @@ enum req_flag_bits {
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
-#define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_POLLED		(1ULL << __REQ_POLLED)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
diff --git a/mm/page_io.c b/mm/page_io.c
index 5d5543fcefa4e..ed2eded74f3ad 100644
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
2.30.2

