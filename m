Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678C9FE8BC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKOXkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 18:40:13 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45822 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfKOXkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:40:13 -0500
Received: from dread.disaster.area (pa49-181-255-80.pa.nsw.optusnet.com.au [49.181.255.80])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 64C9F3A221B;
        Sat, 16 Nov 2019 10:40:07 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iVlC9-0007EW-Ik; Sat, 16 Nov 2019 10:40:05 +1100
Date:   Sat, 16 Nov 2019 10:40:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191115234005.GO4614@dread.disaster.area>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115070843.GA24246@ming.t460p>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=XqaD5fcB6dAc7xyKljs8OA==:117 a=XqaD5fcB6dAc7xyKljs8OA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=rOqdYy3dB9lPaKltuk8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 03:08:43PM +0800, Ming Lei wrote:
> On Fri, Nov 15, 2019 at 03:56:34PM +1100, Dave Chinner wrote:
> > On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> I can reproduce the issue with 4k block size on another RH system, and
> the login info of that system has been shared to you in RH BZ.
> 
> 1)
> sysctl kernel.sched_min_granularity_ns=10000000
> sysctl kernel.sched_wakeup_granularity_ns=15000000

So, these settings definitely influence behaviour.

If these are set to kernel defaults (4ms and 3ms each):

sysctl kernel.sched_min_granularity_ns=4000000
sysctl kernel.sched_wakeup_granularity_ns=3000000

The migration problem largely goes away - the fio task migration
event count goes from ~2,000 a run down to 200/run.

That indicates that the migration trigger is likely load/timing
based. The analysis below is based on the 10/15ms numbers above,
because it makes it so much easier to reproduce.

> 2)
> ./xfs_complete 4k
> 
> Then you should see 1k~1.5k fio io thread migration in above test,
> either v5.4-rc7(build with rhel8 config) or RHEL 4.18 kernel.

Almost all the fio task migrations are coming from migration/X
kernel threads. i.e it's the scheduler active balancing that is
causing the fio thread to bounce around.

This is typical a typical trace, trimmed to remove extraneous noise.
The fio process is running on CPU 10:

             fio-3185  [010] 50419.285954: sched_stat_runtime:   comm=fio pid=3185 runtime=1004014 [ns] vruntime=27067882290 [ns]
             fio-3185  [010] 50419.286953: sched_stat_runtime:   comm=fio pid=3185 runtime=979458 [ns] vruntime=27068861748 [ns]
             fio-3185  [010] 50419.287998: sched_stat_runtime:   comm=fio pid=3185 runtime=1028471 [ns] vruntime=27069890219 [ns]
             fio-3185  [010] 50419.289973: sched_stat_runtime:   comm=fio pid=3185 runtime=989989 [ns] vruntime=27071836208 [ns]
             fio-3185  [010] 50419.290958: sched_stat_runtime:   comm=fio pid=3185 runtime=963914 [ns] vruntime=27072800122 [ns]
             fio-3185  [010] 50419.291952: sched_stat_runtime:   comm=fio pid=3185 runtime=972532 [ns] vruntime=27073772654 [ns]

fio consumes CPU for several milliseconds, then:

             fio-3185  [010] 50419.292935: sched_stat_runtime:   comm=fio pid=3185 runtime=966032 [ns] vruntime=27074738686 [ns]
             fio-3185  [010] 50419.292941: sched_switch:         fio:3185 [120] S ==> kworker/10:0:2763 [120]
    kworker/10:0-2763  [010] 50419.292954: sched_stat_runtime:   comm=kworker/10:0 pid=2763 runtime=13423 [ns] vruntime=27052479694 [ns]
    kworker/10:0-2763  [010] 50419.292956: sched_switch:         kworker/10:0:2763 [120] R ==> fio:3185 [120]
             fio-3185  [010] 50419.293115: sched_waking:         comm=kworker/10:0 pid=2763 prio=120 target_cpu=010
             fio-3185  [010] 50419.293116: sched_stat_runtime:   comm=fio pid=3185 runtime=160370 [ns] vruntime=27074899056 [ns]
             fio-3185  [010] 50419.293118: sched_wakeup:         kworker/10:0:2763 [120] success=1 CPU:010

