Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D6B344C0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCVQpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhCVQpU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:45:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA7C061574;
        Mon, 22 Mar 2021 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1df6usl2xnnPsrzqbx3EXcAa7CHt7bVOPUkJ821J5Gw=; b=vdjjBNmqMgrKZCy+BgdAnzP/5W
        QRR0Vsd6rGB02ZnaaTTlab42XbRMD6nTGnUFZ8ot4qrZT6xTPJKky5ouao/v6uEWeLX6aEOp7UaLB
        NYKAoH+2YuXEdhhPnLmLlFX82ajJXiURPDhDd0yeZmv2LPT85O2/VXAjijXpDHhpSMJ9e2vHR95nH
        Z1dOGHMd4MZbCaIh6ZkRK8ywSdvU70hpIeQQAsM+N8F9WbXqiyKOHXToNtfAqjuhOHxaH8P4UzD4t
        YxYyFAVoHKrsi3r7KphkSSo8xEmqdaZGufK9cH6D+30vLZb5nhqfxy7tVNOE0LpO1WHo6zPAEc7Cr
        fiv6aR0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lONd9-008nQ9-Ma; Mon, 22 Mar 2021 16:42:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E55BC30377D;
        Mon, 22 Mar 2021 17:42:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C792A2BF3371C; Mon, 22 Mar 2021 17:42:14 +0100 (CET)
Date:   Mon, 22 Mar 2021 17:42:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for
 remove_on_exec
Message-ID: <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFiamKX+xYH2HJ4E@elver.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:24:40PM +0100, Marco Elver wrote:
> To make compatible with more recent libc, we'll need to fixup the tests
> with the below.

OK, that reprodiced things here, thanks!

The below seems to not explode instantly.... it still has the
alternative version in as well (and I think it might even work too, but
the one I left in seems simpler).

---

 kernel/events/core.c | 154 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 43 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a7220e8c447e..8c0f905cc017 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2167,8 +2172,9 @@ static void perf_group_detach(struct perf_event *event)
 	 * If this is a sibling, remove it from its group.
 	 */
 	if (leader != event) {
+		leader->nr_siblings--;
 		list_del_init(&event->sibling_list);
-		event->group_leader->nr_siblings--;
+		event->group_leader = event;
 		goto out;
 	}
 
@@ -2182,8 +2188,9 @@ static void perf_group_detach(struct perf_event *event)
 		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
 			perf_remove_sibling_event(sibling);
 
-		sibling->group_leader = sibling;
+		leader->nr_siblings--;
 		list_del_init(&sibling->sibling_list);
+		sibling->group_leader = sibling;
 
 		/* Inherit group flags from the previous leader */
 		sibling->group_caps = event->group_caps;
