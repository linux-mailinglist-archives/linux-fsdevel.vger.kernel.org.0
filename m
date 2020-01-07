Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410851327FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 14:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgAGNml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 08:42:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36131 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgAGNml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:42:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so53999677wru.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNvCQyjsNiMUg/1lQuS7zN7awhZ1AvaufUW/jWm6iRE=;
        b=bPx7kY5OI+nNft9fnbwsarqoPjGBjJJSjjHzWemXe3t7GER+zoJfFAnPj400t2LQoz
         fM/PlOJkPuNd55bpx8Xg2ungszpbk2ANrty4/RTg8I8f/rUiM0UTTJbSVUQllww5BtLk
         MhbJDN/WMLVxKo+LFMjuLhbk7yiH5bSuk5gmrJYBUOfSjb3deloyUmPNpJHtSVJDo30d
         Np1N/XWLrtCcUQpcB0ymOhi7kk+AqUKbjXVqvPurUks396AZbHpHhbjm0k45kYeCB2Dz
         OR0+R4pYchkrRnCvDjZgBDAwE0sHfRuQH0svQql2ptcweXxcQHrOdhk3CmxxRAYMnqlQ
         mEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNvCQyjsNiMUg/1lQuS7zN7awhZ1AvaufUW/jWm6iRE=;
        b=F+Jg1W0nv1FeWQHXEHWFCodSVK6IsqAhtK3XtImzD9ER/eQmtMdpksxqr/FNOZuxJL
         8yb7zhp/5ztrZhLUeDG9WPdXq/oTmOUediPK8roSmR052JGXmj2uM3bbL9e0qLKIt9n8
         I5OE4mUsEiBz1PmaaYQJc+54vlS2V6b16eKKB3UCtHNYuvvQuSoLaBD/HXo6jTegtoVm
         NHllgDIF5xy3etxAM7YkKlhIIoBHCs6lY5AJZOt/ZDHdm0MJ2WOvSbPu3ozcjeuUVEGF
         kvxB0ZqZM2hegxNvEuTxk+k0Z8SnqUdf+YmzZjHGxWdrC3JaazyC/k0Bopvm3Cdb9CM2
         EJxA==
X-Gm-Message-State: APjAAAUBvPKmrdiSzjy+olVnSZTxVtdI7M6qeoyOydG/sCs/BGQinE/u
        I9Ycybka6VfaAu0zpOv/JxsN2Q==
X-Google-Smtp-Source: APXvYqxZncKxrwIQPda/14R2WMIJ14evaqCxUBMzMvTe9xz6KV6xriLPnpaU0IjPUZ4UdN3tcI57rA==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr101971046wru.94.1578404558194;
        Tue, 07 Jan 2020 05:42:38 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id f1sm77802537wrp.93.2020.01.07.05.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:42:37 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:42:34 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20200107134234.GA158998@google.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220164838.31619-1-qais.yousef@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qais,

On Friday 20 Dec 2019 at 16:48:38 (+0000), Qais Yousef wrote:
> +/*
> + * By default RT tasks run at the maximum performance point/capacity of the
> + * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
> + * SCHED_CAPACITY_SCALE.
> + *
> + * This knob allows admins to change the default behavior when uclamp is being
> + * used. In battery powered devices particularly running at the maximum
> + * capacity will increase energy consumption and shorten the battery life.
> + *
> + * This knob only affects the default value RT uses when a new RT task is
> + * forked or has just changed policy to RT and no uclamp user settings were
> + * applied (ie: the task didn't modify the default value to a new value.
> + *
> + * This knob will not override the system default values defined above.
> + */

I suppose this comment could go in the sysctl doc file instead ?

> +unsigned int sysctl_sched_rt_uclamp_util_min = SCHED_CAPACITY_SCALE;

I would suggest renaming the knob as 'sysctl_sched_rt_default_uclamp_min'
or something along those lines to make it clear it's a default value.

And for consistency with the existing code, perhaps set the default to
uclamp_none(UCLAMP_MAX) instead of an explicit SCHED_CAPACITY_SCALE?

