Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A311B0EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgDTOuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 10:50:23 -0400
Received: from foss.arm.com ([217.140.110.172]:50220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDTOuX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:50:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3665531B;
        Mon, 20 Apr 2020 07:50:22 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6943F73D;
        Mon, 20 Apr 2020 07:50:19 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:50:17 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200420145016.lqznren75ua27cl3@e107158-lin.cambridge.arm.com>
References: <20200403123020.13897-1-qais.yousef@arm.com>
 <20200414182152.GB20442@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200414182152.GB20442@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Patrick!

On 04/14/20 20:21, Patrick Bellasi wrote:
> Hi Qais!
> 
> On 03-Apr 13:30, Qais Yousef wrote:
> 
> [...]
> 
> > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> > index d4f6215ee03f..91204480fabc 100644
> > --- a/include/linux/sched/sysctl.h
> > +++ b/include/linux/sched/sysctl.h
> > @@ -59,6 +59,7 @@ extern int sysctl_sched_rt_runtime;
> >  #ifdef CONFIG_UCLAMP_TASK
> >  extern unsigned int sysctl_sched_uclamp_util_min;
> >  extern unsigned int sysctl_sched_uclamp_util_max;
> > +extern unsigned int sysctl_sched_rt_default_uclamp_util_min;
> 
> nit-pick: I would prefer to keep the same prefix of the already
> exising knobs, i.e. sysctl_sched_uclamp_util_min_rt
> 
> The same change for consistency should be applied to all the following
> symbols related to "uclamp_util_min_rt".

All rt sysctl knobs are prefixed with 'sched_rt', so I used this for
consistency.

> 
> NOTE: I would not use "default" as I think that what we are doing is

The 'default' was suggested by Quentin as it felt more descriptive to him. I
took his 'user' point of view.

I don't mind or care about the name ultimately. This symbol is internal and not
exported to userspace.

I just think sticking to sched_rt for consistency is better. What follows I'm
happy to put whatever reviewers agree on. I think Dietmar has another
suggestion for this too.

> exactly force setting a user_defined value for all RT tasks. More on
> that later...

We are NOT force setting the user_defined value. The whole point is to have
a variable default behavior while still allow the user to override this
default. Exactly like it currently works, except that the __hardcoded__ value
is no longer hardcoded and can be modifyied by sys admins at runtime.

> 
> >  #endif
> >  
> >  #ifdef CONFIG_CFS_BANDWIDTH
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 1a9983da4408..a726b26a5056 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -797,6 +797,27 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
> >  /* Max allowed maximum utilization */
> >  unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
> >  
> > +/*
> > + * By default RT tasks run at the maximum performance point/capacity of the
> > + * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
> > + * SCHED_CAPACITY_SCALE.
> > + *
> > + * This knob allows admins to change the default behavior when uclamp is being
> > + * used. In battery powered devices, particularly, running at the maximum
> > + * capacity and frequency will increase energy consumption and shorten the
> > + * battery life.
> > + *
> > + * This knob only affects the default value RT has when a new RT task is
> > + * forked or has just changed policy to RT, given the user hasn't modified the
> > + * uclamp.min value of the task via sched_setattr().
> > + *
> > + * This knob will not override the system default sched_util_clamp_min defined
> > + * above.
> > + *
> > + * Any modification is applied lazily on the next RT task wakeup.
> > + */
> > +unsigned int sysctl_sched_rt_default_uclamp_util_min = SCHED_CAPACITY_SCALE;
> > +
> >  /* All clamps are required to be less or equal than these values */
> >  static struct uclamp_se uclamp_default[UCLAMP_CNT];
> >  
> > @@ -924,6 +945,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
> >  	return uc_req;
> >  }
> >  
> > +static void uclamp_rt_sync_default_util_min(struct task_struct *p)
> > +{
> > +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> 
> Don't we have to filter for RT tasks only here?

Indeed!

> 
> > +
> > +	if (!uc_se->user_defined)
> > +		uclamp_se_set(uc_se, sysctl_sched_rt_default_uclamp_util_min, false);
> 
> Here you are actually setting a user-requested value, why not marking
> it as that, i.e. by using true for the last parameter?

I will have to bounce the question back. The original code passed false.
So why didn't you pass true then? The fact that the value is no longer
hardcoded with this patch doesn't mean the purpose of this code has changed.

> 
> Moreover, by keeping user_defined=false I think you are not getting
> what you want for RT tasks running in a nested cgroup.
> 
> Let say a subgroup is still with the util_min=1024 inherited from the
> system defaults, in uclamp_tg_restrict() we will still return the max
> value and not what you requested for. Isn't it?

With the current code (without my patch) where RT tasks util_min is 1024 by
default and user_defined=false. How is it behaving then? My patch should
retain this behavior. I can't see how it breaks it.. :-/

> 
> IOW, what about:
> 
> ---8<---
> static void uclamp_sync_util_min_rt(struct task_struct *p)
> {
> 	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> 
>   if (likely(uc_se->user_defined || !rt_task(p)))
>     return;
> 
>   uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt, true);
> }
> ---8<---

See above.

