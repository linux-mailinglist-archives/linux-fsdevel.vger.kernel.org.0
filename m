Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D5105C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUWLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 17:11:00 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39292 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbfKUWLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:11:00 -0500
Received: from dread.disaster.area (pa49-181-174-87.pa.nsw.optusnet.com.au [49.181.174.87])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BC18043FDB6;
        Fri, 22 Nov 2019 09:10:53 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iXuf5-0005LT-V4; Fri, 22 Nov 2019 09:10:51 +1100
Date:   Fri, 22 Nov 2019 09:10:51 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191121221051.GG4614@dread.disaster.area>
References: <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121041218.GK24548@ming.t460p>
 <20191121141207.GA18443@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121141207.GA18443@pauld.bos.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3v0Do7u/0+cnL2zxahI5mg==:117 a=3v0Do7u/0+cnL2zxahI5mg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=YOsLQFoBVTFCsumd8cMA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 09:12:07AM -0500, Phil Auld wrote:
> On Thu, Nov 21, 2019 at 12:12:18PM +0800 Ming Lei wrote:
> > On Wed, Nov 20, 2019 at 05:03:13PM -0500, Phil Auld wrote:
> > > Hi Peter,
> > > 
> > > On Wed, Nov 20, 2019 at 08:16:36PM +0100 Peter Zijlstra wrote:
> > > > On Tue, Nov 19, 2019 at 07:40:54AM +1100, Dave Chinner wrote:
> > > > > On Mon, Nov 18, 2019 at 10:21:21AM +0100, Peter Zijlstra wrote:
> > > > 
> > > > > > We typically only fall back to the active balancer when there is
> > > > > > (persistent) imbalance and we fail to migrate anything else (of
> > > > > > substance).
> > > > > > 
> > > > > > The tuning mentioned has the effect of less frequent scheduling, IOW,
> > > > > > leaving (short) tasks on the runqueue longer. This obviously means the
> > > > > > load-balancer will have a bigger chance of seeing them.
> > > > > > 
> > > > > > Now; it's been a while since I looked at the workqueue code but one
> > > > > > possible explanation would be if the kworker that picks up the work item
> > > > > > is pinned. That would make it runnable but not migratable, the exact
> > > > > > situation in which we'll end up shooting the current task with active
> > > > > > balance.
> > > > > 
> > > > > Yes, that's precisely the problem - work is queued, by default, on a
> > > > > specific CPU and it will wait for a kworker that is pinned to that
> > > > 
> > > > I'm thinking the problem is that it doesn't wait. If it went and waited
> > > > for it, active balance wouldn't be needed, that only works on active
> > > > tasks.
> > > 
> > > Since this is AIO I wonder if it should queue_work on a nearby cpu by 
> > > default instead of unbound.  
> > 
> > When the current CPU isn't busy enough, there is still cost for completing
> > request remotely.
> > 
> > Or could we change queue_work() in the following way?
> > 
> >  * We try to queue the work to the CPU on which it was submitted, but if the
> >  * CPU dies or is saturated enough it can be processed by another CPU.
> > 
> > Can we decide in a simple or efficient way if the current CPU is saturated
> > enough?
> > 
> 
> The scheduler doesn't know if the queued_work submitter is going to go to sleep.
> That's why I was singling out AIO. My understanding of it is that you submit the IO
> and then keep going. So in that case it might be better to pick a node-local nearby
> cpu instead. But this is a user of work queue issue not a scheduler issue. 

I think the part people are missing completely here is that the
workqueue in question here is the -completion- work queue, and is
not actually directly connected to the submitter process that is
getting migrated. This all happens on the one CPU:

Submitter		blk-mq completion (softirq)		wq

io_submit()
  aio_write
    submit_bio
  aio_write
    submit_bio
  .....
			blk-mq bh triggered
			bio_endio
			  iomap_dio_endio(dio)
			    queue_work(dio)
							kworker queued
			bio_endio
			  iomap_dio_endio(dio)
			    queue_work(dio)
			....
			<softirq ends, back to submitter>
  aio_write
    submit_bio
  aio_write
    submit_bio
  ...
  <scheduler migrates task>
							iomap_dio_complete()
							  aio_complete()
							....
							iomap_dio_complete()
							  aio_complete()
							....
							iomap_dio_complete()
							  aio_complete()

IOWs, the reason we see this behaviour is the IO completion steering
done by the blk-mq layer is, by default, directing completion back
to the submitter CPU. IIUC, it's the per-cpu submission/completion
queues that result in this behaviour, because local completion of
IOs has been measured to be substantially faster for highly
concurrent, high IOPS workloads.

What Ming's reproducer workload does is increase the amount of CPU
that the submitter process uses to the point where it uses the
entire CPU and starves the completion kworker thread from running.
i.e. there is no idle CPU left for the completion to be processed
without pre-empting the running submitter task in some way.

Sometimes we see the scheduler run the kworker thread and switch
straight back to the submitter task - this is what typically happens
when the scheduler is using the default tunings. But when the
non-default tunings are used, task migrations occur.

So the scheduler migrates the submitter task, because it cannot move
the IO completion tasks. And then the blk-mq sees that submission
are coming from a different CPU, and it queues the incoming
completions to that new CPU, theyby repeating the pattern.

> Interestingly in our fio case the 4k one does not sleep and we get
> the active balance case where it moves the actually running
> thread.  The 512 byte case seems to be sleeping since the
> migrations are all at wakeup time I believe. 

The 512 byte case demonstrates a behaviour where the submitter task
is ping ponging between CPUs on each IO submission. It is likely
another corner case when the blk-mq behaviour of delivering
completions to the submitter CPU triggers immediate migration rather
than just context switching to the kworker thread. Further
investigation needs to be done there to determine if the migration
is caused by pre-emption, or whether it is a result of the submitter
finishing work and yeilding the CPU, but then being woken and
finding the CPU is held by a running bound task and so is migrated
to an idle CPU. The next IO completion has the completion directed
to the new CPU, and so it migrates back when woken.

IOWs, Whatever the cause of the task migration is, it is likely that
it is repeating because IO completions are following the submitter
task around and repeatedly triggering the same migration heuristic
over and over again.

Also, keep in mind this is *not caused by AIO*. Workqueues are used
in IO completion to avoid a basic "can't do filesystem modification
work in irq context" problem. i.e. we can't take blocking locks or
run transactions in bio completion context, because that will stall
IO completion processing for that CPU completelyi, and then the
fileystem deadlocks.

And "non-AIO" example is page cache writeback: the bdi flusher
threads are designed around an asynchrnous IO submission pattern
where it never waits for completions. In this case, delayed
allocation is the reason the submitter consumes a big chunk of CPU.
And IO completion uses workqueues ifor the same reason as AIO -
because we often have to run transactions to complete the metadata
updates necessary to finish the IO correctly. We can't do those
updates in the bio completion context (softirq) because we need to
block and do stuff that is dependent on future IO completions being
processed.

So, yeah, this "queue small amounts of work to a workqueue from IO
completion context" is fundamental to how the filesystem IO stack
functions in a modern kernel. As such, this specific IO completion
workqueue usage needs to be handled correctly by the default kernel
config, and not fall apart when scheduler tunings are slightly
tweaked.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
