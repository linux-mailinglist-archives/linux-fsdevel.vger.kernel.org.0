Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA61F657C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgFKKN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 06:13:57 -0400
Received: from foss.arm.com ([217.140.110.172]:49938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKKN4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:13:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C698431B;
        Thu, 11 Jun 2020 03:13:54 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185913F73D;
        Thu, 11 Jun 2020 03:13:51 -0700 (PDT)
Date:   Thu, 11 Jun 2020 11:13:49 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200611101349.v3utkqrcegthhahr@e107158-lin.cambridge.arm.com>
References: <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de>
 <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
 <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
 <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
 <20200608104424.10781990@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200608104424.10781990@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/08/20 10:44, Steven Rostedt wrote:
> On Mon, 8 Jun 2020 13:31:03 +0100
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > I admit I don't know how much of these numbers is ftrace overhead. When trying
> 
> Note, if you want to get a better idea of how long a function runs, put it
> into set_ftrace_filter, and then trace it. That way you remove the overhead
> of the function graph tracer when its nesting within a function.

Thanks for the tip!

With CONFIG_FAIR_GROUP_SCHED I see (uclamp disabled)


      sched-pipe-602   [001]    73.755392: funcgraph_entry:        2.080 us   |  activate_task();
      sched-pipe-602   [001]    73.755399: funcgraph_entry:        2.000 us   |  deactivate_task();
      sched-pipe-601   [001]    73.755407: funcgraph_entry:        2.220 us   |  activate_task();
      sched-pipe-601   [001]    73.755414: funcgraph_entry:        2.020 us   |  deactivate_task();
      sched-pipe-602   [001]    73.755422: funcgraph_entry:        2.160 us   |  activate_task();
      sched-pipe-602   [001]    73.755429: funcgraph_entry:        1.920 us   |  deactivate_task();
      sched-pipe-601   [001]    73.755437: funcgraph_entry:        2.260 us   |  activate_task();
      sched-pipe-601   [001]    73.755444: funcgraph_entry:        2.080 us   |  deactivate_task();
      sched-pipe-602   [001]    73.755452: funcgraph_entry:        2.160 us   |  activate_task();
      sched-pipe-602   [001]    73.755459: funcgraph_entry:        2.080 us   |  deactivate_task();
      sched-pipe-601   [001]    73.755468: funcgraph_entry:        2.200 us   |  activate_task();
      sched-pipe-601   [001]    73.755521: funcgraph_entry:        3.160 us   |  activate_task();

update_cfs_group() overhead

      sched-pipe-622   [001]   156.790478: funcgraph_entry:        0.820 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790483: funcgraph_entry:        0.840 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790485: funcgraph_entry:        0.820 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790487: funcgraph_entry:        0.820 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790488: funcgraph_entry:        0.800 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790508: funcgraph_entry:        1.040 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790510: funcgraph_entry:        0.920 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790511: funcgraph_entry:        1.040 us   |  update_cfs_group();
      sched-pipe-622   [001]   156.790513: funcgraph_entry:        0.840 us   |  update_cfs_group();
      sched-pipe-623   [001]   156.790540: funcgraph_entry:        1.160 us   |  update_cfs_group();
      sched-pipe-623   [001]   156.790543: funcgraph_entry:        1.020 us   |  update_cfs_group();
      sched-pipe-623   [001]   156.790544: funcgraph_entry:        0.880 us   |  update_cfs_group();
      sched-pipe-623   [001]   156.790546: funcgraph_entry:        0.840 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790905: funcgraph_entry:        1.780 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790908: funcgraph_entry:        1.060 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790910: funcgraph_entry:        0.880 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790912: funcgraph_entry:        0.880 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790916: funcgraph_entry:        0.800 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790917: funcgraph_entry:        0.820 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790919: funcgraph_entry:        0.840 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790921: funcgraph_entry:        0.880 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790932: funcgraph_entry:        0.960 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790934: funcgraph_entry:        0.960 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790936: funcgraph_entry:        1.080 us   |  update_cfs_group();
      sched-pipe-621   [001]   156.790937: funcgraph_entry:        0.840 us   |  update_cfs_group();

Without CONFIG_FAIR_GROUP_SCHED and without CONFIG_UCLAMP_TASK

      sched-pipe-604   [001]    76.386078: funcgraph_entry:        1.380 us   |  activate_task();
      sched-pipe-604   [001]    76.386084: funcgraph_entry:        1.360 us   |  deactivate_task();
      sched-pipe-605   [001]    76.386091: funcgraph_entry:        1.400 us   |  activate_task();
      sched-pipe-605   [001]    76.386096: funcgraph_entry:        1.260 us   |  deactivate_task();
      sched-pipe-604   [001]    76.386104: funcgraph_entry:        1.500 us   |  activate_task();
      sched-pipe-604   [001]    76.386109: funcgraph_entry:        1.280 us   |  deactivate_task();
      sched-pipe-605   [001]    76.386117: funcgraph_entry:        1.380 us   |  activate_task();
      sched-pipe-605   [001]    76.386122: funcgraph_entry:        1.300 us   |  deactivate_task();
      sched-pipe-604   [001]    76.386130: funcgraph_entry:        1.380 us   |  activate_task();
      sched-pipe-604   [001]    76.386135: funcgraph_entry:        1.260 us   |  deactivate_task();
      sched-pipe-605   [001]    76.386142: funcgraph_entry:        1.400 us   |  activate_task();
      sched-pipe-605   [001]    76.386148: funcgraph_entry:        1.340 us   |  deactivate_task();

So approximately 800ns are added by update_cfs_group() for enqueue and dequeue.
This overhead affects 2 tasks in the tests, so the total effect on the
generated usecs/ops

	2 * enqueue_overhead + 2 * dequeue overhead = 4 * ~800ns = 3.2 us

Which explains the 3us drop I see when fair group config is enabled.

Applying similar analysis to uclamp

With uclamp enabled

      sched-pipe-610   [001]   173.429431: funcgraph_entry:        1.580 us   |  activate_task();
      sched-pipe-610   [001]   173.429437: funcgraph_entry:        1.440 us   |  deactivate_task();
      sched-pipe-609   [001]   173.429444: funcgraph_entry:        1.580 us   |  activate_task();
      sched-pipe-609   [001]   173.429450: funcgraph_entry:        1.440 us   |  deactivate_task();
      sched-pipe-610   [001]   173.429458: funcgraph_entry:        1.700 us   |  activate_task();
      sched-pipe-610   [001]   173.429464: funcgraph_entry:        1.460 us   |  deactivate_task();
      sched-pipe-609   [001]   173.429471: funcgraph_entry:        1.540 us   |  activate_task();
      sched-pipe-609   [001]   173.429477: funcgraph_entry:        1.460 us   |  deactivate_task();
      sched-pipe-610   [001]   173.429485: funcgraph_entry:        1.560 us   |  activate_task();
      sched-pipe-610   [001]   173.429491: funcgraph_entry:        1.500 us   |  deactivate_task();
      sched-pipe-609   [001]   173.429498: funcgraph_entry:        1.600 us   |  activate_task();
      sched-pipe-609   [001]   173.429504: funcgraph_entry:        1.460 us   |  deactivate_task();

Which adds approximately 200ns at enqueue and dequeue.

	2 * enqueue_overhead + 2 * dequeue overhead = 4 * ~200ns = 0.8 us

Which would explain the ~1us drop I've seen with uclamp when running sched
bench. Apologies for the very course averaging of the numbers from my side.

As a reminder the results I reported before:


*** uclamp disabled/fair group enabled ***

        # Executed 50000 pipe operations between two threads

             Total time: 0.958 [sec]

              19.177100 usecs/op
                  52145 ops/sec

*** uclamp disabled/fair group disabled ***

        # Executed 50000 pipe operations between two threads
             Total time: 0.808 [sec]

             16.176200 usecs/op
                 61819 ops/sec

*** uclamp enabled/fair group disabled ***

        # Executed 50000 pipe operations between two threads
             Total time: 0.856 [sec]

             17.125740 usecs/op
                 58391 ops/sec


Based on my observation with code shuffling it seems a lot of this 200ns comes
from terrible I$ performance on the particular platform I am testing on.

When I run on x86 machine, if I interpreted perf annotation correctly I see D$
misses on accessing rq->uclamp_rq.bucket[] and p->uclamp[]. But I'll share this
result on a separate email in-reply to Mel.

Thanks

--
Qais Yousef
