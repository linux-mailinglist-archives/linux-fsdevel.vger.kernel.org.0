Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC44E1007B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKROyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 09:54:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35046 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKROyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:54:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so19298093ljg.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2019 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zySh92AsK17Tbfa2bO3mDBDQTkurxauurJzGmieX1zs=;
        b=h2j6tqaiwTD58j6xKeiLmpsyqxn9H7QgTdX/gJAVKCPB4ozMITrwaQ8Ff4agmxwgXX
         IiB8iXemiu0FPZYRulT5S5QQQOlyiQm8QCQfaQsDyhagLebQ6f12A1pn5DE9edTPT3J9
         oc+4MnSOywLmz+F6A1tieTf76LEv+fVl0tPj7hDiDw+IzfZfnypeAL2YQtw7HMWWRHaQ
         F6ZYkTMQ9mYH6oyH9BdNRyXcEPz3oD6f9gHlF+Mbq82rGM3Et6vtyshoMFQ+vD6WFVOE
         qwm3weM2kzTvZdum57+QJKrRAC1gQCzH3hsfd+P5p1JOYKmdq7ByYT/NxDmjyrWiF3hL
         NdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zySh92AsK17Tbfa2bO3mDBDQTkurxauurJzGmieX1zs=;
        b=EdNNeoOGElLfxLx0oRBtvz+S8XMSnv2SO1fn9rroKjfQb5PHPpBILhALyBQrL5Ggv/
         kGcuEfbpqZWejITYAUoIClwREl2t9xgKBdydcUNNZpjBOS/YPeFUtmg1qG6CzZmbFa8D
         NQB8yBuxau6ErOzYcdXPrPvSpQ5/O90heKZl+8n5ykRKgGwSaaCtZIswZDz3vh6nNPHd
         nllRq6OYA2qDf+50C8pI8Wzhwg/ingfhmuxVzJMeVRjriYDYpJXlbrS065I/iECZ3T+q
         qP7DGp1eGjzolJq6b704H9BsG29Auqj24L447Bk6MFivxhV5cmcqRt6HtryecYXTW+hN
         39Kg==
X-Gm-Message-State: APjAAAUPkd7lJQAlVYkdIrgA8Ho/zVVyFRgGYVg5ecSywaRrf23Ac+xy
        +tetQidPQtbTo5A/WwOTcSMSx+XOnCzaD/dzlt9Jjw==
X-Google-Smtp-Source: APXvYqzAa4eOEtBi2PdWPRFasQw3qOejtWoCw4teL8OM4bu4/kQLhg1QGg/F0xq0ntys8ajedqjSn9oBlvaTTpR3HZg=
X-Received: by 2002:a2e:982:: with SMTP id 124mr22194019ljj.48.1574088880847;
 Mon, 18 Nov 2019 06:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20191114113153.GB4213@ming.t460p> <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p> <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p> <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191118092121.GV4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Nov 2019 15:54:29 +0100
