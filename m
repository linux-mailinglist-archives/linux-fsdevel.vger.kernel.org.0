Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6047E1B0F30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgDTPEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:04:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgDTPEe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:04:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4562531B;
        Mon, 20 Apr 2020 08:04:33 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA6C83F73D;
        Mon, 20 Apr 2020 08:04:30 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:04:28 +0100
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
Message-ID: <20200420150427.acz4nqyhlbgywi3h@e107158-lin.cambridge.arm.com>
References: <20200403123020.13897-1-qais.yousef@arm.com>
 <20200414182152.GB20442@darkstar>
 <20200415074600.GA26984@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415074600.GA26984@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/15/20 09:46, Patrick Bellasi wrote:

[...]

> > > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> > > index d4f6215ee03f..91204480fabc 100644
> > > --- a/include/linux/sched/sysctl.h
> > > +++ b/include/linux/sched/sysctl.h
> > > @@ -59,6 +59,7 @@ extern int sysctl_sched_rt_runtime;
> > >  #ifdef CONFIG_UCLAMP_TASK
> > >  extern unsigned int sysctl_sched_uclamp_util_min;
> > >  extern unsigned int sysctl_sched_uclamp_util_max;
> > > +extern unsigned int sysctl_sched_rt_default_uclamp_util_min;
> > 
> > nit-pick: I would prefer to keep the same prefix of the already
> > exising knobs, i.e. sysctl_sched_uclamp_util_min_rt
> > 
> > The same change for consistency should be applied to all the following
> > symbols related to "uclamp_util_min_rt".
> > 
> > NOTE: I would not use "default" as I think that what we are doing is
> > exactly force setting a user_defined value for all RT tasks. More on
> > that later...
> 
> Had a second tought on that...

Sorry just noticed that you had a second reply to this. I just saw the first
initially.

Still catching up after holiday..

[...]

> > > +static void uclamp_rt_sync_default_util_min(struct task_struct *p)
> > > +{
> > > +	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> > 
> > Don't we have to filter for RT tasks only here?
> 
> I think this is still a valid point.

Yep it is.

> 
> > > +
> > > +	if (!uc_se->user_defined)
> > > +		uclamp_se_set(uc_se, sysctl_sched_rt_default_uclamp_util_min, false);
> > 
> > Here you are actually setting a user-requested value, why not marking
> > it as that, i.e. by using true for the last parameter?
> 
> I think you don't want to set user_defined to ensure we keep updating
> the value every time the task is enqueued, in case the "default"
> should be updated at run-time.

Yes. I'm glad we're finally on agreement about this :-)

> 
> > Moreover, by keeping user_defined=false I think you are not getting
> > what you want for RT tasks running in a nested cgroup.
> > 
> > Let say a subgroup is still with the util_min=1024 inherited from the
> > system defaults, in uclamp_tg_restrict() we will still return the max
> > value and not what you requested for. Isn't it?
> 
> This is also not completely true since perhaps you assume that if an
> RT task is running in a nested group with a non tuned uclamp_max then
> that's probably what we want.
> 
> There is still a small concern due to the fact we don't distinguish
> CFS and RT tasks when it comes to cgroup clamp values, which
> potentially could still generate the same issue. Let say for example
> you wanna allow CFS tasks to be boosted to max (util_min=1024) but
> still want to run RT tasks only at lower OPPs.
> Not sure if that could be a use case tho.

No we can't within the same cgroup. But sys admins can potentially create
different cgroups to enforce the different policies.

A per sched-class uclamp control could simplify userspace if they end up with
this scenario. But given where we are now, I'm not sure how easy it would be to
stage the change.

>  
> > IOW, what about:
> > 
> > ---8<---
> > static void uclamp_sync_util_min_rt(struct task_struct *p)
> > {
> > 	struct uclamp_se *uc_se = &p->uclamp_req[UCLAMP_MIN];
> > 
> >   if (likely(uc_se->user_defined || !rt_task(p)))
> >     return;
> > 
> >   uclamp_se_set(uc_se, sysctl_sched_uclamp_util_min_rt, true);
>                                                           ^^^^
>                      This should remain false as in your patch.
> > }
> > ---8<---
> 
> Still, I was thinking that perhaps it would be better to massage the
> code above into the generation of the effective value, in uclamp_eff_get().
> 
> Since you wanna (possibly) update the value at each enqueue time,
> that's what conceptually is represented by the "effective clamp
> value": a value that is computed by definition at enqueue time by
> aggregating all the requests and constraints.
> 
> Poking with the effective value instead of the requested value will
> fix also the ambiguity above, where we set a "requested values" with
> user-defined=false.

Okay, let me have a second look at this. I just took what we had and improved
on it. But what you say could work too. Let me try it out.

Thanks

--
Qais Yousef
