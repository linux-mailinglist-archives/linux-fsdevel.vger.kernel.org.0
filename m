Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC561BDAB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgD2LdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 07:33:10 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61749 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726865AbgD2LdJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:33:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588159988; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=+mKHoOni6HAqTybwiMJ3iqfd2RYtnOIL2dRkZG20+4c=; b=oFJdzz2OkJj75rIuDa69n3pgy+TJTj6lhKDtbHahQTEqzRQmZ7ICr07oKoaenTfwseUW/OIO
 48WPogw47NJpU02j4E9/0VwueTcYksVAmqgOWJ26CUbrSJLeV7ioLRW+iHXwWN2a51X6MLZN
 4kRIp/8wnPj8rPNlaCglCrvyeKY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea965f3.7f04b82dd880-smtp-out-n04;
 Wed, 29 Apr 2020 11:33:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 608FAC4478F; Wed, 29 Apr 2020 11:33:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABF1CC433D2;
        Wed, 29 Apr 2020 11:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABF1CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 29 Apr 2020 17:02:55 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
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
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200429113255.GA19464@codeaurora.org>
References: <20200428164134.5588-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428164134.5588-1-qais.yousef@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qais,

On Tue, Apr 28, 2020 at 05:41:33PM +0100, Qais Yousef wrote:

[...]

>  
> +static void uclamp_sync_util_min_rt_default(struct task_struct *p)
> +{
> +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> +
> +	if (unlikely(rt_task(p)) && !uc_se->user_defined)
> +		uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt_default, false);
> +}

Unlike system default clamp values, RT default value is written to
p->uclamp_req[UCLAMP_MIN]. A user may not be able to set the uclamp.max to a
lower value than sysctl_sched_uclamp_util_min_rt_default. This is not a
big deal. Just sharing my observation. Is this how you expected it to work?

> +
>  static inline struct uclamp_se
>  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> @@ -907,8 +935,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  static inline struct uclamp_se
>  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> -	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
> -	struct uclamp_se uc_max = uclamp_default[clamp_id];
> +	struct uclamp_se uc_req, uc_max;
> +
> +	/*
> +	 * Sync up any change to sysctl_sched_uclamp_util_min_rt_default value.
> +	 */
> +	uclamp_sync_util_min_rt_default(p);
> +
> +	uc_req = uclamp_tg_restrict(p, clamp_id);
> +	uc_max = uclamp_default[clamp_id];

We are calling uclamp_sync_util_min_rt_default() unnecessarily for
clamp_id == UCLAMP_MAX case. Would it be better to have a separate
uclamp_default for RT like uclamp_default_rt and select uc_max based
on task policy? Since all tunables are handled in sysctl_sched_uclamp_handler
we can cover the case of uclamp_util_min < uclamp_util_min_rt.

>  
>  	/* System default restrictions always apply */
>  	if (unlikely(uc_req.value > uc_max.value))
> @@ -1114,12 +1149,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
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
> @@ -1133,6 +1169,18 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  		goto undo;
>  	}
>  
> +	/*
> +	 * The new value will be applied to RT tasks the next time the
> +	 * scheduler needs to calculate the effective uclamp.min for that task,
> +	 * assuming the task is using the system default and not a user
> +	 * specified value. In the latter we shall leave the value as the user
> +	 * requested.
> +	 */
> +	if (sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
> +		result = -EINVAL;
> +		goto undo;
> +	}
> +
>  	if (old_min != sysctl_sched_uclamp_util_min) {
>  		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
>  			      sysctl_sched_uclamp_util_min, false);
> @@ -1158,6 +1206,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  undo:
>  	sysctl_sched_uclamp_util_min = old_min;
>  	sysctl_sched_uclamp_util_max = old_max;
> +	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
>  done:
>  	mutex_unlock(&uclamp_mutex);
>  
> @@ -1200,9 +1249,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
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
> -- 
> 2.17.1
> 

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
