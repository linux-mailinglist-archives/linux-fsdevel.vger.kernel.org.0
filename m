Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF1914C2E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 23:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1WVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 17:21:24 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47951 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgA1WVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:21:23 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C881C7EA220;
        Wed, 29 Jan 2020 09:21:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwZEO-0004wY-9A; Wed, 29 Jan 2020 09:21:12 +1100
Date:   Wed, 29 Jan 2020 09:21:12 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200128222112.GD18610@dread.disaster.area>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128142427.GC3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128142427.GC3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=_R43YDBi6-2cVu1dfQcA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:24:27PM +0000, Mel Gorman wrote:
> I'm adding Jan Kara to the cc as he was looking into the workqueue
> implemention in depth this morning and helped me better understand what
> is going on.
> 
> Phil and Ming are still cc'd as an independent test would still be nice.
> 
> > <light bulb illumination>
> > 
> > Is this actually ping-ponging the CIL flush and journal IO
> > completion because xlog_bio_end_io() always punts journal IO
> > completion to the log workqueue, which is:
> > 
> > 	log->l_ioend_workqueue = alloc_workqueue("xfs-log/%s",
> > 			WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_HIGHPRI, 0,
> > 			mp->m_super->s_id);
> > 
> > i.e. it uses per-cpu kthreads for processing journal IO completion
> > similar to DIO io completion and thereby provides a vector for
> > the same issue?
> > 
> 
> Your light bulb is on point. The XFS unbound workqueue does run near the
> task and does not directly cause the migration but the IO completions
> matter. As it turned out, it was the IO completions I was looking at
> in the old traces but there was insufficient detail to see the exact
> sequence. I only observed that a bound wq at the end was causing the
> migration and it was a consistent pattern.
> 
> I did a more detailed trace that included workqueue tracepoints. I limited
> the run to 1 and 2 dbench clients and compared with and without the
> patch. I still did not dig deep into the specifics of how XFS interacts
> with workqueues because I'm focused on how the scheduler reacts.

[snip traces]

Ok, so it's not /exactly/ as I thought - what is happening is that
both dbench and the CIL push kworker are issuing IO during fsync
operations. dbench issues the data IO, the CIL push worker issues
the journal IO.

> This is an example sequence of what's happening from a scheduler
> perspective on the vanilla kernel. It's editted a bit because there
> were a lot of other IOs going on, mostly logging related which confuse
> the picture.
> 
>           dbench-25633 [004] d...   194.998648: workqueue_queue_work: work struct=000000001cccdc2d function=xlog_cil_push_work [xfs] workqueue=00000000d90239c9 req_cpu=512 cpu=4294967295
>           dbench-25633 [004] d...   194.998650: sched_waking: comm=kworker/u161:6 pid=718 prio=120 target_cpu=006
>           dbench-25633 [004] d...   194.998655: sched_wakeup: comm=kworker/u161:6 pid=718 prio=120 target_cpu=006
>   kworker/u161:6-718   [006] ....   194.998692: workqueue_execute_start: work struct 000000001cccdc2d: function xlog_cil_push_work [xfs]
>   kworker/u161:6-718   [006] ....   194.998706: workqueue_execute_end: work struct 000000001cccdc2d
> 
> Dbench is on CPU 4, it queues xlog_cil_push_work on an UNBOUND
> workqueue. An unbound kworker wakes on CPU 6 and finishes quickly.
> 
>   kworker/u161:6-718   [006] ....   194.998707: workqueue_execute_start: work struct 0000000046fbf8d5: function wq_barrier_func
>   kworker/u161:6-718   [006] d...   194.998708: sched_waking: comm=dbench pid=25633 prio=120 target_cpu=004
>   kworker/u161:6-718   [006] d...   194.998712: sched_wakeup: comm=dbench pid=25633 prio=120 target_cpu=004
>   kworker/u161:6-718   [006] ....   194.998713: workqueue_execute_end: work struct 0000000046fbf8d5

Ok, that's what I'd expect if dbench issued a log force as part of
an fsync() or synchronous transaction. This is it flushing the CIL
and waiting for the flush work to complete (wq_barrier_func is what
wakes the wq flush waiter).

This doesn't complete the log force, however - the dbench process
will now do a bit more work and then go to sleep waiting for journal
IO to complete.

> The kworker wakes dbench and finding that CPU 4 is still free, dbench
> uses its previous CPU and no migration occurs.
> 
>           dbench-25633 [004] d...   194.998727: workqueue_queue_work: work struct=00000000442434a7 function=blk_mq_requeue_work workqueue=00000000df918933 req_cpu=512 cpu=4
>           dbench-25633 [004] d...   194.998728: sched_waking: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
>           dbench-25633 [004] dN..   194.998731: sched_wakeup: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
> 
> Dbench queues blk_mq_requeue_work. This is a BOUND workqueue with a
> mandatory CPU target of 4 so no migration..

