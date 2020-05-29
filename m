Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC321E7A10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgE2KIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 06:08:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2KIQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 06:08:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2A66BAC2D;
        Fri, 29 May 2020 10:08:13 +0000 (UTC)
Date:   Fri, 29 May 2020 11:08:06 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <20200529100806.GA3070@suse.de>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200528161112.GI2483@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 06:11:12PM +0200, Peter Zijlstra wrote:
> > FWIW, I think you're referring to Mel's notice in OSPM regarding the overhead.
> > Trying to see what goes on in there.
> 
> Indeed, that one. The fact that regular distros cannot enable this
> feature due to performance overhead is unfortunate. It means there is a
> lot less potential for this stuff.

During that talk, I was a vague about the cost, admitted I had not looked
too closely at mainline performance and had since deleted the data given
that the problem was first spotted in early April. If I heard someone
else making statements like I did at the talk, I would consider it a bit
vague, potentially FUD, possibly wrong and worth rechecking myself. In
terms of distributions "cannot enable this", we could but I was unwilling
to pay the cost for a feature no one has asked for yet. If they had, I
would endevour to put it behind static branches and disable it by default
(like what happened for PSI). I was contacted offlist about my comments
at OSPM and gathered new data to respond properly. For the record, here
is an editted version of my response;

--8<--

(Some context deleted that is not relevant)

> Does it need any special admin configuration for system
> services, cgroups, scripts, etc?

Nothing special -- out of box configuration. Tests were executed via
mmtests.

> Which mmtests config file did you use?
> 

I used network-netperf-unbound and network-netperf-cstate.
network-netperf-unbound is usually the default but for some issues, I
use the cstate configuration to limit C-states.

For a perf profile, I used network-netperf-cstate-small and
network-netperf-unbound-small to limit the amount of profile data that
was collected. Just collecting data for 64 byte buffers was enough.

> The server that I am going to configure is x86_64 numa, not arm64.

That's fine, I didn't actually test arm64 at all.

> I have a 2 socket 24 CPUs X86 server (4 NUMA nodes, AMD Opteron 6174,
> L2 512KB/cpu, L3 6MB/node, RAM 40GB/node).
> Which machine did you run it on?
> 

It was a 2-socket Haswell machine (E5-2670 v3) with 2 NUMA nodes. I used
5.7-rc7 with the openSUSE Leap 15.1 kernel configuration as a baseline.
I compared with and without uclamp enabled.

For network-netperf-unbound I see

netperf-udp
                                  5.7.0-rc7              5.7.0-rc7
                                 with-clamp          without-clamp
Hmean     send-64         238.52 (   0.00%)      257.28 *   7.87%*
Hmean     send-128        477.10 (   0.00%)      511.57 *   7.23%*
Hmean     send-256        945.53 (   0.00%)      982.50 *   3.91%*
Hmean     send-1024      3655.74 (   0.00%)     3846.98 *   5.23%*
Hmean     send-2048      6926.84 (   0.00%)     7247.04 *   4.62%*
Hmean     send-3312     10767.47 (   0.00%)    10976.73 (   1.94%)
Hmean     send-4096     12821.77 (   0.00%)    13506.03 *   5.34%*
Hmean     send-8192     22037.72 (   0.00%)    22275.29 (   1.08%)
Hmean     send-16384    35935.31 (   0.00%)    34737.63 *  -3.33%*
Hmean     recv-64         238.52 (   0.00%)      257.28 *   7.87%*
Hmean     recv-128        477.10 (   0.00%)      511.57 *   7.23%*
Hmean     recv-256        945.45 (   0.00%)      982.50 *   3.92%*
Hmean     recv-1024      3655.74 (   0.00%)     3846.98 *   5.23%*
Hmean     recv-2048      6926.84 (   0.00%)     7246.51 *   4.62%*
Hmean     recv-3312     10767.47 (   0.00%)    10975.93 (   1.94%)
Hmean     recv-4096     12821.76 (   0.00%)    13506.02 *   5.34%*
Hmean     recv-8192     22037.71 (   0.00%)    22274.55 (   1.07%)
Hmean     recv-16384    35934.82 (   0.00%)    34737.50 *  -3.33%*

