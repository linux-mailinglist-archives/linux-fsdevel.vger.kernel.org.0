Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA7345BF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 11:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCWKch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhCWKcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:32:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DCC061574;
        Tue, 23 Mar 2021 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hZmnbYtc3QdpsYLPmr+JQv0YQpsjHqDjO5iTGYtgkq8=; b=j/5Ci76GdqJDeQkphj8BYYIVw2
        Aip6U+K1w+pwefRhpqTgjBEjmiGS5klPAE22gouksgjZuwdOUACnaO8H3D0Vwnf6qq3Y5uMpBbqeW
        DbrFYw6hUTVUM/GtTu4P/INzbQS0QBXQ/nmaRMJQA4He4gmStP8tL3Vflf5UtmQWVFMMzYzQlPFVn
        Ewijv0uNmXAz3vV5pAhkJz4pxZvmy5asZaRsqhC8vwa0nLfaI++bujIxvN0HzQHoNUL73+GDuQ9kX
        HffJ69vXaHcSjbJVGkJoaA39vbiVOyUYej85jGh2sEPMUeA3wkhkZgKvRJvgjzUSR7whU2UFagzCo
        Vgwm6cAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOeKS-00EcdZ-Od; Tue, 23 Mar 2021 10:32:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D0FE30257C;
        Tue, 23 Mar 2021 11:32:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1189723601885; Tue, 23 Mar 2021 11:32:03 +0100 (CET)
Date:   Tue, 23 Mar 2021 11:32:03 +0100
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
Message-ID: <YFnDo7dczjDzLP68@hirez.programming.kicks-ass.net>
References: <20210310104139.679618-1-elver@google.com>
 <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com>
 <YFjI5qU0z3Q7J/jF@hirez.programming.kicks-ass.net>
 <YFm6aakSRlF2nWtu@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFm6aakSRlF2nWtu@elver.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 23, 2021 at 10:52:41AM +0100, Marco Elver wrote:

> with efs->func==__perf_event_enable. I believe it's sufficient to add
> 
> 	mutex_lock(&parent_event->child_mutex);
> 	list_del_init(&event->child_list);
> 	mutex_unlock(&parent_event->child_mutex);
> 
> right before removing from context. With the version I have now (below
> for completeness), extended torture with the above test results in no
> more warnings and the test also passes.
> 

> +	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
> +		struct perf_event *parent_event = event->parent;
> +
> +		if (!event->attr.remove_on_exec)
>  			continue;
>  
> +		if (!is_kernel_event(event))
> +			perf_remove_from_owner(event);
>  
> +		modified = true;
> +
> +		if (parent_event) {
>  			/*
> +			 * Remove event from parent, to avoid race where the
> +			 * parent concurrently iterates through its children to
> +			 * enable, disable, or otherwise modify an event.
>  			 */
> +			mutex_lock(&parent_event->child_mutex);
> +			list_del_init(&event->child_list);
> +			mutex_unlock(&parent_event->child_mutex);
>  		}

		^^^ this, right?

But that's something perf_event_exit_event() alread does. So then you're
worried about the order of things.

> +
> +		perf_remove_from_context(event, !!event->parent * DETACH_GROUP);
> +		perf_event_exit_event(event, ctx, current, true);
>  	}

perf_event_release_kernel() first does perf_remove_from_context() and
then clears the child_list, and that makes sense because if we're there,
there's no external access anymore, the filedesc is gone and nobody will
be iterating child_list anymore.

perf_event_exit_task_context() and perf_event_exit_event() OTOH seem to
rely on ctx->task == TOMBSTONE to sabotage event_function_call() such
that if anybody is iterating the child_list, it'll NOP out.

But here we don't have neither, and thus need to worry about the order
vs child_list iteration.

I suppose we should stick sync_child_event() in there as well.

And at that point there's very little value in still using
perf_event_exit_event()... let me see if there's something to be done
about that.
