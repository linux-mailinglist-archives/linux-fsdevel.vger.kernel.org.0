Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B54135A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgAINij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:38:39 -0500
Received: from foss.arm.com ([217.140.110.172]:59166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbgAINij (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:38:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70BF231B;
        Thu,  9 Jan 2020 05:38:38 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 741FA3F534;
        Thu,  9 Jan 2020 05:38:36 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:38:34 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        qperret@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200109133833.5da4jdgvhs2vkqxx@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108185650.GA9635@darkstar>
 <026e46e4-5d09-6260-0fa7-e365b0795c9a@arm.com>
 <20200109092137.GA2811@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109092137.GA2811@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/09/20 10:21, Patrick Bellasi wrote:
> On 09-Jan 01:35, Valentin Schneider wrote:
> > On 08/01/2020 18:56, Patrick Bellasi wrote:
> > > Here you are force setting the task-specific _requests_ to match the
> > > system-wide _constraints_. This is not required and it's also
> > > conceptually wrong, since you mix two concepts: requests and
> > > constraints.
> > > 
> > > System-default values must never be synchronized with task-specific
> > > values. This allows to always satisfy task _requests_ when not
> > > conflicting with system-wide (or task-group) _constraints_.
> > > 
> > > For example, assuming we have a task with util_min=500 and we keep
> > > changing the system-wide constraints, we would like the following
> > > effective clamps to be enforced:
> > > 
> > >    time | system-wide | task-specific | effective clamp
> > >    -----+-------------+---------------+-----------------
> > >      t0 |        1024 |           500 |             500
> > >      t1 |           0 |           500 |               0
> > >      t2 |         200 |           500 |             200
> > >      t3 |         600 |           500 |             500
> > > 
> > > If the taks should then change it's requested util_min:
> > > 
> > >    time | system-wide | task-specific | effective clamp
> > >    -----+-------------+---------------+----------------
> > >      t4 |         600 |          800  |             600
> > >      t6 |        1024 |          800  |             800
> > > 
> > > If you force set the task-specific requests to match the system-wide
> > > constraints, you cannot get the above described behaviors since you
> > > keep overwriting the task _requests_ with system-wide _constraints_.
> > > 
> > 
> > But is what Qais' proposing really a system-wide *constraint*? What we want
> > to do here is have a knob for the RT uclamp.min values, because gotomax isn't
> > viable (for mobile, you know the story!).
> 
> Yes I know, and I also see that what Qais is proposing can work.
> I'm just saying that IMO it's not the best way to add that feature.

What's the drawback? My proposed solution is a simple extension of what you did
to make sure RT task go to max OPP by default. So if this is wrong this
naturally means the original solution was wrong too?

> 
> > This leaves user_defined values alone, so you should be able to
> > reproduce exactly what you described above.
> 
> Yes, Qais is acutally affecting the effective value but it does it
> that from the RT sched class, which is not effective for sugov, and most
> importantly with a solution which is not the same we already use for
> CFS tasks.

Quentin suggested using uclamp_rq_inc() to update the default uclamp.min of the
RT tasks. This removes my call in task_woken_rt() - although I still have to
test it. Does this address your concern?

> 
> > If I take your t3 and t4 examples:
> > 
> > | time | system-wide | rt default | task-specific | user_defined | effective |                       
> > |------+-------------+------------+---------------+--------------+-----------|                       
> > | t3   |         600 |       1024 |           500 | Y            |       500 |                       
> > | t4   |         600 |       1024 |           800 | Y            |       600 |
> > 
> > If the values were *not* user-defined, then it would depend on the default
> > knob Qais is introducing:
> > 
> > | time | system-wide | rt default | task-specific | user_defined | effective |                       
> > |------+-------------+------------+---------------+--------------+-----------|                       
> > | t3   |         600 |       1024 |          1024 | N            |       600 |                       
> > | t4   |         600 |          0 |             0 | N            |         0 | 
> > 
> > It's not forcing the task-specific value to the system-wide RT value, it's
> > just using it as tweakable default. At least that's how I understand it,
> > did I miss something?
> 
> You right, but the "tweakable" default should be implemented the same
> way we do for CFS.

I am unable to see your point of view here I am afraid :(

> 
> > > Thus, requests and contraints must always float independently and
> > > used to compute the effective clamp at task wakeup time via:
> > > 
> > >    enqueue_task(rq, p, flags)
> > >      uclamp_rq_inc(rq, p)
> > >        uclamp_rq_inc_id(rq, p, clamp_id)
> > >          uclamp_eff_get(p, clamp_id)
> > >            uclamp_tg_restrict(p, clamp_id)
> > >      p->sched_class->enqueue_task(rq, p, flags)
> > > 
> > > where the task-specific request is restricted considering its task group
> > > effective value (the constraint).
> > > 
> > > Do note that the root task group effective value (for cfs) tasks is kept
> > > in sync with the system default value and propagated down to the
> > > effective value of all subgroups.
> > > 
> > > Do note also that the effective value is computed before calling into
> > > the scheduling class's enqueue_task(). Which means that we have the
> > > right value in place before we poke sugov.
> > > 
> > > Thus, a proper implementation of what you need should just
> > > replicate/generalize what we already do for cfs tasks.
> > > 
> > 
> > Reading
> > 
> >   7274a5c1bbec ("sched/uclamp: Propagate system defaults to the root group")
> > 
> > I see "The clamp values are not tunable at the level of the root task group".
> > This means that, for mobile systems where we want a default uclamp.min of 0
> > for RT tasks, we would need to create a cgroup for all RT tasks (and tweak
> > its uclamp.min, but from playing around a bit I see that defaults to 0).
> 
> That's not entirely true. In that patch we introduce cgroup support
> but, if you look at the code before that patch, for CFS tasks there is
> only:
>  - CFS task-specific values (min,max)=(0,1024) by default
>  - CFS system-wide tunables (min,max)=(1024,1024) by default
> and a change on the system-wide tunable allows for example to enforce
> a uclamp_max=200 on all tasks.
> 
> A similar solution can be implemented for RT tasks, where we have:
>  - RT task-specific values (min,max)=(1024,1024) by default
>  - RT system-wide tunables (min,max)=(1024,1024) by default
>  and a change on the system-wide tunable allows for example to enforce
>  a uclamp_min=200 on all tasks.
>  
> > (Would we need CONFIG_RT_GROUP_SCHED for this? IIRC there's a few pain points
> > when turning it on, but I think we don't have to if we just want things like
> > uclamp value propagation?)
> 
> No, the current design for CFS tasks works also on !CONFIG_CFS_GROUP_SCHED.
> That's because in this case:
>   - uclamp_tg_restrict() returns just the task requested value
>   - uclamp_eff_get() _always_ restricts the requested value considering
>     the system defaults
>  
> > It's quite more work than the simple thing Qais is introducing (and on both
> > user and kernel side).
> 
> But if in the future we will want to extend CGroups support to RT then
> we will feel the pains because we do the effective computation in two
> different places.
> 
> Do note that a proper CGroup support requires that the system default
> values defines the values for the root group and are consistently
> propagated down the hierarchy. Thus we need to add a dedicated pair of
> cgroup attributes, e.g. cpu.util.rt.{min.max}.
> 
> To recap, we don't need CGROUP support right now but just to add a new
> default tracking similar to what we do for CFS.
> 
> We already proposed such a support in one of the initial versions of
> the uclamp series:
>    Message-ID: <20190115101513.2822-10-patrick.bellasi@arm.com>
>    https://lore.kernel.org/lkml/20190115101513.2822-10-patrick.bellasi@arm.com/
> where a:
>    static struct uclamp_se uclamp_default_perf[UCLAMP_CNT];
> was added which was kind of similar/dual to what we do for CFS tasks
> by using:
>    static struct uclamp_se uclamp_default[UCLAMP_CNT];
> 
> That patch will not apply anymore of course, but the concepts still
> hold:
>   1. a new pair of sysctl_sched_uclamp_util_{min,max}_rt are available
>      in userspace
>   2. in sysctl_sched_uclamp_handler() we updated uclamp_default_perf
>      (maybe better calling it uclamp_default_rt?) according to the
>      sysfs tunables
>   3. the uclamp_default_rt values are used in uclamp_eff_get() to
>      _always_ restrict the task specific value returned by
>      uclamp_tg_restrict() (on !CONFIG_UCLAMP_TASK_GROUP builds)
> 
> We will have to add some RT specific logic in uclamp_eff_get(), but
> likely something as simple as the following should be ehought?
> 
> ---8<---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44123b4d14e8..f4a6b120da91 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -897,6 +897,15 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>         return uc_req;
>  }
>  
> +static inline struct uclamp_se
> +uclamp_default_get(struct task_struct *p, clamp_id)
> +{
> +  if (rt_task(p))
> +    return  uclamp_default_rt[clamp_id];

Is this supposed to come from the new sysctl?

I guess your patch assumes we remove the hardcoded set of uclamp_min for RT
task on creation?

> +
> +  return  uclamp_default[clamp_id];
> +}
> +
>  /*
>   * The effective clamp bucket index of a task depends on, by increasing
>   * priority:
> @@ -909,7 +918,7 @@ static inline struct uclamp_se
>  uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>  {
>         struct uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id);
> -       struct uclamp_se uc_max = uclamp_default[clamp_id];
> +       struct uclamp_se uc_max = uclamp_default_get(p clamp_id);
>  
>         /* System default restrictions always apply */
>         if (unlikely(uc_req.value > uc_max.value))

If I set the RT default.uclamp.min to 1024, but on task creation the RT task
uclamp.min is 0; how this will enforce the 1024?

Maybe I need to look at this again on another day when I don't have a headache
and my head is clearer.

But if your objection is merely based on the way the lazy sync/update of the
default value is done then this is workable.

As it stands I don't see how what you propose is cleaner or better than what
I propose. I see my solution is more straightforward and obvious than this one.
But I'll ponder over it more as I could have easily missed some subtlety here
or there :-)

Thanks a lot!

--
Qais Yousef

> 
> ---8<---
> 
> Adding a proper cgroup support would also be better. Otherwise, maybe
> for the time being we can live with just system-defaults to constrain
> the task-specific values with something like:
> 
> ---8<---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44123b4d14e8..73638c0cc65a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -877,6 +877,10 @@ static inline struct uclamp_se
>  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  {
>         struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> +
> +  if (rt_task(p))
> +    return uc_req;
> +
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
>         struct uclamp_se uc_max;
> 
> ---8<---
> 
> Or accept (without the above) that we can constraint RT tasks using
> CFS clamps (i.e. cpu.util.{min,max}) when running in a CGroups.
> Which is ugly but can work for many use-cases if runtimes like Android
> take create to create cgroup specifically dedicated to RT tasks. :/
> 
> -- 
> #include <best/regards.h>
> 
> Patrick Bellasi
