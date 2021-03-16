Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B5133D9CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbhCPQs4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 12:48:56 -0400
Received: from casper.infradead.org ([90.155.50.34]:45110 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhCPQsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:48:30 -0400
X-Greylist: delayed 1498 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 12:48:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DBugU3Nv275YIe120uunlkMX1JrxtNo2cLcdJHIRRa8=; b=e7JSqiKnj0Fjy8O1VZdkU8gkCi
        Zw/Iz1lwQluCLAZfBohkABD1rVdE2kVrfyvK1+4832d+TiXQMXv/lr7Q5hW4755SvvtnLeWhwu/UK
        ZLr0wF8JD9oYUbfAhf4kWlWlhwV0UfhWLnOkYY5alFkWFpWXjzqrIlkryBF+tHF+Xbocxlzvp5OEx
        qVMZb45DGlaHOVFiOyZAAFZXnfYz9YoFyJeR+nL720n8wmeHS9s48kvIZH9appNazEolBO9gjntaA
        9nVKg7HW8n3e91niZlUAdzdIYj1JS80VkyAn9Y/6ffS+By5FZmWfr1feL+o9Uf5BGX7F9MVIW1Afk
        dmXojOVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMCSf-000J72-0j; Tue, 16 Mar 2021 16:22:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81C26305C22;
        Tue, 16 Mar 2021 17:22:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52EDE20B05D7C; Tue, 16 Mar 2021 17:22:23 +0100 (CET)
Date:   Tue, 16 Mar 2021 17:22:23 +0100
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
Subject: Re: [PATCH RFC v2 3/8] perf/core: Add support for event removal on
 exec
Message-ID: <YFDbP3obvxn0SL4w@hirez.programming.kicks-ass.net>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310104139.679618-4-elver@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:41:34AM +0100, Marco Elver wrote:
> Adds bit perf_event_attr::remove_on_exec, to support removing an event
> from a task on exec.
> 
> This option supports the case where an event is supposed to be
> process-wide only, and should not propagate beyond exec, to limit
> monitoring to the original process image only.
> 
> Signed-off-by: Marco Elver <elver@google.com>

> +/*
> + * Removes all events from the current task that have been marked
> + * remove-on-exec, and feeds their values back to parent events.
> + */
> +static void perf_event_remove_on_exec(void)
> +{
> +	int ctxn;
> +
> +	for_each_task_context_nr(ctxn) {
> +		struct perf_event_context *ctx;
> +		struct perf_event *event, *next;
> +
> +		ctx = perf_pin_task_context(current, ctxn);
> +		if (!ctx)
> +			continue;
> +		mutex_lock(&ctx->mutex);
> +
> +		list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
> +			if (!event->attr.remove_on_exec)
> +				continue;
> +
> +			if (!is_kernel_event(event))
> +				perf_remove_from_owner(event);
> +			perf_remove_from_context(event, DETACH_GROUP);

There's a comment on this in perf_event_exit_event(), if this task
happens to have the original event, then DETACH_GROUP will destroy the
grouping.

I think this wants to be:

			perf_remove_from_text(event,
					      child_event->parent ?  DETACH_GROUP : 0);

or something.

> +			/*
> +			 * Remove the event and feed back its values to the
> +			 * parent event.
> +			 */
> +			perf_event_exit_event(event, ctx, current);

Oooh, and here we call it... but it will do list_del_even() /
perf_group_detach() *again*.

So the problem is that perf_event_exit_task_context() doesn't use
remove_from_context(), but instead does task_ctx_sched_out() and then
relies on the events not being active.

Whereas above you *DO* use remote_from_context(), but then
perf_event_exit_event() will try and remove it more.

> +		}
> +		mutex_unlock(&ctx->mutex);

		perf_unpin_context(ctx);

> +		put_ctx(ctx);
> +	}
> +}