A context switch out to a kworker, then 13us later we immediately
switch back to the fio process, and go on running. No doubt
somewhere in what the fio process is doing, we queue up more work to
be run on the cpu, but the fio task keeps running
(due to CONFIG_PREEMPT=n).

             fio-3185  [010] 50419.293934: sched_stat_runtime:   comm=fio pid=3185 runtime=803135 [ns] vruntime=27075702191 [ns]
             fio-3185  [010] 50419.294936: sched_stat_runtime:   comm=fio pid=3185 runtime=988478 [ns] vruntime=27076690669 [ns]
             fio-3185  [010] 50419.295934: sched_stat_runtime:   comm=fio pid=3185 runtime=982219 [ns] vruntime=27077672888 [ns]
             fio-3185  [010] 50419.296935: sched_stat_runtime:   comm=fio pid=3185 runtime=984781 [ns] vruntime=27078657669 [ns]
             fio-3185  [010] 50419.297934: sched_stat_runtime:   comm=fio pid=3185 runtime=981703 [ns] vruntime=27079639372 [ns]
             fio-3185  [010] 50419.298937: sched_stat_runtime:   comm=fio pid=3185 runtime=990057 [ns] vruntime=27080629429 [ns]
             fio-3185  [010] 50419.299935: sched_stat_runtime:   comm=fio pid=3185 runtime=977554 [ns] vruntime=27081606983 [ns]

About 6ms later, CPU 0 kicks the active load balancer on CPU 10...

          <idle>-0     [000] 50419.300014: sched_waking:         comm=migration/10 pid=70 prio=0 target_cpu=010
             fio-3185  [010] 50419.300024: sched_wakeup:         migration/10:70 [0] success=1 CPU:010
             fio-3185  [010] 50419.300026: sched_stat_runtime:   comm=fio pid=3185 runtime=79291 [ns] vruntime=27081686274 [ns]
             fio-3185  [010] 50419.300027: sched_switch:         fio:3185 [120] S ==> migration/10:70 [0]
    migration/10-70    [010] 50419.300032: sched_migrate_task:   comm=fio pid=3185 prio=120 orig_cpu=10 dest_cpu=12
    migration/10-70    [010] 50419.300040: sched_switch:         migration/10:70 [0] D ==> kworker/10:0:2763 [120]

And 10us later the fio process is switched away, the active load
balancer work is run and migrates the fio process to CPU 12. Then...

    kworker/10:0-2763  [010] 50419.300048: sched_stat_runtime:   comm=kworker/10:0 pid=2763 runtime=9252 [ns] vruntime=27062908308 [ns]
    kworker/10:0-2763  [010] 50419.300062: sched_switch:         kworker/10:0:2763 [120] R ==> swapper/10:0 [120]
          <idle>-0     [010] 50419.300067: sched_waking:         comm=kworker/10:0 pid=2763 prio=120 target_cpu=010
          <idle>-0     [010] 50419.300069: sched_wakeup:         kworker/10:0:2763 [120] success=1 CPU:010
          <idle>-0     [010] 50419.300071: sched_switch:         swapper/10:0 [120] S ==> kworker/10:0:2763 [120]
    kworker/10:0-2763  [010] 50419.300073: sched_switch:         kworker/10:0:2763 [120] R ==> swapper/10:0 [120]

The kworker runs for another 10us and the CPU goes idle. Shortly
after this, CPU 12 is woken:

          <idle>-0     [012] 50419.300113: sched_switch:         swapper/12:0 [120] S ==> fio:3185 [120]
             fio-3185  [012] 50419.300596: sched_waking:         comm=kworker/12:1 pid=227 prio=120 target_cpu=012
             fio-3185  [012] 50419.300598: sched_stat_runtime:   comm=fio pid=3185 runtime=561137 [ns] vruntime=20361153275 [ns]
             fio-3185  [012] 50419.300936: sched_stat_runtime:   comm=fio pid=3185 runtime=326187 [ns] vruntime=20361479462 [ns]
             fio-3185  [012] 50419.301935: sched_stat_runtime:   comm=fio pid=3185 runtime=981201 [ns] vruntime=20362460663 [ns]
             fio-3185  [012] 50419.302935: sched_stat_runtime:   comm=fio pid=3185 runtime=983160 [ns] vruntime=20363443823 [ns]
             fio-3185  [012] 50419.303934: sched_stat_runtime:   comm=fio pid=3185 runtime=983855 [ns] vruntime=20364427678 [ns]
             fio-3185  [012] 50419.304934: sched_stat_runtime:   comm=fio pid=3185 runtime=977757 [ns] vruntime=20365405435 [ns]
             fio-3185  [012] 50419.305948: sched_stat_runtime:   comm=fio pid=3185 runtime=999563 [ns] vruntime=20366404998 [ns]


