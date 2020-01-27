Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714C614AC13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0WdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 17:33:04 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:42698 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbgA0WdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 17:33:04 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id E64C13A18D0;
        Tue, 28 Jan 2020 09:32:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwCwC-000595-Pp; Tue, 28 Jan 2020 09:32:56 +1100
Date:   Tue, 28 Jan 2020 09:32:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200127223256.GA18610@dread.disaster.area>
References: <20200127143608.GX3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127143608.GX3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=0d4712DzcxtLHTL675QA:9
        a=7Xq_qdO54CbiHfrq:21 a=_PJthSLu79-rBWCo:21 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 02:36:08PM +0000, Mel Gorman wrote:
> Commit 8ab39f11d974 ("xfs: prevent CIL push holdoff in log
> recovery") changed from using bound workqueues to using unbound
> workqueues. Functionally this makes sense but it was observed at the time
> that the dbench performance dropped quite a lot and CPU migrations were
> excessively high even when there are plenty of idle CPUs.

Hmmm - that just made the CIL workqueue WQ_UNBOUND. Not a complex
change...

> The pattern of the task migration is straight-forward. With XFS, an IO
> issuer may delegate work to a kworker which wakes on the same CPU. On
> completion of the work, it wakes the task, finds that the previous CPU
> is busy (because the kworker is still running on it) and migrates the
> task to the next idle CPU. The task ends up migrating around all CPUs
> sharing a LLC at high frequency. This has negative implications both in
> commication costs and power management.  mpstat confirmed that at low
> thread counts that all CPUs sharing an LLC has low level of activity.

Very interesting, Mel. :)

I suspect this appears is a very similar issue that is discussed in
this thread about workqueues and AIO completion latencies:

https://lore.kernel.org/lkml/20191114113153.GB4213@ming.t460p/

The problem is described here, along with comments about how
fundamental this behaviour is to the correct functioning of
filesystems:

https://lore.kernel.org/lkml/20191121221051.GG4614@dread.disaster.area/

There are several patches thrown about during the discussion,
initially focussed on wakeup pre-emption to run the work immediately
until I pointed out that was the wrong thing to do for work being
deferred to workqueues.  After a some more proposed patches the
discussion on the scheduler side of things largely ground to a halt
and so has not been fixed.

So I'm initially wondering if this solves that problem, too, or
whether you are seeing a slightly different manifestation of that
same scheduler issue....

> The impact of this problem is related to the number of CPUs sharing an LLC.
> 
> This patch special cases the pattern and allows a kworker waker and a
> task wakee to stack on the same CPU if there is a strong chance they are
> directly related. The expectation is that the kworker is likely going
> back to sleep shortly. This is not guaranteed as the IO could be queued
> asynchronously but there is a very strong relationship between the task and
> kworker in this case that would justify stacking on the same CPU instead
> of migrating. There should be few concerns about kworker starvation given
> that the special casing is only when the kworker is the waker.
> DBench on XFS

[snip positive dbench results]

Yeah, dbench does lots of synchronous operations that end up waiting
on journal flushes (data integrity operations) so it would trip over
kworker scheduling latency issues.

FWIW, I didn't see any perf degradation on my machines from the
commit you quoted, but I also had a real hard time replication the
aio completion latency problem on them as well. Hence I don't think
they are particularly susceptible to bad migration decisions, so I'm
not surprised I didn't see this.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe4e0d775375..76df439aff76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5912,6 +5912,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
>  		return prev;
>  
> +	/*
> +	 * Allow a per-cpu kthread to stack with the wakee if the
> +	 * kworker thread and the tasks previous CPU are the same.
> +	 * The assumption is that the wakee queued work for the
> +	 * per-cpu kthread that is now complete and the wakeup is
> +	 * essentially a sync wakeup.
> +	 */
> +	if (is_per_cpu_kthread(current) &&
> +	    prev == smp_processor_id() &&
> +	    this_rq()->nr_running <= 1) {
> +		return prev;
> +	}

Ok, so if I've read this correctly, this special case only triggers
when scheduling from the per-cpu kworker thread context, and only if
there is one other runnable task on the queue? So it special cases
the ping-pong case so that the non-bound task that scheduled the
kworker also remains scheduled this CPU?

Hmmmm.

When we set up a workqueue as WQ_UNBOUND on a numa system, isn't the
worker pool set up as a node-bound task? i.e. it's not a per-cpu
kthread anymore, but a task limited by the cpumask of that node?
That isn't a per-CPU kthread anymore, is it? That is:

> @@ -2479,3 +2479,16 @@ static inline void membarrier_switch_mm(struct rq *rq,
>  {
>  }
>  #endif
> +
> +#ifdef CONFIG_SMP
> +static inline bool is_per_cpu_kthread(struct task_struct *p)
> +{
> +	if (!(p->flags & PF_KTHREAD))
> +		return false;
> +
> +	if (p->nr_cpus_allowed != 1)
> +		return false;

p->nr_cpus_allowed is no longer 1 but the number of CPUs in the
per-node cpu mask it is allowed to run on?

And so if that is the case, then the change in commit 8ab39f11d974
which set WQ_UNBOUND on the XFS CIL workqueue would mean the above
logic change should not be triggering for the CIL worker because it
is no longer a CPU bound kthread....

What am I missing here?

<light bulb illumination>

Is this actually ping-ponging the CIL flush and journal IO
completion because xlog_bio_end_io() always punts journal IO
completion to the log workqueue, which is:

	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
			WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_HIGHPRI, 0,
			mp->m_super->s_id);

i.e. it uses per-cpu kthreads for processing journal IO completion
similar to DIO io completion and thereby provides a vector for
the same issue?

A typical fsync is processed like this:

user task		CIL kworker		IO completion kworker
   xfs_trans_commit()
    pushes on log
    <blocks waiting on flush completion>

			<wake>
			formats vectors
			loop {
			   wait for iclog space
			   <block waiting on write completion>

						<wake>
						journal IO completion
						frees up iclog space
						wakes write waiter
						<done>

			   <wake>
			   write vectors into iclog
			   submit iclog IO
			}
			<done>

						<wake>
						journal IO completion
						frees up iclog space
						wakes flush waiter
						<done>
   <wakes>
   <transaction commit done>

i.e. before commit 8ab39f11d974 we have:

user task = unbound
XFS CIL commit worker = CPU bound kthread
XFS journal IO completion = CPU bound kthread

And because the the CIL kworker and IO completion kworker are bound
to the same CPU they don't trigger migrations as they can't be moved
anywhere else.  And so it doesn't matter how many times we switch
between them to complete a CIL flush because they will not trigger
migrations.

However, after commit 8ab39f11d974 we have:

user task = unbound
XFS CIL commit worker = unbound kthread
XFS journal IO completion = CPU bound kthread

IOWs, I think we now have exactly the same situation as discussed in
the thread I pointed you to above, where an unbound task work (the
CIL kworker) is trying to run on the same CPU as the CPU bound IO
completion kworker, and that causes the CIL kworker to be migrated
to a different CPU on each bounced throught the "wait for iclog
space" loop. Hence your new logic is actually triggering on the
journal IO completion kworker threads, not the CIL kworker threads.

After all this, I have two questions that would help me understand
if this is what you are seeing:

1. to confirm: does removing just the WQ_UNBOUND from the CIL push
workqueue (as added in 8ab39f11d974) make the regression go away?

2. when the problem shows up, which tasks are actually being
migrated excessively - is it the user task, the CIL kworker task
or something else?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
