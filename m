Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A5B1ED2DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgFCO7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFCO7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:59:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D0C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2020 07:59:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so3094086ljh.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2020 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3gULNc5o6rDWFlyFYtI7qphk+pGj3+0r/jIrUq0xCg=;
        b=kjWK618BvweQ6tbdxhKUdH3+E3jEV3i2X3hL3t3KPt8TtrOS7Dpy72DTP0xDdQrDCG
         np00IKlPluZEp7slLTcE/05nUU15vi+h7PSNwxitCV6YMJPLXDzAnWpaOEx4azPnF1ye
         5GJ0sD+izd0JEmY4+DOOwY/vtGy7wlrBc3PzmHGM0Diz+u1Q1rP3Rgydi3IBzUeKdzJr
         H3QnjUC1ooFXv79Tnq9eRzR1qu9dDr9IPm9pI5uqTgeZgVtcYvCvQpqYMc3UbBe3k3/M
         ZCpmsVgeek0ueEQTJmDipKDkLgFz2G/JGJFqNeBOypkgNn1l3t407VUrtpmdtF4o7DSr
         g90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3gULNc5o6rDWFlyFYtI7qphk+pGj3+0r/jIrUq0xCg=;
        b=S7nc3CUMxGoaDovo9nuwXDCckxeQXw2EVAFtLmBSXVCg6JF95mhHSfgMOgco1TX1mS
         2JT/2KzTiuIJH+Ol9jiioL809Qo9c4aBUtaa9lTIm3Wp8aAJlq4HYAnfztHt4+l708ET
         zxEK44Boy7YzDMYxx7DTYnLY6yZE71G57ujD8P086c02v3iu7qA36yvKJVsbUa9zVi/w
         i77VgWqufT6tiPTUZMWebfhesyHVb2WNyi/w/WZE5KIcDJ3qfJ+5r78KRt5Eseovv9iM
         3ai/xQ1dsTY4BP4s0xitz1rNlhoN88tpxMb+vUml++QYfI6nXBbC5rnEcLVTwZE2jy63
         Yjug==
X-Gm-Message-State: AOAM53289UVkQIjFPVCrlLe7eTcLO62eYmT12iVReHzdcJyKMAVIiqsl
        47VK1/68uuN9nghc1XM9G0LIS8fKkms82TZga4cyYQ==
X-Google-Smtp-Source: ABdhPJwLZn/G+w0RRGpk174MhHzR9IiVw4lvU3596knATh5HEXTsFJAT5vymUluEm4CL6dTS+rZDSnIIW1hhcbY2EyY=
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr2329628ljp.177.1591196353337;
 Wed, 03 Jun 2020 07:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200511154053.7822-1-qais.yousef@arm.com> <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com> <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de>
