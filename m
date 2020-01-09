Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C91357BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgAILQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 06:16:30 -0500
Received: from foss.arm.com ([217.140.110.172]:57266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgAILQa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:16:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C138031B;
        Thu,  9 Jan 2020 03:16:29 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A71DD3F703;
        Thu,  9 Jan 2020 03:16:27 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:16:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200109111624.5qxfidhvqa5vylcw@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200107134234.GA158998@google.com>
 <8bb17e84-d43f-615f-d04d-c36bb6ede5e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bb17e84-d43f-615f-d04d-c36bb6ede5e0@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/07/20 20:30, Dietmar Eggemann wrote:
> On 07/01/2020 14:42, Quentin Perret wrote:
> > Hi Qais,
> > 
> > On Friday 20 Dec 2019 at 16:48:38 (+0000), Qais Yousef wrote:
> 
> [...]
> 
> >> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >> index e591d40fd645..19572dfc175b 100644
> >> --- a/kernel/sched/rt.c
> >> +++ b/kernel/sched/rt.c
> >> @@ -2147,6 +2147,12 @@ static void pull_rt_task(struct rq *this_rq)
> >>   */
> >>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
> >>  {
> >> +	/*
> >> +	 * When sysctl_sched_rt_uclamp_util_min value is changed by the user,
> >> +	 * we apply any new value on the next wakeup, which is here.
> >> +	 */
> >> +	uclamp_rt_sync_default_util_min(p);
> > 
> > The task has already been enqueued and sugov has been called by then I
> > think, so this is a bit late. You could do that in uclamp_rq_inc() maybe?
> 
> That's probably better.
> Just to be sure ...we want this feature (an existing rt task gets its
> UCLAMP_MIN value set when the sysctl changes) because there could be rt
> tasks running before the sysctl is set?

Yes. If the default value changes this sync will propagate it to all current RT
task to reflect the new value. It is done in a lazy way though, so there will
be a window where the RT task runs with the old value.

> 
> >> +
> >>  	if (!task_running(rq, p) &&
> >>  	    !test_tsk_need_resched(rq->curr) &&
> >>  	    p->nr_cpus_allowed > 1 &&
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index 280a3c735935..337bf17b1a9d 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -2300,6 +2300,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> >>  #endif /* CONFIG_CPU_FREQ */
> >>  
> >>  #ifdef CONFIG_UCLAMP_TASK
> >> +void uclamp_rt_sync_default_util_min(struct task_struct *p);
> >> +
> >>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> >>  
> >>  static __always_inline
> >> @@ -2330,6 +2332,8 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> >>  	return uclamp_util_with(rq, util, NULL);
> >>  }
> >>  #else /* CONFIG_UCLAMP_TASK */
> >> +void uclamp_rt_sync_default_util_min(struct task_struct *p) {}
> 
> -void uclamp_rt_sync_default_util_min(struct task_struct *p) {}
> +static inline void uclamp_rt_sync_default_util_min(struct task_struct
> *p) {}

+1

Thanks!

--
Qais Yousef
