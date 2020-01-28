Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7597114B2A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 11:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgA1KcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 05:32:21 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:52006 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbgA1KcV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:32:21 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id EB7BD1C28C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 10:32:18 +0000 (GMT)
Received: (qmail 29623 invoked from network); 28 Jan 2020 10:32:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2020 10:32:18 -0000
Date:   Tue, 28 Jan 2020 10:32:16 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200128103216.GA3466@techsingularity.net>
References: <20200128100643.3016-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200128100643.3016-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 06:06:43PM +0800, Hillf Danton wrote:
> 
> On Mon, 27 Jan 2020 14:36:08 +0000 Mel Gorman wrote:
> > Commit 8ab39f11d974 ("xfs: prevent CIL push holdoff in log
> > recovery") changed from using bound workqueues to using unbound
> > workqueues. Functionally this makes sense but it was observed at the time
> > that the dbench performance dropped quite a lot and CPU migrations were
> > excessively high even when there are plenty of idle CPUs.
> > 
> > The pattern of the task migration is straight-forward. With XFS, an IO
> > issuer may delegate work to a kworker which wakes on the same CPU. On
> > completion of the work, it wakes the task, finds that the previous CPU
> > is busy (because the kworker is still running on it) and migrates the
> > task to the next idle CPU. The task ends up migrating around all CPUs
> > sharing a LLC at high frequency. This has negative implications both in
> > commication costs and power management.  mpstat confirmed that at low
> > thread counts that all CPUs sharing an LLC has low level of activity.
> > 
> > The impact of this problem is related to the number of CPUs sharing an LLC.
> > 
>
> Are you trying to fix a problem of cache affinity?
> 

No, I'm simply stating that the search space for select_idle_sibling
matters.

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
> 
> Looks like cache affinity is not your target.

It's not, at least not LLC. L1 is a partial consideration.

> Wondering why it does not work to select a cpu sharing cache with prev
> if strong relation exists between waker and wakee.
> 

Functionally it works, it's just slow. There is a cost to migration and
a cost to exiting from idle state and ramping up the CPU frequency.

> > +	    this_rq()->nr_running <= 1) {
> > +		return prev;
> > +	}
> > +
> >  	/* Check a recently used CPU as a potential idle candidate: */
> >  	recent_used_cpu = p->recent_used_cpu;
> >  	if (recent_used_cpu != prev &&
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 1a88dc8ad11b..5876e6ba5903 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
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
> 
> Suspect you need PF_KTHREAD instead of PF_WQ_WORKER. Here is a
> small helper and feel free to pick it up if it makes a sense.
> 

Did you mean to switch that around? Either way, I moved an existing helper
that is already used to detect this particular situation. While it works
when it's made specific to a workqueue and open-coding it, there was no
clear reason to narrow the conditions further.

-- 
Mel Gorman
SUSE Labs
