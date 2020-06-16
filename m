Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D391FB2F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 15:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgFPN4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 09:56:33 -0400
Received: from foss.arm.com ([217.140.110.172]:37990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbgFPN4Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:56:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5211B1FB;
        Tue, 16 Jun 2020 06:56:23 -0700 (PDT)
Received: from [10.37.12.69] (unknown [10.37.12.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C5F13F71F;
        Tue, 16 Jun 2020 06:56:18 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Qais Yousef <qais.yousef@arm.com>, Mel Gorman <mgorman@suse.de>
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
        linux-fsdevel@vger.kernel.org, chris.redpath@arm.com
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
 <20200616110824.dgkkbyapn3io6wik@e107158-lin>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <d9c951da-87eb-ab20-9434-f15b34096d66@arm.com>
Date:   Tue, 16 Jun 2020 14:56:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200616110824.dgkkbyapn3io6wik@e107158-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


[snip]

Hi Mel and Qais,

I was able to synthesize results from some experiments which I conducted
on my machine. You can find them below with descriptions.

1. Description of the configuration and hardware

My machine is a HP server 2 socket 24 CPUs X86 64bit
(4 NUMA nodes, AMD Opteron 6174, L2 512KB/cpu, L3 6MB/node, RAM 40GB/node).

Results presented here are coming from OpenSuse 15.1 (apart from last 
experiment) with kernel build based on the distro config.
Kernel tag v5.7-rc7.
There are 3 kernels that I have created based on distro config:
a) v5.7-rc7-base - default kernel build (no uclamp)
b) v5.7-rc7-ucl-tsk - base kernel + CONFIG_UCLAMP_TASK
c) v5.7-rc7-ucl-tsk-grp - base kernel + CONFIG_UCLAMP_TASK & 
CONFIG_UCLAMP_TASK_GROUP

2. Experiments

I have been using the mmtests with configuration as you recommended.
I put under stress the system in different scenarios, to check if some
regression can be observed and under what circumstances.
The descriptions below show these different angles of attacks during
mmtests: w/ or w/o numa pinning, using or not perf, tracing, etc.
I have also checked a bit closer to the suspected functions:
activate_task and deactivate_task, which you might find in the
experiment description.

2.1. Experiment with netperf and two kernels

These tests have been conducted without numactl force settings (all CPUs
allowed). As it can be seen the kernel with uclamp task has worse
performance for UDP, but somehow better for TCP.

UDP tests results:
netperf-udp
                           ./v5.7-rc7-base       ./v5.7-rc7-ucl-tsk
Hmean     send-64          62.15 (   0.00%)       59.65 *  -4.02%*
Hmean     send-128        122.88 (   0.00%)      119.37 *  -2.85%*
Hmean     send-256        244.85 (   0.00%)      234.26 *  -4.32%*
Hmean     send-1024       919.24 (   0.00%)      880.67 *  -4.20%*
Hmean     send-2048      1689.45 (   0.00%)     1647.54 *  -2.48%*
Hmean     send-3312      2542.36 (   0.00%)     2485.23 *  -2.25%*
Hmean     send-4096      2935.69 (   0.00%)     2861.09 *  -2.54%*
Hmean     send-8192      4800.35 (   0.00%)     4680.09 *  -2.51%*
Hmean     send-16384     7473.66 (   0.00%)     7349.60 *  -1.66%*
Hmean     recv-64          62.15 (   0.00%)       59.65 *  -4.03%*
Hmean     recv-128        122.88 (   0.00%)      119.37 *  -2.85%*
Hmean     recv-256        244.84 (   0.00%)      234.26 *  -4.32%*
Hmean     recv-1024       919.24 (   0.00%)      880.67 *  -4.20%*
Hmean     recv-2048      1689.44 (   0.00%)     1647.54 *  -2.48%*
Hmean     recv-3312      2542.36 (   0.00%)     2485.23 *  -2.25%*
Hmean     recv-4096      2935.69 (   0.00%)     2861.09 *  -2.54%*
Hmean     recv-8192      4800.35 (   0.00%)     4678.15 *  -2.55%*
Hmean     recv-16384     7473.63 (   0.00%)     7349.52 *  -1.66%*

TCP test results:
netperf-tcp
                        ./v5.7-rc7-base    ./v5.7-rc7-ucl-tsk
