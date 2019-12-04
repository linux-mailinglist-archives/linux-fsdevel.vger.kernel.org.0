Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF2C1137EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 23:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfLDW7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 17:59:23 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:41601 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbfLDW7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:59:23 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 31B6E3A1476;
        Thu,  5 Dec 2019 09:59:17 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1icdc3-0006dP-VE; Thu, 05 Dec 2019 09:59:15 +1100
Date:   Thu, 5 Dec 2019 09:59:15 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191204225915.GO2695@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <20191202090158.15016-1-hdanton@sina.com>
 <20191203131514.5176-1-hdanton@sina.com>
 <20191204102903.896-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204102903.896-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=3OwV-sDklMwd061yJKAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:29:03PM +0800, Hillf Danton wrote:
> 
> On Wed, 4 Dec 2019 09:29:25 +1100 Dave Chinner wrote:
> > 
> > If we really want to hack around the load balancer problems in this
> > way, then we need to add a new workqueue concurrency management type
> > with behaviour that lies between the default of bound and WQ_UNBOUND.
> > 
> > WQ_UNBOUND limits scheduling to within a numa node - see
> > wq_update_unbound_numa() for how it sets up the cpumask attributes
> > it applies to it's workers - but we need the work to be bound to
> > within the local cache domain rather than a numa node. IOWs, set up
> > the kworker task pool management structure with the right attributes
> > (e.g. cpu masks) to define the cache domains, add all the hotplug
> > code to make it work with CPU hotplug, then simply apply those
> > attributes to the kworker task that is selected to execute the work.
> > 
> > This allows the scheduler to migrate the kworker away from the local
> > run queue without interrupting the currently scheduled task. The
> > cpumask limits the task is configured with limit the scheduler to
> > selecting the best CPU within the local cache domain, and we don't
> > have to bind work to CPUs to get CPU cache friendly work scheduling.
> > This also avoids overhead of per-queue_work_on() sibling CPU
> > calculation, and all the code that wants to use this functionality
> > needs to do is add a single flag at work queue init time (e.g.
> > WQ_CACHEBOUND).
> > 
> > IOWs, if the task migration behaviour cannot be easily fixed and so
> > we need work queue users to be more flexible about work placement,
> > then the solution needed here is "cpu cache local work queue
> > scheduling" implemented in the work queue infrastructure, not in
> > every workqueue user.
> 
> Add WQ_CACHE_BOUND and a user of it and a helper to find cpus that
> share cache.

<sigh>

If you are going to quote my suggestion in full, then please
implement it in full. This patch does almost none of what you quoted
above - it still has all the problems of the previous version that
lead me to write the above.

> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1358,16 +1358,42 @@ static bool is_chained_work(struct workq
>  	return worker && worker->current_pwq->wq == wq;
>  }
>  
> +static DEFINE_PER_CPU(int, wq_sel_cbc_cnt);
> +static DEFINE_PER_CPU(int, wq_sel_cbc_cpu);
> +#define WQ_SEL_CBC_BATCH 7
> +
> +static int wq_select_cache_bound_cpu(int this_cpu)
> +{
> +	int *cntp, *cpup;
> +	int cpu;
> +
> +	cntp = get_cpu_ptr(&wq_sel_cbc_cnt);
> +	cpup = this_cpu_ptr(&wq_sel_cbc_cpu);
> +	cpu = *cpup;
> +
> +	if (!(*cntp & WQ_SEL_CBC_BATCH)) {
> +		cpu = cpus_share_cache_next_cpu(this_cpu, cpu);
> +		*cpup = cpu;
> +	}
> +	(*cntp)++;
> +	put_cpu_ptr(&wq_sel_cbc_cnt);
> +
> +	return cpu;
> +}

This selects a specific CPU in the local cache domain at
queue_work() time, just like the previous patch. It does not do what
I suggested above in reponse to the scalability issues this approach
has...

>  /*
>   * When queueing an unbound work item to a wq, prefer local CPU if allowed
>   * by wq_unbound_cpumask.  Otherwise, round robin among the allowed ones to
>   * avoid perturbing sensitive tasks.
>   */
> -static int wq_select_unbound_cpu(int cpu)
> +static int wq_select_unbound_cpu(int cpu, bool cache_bound)
>  {
>  	static bool printed_dbg_warning;
>  	int new_cpu;
>  
> +	if (cache_bound)
> +		return wq_select_cache_bound_cpu(cpu);
> +
>  	if (likely(!wq_debug_force_rr_cpu)) {
>  		if (cpumask_test_cpu(cpu, wq_unbound_cpumask))
>  			return cpu;
> @@ -1417,7 +1443,8 @@ static void __queue_work(int cpu, struct
>  	rcu_read_lock();
>  retry:
>  	if (req_cpu == WORK_CPU_UNBOUND)
> -		cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> +		cpu = wq_select_unbound_cpu(raw_smp_processor_id(),
> +					wq->flags & WQ_CACHE_BOUND);

And the per-cpu  kworker pool selection after we've selected a CPU
here binds it to that specific CPU or (if WQ_UNBOUND) the local
node. IOWs, this is exactly the same functionality as the last
patch, just moved inside the work queue infrastructure.

IOWs, apart from the WQ_CACHE_BOUND flag, this patch doesn't
implement any of what I suggested above. It does not solve the the
problem of bound kworkers kicking running tasks off a CPU so the
bound task can run, and it does not allow the scheduler to select
the best CPU in the local cache scheduling domain for the kworker to
run on. i.e. it still behaves like bound work rather than WQ_UNBOUND
work.

IMO, this adds the CPU selection to the -wrong function-.  We still
want the local CPU selected when req_cpu == WORK_CPU_UNBOUND.  The
following code selects where the kworker will be bound based on the
task pool that the workqueue is configured to use:

	/* pwq which will be used unless @work is executing elsewhere */
	if (!(wq->flags & WQ_UNBOUND))
		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
	else
		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));

i.e. the local CPU is the key we need to look up the task pool for
running tasks in the local cache domain - we do not use it as the
CPU we want to run work on. IOWs, what we really want is this:

	if (wq->flags & WQ_UNBOUND)
		pwq = unbound_pwq_by_node(wq, cpu_to_node(cpu));
	else if (wq->flags & WQ_CACHE_BOUND)
		pwq = unbound_pwq_by_cache(wq, cpu);
	else
		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);

And then unbound_pwq_by_cache() is implemented in a similar manner
to unbound_pwq_by_node() where there is a separate worker pool per
cache domain. THe scheduler domain attributes (cpumask) is held by
the task pool, and they are applied to the kworker task when it's
given the task to run. This, like WQ_UNBOUND, allows the scheduler
to select the best CPU in the cpumask for the task to run on.

Binding kworkers to a single CPU is exactly the problem we need to
avoid here - we need to let the scheduler choose the best CPU in the
local cache domain based on the current load. That means the
implementation needs to behave like a WQ_UNBOUND workqueue, just
with a more restrictive cpumask.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
