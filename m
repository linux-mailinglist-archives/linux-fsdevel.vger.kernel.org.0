Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6527D1C597A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgEEO2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 10:28:05 -0400
Received: from foss.arm.com ([217.140.110.172]:41792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgEEO2D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 10:28:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF3D1FB;
        Tue,  5 May 2020 07:28:02 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 840BD3F68F;
        Tue,  5 May 2020 07:28:00 -0700 (PDT)
Date:   Tue, 5 May 2020 15:27:58 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <derkling@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200505142757.rturrjok4uklf2ea@e107158-lin.cambridge.arm.com>
References: <20200501114927.15248-1-qais.yousef@arm.com>
 <87h7wwrkcd.derkling@matbug.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7wwrkcd.derkling@matbug.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/03/20 19:37, Patrick Bellasi wrote:

[...]

> > +static inline void uclamp_sync_util_min_rt_default(struct task_struct *p,
> > +						   enum uclamp_id clamp_id)
> > +{
> > +	struct uclamp_se *uc_se;
> > +
> > +	/* Only sync for UCLAMP_MIN and RT tasks */
> > +	if (clamp_id != UCLAMP_MIN || likely(!rt_task(p)))
>                                       ^^^^^^
> Are we sure that likely makes any difference when used like that?
> 
> I believe you should either use:
> 
> 	if (likely(clamp_id != UCLAMP_MIN || !rt_task(p)))
> 
> or completely drop it.

I agree all these likely/unlikely better dropped.

> 
> > +		return;
> > +
> > +	uc_se = &p->uclamp_req[UCLAMP_MIN];
> 
> nit-pick: you can probably move this at declaration time.
> 
> The compiler will be smart enough to either post-pone the init or, given
> the likely() above, "pre-fetch" the value.
> 
> Anyway, the compiler is likely smarter then us. :)

I'll fling this question to the reviewers who voiced concerns about the
overhead. Personally I see the v3 implementation is the best fit :)

> 
> > +
> > +	/*
> > +	 * Only sync if user didn't override the default request and the sysctl
> > +	 * knob has changed.
> > +	 */
> > +	if (unlikely(uc_se->user_defined) ||
> > +	    likely(uc_se->value == sysctl_sched_uclamp_util_min_rt_default))
> > +		return;
> 
> Same here, I believe likely/unlikely work only if wrapping a full if()
> condition. Thus, you should probably better split the above in two
> separate checks, which also makes for a better inline doc.
> 
> > +
> > +	uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt_default, false);
> 
> Nit-pick: perhaps we can also improve a bit readability by defining at
> the beginning an alias variable with a shorter name, e.g.
> 
>        unsigned int uclamp_min =  sysctl_sched_uclamp_util_min_rt_default;
> 
> ?

Could do. I used default_util_min as a name though.

> 
> > +}
> > +
> >  static inline struct uclamp_se
> >  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
> >  {
> > @@ -907,8 +949,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
> >  static inline struct uclamp_se
> >  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
> >  {
> > -	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
> > -	struct uclamp_se uc_max = uclamp_default[clamp_id];
> > +	struct uclamp_se uc_req, uc_max;
> > +
> > +	/*
> > +	 * Sync up any change to sysctl_sched_uclamp_util_min_rt_default value.
>                                                                          ^^^^^
> > +	 */
> 
> nit-pick: we can use a single line comment if you drop the (useless)
> 'value' at the end.

Okay.

> 
> > +	uclamp_sync_util_min_rt_default(p, clamp_id);
> > +
> > +	uc_req = uclamp_tg_restrict(p, clamp_id);
> > +	uc_max = uclamp_default[clamp_id];
> >  
> >  	/* System default restrictions always apply */
> >  	if (unlikely(uc_req.value > uc_max.value))
> > @@ -1114,12 +1163,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  				loff_t *ppos)
> >  {
> >  	bool update_root_tg = false;
> > -	int old_min, old_max;
> > +	int old_min, old_max, old_min_rt;
> >  	int result;
> >  
> >  	mutex_lock(&uclamp_mutex);
> >  	old_min = sysctl_sched_uclamp_util_min;
> >  	old_max = sysctl_sched_uclamp_util_max;
> > +	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
> >  
> >  	result = proc_dointvec(table, write, buffer, lenp, ppos);
> >  	if (result)
> > @@ -1133,6 +1183,18 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  		goto undo;
> >  	}
> >  
> > +	/*
> > +	 * The new value will be applied to RT tasks the next time the
> > +	 * scheduler needs to calculate the effective uclamp.min for that task,
> > +	 * assuming the task is using the system default and not a user
> > +	 * specified value. In the latter we shall leave the value as the user
> > +	 * requested.
> 
> IMO it does not make sense to explain here what you will do with this
> value. This will make even more complicated to maintain the comment
> above if the code using it should change in the future.
> 
> So, if the code where we use the knob is not clear enough, maybe we can
> move this comment to the description of:
>    uclamp_sync_util_min_rt_default()
> or to be part of the documentation of:
>   sysctl_sched_uclamp_util_min_rt_default
> 
> By doing that you can also just add this if condition with the previous ones.

Okay.

> 
> > +	 */
> > +	if (sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
> > +		result = -EINVAL;
> > +		goto undo;
> > +	}
> > +
> >  	if (old_min != sysctl_sched_uclamp_util_min) {
> >  		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
> >  			      sysctl_sched_uclamp_util_min, false);
> > @@ -1158,6 +1220,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  undo:
> >  	sysctl_sched_uclamp_util_min = old_min;
> >  	sysctl_sched_uclamp_util_max = old_max;
> > +	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
> >  done:
> >  	mutex_unlock(&uclamp_mutex);
> >  
> > @@ -1200,9 +1263,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  		if (uc_se->user_defined)
> >  			continue;
> >  
> > -		/* By default, RT tasks always get 100% boost */
> > +		/*
> > +		 * By default, RT tasks always get 100% boost, which the admins
> > +		 * are allowed to change via
> > +		 * sysctl_sched_uclamp_util_min_rt_default knob.
> > +		 */
> >  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > -			clamp_value = uclamp_none(UCLAMP_MAX);
> > +			clamp_value = sysctl_sched_uclamp_util_min_rt_default;
> 
> Mmm... I suspect we don't need this anymore.
> 
> If the task has a user_defined value, we skip this anyway.
> If the task has not a user_defined value, we will do set this anyway at
> each enqueue time.
> 
> No?

Indeed.

Thanks

--
Qais Yousef
