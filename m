Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0334CFBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 14:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhC2MIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhC2MIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:08:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82BAC061574;
        Mon, 29 Mar 2021 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Njn/KvV5Snuv3RW7HAFUHdZEr2iaxCFGr7M1vBWlqyE=; b=HItK73o0bQo72HLTdxmUfNE+Tx
        5RC7H0/B82q23CUYsvFs3+5H8CYap7vGcfq0YcTFFhKd5km8DdGvhmT4fnKoYz9ZE3vucoJ+2e5Rj
        mZG4oju+VZl5ri5ckYwXVae1tbFoFCSmsPqAvAJW48MZmiws+JLzDkUENY9Z45KTju7JPqvLLaChv
        pRyQfWKopxnNivlzrjrXRhnUXf43yDuNsAoPHohWhLRzhmg19LtEKMgjX25v9t2cgNfwDMtidlkw0
        xR56RxWS6dOWGRZolAj79Ss/uzt26prrNSUD+nrBUUQJq6ffU99UownAzF74gEXF3/xIqrE09E6Qv
        jeMw0Dxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQqfm-001WyJ-TV; Mon, 29 Mar 2021 12:07:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5B5B304B90;
        Mon, 29 Mar 2021 14:07:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D5F52071A3CB; Mon, 29 Mar 2021 14:07:09 +0200 (CEST)
Date:   Mon, 29 Mar 2021 14:07:09 +0200
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
        x86@kernel.org, linux-kselftest@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
Message-ID: <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFxGb+QHEumZB6G8@elver.google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:14:39AM +0100, Marco Elver wrote:
> On Wed, Mar 24, 2021 at 12:24PM +0100, Marco Elver wrote:
> [...]
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b6434697c516..1e4c949bf75f 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6391,6 +6391,17 @@ void perf_event_wakeup(struct perf_event *event)
> >  	}
> >  }
> >  
> > +static void perf_sigtrap(struct perf_event *event)
> > +{
> > +	struct kernel_siginfo info;
> > +
> 
> I think we need to add something like this here:
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4b82788fbaab..4fcd6b45ce66 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6395,6 +6395,13 @@ static void perf_sigtrap(struct perf_event *event)
>  {
>  	struct kernel_siginfo info;
>  
> +	/*
> +	 * This irq_work can race with an exiting task; bail out if sighand has
> +	 * already been released in release_task().
> +	 */
> +	if (!current->sighand)
> +		return;
> +
>  	clear_siginfo(&info);
>  	info.si_signo = SIGTRAP;
>  	info.si_code = TRAP_PERF;
> 
> 

Urgh.. I'm not entirely sure that check is correct, but I always forget
the rules with signal. It could be we ought to be testing PF_EXISTING
instead.

But also, I think Jiri Olsa was going to poke around here because all of
this is broken on PREEMPT_RT. IIRC the plan was to add yet another stage
to the construct. So where today we have:


	<NMI>
		irq_work_queue()
	</NMI>
	...
	<IRQ>
		perf_pending_event()
	</IRQ>

(and we might already have a problem on some architectures where there
can be significant time between these due to not having
arch_irq_work_raise(), so ideally we ought to double check current in
your case)

The idea was, I think to add a task_work(), such that we get:

	<NMI>
		irq_work_queue()
	</NMI>
	...
	<IRQ>
		perf_pending_event()
		  task_work_add()
	</IRQ>

	<ret-to-user>
		run_task_work()
		  ...
		    kill_fasync();


