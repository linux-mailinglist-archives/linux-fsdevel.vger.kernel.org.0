Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E051ECFFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgFCMlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 08:41:19 -0400
Received: from foss.arm.com ([217.140.110.172]:32924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgFCMlT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:41:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2877B31B;
        Wed,  3 Jun 2020 05:41:18 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 719823F305;
        Wed,  3 Jun 2020 05:41:15 -0700 (PDT)
Date:   Wed, 3 Jun 2020 13:41:13 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200603124112.w5stb7v2z3kzcze3@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <20200603094036.GF3070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200603094036.GF3070@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/03/20 10:40, Mel Gorman wrote:
> On Tue, Jun 02, 2020 at 06:46:00PM +0200, Dietmar Eggemann wrote:
> > On 29.05.20 12:08, Mel Gorman wrote:
> > > On Thu, May 28, 2020 at 06:11:12PM +0200, Peter Zijlstra wrote:
> > >>> FWIW, I think you're referring to Mel's notice in OSPM regarding the overhead.
> > >>> Trying to see what goes on in there.
> > >>
> > >> Indeed, that one. The fact that regular distros cannot enable this
> > >> feature due to performance overhead is unfortunate. It means there is a
> > >> lot less potential for this stuff.
> > > 
> > > During that talk, I was a vague about the cost, admitted I had not looked
> > > too closely at mainline performance and had since deleted the data given
> > > that the problem was first spotted in early April. If I heard someone
> > > else making statements like I did at the talk, I would consider it a bit
> > > vague, potentially FUD, possibly wrong and worth rechecking myself. In
> > > terms of distributions "cannot enable this", we could but I was unwilling
> > > to pay the cost for a feature no one has asked for yet. If they had, I
> > > would endevour to put it behind static branches and disable it by default
> > > (like what happened for PSI). I was contacted offlist about my comments
> > > at OSPM and gathered new data to respond properly. For the record, here
> > > is an editted version of my response;
> > 
> > [...]
> > 
> > I ran these tests on 'Ubuntu 18.04 Desktop' on Intel E5-2690 v2
> > (2 sockets * 10 cores * 2 threads) with powersave governor as:
> > 
> > $ numactl -N 0 ./run-mmtests.sh XXX
> > 
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
> > 
> > Hmean     send-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> > Hmean     send-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> > Hmean     send-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> > Hmean     send-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> > Hmean     send-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.96 *   1.24%*
> > Hmean     send-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> > Hmean     send-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> > Hmean     send-8192     14961.77 (   0.00%)    14418.92 *  -3.63%*    14908.36 *  -0.36%*
> > Hmean     send-16384    25799.50 (   0.00%)    25025.64 *  -3.00%*    25831.20 *   0.12%*
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
> 
> I don't see the stddev and coeff but these look close to borderline.
> Sure, they are marked with a * so it passed a significant test but it's
> still a very marginal difference for netperf. It's possible that the
> systemd configurations differ in some way that is significant for uclamp
> but I don't know what that is.

Hmm so what you're saying is that Dietmar didn't reproduce the same problem
you're observing? I was hoping to use that to dig more into it.

> 
> > With this test setup we now can play with the uclamp code in
> > enqueue_task() and dequeue_task().
> > 
> 
> That is still true. An annotated perf profile should tell you if the
> uclamp code is being heavily used or if it's bailing early but it's also
> possible that uclamp overhead is not a big deal on your particular
> machine.
> 
> The possibility that either the distribution, the machine or both are
> critical for detecting a problem with uclamp may explain why any overhead
> was missed. Even if it is marginal, it still makes sense to minimise the
> amount of uclamp code that is executed if no limit is specified for tasks.

So one speculation I have that might be causing the problem is that the
accesses of struct uclamp_rq are causing bad cache behavior in your case. Your
mmtest description of the netperf says that it is sensitive to cacheline
bouncing.

Looking at struct rq, the uclamp_rq is spanning 2 cachelines

 29954         /* --- cacheline 1 boundary (64 bytes) --- */
 29955         struct uclamp_rq           uclamp[2];            /*    64    96 */
 29956         /* --- cacheline 2 boundary (128 bytes) was 32 bytes ago --- */
 29957         unsigned int               uclamp_flags;         /*   160     4 */
 29958
 29959         /* XXX 28 bytes hole, try to pack */
 29960

Reducing sturct uclamp_bucket to use unsigned int instead of unsigned long
helps putting it all in a single cacheline

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..63b5397a1708 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -833,8 +833,8 @@ extern void rto_push_irq_work_func(struct irq_work *work);
  * clamp value.
  */
 struct uclamp_bucket {
-       unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
-       unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
+       unsigned int value : bits_per(SCHED_CAPACITY_SCALE);
+       unsigned int tasks : 32 - bits_per(SCHED_CAPACITY_SCALE);
 };

 /*

 29954         /* --- cacheline 1 boundary (64 bytes) --- */
 29955         struct uclamp_rq           uclamp[2];            /*    64    48 */
 29956         unsigned int               uclamp_flags;         /*   112     4 */
 29957

Is it something worth experimenting with?

Thanks

--
Qais Yousef
