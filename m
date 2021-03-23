Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152E6345DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 13:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhCWMJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 08:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhCWMJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:09:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288DC061763
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 05:09:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so20528094wrn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 05:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B6h9ZiEvk3OjrxZiLfOl6jy0sUhDT3fazDwCa5g6frs=;
        b=O0kY6dQAKFr9wlu7HnQpMWqc6zZphu1xuqfTAOsUBlwOdjbfuoX8auWdcm/J7kF1q9
         86p/C7rWp3p4AI4OL0Khvxoc0onkh1X5vySB0k6tasLzuQ/Bxk4rsLC7fLRneNNqLAh/
         n1Xg6FotkEBB4otnLAs7F687FQFxc9U6G3WcicQqgBjr2+2eEG5zaXBpPZohEPRrmGjj
         EKky0wGDdoU0crenWHSBUWaiweGJTTlPRjjjtAUx0yC6kLEO1RfO5af7DqP5AJMZXqbA
         kF4ZLnNDQeuNyl5nm9nR1fP6LtkfFMIYDGuZz7Om99YpCxqKH0ypGEKl5a6fLqoH8MMw
         f8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B6h9ZiEvk3OjrxZiLfOl6jy0sUhDT3fazDwCa5g6frs=;
        b=kK3SHhyhuQv8ZDYI4CCfx1d7isjcspyOo78EJtSgdr1WYwBfOvfJVqQmeSVL+xXOlG
         faWS9AQXFQaJMCyrUGLt4oMvtou7Vn1HPJKiN9ke1ugclf4+mX7SzlP5PUXd1ZI2vT5p
         kUpHvhwnMlgPuXzusit5mtVMG6I+I/QY63EjPKOQ1anYs0u28HJ9PjI1if5EpOjhx4qE
         Xj0TOB9l/znqaQ6p9FfQys8wiJ7X7P4ntMdt0/xlZijr6cLbM6s+RzIl1kHKoeV0m1xS
         HvXXdbrNZ5VWnNRJoa6LhxCwhyRo8MD5iR67f830cwGd71520ohLX6oueLkSZ3/6SLNe
         U9uQ==
X-Gm-Message-State: AOAM531r0Gix+kDiAd29WHuntknVFV7piW/BMMG7+ZGT+Nu0CwgaYGJ7
        6Cd2htq3U5R0wPkRHIt4GXgXHA==
X-Google-Smtp-Source: ABdhPJxh5+BazkYu61xCb+72wUX5blxNp3zaRB7T4ZsXIuPKcNW/QJR2dpW9wpW3SOAFvEzbns2vig==
X-Received: by 2002:adf:ea0e:: with SMTP id q14mr3674929wrm.389.1616501343004;
        Tue, 23 Mar 2021 05:09:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4cfd:1405:ab5d:85f8])
        by smtp.gmail.com with ESMTPSA id r26sm2338599wmn.28.2021.03.23.05.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:09:02 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:08:55 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for
 remove_on_exec
Message-ID: <YFnaV/uY/fN9WI5+@elver.google.com>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
 <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
 <YFm6aakSRlF2nWtu@elver.google.com>
 <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
 <CANpmjNO1mRBFBQ6Rij-6ojVPKkaB6JLHD2WOVxhQeqxsqit2-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO1mRBFBQ6Rij-6ojVPKkaB6JLHD2WOVxhQeqxsqit2-Q@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:41AM +0100, Marco Elver wrote:
> On Tue, 23 Mar 2021 at 11:32, Peter Zijlstra <peterz@infradead.org> wrote:
[...]
> > > +             if (parent_event) {
> > >                       /*
> > > +                      * Remove event from parent, to avoid race where the
> > > +                      * parent concurrently iterates through its children to
> > > +                      * enable, disable, or otherwise modify an event.
> > >                        */
> > > +                     mutex_lock(&parent_event->child_mutex);
> > > +                     list_del_init(&event->child_list);
> > > +                     mutex_unlock(&parent_event->child_mutex);
> > >               }
> >
> >                 ^^^ this, right?
> >
> > But that's something perf_event_exit_event() alread does. So then you're
> > worried about the order of things.
> 
> Correct. We somehow need to prohibit the parent from doing an
> event_function_call() while we potentially deactivate the context with
> perf_remove_from_context().
> 
> > > +
> > > +             perf_remove_from_context(event, !!event->parent * DETACH_GROUP);
> > > +             perf_event_exit_event(event, ctx, current, true);
> > >       }
> >
> > perf_event_release_kernel() first does perf_remove_from_context() and
> > then clears the child_list, and that makes sense because if we're there,
> > there's no external access anymore, the filedesc is gone and nobody will
> > be iterating child_list anymore.
> >
> > perf_event_exit_task_context() and perf_event_exit_event() OTOH seem to
> > rely on ctx->task == TOMBSTONE to sabotage event_function_call() such
> > that if anybody is iterating the child_list, it'll NOP out.
> >
> > But here we don't have neither, and thus need to worry about the order
> > vs child_list iteration.
> >
> > I suppose we should stick sync_child_event() in there as well.
> >
> > And at that point there's very little value in still using
> > perf_event_exit_event()... let me see if there's something to be done
> > about that.
> 
> I don't mind dropping use of perf_event_exit_event() and open coding
> all of this. That would also avoid modifying perf_event_exit_event().
> 
> But I leave it to you what you think is nicest.

I played a bit more with it, and the below would be the version without
using perf_event_exit_event(). Perhaps it isn't too bad.

Thanks,
-- Marco

------ >8 ------

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa47e111435e..288b61820dab 100644
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
@@ -4196,43 +4207,86 @@ static void perf_event_enable_on_exec(int ctxn)
 }
 
 static void perf_remove_from_owner(struct perf_event *event);
-static void perf_event_exit_event(struct perf_event *child_event,
-				  struct perf_event_context *child_ctx,
-				  struct task_struct *child);
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *child);
+static void free_event(struct perf_event *event);
 
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
+
+		modified = true;
 
-			if (!is_kernel_event(event))
-				perf_remove_from_owner(event);
-			perf_remove_from_context(event, DETACH_GROUP);
+		if (parent_event) {
 			/*
-			 * Remove the event and feed back its values to the
-			 * parent event.
+			 * Remove event from parent *before* modifying contexts,
+			 * to avoid race where the parent concurrently iterates
+			 * through its children to enable, disable, or otherwise
+			 * modify an event.
 			 */
-			perf_event_exit_event(event, ctx, current);
+
+			sync_child_event(event, current);
+
+			WARN_ON_ONCE(parent_event->ctx->parent_ctx);
+			mutex_lock(&parent_event->child_mutex);
+			list_del_init(&event->child_list);
+			mutex_unlock(&parent_event->child_mutex);
+
+			perf_event_wakeup(parent_event);
+			put_event(parent_event);
 		}
-		mutex_unlock(&ctx->mutex);
-		put_ctx(ctx);
+
+		perf_remove_from_context(event, !!event->parent * DETACH_GROUP);
+
+		raw_spin_lock_irq(&ctx->lock);
+		WARN_ON_ONCE(ctx->is_active);
+		perf_event_set_state(event, PERF_EVENT_STATE_EXIT); /* is_event_hup() */
+		raw_spin_unlock_irq(&ctx->lock);
+
+		if (parent_event)
+			free_event(event);
+		else
+			perf_event_wakeup(event);
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
@@ -7581,20 +7635,18 @@ void perf_event_exec(void)
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
