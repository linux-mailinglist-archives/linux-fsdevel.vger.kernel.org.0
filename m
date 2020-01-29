Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 775A914D2C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 23:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA2WA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 17:00:29 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42381 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgA2WA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:00:28 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5F41F7E7E17;
        Thu, 30 Jan 2020 09:00:24 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwvNl-0004zC-W7; Thu, 30 Jan 2020 09:00:22 +1100
Date:   Thu, 30 Jan 2020 09:00:21 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, fair: Allow a per-cpu kthread waking a task to
 stack on the same CPU
Message-ID: <20200129220021.GN18610@dread.disaster.area>
References: <20200127143608.GX3466@techsingularity.net>
 <20200127223256.GA18610@dread.disaster.area>
 <20200128011936.GY3466@techsingularity.net>
 <20200128091012.GZ3466@techsingularity.net>
 <20200129173852.GP14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129173852.GP14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=9OUhOvZmy8axzo4XzYoA:9 a=2cTGYF7_BJ3EkAcu:21
        a=c5nVs7L-Gq4kIs1z:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 06:38:52PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 28, 2020 at 09:10:12AM +0000, Mel Gorman wrote:
> > Peter, Ingo and Vincent -- I know the timing is bad due to the merge
> > window but do you have any thoughts on allowing select_idle_sibling to
> > stack a wakee task on the same CPU as a waker in this specific case?
> 
> I sort of see, but *groan*...
> 
> so if the kworker unlocks a contended mutex/rwsem/completion...
> 
> I suppose the fact that it limits it to tasks that were running on the
> same CPU limits the impact if we do get it wrong.
> 
> Elsewhere you write:
> 
> > I would prefer the wakeup code did not have to signal that it's a
> > synchronous wakeup. Sync wakeups so exist but callers got it wrong many
> > times where stacking was allowed and then the waker did not go to sleep.
> > While the chain of events are related, they are not related in a very
> > obvious way. I think it's much safer to keep this as a scheduler
> > heuristic instead of depending on callers to have sufficient knowledge
> > of the scheduler implementation.
> 
> That is true; the existing WF_SYNC has caused many issues for maybe
> being too strong.
> 
> But what if we create a new hint that combines both these ideas? Say
> WF_COMPLETE and subject that to these same criteria. This way we can
> eliminate wakeups from locks and such (they won't have this set).
> 
> Or am I just making things complicated again?

I suspect this is making it complicated again, because it requires
the people who maintain the code that is using workqueues to
understand when they might need to use a special wakeup interface in
the work function. And that includes code that currently calls
wake_up_all() because there can be hundreds of independent tasks
waiting on the IO completion (e.g all the wait queues in the XFS
journal code can (and do) have multiple threads waiting on them).

IOWs, requiring a special flag just to optimise this specific case
(i.e. single dependent waiter on same CPU as the kworker) when the
adverse behaviour is both hardware and workload dependent means it
just won't get used correctly or reliably.

Hence I'd much prefer the kernel detects and dynamically handles
this situation at runtime, because this pattern of workqueue usage
is already quite common and will only become more widespread as we
progress towards async processing of syscalls.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