>  /* All clamps are required to be less or equal than these values */
>  static struct uclamp_se uclamp_default[UCLAMP_CNT];
>  
> @@ -919,6 +936,14 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>  	return uc_req;
>  }
>  
> +void uclamp_rt_sync_default_util_min(struct task_struct *p)
> +{
> +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> +
> +	if (!uc_se->user_defined)
> +		uclamp_se_set(uc_se, sysctl_sched_rt_uclamp_util_min, false);
> +}
> +
>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>  {
>  	struct uclamp_se uc_eff;
> @@ -1116,12 +1141,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  				loff_t *ppos)
>  {
>  	bool update_root_tg = false;
> -	int old_min, old_max;
> +	int old_min, old_max, old_rt_min;
>  	int result;
>  
>  	mutex_lock(&uclamp_mutex);
>  	old_min = sysctl_sched_uclamp_util_min;
>  	old_max = sysctl_sched_uclamp_util_max;
> +	old_rt_min = sysctl_sched_rt_uclamp_util_min;
>  
>  	result = proc_dointvec(table, write, buffer, lenp, ppos);
>  	if (result)
> @@ -1129,12 +1155,23 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  	if (!write)
>  		goto done;
>  
> +	/*
> +	 * The new value will be applied to all RT tasks the next time they
> +	 * wakeup, assuming the task is using the system default and not a user
> +	 * specified value. In the latter we shall leave the value as the user
> +	 * requested.
> +	 */
>  	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
>  	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
>  		result = -EINVAL;
>  		goto undo;
>  	}
>  
> +	if (sysctl_sched_rt_uclamp_util_min > SCHED_CAPACITY_SCALE) {
> +		result = -EINVAL;
> +		goto undo;
> +	}
> +
>  	if (old_min != sysctl_sched_uclamp_util_min) {
>  		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
>  			      sysctl_sched_uclamp_util_min, false);
> @@ -1160,6 +1197,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  undo:
>  	sysctl_sched_uclamp_util_min = old_min;
>  	sysctl_sched_uclamp_util_max = old_max;
> +	sysctl_sched_rt_uclamp_util_min = old_rt_min;
>  done:
>  	mutex_unlock(&uclamp_mutex);
>  
> @@ -1202,9 +1240,12 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  		if (uc_se->user_defined)
>  			continue;
>  
> -		/* By default, RT tasks always get 100% boost */
> +		/*
> +		 * By default, RT tasks always get 100% boost, which the admins
> +		 * are allowed change via sysctl_sched_rt_uclamp_util_min knob.
> +		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			clamp_value = uclamp_none(UCLAMP_MAX);
> +			clamp_value = sysctl_sched_rt_uclamp_util_min;
>  
>  		uclamp_se_set(uc_se, clamp_value, false);
>  	}
> @@ -1236,9 +1277,12 @@ static void uclamp_fork(struct task_struct *p)
>  	for_each_clamp_id(clamp_id) {
>  		unsigned int clamp_value = uclamp_none(clamp_id);
>  
> -		/* By default, RT tasks always get 100% boost */
> +		/*
> +		 * By default, RT tasks always get 100% boost, which the admins
> +		 * are allowed change via sysctl_sched_rt_uclamp_util_min knob.
> +		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			clamp_value = uclamp_none(UCLAMP_MAX);
> +			clamp_value = sysctl_sched_rt_uclamp_util_min;
>  
>  		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
>  	}
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index e591d40fd645..19572dfc175b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2147,6 +2147,12 @@ static void pull_rt_task(struct rq *this_rq)
>   */
>  static void task_woken_rt(struct rq *rq, struct task_struct *p)
>  {
> +	/*
> +	 * When sysctl_sched_rt_uclamp_util_min value is changed by the user,
> +	 * we apply any new value on the next wakeup, which is here.
> +	 */
> +	uclamp_rt_sync_default_util_min(p);

The task has already been enqueued and sugov has been called by then I
think, so this is a bit late. You could do that in uclamp_rq_inc() maybe?

> +
>  	if (!task_running(rq, p) &&
>  	    !test_tsk_need_resched(rq->curr) &&
>  	    p->nr_cpus_allowed > 1 &&
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 280a3c735935..337bf17b1a9d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2300,6 +2300,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  #endif /* CONFIG_CPU_FREQ */
>  
>  #ifdef CONFIG_UCLAMP_TASK
> +void uclamp_rt_sync_default_util_min(struct task_struct *p);
> +
>  unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>  
>  static __always_inline
> @@ -2330,6 +2332,8 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
>  	return uclamp_util_with(rq, util, NULL);
>  }
>  #else /* CONFIG_UCLAMP_TASK */
> +void uclamp_rt_sync_default_util_min(struct task_struct *p) {}
> +
>  static inline unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
>  					    struct task_struct *p)
>  {
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 70665934d53e..06183762daac 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -465,6 +465,13 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= sysctl_sched_uclamp_handler,
>  	},
> +	{
> +		.procname	= "sched_rt_util_clamp_min",
> +		.data		= &sysctl_sched_rt_uclamp_util_min,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= sysctl_sched_uclamp_handler,
> +	},
>  #endif
>  #ifdef CONFIG_SCHED_AUTOGROUP
>  	{
> -- 
> 2.17.1
> 

Apart from the small things above, this seems like a sensible idea and
would indeed be useful, so thanks for the patch!

Quentin
