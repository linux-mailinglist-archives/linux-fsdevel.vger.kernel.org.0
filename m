Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC45343C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCVJUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCVJUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:20:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986DC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 02:20:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 12so9042966wmf.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F5/VR6ur6ttgORsBImTX+DpB0R63FTk/snr4DsJXf+o=;
        b=LAlde5AAdUVapw7vv1gIYubILL5Z2XANHWPhRQ/hbJ2Fou/NTJgHUFVZTaxjyRz3Ew
         PTe96LsHdHSVzBvhe5oibh2MqK+onBku6Nwv46INNhyog8/I8FkmIm/kcSmyGuUY7ywC
         edqX4hukcMMkcYjyrzb7l529S4IiCtdLP8oFMKrQPc5AWNL8UaydZOMkpk3Dm+IPHWcA
         mx/Y5mzudbzTxHmc0dMQ6vbY3qw9vo3Xr8DeWuyUU2O2aEsj+t3FTqL5BXJzI0dZPni3
         lRR9RaZM5hxKBqmrPe69kXeUTEHXrHe4wGYO4NTdmIaIfPmjAClTVL8KC1+wYVRa1a1D
         NaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F5/VR6ur6ttgORsBImTX+DpB0R63FTk/snr4DsJXf+o=;
        b=rgot+myFT+zK6oJcapY2QObB1r4xQOtDWS7dNmmg9Qu3cMXqqA5KkZAAGwgGQsg/Vx
         +iGEkX0lAajGiT0pOxtnZ4pUHEBelckcdkV/AWHSBHUeYfvpO5Nt0r2iN9Wp2x5oe0dn
         AvMTCAvihDl8UBKiGsV2Cm7U5YypKToStRukTBy8WS0rVMk4XwQXLzLFTMLPIWPZN3oZ
         3vwvmdDLkwAt7C9VTZTIH1KO1ACe9Oj4/eFLoS8l7EFQDbe2kEiGX7uShm5aKKCe7/jh
         QAgjgLgtdRRJAFVzE9EsK+ul8R1C0L6nTY5RmE46ZYT03ZCdsrFbH4KvUEykyJZ2OCyi
         R1/w==
X-Gm-Message-State: AOAM533VxopABky3X8Pj3GeFDb91dYQzMsvA4l8ywLEqG4dWbOIhq6jB
        o7jSx60LX66peeEB4EvXFhLCgQ==
X-Google-Smtp-Source: ABdhPJxdUPu8j7Fbf9CICQn/Kem6MGhyHY+14eKuLhORG8IcT+mpqiseapeHYTtiETMKXgFIbIShSQ==
X-Received: by 2002:a05:600c:4013:: with SMTP id i19mr14956538wmm.33.1616404808866;
        Mon, 22 Mar 2021 02:20:08 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:58e2:985b:a5ad:807c])
        by smtp.gmail.com with ESMTPSA id u3sm19133667wrt.82.2021.03.22.02.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:20:08 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:20:02 +0100
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
Subject: Re: [PATCH RFC v2 3/8] perf/core: Add support for event removal on
 exec
Message-ID: <YFhhQgUzXLSTlcu0@elver.google.com>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-4-elver@google.com>
 <YFDbP3obvxn0SL4w@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFDbP3obvxn0SL4w@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 05:22PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 11:41:34AM +0100, Marco Elver wrote:
> > Adds bit perf_event_attr::remove_on_exec, to support removing an event
> > from a task on exec.
> > 
> > This option supports the case where an event is supposed to be
> > process-wide only, and should not propagate beyond exec, to limit
> > monitoring to the original process image only.
> > 
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> > +/*
> > + * Removes all events from the current task that have been marked
> > + * remove-on-exec, and feeds their values back to parent events.
> > + */
> > +static void perf_event_remove_on_exec(void)
> > +{
> > +	int ctxn;
> > +
> > +	for_each_task_context_nr(ctxn) {
> > +		struct perf_event_context *ctx;
> > +		struct perf_event *event, *next;
> > +
> > +		ctx = perf_pin_task_context(current, ctxn);
> > +		if (!ctx)
> > +			continue;
> > +		mutex_lock(&ctx->mutex);
> > +
> > +		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
> > +			if (!event->attr.remove_on_exec)
> > +				continue;
> > +
> > +			if (!is_kernel_event(event))
> > +				perf_remove_from_owner(event);
> > +			perf_remove_from_context(event, DETACH_GROUP);
> 
> There's a comment on this in perf_event_exit_event(), if this task
> happens to have the original event, then DETACH_GROUP will destroy the
> grouping.
> 
> I think this wants to be:
> 
> 			perf_remove_from_text(event,
> 					      child_event->parent ?  DETACH_GROUP : 0);
> 
> or something.
> 
> > +			/*
> > +			 * Remove the event and feed back its values to the
> > +			 * parent event.
> > +			 */
> > +			perf_event_exit_event(event, ctx, current);
> 
> Oooh, and here we call it... but it will do list_del_even() /
> perf_group_detach() *again*.
> 
> So the problem is that perf_event_exit_task_context() doesn't use
> remove_from_context(), but instead does task_ctx_sched_out() and then
> relies on the events not being active.
> 
> Whereas above you *DO* use remote_from_context(), but then
> perf_event_exit_event() will try and remove it more.

AFAIK, we want to deallocate the events and not just remove them, so
doing what perf_event_exit_event() is the right way forward? Or did you
have something else in mind?

I'm still trying to make sense of the zoo of synchronisation mechanisms
at play here. No matter what I try, it seems I get stuck on the fact
that I can't cleanly "pause" the context to remove the events (warnings
in event_function()).

This is what I've been playing with to understand:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 450ea9415ed7..c585cef284a0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4195,6 +4195,88 @@ static void perf_event_enable_on_exec(int ctxn)
 		put_ctx(clone_ctx);
 }
 
+static void perf_remove_from_owner(struct perf_event *event);
+static void perf_event_exit_event(struct perf_event *child_event,
+				  struct perf_event_context *child_ctx,
+				  struct task_struct *child);
+
+/*
+ * Removes all events from the current task that have been marked
+ * remove-on-exec, and feeds their values back to parent events.
+ */
+static void perf_event_remove_on_exec(void)
+{
+	struct perf_event *event, *next;
+	int ctxn;
+
+	/*****************  BROKEN BROKEN BROKEN *****************/
+
+	for_each_task_context_nr(ctxn) {
+		struct perf_event_context *ctx;
+		bool removed = false;
+
+		ctx = perf_pin_task_context(current, ctxn);
+		if (!ctx)
+			continue;
+		mutex_lock(&ctx->mutex);
+
+		raw_spin_lock_irq(&ctx->lock);
+		/*
+		 * WIP: Ok, we will unschedule the context, _and_ tell everyone
+		 * still trying to use that it's dead... even though it isn't.
+		 *
+		 * This can't be right...
+		 */
+		task_ctx_sched_out(__get_cpu_context(ctx), ctx, EVENT_ALL);
+		RCU_INIT_POINTER(current->perf_event_ctxp[ctxn], NULL);
+		WRITE_ONCE(ctx->task, TASK_TOMBSTONE);

This code here is obviously bogus, because it removes the context from
the task: we might still need it since this task is not dead yet.

What's the right way to pause the context to remove the events from it?

+		raw_spin_unlock_irq(&ctx->lock);
+
+		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+			if (!event->attr.remove_on_exec)
+				continue;
+			removed = true;
+
+			if (!is_kernel_event(event))
+				perf_remove_from_owner(event);
+
+			/*
+			 * WIP: Want to free the event and feed back its values
+			 * to the parent (if any) ...
+			 */
+			perf_event_exit_event(event, ctx, current);
+		}
+

... need to schedule context back in here?

+
+		mutex_unlock(&ctx->mutex);
+		perf_unpin_context(ctx);
+		put_ctx(ctx);
+	}
+}
+
 struct perf_read_data {
 	struct perf_event *event;
 	bool group;
@@ -7553,6 +7635,8 @@ void perf_event_exec(void)
 				   true);
 	}
 	rcu_read_unlock();
+
+	perf_event_remove_on_exec();
 }
 

Thanks,
-- Marco
