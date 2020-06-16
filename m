Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D11FAEEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgFPLIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 07:08:34 -0400
Received: from foss.arm.com ([217.140.110.172]:35570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgFPLIc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:08:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B10B1F1;
        Tue, 16 Jun 2020 04:08:31 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950D83F6CF;
        Tue, 16 Jun 2020 04:08:28 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:08:26 +0100
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
        linux-fsdevel@vger.kernel.org, chris.redpath@arm.com,
        lukasz.luba@arm.com
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200616110824.dgkkbyapn3io6wik@e107158-lin>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <20200603094036.GF3070@suse.de>
 <20200603124112.w5stb7v2z3kzcze3@e107158-lin.cambridge.arm.com>
 <20200604134042.GJ3070@suse.de>
 <20200611105811.5q5rga2cmy6ypq7e@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200611105811.5q5rga2cmy6ypq7e@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/11/20 11:58, Qais Yousef wrote:

[...]

> 
>                                     nouclam               nouclamp                  uclam                 uclamp         uclamp.disable                 uclamp                 uclamp                 uclamp
>                                    nouclamp              recompile                 uclamp                uclamp2        uclamp.disabled                    opt                   opt2           opt.disabled
> Hmean     send-64         158.07 (   0.00%)      156.99 *  -0.68%*      163.83 *   3.65%*      160.97 *   1.83%*      163.93 *   3.71%*      159.62 *   0.98%*      161.79 *   2.36%*      161.14 *   1.94%*
> Hmean     send-128        314.86 (   0.00%)      314.41 *  -0.14%*      329.05 *   4.51%*      322.88 *   2.55%*      327.88 *   4.14%*      317.56 *   0.86%*      320.72 *   1.86%*      319.62 *   1.51%*
> Hmean     send-256        629.98 (   0.00%)      625.78 *  -0.67%*      652.67 *   3.60%*      639.98 *   1.59%*      643.99 *   2.22%*      631.96 *   0.31%*      635.75 *   0.92%*      644.10 *   2.24%*
> Hmean     send-1024      2465.04 (   0.00%)     2452.29 *  -0.52%*     2554.66 *   3.64%*     2509.60 *   1.81%*     2540.71 *   3.07%*     2495.82 *   1.25%*     2490.50 *   1.03%*     2509.86 *   1.82%*
> Hmean     send-2048      4717.57 (   0.00%)     4713.17 *  -0.09%*     4923.98 *   4.38%*     4811.01 *   1.98%*     4881.87 *   3.48%*     4793.82 *   1.62%*     4820.28 *   2.18%*     4824.60 *   2.27%*
> Hmean     send-3312      7412.33 (   0.00%)     7433.42 *   0.28%*     7717.76 *   4.12%*     7522.97 *   1.49%*     7620.99 *   2.82%*     7522.89 *   1.49%*     7614.51 *   2.73%*     7568.51 *   2.11%*
> Hmean     send-4096      9021.55 (   0.00%)     8988.71 *  -0.36%*     9337.62 *   3.50%*     9075.49 *   0.60%*     9258.34 *   2.62%*     9117.17 *   1.06%*     9175.85 *   1.71%*     9079.50 *   0.64%*
> Hmean     send-8192     15370.36 (   0.00%)    15467.63 *   0.63%*    15999.52 *   4.09%*    15467.80 *   0.63%*    15978.69 *   3.96%*    15619.84 *   1.62%*    15395.09 *   0.16%*    15779.73 *   2.66%*
> Hmean     send-16384    26512.35 (   0.00%)    26498.18 *  -0.05%*    26931.86 *   1.58%*    26513.18 *   0.00%*    26873.98 *   1.36%*    26456.38 *  -0.21%*    26467.77 *  -0.17%*    26975.04 *   1.75%*

I have attempted a few other things after this.

As pointed out above, with 5.7-rc7 I can't see a regression.

The machine I'm testing on is 2 Sockets Xeon E5 2x10-Cores (40 CPUs).

If I switch to 5.6, I can see a drop (performed each run twice)

                                   nouclamp              nouclamp2                 uclamp                uclamp2
Hmean     send-64         162.43 (   0.00%)      161.46 *  -0.60%*      157.84 *  -2.82%*      158.11 *  -2.66%*
Hmean     send-128        324.71 (   0.00%)      323.88 *  -0.25%*      314.78 *  -3.06%*      314.94 *  -3.01%*
Hmean     send-256        641.55 (   0.00%)      640.22 *  -0.21%*      628.67 *  -2.01%*      631.79 *  -1.52%*
Hmean     send-1024      2525.28 (   0.00%)     2520.31 *  -0.20%*     2448.26 *  -3.05%*     2497.15 *  -1.11%*
Hmean     send-2048      4836.14 (   0.00%)     4827.47 *  -0.18%*     4712.08 *  -2.57%*     4757.70 *  -1.62%*
Hmean     send-3312      7540.83 (   0.00%)     7603.14 *   0.83%*     7425.45 *  -1.53%*     7499.87 *  -0.54%*
Hmean     send-4096      9124.53 (   0.00%)     9224.90 *   1.10%*     8948.82 *  -1.93%*     9087.20 *  -0.41%*
Hmean     send-8192     15589.67 (   0.00%)    15768.82 *   1.15%*    15486.35 *  -0.66%*    15594.53 *   0.03%*
Hmean     send-16384    26386.47 (   0.00%)    26683.64 *   1.13%*    25752.25 *  -2.40%*    26609.64 *   0.85%*

If I apply the 2 patches from my previous email, with uclamp enabled I see

                                   nouclamp              nouclamp2             uclamp-opt            uclamp-opt2
Hmean     send-64         162.43 (   0.00%)      161.46 *  -0.60%*      159.84 *  -1.60%*      160.79 *  -1.01%*
Hmean     send-128        324.71 (   0.00%)      323.88 *  -0.25%*      318.44 *  -1.93%*      321.88 *  -0.87%*
Hmean     send-256        641.55 (   0.00%)      640.22 *  -0.21%*      633.54 *  -1.25%*      640.43 *  -0.17%*
Hmean     send-1024      2525.28 (   0.00%)     2520.31 *  -0.20%*     2497.47 *  -1.10%*     2522.00 *  -0.13%*
Hmean     send-2048      4836.14 (   0.00%)     4827.47 *  -0.18%*     4773.63 *  -1.29%*     4825.31 *  -0.22%*
Hmean     send-3312      7540.83 (   0.00%)     7603.14 *   0.83%*     7512.92 *  -0.37%*     7482.66 *  -0.77%*
Hmean     send-4096      9124.53 (   0.00%)     9224.90 *   1.10%*     9076.62 *  -0.52%*     9175.58 *   0.56%*
Hmean     send-8192     15589.67 (   0.00%)    15768.82 *   1.15%*    15466.02 *  -0.79%*    15792.10 *   1.30%*
Hmean     send-16384    26386.47 (   0.00%)    26683.64 *   1.13%*    26234.79 *  -0.57%*    26459.95 *   0.28%*

Which shows that on this machine, the system is slowed down due to bad D$
behavior on access to rq->uclamp[].bucket[] and p->uclamp{_rq}[].

If I disable uclamp using the static key I get

                                   nouclamp              nouclamp2    uclamp-opt.disabled   uclamp-opt.disabled2
Hmean     send-64         162.43 (   0.00%)      161.46 *  -0.60%*      161.21 *  -0.75%*      161.05 *  -0.85%*
Hmean     send-128        324.71 (   0.00%)      323.88 *  -0.25%*      321.09 *  -1.11%*      319.72 *  -1.54%*
Hmean     send-256        641.55 (   0.00%)      640.22 *  -0.21%*      637.37 *  -0.65%*      637.82 *  -0.58%*
Hmean     send-1024      2525.28 (   0.00%)     2520.31 *  -0.20%*     2510.07 *  -0.60%*     2504.99 *  -0.80%*
Hmean     send-2048      4836.14 (   0.00%)     4827.47 *  -0.18%*     4795.29 *  -0.84%*     4788.99 *  -0.97%*
Hmean     send-3312      7540.83 (   0.00%)     7603.14 *   0.83%*     7490.27 *  -0.67%*     7498.56 *  -0.56%*
Hmean     send-4096      9124.53 (   0.00%)     9224.90 *   1.10%*     9108.73 *  -0.17%*     9196.45 *   0.79%*
Hmean     send-8192     15589.67 (   0.00%)    15768.82 *   1.15%*    15649.50 *   0.38%*    16101.68 *   3.28%*
Hmean     send-16384    26386.47 (   0.00%)    26683.64 *   1.13%*    26435.38 *   0.19%*    27199.11 *   3.08%*

I decided after this to see if this failure is observed all the way until
5.7-rc7.

For 5.7-rc1 I get (comparing against 5.6-nouclamp)

                                   nouclamp              nouclamp2                 uclamp                uclamp2
Hmean     send-64         162.43 (   0.00%)      161.46 *  -0.60%*      155.56 *  -4.23%*      156.72 *  -3.52%*
Hmean     send-128        324.71 (   0.00%)      323.88 *  -0.25%*      311.68 *  -4.01%*      312.63 *  -3.72%*
Hmean     send-256        641.55 (   0.00%)      640.22 *  -0.21%*      616.03 *  -3.98%*      620.83 *  -3.23%*
Hmean     send-1024      2525.28 (   0.00%)     2520.31 *  -0.20%*     2441.92 *  -3.30%*     2433.83 *  -3.62%*
Hmean     send-2048      4836.14 (   0.00%)     4827.47 *  -0.18%*     4698.42 *  -2.85%*     4682.22 *  -3.18%*
Hmean     send-3312      7540.83 (   0.00%)     7603.14 *   0.83%*     7379.37 *  -2.14%*     7354.82 *  -2.47%*
Hmean     send-4096      9124.53 (   0.00%)     9224.90 *   1.10%*     8797.21 *  -3.59%*     8815.65 *  -3.39%*
Hmean     send-8192     15589.67 (   0.00%)    15768.82 *   1.15%*    15009.19 *  -3.72%*    15065.16 *  -3.36%*
Hmean     send-16384    26386.47 (   0.00%)    26683.64 *   1.13%*    25829.20 *  -2.11%*    25783.17 *  -2.29%*

For 5.7-rc2, the overhead disappears again (against 5.6-nouclamp)

                                   nouclamp              nouclamp2                 uclamp                uclamp2
Hmean     send-64         162.43 (   0.00%)      161.46 *  -0.60%*      162.97 *   0.34%*      163.31 *   0.54%*
Hmean     send-128        324.71 (   0.00%)      323.88 *  -0.25%*      323.94 *  -0.24%*      325.74 *   0.32%*
Hmean     send-256        641.55 (   0.00%)      640.22 *  -0.21%*      641.82 *   0.04%*      645.11 *   0.56%*
Hmean     send-1024      2525.28 (   0.00%)     2520.31 *  -0.20%*     2522.74 *  -0.10%*     2535.63 *   0.41%*
Hmean     send-2048      4836.14 (   0.00%)     4827.47 *  -0.18%*     4836.74 *   0.01%*     4838.62 *   0.05%*
Hmean     send-3312      7540.83 (   0.00%)     7603.14 *   0.83%*     7635.31 *   1.25%*     7613.91 *   0.97%*
Hmean     send-4096      9124.53 (   0.00%)     9224.90 *   1.10%*     9198.58 *   0.81%*     9161.53 *   0.41%*
Hmean     send-8192     15589.67 (   0.00%)    15768.82 *   1.15%*    15804.47 *   1.38%*    15755.91 *   1.07%*
Hmean     send-16384    26386.47 (   0.00%)    26683.64 *   1.13%*    26649.29 *   1.00%*    26677.46 *   1.10%*

I stopped here tbh. I thought maybe numa scheduling is making the uclamp
accesses more expensive in certain patterns, so I tried with numactl -N 0
(using 5.7-rc1)

                                   nouclamp              nouclamp2            uclamp-N0-1            uclamp-N0-2
Hmean     send-64         162.43 (   0.00%)      161.46 *  -0.60%*      156.26 *  -3.80%*      156.00 *  -3.96%*
Hmean     send-128        324.71 (   0.00%)      323.88 *  -0.25%*      312.20 *  -3.85%*      312.94 *  -3.63%*
Hmean     send-256        641.55 (   0.00%)      640.22 *  -0.21%*      620.29 *  -3.31%*      619.25 *  -3.48%*
Hmean     send-1024      2525.28 (   0.00%)     2520.31 *  -0.20%*     2437.59 *  -3.47%*     2433.94 *  -3.62%*
Hmean     send-2048      4836.14 (   0.00%)     4827.47 *  -0.18%*     4671.28 *  -3.41%*     4714.49 *  -2.52%*
Hmean     send-3312      7540.83 (   0.00%)     7603.14 *   0.83%*     7355.86 *  -2.45%*     7387.51 *  -2.03%*
Hmean     send-4096      9124.53 (   0.00%)     9224.90 *   1.10%*     8793.02 *  -3.63%*     8883.88 *  -2.64%*
Hmean     send-8192     15589.67 (   0.00%)    15768.82 *   1.15%*    14898.76 *  -4.43%*    14958.19 *  -4.05%*
Hmean     send-16384    26386.47 (   0.00%)    26683.64 *   1.13%*    25745.40 *  -2.43%*    25800.01 *  -2.22%*

And it had no effect. Interesting Lukasz can see an improvement if he tries
something similar on his machine.

Did we have any previous history of code/data layout affecting the performance
of the hot path in the past? On the juno board (octa core big.LITTLE arm
paltform), I could make the overhead disappear with a simple code shuffle (for
perf bench sched pipe).

I have tried putting the rq->uclamp[].bucket[] structures into their own PERCPU
variable since the rq is read by many cpus and thought that might lead to bad
cache patterns since uclamp are mostly read by the owning cpus, but no luck
with this approach.

I am working on a proper static key patch now that disables uclamp by default
and only enables it if the userspace attemps to modify any of the knobs it
provides, then we switch it on and keep it on. Testing it at the moment.

Thanks

--
Qais Yousef
