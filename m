Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C389134B05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 19:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgAHS5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 13:57:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54491 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHS5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:57:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so29985wmj.4;
        Wed, 08 Jan 2020 10:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5b6WdJdM0aM6t81kIZ+9qAJNtKuxGXlZNzct5nHyCQE=;
        b=K1HAfZ3CW3F0lgDRTQYww3xlvcKh6Ap7GPDnXMVylMZFxq+36d69L5UwnZH0+I/IW9
         VAk6EduxWzwDH6mNXBnQpcme+a02Qg5uVIM5F0byyH3nlt8JEQYSaBWoH8I0fuuDnhut
         s2DxkNHq+jw/0Z/9AwICZRMqDqdIrMrEoavq6IYu4VNG7m/R0UnavpCy+AEl2mVUNao9
         KMA1cmtAKgTgKhEHnziHrhE7HEvJT27BDQRWgW8t1r8629NiCV1Qx5yeAgIWSDoDCodj
         UrRxtepmVRJMiCEIZyn5aKv7/ywUj/Sbpkxw4kbc24LQSNUNI0XRiDMNovoDFGxbWtQF
         sZlg==
X-Gm-Message-State: APjAAAVRuvlVnOL81KB3LmJJjtEA6Nc8uI2JFvN059GSEsN8Iy7Ou51B
        t0Qr6T0h39q9nIF6595yNHVl2Zmq5iEYN0kW
X-Google-Smtp-Source: APXvYqxnzVlXJeROaPdxaaGHvWGUzrRrPOsQRflwmVudTvwGre+ehyr4Ka1V4MSAxR/Ht3Ozn3Ezvg==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr56625wmb.174.1578509823710;
        Wed, 08 Jan 2020 10:57:03 -0800 (PST)
Received: from darkstar ([2a04:ee41:4:500b:c62:197d:80dc:1629])
        by smtp.gmail.com with ESMTPSA id n3sm4906029wrs.8.2020.01.08.10.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 10:57:03 -0800 (PST)
Date:   Wed, 8 Jan 2020 19:56:50 +0100
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
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
        valentin.schneider@arm.com, qperret@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200108185650.GA9635@darkstar>
References: <20191220164838.31619-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220164838.31619-1-qais.yousef@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qais,

On 20-Dec 16:48, Qais Yousef wrote:
> RT tasks by default try to run at the highest capacity/performance
> level. When uclamp is selected this default behavior is retained by
> enforcing the uclamp_util_min of the RT tasks to be
> uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> value.
> 
> See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> 
> On battery powered devices, this default behavior could consume more
> power, and it is desired to be able to tune it down. While uclamp allows
> tuning this by changing the uclamp_util_min of the individual tasks, but
> this is cumbersome and error prone.
> 
> To control the default behavior globally by system admins and device
> integrators, introduce the new sysctl_sched_rt_uclamp_util_min to
> change the default uclamp_util_min value of the RT tasks.
> 
> Whenever the new default changes, it'd be applied on the next wakeup of
> the RT task, assuming that it still uses the system default value and
> not a user applied one.
> 
> If the uclamp_util_min of an RT task is 0, then the RT utilization of
> the rq is used to drive the frequency selection in schedutil for RT
> tasks.
> 
> Tested on Juno-r2 in combination of the RT capacity awareness patches.
> By default an RT task will go to the highest capacity CPU and run at the
> maximum frequency. With this patch the RT task can run anywhere and
> doesn't cause the frequency to be maximum all the time.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  include/linux/sched/sysctl.h |  1 +
>  kernel/sched/core.c          | 54 ++++++++++++++++++++++++++++++++----
>  kernel/sched/rt.c            |  6 ++++
>  kernel/sched/sched.h         |  4 +++
>  kernel/sysctl.c              |  7 +++++
>  5 files changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d4f6215ee03f..ec73d8db2092 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -59,6 +59,7 @@ extern int sysctl_sched_rt_runtime;
>  #ifdef CONFIG_UCLAMP_TASK
>  extern unsigned int sysctl_sched_uclamp_util_min;
>  extern unsigned int sysctl_sched_uclamp_util_max;
> +extern unsigned int sysctl_sched_rt_uclamp_util_min;
>  #endif
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 90e4b00ace89..a8ab0bb7a967 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -792,6 +792,23 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
>  /* Max allowed maximum utilization */
>  unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>  
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
> +unsigned int sysctl_sched_rt_uclamp_util_min = SCHED_CAPACITY_SCALE;
> +
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

Here you are force setting the task-specific _requests_ to match the
system-wide _constraints_. This is not required and it's also
conceptually wrong, since you mix two concepts: requests and
constraints.

System-default values must never be synchronized with task-specific
values. This allows to always satisfy task _requests_ when not
conflicting with system-wide (or task-group) _constraints_.

For example, assuming we have a task with util_min=500 and we keep
changing the system-wide constraints, we would like the following
effective clamps to be enforced:

   time | system-wide | task-specific | effective clamp
   -----+-------------+---------------+-----------------
     t0 |        1024 |           500 |             500
     t1 |           0 |           500 |               0
     t2 |         200 |           500 |             200
     t3 |         600 |           500 |             500

If the taks should then change it's requested util_min:

   time | system-wide | task-specific | effective clamp
   -----+-------------+---------------+----------------
     t4 |         600 |          800  |             600
     t6 |        1024 |          800  |             800

If you force set the task-specific requests to match the system-wide
constraints, you cannot get the above described behaviors since you
keep overwriting the task _requests_ with system-wide _constraints_.

Thus, requests and contraints must always float independently and
used to compute the effective clamp at task wakeup time via:

   enqueue_task(rq, p, flags)
     uclamp_rq_inc(rq, p)
       uclamp_rq_inc_id(rq, p, clamp_id)
         uclamp_eff_get(p, clamp_id)
           uclamp_tg_restrict(p, clamp_id)
     p->sched_class->enqueue_task(rq, p, flags)

where the task-specific request is restricted considering its task group
effective value (the constraint).

Do note that the root task group effective value (for cfs) tasks is kept
in sync with the system default value and propagated down to the
effective value of all subgroups.

Do note also that the effective value is computed before calling into
the scheduling class's enqueue_task(). Which means that we have the
right value in place before we poke sugov.

Thus, a proper implementation of what you need should just
replicate/generalize what we already do for cfs tasks.

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

-- 
#include <best/regards.h>

Patrick Bellasi
