Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0D14AD89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 02:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA1B2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 20:28:43 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:47495 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbgA1B2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:28:42 -0500
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jan 2020 20:28:39 EST
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 87343B8814
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 01:19:37 +0000 (GMT)
Received: (qmail 27547 invoked from network); 28 Jan 2020 01:19:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2020 01:19:37 -0000
Date:   Tue, 28 Jan 2020 01:19:36 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200128011936.GY3466@techsingularity.net>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200127223256.GA18610@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 09:32:56AM +1100, Dave Chinner wrote:
> On Mon, Jan 27, 2020 at 02:36:08PM +0000, Mel Gorman wrote:
> > Commit 8ab39f11d974 ("xfs: prevent CIL push holdoff in log
> > recovery") changed from using bound workqueues to using unbound
> > workqueues. Functionally this makes sense but it was observed at the time
> > that the dbench performance dropped quite a lot and CPU migrations were
> > excessively high even when there are plenty of idle CPUs.
> 
> Hmmm - that just made the CIL workqueue WQ_UNBOUND. Not a complex
> change...
> 

Not in itself but it has an effect on the wakeup path hitting
select_idle_sibling and migrating a user task because the previously used
CPU is not idle. Performance problems with select_idle_sibling has been
known to cause poor anger management issues.

> > The pattern of the task migration is straight-forward. With XFS, an IO
> > issuer may delegate work to a kworker which wakes on the same CPU. On
> > completion of the work, it wakes the task, finds that the previous CPU
> > is busy (because the kworker is still running on it) and migrates the
> > task to the next idle CPU. The task ends up migrating around all CPUs
> > sharing a LLC at high frequency. This has negative implications both in
> > commication costs and power management.  mpstat confirmed that at low
> > thread counts that all CPUs sharing an LLC has low level of activity.
> 
> Very interesting, Mel. :)
> 
> I suspect this appears is a very similar issue that is discussed in
> this thread about workqueues and AIO completion latencies:
> 
> https://lore.kernel.org/lkml/20191114113153.GB4213@ming.t460p/
> 
> The problem is described here, along with comments about how
> fundamental this behaviour is to the correct functioning of
> filesystems:
> 
> https://lore.kernel.org/lkml/20191121221051.GG4614@dread.disaster.area/
> 

I suspect the problem is very similar, maybe even identical and just
observed from different directions. I agree with your assessment of the
issues and observations although I cannot swear every aspect is correct.
However, IO completions being sent to the issuer CPU makes sense,
particularly for synchronous IO where the issuer has gone to sleep. The
data may be still hot in L1 cache and the CPU is probably ramped up to a
higher frequency. There is no obvious reason why blk-mq should deliver
the completion to a different CPU just to sidestep undesired scheduler
behaviour.

It's less clear cut for jbd as stacking multiple IO issuers on top of jbd
is unlikely to perform very well. However, jbd appears to be unaffected
by this patch.

> There are several patches thrown about during the discussion,
> initially focussed on wakeup pre-emption to run the work immediately
> until I pointed out that was the wrong thing to do for work being
> deferred to workqueues.  After a some more proposed patches the
> discussion on the scheduler side of things largely ground to a halt
> and so has not been fixed.
> 

I do not think it's a good idea to preempt the issuing task when it is
asynchronous. Aside from any filesystem considerations, it artifically
increases context switches.

> So I'm initially wondering if this solves that problem, too, or
> whether you are seeing a slightly different manifestation of that
> same scheduler issue....
> 

I suspect my patch may accidentally fix or at least mitigate the issue.

> > The impact of this problem is related to the number of CPUs sharing an LLC.
> > 
> > This patch special cases the pattern and allows a kworker waker and a
> > task wakee to stack on the same CPU if there is a strong chance they are
> > directly related. The expectation is that the kworker is likely going
> > back to sleep shortly. This is not guaranteed as the IO could be queued
> > asynchronously but there is a very strong relationship between the task and
> > kworker in this case that would justify stacking on the same CPU instead
> > of migrating. There should be few concerns about kworker starvation given
> > that the special casing is only when the kworker is the waker.
> > DBench on XFS
> 
> [snip positive dbench results]
> 
> Yeah, dbench does lots of synchronous operations that end up waiting
> on journal flushes (data integrity operations) so it would trip over
> kworker scheduling latency issues.
> 

