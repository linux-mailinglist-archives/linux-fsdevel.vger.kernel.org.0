Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4661611C00B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 23:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLKWqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 17:46:23 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:46912 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbfLKWqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:46:23 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2394B82045C;
        Thu, 12 Dec 2019 09:46:18 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ifAkL-0005w2-3b; Thu, 12 Dec 2019 09:46:17 +1100
Date:   Thu, 12 Dec 2019 09:46:17 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4] sched/core: Preempt current task in favour of bound
 kthread
Message-ID: <20191211224617.GE19256@dread.disaster.area>
References: <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
 <20191121132937.GW4114@hirez.programming.kicks-ass.net>
 <20191209165122.GA27229@linux.vnet.ibm.com>
 <20191209231743.GA19256@dread.disaster.area>
 <20191210054330.GF27253@linux.vnet.ibm.com>
 <20191210172307.GD9139@linux.vnet.ibm.com>
 <20191211173829.GB21797@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211173829.GB21797@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=DKMTVZrBpn61F86xKIIA:9 a=7pSkhifIAIoKH1Ap:21
        a=Iepqc9itoRpRa7oB:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=1c-WWmYQErFem0j6iXEC:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:08:29PM +0530, Srikar Dronamraju wrote:
> A running task can wake-up a per CPU bound kthread on the same CPU.
> If the current running task doesn't yield the CPU before the next load
> balance operation, the scheduler would detect load imbalance and try to
> balance the load. However this load balance would fail as the waiting
> task is CPU bound, while the running task cannot be moved by the regular
> load balancer. Finally the active load balancer would kick in and move
> the task to a different CPU/Core. Moving the task to a different
> CPU/core can lead to loss in cache affinity leading to poor performance.
> 
> This is more prone to happen if the current running task is CPU
> intensive and the sched_wake_up_granularity is set to larger value.
> When the sched_wake_up_granularity was relatively small, it was observed
> that the bound thread would complete before the load balancer would have
> chosen to move the cache hot task to a different CPU.
> 
> To deal with this situation, the current running task would yield to a
> per CPU bound kthread, provided kthread is not CPU intensive.

So a question for you here: when does the workqueue worker pre-empt
the currently running task? Is it immediately? Or when a time-slice
of the currently running task runs out?

We don't want queued work immediately pre-empting the task that
queued the work - the queued work is *deferred* work that should be
run _soon_ but we want the currently running task to finish what it
is doing first if possible. i.e. these are not synchronous wakeups,
and so we shouldn't schedule kworker threads as though they are sync
wakeups. That will affect batch processing effciency and reduce
throughput because it will greatly increase the number of
unnecessary context switches during IO completion processing....

> /pboffline/hwcct_prg_old/lib/fsperf -t overwrite --noclean -f 5g -b 4k /pboffline
> 
> (With sched_wake_up_granularity set to 15ms)
> 
> Performance counter stats for 'system wide' (5 runs):
> event					    v5.4 				v5.4 + patch(v3)
> probe:active_load_balance_cpu_stop       1,919  ( +-  2.89% )                     4  ( +- 20.48% )
> sched:sched_waking                     441,535  ( +-  0.17% )               914,630  ( +-  0.18% )
> sched:sched_wakeup                     441,533  ( +-  0.17% )               914,630  ( +-  0.18% )
> sched:sched_wakeup_new                   2,436  ( +-  8.08% )                   545  ( +-  4.02% )
> sched:sched_switch                     797,007  ( +-  0.26% )             1,490,261  ( +-  0.10% )
> sched:sched_migrate_task                20,998  ( +-  1.04% )                 2,492  ( +- 11.56% )

As we see here. We've doubled the number of context switches
(increased by 700,000) just to avoid 17,000 incorrect load balancer
task migrations.

That seems like we now make 700,000 incorrect decisions instead of
just 20,000. The difference is that the consequence of making these
many incorrect pre-emption decisions is vastly less than the
consequence of making the wrong migration decision.

It seems to me that we should be checking this is_per_cpu_kthread()
state for tasks queued on the runqueue during active load balancing,
rather than at wakeup time.  i.e. in these cases we don't migrate
the running task, we just let it run out it's timeslice out and the
local per-cpu kthreads then run appropriately.

AFAICT this would have the same effect of avoiding unnecessary task
migrations in this workload, but without causing a global change to
the way workqueue kworkers are scheduled that has the potential to
cause regressions in other workqueue intensive workloads....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