netperf-tcp
                             5.7.0-rc7              5.7.0-rc7
                            with-clamp          without-clamp
Min       64        2004.71 (   0.00%)     2033.23 (   1.42%)
Min       128       3657.58 (   0.00%)     3733.35 (   2.07%)
Min       256       6063.25 (   0.00%)     6105.67 (   0.70%)
Min       1024     18152.50 (   0.00%)    18487.00 (   1.84%)
Min       2048     28544.54 (   0.00%)    29218.11 (   2.36%)
Min       3312     33962.06 (   0.00%)    36094.97 (   6.28%)
Min       4096     36234.82 (   0.00%)    38223.60 (   5.49%)
Min       8192     42324.06 (   0.00%)    43328.72 (   2.37%)
Min       16384    44323.33 (   0.00%)    45315.21 (   2.24%)
Hmean     64        2018.36 (   0.00%)     2038.53 *   1.00%*
Hmean     128       3700.12 (   0.00%)     3758.20 *   1.57%*
Hmean     256       6236.14 (   0.00%)     6212.77 (  -0.37%)
Hmean     1024     18214.97 (   0.00%)    18601.01 *   2.12%*
Hmean     2048     28749.56 (   0.00%)    29728.26 *   3.40%*
Hmean     3312     34585.50 (   0.00%)    36345.09 *   5.09%*
Hmean     4096     36777.62 (   0.00%)    38576.17 *   4.89%*
Hmean     8192     43149.08 (   0.00%)    43903.77 *   1.75%*
Hmean     16384    45478.27 (   0.00%)    46372.93 (   1.97%)

The cstate-limited config had similar results for UDP_STREAM but was
mostly indifferent for TCP_STREAM.

So for UDP_STREAM,. there is a fairly sizable difference for uclamp. There
are caveats, netperf is not 100% stable from a performance perspective on
NUMA machines. That's improved quite a bit with 5.7 but it still should
be treated with care.

When I first saw a problem, I was using ftrace looking for latencies and
uclamp appeared to crop up. As I didn't actually need uclamp and there was
no user request to support it, I simply dropped it from the master config
so it would get propogated to any distro we release with a 5.x kernel.

From a perf profile, it's not particularly obvious that uclamp is
involved so it could be in error but I doubt it. A diff of without vs
with looks like

# Event 'cycles:ppp'
#
# Baseline  Delta Abs  Shared Object             Symbol
# ........  .........  ........................  ..............................................
#
     9.59%     -2.87%  [kernel.vmlinux]          [k] poll_idle
     0.19%     +1.85%  [kernel.vmlinux]          [k] activate_task
               +1.17%  [kernel.vmlinux]          [k] dequeue_task
               +0.89%  [kernel.vmlinux]          [k] update_rq_clock.part.73
     3.88%     +0.73%  [kernel.vmlinux]          [k] try_to_wake_up
     3.17%     +0.68%  [kernel.vmlinux]          [k] __schedule
     1.16%     -0.60%  [kernel.vmlinux]          [k] __update_load_avg_cfs_rq
     2.20%     -0.54%  [kernel.vmlinux]          [k] resched_curr
     2.08%     -0.29%  [kernel.vmlinux]          [k] _raw_spin_lock_irqsave
     0.44%     -0.29%  [kernel.vmlinux]          [k] cpus_share_cache
     1.13%     +0.23%  [kernel.vmlinux]          [k] _raw_spin_lock_bh

A lot of the uclamp functions appear to be inlined so it is not be
particularly obvious from a raw profile but it shows up in the annotated
profile in activate_task and dequeue_task for example. In the case of
dequeue_task, uclamp_rq_dec_id() is extremely expensive according to the
annotated profile.

I'm afraid I did not dig into this deeply once I knew I could just disable
it even within the distribution.

-- 
Mel Gorman
SUSE Labs