@@ -2360,10 +2367,19 @@ __perf_remove_from_context(struct perf_event *event,
 static void perf_remove_from_context(struct perf_event *event, unsigned long flags)
 {
 	struct perf_event_context *ctx = event->ctx;
+	bool remove;
 
 	lockdep_assert_held(&ctx->mutex);
 
-	event_function_call(event, __perf_remove_from_context, (void *)flags);
+	/*
+	 * There is concurrency vs remove_on_exec().
+	 */
+	raw_spin_lock_irq(&ctx->lock);
+	remove = (event->attach_state & PERF_ATTACH_CONTEXT);
+	raw_spin_unlock_irq(&ctx->lock);
+
+	if (remove)
+		event_function_call(event, __perf_remove_from_context, (void *)flags);
 
 	/*
 	 * The above event_function_call() can NO-OP when it hits
@@ -4232,41 +4248,92 @@ static void perf_event_enable_on_exec(int ctxn)
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *child_event,
 				  struct perf_event_context *child_ctx,
-				  struct task_struct *child);
+				  struct task_struct *child,
+				  bool removed);
 
 /*
  * Removes all events from the current task that have been marked
  * remove-on-exec, and feeds their values back to parent events.
  */
-static void perf_event_remove_on_exec(void)
+static void perf_event_remove_on_exec(int ctxn)
 {
-	int ctxn;
+	struct perf_event_context *ctx, *clone_ctx = NULL;
+	struct perf_event *event, *next;
+	LIST_HEAD(free_list);
+	unsigned long flags;
+	bool modified = false;
 
-	for_each_task_context_nr(ctxn) {
-		struct perf_event_context *ctx;
-		struct perf_event *event, *next;
+	ctx = perf_pin_task_context(current, ctxn);
+	if (!ctx)
+		return;
 
-		ctx = perf_pin_task_context(current, ctxn);
-		if (!ctx)
+	mutex_lock(&ctx->mutex);
+
+	if (WARN_ON_ONCE(ctx->task != current))
+		goto unlock;
+
+	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+		if (!event->attr.remove_on_exec)
 			continue;
-		mutex_lock(&ctx->mutex);
 
-		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
-			if (!event->attr.remove_on_exec)
-				continue;
+		if (!is_kernel_event(event))
+			perf_remove_from_owner(event);
 
-			if (!is_kernel_event(event))
-				perf_remove_from_owner(event);
-			perf_remove_from_context(event, DETACH_GROUP);
-			/*
-			 * Remove the event and feed back its values to the
-			 * parent event.
-			 */
-			perf_event_exit_event(event, ctx, current);
-		}
-		mutex_unlock(&ctx->mutex);
-		put_ctx(ctx);
+		modified = true;
+
+		perf_remove_from_context(event, !!event->parent * DETACH_GROUP);
+		perf_event_exit_event(event, ctx, current, true);
+	}
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (modified)
+		clone_ctx = unclone_ctx(ctx);
+	--ctx->pin_count;
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
+#if 0
+	struct perf_cpu_context *cpuctx;
+
+	if (!modified) {
+		perf_unpin_context(ctx);
+		goto unlock;
+	}
+
+	local_irq_save(flags);
+	cpuctx = __get_cpu_context(ctx);
+	perf_ctx_lock(cpuctx, ctx);
+	task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
+
+	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+		if (!event->attr.remove_on_exec)
+			continue;
+
+		if (event->parent)
+			perf_group_detach(event);
+		list_del_event(event, ctx);
+
+		list_add(&event->active_list, &free_list);
+	}
+
+	ctx_resched(cpuctx, ctx, EVENT_ALL);
+
+	clone_ctx = unclone_ctx(ctx);
+	--ctx->pin_count;
+	perf_ctx_unlock(cpuctx, ctx);
+	local_irq_restore(flags);
+
+	list_for_each_entry_safe(event, next, &free_list, active_entry) {
+		list_del(&event->active_entry);
+		perf_event_exit_event(event, ctx, current, true);
 	}
+#endif
+
+unlock:
+	mutex_unlock(&ctx->mutex);
+
+	put_ctx(ctx);
+	if (clone_ctx)
+		put_ctx(clone_ctx);
 }
 
 struct perf_read_data {
@@ -7615,20 +7682,18 @@ void perf_event_exec(void)
 	struct perf_event_context *ctx;
 	int ctxn;
 
-	rcu_read_lock();
 	for_each_task_context_nr(ctxn) {
-		ctx = current->perf_event_ctxp[ctxn];
-		if (!ctx)
-			continue;
-
 		perf_event_enable_on_exec(ctxn);
+		perf_event_remove_on_exec(ctxn);
 
-		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL,
-				   true);
+		rcu_read_lock();
+		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
+		if (ctx) {
+			perf_iterate_ctx(ctx, perf_event_addr_filters_exec,
+					 NULL, true);
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
-
-	perf_event_remove_on_exec();
 }
 
 struct remote_output {
@@ -12509,7 +12574,7 @@ static void sync_child_event(struct perf_event *child_event,
 static void
 perf_event_exit_event(struct perf_event *child_event,
 		      struct perf_event_context *child_ctx,
-		      struct task_struct *child)
+		      struct task_struct *child, bool removed)
 {
 	struct perf_event *parent_event = child_event->parent;
 
@@ -12526,12 +12591,15 @@ perf_event_exit_event(struct perf_event *child_event,
 	 * and being thorough is better.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	WARN_ON_ONCE(child_ctx->is_active);
+	if (!removed) {
+		WARN_ON_ONCE(child_ctx->is_active);
 
-	if (parent_event)
-		perf_group_detach(child_event);
-	list_del_event(child_event, child_ctx);
-	perf_event_set_state(child_event, PERF_EVENT_STATE_EXIT); /* is_event_hup() */
+		if (parent_event)
+			perf_group_detach(child_event);
+		list_del_event(child_event, child_ctx);
+	}
+	if (child_event->state >= PERF_EVENT_STATE_EXIT)
+		perf_event_set_state(child_event, PERF_EVENT_STATE_EXIT); /* is_event_hup() */
 	raw_spin_unlock_irq(&child_ctx->lock);
 
 	/*
@@ -12617,7 +12685,7 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx, child);
+		perf_event_exit_event(child_event, child_ctx, child, false);
 
 	mutex_unlock(&child_ctx->mutex);
 