In-Reply-To: <20200603101022.GG3070@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 3 Jun 2020 16:59:00 +0200
Message-ID: <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Mel Gorman <mgorman@suse.de>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 Jun 2020 at 12:10, Mel Gorman <mgorman@suse.de> wrote:
>
> On Wed, Jun 03, 2020 at 10:29:22AM +0200, Patrick Bellasi wrote:
> >
> > Hi Dietmar,
> > thanks for sharing these numbers.
> >
> > On Tue, Jun 02, 2020 at 18:46:00 +0200, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote...
> >
> > [...]
> >
> > > I ran these tests on 'Ubuntu 18.04 Desktop' on Intel E5-2690 v2
> > > (2 sockets * 10 cores * 2 threads) with powersave governor as:
> > >
> > > $ numactl -N 0 ./run-mmtests.sh XXX
> >
> > Great setup, it's worth to rule out all possible noise source (freq
> > scaling, thermal throttling, NUMA scheduler, etc.).
>
> config-network-netperf-cross-socket will do the binding of the server
> and client to two CPUs that are on one socket. However, it does not take
> care to avoid HT siblings although that could be implemented. The same
> configuration should limit the CPU to C1. It does not change the governor
> but all that would take is adding "cpupower frequency-set -g performance"
> to the end of the configuration.
>
> > Wondering if disabling HT can also help here in reducing results "noise"?
> >
> > > w/ config-network-netperf-unbound.
> > >
> > > Running w/o 'numactl -N 0' gives slightly worse results.
> > >
> > > without-clamp      : CONFIG_UCLAMP_TASK is not set
> > > with-clamp         : CONFIG_UCLAMP_TASK=y,
> > >                      CONFIG_UCLAMP_TASK_GROUP is not set
> > > with-clamp-tskgrp  : CONFIG_UCLAMP_TASK=y,
> > >                      CONFIG_UCLAMP_TASK_GROUP=y
> > >
> > >
> > > netperf-udp
> > >                                 ./5.7.0-rc7            ./5.7.0-rc7            ./5.7.0-rc7
> > >                               without-clamp             with-clamp      with-clamp-tskgrp
> >
> > Can you please specify how to read the following scores? I give it a run
> > to my local netperf and it reports Throughput, thous I would expect the
> > higher the better... but... this seems something different.
> >
> > > Hmean     send-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> > > Hmean     send-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> > > Hmean     send-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> > > Hmean     send-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> > > Hmean     send-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.96 *   1.24%*
> > > Hmean     send-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> > > Hmean     send-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> > > Hmean     send-8192     14961.77 (   0.00%)    14418.92 *  -3.63%*    14908.36 *  -0.36%*
> > > Hmean     send-16384    25799.50 (   0.00%)    25025.64 *  -3.00%*    25831.20 *   0.12%*
> >
> > If I read it as the lower the score the better, all the above results
> > tell us that with-clamp is even better, while with-clamp-tskgrp
> > is not that much worst.
> >
>
> The figures are throughput to taking the first line
>
> without-clamp           153.62
> with-clamp              151.80 (worse, so the percentage difference is negative)
> with-clamp-tskgrp       155.60 (better so the percentage different is positive)
>
> > The other way around (the higher the score the better) would look odd
> > since we definitively add in more code and complexity when uclamp has
> > the TG support enabled we would not expect better scores.
> >
>
> Netperf for small differences is very fickle as small differences in timing
> or code layout can make a difference. Boot-to-boot variance can also be
> an issue and bisection is generally unreliable. In this case, I relied on
> the perf annotation and differences in ftrace function_graph to determine
> that uclamp was introducing enough overhead to be considered a problem.

When I want to stress the fast path i usually use "perf bench sched pipe -T "
The tip/sched/core on my arm octo core gives the following results for
20 iterations of perf bench sched pipe -T -l 50000

all uclamp config disabled  50035.4(+/- 0.334%)
all uclamp config enabled  48749.8(+/- 0.339%)   -2.64%

It's quite easy to reproduce and probably easier to study the impact