So I spent some time trying to work out how the dbench process
triggers this directly. This work is queued when a new cache flush
command is inserted into the request queue, and generally those are
done by the journal writes via REQ_PREFLUSH | REQ_FUA. Those would
show up in the context of the xlog_cil_push_work and run on that
CPU, not the dbench task or CPU.

So this is probably xfs_file_fsync() calling
xfs_blkdev_issue_flush() directly because the inode metadata had
already been written to the journal by an earlier (or racing)
journal flush.  Hence we have to flush the device cache manually to
ensure that the data that may have been written is also on stable
storage. That will insert a flush directly into the request queue,
and that's likely how we are getting the flush machinery running on
this CPU.

>     kworker/4:1H-991   [004] ....   194.998736: workqueue_execute_start: work struct 00000000442434a7: function blk_mq_requeue_work
>     kworker/4:1H-991   [004] ....   194.998742: workqueue_execute_end: work struct 00000000442434a7
> 
> blk_mq_requeue_work is done
> 
>           <idle>-0     [004] d.s.   194.998859: workqueue_queue_work: work struct=00000000442434a7 function=blk_mq_requeue_work workqueue=00000000df918933 req_cpu=512 cpu=4
>           <idle>-0     [004] d.s.   194.998861: sched_waking: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
>           <idle>-0     [004] dNs.   194.998862: sched_wakeup: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
>     kworker/4:1H-991   [004] ....   194.998866: workqueue_execute_start: work struct 00000000442434a7: function blk_mq_requeue_work
>     kworker/4:1H-991   [004] ....   194.998870: workqueue_execute_end: work struct 00000000442434a7
>           <idle>-0     [004] d.s.   194.998911: workqueue_queue_work: work struct=0000000072f39adb function=xlog_ioend_work [xfs] workqueue=00000000008f3d7f req_cpu=512 cpu=4
>           <idle>-0     [004] d.s.   194.998912: sched_waking: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
>           <idle>-0     [004] dNs.   194.998913: sched_wakeup: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
> 
> Ok, this looks like an IRQ delivered for IO completion and the
> xlog_ioend_work is reached. The BOUND kworker is woken again by the IRQ
> handler on CPU 4 because it has no choice.

Yeah, this looks to be is the completion of the cache flush that the
dbench process is waiting on. It looks like the block layer is
aggregating sequential cache flushes into a single operation, and so
a post-journal-write cache flush and the fsync cache flush are one
and the same. Hence it runs journal IO completion in this flush
completion context, which queues xlog_ioend_work()...

>     kworker/4:1H-991   [004] ....   194.998918: workqueue_execute_start: work struct 0000000072f39adb: function xlog_ioend_work [xfs]
>     kworker/4:1H-991   [004] d...   194.998943: sched_waking: comm=dbench pid=25633 prio=120 target_cpu=004
>     kworker/4:1H-991   [004] d...   194.998945: sched_migrate_task: comm=dbench pid=25633 prio=120 orig_cpu=4 dest_cpu=5
>     kworker/4:1H-991   [004] d...   194.998947: sched_wakeup: comm=dbench pid=25633 prio=120 target_cpu=005
>     kworker/4:1H-991   [004] ....   194.998948: workqueue_execute_end: work struct 0000000072f39adb
> 
> The IO completion handler finishes, the bound workqueue tries to wake
> dbench on its old CPU. The BOUND kworker is on CPU 4, the task wants
> CPU 4 but the CPU is busy with the kworker so the scheduler function
> select_idle_sibling picks CPU 5 instead and now the task is migrated
> and we have started our round-trip of all CPUs sharing a LLC. It's not a
> perfect round-robin because p->recent_used_cpu often works.  Looking at
> the traces, dbench bounces back and forth between CPUs 4 and 5 for 7 IO
> completions before bouncing between CPUs 6/7 and so on.

Then this happens.

Ok, so the commit that made the CIL push work unbound didn't
introduce this sub-optimal scheduling pattern, it just made it more
likely to trigger by increasing the likelihood of cache flush
aggregation. I think the problem was likely first visible when
blk-mq was introduced because of it's async cache flush machinery
but it went unnoticed because dbench on blk-mq was faster because of
all the other improvements blkmq brought to the table....

> The patch alters the very last stage. The IO completion is a bound kworker
> and allows the wakee task to use the same CPU and avoid the migration.

*nod*

AFAICT, everything is pointing to this being the same issue as the
AIO/DIO completion issue. We've got a bound worker thread waking an
unbound user task, and the scheduler is migrating the unbound worker
task to an idle CPU because it doesn't know we really want
synchronous wakeup semantics in this situation. And, really, I don't
think the code doing the wakeup knows whether synchronous wakeup
semantics are correct, either, as there can be many processes across
the entire machine waiting on this journal IO completion
notification. Hence I suspect a runtime evaluated heuristic is the
best we can do here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
