Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAF1C2E61
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgECRhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgECRhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 13:37:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B46C061A0E;
        Sun,  3 May 2020 10:37:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so18110682wrb.8;
        Sun, 03 May 2020 10:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:references:user-agent:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=CcNNW48DMJd5dqECUPVDtpDVz5NkbZaOubZZLlBCd0E=;
        b=htNXykB1FiMsSJ0PjO31O5n3kJzWC9OAb66zDvjZSL8yc1LELM11IhNP2TjIcPb8Jv
         k3u0UHgkv5cqT6JMmKT5z/muaDpz67l2NMTfLSJgQgzEgD9btLxxA1NhXAUQRijOIrJE
         10BMErUd5OThZOFhY9aF2yE+Ghttpi1nFBuRNZylXeGC/jwRbi9C2CTg/eonjhcLbU2L
         2Pjp7ARKgD63y6hOrQAbdIj/aSaEiSgcsBocf0SRbbVVHQugjrcSgy0nP7E0sBgda4NR
         3uqj9bC8w5JQ+SUNO2hRmsuhuYkQeb/U8tMJz8dfVrDZtpFQBRl0Xo8w1OsnAxioudfv
         pxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:user-agent:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=CcNNW48DMJd5dqECUPVDtpDVz5NkbZaOubZZLlBCd0E=;
        b=rWptewSvnAH9jNlS0SZ33Ja/zyAEW2vEP5o5pp/ux5hcnqqr3Se5QakMzXM5Qvge4C
         cBqWrZDdIXynHccJHuiNsLU3g6O7tqasCZ+52NNifSn2d6h0GQ9QD1n4LOklg3n/dZ3A
         3H/iRmXcsQ/Xuy7BRo/Jat1LGN/xtDHItL+Qyf2ExkPGD/9u0XGCOQEnvYF3csCkjLKw
         /5d5J+Cy8d7nMdZphsvk1g91zAHgCY5laNEdJZ4MwTikxz2lTIOarYGYFPaRf0V9bTjH
         +dei221OW9uW6sVWtYlKiZh5y5L/n1M90sq5xaWYj25n9GDOLHxnxtoY1goMWc2mKam9
         IwMQ==
X-Gm-Message-State: AGi0PubSF3Ia4wKwXt20LRhQ59S1OsAA0EG/L+RoHV8Pv+gkMuXo81cc
        M+mEDtC+m5GmuCf3FolfJXCGuReMlC0zSA==
X-Google-Smtp-Source: APiQypLBDx2IX/SbA45FnI0MuVve6ubbCLv8YvZOIy2HSAlJcJLQenicxRVMscHSSry4mWXZgSi/8A==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr14856219wrq.59.1588527428281;
        Sun, 03 May 2020 10:37:08 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id n9sm14788939wrx.61.2020.05.03.10.37.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 10:37:07 -0700 (PDT)
From:   Patrick Bellasi <derkling@gmail.com>
X-Google-Original-From: Patrick Bellasi <patrick.bellasi@matbug.com>
References: <20200501114927.15248-1-qais.yousef@arm.com>
User-agent: mu4e 1.4.3; emacs 26.3
To:     Qais Yousef <qais.yousef@arm.com>
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
Subject: Re: [PATCH v4 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
In-reply-to: <20200501114927.15248-1-qais.yousef@arm.com>
Message-ID: <87h7wwrkcd.derkling@matbug.com>
Date:   Sun, 03 May 2020 19:37:06 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Qais,

few notes follows, but in general I like the way code is now organised.

On Fri, May 01, 2020 at 13:49:26 +0200, Qais Yousef <qais.yousef@arm.com> wrote...

[...]

> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d4f6215ee03f..e62cef019094 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -59,6 +59,7 @@ extern int sysctl_sched_rt_runtime;
>  #ifdef CONFIG_UCLAMP_TASK
>  extern unsigned int sysctl_sched_uclamp_util_min;
>  extern unsigned int sysctl_sched_uclamp_util_max;
> +extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
>  #endif
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9a2fbf98fd6f..15d2978e1869 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -790,6 +790,26 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
>  /* Max allowed maximum utilization */
>  unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>  
> +/*
> + * By default RT tasks run at the maximum performance point/capacity of the
> + * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
> + * SCHED_CAPACITY_SCALE.
> + *
> + * This knob allows admins to change the default behavior when uclamp is being
> + * used. In battery powered devices, particularly, running at the maximum
> + * capacity and frequency will increase energy consumption and shorten the
> + * battery life.
> + *
> + * This knob only affects RT tasks that their uclamp_se->user_defined == false.
> + *
> + * This knob will not override the system default sched_util_clamp_min defined
> + * above.
> + *
> + * Any modification is applied lazily on the next attempt to calculate the
> + * effective value of the task.
> + */
> +unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
> +
>  /* All clamps are required to be less or equal than these values */
>  static struct uclamp_se uclamp_default[UCLAMP_CNT];
>  
> @@ -872,6 +892,28 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
>  	return uclamp_idle_value(rq, clamp_id, clamp_value);
>  }
>  
> +static inline void uclamp_sync_util_min_rt_default(struct task_struct *p,
> +						   enum uclamp_id clamp_id)
> +{
> +	struct uclamp_se *uc_se;
> +
> +	/* Only sync for UCLAMP_MIN and RT tasks */
> +	if (clamp_id != UCLAMP_MIN || likely(!rt_task(p)))
                                      ^^^^^^
Are we sure that likely makes any difference when used like that?

I believe you should either use:

	if (likely(clamp_id != UCLAMP_MIN || !rt_task(p)))

or completely drop it.

> +		return;
> +
> +	uc_se = &p->uclamp_req[UCLAMP_MIN];

nit-pick: you can probably move this at declaration time.

The compiler will be smart enough to either post-pone the init or, given
the likely() above, "pre-fetch" the value.

Anyway, the compiler is likely smarter then us. :)