>
> > > Hmean     recv-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> > > Hmean     recv-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> > > Hmean     recv-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> > > Hmean     recv-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> > > Hmean     recv-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.95 *   1.24%*
> > > Hmean     recv-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> > > Hmean     recv-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> > > Hmean     recv-8192     14961.61 (   0.00%)    14418.88 *  -3.63%*    14908.30 *  -0.36%*
> > > Hmean     recv-16384    25799.39 (   0.00%)    25025.49 *  -3.00%*    25831.00 *   0.12%*
> > >
> > > netperf-tcp
> > >
> > > Hmean     64              818.65 (   0.00%)      812.98 *  -0.69%*      826.17 *   0.92%*
> > > Hmean     128            1569.55 (   0.00%)     1555.79 *  -0.88%*     1586.94 *   1.11%*
> > > Hmean     256            2952.86 (   0.00%)     2915.07 *  -1.28%*     2968.15 *   0.52%*
> > > Hmean     1024          10425.91 (   0.00%)    10296.68 *  -1.24%*    10418.38 *  -0.07%*
> > > Hmean     2048          17454.51 (   0.00%)    17369.57 *  -0.49%*    17419.24 *  -0.20%*
> > > Hmean     3312          22509.95 (   0.00%)    22229.69 *  -1.25%*    22373.32 *  -0.61%*
> > > Hmean     4096          25033.23 (   0.00%)    24859.59 *  -0.69%*    24912.50 *  -0.48%*
> > > Hmean     8192          32080.51 (   0.00%)    31744.51 *  -1.05%*    31800.45 *  -0.87%*
> > > Hmean     16384         36531.86 (   0.00%)    37064.68 *   1.46%*    37397.71 *   2.37%*
> > >
> > > The diffs are smaller than on openSUSE Leap 15.1 and some of the
> > > uclamp taskgroup results are better?
> > >
> > > With this test setup we now can play with the uclamp code in
> > > enqueue_task() and dequeue_task().
> > >
> > > ---
> > >
> > > W/ config-network-netperf-unbound (only netperf-udp and buffer size 64):
> > >
> > > $ perf diff 5.7.0-rc7_without-clamp/perf.data 5.7.0-rc7_with-clamp/perf.data | grep activate_task
> > >
> > > # Event 'cycles:ppp'
> > > #
> > > # Baseline  Delta Abs  Shared Object            Symbol
> > >
> > >      0.02%     +0.54%  [kernel.vmlinux]         [k] activate_task
> > >      0.02%     +0.38%  [kernel.vmlinux]         [k] deactivate_task
> > >
> > > $ perf diff 5.7.0-rc7_without-clamp/perf.data 5.7.0-rc7_with-clamp-tskgrp/perf.data | grep activate_task
> > >
> > >      0.02%     +0.35%  [kernel.vmlinux]         [k] activate_task
> > >      0.02%     +0.34%  [kernel.vmlinux]         [k] deactivate_task
> >
> > These data makes more sense to me, AFAIR we measured <1% impact in the
> > wakeup path using cycletest.
> >
>
> 1% doesn't sound like a lot but UDP_STREAM is an example of a load with
> a *lot* of wakeups so even though the impact on each individual wakeup
> is small, it builds up.
>
> > I would also suggest to always report the overheads for
> >   __update_load_avg_cfs_rq()
> > as a reference point. We use that code quite a lot in the wakeup path
> > and it's a good proxy for relative comparisons.
> >
> >
> > > I still see 20 out of 90 tests with the warning message that the
> > > desired confidence was not achieved though.
> >
> > Where the 90 comes from? From the above table we run 9 sizes for
> > {udp-send, udp-recv, tcp} and 3 kernels. Should not give us 81 results?
> >
> > Maybe the Warning are generated only when a test has to be repeated?
>
> The warning is issued when it could not get a reliable result within the
> iterations allowed.
>
> > > "
> > > !!! WARNING
> > > !!! Desired confidence was not achieved within the specified iterations.
> > > !!! This implies that there was variability in the test environment that
> > > !!! must be investigated before going further.
> > > !!! Confidence intervals: Throughput      : 6.727% <-- more than 5% !!!
> > > !!!                       Local CPU util  : 0.000%
> > > !!!                       Remote CPU util : 0.000%
> > > "
> > >
> > > mmtests seems to run netperf with the following '-I' and 'i' parameter
> > > hardcoded: 'netperf -t UDP_STREAM -i 3,3 -I 95,5'
> >
> > This means that we compute a score's (average +-2.5%) with a 95% confidence.
> >
> > Does not that means that every +-2.5% difference in the results
> > above should be considered in the noise?
> >
>
> Usually yes but the impact is small enough to be within noise but
> still detectable. Where we get hurt is when there are multiple problems
> introduced where each contribute overhead that is within the noise but when
> all added together there is a regression outside the noise. Uclamp is not
> special in this respect, it just happens to be the current focus.  We met
> this type of problem before with PSI that was resolved by e0c274472d5d
> ("psi: make disabling/enabling easier for vendor kernels").
>
> > I would say that it could be useful to run with more iterations
> > and, given the small numbers we are looking at (apparently we are
> > scared by a 1% overhead), we should better use a more aggressive CI.
> >
> > What about something like:
> >
> >    netperf -t UDP_STREAM -i 3,30 -I 99,1
> >
> > ?
> >
>
> You could but the runtime of netperf will be variable, it will not be
> guaranteed to give consistent results and it may mask the true variability
> of the workload. While we could debate which is a valid approach, I
> think it makes sense to minimise the overhead of uclamp when it's not
> configured even if that means putting it behind a static branch that is
> enabled via a command-line parameter or a Kconfig that specifies whether
> it's on or off by default.
>
> --
> Mel Gorman
> SUSE Labs