and fio goes on running there. The pattern repeats very soon afterwards:

          <idle>-0     [000] 50419.314982: sched_waking:         comm=migration/12 pid=82 prio=0 target_cpu=012
             fio-3185  [012] 50419.314988: sched_wakeup:         migration/12:82 [0] success=1 CPU:012
             fio-3185  [012] 50419.314990: sched_stat_runtime:   comm=fio pid=3185 runtime=46342 [ns] vruntime=20375268656 [ns]
             fio-3185  [012] 50419.314991: sched_switch:         fio:3185 [120] S ==> migration/12:82 [0]
    migration/12-82    [012] 50419.314995: sched_migrate_task:   comm=fio pid=3185 prio=120 orig_cpu=12 dest_cpu=5
    migration/12-82    [012] 50419.315001: sched_switch:         migration/12:82 [0] D ==> kworker/12:1:227 [120]
    kworker/12:1-227   [012] 50419.315022: sched_stat_runtime:   comm=kworker/12:1 pid=227 runtime=21453 [ns] vruntime=20359477889 [ns]
    kworker/12:1-227   [012] 50419.315028: sched_switch:         kworker/12:1:227 [120] R ==> swapper/12:0 [120]
          <idle>-0     [005] 50419.315053: sched_switch:         swapper/5:0 [120] S ==> fio:3185 [120]
             fio-3185  [005] 50419.315286: sched_waking:         comm=kworker/5:0 pid=2646 prio=120 target_cpu=005
             fio-3185  [005] 50419.315288: sched_stat_runtime:   comm=fio pid=3185 runtime=287737 [ns] vruntime=33779011507 [ns]

And fio is now running on CPU 5 - it only ran on CPU 12 for about
15ms. Hmmm:

$ grep fio-3185 ~/tmp/sched.out | awk 'BEGIN {totcpu = 0.0; switches = 0.0; prev_waket = 0.0 }/sched_waking/ { cpu = $2; split($3, t, ":"); waket = t[1]; if (cpu != prev_cpu) { t_on_cpu = waket - prev_waket; if (prev_waket) { print "time on CPU", cpu, "was", t_on_cpu; totcpu += t_on_cpu; switches++ } prev_waket = waket; prev_cpu = cpu; } } END { print "switches", switches, "time on cpu", totcpu, "aver time on cpu", (totcpu / switches) } ' | stats --trim-outliers
switches 2211 time on cpu 30.0994 aver time on cpu 0.0136135
time on CPU [0-23(8.8823+/-6.2)] was 0.000331-0.330772(0.0134759+/-0.012)

Yeah, the fio task averages 13.4ms on any given CPU before being
switched to another CPU. Mind you, the stddev is 12ms, so the range
of how long it spends on any one CPU is pretty wide (330us to
330ms).

IOWs, this doesn't look like a workqueue problem at all - this looks
like the scheduler is repeatedly making the wrong load balancing
decisions when mixing a very short runtime task (queued work) with a
long runtime task on the same CPU....

This is not my area of expertise, so I have no idea why this might
be happening. Scheduler experts: is this expected behaviour? What
tunables directly influence the active load balancer (and/or CONFIG
options) to change how aggressive it's behaviour is?

> Not reproduced the issue with 512 block size on the RH system yet,
> maybe it is related with my kernel config.

I doubt it - this looks like a load specific corner case in the
scheduling algorithm....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
