Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8398B111BA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 23:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfLCW3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 17:29:32 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54117 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727131AbfLCW3c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:29:32 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id DF15E3A16AB;
        Wed,  4 Dec 2019 09:29:26 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1icGfd-0006VE-Vs; Wed, 04 Dec 2019 09:29:25 +1100
Date:   Wed, 4 Dec 2019 09:29:25 +1100
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
Message-ID: <20191203222925.GM2695@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <20191202090158.15016-1-hdanton@sina.com>
 <20191203131514.5176-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203131514.5176-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=LmalR2UegCLWsU6ZP5sA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 03, 2019 at 09:15:14PM +0800, Hillf Danton wrote:
> > IOWs, we are trying to ensure that we run the data IO completion on
> > the CPU with that has that data hot in cache. When we are running
> > millions of IOs every second, this matters -a lot-. IRQ steering is
> > just a mechansim that is used to ensure completion processing hits
> > hot caches.
> 
> Along the "CPU affinity" direction, a trade-off is made between CPU
> affinity and cache affinity before lb can bear the ca scheme.
> Completion works are queued in round robin on the CPUs that share
> cache with the submission CPU.
> 
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -143,6 +143,42 @@ static inline void iomap_dio_set_error(s
>  	cmpxchg(&dio->error, 0, ret);
>  }
>  
> +static DEFINE_PER_CPU(int, iomap_dio_bio_end_io_cnt);
> +static DEFINE_PER_CPU(int, iomap_dio_bio_end_io_cpu);
> +#define IOMAP_DIO_BIO_END_IO_BATCH 7
> +
> +static int iomap_dio_cpu_rr(void)
> +{
> +	int *io_cnt, *io_cpu;
> +	int cpu, this_cpu;
> +
> +	io_cnt = get_cpu_ptr(&iomap_dio_bio_end_io_cnt);
> +	io_cpu = this_cpu_ptr(&iomap_dio_bio_end_io_cpu);
> +	this_cpu = smp_processor_id();
> +
> +	if (!(*io_cnt & IOMAP_DIO_BIO_END_IO_BATCH)) {
> +		for (cpu = *io_cpu + 1; cpu < nr_cpu_id; cpu++)
> +			if (cpu == this_cpu ||
> +			    cpus_share_cache(cpu, this_cpu))
> +				goto update_cpu;
> +
> +		for (cpu = 0; cpu < *io_cpu; cpu++)
> +			if (cpu == this_cpu ||
> +			    cpus_share_cache(cpu, this_cpu))
> +				goto update_cpu;

Linear scans like this just don't scale. We can have thousands of
CPUs in a system and maybe only 8 cores that share a local cache.
And we can be completing millions of direct IO writes a second these
days. A linear scan of (thousands - 8) cpu ids every so often is
going to show up as long tail latency for the unfortunate IO that
has to scan those thousands of non-matching CPU IDs to find a
sibling, and we'll be doing that every handful of IOs that are
completed on every CPU.

> +
> +		cpu = this_cpu;
> +update_cpu:
> +		*io_cpu = cpu;
> +	}
> +
> +	(*io_cnt)++;
> +	cpu = *io_cpu;
> +	put_cpu_ptr(&iomap_dio_bio_end_io_cnt);
> +
> +	return cpu;
> +}
> 
>  static void iomap_dio_bio_end_io(struct bio *bio)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
> @@ -158,9 +194,10 @@ static void iomap_dio_bio_end_io(struct
>  			blk_wake_io_task(waiter);
>  		} else if (dio->flags & IOMAP_DIO_WRITE) {
>  			struct inode *inode = file_inode(dio->iocb->ki_filp);
> +			int cpu = iomap_dio_cpu_rr();

IMO, this sort of "limit work to sibling CPU cores" does not belong in
general code. We have *lots* of workqueues that need this treatment,
and it's not viable to add this sort of linear search loop to every
workqueue and place we queue work. Besides....

>  
>  			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> -			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> +			queue_work_on(cpu, inode->i_sb->s_dio_done_wq, &dio->aio.work);

.... as I've stated before, this *does not solve the scheduler
problem*.  All this does is move the problem to the target CPU
instead of seeing it on the local CPU.

If we really want to hack around the load balancer problems in this
way, then we need to add a new workqueue concurrency management type
with behaviour that lies between the default of bound and WQ_UNBOUND.

WQ_UNBOUND limits scheduling to within a numa node - see
wq_update_unbound_numa() for how it sets up the cpumask attributes
it applies to it's workers - but we need the work to be bound to
within the local cache domain rather than a numa node. IOWs, set up
the kworker task pool management structure with the right attributes
(e.g. cpu masks) to define the cache domains, add all the hotplug
code to make it work with CPU hotplug, then simply apply those
attributes to the kworker task that is selected to execute the work.

This allows the scheduler to migrate the kworker away from the local
run queue without interrupting the currently scheduled task. The
cpumask limits the task is configured with limit the scheduler to
selecting the best CPU within the local cache domain, and we don't
have to bind work to CPUs to get CPU cache friendly work scheduling.
This also avoids overhead of per-queue_work_on() sibling CPU
calculation, and all the code that wants to use this functionality
needs to do is add a single flag at work queue init time (e.g.
WQ_CACHEBOUND).

IOWs, if the task migration behaviour cannot be easily fixed and so
we need work queue users to be more flexible about work placement,
then the solution needed here is "cpu cache local work queue
scheduling" implemented in the work queue infrastructure, not in
every workqueue user.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
