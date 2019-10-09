Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF4D05ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfJIDVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:21:40 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58117 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730516AbfJIDVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:21:36 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 596B7363311;
        Wed,  9 Oct 2019 14:21:27 +1100 (AEDT)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-0006B4-M7; Wed, 09 Oct 2019 14:21:26 +1100
Received: from dave by discord.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1iI2XW-00038y-KH; Wed, 09 Oct 2019 14:21:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/26] xfs: Throttle commits on delayed background CIL push
Date:   Wed,  9 Oct 2019 14:21:00 +1100
Message-Id: <20191009032124.10541-3-david@fromorbit.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20191009032124.10541-1-david@fromorbit.com>
References: <20191009032124.10541-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=20KFwNOVAAAA:8
        a=tJydQp0-tQu7GIGPLyIA:9 a=6FibWmxOnplWDJ0V:21 a=ecaMPYEfmtohdEYC:21
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

In certain situations the background CIL push can be indefinitely
delayed. While we have workarounds from the obvious cases now, it
doesn't solve the underlying issue. This issue is that there is no
upper limit on the CIL where we will either force or wait for
a background push to start, hence allowing the CIL to grow without
bound until it consumes all log space.

To fix this, add a new wait queue to the CIL which allows background
pushes to wait for the CIL context to be switched out. This happens
when the push starts, so it will allow us to block incoming
transaction commit completion until the push has started. This will
only affect processes that are running modifications, and only when
the CIL threshold has been significantly overrun.

This has no apparent impact on performance, and doesn't even trigger
until over 45 million inodes had been created in a 16-way fsmark
test on a 2GB log. That was limiting at 64MB of log space used, so
the active CIL size is only about 3% of the total log in that case.
The concurrent removal of those files did not trigger the background
sleep at all.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_log_cil.c  | 37 +++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_log_priv.h | 24 ++++++++++++++++++++++++
 fs/xfs/xfs_trace.h    |  1 +
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index ef652abd112c..4a09d50e1368 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -670,6 +670,11 @@ xlog_cil_push(
 	push_seq = cil->xc_push_seq;
 	ASSERT(push_seq <= ctx->sequence);
 
+	/*
+	 * Wake up any background push waiters now this context is being pushed.
+	 */
+	wake_up_all(&ctx->push_wait);
+
 	/*
 	 * Check if we've anything to push. If there is nothing, then we don't
 	 * move on to a new sequence number and so we have to be able to push
@@ -746,6 +751,7 @@ xlog_cil_push(
 	 */
 	INIT_LIST_HEAD(&new_ctx->committing);
 	INIT_LIST_HEAD(&new_ctx->busy_extents);
+	init_waitqueue_head(&new_ctx->push_wait);
 	new_ctx->sequence = ctx->sequence + 1;
 	new_ctx->cil = cil;
 	cil->xc_ctx = new_ctx;
@@ -900,7 +906,7 @@ xlog_cil_push_work(
  */
 static void
 xlog_cil_push_background(
-	struct xlog	*log)
+	struct xlog	*log) __releases(cil->xc_ctx_lock)
 {
 	struct xfs_cil	*cil = log->l_cilp;
 
@@ -914,14 +920,36 @@ xlog_cil_push_background(
 	 * don't do a background push if we haven't used up all the
 	 * space available yet.
 	 */
-	if (cil->xc_ctx->space_used < XLOG_CIL_SPACE_LIMIT(log))
+	if (cil->xc_ctx->space_used < XLOG_CIL_SPACE_LIMIT(log)) {
+		up_read(&cil->xc_ctx_lock);
 		return;
+	}
 
 	spin_lock(&cil->xc_push_lock);
 	if (cil->xc_push_seq < cil->xc_current_sequence) {
 		cil->xc_push_seq = cil->xc_current_sequence;
 		queue_work(log->l_mp->m_cil_workqueue, &cil->xc_push_work);
 	}
+
+	/*
+	 * Drop the context lock now, we can't hold that if we need to sleep
+	 * because we are over the blocking threshold. The push_lock is still
+	 * held, so blocking threshold sleep/wakeup is still correctly
+	 * serialised here.
+	 */
+	up_read(&cil->xc_ctx_lock);
+
+	/*
+	 * If we are well over the space limit, throttle the work that is being
+	 * done until the push work on this context has begun.
+	 */
+	if (cil->xc_ctx->space_used >= XLOG_CIL_BLOCKING_SPACE_LIMIT(log)) {
+		trace_xfs_log_cil_wait(log, cil->xc_ctx->ticket);
+		ASSERT(cil->xc_ctx->space_used < log->l_logsize);
+		xlog_wait(&cil->xc_ctx->push_wait, &cil->xc_push_lock);
+		return;
+	}
+
 	spin_unlock(&cil->xc_push_lock);
 
 }
@@ -1038,9 +1066,9 @@ xfs_log_commit_cil(
 		if (lip->li_ops->iop_committing)
 			lip->li_ops->iop_committing(lip, xc_commit_lsn);
 	}
-	xlog_cil_push_background(log);
 
-	up_read(&cil->xc_ctx_lock);
+	/* xlog_cil_push_background() releases cil->xc_ctx_lock */
+	xlog_cil_push_background(log);
 }
 
 /*
@@ -1199,6 +1227,7 @@ xlog_cil_init(
 
 	INIT_LIST_HEAD(&ctx->committing);
 	INIT_LIST_HEAD(&ctx->busy_extents);
+	init_waitqueue_head(&ctx->push_wait);
 	ctx->sequence = 1;
 	ctx->cil = cil;
 	cil->xc_ctx = ctx;
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index a3cc8a9a16d9..f231b7dfaeab 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -247,6 +247,7 @@ struct xfs_cil_ctx {
 	struct xfs_log_vec	*lv_chain;	/* logvecs being pushed */
 	struct list_head	iclog_entry;
 	struct list_head	committing;	/* ctx committing list */
+	wait_queue_head_t	push_wait;	/* background push throttle */
 	struct work_struct	discard_endio_work;
 };
 