> 
> 
> > +}
> > +
> >  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
> >  {
> >  	struct uclamp_se uc_eff;
> > @@ -1030,6 +1059,12 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> >  	if (unlikely(!p->sched_class->uclamp_enabled))
> >  		return;
> >  
> > +	/*
> > +	 * When sysctl_sched_rt_default_uclamp_util_min value is changed by the
> > +	 * user, we apply any new value on the next wakeup, which is here.
> > +	 */
> > +	uclamp_rt_sync_default_util_min(p);
> > +
> >  	for_each_clamp_id(clamp_id)
> >  		uclamp_rq_inc_id(rq, p, clamp_id);
> >  
> > @@ -1121,12 +1156,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  				loff_t *ppos)
> >  {
> >  	bool update_root_tg = false;
> > -	int old_min, old_max;
> > +	int old_min, old_max, old_rt_min;
> >  	int result;
> >  
> >  	mutex_lock(&uclamp_mutex);
> >  	old_min = sysctl_sched_uclamp_util_min;
> >  	old_max = sysctl_sched_uclamp_util_max;
> > +	old_rt_min = sysctl_sched_rt_default_uclamp_util_min;
> 
> Perpahs it's just my OCD but, is not "old_min_rt" reading better?

:D

> 
> >  
> >  	result = proc_dointvec(table, write, buffer, lenp, ppos);
> >  	if (result)
> > @@ -1134,12 +1170,23 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  	if (!write)
> >  		goto done;
> >  
> > +	/*
> > +	 * The new value will be applied to all RT tasks the next time they
> > +	 * wakeup, assuming the task is using the system default and not a user
> > +	 * specified value. In the latter we shall leave the value as the user
> > +	 * requested.
> > +	 */
> 
> Should not this comment go before the next block?

+1

> 
> >  	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
> >  	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
> >  		result = -EINVAL;
> >  		goto undo;
> >  	}
> >  
> > +	if (sysctl_sched_rt_default_uclamp_util_min > SCHED_CAPACITY_SCALE) {
> > +		result = -EINVAL;
> > +		goto undo;
> > +	}
> > +
> >  	if (old_min != sysctl_sched_uclamp_util_min) {
> >  		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
> >  			      sysctl_sched_uclamp_util_min, false);
> > @@ -1165,6 +1212,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  undo:
> >  	sysctl_sched_uclamp_util_min = old_min;
> >  	sysctl_sched_uclamp_util_max = old_max;
> > +	sysctl_sched_rt_default_uclamp_util_min = old_rt_min;
> >  done:
> >  	mutex_unlock(&uclamp_mutex);
> >  
> > @@ -1207,9 +1255,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  		if (uc_se->user_defined)
> >  			continue;
> >  
> > -		/* By default, RT tasks always get 100% boost */
> > +		/*
> > +		 * By default, RT tasks always get 100% boost, which the admins
> > +		 * are allowed to change via
> > +		 * sysctl_sched_rt_default_uclamp_util_min knob.
> > +		 */
> >  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > -			clamp_value = uclamp_none(UCLAMP_MAX);
> > +			clamp_value = sysctl_sched_rt_default_uclamp_util_min;
> >
> >  		uclamp_se_set(uc_se, clamp_value, false);
> >  	}
> > @@ -1241,9 +1293,13 @@ static void uclamp_fork(struct task_struct *p)
> >  	for_each_clamp_id(clamp_id) {
> >  		unsigned int clamp_value = uclamp_none(clamp_id);
> >  
> > -		/* By default, RT tasks always get 100% boost */
> > +		/*
> > +		 * By default, RT tasks always get 100% boost, which the admins
> > +		 * are allowed to change via
> > +		 * sysctl_sched_rt_default_uclamp_util_min knob.
> > +		 */
> >  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > -			clamp_value = uclamp_none(UCLAMP_MAX);
> > +			clamp_value = sysctl_sched_rt_default_uclamp_util_min;
> >  
> 
> This is not required, look at this Quentin's patch:
> 
>    Message-ID: <20200414161320.251897-1-qperret@google.com>
>    https://lore.kernel.org/lkml/20200414161320.251897-1-qperret@google.com/

Yep saw it.

Thanks for taking the time to review!

Cheers

--
Qais Yousef

> 
> >  		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
> >  	}
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index ad5b88a53c5a..0272ae8c6147 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -465,6 +465,13 @@ static struct ctl_table kern_table[] = {
> >  		.mode		= 0644,
> >  		.proc_handler	= sysctl_sched_uclamp_handler,
> >  	},
> > +	{
> > +		.procname	= "sched_rt_default_util_clamp_min",
> > +		.data		= &sysctl_sched_rt_default_uclamp_util_min,
> > +		.maxlen		= sizeof(unsigned int),
> > +		.mode		= 0644,
> > +		.proc_handler	= sysctl_sched_uclamp_handler,
> > +	},
> >  #endif
> >  #ifdef CONFIG_SCHED_AUTOGROUP
> >  	{
> 
> Best,
> Patrick
> 
> -- 
> #include <best/regards.h>
> 
> Patrick Bellasi