Yes, it turned out to be a good workload.

> FWIW, I didn't see any perf degradation on my machines from the
> commit you quoted, but I also had a real hard time replication the
> aio completion latency problem on them as well. Hence I don't think
> they are particularly susceptible to bad migration decisions, so I'm
> not surprised I didn't see this.
> 

FWIW, of 12 machines that checked commits around that time frame, only 2
machines bisected reliably to the XFS commit. About all that was special
about those machines it the number of CPUs sharing LLC. The disks were
SSDs but not particularly fast ones.

> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fe4e0d775375..76df439aff76 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5912,6 +5912,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
> >  		return prev;
> >  
> > +	/*
> > +	 * Allow a per-cpu kthread to stack with the wakee if the
> > +	 * kworker thread and the tasks previous CPU are the same.
> > +	 * The assumption is that the wakee queued work for the
> > +	 * per-cpu kthread that is now complete and the wakeup is
> > +	 * essentially a sync wakeup.
> > +	 */
> > +	if (is_per_cpu_kthread(current) &&
> > +	    prev == smp_processor_id() &&
> > +	    this_rq()->nr_running <= 1) {
> > +		return prev;
> > +	}
> 
> Ok, so if I've read this correctly, this special case only triggers
> when scheduling from the per-cpu kworker thread context, and only if
> there is one other runnable task on the queue?

Not quite, the 1 running task is the kworker itself.

> So it special cases
> the ping-pong case so that the non-bound task that scheduled the
> kworker also remains scheduled this CPU?
> 

Yes. Ordinarily, allowing premature task stacking in select_idle_sibling
when siblings are idle would be shot straight in the head. Stacking tasks
suits benchmarks that are strictly synchronised like pipes but almost
always a disaster in any other case. I think this patch is constrained
enough that it should fix the targetted problem without side-effects.

> Hmmmm.
> 
> When we set up a workqueue as WQ_UNBOUND on a numa system, isn't the
> worker pool set up as a node-bound task? i.e. it's not a per-cpu
> kthread anymore, but a task limited by the cpumask of that node?
> That isn't a per-CPU kthread anymore, is it? That is:
> 

I would have thought so but I didn't drill deep enough into the kworker
behaviour to see what exactly was causing the problem. 