> +
> +	/*
> +	 * Only sync if user didn't override the default request and the sysctl
> +	 * knob has changed.
> +	 */
> +	if (unlikely(uc_se->user_defined) ||
> +	    likely(uc_se->value == sysctl_sched_uclamp_util_min_rt_default))
> +		return;

Same here, I believe likely/unlikely work only if wrapping a full if()
condition. Thus, you should probably better split the above in two
separate checks, which also makes for a better inline doc.

> +
> +	uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt_default, false);

Nit-pick: perhaps we can also improve a bit readability by defining at
the beginning an alias variable with a shorter name, e.g.

       unsigned int uclamp_min =  sysctl_sched_uclamp_util_min_rt_default;

?

> +}
> +
>  static inline struct uclamp_se
>  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> @@ -907,8 +949,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  static inline struct uclamp_se
>  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> -	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
> -	struct uclamp_se uc_max = uclamp_default[clamp_id];
> +	struct uclamp_se uc_req, uc_max;
> +
> +	/*
> +	 * Sync up any change to sysctl_sched_uclamp_util_min_rt_default value.
                                                                         ^^^^^
> +	 */

nit-pick: we can use a single line comment if you drop the (useless)
'value' at the end.

> +	uclamp_sync_util_min_rt_default(p, clamp_id);
> +
> +	uc_req = uclamp_tg_restrict(p, clamp_id);
> +	uc_max = uclamp_default[clamp_id];
>  
>  	/* System default restrictions always apply */
>  	if (unlikely(uc_req.value > uc_max.value))
> @@ -1114,12 +1163,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  				loff_t *ppos)
>  {
>  	bool update_root_tg = false;
> -	int old_min, old_max;
> +	int old_min, old_max, old_min_rt;
>  	int result;
>  
>  	mutex_lock(&uclamp_mutex);
>  	old_min = sysctl_sched_uclamp_util_min;
>  	old_max = sysctl_sched_uclamp_util_max;
> +	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
>  
>  	result = proc_dointvec(table, write, buffer, lenp, ppos);
>  	if (result)
> @@ -1133,6 +1183,18 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  		goto undo;
>  	}
>  
> +	/*
> +	 * The new value will be applied to RT tasks the next time the
> +	 * scheduler needs to calculate the effective uclamp.min for that task,
> +	 * assuming the task is using the system default and not a user
> +	 * specified value. In the latter we shall leave the value as the user
> +	 * requested.

IMO it does not make sense to explain here what you will do with this
value. This will make even more complicated to maintain the comment
above if the code using it should change in the future.

So, if the code where we use the knob is not clear enough, maybe we can
move this comment to the description of:
   uclamp_sync_util_min_rt_default()
or to be part of the documentation of:
  sysctl_sched_uclamp_util_min_rt_default

By doing that you can also just add this if condition with the previous ones.

> +	 */
> +	if (sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
> +		result = -EINVAL;
> +		goto undo;
> +	}
> +
>  	if (old_min != sysctl_sched_uclamp_util_min) {
>  		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
>  			      sysctl_sched_uclamp_util_min, false);
> @@ -1158,6 +1220,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  undo:
>  	sysctl_sched_uclamp_util_min = old_min;
>  	sysctl_sched_uclamp_util_max = old_max;
> +	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
>  done:
>  	mutex_unlock(&uclamp_mutex);
>  
> @@ -1200,9 +1263,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  		if (uc_se->user_defined)
>  			continue;
>  
> -		/* By default, RT tasks always get 100% boost */
> +		/*
> +		 * By default, RT tasks always get 100% boost, which the admins
> +		 * are allowed to change via
> +		 * sysctl_sched_uclamp_util_min_rt_default knob.
> +		 */
>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> -			clamp_value = uclamp_none(UCLAMP_MAX);
> +			clamp_value = sysctl_sched_uclamp_util_min_rt_default;

Mmm... I suspect we don't need this anymore.

If the task has a user_defined value, we skip this anyway.
If the task has not a user_defined value, we will do set this anyway at
each enqueue time.

No?

>  
>  		uclamp_se_set(uc_se, clamp_value, false);
>  	}
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..64117363c502 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -453,6 +453,13 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= sysctl_sched_uclamp_handler,
>  	},
> +	{
> +		.procname	= "sched_util_clamp_min_rt_default",
> +		.data		= &sysctl_sched_uclamp_util_min_rt_default,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= sysctl_sched_uclamp_handler,
> +	},
>  #endif
>  #ifdef CONFIG_SCHED_AUTOGROUP
>  	{

Best,
Patrick

