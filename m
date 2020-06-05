Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FEF1EF670
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgFELcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 07:32:11 -0400
Received: from foss.arm.com ([217.140.110.172]:53908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgFELcL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:32:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3A52B;
        Fri,  5 Jun 2020 04:32:09 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428383F52E;
        Fri,  5 Jun 2020 04:32:07 -0700 (PDT)
Date:   Fri, 5 Jun 2020 12:32:04 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200605113204.srskjrunz2ezkcuj@e107158-lin.cambridge.arm.com>
References: <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de>
 <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
 <875zc60ww2.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875zc60ww2.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/05/20 09:55, Patrick Bellasi wrote:
> 
> Hi Qais,
> 
> On Wed, Jun 03, 2020 at 18:52:00 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> > On 06/03/20 16:59, Vincent Guittot wrote:
> >> When I want to stress the fast path i usually use "perf bench sched pipe -T "
> >> The tip/sched/core on my arm octo core gives the following results for
> >> 20 iterations of perf bench sched pipe -T -l 50000
> >> 
> >> all uclamp config disabled  50035.4(+/- 0.334%)
> >> all uclamp config enabled  48749.8(+/- 0.339%)   -2.64%
> 
> I use to run the same test but I don't remember such big numbers :/

Yeah I remember you ran a lot of testing on this.

> 
> >> It's quite easy to reproduce and probably easier to study the impact
> >
> > Thanks Vincent. This is very useful!
> >
> > I could reproduce that on my Juno.
> >
> > One of the codepath I was suspecting seems to affect it.
> >
> >
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0464569f26a7..9f48090eb926 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1063,10 +1063,12 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >          * e.g. due to future modification, warn and fixup the expected value.
> >          */
> >         SCHED_WARN_ON(bucket->value > rq_clamp);
> > +#if 0
> >         if (bucket->value >= rq_clamp) {
> >                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
> >                 WRITE_ONCE(uc_rq->value, bkt_clamp);
> >         }
> > +#endif
> 
> Yep, that's likely where we have most of the overhead at dequeue time,
> sine _sometimes_ we need to update the cpu's clamp value.
> 
> However, while running perf sched pipe, I expect:
>  - all tasks to have the same clamp value
>  - all CPUs to have _always_ at least one RUNNABLE task
> 
> Given these two conditions above, if the CPU is never "CFS idle" (i.e.
> without RUNNABLE CFS tasks), the code above should never be triggered.
> More on that later...

So the cost is only incurred by idle cpus is what you're saying.

> 
> >  }
> >
> >  static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> >
> >
> >
> > uclamp_rq_max_value() could be expensive as it loops over all buckets.
> 
> It loops over UCLAMP_CNT values which are defined to fit into a single

I think you meant to say UCLAMP_BUCKETS which is defined 5 by default.

> $L. That was the optimal space/time complexity compromise we found to
> get the MAX of a set of values.

It actually covers two cachelines, see below and my other email to Mel.

> 
> > Commenting this whole path out strangely doesn't just 'fix' it,
> > but produces  better results to no-uclamp kernel :-/
> >
> > # ./perf bench -r 20 sched pipe -T -l 50000
> > Without uclamp:		5039
> > With uclamp:		4832
> > With uclamp+patch:	5729
> 
> I explain it below: with that code removed you never decrease the CPU's
> uclamp value. Thus, the first time you schedule an RT task you go to MAX
> OPP and stay there forever.

Okay.

> 
> > It might be because schedutil gets biased differently by uclamp..? If I move to
> > performance governor these numbers almost double.
> >
> > I don't know. But this promoted me to look closer and
> 
> Just to resume, when a task is dequeued we can have only these cases:
> 
> - uclamp(task) < uclamp(cpu):
>   this happens when the task was co-scheduled with other tasks with
>   higher clamp values which are still RUNNABLE.
>   In this case there are no uclamp(cpu) updates.
> 
> - uclamp(task) == uclamp(cpu):
>   this happens when the task was one of the tasks defining the current
>   uclamp(cpu) value, which is defined to track the MAX of the RUNNABLE
>   tasks clamp values.
> 
> In this last case we _not_ always need to do a uclamp(cpu) update.
> Indeed the update is required _only_ when that task was _the last_ task
> defining the current uclamp(cpu) value.
> 
> In this case we use uclamp_rq_max_value() to do a linear scan of
> UCLAMP_CNT values which fits into a single cache line.

Again, I think you mean UCLAMP_BUCKETS here. Unless I missed something, they
span 2 cahcelines on 64bit machines and 64b cacheline size.

To be specific, I am referring to struct uclamp_rq, which defines an array of
size UCLAMP_BUCKETS of type struct uclamp_bucket.

uclamp_rq_max_value() scans the buckets for a given clamp_id (UCLAMP_MIN or
UCLAMP_MAX).

So sizeof(struct uclamp_rq) = 8 * 5 + 4 = 44; on 64bit machines.

And actually the compiler introduces a 4 bytes hole, so we end up with a total
of 48 bytes.

In struct rq, we define struct uclamp_rq as an array of UCLAMP_CNT which is 2.

So by default we have 2 * sizeof(struct uclamp_rq) = 96 bytes.

> 
> > I think I spotted a bug where in the if condition we check for '>='
> > instead of '>', causing us to take the supposedly impossible fail safe
> > path.
> 
> The fail safe path is when the '>' condition matches, which is what the
> SCHED_WARN_ON tell us. Indeed, we never expect uclamp(cpu) to be bigger
> than one of its RUNNABLE tasks. If that should happen we WARN and fix
> the cpu clamp value for the best.
> 
> The normal path is instead '=' and, according to by previous resume,
> it's expected to be executed _only_ when we dequeue the last task of the
> clamp group defining the current uclamp(cpu) value.

Okay. I was mislead by the comment then. Thanks for clarifying.

Can this function be broken down to deal with '=' separately from the '>' case?

IIUC, for the common '=', we always want to return uclamp_idle_value() hence
skip the potentially expensive scan?

Anyway, based on Vincent results, it doesn't seem this path is an issue for him
and the real problem is lurking somewhere else.

> 
> > Mind trying with the below patch please?
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0464569f26a7..50d66d4016ff 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1063,7 +1063,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >          * e.g. due to future modification, warn and fixup the expected value.
> >          */
> >         SCHED_WARN_ON(bucket->value > rq_clamp);
> > -       if (bucket->value >= rq_clamp) {
> > +       if (bucket->value > rq_clamp) {
> >                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
> >                 WRITE_ONCE(uc_rq->value, bkt_clamp);
> >         }
> 
> This patch is thus bogus, since we never expect to have uclamp(cpu)
> bigger than uclamp(task) and thus we will never reset the clamp value of
> a cpu.

Yeah I got confused by SCHED_WARN_ON() and the comment. Thanks for clarifying.

Cheers

--
Qais Yousef
