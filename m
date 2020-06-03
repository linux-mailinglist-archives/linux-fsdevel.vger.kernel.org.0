Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E934E1ED48C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 18:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFCQwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 12:52:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgFCQwH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:52:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20F3A31B;
        Wed,  3 Jun 2020 09:52:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A6C83F305;
        Wed,  3 Jun 2020 09:52:03 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:52:00 +0100
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
Message-ID: <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
 <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de>
 <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/03/20 16:59, Vincent Guittot wrote:
> When I want to stress the fast path i usually use "perf bench sched pipe -T "
> The tip/sched/core on my arm octo core gives the following results for
> 20 iterations of perf bench sched pipe -T -l 50000
> 
> all uclamp config disabled  50035.4(+/- 0.334%)
> all uclamp config enabled  48749.8(+/- 0.339%)   -2.64%
> 
> It's quite easy to reproduce and probably easier to study the impact

Thanks Vincent. This is very useful!

I could reproduce that on my Juno.

One of the codepath I was suspecting seems to affect it.



diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0464569f26a7..9f48090eb926 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1063,10 +1063,12 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
         * e.g. due to future modification, warn and fixup the expected value.
         */
        SCHED_WARN_ON(bucket->value > rq_clamp);
+#if 0
        if (bucket->value >= rq_clamp) {
                bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
                WRITE_ONCE(uc_rq->value, bkt_clamp);
        }
+#endif
 }

 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)



uclamp_rq_max_value() could be expensive as it loops over all buckets.
Commenting this whole path out strangely doesn't just 'fix' it, but produces
better results to no-uclamp kernel :-/



# ./perf bench -r 20 sched pipe -T -l 50000
Without uclamp:		5039
With uclamp:		4832
With uclamp+patch:	5729



It might be because schedutil gets biased differently by uclamp..? If I move to
performance governor these numbers almost double.

I don't know. But this promoted me to look closer and I think I spotted a bug
where in the if condition we check for '>=' instead of '>', causing us to take
the supposedly impossible fail safe path.

Mind trying with the below patch please?



diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0464569f26a7..50d66d4016ff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1063,7 +1063,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
         * e.g. due to future modification, warn and fixup the expected value.
         */
        SCHED_WARN_ON(bucket->value > rq_clamp);
-       if (bucket->value >= rq_clamp) {
+       if (bucket->value > rq_clamp) {
                bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
                WRITE_ONCE(uc_rq->value, bkt_clamp);
        }



Thanks

--
Qais Yousef
