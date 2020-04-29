Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A661BE270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgD2PVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 11:21:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45497 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726762AbgD2PV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:21:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588173688; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=+gyt2AqINPW1eeo+2IXQyoxZJZuFqi+WhErt1y8Af3c=; b=fdiV22dOUF9/cwvYw5taujNktu5Ichtzc9rpoVAWxwaE74fPPDxqyKVUy+afaVDj7FI7RkJk
 mCNET84M+zafMMrfRbAOJEao0vhFu9mEJNGzzuvZnT2XkEZyw8z87Edp50f5aZB1u/7ZA35L
 r/3avepqEUjeKbB0B/VSZ8EyMQ8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea99b6f.7f1bc751d810-smtp-out-n05;
 Wed, 29 Apr 2020 15:21:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E423DC44791; Wed, 29 Apr 2020 15:21:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA646C433CB;
        Wed, 29 Apr 2020 15:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA646C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 29 Apr 2020 20:51:06 +0530
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
Message-ID: <20200429152106.GB19464@codeaurora.org>
References: <20200428164134.5588-1-qais.yousef@arm.com>
 <20200429113255.GA19464@codeaurora.org>
 <20200429123056.otyedhljlugyf5we@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429123056.otyedhljlugyf5we@e107158-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qais,

On Wed, Apr 29, 2020 at 01:30:57PM +0100, Qais Yousef wrote:
> Hi Pavan
> 
> On 04/29/20 17:02, Pavan Kondeti wrote:
> > Hi Qais,
> > 
> > On Tue, Apr 28, 2020 at 05:41:33PM +0100, Qais Yousef wrote:
> > 
> > [...]
> > 
> > >  
> > > +static void uclamp_sync_util_min_rt_default(struct task_struct *p)
> > > +{
> > > +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> > > +
> > > +	if (unlikely(rt_task(p)) && !uc_se->user_defined)
> > > +		uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt_default, false);
> > > +}
> > 
> > Unlike system default clamp values, RT default value is written to
> > p->uclamp_req[UCLAMP_MIN]. A user may not be able to set the uclamp.max to a
> > lower value than sysctl_sched_uclamp_util_min_rt_default. This is not a
> > big deal. Just sharing my observation. Is this how you expected it to work?
> 
> This is how I expect it to work yes.
> 
> Note that the sysctl_sched_uclamp_util_{min,max}, or 'system default clamp
> values' as you called them, are constraints. They define the range any task is
> _allowed to_ *request*.
> 
> The new sysctl_sched_uclamp_util_min_rt_default is setting the default
> *request* for RT tasks. And this was done since historically RT tasks has
> always run at the highest performance point in Linux.
> 
> Can you think of a scenario where setting the default *request* of uclamp.max
> for all RT tasks helps?
> 

It was a hypothetical question :-) Thanks for clearly explaining the
difference between system default clamp values (constraints) vs the newly
introduced sysctl_sched_uclamp_util_min_rt_default (request for RT tasks).

