Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC13E347ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 15:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhCXOgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236139AbhCXOga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:36:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119EAC061763;
        Wed, 24 Mar 2021 07:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gZNDVx2/PlbsIgQ9b2b5kJPlJKUPEQS2/HXJQTw43w4=; b=k3/gF41UIwj1Pdt2mjIaGfHC5U
        coWuLaceQXKwR1Ko7RAtOy4xlyIXbxBRo4NgLh92ENxXW93dwqBSE6N2Svtedapqpuy+wsf0bdBE1
        J2frHCckHbfJHmAGN49DtjD98oKjUMOov+CRq6KSmv9a/4K0bKEvxGMuDBy1kkz/Rr5VsZ/AXAnXo
        ok++/B3yzrxaSg0JIxD2aHLt6uo6LGvq5YqXGdg1e09a4M6UEzABlQ8eAPuHqvYbxk0YLz7fNqrA5
        ZNsDQDomwsrnfpUxLWDLS5PK1K/jvJ0N5EgRyNkkP5Uzgo1V64zqrrlVhy0UtsXZziAaw9dCabZt9
        99Y0wJMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP4cJ-00HDi6-Gc; Wed, 24 Mar 2021 14:36:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E615306099;
        Wed, 24 Mar 2021 15:36:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65EF720693989; Wed, 24 Mar 2021 15:36:14 +0100 (CET)
Date:   Wed, 24 Mar 2021 15:36:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <YFtOXpl1vWp47Qud@hirez.programming.kicks-ass.net>
References: <20210323035706.572953-1-joshdon@google.com>
 <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
 <YFsaYBO/UqMHSpGS@hirez.programming.kicks-ass.net>
 <20210324114224.GP15768@suse.de>
 <YFssoD5NDl6dFfg/@hirez.programming.kicks-ass.net>
 <20210324133916.GQ15768@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324133916.GQ15768@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 01:39:16PM +0000, Mel Gorman wrote:

> > Yeah, lets say I was pleasantly surprised to find it there :-)
> > 
> 
> Minimally, lets move that out before it gets kicked out. Patch below.

OK, stuck that in front.

> > > Moving something like sched_min_granularity_ns will break a number of
> > > tuning guides as well as the "tuned" tool which ships by default with
> > > some distros and I believe some of the default profiles used for tuned
> > > tweak kernel.sched_min_granularity_ns
> > 
> > Yeah, can't say I care. I suppose some people with PREEMPT=n kernels
> > increase that to make their server workloads 'go fast'. But I'll
> > absolutely suck rock on anything desktop.
> > 
> 
> Broadly speaking yes and despite the lack of documentation, enough people
> think of that parameter when tuning for throughput vs latency depending on
> the expected use of the machine.  kernel.sched_wakeup_granularity_ns might
> get tuned if preemption is causing overscheduling. Same potentially with
> kernel.sched_min_granularity_ns and kernel.sched_latency_ns. That said, I'm
> struggling to think of an instance where I've seen tuning recommendations
> properly quantified other than the impact on microbenchmarks but I
> think there will be complaining if they disappear. I suspect that some
> recommended tuning is based on "I tried a number of different values and
> this seemed to work reasonably well".

Right, except that due to that scaling thing, you'd have to re-evaluate
when you change machine.

Also, do you have any inclination on the perf difference we're talking
about? (I should probably ask Google and not you...)

> kernel.sched_schedstats probably should not depend in SCHED_DEBUG because
> it has value for workload analysis which is not necessarily about debugging
> per-se. It might simply be informing whether another variable should be
> tuned or useful for debugging applications rather than the kernel.

Dubious, if you're that far down the rabit hole, you're dang near
debugging.

> As an aside, I wonder how often SCHED_DEBUG has been enabled simply
> because LATENCYTOP selects it -- no idea offhand why LATENCYTOP even
> needs SCHED_DEBUG.

Perhaps schedstats used to rely on debug? I can't remember. I don't
think I've used latencytop in at least 10 years. ftrace and perf sorta
killed the need for it.

> > These knobs really shouldn't have been as widely available as they are.
> > 
> 
> Probably not. Worse, some of the tuning is probably based on "this worked
> for workload X 10 years ago so I'll just keep doing that"

That sounds like an excellent reason to disrupt ;-)

> > And guides, well, the writes have to earn a living too, right.
> > 
> 
> For most of the guides I've seen they either specify values without
> explaining why or just describe roughly what the parameter does and it's
> not always that accurate a description.

Another good reason.

> > > Whether there are legimiate reasons to modify those values or not,
> > > removing them may generate fun bug reports.
> > 
> > Which I'll close with -EDONTCARE, userspace has to cope with
> > SCHED_DEBUG=n in any case.
> 
> True but removing the throughput vs latency parameters is likely to
> generate a lot of noise even if the reasons for tuning are bad ones.
> Some definitely should not be depending on SCHED_DEBUG, others may
> need to be moved to debugfs one patch at a time so they can be reverted
> individually if complaining is excessive and there is a legiminate reason
> why it should be tuned. It's possible that complaining will be based on
> a workload regression that really depended on tuned changing parameters.

The way I've done it, you can simply re-instate the systl table entry
and it'll work again, except for the entries that had a custom handler.

I'm ready to disrupt :-)