> > @@ -2479,3 +2479,16 @@ static inline void membarrier_switch_mm(struct rq *rq,
> >  {
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_SMP
> > +static inline bool is_per_cpu_kthread(struct task_struct *p)
> > +{
> > +	if (!(p->flags & PF_KTHREAD))
> > +		return false;
> > +
> > +	if (p->nr_cpus_allowed != 1)
> > +		return false;
> 
> p->nr_cpus_allowed is no longer 1 but the number of CPUs in the
> per-node cpu mask it is allowed to run on?
> 

If that was the case, the patch would have had no effect so there is a
mix of unbound and bound workqueues that I failed to fully understand.
The patch was based on scheduler traces instead of a deep understanding
of workqueue internals or how filesystems use them :(

> And so if that is the case, then the change in commit 8ab39f11d974
> which set WQ_UNBOUND on the XFS CIL workqueue would mean the above
> logic change should not be triggering for the CIL worker because it
> is no longer a CPU bound kthread....
> 
> What am I missing here?
> 

I'm almost 100% certain the patch revealed some unintended behaviour and
the bisection did appear reliable. This is a report excerpt I got from
automation testing (similar functionality to LKP) commits around that time

Comparison
==========
                             initial                initial                   last                  penup                   last                  penup                  first
                           good-v5.3       bad-1c4e395cf7de           bad-b41dae06           bad-c6cfaf4f          good-cdea5459          good-7c107afb           bad-8ab39f11
....
Amean     1         47.34 (   0.00%)       54.80 * -15.75%*       56.02 * -18.35%*       56.05 * -18.40%*       48.05 *  -1.50%*       46.36 *   2.07%*       55.56 * -17.38%*
Amean     2         50.10 (   0.00%)       58.35 * -16.45%*       62.44 * -24.62%*       62.39 * -24.52%*       51.68 *  -3.15%*       50.28 *  -0.36%*       61.44 * -22.63%*
Amean     4         58.07 (   0.00%)       66.65 * -14.79%*       67.53 * -16.29%*       66.70 * -14.86%*       58.40 *  -0.57%*       58.49 *  -0.74%*       65.63 * -13.03%*
Amean     8         74.86 (   0.00%)       78.36 *  -4.68%*       79.84 *  -6.65%*       80.21 *  -7.15%*       75.82 *  -1.28%*       74.68 *   0.25%*       79.38 *  -6.03%*
Amean     16       108.57 (   0.00%)      108.86 *  -0.26%*      109.65 *  -1.00%*      109.52 *  -0.88%*      108.91 *  -0.32%*      107.99 *   0.53%*      109.81 *  -1.14%*
Amean     32       199.20 (   0.00%)      198.80 (   0.20%)      199.62 (  -0.21%)      200.11 *  -0.46%*      201.98 *  -1.40%*      202.33 *  -1.57%*      199.70 (  -0.25%)
Amean     64       424.43 (   0.00%)      421.39 *   0.72%*      419.08 *   1.26%*      422.68 *   0.41%*      427.88 *  -0.81%*      422.82 *   0.38%*      427.16 *  -0.64%*
Amean     128     1011.56 (   0.00%)      994.98 *   1.64%*      997.81 *   1.36%*      999.07 *   1.24%*     1003.33 *   0.81%*     1003.38 *   0.81%*      985.47 *   2.58%*

The difference between good-cdea5459 and bad-8ab39f11 is pretty clear.


> <light bulb illumination>
> 
> Is this actually ping-ponging the CIL flush and journal IO
> completion because xlog_bio_end_io() always punts journal IO
> completion to the log workqueue, which is:
> 
> 	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
> 			WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_HIGHPRI, 0,
> 			mp->m_super->s_id);
> 
> i.e. it uses per-cpu kthreads for processing journal IO completion
> similar to DIO io completion and thereby provides a vector for
> the same issue?
> 
> <SNIP>

That is extremely informative, thanks!  Your reasoning sounds plausible
but unfortunately from the scheduler trace, I knew kworkers were involved
but not exactly what those kworkers were doing.  The pattern also did
not always cause major problems. Sometimes select_idle_sibling would
use p->recent_used_cpu instead of moving the task round-robin around the
LLC. It's the reason why I placed the check for per-cpu kthreads *before*
considering recent_used_cpu as an idle CPU. It was the difference between
reducing migration rates by 85% to almost 100%.

> IOWs, I think we now have exactly the same situation as discussed in
> the thread I pointed you to above, where an unbound task work (the
> CIL kworker) is trying to run on the same CPU as the CPU bound IO
> completion kworker, and that causes the CIL kworker to be migrated
> to a different CPU on each bounced throught the "wait for iclog
> space" loop. Hence your new logic is actually triggering on the
> journal IO completion kworker threads, not the CIL kworker threads.
> 

I added Paul Auld and Ming Lei to the cc. Maybe they'd be willing to
give the patch a spin on their test case. I could recreate their test
case easily enough but an independent test would be preferred.

> After all this, I have two questions that would help me understand
> if this is what you are seeing:
> 
> 1. to confirm: does removing just the WQ_UNBOUND from the CIL push
> workqueue (as added in 8ab39f11d974) make the regression go away?
> 

I'll have to check in the morning. Around the v5.4 development timeframe,
I'm definite that reverting the patch helped but that was not an option
given that it's fixing a correctness issue.

> 2. when the problem shows up, which tasks are actually being
> migrated excessively - is it the user task, the CIL kworker task
> or something else?
> 

The user task is doing the migration in my case. However, that may not
be universally true. The patch also does not prevent all migrations. For
low numbers of dbench clients, there are almost no migrations but as the
client count increases migrations happen because there are too many
running tasks.

-- 
Mel Gorman
SUSE Labs