Hmean     64         756.44 (   0.00%)      881.17 *  16.49%*
Hmean     128       1425.09 (   0.00%)     1558.70 *   9.38%*
Hmean     256       2292.65 (   0.00%)     2508.72 *   9.42%*
Hmean     1024      5068.70 (   0.00%)     5612.17 *  10.72%*
Hmean     2048      6506.81 (   0.00%)     6739.87 *   3.58%*
Hmean     3312      7232.42 (   0.00%)     7735.86 *   6.96%*
Hmean     4096      7597.95 (   0.00%)     7698.76 *   1.33%*
Hmean     8192      8402.80 (   0.00%)     8540.36 *   1.64%*
Hmean     16384     8841.60 (   0.00%)     9068.70 *   2.57%*

Using perf for in similar workload:
Perf difference in the activate_task and deactivate_task is not too
small.
v5.7-rc7-base
      0.62%  netperf          [kernel.kallsyms]        [k] activate_task
      0.06%  netserver        [kernel.kallsyms]        [k] deactivate_task

v5.7-rc7-ucl-tsk
      3.43%  netperf          [kernel.kallsyms]        [k] activate_task
      2.39%  netserver        [kernel.kallsyms]        [k] deactivate_task

It's a starting point, just to align with others who see also some
regression.

2.2. Experiment with many tests of a single netperf-udp 64B and tracing

I have tried to measure the suspected functions, which were mentioned
many times. Here are the measurements of functions 'activate_task' and
'deactivate_task', such as:
number of hits, total computation time, average time of one call.
These values have been captured during one single netperf-udp 64B test,
but repeated many time. These tables below show processed statistics for
experiments conducted with 3 different kernels. How many times the test
has been repeated on each kernel is shown in row called 'counts'.
This is the output from pandas data frame, function describe(). In case
of confusion with labels in the first row, please check the web for some
tutorials.

stats: fprof.base (basic kernel v5.7-rc7 nouclamp)
activate_task
                Hit    Time_us  Avg_us  s^2_us
count       138.00     138.00  138.00  138.00
mean     20,387.44  14,587.33    1.15    0.53
std     114,980.19  81,427.51    0.42    0.23
min         110.00     181.68    0.32    0.00
50%         411.00     461.55    1.32    0.54
75%         881.75     760.08    1.47    0.66
90%       2,885.60   1,302.03    1.61    0.80
95%      55,318.05  41,273.41    1.66    0.92
99%     501,660.04 358,939.04    1.77    1.09
max   1,131,457.00 798,097.30    1.80    1.42
deactivate_task
                Hit    Time_us  Avg_us  s^2_us
count       138.00     138.00  138.00  138.00
mean     81,828.83  39,991.61    0.81    0.28
std     260,130.01 126,386.89    0.28    0.14
min          97.00      92.35    0.26    0.00
50%         424.00     340.35    0.94    0.30
75%       1,062.25     684.98    1.05    0.37
90%     330,657.50 168,320.94    1.11    0.46
95%     748,920.70 359,498.23    1.15    0.51
99%   1,094,614.76 528,459.50    1.21    0.56
max   1,630,473.00 789,476.50    1.25    0.60

stats: fprof.uclamp_tsk (kernel v5.7-rc7 + uclamp tasks)
activate_task
                Hit      Time_us  Avg_us  s^2_us
count       113.00       113.00  113.00  113.00
mean     23,006.46    24,133.29    1.36    0.64
std     161,171.74   170,299.61    0.45    0.24
min          98.00       173.13    0.44    0.08
50%         369.00       575.96    1.55    0.62
75%         894.00       883.71    1.69    0.74
90%       1,941.20     1,221.70    1.77    0.90
95%       3,187.40     1,627.21    1.85    1.14
99%     431,604.88   437,291.66    1.92    1.35
max   1,631,657.00 1,729,488.00    2.16    1.35
deactivate_task
                Hit      Time_us  Avg_us  s^2_us
count       113.00       113.00  113.00  113.00
mean    108,067.93    86,020.56    1.00    0.35
std     310,429.35   246,938.68    0.33    0.15
min          89.00       102.46    0.33    0.00
50%         430.00       495.87    1.14    0.35
75%       1,361.00       823.63    1.24    0.44
90%     437,528.40   345,051.10    1.34    0.53
95%     886,978.60   696,796.74    1.40    0.58
99%   1,345,052.40 1,086,567.76    1.44    0.68
max   1,391,534.00 1,116,053.00    1.63    0.80

