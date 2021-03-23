Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28A4345B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCWJxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhCWJwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:52:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BCFC061763
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 02:52:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so12625465wml.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NpSzRKLiXLe6KNJ61EsuxfhUG16pLqYRTekTKu3oBUc=;
        b=nm5ohOy/Tz6gPUdf2gMWQvMdzKZVF5SbH1eSB69U9CjPSipRPi2dy9NH/BJgO4jLNg
         4dBTd4IYQtJYOXQUUOn0CnfuHHIqA05xlBywDVEdHgK9e9JLfeuDvMdvB2lBrNVTX6pB
         OS3wLmA0KWDnggRMZC5exNJ1LY7jf4Jc7rKj/DNnZFJU43qEUyI/pDrRzlQjE/uh5FL1
         svDaPWuPSvyPXVYjIbXIS9D5+dYDOXdsSuiQB4M4UuUfVMMFORvbhAIOTdNWpN3mPPYT
         1f3Ohc5mhYZ544s8vKlpzR3OCxeCVcutUIw6XhSMG5tn43twR6QEfNQzopt3xcowAsdC
         PjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpSzRKLiXLe6KNJ61EsuxfhUG16pLqYRTekTKu3oBUc=;
        b=UWy9jEmjZ9jiX9yT5UOGtPxy2rY+jBoVo3jObs/RAMyuYIYVXcFlAAViHNM3msKeKp
         oWKdgPWr4meQvd1YIaAFn3tqmftSGxkElR7vHKlJgcpx8kiERRL5PRQL9S5wpxtPrjtY
         cEb5aF8r9e9b9mhsiGHe5XuRHKRxGrdzf13x8Ejg8Ud+n+C8V6xBaIhMy0ygT24ukHYm
         xSVx3/rIO8KXNGwvYTL+NzhXwOQ4D/fzYpSd568E7O8heUREgbXTfFpxdxYDY3oujv+E
         IxdFh96HhyGvUfG5u2vpVlN93u6nTb8PL9Zpba/Tuf5GtNPM3ur9piUBChtgk9CPzELP
         88rw==
X-Gm-Message-State: AOAM532JgtYowzXXELHWkRjXeEfL+V0creypdJ1oDt1CYvz7PhS1XZeX
        Qr5QUcdPYf7kqJlXUjsMGx+aAQ==
X-Google-Smtp-Source: ABdhPJynBtjtRFMq0h/oQx96ep++DSyzmkESiyVdIdheo9/1EBRWQVmH/fV5oKxUpBfhPw30yuFZYw==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr2555707wmf.165.1616493167647;
        Tue, 23 Mar 2021 02:52:47 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4cfd:1405:ab5d:85f8])
        by smtp.gmail.com with ESMTPSA id c9sm22669184wrr.78.2021.03.23.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:52:46 -0700 (PDT)
Date:   Tue, 23 Mar 2021 10:52:41 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <YFm6aakSRlF2nWtu@elver.google.com>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
 <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 05:42PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 02:24:40PM +0100, Marco Elver wrote:
> > To make compatible with more recent libc, we'll need to fixup the tests
> > with the below.
> 
> OK, that reprodiced things here, thanks!
> 
> The below seems to not explode instantly.... it still has the
> alternative version in as well (and I think it might even work too, but
> the one I left in seems simpler).

Thanks! Unfortunately neither version worked if I tortured it a little
with this:

	for x in {1..1000}; do ( tools/testing/selftests/perf_events/remove_on_exec & ); done

Which resulted in the 2 warnings:

	WARNING: CPU: 1 PID: 795 at kernel/events/core.c:242 event_function+0xf3/0x100
	WARNING: CPU: 1 PID: 795 at kernel/events/core.c:247 event_function+0xef/0x100

with efs->func==__perf_event_enable. I believe it's sufficient to add

	mutex_lock(&parent_event->child_mutex);
	list_del_init(&event->child_list);
	mutex_unlock(&parent_event->child_mutex);

right before removing from context. With the version I have now (below
for completeness), extended torture with the above test results in no
more warnings and the test also passes.


I'd be happy to send a non-RFC v3 with all that squashed in. I'd need
your Signed-off-by for the diff you sent to proceed (and add your
Co-developed-by).

Thanks,
-- Marco

------ >8 ------

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa47e111435e..cea7c88fe131 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2165,8 +2165,9 @@ static void perf_group_detach(struct perf_event *event)
 	 * If this is a sibling, remove it from its group.
 	 */
 	if (leader != event) {
+		leader->nr_siblings--;
 		list_del_init(&event->sibling_list);
-		event->group_leader->nr_siblings--;
+		event->group_leader = event;
 		goto out;
 	}
 
@@ -2180,8 +2181,9 @@ static void perf_group_detach(struct perf_event *event)
 		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
 			perf_remove_sibling_event(sibling);
 
-		sibling->group_leader = sibling;
+		leader->nr_siblings--;
 		list_del_init(&sibling->sibling_list);
+		sibling->group_leader = sibling;
 
 		/* Inherit group flags from the previous leader */
 		sibling->group_caps = event->group_caps;
@@ -2358,10 +2360,19 @@ __perf_remove_from_context(struct perf_event *event,
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
@@ -4198,41 +4209,68 @@ static void perf_event_enable_on_exec(int ctxn)
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
+		struct perf_event *parent_event = event->parent;
+
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
+		modified = true;
+
+		if (parent_event) {
 			/*
-			 * Remove the event and feed back its values to the
-			 * parent event.
+			 * Remove event from parent, to avoid race where the
+			 * parent concurrently iterates through its children to
+			 * enable, disable, or otherwise modify an event.
 			 */
-			perf_event_exit_event(event, ctx, current);
+			mutex_lock(&parent_event->child_mutex);
+			list_del_init(&event->child_list);
+			mutex_unlock(&parent_event->child_mutex);
 		}
-		mutex_unlock(&ctx->mutex);
-		put_ctx(ctx);
+
+		perf_remove_from_context(event, !!event->parent * DETACH_GROUP);
+		perf_event_exit_event(event, ctx, current, true);
 	}
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (modified)
+		clone_ctx = unclone_ctx(ctx);
+	--ctx->pin_count;
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
+unlock:
+	mutex_unlock(&ctx->mutex);
+
+	put_ctx(ctx);
+	if (clone_ctx)
+		put_ctx(clone_ctx);
 }
 
 struct perf_read_data {
@@ -7581,20 +7619,18 @@ void perf_event_exec(void)
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
@@ -12472,7 +12508,7 @@ static void sync_child_event(struct perf_event *child_event,
 static void
 perf_event_exit_event(struct perf_event *child_event,
 		      struct perf_event_context *child_ctx,
-		      struct task_struct *child)
+		      struct task_struct *child, bool removed)
 {
 	struct perf_event *parent_event = child_event->parent;
 
@@ -12489,12 +12525,15 @@ perf_event_exit_event(struct perf_event *child_event,
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
@@ -12580,7 +12619,7 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx, child);
+		perf_event_exit_event(child_event, child_ctx, child, false);
 
 	mutex_unlock(&child_ctx->mutex);
 
