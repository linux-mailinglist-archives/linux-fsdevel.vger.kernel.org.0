Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48C10E668
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 08:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLBHjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 02:39:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46847 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbfLBHjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 02:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575272391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDwPxIthRhzqqxIn8nRFrTMx6Oq9FZoOrVRMoJGDac8=;
        b=KT7Ne+SKOneMgyNVHOg8GTj2dB24ZGAAtl6lQhF3VkZScHe/Tyg82QlA45n4fN1+YxkFCq
        78J2bfk8hk2stIXNazMkrdnqdRqVmDzW4i13w1Cln7vpobUzlRe/IwfDkn9yZabAJs3a2r
        113GyoK9JzxAhzlgPLsMLNGUtKSsBmI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-VCpWYpJdMCqdrBCwTg-O8A-1; Mon, 02 Dec 2019 02:39:50 -0500
Received: by mail-wm1-f71.google.com with SMTP id p5so5703725wmc.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2019 23:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h07fKCxz6cysE/fgl9fYUVPm0w40qHJZvUYbahblgw0=;
        b=SP2RePyum2S7m6zwfNFNtqS35wgHGULxDs/QDFjC4hBKEd2wAdN+4w0Sd7RytlrF0H
         10ILcLOghHoWccnwMEBygYcIlE/p+eE73b+qshSwEPL+U6PTEvoRchSguT9GxrchXbmL
         BfJXGOTSQhrxNwVB90X48zdJ4CktNfWRD0nOmU3f+1Akv8centT5xjeYuUKGtSD0F2tl
         l/nyigYEkr/YNzzDHT+gLVicP1FBMKQ5pLW5qIf2txsDoZCXragjj5EkoQtg/jtsz+5L
         8Kwd7957/lNgRfSkN+AlwCQVPwmlzny2huB5MwUs71+SBLzYiGLRxPcv5j11ucDe/BjW
         x/Ng==
X-Gm-Message-State: APjAAAXy59eBG2d7qIOHzoH3HjPppWgyRaw90RpytDf9sVE0cioF1xvl
        alsR9Wc+eN13kdhTyI5MXaPhu/FpL0cIEA2ZtIsE68AoWMi/FmYnFtmrPaopoPGn7eRR91OId8I
        LX4Ouu9SP2vepiUrN3f01aJwHWg==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr18045506wrv.333.1575272388543;
        Sun, 01 Dec 2019 23:39:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5BaUxQShBg6QgaaYASIoOuGOQzaZT45JG9xEGMspcb0TOWdi31u/XmEO1ZsyTdUs0mdL5lA==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr18045465wrv.333.1575272388079;
        Sun, 01 Dec 2019 23:39:48 -0800 (PST)
Received: from localhost.localdomain ([151.29.19.49])
        by smtp.gmail.com with ESMTPSA id u22sm21199872wru.30.2019.12.01.23.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Dec 2019 23:39:46 -0800 (PST)
Date:   Mon, 2 Dec 2019 08:39:44 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Rong Chen <rong.a.chen@intel.com>, Tejun Heo <tj@kernel.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191202073944.GQ23227@localhost.localdomain>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191128094003.752-1-hdanton@sina.com>
 <CAKfTPtA23ErKGCEJVmg6vk-QoufkiUM3NbXd31mZmKnuwbTkFw@mail.gmail.com>
 <20191202024625.GD24512@ming.t460p>