stats: fprof.uclamp_tsk_grp (kernel v5.7-rc7 + uclamp tasks + uclamp 
task group)
activate_task
                Hit      Time_us  Avg_us  s^2_us
count       273.00       273.00  273.00  273.00
mean     15,958.34    16,471.84    1.58    0.67
std     105,096.88   108,322.03    0.43    0.32
min           3.00         4.96    0.41    0.00
50%         245.00       400.23    1.70    0.64
75%         384.00       565.53    1.85    0.78
90%       1,602.00     1,069.08    1.95    0.95
95%       3,403.00     1,573.74    2.01    1.13
99%     589,484.56   604,992.57    2.11    1.75
max   1,035,866.00 1,096,975.00    2.40    3.08
deactivate_task
                Hit      Time_us  Avg_us  s^2_us
count       273.00       273.00  273.00  273.00
mean     94,607.02    63,433.12    1.02    0.34
std     325,130.91   216,844.92    0.28    0.16
min           2.00         2.79    0.29    0.00
50%         244.00       291.49    1.11    0.36
75%         496.00       448.72    1.19    0.43
90%     120,304.60    82,964.94    1.25    0.55
95%     945,480.60   626,793.58    1.33    0.60
99%   1,485,959.96 1,010,615.72    1.40    0.68
max   2,120,682.00 1,403,280.00    1.80    1.11

As you can see the data is distributed differently, having
higher 'Hit' and 'Time_us' value at around .95 for kernels
with uclamp.

2.3. Experiment forcing test tasks to run in the same NUMA node

The experiment showing if forcing to use only one NUMA node for all test
tasks can make a difference.

netperf-udp
                                  ./v5.7-rc7             ./v5.7-rc7 
        ./v5.7-rc7
                                  base-numa0          ucl-tsk-numa0 
ucl-tsk-grp-numa0
Hmean     send-64          60.99 (   0.00%)       61.19 *   0.32%* 
64.58 *   5.88%*
Hmean     send-128        121.92 (   0.00%)      121.37 *  -0.45%* 
128.26 *   5.20%*
Hmean     send-256        240.74 (   0.00%)      240.87 *   0.06%* 
253.86 *   5.45%*
Hmean     send-1024       905.17 (   0.00%)      908.43 *   0.36%* 
955.59 *   5.57%*
Hmean     send-2048      1669.18 (   0.00%)     1681.30 *   0.73%* 
1752.39 *   4.99%*
Hmean     send-3312      2496.30 (   0.00%)     2510.48 *   0.57%* 
2602.42 *   4.25%*
Hmean     send-4096      2914.13 (   0.00%)     2932.19 *   0.62%* 
3028.83 *   3.94%*
Hmean     send-8192      4744.81 (   0.00%)     4762.90 *   0.38%* 
4916.24 *   3.61%*
Hmean     send-16384     7489.47 (   0.00%)     7514.17 *   0.33%* 
7570.39 *   1.08%*
Hmean     recv-64          60.98 (   0.00%)       61.18 *   0.34%* 
64.54 *   5.85%*
Hmean     recv-128        121.86 (   0.00%)      121.29 *  -0.47%* 
128.26 *   5.26%*
Hmean     recv-256        240.65 (   0.00%)      240.79 *   0.06%* 
253.74 *   5.44%*
Hmean     recv-1024       904.65 (   0.00%)      908.20 *   0.39%* 
955.58 *   5.63%*
Hmean     recv-2048      1669.18 (   0.00%)     1680.89 *   0.70%* 
1752.39 *   4.99%*
Hmean     recv-3312      2495.08 (   0.00%)     2509.68 *   0.59%* 
2601.31 *   4.26%*
Hmean     recv-4096      2911.66 (   0.00%)     2931.46 *   0.68%* 
3028.83 *   4.02%*
Hmean     recv-8192      4738.70 (   0.00%)     4762.27 *   0.50%* 
4911.90 *   3.66%*
Hmean     recv-16384     7485.81 (   0.00%)     7513.41 *   0.37%* 
7569.91 *   1.12%*

netperf-tcp
                         ./v5.7-rc7             ./v5.7-rc7 
./v5.7-rc7
                         base-numa0          ucl-tsk-numa0 
