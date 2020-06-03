Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872931ECD42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 12:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgFCKKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 06:10:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgFCKK3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:10:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0013DABEC;
        Wed,  3 Jun 2020 10:10:28 +0000 (UTC)
Date:   Wed, 3 Jun 2020 11:10:22 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200603101022.GG3070@suse.de>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <87v9k84knx.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87v9k84knx.derkling@matbug.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:29:22AM +0200, Patrick Bellasi wrote:
> 
> Hi Dietmar,
> thanks for sharing these numbers.
> 
> On Tue, Jun 02, 2020 at 18:46:00 +0200, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote...
> 
> [...]
> 
> > I ran these tests on 'Ubuntu 18.04 Desktop' on Intel E5-2690 v2
> > (2 sockets * 10 cores * 2 threads) with powersave governor as:
> >
> > $ numactl -N 0 ./run-mmtests.sh XXX
> 
> Great setup, it's worth to rule out all possible noise source (freq
> scaling, thermal throttling, NUMA scheduler, etc.).

config-network-netperf-cross-socket will do the binding of the server
and client to two CPUs that are on one socket. However, it does not take
care to avoid HT siblings although that could be implemented. The same
configuration should limit the CPU to C1. It does not change the governor
but all that would take is adding "cpupower frequency-set -g performance"
to the end of the configuration.

> Wondering if disabling HT can also help here in reducing results "noise"?
> 
> > w/ config-network-netperf-unbound.
> >
> > Running w/o 'numactl -N 0' gives slightly worse results.
> >
> > without-clamp      : CONFIG_UCLAMP_TASK is not set
> > with-clamp         : CONFIG_UCLAMP_TASK=y,
> >                      CONFIG_UCLAMP_TASK_GROUP is not set
> > with-clamp-tskgrp  : CONFIG_UCLAMP_TASK=y,
> >                      CONFIG_UCLAMP_TASK_GROUP=y
> >
> >
> > netperf-udp
> >                                 ./5.7.0-rc7            ./5.7.0-rc7            ./5.7.0-rc7
> >                               without-clamp             with-clamp      with-clamp-tskgrp
> 
> Can you please specify how to read the following scores? I give it a run
> to my local netperf and it reports Throughput, thous I would expect the
> higher the better... but... this seems something different.
> 
> > Hmean     send-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> > Hmean     send-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> > Hmean     send-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> > Hmean     send-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> > Hmean     send-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.96 *   1.24%*
> > Hmean     send-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> > Hmean     send-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> > Hmean     send-8192     14961.77 (   0.00%)    14418.92 *  -3.63%*    14908.36 *  -0.36%*
> > Hmean     send-16384    25799.50 (   0.00%)    25025.64 *  -3.00%*    25831.20 *   0.12%*
> 
> If I read it as the lower the score the better, all the above results
> tell us that with-clamp is even better, while with-clamp-tskgrp
> is not that much worst.
> 

The figures are throughput to taking the first line

without-clamp		153.62
with-clamp		151.80 (worse, so the percentage difference is negative)
with-clamp-tskgrp	155.60 (better so the percentage different is positive)

> The other way around (the higher the score the better) would look odd
> since we definitively add in more code and complexity when uclamp has
> the TG support enabled we would not expect better scores.
> 

Netperf for small differences is very fickle as small differences in timing
or code layout can make a difference. Boot-to-boot variance can also be
an issue and bisection is generally unreliable. In this case, I relied on
the perf annotation and differences in ftrace function_graph to determine
that uclamp was introducing enough overhead to be considered a problem.