> I'm thinking, the global constrain of sysctl_sched_uclamp_util_max should
> suffice. Or one can use cgroup to selectively cap some tasks.
> 
> For example if you don't want any task in the system to be boosted to anything
> higher than 800, just do
> 
> 	sysctl_sched_uclamp_util_max = 800
> 
> Or if you want to be selective, the same thing can be achieved by creating
> a cgroup cpu controller that has uclamp.max = 0.8 and attaching tasks to it.
> 
> > 
> > > +
> > >  static inline struct uclamp_se
> > >  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
> > >  {
> > > @@ -907,8 +935,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
> > >  static inline struct uclamp_se
> > >  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
> > >  {
> > > -	struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
> > > -	struct uclamp_se uc_max = uclamp_default[clamp_id];
> > > +	struct uclamp_se uc_req, uc_max;
> > > +
> > > +	/*
> > > +	 * Sync up any change to sysctl_sched_uclamp_util_min_rt_default value.
> > > +	 */
> > > +	uclamp_sync_util_min_rt_default(p);
> > > +
> > > +	uc_req = uclamp_tg_restrict(p, clamp_id);
> > > +	uc_max = uclamp_default[clamp_id];
> > 
> > We are calling uclamp_sync_util_min_rt_default() unnecessarily for
> > clamp_id == UCLAMP_MAX case. Would it be better to have a separate
> 
> It was actually intentional to make sure we update the value ASAP. I didn't
> think it's a lot of overhead. I can further protect with a check to verify
> whether the value has changed if it seems heavy handed.
> 
> > uclamp_default for RT like uclamp_default_rt and select uc_max based
> > on task policy? Since all tunables are handled in sysctl_sched_uclamp_handler
> > we can cover the case of uclamp_util_min < uclamp_util_min_rt.
> 
> Hmm I'm not sure I got you.
> 
> uclamp_default[] is setting the constraints. I.e. what's the range it's allowed
> to take.
> 
> What's added here is simply setting the requested uclamp.min value, which if
> the constraints allow it will be applied.
> 
> For example. If
> 
> 	sysctl_sched_uclamp_util_min = 0
> 	sysctl_sched_uclamp_util_min_rt_default = 400
> 
> uclamp_eff_get() will return 0 as effective uclamp.min value for the task. So
> while the task still requests to be boosted to 1024, but the system constraint
> prevents it from getting it. But as soon as the system constraint has changed,
> the task might be able to get what it wants.
> 
> For example, if at runtime sysctl_sched_uclamp_util_min was modified to 1024
> 
> 	sysctl_sched_uclamp_util_min = 1024
> 	sysctl_sched_uclamp_util_min_rt_default = 400
> 
> uclamp_eff_get() return 400 for the task now, as requested.
> 

Yes, I did understand the relation between sysctl_sched_uclamp_util_min and
sysctl_sched_uclamp_util_min_rt_default . It is not clear why we are copying
sysctl_sched_uclamp_util_min_rt_default into p->uclamp_req[UCLAMP_MIN] though
user did not explicitly asked for it. In the above reply, you clearly
mentioned that the new knob works like a request from the user space for all
RT tasks.

As we are copying the sysctl_sched_uclamp_util_min_rt_default value into
p->uclamp_req[UCLAMP_MIN], user gets it when sched_getattr() is called though
sched_setattr() was not called before. I guess that is expected behavior with
your definition of this new tunable. Thanks for answering the question in
detail.

Thanks,
Pavan

> Thanks
> 
> --
> Qais Yousef
> 
> > 
> > >  
> > >  	/* System default restrictions always apply */
> > >  	if (unlikely(uc_req.value > uc_max.value))
> > > @@ -1114,12 +1149,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> > >  				loff_t *ppos)
> > >  {
> > >  	bool update_root_tg = false;
> > > -	int old_min, old_max;
> > > +	int old_min, old_max, old_min_rt;
> > >  	int result;
> > >  
> > >  	mutex_lock(&uclamp_mutex);
> > >  	old_min = sysctl_sched_uclamp_util_min;
> > >  	old_max = sysctl_sched_uclamp_util_max;
> > > +	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
> > >  
> > >  	result = proc_dointvec(table, write, buffer, lenp, ppos);
> > >  	if (result)
> > > @@ -1133,6 +1169,18 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> > >  		goto undo;
> > >  	}
> > >  
> > > +	/*
> > > +	 * The new value will be applied to RT tasks the next time the
> > > +	 * scheduler needs to calculate the effective uclamp.min for that task,
> > > +	 * assuming the task is using the system default and not a user
> > > +	 * specified value. In the latter we shall leave the value as the user
> > > +	 * requested.
> > > +	 */
> > > +	if (sysctl_sched_uclamp_util_min_rt_default > SCHED_CAPACITY_SCALE) {
> > > +		result = -EINVAL;
> > > +		goto undo;
> > > +	}
> > > +
> > >  	if (old_min != sysctl_sched_uclamp_util_min) {
> > >  		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
> > >  			      sysctl_sched_uclamp_util_min, false);
> > > @@ -1158,6 +1206,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> > >  undo:
> > >  	sysctl_sched_uclamp_util_min = old_min;
> > >  	sysctl_sched_uclamp_util_max = old_max;
> > > +	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
> > >  done:
> > >  	mutex_unlock(&uclamp_mutex);
> > >  
> > > @@ -1200,9 +1249,13 @@ static void __setscheduler_uclamp(struct task_struct *p,
> > >  		if (uc_se->user_defined)
> > >  			continue;
> > >  
> > > -		/* By default, RT tasks always get 100% boost */
> > > +		/*
> > > +		 * By default, RT tasks always get 100% boost, which the admins
> > > +		 * are allowed to change via
> > > +		 * sysctl_sched_uclamp_util_min_rt_default knob.
> > > +		 */
> > >  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
> > > -			clamp_value = uclamp_none(UCLAMP_MAX);
> > > +			clamp_value = sysctl_sched_uclamp_util_min_rt_default;
> > >  
> > >  		uclamp_se_set(uc_se, clamp_value, false);
> > >  	}
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 8a176d8727a3..64117363c502 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -453,6 +453,13 @@ static struct ctl_table kern_table[] = {
> > >  		.mode		= 0644,
> > >  		.proc_handler	= sysctl_sched_uclamp_handler,
> > >  	},
> > > +	{
> > > +		.procname	= "sched_util_clamp_min_rt_default",
> > > +		.data		= &sysctl_sched_uclamp_util_min_rt_default,
> > > +		.maxlen		= sizeof(unsigned int),
> > > +		.mode		= 0644,
> > > +		.proc_handler	= sysctl_sched_uclamp_handler,
> > > +	},
> > >  #endif
> > >  #ifdef CONFIG_SCHED_AUTOGROUP
> > >  	{
> > > -- 
> > > 2.17.1
> > > 
> > 
> > Thanks,
> > Pavan
> > 
> > -- 
> > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