ucl-tsk-grp-numa0
Hmean     64         762.29 (   0.00%)      826.48 *   8.42%* 
768.86 *   0.86%*
Hmean     128       1418.94 (   0.00%)     1573.76 *  10.91%* 
1444.04 *   1.77%*
Hmean     256       2302.76 (   0.00%)     2518.75 *   9.38%* 
2315.00 *   0.53%*
Hmean     1024      5076.92 (   0.00%)     5351.65 *   5.41%* 
5061.19 *  -0.31%*
Hmean     2048      6493.42 (   0.00%)     6645.99 *   2.35%* 
6493.79 *   0.01%*
Hmean     3312      7229.76 (   0.00%)     7373.29 *   1.99%* 
7208.45 *  -0.29%*
Hmean     4096      7604.00 (   0.00%)     7656.45 *   0.69%* 
7574.14 *  -0.39%*
Hmean     8192      8456.24 (   0.00%)     8495.95 *   0.47%* 
8387.04 *  -0.82%*
Hmean     16384     8835.74 (   0.00%)     8775.17 *  -0.69%* 
8837.48 *   0.02%*

Perf values of suspected functions for each kernel for similar test from
above (pinned to NUMA 0) shows that there is more calls to these
functions, like usually.
  base
      0.57%  netperf          [kernel.kallsyms]        [k] activate_task
      0.11%  netserver        [kernel.kallsyms]        [k] deactivate_task
  ucl-tsk
      3.44%  netperf          [kernel.kallsyms]          [k] activate_task
      2.49%  netserver        [kernel.kallsyms]          [k] deactivate_task
  ucl-tsk-grp
      2.47%  netperf          [kernel.kallsyms]        [k] activate_task
      1.30%  netserver        [kernel.kallsyms]        [k] deactivate_task

This shows there is more work in the related function, but somehow the
machine is able to handle it and the performance results are even better
with uclamp.

2.4. Experiment with one netperf-udp and perf tool.

Repeating nteperd-udp 64B experiment with base kernel vs uclamp task
group of one test run a few times, I could observed in perf that I have:
87bln vs 100bln cycles
~0.8-0.9k  vs ~2.6M context-switches
  ~73bln vs 76-77bln instr
task-clock stays the same: ~48s

2.5. Ubuntu server and distro kernel experiments

Here are some results when I checked different distro, to check if it
can be observed there as well.
This experiment if for different kernel and different distro:
Ubuntu server 18.04, but the same machine.
The results are for kernel uclamp task + task (last column) group might
look really bad.
I convinced myself after processing results from experiment 2.2
that I just might hit worse usecase during these 5 iterations test of
'netperf-udp send-128', a very bad tasks bouncing.
Apart from that, in general, worse performance results can be observed.

                       ./v5.6-custom-nouclamp       ./v5.6-custom-uct 
  ./v5.6-custom-uctg
Hmean     send-64          99.43 (   0.00%)       94.40 *  -5.06%* 
90.19 *  -9.29%*
Hmean     send-128        198.81 (   0.00%)      180.91 *  -9.01%* 
137.80 * -30.69%*
Hmean     send-256        393.12 (   0.00%)      341.89 * -13.03%* 
332.72 * -15.36%*
Hmean     send-1024      1052.48 (   0.00%)      961.17 *  -8.68%* 
961.64 *  -8.63%*
Hmean     send-2048      1935.68 (   0.00%)     1803.86 *  -6.81%* 
1755.36 *  -9.32%*
Hmean     send-3312      2983.04 (   0.00%)     2806.50 *  -5.92%* 
2802.44 *  -6.05%*
Hmean     send-4096      3558.37 (   0.00%)     3348.70 *  -5.89%* 
3373.92 *  -5.18%*
Hmean     send-8192      5335.23 (   0.00%)     5227.89 *  -2.01%* 
5277.22 *  -1.09%*
Hmean     send-16384     7552.66 (   0.00%)     7374.27 *  -2.36%* 
7388.90 *  -2.17%*

3. Some hypothesis and summary

These 1.5M extra ctx-switches might cause + 3-4bln instr,
which could consume extra 13bln cycles.
Tasks are jumping around across the CPUs more often.
More frequently there is context switch.
The functions 'activate_task' and 'deactivate_task' have worse
total hit or total computation time in the same netperf-udp test.
This also makes worse average time for them. It might be because of the
pressure on caches and branch predictions. Surprisingly the machine can
handle higher value of bouncing tasks when they are pinned to one single
NUMA node.

I hope it could help you to investigate further this issue and find a
solution. IMHO having this uclamp option as a static key is in my
opinion a good idea.
Thank you Mel for your help in my machine configuration and setup.

Regards,
Lukasz Luba


