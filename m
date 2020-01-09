Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026C71359D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbgAINPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:15:31 -0500
Received: from foss.arm.com ([217.140.110.172]:58876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgAINPa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:15:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFEA131B;
        Thu,  9 Jan 2020 05:15:29 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24B63F534;
        Thu,  9 Jan 2020 05:15:27 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:15:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
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
Message-ID: <20200109131525.hcrhenhktrlbrlog@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108185650.GA9635@darkstar>
 <026e46e4-5d09-6260-0fa7-e365b0795c9a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <026e46e4-5d09-6260-0fa7-e365b0795c9a@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/09/20 01:35, Valentin Schneider wrote:
> On 08/01/2020 18:56, Patrick Bellasi wrote:
> > Here you are force setting the task-specific _requests_ to match the
> > system-wide _constraints_. This is not required and it's also
> > conceptually wrong, since you mix two concepts: requests and
> > constraints.
> > 
> > System-default values must never be synchronized with task-specific
> > values. This allows to always satisfy task _requests_ when not
> > conflicting with system-wide (or task-group) _constraints_.
> > 
> > For example, assuming we have a task with util_min=500 and we keep
> > changing the system-wide constraints, we would like the following
> > effective clamps to be enforced:
> > 
> >    time | system-wide | task-specific | effective clamp
> >    -----+-------------+---------------+-----------------
> >      t0 |        1024 |           500 |             500
> >      t1 |           0 |           500 |               0
> >      t2 |         200 |           500 |             200
> >      t3 |         600 |           500 |             500
> > 
> > If the taks should then change it's requested util_min:
> > 
> >    time | system-wide | task-specific | effective clamp
> >    -----+-------------+---------------+----------------
> >      t4 |         600 |          800  |             600
> >      t6 |        1024 |          800  |             800
> > 
> > If you force set the task-specific requests to match the system-wide
> > constraints, you cannot get the above described behaviors since you
> > keep overwriting the task _requests_ with system-wide _constraints_.
> > 
> 
> But is what Qais' proposing really a system-wide *constraint*? What we want
> to do here is have a knob for the RT uclamp.min values, because gotomax isn't
> viable (for mobile, you know the story!). This leaves user_defined values
> alone, so you should be able to reproduce exactly what you described above.
> If I take your t3 and t4 examples:
> 
> | time | system-wide | rt default | task-specific | user_defined | effective |                       
> |------+-------------+------------+---------------+--------------+-----------|                       
> | t3   |         600 |       1024 |           500 | Y            |       500 |                       
> | t4   |         600 |       1024 |           800 | Y            |       600 |
> 
> If the values were *not* user-defined, then it would depend on the default
> knob Qais is introducing:
> 
> | time | system-wide | rt default | task-specific | user_defined | effective |                       
> |------+-------------+------------+---------------+--------------+-----------|                       
> | t3   |         600 |       1024 |          1024 | N            |       600 |                       
> | t4   |         600 |          0 |             0 | N            |         0 | 
> 
> It's not forcing the task-specific value to the system-wide RT value, it's
> just using it as tweakable default. At least that's how I understand it,
> did I miss something?

Yes that's exactly what it should be. I am making the existing hardcoded value
a configurable parameter + some logic to make sure the new value propagates
correctly when it changes since the hardcoded value is set once when a task is
created.

> 
> > Thus, requests and contraints must always float independently and
> > used to compute the effective clamp at task wakeup time via:
> > 
> >    enqueue_task(rq, p, flags)
> >      uclamp_rq_inc(rq, p)
> >        uclamp_rq_inc_id(rq, p, clamp_id)
> >          uclamp_eff_get(p, clamp_id)
> >            uclamp_tg_restrict(p, clamp_id)
> >      p->sched_class->enqueue_task(rq, p, flags)
> > 
> > where the task-specific request is restricted considering its task group
> > effective value (the constraint).
> > 
> > Do note that the root task group effective value (for cfs) tasks is kept
> > in sync with the system default value and propagated down to the
> > effective value of all subgroups.
> > 
> > Do note also that the effective value is computed before calling into
> > the scheduling class's enqueue_task(). Which means that we have the
> > right value in place before we poke sugov.
> > 
> > Thus, a proper implementation of what you need should just
> > replicate/generalize what we already do for cfs tasks.
> > 
> 
> Reading
> 
>   7274a5c1bbec ("sched/uclamp: Propagate system defaults to the root group")
> 
> I see "The clamp values are not tunable at the level of the root task group".
> This means that, for mobile systems where we want a default uclamp.min of 0
> for RT tasks, we would need to create a cgroup for all RT tasks (and tweak
> its uclamp.min, but from playing around a bit I see that defaults to 0).
> 
> (Would we need CONFIG_RT_GROUP_SCHED for this? IIRC there's a few pain points
> when turning it on, but I think we don't have to if we just want things like
> uclamp value propagation?)
> 
> It's quite more work than the simple thing Qais is introducing (and on both
> user and kernel side).

I don't see the daemon solution is particularly pretty or intuitive for admins
to control the default boost value of the RT tasks.

Thanks

--
Qais Yousef
