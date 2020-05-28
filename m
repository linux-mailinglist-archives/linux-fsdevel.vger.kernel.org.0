Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7061E66F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404755AbgE1P6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 11:58:10 -0400
Received: from foss.arm.com ([217.140.110.172]:54840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404631AbgE1P6J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 11:58:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB6630E;
        Thu, 28 May 2020 08:58:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8DE73F305;
        Thu, 28 May 2020 08:58:03 -0700 (PDT)
Date:   Thu, 28 May 2020 16:58:01 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528132327.GB706460@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/28/20 15:23, Peter Zijlstra wrote:
> On Mon, May 11, 2020 at 04:40:52PM +0100, Qais Yousef wrote:
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
> > + * This knob only affects RT tasks that their uclamp_se->user_defined == false.
> > + *
> > + * This knob will not override the system default sched_util_clamp_min defined
> > + * above.
> > + *
> > + * Any modification is applied lazily on the next attempt to calculate the
> > + * effective value of the task.
> > + */
> > +unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
> > +
> >  /* All clamps are required to be less or equal than these values */
> >  static struct uclamp_se uclamp_default[UCLAMP_CNT];
> >  
> > @@ -872,6 +892,28 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
> >  	return uclamp_idle_value(rq, clamp_id, clamp_value);
> >  }
> >  
> > +static inline void uclamp_sync_util_min_rt_default(struct task_struct *p,
> > +						   enum uclamp_id clamp_id)
> > +{
> > +	unsigned int default_util_min = sysctl_sched_uclamp_util_min_rt_default;
> > +	struct uclamp_se *uc_se;
> > +
> > +	/* Only sync for UCLAMP_MIN and RT tasks */
> > +	if (clamp_id != UCLAMP_MIN || !rt_task(p))
> > +		return;
> > +
> > +	uc_se = &p->uclamp_req[UCLAMP_MIN];
> > +
> > +	/*
> > +	 * Only sync if user didn't override the default request and the sysctl
> > +	 * knob has changed.
> > +	 */
> > +	if (uc_se->user_defined || uc_se->value == default_util_min)
> > +		return;
> > +
> > +	uclamp_se_set(uc_se, default_util_min, false);
> > +}
> 
> So afaict this is directly added to the enqueue/dequeue path, and we've
> recently already had complaints that uclamp is too slow.

I wanted to keep this function simpler.

> 
> Is there really no other way?

There is my first attempt which performs the sync @ task_woken_rt().

https://lore.kernel.org/lkml/20191220164838.31619-1-qais.yousef@arm.com/

I can revert the sync function to the simpler version defined in that patch
too.

I can potentially move this to uclamp_eff_value() too. Will need to think more
if this is enough. If task_woken_rt() is good for you, I'd say that's more
obviously correct and better to go with it.

FWIW, I think you're referring to Mel's notice in OSPM regarding the overhead.
Trying to see what goes on in there.

Thanks!

--
Qais Yousef