MIME-Version: 1.0
In-Reply-To: <20191202024625.GD24512@ming.t460p>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-MC-Unique: VCpWYpJdMCqdrBCwTg-O8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 02/12/19 10:46, Ming Lei wrote:
> On Thu, Nov 28, 2019 at 10:53:33AM +0100, Vincent Guittot wrote:
> > On Thu, 28 Nov 2019 at 10:40, Hillf Danton <hdanton@sina.com> wrote:
> > >
> > >
> > > On Sat, 16 Nov 2019 10:40:05 Dave Chinner wrote:
> > > > On Fri, Nov 15, 2019 at 03:08:43PM +0800, Ming Lei wrote:
> > > > > On Fri, Nov 15, 2019 at 03:56:34PM +1100, Dave Chinner wrote:
> > > > > > On Fri, Nov 15, 2019 at 09:08:24AM +0800, Ming Lei wrote:
> > > > > I can reproduce the issue with 4k block size on another RH system=
, and
> > > > > the login info of that system has been shared to you in RH BZ.
> > > > >
> > > > > 1)
> > > > > sysctl kernel.sched_min_granularity_ns=3D10000000
> > > > > sysctl kernel.sched_wakeup_granularity_ns=3D15000000
> > > >
> > > > So, these settings definitely influence behaviour.
> > > >
> > > > If these are set to kernel defaults (4ms and 3ms each):
> > > >
> > > > sysctl kernel.sched_min_granularity_ns=3D4000000
> > > > sysctl kernel.sched_wakeup_granularity_ns=3D3000000
> > > >
> > > > The migration problem largely goes away - the fio task migration
> > > > event count goes from ~2,000 a run down to 200/run.
> > > >
> > > > That indicates that the migration trigger is likely load/timing
> > > > based. The analysis below is based on the 10/15ms numbers above,
> > > > because it makes it so much easier to reproduce.
> > > >
> > > > > 2)
> > > > > ./xfs_complete 4k
> > > > >
> > > > > Then you should see 1k~1.5k fio io thread migration in above test=
,
> > > > > either v5.4-rc7(build with rhel8 config) or RHEL 4.18 kernel.
> > > >
> > > > Almost all the fio task migrations are coming from migration/X
> > > > kernel threads. i.e it's the scheduler active balancing that is
> > > > causing the fio thread to bounce around.
> > > >
> > > > This is typical a typical trace, trimmed to remove extraneous noise=
.
> > > > The fio process is running on CPU 10:
> > > >
> > > >              fio-3185  [010] 50419.285954: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D1004014 [ns] vruntime=3D27067882290 [ns]
> > > >              fio-3185  [010] 50419.286953: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D979458 [ns] vruntime=3D27068861748 [ns]
> > > >              fio-3185  [010] 50419.287998: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D1028471 [ns] vruntime=3D27069890219 [ns]
> > > >              fio-3185  [010] 50419.289973: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D989989 [ns] vruntime=3D27071836208 [ns]
> > > >              fio-3185  [010] 50419.290958: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D963914 [ns] vruntime=3D27072800122 [ns]
> > > >              fio-3185  [010] 50419.291952: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D972532 [ns] vruntime=3D27073772654 [ns]
> > > >
> > > > fio consumes CPU for several milliseconds, then:
> > > >
> > > >              fio-3185  [010] 50419.292935: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D966032 [ns] vruntime=3D27074738686 [ns]
> > > >              fio-3185  [010] 50419.292941: sched_switch:         fi=
o:3185 [120] S =3D=3D> kworker/10:0:2763 [120]
> > > >     kworker/10:0-2763  [010] 50419.292954: sched_stat_runtime:   co=
mm=3Dkworker/10:0 pid=3D2763 runtime=3D13423 [ns] vruntime=3D27052479694 [n=
s]
> > > >     kworker/10:0-2763  [010] 50419.292956: sched_switch:         kw=
orker/10:0:2763 [120] R =3D=3D> fio:3185 [120]
> > > >              fio-3185  [010] 50419.293115: sched_waking:         co=
mm=3Dkworker/10:0 pid=3D2763 prio=3D120 target_cpu=3D010
> > > >              fio-3185  [010] 50419.293116: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D160370 [ns] vruntime=3D27074899056 [ns]
> > > >              fio-3185  [010] 50419.293118: sched_wakeup:         kw=
orker/10:0:2763 [120] success=3D1 CPU:010
> > > >
> > > > A context switch out to a kworker, then 13us later we immediately
> > > > switch back to the fio process, and go on running. No doubt
> > > > somewhere in what the fio process is doing, we queue up more work t=
o
> > > > be run on the cpu, but the fio task keeps running
> > > > (due to CONFIG_PREEMPT=3Dn).
> > > >
> > > >              fio-3185  [010] 50419.293934: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D803135 [ns] vruntime=3D27075702191 [ns]
> > > >              fio-3185  [010] 50419.294936: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D988478 [ns] vruntime=3D27076690669 [ns]
> > > >              fio-3185  [010] 50419.295934: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D982219 [ns] vruntime=3D27077672888 [ns]
> > > >              fio-3185  [010] 50419.296935: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D984781 [ns] vruntime=3D27078657669 [ns]
> > > >              fio-3185  [010] 50419.297934: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D981703 [ns] vruntime=3D27079639372 [ns]
> > > >              fio-3185  [010] 50419.298937: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D990057 [ns] vruntime=3D27080629429 [ns]
> > > >              fio-3185  [010] 50419.299935: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D977554 [ns] vruntime=3D27081606983 [ns]
> > > >
> > > > About 6ms later, CPU 0 kicks the active load balancer on CPU 10...
> > > >
> > > >           <idle>-0     [000] 50419.300014: sched_waking:         co=
mm=3Dmigration/10 pid=3D70 prio=3D0 target_cpu=3D010
> > > >              fio-3185  [010] 50419.300024: sched_wakeup:         mi=
gration/10:70 [0] success=3D1 CPU:010
> > > >              fio-3185  [010] 50419.300026: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D79291 [ns] vruntime=3D27081686274 [ns]
> > > >              fio-3185  [010] 50419.300027: sched_switch:         fi=
o:3185 [120] S =3D=3D> migration/10:70 [0]
> > > >     migration/10-70    [010] 50419.300032: sched_migrate_task:   co=
mm=3Dfio pid=3D3185 prio=3D120 orig_cpu=3D10 dest_cpu=3D12
> > > >     migration/10-70    [010] 50419.300040: sched_switch:         mi=
gration/10:70 [0] D =3D=3D> kworker/10:0:2763 [120]
> > > >
> > > > And 10us later the fio process is switched away, the active load
> > > > balancer work is run and migrates the fio process to CPU 12. Then..=
.
> > > >
> > > >     kworker/10:0-2763  [010] 50419.300048: sched_stat_runtime:   co=
mm=3Dkworker/10:0 pid=3D2763 runtime=3D9252 [ns] vruntime=3D27062908308 [ns=
]
> > > >     kworker/10:0-2763  [010] 50419.300062: sched_switch:         kw=
orker/10:0:2763 [120] R =3D=3D> swapper/10:0 [120]
> > > >           <idle>-0     [010] 50419.300067: sched_waking:         co=
mm=3Dkworker/10:0 pid=3D2763 prio=3D120 target_cpu=3D010
> > > >           <idle>-0     [010] 50419.300069: sched_wakeup:         kw=
orker/10:0:2763 [120] success=3D1 CPU:010
> > > >           <idle>-0     [010] 50419.300071: sched_switch:         sw=
apper/10:0 [120] S =3D=3D> kworker/10:0:2763 [120]
> > > >     kworker/10:0-2763  [010] 50419.300073: sched_switch:         kw=
orker/10:0:2763 [120] R =3D=3D> swapper/10:0 [120]
> > > >
> > > > The kworker runs for another 10us and the CPU goes idle. Shortly
> > > > after this, CPU 12 is woken:
> > > >
> > > >           <idle>-0     [012] 50419.300113: sched_switch:         sw=
apper/12:0 [120] S =3D=3D> fio:3185 [120]
> > > >              fio-3185  [012] 50419.300596: sched_waking:         co=
mm=3Dkworker/12:1 pid=3D227 prio=3D120 target_cpu=3D012
> > > >              fio-3185  [012] 50419.300598: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D561137 [ns] vruntime=3D20361153275 [ns]
> > > >              fio-3185  [012] 50419.300936: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D326187 [ns] vruntime=3D20361479462 [ns]
> > > >              fio-3185  [012] 50419.301935: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D981201 [ns] vruntime=3D20362460663 [ns]
> > > >              fio-3185  [012] 50419.302935: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D983160 [ns] vruntime=3D20363443823 [ns]
> > > >              fio-3185  [012] 50419.303934: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D983855 [ns] vruntime=3D20364427678 [ns]
> > > >              fio-3185  [012] 50419.304934: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D977757 [ns] vruntime=3D20365405435 [ns]
> > > >              fio-3185  [012] 50419.305948: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D999563 [ns] vruntime=3D20366404998 [ns]
> > > >
> > > >
> > > > and fio goes on running there. The pattern repeats very soon afterw=
ards:
> > > >
> > > >           <idle>-0     [000] 50419.314982: sched_waking:         co=
mm=3Dmigration/12 pid=3D82 prio=3D0 target_cpu=3D012
> > > >              fio-3185  [012] 50419.314988: sched_wakeup:         mi=
gration/12:82 [0] success=3D1 CPU:012
> > > >              fio-3185  [012] 50419.314990: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D46342 [ns] vruntime=3D20375268656 [ns]
> > > >              fio-3185  [012] 50419.314991: sched_switch:         fi=
o:3185 [120] S =3D=3D> migration/12:82 [0]
> > > >     migration/12-82    [012] 50419.314995: sched_migrate_task:   co=
mm=3Dfio pid=3D3185 prio=3D120 orig_cpu=3D12 dest_cpu=3D5
> > > >     migration/12-82    [012] 50419.315001: sched_switch:         mi=
gration/12:82 [0] D =3D=3D> kworker/12:1:227 [120]
> > > >     kworker/12:1-227   [012] 50419.315022: sched_stat_runtime:   co=
mm=3Dkworker/12:1 pid=3D227 runtime=3D21453 [ns] vruntime=3D20359477889 [ns=
]
> > > >     kworker/12:1-227   [012] 50419.315028: sched_switch:         kw=
orker/12:1:227 [120] R =3D=3D> swapper/12:0 [120]
> > > >           <idle>-0     [005] 50419.315053: sched_switch:         sw=
apper/5:0 [120] S =3D=3D> fio:3185 [120]
> > > >              fio-3185  [005] 50419.315286: sched_waking:         co=
mm=3Dkworker/5:0 pid=3D2646 prio=3D120 target_cpu=3D005
> > > >              fio-3185  [005] 50419.315288: sched_stat_runtime:   co=
mm=3Dfio pid=3D3185 runtime=3D287737 [ns] vruntime=3D33779011507 [ns]
> > > >
> > > > And fio is now running on CPU 5 - it only ran on CPU 12 for about
> > > > 15ms. Hmmm:
> > > >
> > > > $ grep fio-3185 ~/tmp/sched.out | awk 'BEGIN {totcpu =3D 0.0; switc=
hes =3D 0.0; prev_waket =3D 0.0 }/sched_waking/ { cpu =3D $2; split($3, t, =
":"); waket =3D t[1]; if (cpu !=3D prev_cpu) { t_on_cpu =3D waket - prev_wa=
ket; if (prev_waket) { print "time on CPU", cpu, "was", t_on_cpu; totcpu +=
=3D t_on_cpu; switches++ } prev_waket =3D waket; prev_cpu =3D cpu; } } END =
{ print "switches", switches, "time on cpu", totcpu, "aver time on cpu", (t=
otcpu / switches) } ' | stats --trim-outliers
> > > > switches 2211 time on cpu 30.0994 aver time on cpu 0.0136135
> > > > time on CPU [0-23(8.8823+/-6.2)] was 0.000331-0.330772(0.0134759+/-=
0.012)
> > > >
> > > > Yeah, the fio task averages 13.4ms on any given CPU before being
> > > > switched to another CPU. Mind you, the stddev is 12ms, so the range
> > > > of how long it spends on any one CPU is pretty wide (330us to
> > > > 330ms).
> > > >
> > > Hey Dave
> > >
> > > > IOWs, this doesn't look like a workqueue problem at all - this look=
s
> > >
> > > Surprised to see you're so sure it has little to do with wq,
> > >
> > > > like the scheduler is repeatedly making the wrong load balancing
> > > > decisions when mixing a very short runtime task (queued work) with =
a
> > > > long runtime task on the same CPU....
> > > >
> > > and it helps more to know what is driving lb to make decisions like
> > > this. Because for 70+ per cent of communters in cities like London it
> > > is supposed tube is better than cab on work days, the end_io cb is
> > > tweaked to be a lookalike of execute_in_process_context() in the diff
> > > with the devoted s_dio_done_wq taken out of account. It's interesting
> > > to see what difference lb will make in the tube environment.
> > >
> > > Hillf
> > >
> > > > This is not my area of expertise, so I have no idea why this might
> > > > be happening. Scheduler experts: is this expected behaviour? What
> > > > tunables directly influence the active load balancer (and/or CONFIG
> > > > options) to change how aggressive it's behaviour is?
> > > >
> > > > > Not reproduced the issue with 512 block size on the RH system yet=
,
> > > > > maybe it is related with my kernel config.
> > > >
> > > > I doubt it - this looks like a load specific corner case in the
> > > > scheduling algorithm....
> > > >
> > > > Cheers,
> > > >
> > > > Dave.
> > > > --
> > > > Dave Chinner
> > > > david@fromorbit.com
> > >
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -157,10 +157,8 @@ static void iomap_dio_bio_end_io(struct
> > >                         WRITE_ONCE(dio->submit.waiter, NULL);
> > >                         blk_wake_io_task(waiter);
> > >                 } else if (dio->flags & IOMAP_DIO_WRITE) {
> > > -                       struct inode *inode =3D file_inode(dio->iocb-=
>ki_filp);
> > > -
> > >                         INIT_WORK(&dio->aio.work, iomap_dio_complete_=
work);
> > > -                       queue_work(inode->i_sb->s_dio_done_wq, &dio->=
aio.work);
> > > +                       schedule_work(&dio->aio.work);
> >=20
> > I'm not sure that this will make a real difference because it ends up
> > to call queue_work(system_wq, ...) and system_wq is bounded as well so
> > the work will still be pinned to a CPU
> > Using system_unbound_wq should make a difference because it doesn't
> > pin the work on a CPU
> >  +                       queue_work(system_unbound_wq, &dio->aio.work);
>=20
> Indeed, just run a quick test on my KVM guest, looks the following patch
> makes a difference:
>=20
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 9329ced91f1d..2f4488b0ecec 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -613,7 +613,8 @@ int sb_init_dio_done_wq(struct super_block *sb)
>  {
>         struct workqueue_struct *old;
>         struct workqueue_struct *wq =3D alloc_workqueue("dio/%s",
> -                                                     WQ_MEM_RECLAIM, 0,
> +                                                     WQ_MEM_RECLAIM |
> +                                                     WQ_UNBOUND, 0,
>                                                       sb->s_id);

Chiming in to report that, after Vincent suggested to try the very same
change out on a private IRC conversation, I saw the very same positive
effects. E.g.,

Baseline is using 'slow' sched parameters (10ms/15ms), baseline 3/4 is
same kernel just with default 'fast' sched params and dio unbound 10/15
is a kernel patched with the above patch and using 'slow' sched params.

fsperf-4k-5G                            baseline 3/4    dio unbound 10/15=
=09
                                        improv.=09        improv.
sequential initial write throughput=09-0.12=09        -0.87
                         latency=091.15=09        2.87
           overwrite     throughput=091186.32=09        1232.74
                         latency=0911.35           11.26
           read          throughput     0.80            -2.38
                         latency        2.79            3.03
random     initial write throughput     84.73           105.34
                         latency        0.00            1.14
           overwrite     throughput     254.27          273.17
                         latency        1.23            7.37
           read=09         throughput=0940.05           3.24
                         latency        8.03            7.36

Best,

Juri

