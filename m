Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38170135103
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 02:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgAIBfL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 20:35:11 -0500
Received: from foss.arm.com ([217.140.110.172]:52546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgAIBfL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:35:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51B8B31B;
        Wed,  8 Jan 2020 17:35:10 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36C023F6C4;
        Wed,  8 Jan 2020 17:35:08 -0800 (PST)
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
To:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>
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
        qperret@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108185650.GA9635@darkstar>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <026e46e4-5d09-6260-0fa7-e365b0795c9a@arm.com>
Date:   Thu, 9 Jan 2020 01:35:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108185650.GA9635@darkstar>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/01/2020 18:56, Patrick Bellasi wrote:
> Here you are force setting the task-specific _requests_ to match the
> system-wide _constraints_. This is not required and it's also
> conceptually wrong, since you mix two concepts: requests and
> constraints.
> 
> System-default values must never be synchronized with task-specific
> values. This allows to always satisfy task _requests_ when not
> conflicting with system-wide (or task-group) _constraints_.
> 
> For example, assuming we have a task with util_min=500 and we keep
> changing the system-wide constraints, we would like the following
> effective clamps to be enforced:
> 
>    time | system-wide | task-specific | effective clamp
>    -----+-------------+---------------+-----------------
>      t0 |        1024 |           500 |             500
>      t1 |           0 |           500 |               0
>      t2 |         200 |           500 |             200
>      t3 |         600 |           500 |             500
> 
> If the taks should then change it's requested util_min:
> 
>    time | system-wide | task-specific | effective clamp
>    -----+-------------+---------------+----------------
>      t4 |         600 |          800  |             600
>      t6 |        1024 |          800  |             800
> 
> If you force set the task-specific requests to match the system-wide
> constraints, you cannot get the above described behaviors since you
> keep overwriting the task _requests_ with system-wide _constraints_.
> 

But is what Qais' proposing really a system-wide *constraint*? What we want
to do here is have a knob for the RT uclamp.min values, because gotomax isn't
viable (for mobile, you know the story!). This leaves user_defined values
alone, so you should be able to reproduce exactly what you described above.
If I take your t3 and t4 examples:

| time | system-wide | rt default | task-specific | user_defined | effective |                       
|------+-------------+------------+---------------+--------------+-----------|                       
| t3   |         600 |       1024 |           500 | Y            |       500 |                       
| t4   |         600 |       1024 |           800 | Y            |       600 |

If the values were *not* user-defined, then it would depend on the default
knob Qais is introducing:

| time | system-wide | rt default | task-specific | user_defined | effective |                       
|------+-------------+------------+---------------+--------------+-----------|                       
| t3   |         600 |       1024 |          1024 | N            |       600 |                       
| t4   |         600 |          0 |             0 | N            |         0 | 

It's not forcing the task-specific value to the system-wide RT value, it's
just using it as tweakable default. At least that's how I understand it,
did I miss something?

> Thus, requests and contraints must always float independently and
> used to compute the effective clamp at task wakeup time via:
> 
>    enqueue_task(rq, p, flags)
>      uclamp_rq_inc(rq, p)
>        uclamp_rq_inc_id(rq, p, clamp_id)
>          uclamp_eff_get(p, clamp_id)
>            uclamp_tg_restrict(p, clamp_id)
>      p->sched_class->enqueue_task(rq, p, flags)
> 
> where the task-specific request is restricted considering its task group
> effective value (the constraint).
> 
> Do note that the root task group effective value (for cfs) tasks is kept
> in sync with the system default value and propagated down to the
> effective value of all subgroups.
> 
> Do note also that the effective value is computed before calling into
> the scheduling class's enqueue_task(). Which means that we have the
> right value in place before we poke sugov.
> 
> Thus, a proper implementation of what you need should just
> replicate/generalize what we already do for cfs tasks.
> 

Reading

  7274a5c1bbec ("sched/uclamp: Propagate system defaults to the root group")

I see "The clamp values are not tunable at the level of the root task group".
This means that, for mobile systems where we want a default uclamp.min of 0
for RT tasks, we would need to create a cgroup for all RT tasks (and tweak
its uclamp.min, but from playing around a bit I see that defaults to 0).

(Would we need CONFIG_RT_GROUP_SCHED for this? IIRC there's a few pain points
when turning it on, but I think we don't have to if we just want things like
uclamp value propagation?)

It's quite more work than the simple thing Qais is introducing (and on both
user and kernel side).