@@ -344,10 +345,33 @@ struct xfs_cil {
  *   buffer window (32MB) as measurements have shown this to be roughly the
  *   point of diminishing performance increases under highly concurrent
  *   modification workloads.
+ *
+ * To prevent the CIL from overflowing upper commit size bounds, we introduce a
+ * new threshold at which we block committing transactions until the background
+ * CIL commit commences and switches to a new context. While this is not a hard
+ * limit, it forces the process committing a transaction to the CIL to block and
+ * yeild the CPU, giving the CIL push work a chance to be scheduled and start
+ * work. This prevents a process running lots of transactions from overfilling
+ * the CIL because it is not yielding the CPU. We set the blocking limit at
+ * twice the background push space threshold so we keep in line with the AIL
+ * push thresholds.
+ *
+ * Note: this is not a -hard- limit as blocking is applied after the transaction
+ * is inserted into the CIL and the push has been triggered. It is largely a
+ * throttling mechanism that allows the CIL push to be scheduled and run. A hard
+ * limit will be difficult to implement without introducing global serialisation
+ * in the CIL commit fast path, and it's not at all clear that we actually need
+ * such hard limits given the ~7 years we've run without a hard limit before
+ * finding the first situation where a checkpoint size overflow actually
+ * occurred. Hence the simple throttle, and an ASSERT check to tell us that
+ * we've overrun the max size.
  */
 #define XLOG_CIL_SPACE_LIMIT(log)	\
 	min_t(int, (log)->l_logsize >> 3, BBTOB(XLOG_TOTAL_REC_SHIFT(log)) << 4)
 
+#define XLOG_CIL_BLOCKING_SPACE_LIMIT(log)	\
+	(XLOG_CIL_SPACE_LIMIT(log) * 2)
+
 /*
  * ticket grant locks, queues and accounting have their own cachlines
  * as these are quite hot and can be operated on concurrently.
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index eaae275ed430..e7087ede2662 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1011,6 +1011,7 @@ DEFINE_LOGGRANT_EVENT(xfs_log_regrant_reserve_sub);
 DEFINE_LOGGRANT_EVENT(xfs_log_ungrant_enter);
 DEFINE_LOGGRANT_EVENT(xfs_log_ungrant_exit);
 DEFINE_LOGGRANT_EVENT(xfs_log_ungrant_sub);
+DEFINE_LOGGRANT_EVENT(xfs_log_cil_wait);
 
 DECLARE_EVENT_CLASS(xfs_log_item_class,
 	TP_PROTO(struct xfs_log_item *lip),
-- 
2.23.0.rc1

