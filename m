Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B763461C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhCWOqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhCWOqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:46:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529EBC061574;
        Tue, 23 Mar 2021 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NJf+HZsOodPaZPW38P1Cps8i58xLSQI9qQh/4dJkNeU=; b=kLSH1p6RG6cZLeYwyy1gl9p4dS
        s0vhnzxy8vzIum0++LWM3QIn9KYjyu7dRL+o1M2p663wEF01mi/I40vFi+q5s+c1kxEprYrOhKmby
        6WrAi/9mUnId/ZjtDCXFMIysyNg6I3WKK4sHZUkxbUTF3KRddI+q+Rn8cFmDNetE8ds/PQNFoafBm
        W+gcup2MWd1fEgwuLh/FiDAyPFjHONJ7lZDgrFOt1n3Ef8L0WvPOBGKLXqV9sldnamBD7dCINuLZ0
        X6/NDQb55DisVT656yPPHZsx/PpeJsHMM8vVUAhUA73zV1ygvmQzAvsVVo26z7x7/MiZXljRFyeJi
        6JivnI+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOiI8-00FCBz-R0; Tue, 23 Mar 2021 14:45:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7170130477A;
        Tue, 23 Mar 2021 15:45:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CC4C2D2A4F60; Tue, 23 Mar 2021 15:45:55 +0100 (CET)
Date:   Tue, 23 Mar 2021 15:45:55 +0100
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
Message-ID: <YFn/I3aKF+TOjGcl@hirez.programming.kicks-ass.net>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
 <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
 <YFm6aakSRlF2nWtu@elver.google.com>
 <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:32:03AM +0100, Peter Zijlstra wrote:

> And at that point there's very little value in still using
> perf_event_exit_event()... let me see if there's something to be done
> about that.

I ended up with something like the below. Which then simplifies
remove_on_exec() to:

static void perf_event_remove_on_exec(int ctxn)
{
	struct perf_event_context *ctx, *clone_ctx = NULL;
	struct perf_event *event, *next;
	bool modified = false;
	unsigned long flags;

	ctx = perf_pin_task_context(current, ctxn);
	if (!ctx)
		return;

	mutex_lock(&ctx->mutex);

	if (WARN_ON_ONCE(ctx->task != current))
		goto unlock;

	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
		if (!event->attr.remove_on_exec)
			continue;

		if (!is_kernel_event(event))
			perf_remove_from_owner(event);

		modified = true;

		perf_event_exit_event(event, ctx);
	}

	raw_spin_lock_irqsave(&ctx->lock, flags);
	if (modified)
		clone_ctx = unclone_ctx(ctx);
	--ctx->pin_count;
	raw_spin_unlock_irqrestore(&ctx->lock, flags);

unlock:
	mutex_unlock(&ctx->mutex);

	put_ctx(ctx);
	if (clone_ctx)
		put_ctx(clone_ctx);
}


Very lightly tested with that {1..1000} thing.

---

Subject: perf: Rework perf_event_exit_event()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Mar 23 15:16:06 CET 2021

Make perf_event_exit_event() more robust, such that we can use it from
other contexts. Specifically the up and coming remove_on_exec.

For this to work we need to address a few issues. Remove_on_exec will
not destroy the entire context, so we cannot rely on TASK_TOMBSTONE to
disable event_function_call() and we thus have to use
perf_remove_from_context().

When using perf_remove_from_context(), there's two races to consider.
The first is against close(), where we can have concurrent tear-down
of the event. The second is against child_list iteration, which should
not find a half baked event.

To address this, teach perf_remove_from_context() to special case
!ctx->is_active and about DETACH_CHILD.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |    1 
 kernel/events/core.c       |  144 +++++++++++++++++++++++++--------------------
 2 files changed, 81 insertions(+), 64 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -607,6 +607,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_TASK_DATA	0x08
 #define PERF_ATTACH_ITRACE	0x10
 #define PERF_ATTACH_SCHED_CB	0x20
+#define PERF_ATTACH_CHILD	0x40
 
 struct perf_cgroup;
 struct perf_buffer;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2210,6 +2210,26 @@ static void perf_group_detach(struct per
 	perf_event__header_size(leader);
 }
 
