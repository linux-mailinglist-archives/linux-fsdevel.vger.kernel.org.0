Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830021357B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 12:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgAILMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 06:12:41 -0500
Received: from foss.arm.com ([217.140.110.172]:57190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgAILMl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:12:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7703C31B;
        Thu,  9 Jan 2020 03:12:40 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EEF63F703;
        Thu,  9 Jan 2020 03:12:38 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:12:36 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <20200109111235.auslgkuqkfsaohcd@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200107134234.GA158998@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200107134234.GA158998@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Quentin

On 01/07/20 13:42, Quentin Perret wrote:
> Hi Qais,
> 
> On Friday 20 Dec 2019 at 16:48:38 (+0000), Qais Yousef wrote:
> > +/*
> > + * By default RT tasks run at the maximum performance point/capacity of the
> > + * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
> > + * SCHED_CAPACITY_SCALE.
> > + *
> > + * This knob allows admins to change the default behavior when uclamp is being
> > + * used. In battery powered devices particularly running at the maximum
> > + * capacity will increase energy consumption and shorten the battery life.
> > + *
> > + * This knob only affects the default value RT uses when a new RT task is
> > + * forked or has just changed policy to RT and no uclamp user settings were
> > + * applied (ie: the task didn't modify the default value to a new value.
> > + *
> > + * This knob will not override the system default values defined above.
> > + */
> 
> I suppose this comment could go in the sysctl doc file instead ?

Sure. Does it hurt to keep the comment here too though?

> 
> > +unsigned int sysctl_sched_rt_uclamp_util_min = SCHED_CAPACITY_SCALE;
> 
> I would suggest renaming the knob as 'sysctl_sched_rt_default_uclamp_min'
> or something along those lines to make it clear it's a default value.

+1

> 
> And for consistency with the existing code, perhaps set the default to
> uclamp_none(UCLAMP_MAX) instead of an explicit SCHED_CAPACITY_SCALE?

Can do. But this means you need to move the initialization to sched_init() to
do a function call. Using SCHED_CAPACITY_SCALE is consistent with other uclamp
sysctl definition - there's no big advantage to this code shuffling to achieve
the same thing?

[...]

> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index e591d40fd645..19572dfc175b 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -2147,6 +2147,12 @@ static void pull_rt_task(struct rq *this_rq)
> >   */
> >  static void task_woken_rt(struct rq *rq, struct task_struct *p)
> >  {
> > +	/*
> > +	 * When sysctl_sched_rt_uclamp_util_min value is changed by the user,
> > +	 * we apply any new value on the next wakeup, which is here.
> > +	 */
> > +	uclamp_rt_sync_default_util_min(p);
> 
> The task has already been enqueued and sugov has been called by then I
> think, so this is a bit late. You could do that in uclamp_rq_inc() maybe?

Yeah that might be a better place - I'm not sure why I didn't consider it. I'll
try it out.

> 
> > +
> >  	if (!task_running(rq, p) &&
> >  	    !test_tsk_need_resched(rq->curr) &&
> >  	    p->nr_cpus_allowed > 1 &&
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 280a3c735935..337bf17b1a9d 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2300,6 +2300,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
> >  #endif /* CONFIG_CPU_FREQ */
> >  
> >  #ifdef CONFIG_UCLAMP_TASK
> > +void uclamp_rt_sync_default_util_min(struct task_struct *p);
> > +
> >  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> >  
> >  static __always_inline
> > @@ -2330,6 +2332,8 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> >  	return uclamp_util_with(rq, util, NULL);
> >  }
> >  #else /* CONFIG_UCLAMP_TASK */
> > +void uclamp_rt_sync_default_util_min(struct task_struct *p) {}
> > +
> >  static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> >  					    struct task_struct *p)
> >  {
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 70665934d53e..06183762daac 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -465,6 +465,13 @@ static struct ctl_table kern_table[] = {
> >  		.mode		= 0644,
> >  		.proc_handler	= sysctl_sched_uclamp_handler,
> >  	},
> > +	{
> > +		.procname	= "sched_rt_util_clamp_min",
> > +		.data		= &sysctl_sched_rt_uclamp_util_min,
> > +		.maxlen		= sizeof(unsigned int),
> > +		.mode		= 0644,
> > +		.proc_handler	= sysctl_sched_uclamp_handler,
> > +	},
> >  #endif
> >  #ifdef CONFIG_SCHED_AUTOGROUP
> >  	{
> > -- 
> > 2.17.1
> > 
> 
> Apart from the small things above, this seems like a sensible idea and
> would indeed be useful, so thanks for the patch!

Thanks for having a look!

--
Qais Yousef