Message-ID: <CAKfTPtBz3E9i6eTDG=RZArSCBBDepf8kK7Uogi8kQX9UQeck1Q@mail.gmail.com>
Subject: Re: single aio thread is migrated crazily by scheduler
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 18 Nov 2019 at 10:21, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> +Vincent
>
> On Sat, Nov 16, 2019 at 10:40:05AM +1100, Dave Chinner wrote:
> > On Fri, Nov 15, 2019 at 03:08:43PM +0800, Ming Lei wrote:
> > > On Fri, Nov 15, 2019 at 03:56:34PM +1100, Dave Chinner wrote:
> > > > On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> > > I can reproduce the issue with 4k block size on another RH system, an=
d
> > > the login info of that system has been shared to you in RH BZ.
> > >
> > > 1)
> > > sysctl kernel.sched_min_granularity_ns=3D10000000
> > > sysctl kernel.sched_wakeup_granularity_ns=3D15000000
> >
> > So, these settings definitely influence behaviour.
> >
> > If these are set to kernel defaults (4ms and 3ms each):
> >
> > sysctl kernel.sched_min_granularity_ns=3D4000000
> > sysctl kernel.sched_wakeup_granularity_ns=3D3000000
> >
> > The migration problem largely goes away - the fio task migration
> > event count goes from ~2,000 a run down to 200/run.
> >
> > That indicates that the migration trigger is likely load/timing
> > based. The analysis below is based on the 10/15ms numbers above,
> > because it makes it so much easier to reproduce.
> >
> > > 2)
> > > ./xfs_complete 4k
> > >
> > > Then you should see 1k~1.5k fio io thread migration in above test,
> > > either v5.4-rc7(build with rhel8 config) or RHEL 4.18 kernel.
> >
> > Almost all the fio task migrations are coming from migration/X
> > kernel threads. i.e it's the scheduler active balancing that is
> > causing the fio thread to bounce around.
> >
> > This is typical a typical trace, trimmed to remove extraneous noise.
> > The fio process is running on CPU 10:
> >
> >              fio-3185  [010] 50419.285954: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D1004014 [ns] vruntime=3D27067882290 [ns]
> >              fio-3185  [010] 50419.286953: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D979458 [ns] vruntime=3D27068861748 [ns]
> >              fio-3185  [010] 50419.287998: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D1028471 [ns] vruntime=3D27069890219 [ns]
> >              fio-3185  [010] 50419.289973: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D989989 [ns] vruntime=3D27071836208 [ns]
> >              fio-3185  [010] 50419.290958: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D963914 [ns] vruntime=3D27072800122 [ns]
> >              fio-3185  [010] 50419.291952: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D972532 [ns] vruntime=3D27073772654 [ns]
> >
> > fio consumes CPU for several milliseconds, then:
> >
> >              fio-3185  [010] 50419.292935: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D966032 [ns] vruntime=3D27074738686 [ns]
> >              fio-3185  [010] 50419.292941: sched_switch:         fio:31=
85 [120] S =3D=3D> kworker/10:0:2763 [120]
> >     kworker/10:0-2763  [010] 50419.292954: sched_stat_runtime:   comm=
=3Dkworker/10:0 pid=3D2763 runtime=3D13423 [ns] vruntime=3D27052479694 [ns]
> >     kworker/10:0-2763  [010] 50419.292956: sched_switch:         kworke=
r/10:0:2763 [120] R =3D=3D> fio:3185 [120]
> >              fio-3185  [010] 50419.293115: sched_waking:         comm=
=3Dkworker/10:0 pid=3D2763 prio=3D120 target_cpu=3D010
> >              fio-3185  [010] 50419.293116: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D160370 [ns] vruntime=3D27074899056 [ns]
> >              fio-3185  [010] 50419.293118: sched_wakeup:         kworke=
r/10:0:2763 [120] success=3D1 CPU:010
> >
> > A context switch out to a kworker, then 13us later we immediately
> > switch back to the fio process, and go on running. No doubt
> > somewhere in what the fio process is doing, we queue up more work to
> > be run on the cpu, but the fio task keeps running
> > (due to CONFIG_PREEMPT=3Dn).
> >
> >              fio-3185  [010] 50419.293934: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D803135 [ns] vruntime=3D27075702191 [ns]
> >              fio-3185  [010] 50419.294936: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D988478 [ns] vruntime=3D27076690669 [ns]
> >              fio-3185  [010] 50419.295934: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D982219 [ns] vruntime=3D27077672888 [ns]
> >              fio-3185  [010] 50419.296935: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D984781 [ns] vruntime=3D27078657669 [ns]
> >              fio-3185  [010] 50419.297934: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D981703 [ns] vruntime=3D27079639372 [ns]
> >              fio-3185  [010] 50419.298937: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D990057 [ns] vruntime=3D27080629429 [ns]
> >              fio-3185  [010] 50419.299935: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D977554 [ns] vruntime=3D27081606983 [ns]
> >
> > About 6ms later, CPU 0 kicks the active load balancer on CPU 10...
> >
> >           <idle>-0     [000] 50419.300014: sched_waking:         comm=
=3Dmigration/10 pid=3D70 prio=3D0 target_cpu=3D010
> >              fio-3185  [010] 50419.300024: sched_wakeup:         migrat=
ion/10:70 [0] success=3D1 CPU:010
> >              fio-3185  [010] 50419.300026: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D79291 [ns] vruntime=3D27081686274 [ns]
> >              fio-3185  [010] 50419.300027: sched_switch:         fio:31=
85 [120] S =3D=3D> migration/10:70 [0]
> >     migration/10-70    [010] 50419.300032: sched_migrate_task:   comm=
=3Dfio pid=3D3185 prio=3D120 orig_cpu=3D10 dest_cpu=3D12
> >     migration/10-70    [010] 50419.300040: sched_switch:         migrat=
ion/10:70 [0] D =3D=3D> kworker/10:0:2763 [120]
> >
> > And 10us later the fio process is switched away, the active load
> > balancer work is run and migrates the fio process to CPU 12. Then...
> >
> >     kworker/10:0-2763  [010] 50419.300048: sched_stat_runtime:   comm=
=3Dkworker/10:0 pid=3D2763 runtime=3D9252 [ns] vruntime=3D27062908308 [ns]
> >     kworker/10:0-2763  [010] 50419.300062: sched_switch:         kworke=
r/10:0:2763 [120] R =3D=3D> swapper/10:0 [120]
> >           <idle>-0     [010] 50419.300067: sched_waking:         comm=
=3Dkworker/10:0 pid=3D2763 prio=3D120 target_cpu=3D010
> >           <idle>-0     [010] 50419.300069: sched_wakeup:         kworke=
r/10:0:2763 [120] success=3D1 CPU:010
> >           <idle>-0     [010] 50419.300071: sched_switch:         swappe=
r/10:0 [120] S =3D=3D> kworker/10:0:2763 [120]
> >     kworker/10:0-2763  [010] 50419.300073: sched_switch:         kworke=
r/10:0:2763 [120] R =3D=3D> swapper/10:0 [120]
> >
> > The kworker runs for another 10us and the CPU goes idle. Shortly
> > after this, CPU 12 is woken:
> >
> >           <idle>-0     [012] 50419.300113: sched_switch:         swappe=
r/12:0 [120] S =3D=3D> fio:3185 [120]
> >              fio-3185  [012] 50419.300596: sched_waking:         comm=
=3Dkworker/12:1 pid=3D227 prio=3D120 target_cpu=3D012
> >              fio-3185  [012] 50419.300598: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D561137 [ns] vruntime=3D20361153275 [ns]
> >              fio-3185  [012] 50419.300936: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D326187 [ns] vruntime=3D20361479462 [ns]
> >              fio-3185  [012] 50419.301935: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D981201 [ns] vruntime=3D20362460663 [ns]
> >              fio-3185  [012] 50419.302935: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D983160 [ns] vruntime=3D20363443823 [ns]
> >              fio-3185  [012] 50419.303934: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D983855 [ns] vruntime=3D20364427678 [ns]
> >              fio-3185  [012] 50419.304934: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D977757 [ns] vruntime=3D20365405435 [ns]
> >              fio-3185  [012] 50419.305948: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D999563 [ns] vruntime=3D20366404998 [ns]
> >
> >
> > and fio goes on running there. The pattern repeats very soon afterwards=
:
> >
> >           <idle>-0     [000] 50419.314982: sched_waking:         comm=
=3Dmigration/12 pid=3D82 prio=3D0 target_cpu=3D012
> >              fio-3185  [012] 50419.314988: sched_wakeup:         migrat=
ion/12:82 [0] success=3D1 CPU:012
> >              fio-3185  [012] 50419.314990: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D46342 [ns] vruntime=3D20375268656 [ns]
> >              fio-3185  [012] 50419.314991: sched_switch:         fio:31=
85 [120] S =3D=3D> migration/12:82 [0]
> >     migration/12-82    [012] 50419.314995: sched_migrate_task:   comm=
=3Dfio pid=3D3185 prio=3D120 orig_cpu=3D12 dest_cpu=3D5
> >     migration/12-82    [012] 50419.315001: sched_switch:         migrat=
ion/12:82 [0] D =3D=3D> kworker/12:1:227 [120]
> >     kworker/12:1-227   [012] 50419.315022: sched_stat_runtime:   comm=
=3Dkworker/12:1 pid=3D227 runtime=3D21453 [ns] vruntime=3D20359477889 [ns]
> >     kworker/12:1-227   [012] 50419.315028: sched_switch:         kworke=
r/12:1:227 [120] R =3D=3D> swapper/12:0 [120]
> >           <idle>-0     [005] 50419.315053: sched_switch:         swappe=
r/5:0 [120] S =3D=3D> fio:3185 [120]
> >              fio-3185  [005] 50419.315286: sched_waking:         comm=
=3Dkworker/5:0 pid=3D2646 prio=3D120 target_cpu=3D005
> >              fio-3185  [005] 50419.315288: sched_stat_runtime:   comm=
=3Dfio pid=3D3185 runtime=3D287737 [ns] vruntime=3D33779011507 [ns]
> >
> > And fio is now running on CPU 5 - it only ran on CPU 12 for about
> > 15ms. Hmmm:
> >
> > $ grep fio-3185 ~/tmp/sched.out | awk 'BEGIN {totcpu =3D 0.0; switches =
=3D 0.0; prev_waket =3D 0.0 }/sched_waking/ { cpu =3D $2; split($3, t, ":")=
; waket =3D t[1]; if (cpu !=3D prev_cpu) { t_on_cpu =3D waket - prev_waket;=
 if (prev_waket) { print "time on CPU", cpu, "was", t_on_cpu; totcpu +=3D t=
_on_cpu; switches++ } prev_waket =3D waket; prev_cpu =3D cpu; } } END { pri=
nt "switches", switches, "time on cpu", totcpu, "aver time on cpu", (totcpu=
 / switches) } ' | stats --trim-outliers
> > switches 2211 time on cpu 30.0994 aver time on cpu 0.0136135
> > time on CPU [0-23(8.8823+/-6.2)] was 0.000331-0.330772(0.0134759+/-0.01=
2)
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

I agree with your explanation above

Although queue_work uses queue_work_on(WORK_CPU_UNBOUND,... At the
end, it uses a bounded workqueue and tries to queue the work on the
local cpu 1st even if the latter is already busy

>
> I'll go see if I can reproduce and stare at the workqueue code a bit.
>
> >
> > > Not reproduced the issue with 512 block size on the RH system yet,
> > > maybe it is related with my kernel config.
> >
> > I doubt it - this looks like a load specific corner case in the
> > scheduling algorithm....
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