> > Hmean     recv-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> > Hmean     recv-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> > Hmean     recv-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> > Hmean     recv-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> > Hmean     recv-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.95 *   1.24%*
> > Hmean     recv-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> > Hmean     recv-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> > Hmean     recv-8192     14961.61 (   0.00%)    14418.88 *  -3.63%*    14908.30 *  -0.36%*
> > Hmean     recv-16384    25799.39 (   0.00%)    25025.49 *  -3.00%*    25831.00 *   0.12%*
> >
> > netperf-tcp
> >  
> > Hmean     64              818.65 (   0.00%)      812.98 *  -0.69%*      826.17 *   0.92%*
> > Hmean     128            1569.55 (   0.00%)     1555.79 *  -0.88%*     1586.94 *   1.11%*
> > Hmean     256            2952.86 (   0.00%)     2915.07 *  -1.28%*     2968.15 *   0.52%*
> > Hmean     1024          10425.91 (   0.00%)    10296.68 *  -1.24%*    10418.38 *  -0.07%*
> > Hmean     2048          17454.51 (   0.00%)    17369.57 *  -0.49%*    17419.24 *  -0.20%*
> > Hmean     3312          22509.95 (   0.00%)    22229.69 *  -1.25%*    22373.32 *  -0.61%*
> > Hmean     4096          25033.23 (   0.00%)    24859.59 *  -0.69%*    24912.50 *  -0.48%*
> > Hmean     8192          32080.51 (   0.00%)    31744.51 *  -1.05%*    31800.45 *  -0.87%*
> > Hmean     16384         36531.86 (   0.00%)    37064.68 *   1.46%*    37397.71 *   2.37%*
> >
> > The diffs are smaller than on openSUSE Leap 15.1 and some of the
> > uclamp taskgroup results are better?
> >
> > With this test setup we now can play with the uclamp code in
> > enqueue_task() and dequeue_task().
> >
> > ---
> >
> > W/ config-network-netperf-unbound (only netperf-udp and buffer size 64):
> >
> > $ perf diff 5.7.0-rc7_without-clamp/perf.data 5.7.0-rc7_with-clamp/perf.data | grep activate_task
> >
> > # Event 'cycles:ppp'
> > #
> > # Baseline  Delta Abs  Shared Object            Symbol
> >
> >      0.02%     +0.54%  [kernel.vmlinux]         [k] activate_task
> >      0.02%     +0.38%  [kernel.vmlinux]         [k] deactivate_task
> >
> > $ perf diff 5.7.0-rc7_without-clamp/perf.data 5.7.0-rc7_with-clamp-tskgrp/perf.data | grep activate_task
> >
> >      0.02%     +0.35%  [kernel.vmlinux]         [k] activate_task
> >      0.02%     +0.34%  [kernel.vmlinux]         [k] deactivate_task
> 
> These data makes more sense to me, AFAIR we measured <1% impact in the
> wakeup path using cycletest.
> 

1% doesn't sound like a lot but UDP_STREAM is an example of a load with
a *lot* of wakeups so even though the impact on each individual wakeup
is small, it builds up.

> I would also suggest to always report the overheads for 
>   __update_load_avg_cfs_rq()
> as a reference point. We use that code quite a lot in the wakeup path
> and it's a good proxy for relative comparisons.
> 
> 
> > I still see 20 out of 90 tests with the warning message that the
> > desired confidence was not achieved though.
> 
> Where the 90 comes from? From the above table we run 9 sizes for
> {udp-send, udp-recv, tcp} and 3 kernels. Should not give us 81 results?
> 
> Maybe the Warning are generated only when a test has to be repeated?

The warning is issued when it could not get a reliable result within the
iterations allowed.

> > "
> > !!! WARNING
> > !!! Desired confidence was not achieved within the specified iterations.
> > !!! This implies that there was variability in the test environment that
> > !!! must be investigated before going further.
> > !!! Confidence intervals: Throughput      : 6.727% <-- more than 5% !!!
> > !!!                       Local CPU util  : 0.000%
> > !!!                       Remote CPU util : 0.000%
> > "
> >
> > mmtests seems to run netperf with the following '-I' and 'i' parameter
> > hardcoded: 'netperf -t UDP_STREAM -i 3,3 -I 95,5' 
> 
> This means that we compute a score's (average +-2.5%) with a 95% confidence.
> 
> Does not that means that every +-2.5% difference in the results
> above should be considered in the noise?
> 

Usually yes but the impact is small enough to be within noise but
still detectable. Where we get hurt is when there are multiple problems
introduced where each contribute overhead that is within the noise but when
all added together there is a regression outside the noise. Uclamp is not
special in this respect, it just happens to be the current focus.  We met
this type of problem before with PSI that was resolved by e0c274472d5d
("psi: make disabling/enabling easier for vendor kernels").

> I would say that it could be useful to run with more iterations
> and, given the small numbers we are looking at (apparently we are
> scared by a 1% overhead), we should better use a more aggressive CI.
> 
> What about something like:
> 
>    netperf -t UDP_STREAM -i 3,30 -I 99,1
> 
> ?
> 

You could but the runtime of netperf will be variable, it will not be
guaranteed to give consistent results and it may mask the true variability
of the workload. While we could debate which is a valid approach, I
think it makes sense to minimise the overhead of uclamp when it's not
configured even if that means putting it behind a static branch that is
enabled via a command-line parameter or a Kconfig that specifies whether
it's on or off by default.

-- 
Mel Gorman
SUSE Labs
