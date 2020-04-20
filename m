Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADAB1B0F4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgDTPIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:08:46 -0400
Received: from foss.arm.com ([217.140.110.172]:50590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgDTPIp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:08:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC5FB31B;
        Mon, 20 Apr 2020 08:08:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DF373F73D;
        Mon, 20 Apr 2020 08:08:42 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:08:40 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200420150839.ysh3ijfjftyzg7jw@e107158-lin.cambridge.arm.com>
References: <20200403123020.13897-1-qais.yousef@arm.com>
 <20200415101122.GA14447@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415101122.GA14447@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Quentin

On 04/15/20 11:11, Quentin Perret wrote:
> Hi Qais,
> 
> On Friday 03 Apr 2020 at 13:30:19 (+0100), Qais Yousef wrote:
> <snip>
> > +	/*
> > +	 * The new value will be applied to all RT tasks the next time they
> > +	 * wakeup, assuming the task is using the system default and not a user
> > +	 * specified value. In the latter we shall leave the value as the user
> > +	 * requested.
> > +	 */
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
> 
> Hmm, checking:
> 
> 	if (sysctl_sched_rt_default_uclamp_util_min > sysctl_sched_uclamp_util_min)
> 
> would probably make sense too, but then that would make writing in
> sysctl_sched_uclamp_util_min cumbersome for sysadmins as they'd need to
> lower the rt default first. Is that the reason for checking against
> SCHED_CAPACITY_SCALE? That might deserve a comment or something.

There's no need for that extra diff. That constraint will be applied
automatically when calculating the effective value.

The check for SCHED_CAPACITY_SCALE is a a range check. The possible value is
[0:SCHED_CAPACITY_SCALE].

Does this answer your question? I could add a comment that all the uclamp
sysctls need to be within this range.

> 
> <snip>
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
> >  		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
> >  	}
> 
> And that, as per 20200414161320.251897-1-qperret@google.com, should not
> be there :)

Yep saw it. Thanks for fixing it!

> 
> Otherwise the patch pretty looks good to me!

Cheers

--
Qais Yousef