+static void sync_child_event(struct perf_event *child_event);
+
+static void perf_child_detach(struct perf_event *event)
+{
+	struct perf_event *parent_event = event->parent;
+
+	if (!(event->attach_state & PERF_ATTACH_CHILD))
+		return;
+
+	event->attach_state &= ~PERF_ATTACH_CHILD;
+
+	if (WARN_ON_ONCE(!parent_event))
+		return;
+
+	lockdep_assert_held(&parent_event->child_mutex);
+
+	sync_child_event(event);
+	list_del_init(&event->child_list);
+}
+
 static bool is_orphaned_event(struct perf_event *event)
 {
 	return event->state == PERF_EVENT_STATE_DEAD;
@@ -2317,6 +2337,7 @@ group_sched_out(struct perf_event *group
 }
 
 #define DETACH_GROUP	0x01UL
+#define DETACH_CHILD	0x02UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2340,6 +2361,8 @@ __perf_remove_from_context(struct perf_e
 	event_sched_out(event, cpuctx, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
+	if (flags & DETACH_CHILD)
+		perf_child_detach(event);
 	list_del_event(event, ctx);
 
 	if (!ctx->nr_events && ctx->is_active) {
@@ -2368,25 +2391,21 @@ static void perf_remove_from_context(str
 
 	lockdep_assert_held(&ctx->mutex);
 
-	event_function_call(event, __perf_remove_from_context, (void *)flags);
-
 	/*
-	 * The above event_function_call() can NO-OP when it hits
-	 * TASK_TOMBSTONE. In that case we must already have been detached
-	 * from the context (by perf_event_exit_event()) but the grouping
-	 * might still be in-tact.
-	 */
-	WARN_ON_ONCE(event->attach_state & PERF_ATTACH_CONTEXT);
-	if ((flags & DETACH_GROUP) &&
-	    (event->attach_state & PERF_ATTACH_GROUP)) {
-		/*
-		 * Since in that case we cannot possibly be scheduled, simply
-		 * detach now.
-		 */
-		raw_spin_lock_irq(&ctx->lock);
-		perf_group_detach(event);
+	 * Because of perf_event_exit_task(), perf_remove_from_context() ought
+	 * to work in the face of TASK_TOMBSTONE, unlike every other
+	 * event_function_call() user.
+	 */
+	raw_spin_lock_irq(&ctx->lock);
+	if (!ctx->is_active) {
+		__perf_remove_from_context(event, __get_cpu_context(ctx),
+					   ctx, (void *)flags);
 		raw_spin_unlock_irq(&ctx->lock);
+		return;
 	}
+	raw_spin_unlock_irq(&ctx->lock);
+
+	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
 /*
@@ -12379,14 +12398,17 @@ void perf_pmu_migrate_context(struct pmu
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
 
-static void sync_child_event(struct perf_event *child_event,
-			       struct task_struct *child)
+static void sync_child_event(struct perf_event *child_event)
 {
 	struct perf_event *parent_event = child_event->parent;
 	u64 child_val;
 
-	if (child_event->attr.inherit_stat)
-		perf_event_read_event(child_event, child);
+	if (child_event->attr.inherit_stat) {
+		struct task_struct *task = child_event->ctx->task;
+
+		if (task)
+			perf_event_read_event(child_event, task);
+	}
 
 	child_val = perf_event_count(child_event);
 
@@ -12401,60 +12423,53 @@ static void sync_child_event(struct perf
 }
 
 static void
-perf_event_exit_event(struct perf_event *child_event,
-		      struct perf_event_context *child_ctx,
-		      struct task_struct *child)
+perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 {
-	struct perf_event *parent_event = child_event->parent;
+	struct perf_event *parent_event = event->parent;
+	unsigned long detach_flags = 0;
 
-	/*
-	 * Do not destroy the 'original' grouping; because of the context
-	 * switch optimization the original events could've ended up in a
-	 * random child task.
-	 *
-	 * If we were to destroy the original group, all group related
-	 * operations would cease to function properly after this random
-	 * child dies.
-	 *
-	 * Do destroy all inherited groups, we don't care about those
-	 * and being thorough is better.
-	 */
-	raw_spin_lock_irq(&child_ctx->lock);
-	WARN_ON_ONCE(child_ctx->is_active);
+	if (parent_event) {
+		/*
+		 * Do not destroy the 'original' grouping; because of the
+		 * context switch optimization the original events could've
+		 * ended up in a random child task.
+		 *
+		 * If we were to destroy the original group, all group related
+		 * operations would cease to function properly after this
+		 * random child dies.
+		 *
+		 * Do destroy all inherited groups, we don't care about those
+		 * and being thorough is better.
+		 */
+		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		mutex_lock(&parent_event->child_mutex);
+	}
 
-	if (parent_event)
-		perf_group_detach(child_event);
-	list_del_event(child_event, child_ctx);
-	perf_event_set_state(child_event, PERF_EVENT_STATE_EXIT); /* is_event_hup() */
-	raw_spin_unlock_irq(&child_ctx->lock);
+	perf_remove_from_context(event, detach_flags);
+
+	raw_spin_lock_irq(&ctx->lock);
+	if (event->state > PERF_EVENT_STATE_EXIT)
+		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
+	raw_spin_unlock_irq(&ctx->lock);
 
 	/*
-	 * Parent events are governed by their filedesc, retain them.
+	 * Child events can be freed.
 	 */
-	if (!parent_event) {
-		perf_event_wakeup(child_event);
+	if (parent_event) {
+		mutex_unlock(&parent_event->child_mutex);
+		/*
+		 * Kick perf_poll() for is_event_hup();
+		 */
+		perf_event_wakeup(parent_event);
+		free_event(event);
+		put_event(parent_event);
 		return;
 	}
-	/*
-	 * Child events can be cleaned up.
-	 */
-
-	sync_child_event(child_event, child);
 
 	/*
-	 * Remove this event from the parent's list
-	 */
-	WARN_ON_ONCE(parent_event->ctx->parent_ctx);
-	mutex_lock(&parent_event->child_mutex);
-	list_del_init(&child_event->child_list);
-	mutex_unlock(&parent_event->child_mutex);
-
-	/*
-	 * Kick perf_poll() for is_event_hup().
+	 * Parent events are governed by their filedesc, retain them.
 	 */
-	perf_event_wakeup(parent_event);
-	free_event(child_event);
-	put_event(parent_event);
+	perf_event_wakeup(event);
 }
 
 static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
@@ -12511,7 +12526,7 @@ static void perf_event_exit_task_context
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx, child);
+		perf_event_exit_event(child_event, child_ctx);
 
 	mutex_unlock(&child_ctx->mutex);
 
@@ -12771,6 +12786,7 @@ inherit_event(struct perf_event *parent_
 	 */
 	raw_spin_lock_irqsave(&child_ctx->lock, flags);
 	add_event_to_ctx(child_event, child_ctx);
+	child_event->attach_state |= PERF_ATTACH_CHILD;
 	raw_spin_unlock_irqrestore(&child_ctx->lock, flags);
 
 	/*
