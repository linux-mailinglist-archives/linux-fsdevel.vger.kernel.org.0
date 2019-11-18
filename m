Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27057100D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 21:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfKRUlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 15:41:06 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:57664 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbfKRUlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:41:06 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 262253A1D17;
        Tue, 19 Nov 2019 07:40:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iWnpO-00050x-Nx; Tue, 19 Nov 2019 07:40:54 +1100
Date:   Tue, 19 Nov 2019 07:40:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191118204054.GV4614@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118092121.GV4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=yVoF5iLBKTpoLJ-sB64A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:21:21AM +0100, Peter Zijlstra wrote:
> On Sat, Nov 16, 2019 at 10:40:05AM +1100, Dave Chinner wrote:
> > On Fri, Nov 15, 2019 at 03:08:43PM +0800, Ming Lei wrote:
> > And fio is now running on CPU 5 - it only ran on CPU 12 for about
> > 15ms. Hmmm:
> > 
> > $ grep fio-3185 ~/tmp/sched.out | awk 'BEGIN {totcpu = 0.0; switches = 0.0; prev_waket = 0.0 }/sched_waking/ { cpu = $2; split($3, t, ":"); waket = t[1]; if (cpu != prev_cpu) { t_on_cpu = waket - prev_waket; if (prev_waket) { print "time on CPU", cpu, "was", t_on_cpu; totcpu += t_on_cpu; switches++ } prev_waket = waket; prev_cpu = cpu; } } END { print "switches", switches, "time on cpu", totcpu, "aver time on cpu", (totcpu / switches) } ' | stats --trim-outliers
> > switches 2211 time on cpu 30.0994 aver time on cpu 0.0136135
> > time on CPU [0-23(8.8823+/-6.2)] was 0.000331-0.330772(0.0134759+/-0.012)
> > 
> > Yeah, the fio task averages 13.4ms on any given CPU before being
> > switched to another CPU. Mind you, the stddev is 12ms, so the range
> > of how long it spends on any one CPU is pretty wide (330us to
> > 330ms).
> > 
> > IOWs, this doesn't look like a workqueue problem at all - this looks
> > like the scheduler is repeatedly making the wrong load balancing
> > decisions when mixing a very short runtime task (queued work) with a
> > long runtime task on the same CPU....
> > 
> > This is not my area of expertise, so I have no idea why this might
> > be happening. Scheduler experts: is this expected behaviour? What
> > tunables directly influence the active load balancer (and/or CONFIG
> > options) to change how aggressive it's behaviour is?
> 
> We typically only fall back to the active balancer when there is
> (persistent) imbalance and we fail to migrate anything else (of
> substance).
> 
> The tuning mentioned has the effect of less frequent scheduling, IOW,
> leaving (short) tasks on the runqueue longer. This obviously means the
> load-balancer will have a bigger chance of seeing them.
> 
> Now; it's been a while since I looked at the workqueue code but one
> possible explanation would be if the kworker that picks up the work item
> is pinned. That would make it runnable but not migratable, the exact
> situation in which we'll end up shooting the current task with active
> balance.

Yes, that's precisely the problem - work is queued, by default, on a
specific CPU and it will wait for a kworker that is pinned to that
specific CPU to dispatch it. We've already tested that queuing on a
different CPU (via queue_work_on()) makes the problem largely go
away as the work is not longer queued behind the long running fio
task.

This, however, is not at viable solution to the problem. The pattern
of a long running process queuing small pieces of individual work
for processing in a separate context is pretty common...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
