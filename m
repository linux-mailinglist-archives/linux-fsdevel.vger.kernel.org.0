Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58414B9AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 15:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgA1OeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 09:34:05 -0500
Received: from outbound-smtp28.blacknight.com ([81.17.249.11]:47868 "EHLO
        outbound-smtp28.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732546AbgA1OYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:24:32 -0500
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id 593F0D01D0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 14:24:30 +0000 (GMT)
Received: (qmail 7133 invoked from network); 28 Jan 2020 14:24:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jan 2020 14:24:30 -0000
Date:   Tue, 28 Jan 2020 14:24:27 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200128142427.GC3466@techsingularity.net>
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

I'm adding Jan Kara to the cc as he was looking into the workqueue
implemention in depth this morning and helped me better understand what
is going on.

Phil and Ming are still cc'd as an independent test would still be nice.

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

Your light bulb is on point. The XFS unbound workqueue does run near the
task and does not directly cause the migration but the IO completions
matter. As it turned out, it was the IO completions I was looking at
in the old traces but there was insufficient detail to see the exact
sequence. I only observed that a bound wq at the end was causing the
migration and it was a consistent pattern.

I did a more detailed trace that included workqueue tracepoints. I limited
the run to 1 and 2 dbench clients and compared with and without the
patch. I still did not dig deep into the specifics of how XFS interacts
with workqueues because I'm focused on how the scheduler reacts.

The patch is still having an impact with bound workqueues as expected
because;

# zgrep sched_migrate_task 5.5.0-rc7-tipsched-20200124/iter-0/ftrace-dbench4.gz | wc -l
556259
# zgrep sched_migrate_task 5.5.0-rc7-kworkerstack-v1r2/iter-0/ftrace-dbench4.gz | wc -l
11736

There are still migrations happening but there also was a lot of logging
going on for this run so it's not directly comparable what I originally
reported.

This is an example sequence of what's happening from a scheduler
perspective on the vanilla kernel. It's editted a bit because there
were a lot of other IOs going on, mostly logging related which confuse
the picture.

          dbench-25633 [004] d...   194.998648: workqueue_queue_work: work struct=000000001cccdc2d function=xlog_cil_push_work [xfs] workqueue=00000000d90239c9 req_cpu=512 cpu=4294967295
          dbench-25633 [004] d...   194.998650: sched_waking: comm=kworker/u161:6 pid=718 prio=120 target_cpu=006
          dbench-25633 [004] d...   194.998655: sched_wakeup: comm=kworker/u161:6 pid=718 prio=120 target_cpu=006
  kworker/u161:6-718   [006] ....   194.998692: workqueue_execute_start: work struct 000000001cccdc2d: function xlog_cil_push_work [xfs]
  kworker/u161:6-718   [006] ....   194.998706: workqueue_execute_end: work struct 000000001cccdc2d

Dbench is on CPU 4, it queues xlog_cil_push_work on an UNBOUND
workqueue. An unbound kworker wakes on CPU 6 and finishes quickly.

  kworker/u161:6-718   [006] ....   194.998707: workqueue_execute_start: work struct 0000000046fbf8d5: function wq_barrier_func
  kworker/u161:6-718   [006] d...   194.998708: sched_waking: comm=dbench pid=25633 prio=120 target_cpu=004
  kworker/u161:6-718   [006] d...   194.998712: sched_wakeup: comm=dbench pid=25633 prio=120 target_cpu=004
  kworker/u161:6-718   [006] ....   194.998713: workqueue_execute_end: work struct 0000000046fbf8d5

The kworker wakes dbench and finding that CPU 4 is still free, dbench
uses its previous CPU and no migration occurs.

          dbench-25633 [004] d...   194.998727: workqueue_queue_work: work struct=00000000442434a7 function=blk_mq_requeue_work workqueue=00000000df918933 req_cpu=512 cpu=4
          dbench-25633 [004] d...   194.998728: sched_waking: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
          dbench-25633 [004] dN..   194.998731: sched_wakeup: comm=kworker/4:1H pid=991 prio=100 target_cpu=004

Dbench queues blk_mq_requeue_work. This is a BOUND workqueue with a
mandatory CPU target of 4 so no migration..

    kworker/4:1H-991   [004] ....   194.998736: workqueue_execute_start: work struct 00000000442434a7: function blk_mq_requeue_work
    kworker/4:1H-991   [004] ....   194.998742: workqueue_execute_end: work struct 00000000442434a7

blk_mq_requeue_work is done

          <idle>-0     [004] d.s.   194.998859: workqueue_queue_work: work struct=00000000442434a7 function=blk_mq_requeue_work workqueue=00000000df918933 req_cpu=512 cpu=4
          <idle>-0     [004] d.s.   194.998861: sched_waking: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
          <idle>-0     [004] dNs.   194.998862: sched_wakeup: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
    kworker/4:1H-991   [004] ....   194.998866: workqueue_execute_start: work struct 00000000442434a7: function blk_mq_requeue_work
    kworker/4:1H-991   [004] ....   194.998870: workqueue_execute_end: work struct 00000000442434a7
          <idle>-0     [004] d.s.   194.998911: workqueue_queue_work: work struct=0000000072f39adb function=xlog_ioend_work [xfs] workqueue=00000000008f3d7f req_cpu=512 cpu=4
          <idle>-0     [004] d.s.   194.998912: sched_waking: comm=kworker/4:1H pid=991 prio=100 target_cpu=004
          <idle>-0     [004] dNs.   194.998913: sched_wakeup: comm=kworker/4:1H pid=991 prio=100 target_cpu=004

Ok, this looks like an IRQ delivered for IO completion and the
xlog_ioend_work is reached. The BOUND kworker is woken again by the IRQ
handler on CPU 4 because it has no choice.

    kworker/4:1H-991   [004] ....   194.998918: workqueue_execute_start: work struct 0000000072f39adb: function xlog_ioend_work [xfs]
    kworker/4:1H-991   [004] d...   194.998943: sched_waking: comm=dbench pid=25633 prio=120 target_cpu=004
    kworker/4:1H-991   [004] d...   194.998945: sched_migrate_task: comm=dbench pid=25633 prio=120 orig_cpu=4 dest_cpu=5
    kworker/4:1H-991   [004] d...   194.998947: sched_wakeup: comm=dbench pid=25633 prio=120 target_cpu=005
    kworker/4:1H-991   [004] ....   194.998948: workqueue_execute_end: work struct 0000000072f39adb

The IO completion handler finishes, the bound workqueue tries to wake
dbench on its old CPU. The BOUND kworker is on CPU 4, the task wants
CPU 4 but the CPU is busy with the kworker so the scheduler function
select_idle_sibling picks CPU 5 instead and now the task is migrated
and we have started our round-trip of all CPUs sharing a LLC. It's not a
perfect round-robin because p->recent_used_cpu often works.  Looking at
the traces, dbench bounces back and forth between CPUs 4 and 5 for 7 IO
completions before bouncing between CPUs 6/7 and so on.

The patch alters the very last stage. The IO completion is a bound kworker
and allows the wakee task to use the same CPU and avoid the migration.

-- 
Mel Gorman
SUSE Labs
