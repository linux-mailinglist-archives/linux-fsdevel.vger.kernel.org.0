Return-Path: <linux-fsdevel+bounces-3498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8567F54EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 00:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6FF281714
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529D2137A;
	Wed, 22 Nov 2023 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xLIzK0cA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ADC19E
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 15:43:08 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700696585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sbglU1gTjhMh5AV26uS1M/ul7lMfc0IAqkXH+wYP664=;
	b=xLIzK0cADyb6SJHKhuqfQBRvKu9L5jzZLrfLilqAL1w2M26wvojb5PZEzhu/+eLi8Wckbz
	MCN4NFH+TbNoEmOGyM5qO/Iy1gC/kt6/af/7Y3fDg7wBO/wljRKUxiC9TcbuE+zHiIED3O
	+GYr/8KE92BVPCnagTflDLY6jtHZ1hc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: 
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/aio: obey min_nr when doing wakeups
Date: Wed, 22 Nov 2023 18:42:53 -0500
Message-ID: <20231122234257.179390-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Unclear who's maintaining fs/aio.c these days - who wants to take this?
-- >8 --

I've been observing workloads where IPIs due to wakeups in
aio_complete() are ~15% of total CPU time in the profile. Most of those
wakeups are unnecessary when completion batching is in use in
io_getevents().

This plumbs min_nr through via the wait eventry, so that aio_complete()
can avoid doing unnecessary wakeups.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Benjamin LaHaise <bcrl@kvack.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-aio@kvack.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/aio.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index f8589caef9c1..c69e7caacd1b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1106,6 +1106,11 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
 	kmem_cache_free(kiocb_cachep, iocb);
 }
 
+struct aio_waiter {
+	struct wait_queue_entry	w;
+	size_t			min_nr;
+};
+
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
@@ -1114,7 +1119,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
-	unsigned tail, pos, head;
+	unsigned tail, pos, head, avail;
 	unsigned long	flags;
 
 	/*
@@ -1156,6 +1161,10 @@ static void aio_complete(struct aio_kiocb *iocb)
 	ctx->completed_events++;
 	if (ctx->completed_events > 1)
 		refill_reqs_available(ctx, head, tail);
+
+	avail = tail > head
+		? tail - head
+		: tail + ctx->nr_events - head;
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	pr_debug("added to ring %p at [%u]\n", iocb, tail);
@@ -1176,8 +1185,18 @@ static void aio_complete(struct aio_kiocb *iocb)
 	 */
 	smp_mb();
 
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->wait)) {
+		struct aio_waiter *curr, *next;
+		unsigned long flags;
+
+		spin_lock_irqsave(&ctx->wait.lock, flags);
+		list_for_each_entry_safe(curr, next, &ctx->wait.head, w.entry)
+			if (avail >= curr->min_nr) {
+				list_del_init_careful(&curr->w.entry);
+				wake_up_process(curr->w.private);
+			}
+		spin_unlock_irqrestore(&ctx->wait.lock, flags);
+	}
 }
 
 static inline void iocb_put(struct aio_kiocb *iocb)
@@ -1290,7 +1309,9 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 			struct io_event __user *event,
 			ktime_t until)
 {
-	long ret = 0;
+	struct hrtimer_sleeper	t;
+	struct aio_waiter	w;
+	long ret = 0, ret2 = 0;
 
 	/*
 	 * Note that aio_read_events() is being called as the conditional - i.e.
@@ -1306,12 +1327,37 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	 * the ringbuffer empty. So in practice we should be ok, but it's
 	 * something to be aware of when touching this code.
 	 */
-	if (until == 0)
-		aio_read_events(ctx, min_nr, nr, event, &ret);
-	else
-		wait_event_interruptible_hrtimeout(ctx->wait,
-				aio_read_events(ctx, min_nr, nr, event, &ret),
-				until);
+	aio_read_events(ctx, min_nr, nr, event, &ret);
+	if (until == 0 || ret < 0 || ret >= min_nr)
+		return ret;
+
+	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	if (until != KTIME_MAX) {
+		hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
+		hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
+	}
+
+	init_wait(&w.w);
+
+	while (1) {
+		unsigned long nr_got = ret;
+
+		w.min_nr = min_nr - ret;
+
+		ret2 = prepare_to_wait_event(&ctx->wait, &w.w, TASK_INTERRUPTIBLE) ?:
+			!t.task ? -ETIME : 0;
+
+		if (aio_read_events(ctx, min_nr, nr, event, &ret) || ret2)
+			break;
+
+		if (nr_got == ret)
+			schedule();
+	}
+
+	finish_wait(&ctx->wait, &w.w);
+	hrtimer_cancel(&t.timer);
+	destroy_hrtimer_on_stack(&t.timer);
+
 	return ret;
 }
 
-- 
2.42.0


