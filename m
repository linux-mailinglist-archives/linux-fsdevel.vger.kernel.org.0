Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C207F1F18C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 14:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgFHMbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 08:31:13 -0400
Received: from foss.arm.com ([217.140.110.172]:52148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbgFHMbK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:31:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E77441FB;
        Mon,  8 Jun 2020 05:31:08 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E00B3F52E;
        Mon,  8 Jun 2020 05:31:06 -0700 (PDT)
Date:   Mon, 8 Jun 2020 13:31:03 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200608123102.6sdhdhit7lac5cfl@e107158-lin.cambridge.arm.com>
References: <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de>
 <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
 <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/04/20 14:14, Vincent Guittot wrote:

[...]

> I have tried your patch and I don't see any difference compared to
> previous tests. Let me give you more details of my setup:
> I create 3 levels of cgroups and usually run the tests in the 4 levels
> (which includes root). The result above are for the root level
> 
> But I see a difference at other levels:
> 
>                            root           level 1       level 2       level 3
> 
> /w patch uclamp disable     50097         46615         43806         41078
> tip uclamp enable           48706(-2.78%) 45583(-2.21%) 42851(-2.18%)
> 40313(-1.86%)
> /w patch uclamp enable      48882(-2.43%) 45774(-1.80%) 43108(-1.59%)
> 40667(-1.00%)
> 
> Whereas tip with uclamp stays around 2% behind tip without uclamp, the
> diff of uclamp with your patch tends to decrease when we increase the
> number of level

So I did try to dig more into this, but I think it's either not a good
reproducer or what we're observing here is uArch level latencies caused by the
new code that seem to produce a bigger knock on effect than what they really
are.

First, CONFIG_FAIR_GROUP_SCHED is 'expensive', for some definition of
expensive..

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

So there's a 15.6% drop in ops/sec when enabling this option. I think it's good
to look at the absolutely number of usecs/op, Fair group adds around
3 usecs/op.

I dropped FAIR_GROUP_SCHED from my config to eliminate this overhead and focus
on solely on uclamp overhead.

With uclamp enabled but no fair group I get

*** uclamp enabled/fair group disabled ***

	# Executed 50000 pipe operations between two threads
	     Total time: 0.856 [sec]

	     17.125740 usecs/op
		 58391 ops/sec

The drop is 5.5% in ops/sec. Or 1 usecs/op.

I don't know what's the expectation here. 1 us could be a lot, but I don't
think we expect the new code to take more than few 100s of ns anyway. If you
add potential caching effects, reaching 1 us wouldn't be that hard.

Note that in my runs I chose performance governor and use `taskset 0x2` to
force running on a big core to make sure the runs are repeatable.

On Juno-r2 I managed to scrap most of the 1 us with the below patch. It seems
there was weird branching behavior that affects the I$ in my case. It'd be good
to try it out to see if it makes a difference for you.

The I$ effect is my best educated guess. Perf doesn't catch this path and
I couldn't convince it to look at cache and branch misses between 2 specific
points.

Other subtle code shuffling did have weird effect on the result too. One worthy
one is making uclamp_rq_dec() noinline gains back ~400 ns. Making
uclamp_rq_inc() noinline *too* cancels this gain out :-/


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0464569f26a7..0835ee20a3c7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1071,13 +1071,11 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 {
-	enum uclamp_id clamp_id;
-
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_inc_id(rq, p, clamp_id);
+	uclamp_rq_inc_id(rq, p, UCLAMP_MIN);
+	uclamp_rq_inc_id(rq, p, UCLAMP_MAX);
 
 	/* Reset clamp idle holding when there is one RUNNABLE task */
 	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
@@ -1086,13 +1084,11 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 {
-	enum uclamp_id clamp_id;
-
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	for_each_clamp_id(clamp_id)
-		uclamp_rq_dec_id(rq, p, clamp_id);
+	uclamp_rq_dec_id(rq, p, UCLAMP_MIN);
+	uclamp_rq_dec_id(rq, p, UCLAMP_MAX);
 }
 
 static inline void


FWIW I fail to see activate/deactivate_task in perf record. They don't show up
on the list which means this micro benchmark doesn't stress them as Mel's test
does.

Worth noting that I did try running the same test on 2 vCPU VirtualBox VM and
64 vCPU qemu and I couldn't spot a difference when uclamp was enabled/disabled
in these 2 environments.

> 
> Beside this, that's also interesting to notice the ~6% of perf impact
> between each level for the same image

Beside my observation above, I captured this function_graph when
FAIR_GROUP_SCHED is enabled. What I pasted below is a particularly bad
deactivation, it's not always that costly.

This ran happened was recorded with uclamp disabled.

I admit I don't know how much of these numbers is ftrace overhead. When trying
to capture similar runs for uclamp, the numbers didn't add up compared to
running the test without ftrace generating the graph. If juno is suffering from
bad branching costs in this path, then I suspect ftrace will amplify this as
AFAIU it'll cause extra jumps on entry and exit.



      sched-pipe-6532  [001]  9407.276302: funcgraph_entry:                   |  deactivate_task() {
      sched-pipe-6532  [001]  9407.276302: funcgraph_entry:                   |    dequeue_task_fair() {
      sched-pipe-6532  [001]  9407.276303: funcgraph_entry:                   |      update_curr() {
      sched-pipe-6532  [001]  9407.276304: funcgraph_entry:        0.780 us   |        update_min_vruntime();
      sched-pipe-6532  [001]  9407.276306: funcgraph_entry:                   |        cpuacct_charge() {
      sched-pipe-6532  [001]  9407.276306: funcgraph_entry:        0.820 us   |          __rcu_read_lock();
      sched-pipe-6532  [001]  9407.276308: funcgraph_entry:        0.740 us   |          __rcu_read_unlock();
      sched-pipe-6532  [001]  9407.276309: funcgraph_exit:         3.980 us   |        }
      sched-pipe-6532  [001]  9407.276310: funcgraph_entry:        0.720 us   |        __rcu_read_lock();
      sched-pipe-6532  [001]  9407.276312: funcgraph_entry:        0.720 us   |        __rcu_read_unlock();
      sched-pipe-6532  [001]  9407.276313: funcgraph_exit:         9.840 us   |      }
      sched-pipe-6532  [001]  9407.276314: funcgraph_entry:                   |      __update_load_avg_se() {
      sched-pipe-6532  [001]  9407.276315: funcgraph_entry:        0.720 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276316: funcgraph_exit:         2.260 us   |      }
      sched-pipe-6532  [001]  9407.276317: funcgraph_entry:                   |      __update_load_avg_cfs_rq() {
      sched-pipe-6532  [001]  9407.276318: funcgraph_entry:        0.860 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276319: funcgraph_exit:         2.340 us   |      }
      sched-pipe-6532  [001]  9407.276320: funcgraph_entry:        0.760 us   |      clear_buddies();
      sched-pipe-6532  [001]  9407.276321: funcgraph_entry:        0.800 us   |      account_entity_dequeue();
      sched-pipe-6532  [001]  9407.276323: funcgraph_entry:        0.720 us   |      update_cfs_group();
      sched-pipe-6532  [001]  9407.276324: funcgraph_entry:        0.740 us   |      update_min_vruntime();
      sched-pipe-6532  [001]  9407.276326: funcgraph_entry:        0.720 us   |      set_next_buddy();
      sched-pipe-6532  [001]  9407.276327: funcgraph_entry:                   |      __update_load_avg_se() {
      sched-pipe-6532  [001]  9407.276328: funcgraph_entry:        0.740 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276329: funcgraph_exit:         2.220 us   |      }
      sched-pipe-6532  [001]  9407.276330: funcgraph_entry:                   |      __update_load_avg_cfs_rq() {
      sched-pipe-6532  [001]  9407.276331: funcgraph_entry:        0.740 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276332: funcgraph_exit:         2.180 us   |      }
      sched-pipe-6532  [001]  9407.276333: funcgraph_entry:                   |      update_cfs_group() {
      sched-pipe-6532  [001]  9407.276334: funcgraph_entry:                   |        reweight_entity() {
      sched-pipe-6532  [001]  9407.276335: funcgraph_entry:                   |          update_curr() {
      sched-pipe-6532  [001]  9407.276335: funcgraph_entry:        0.720 us   |            __calc_delta();
      sched-pipe-6532  [001]  9407.276337: funcgraph_entry:        0.740 us   |            update_min_vruntime();
      sched-pipe-6532  [001]  9407.276338: funcgraph_exit:         3.560 us   |          }
      sched-pipe-6532  [001]  9407.276339: funcgraph_entry:        0.720 us   |          account_entity_dequeue();
      sched-pipe-6532  [001]  9407.276340: funcgraph_entry:        0.720 us   |          account_entity_enqueue();
      sched-pipe-6532  [001]  9407.276342: funcgraph_exit:         7.860 us   |        }
      sched-pipe-6532  [001]  9407.276342: funcgraph_exit:         9.280 us   |      }
      sched-pipe-6532  [001]  9407.276343: funcgraph_entry:                   |      __update_load_avg_se() {
      sched-pipe-6532  [001]  9407.276344: funcgraph_entry:        0.720 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276345: funcgraph_exit:         2.180 us   |      }
      sched-pipe-6532  [001]  9407.276346: funcgraph_entry:                   |      __update_load_avg_cfs_rq() {
      sched-pipe-6532  [001]  9407.276347: funcgraph_entry:        0.740 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276348: funcgraph_exit:         2.180 us   |      }
      sched-pipe-6532  [001]  9407.276349: funcgraph_entry:                   |      update_cfs_group() {
      sched-pipe-6532  [001]  9407.276350: funcgraph_entry:                   |        reweight_entity() {
      sched-pipe-6532  [001]  9407.276350: funcgraph_entry:                   |          update_curr() {
      sched-pipe-6532  [001]  9407.276351: funcgraph_entry:        0.740 us   |            __calc_delta();
      sched-pipe-6532  [001]  9407.276353: funcgraph_entry:        0.720 us   |            update_min_vruntime();
      sched-pipe-6532  [001]  9407.276354: funcgraph_exit:         3.580 us   |          }
      sched-pipe-6532  [001]  9407.276355: funcgraph_entry:        0.740 us   |          account_entity_dequeue();
      sched-pipe-6532  [001]  9407.276356: funcgraph_entry:        0.720 us   |          account_entity_enqueue();
      sched-pipe-6532  [001]  9407.276358: funcgraph_exit:         7.960 us   |        }
      sched-pipe-6532  [001]  9407.276358: funcgraph_exit:         9.400 us   |      }
      sched-pipe-6532  [001]  9407.276360: funcgraph_entry:                   |      __update_load_avg_se() {
      sched-pipe-6532  [001]  9407.276360: funcgraph_entry:        0.740 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276362: funcgraph_exit:         2.220 us   |      }
      sched-pipe-6532  [001]  9407.276362: funcgraph_entry:                   |      __update_load_avg_cfs_rq() {
      sched-pipe-6532  [001]  9407.276363: funcgraph_entry:        0.740 us   |        __accumulate_pelt_segments();
      sched-pipe-6532  [001]  9407.276365: funcgraph_exit:         2.160 us   |      }
      sched-pipe-6532  [001]  9407.276366: funcgraph_entry:                   |      update_cfs_group() {
      sched-pipe-6532  [001]  9407.276367: funcgraph_entry:                   |        reweight_entity() {
      sched-pipe-6532  [001]  9407.276368: funcgraph_entry:                   |          update_curr() {
      sched-pipe-6532  [001]  9407.276368: funcgraph_entry:        0.720 us   |            __calc_delta();
      sched-pipe-6532  [001]  9407.276370: funcgraph_entry:        0.720 us   |            update_min_vruntime();
      sched-pipe-6532  [001]  9407.276371: funcgraph_exit:         3.540 us   |          }
      sched-pipe-6532  [001]  9407.276372: funcgraph_entry:        0.740 us   |          account_entity_dequeue();
      sched-pipe-6532  [001]  9407.276373: funcgraph_entry:        0.720 us   |          account_entity_enqueue();
      sched-pipe-6532  [001]  9407.276375: funcgraph_exit:         7.840 us   |        }
      sched-pipe-6532  [001]  9407.276375: funcgraph_exit:         9.300 us   |      }
      sched-pipe-6532  [001]  9407.276376: funcgraph_entry:        0.720 us   |      hrtick_update();
      sched-pipe-6532  [001]  9407.276377: funcgraph_exit:       + 75.000 us  |    }
      sched-pipe-6532  [001]  9407.276378: funcgraph_exit:       + 76.700 us  |  }


Cheers

--
Qais Yousef
