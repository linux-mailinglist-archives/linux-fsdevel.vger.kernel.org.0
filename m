Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622E067564D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 15:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjATOEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 09:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATOD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:03:59 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5A10F4;
        Fri, 20 Jan 2023 06:03:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674223435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sy7eMQzxcTa/bh+mUhi76yBRMuqFbyrbkkHTHv1Udhg=;
        b=f7AHZlnjAPNNXFg75Batm8SpXClWMYWFjfBADNg8RH4JTrffz3mU0HurWjRmqY7J7KSi8P
        sfKfNL7HsEUAgBh6z0PCQabIHjliW3GFo7x6k3M+basy3JzRdyC+kHTAzLrkaK2KmprkgH
        3HyWnD3v99v1NZfXDf3iLShugGzZ3lY=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] fs/aio: obey min_nr when doing wakeups
Date:   Fri, 20 Jan 2023 09:03:47 -0500
Message-Id: <20230120140347.2133611-1-kent.overstreet@linux.dev>
In-Reply-To: <20230118152603.28301-1-kent.overstreet@linux.dev>
References: <20230118152603.28301-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been observing workloads where IPIs due to wakeups in
aio_complete() are ~15% of total CPU time in the profile. Most of those
wakeups are unnecessary when completion batching is in use in
io_getevents().

This plumbs min_nr through via the wait eventry, so that aio_complete()
can avoid doing unnecessary wakeups.

v2: This fixes a race in the first version of the patch. If we read some
events out after adding to the waitlist, we need to update wait.min_nr
call prepare_to_wait_event() again before scheduling.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Benjamin LaHaise <bcrl@kvack.org
Cc: linux-aio@kvack.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/aio.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3f795ed2a2..5be35cb8ec 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1105,6 +1105,11 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
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
@@ -1113,7 +1118,7 @@ static void aio_complete(struct aio_kiocb *iocb)
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
 	struct io_event	*ev_page, *event;
-	unsigned tail, pos, head;
+	unsigned tail, pos, head, avail;
 	unsigned long	flags;
 
 	/*
@@ -1157,6 +1162,10 @@ static void aio_complete(struct aio_kiocb *iocb)
 	ctx->completed_events++;
 	if (ctx->completed_events > 1)
 		refill_reqs_available(ctx, head, tail);
+
+	avail = tail > head
+		? tail - head
+		: tail + ctx->nr_events - head;
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	pr_debug("added to ring %p at [%u]\n", iocb, tail);
@@ -1177,8 +1186,18 @@ static void aio_complete(struct aio_kiocb *iocb)
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
@@ -1294,7 +1313,9 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 			struct io_event __user *event,
 			ktime_t until)
 {
-	long ret = 0;
+	struct hrtimer_sleeper	t;
+	struct aio_waiter	w;
+	long ret = 0, ret2 = 0;
 
 	/*
 	 * Note that aio_read_events() is being called as the conditional - i.e.
@@ -1310,12 +1331,37 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
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
2.39.0

