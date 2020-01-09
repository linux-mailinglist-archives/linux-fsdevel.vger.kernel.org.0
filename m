Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38EAB1359AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgAINBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:01:05 -0500
Received: from foss.arm.com ([217.140.110.172]:58734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbgAINBF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:01:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702C231B;
        Thu,  9 Jan 2020 05:01:02 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73F623F534;
        Thu,  9 Jan 2020 05:01:00 -0800 (PST)
Date:   Thu, 9 Jan 2020 13:00:58 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, qperret@google.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200109130052.feebuwuuvwvm324w@e107158-lin.cambridge.arm.com>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108134448.GG2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108134448.GG2844@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/08/20 14:44, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 04:48:38PM +0000, Qais Yousef wrote:
> > RT tasks by default try to run at the highest capacity/performance
> > level. When uclamp is selected this default behavior is retained by
> > enforcing the uclamp_util_min of the RT tasks to be
> > uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> > value.
> > 
> > See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> > 
> > On battery powered devices, this default behavior could consume more
> > power, and it is desired to be able to tune it down. While uclamp allows
> > tuning this by changing the uclamp_util_min of the individual tasks, but
> > this is cumbersome and error prone.
> > 
> > To control the default behavior globally by system admins and device
> > integrators, introduce the new sysctl_sched_rt_uclamp_util_min to
> > change the default uclamp_util_min value of the RT tasks.
> > 
> > Whenever the new default changes, it'd be applied on the next wakeup of
> > the RT task, assuming that it still uses the system default value and
> > not a user applied one.
> 
> This is because these RT tasks are not in a cgroup or not affected by
> cgroup settings? I feel the justification is a little thin here.

The uclamp_min for RT tasks is always hardcoded to 1024 at the moment. So even
if they belong to a cgroup->uclamp_min = 0, they'll still run at max frequency,
no?

To control this behavior with cgroups one must have a daemon that:

	while true:
		for_each_rt_task:
			set task->uclamp_min = 0
			add to rt_cgroup
			rt_cgroup.util_min = $DESIRED_DEFAULT_RT_UCLMAP_MIN

		sleep $M_SECONDS

The above will overwrite the task util_min in case it was modified by the app
or sysadmin.


OR we can do

The counter intuitive usage of uclamp_max to throttle the default boost

	while true:
		for_each_rt_task():
			add to rt_cgroup
			rt_cgroup.util_max = $DESIRED_DEFAULT_RT_UCLMAP_MIN

		sleep $M_SECONDS

Or did I miss something?

Apologies if the justification was thin. The problem seemed too obvious to me
and maybe I missed that it might not be.

What I am trying to do is make this hardcoded value a configurable parameter so
it can be set to anything at runtime. Which gives the desired behavior of
giving the RT task the minimum boost without pushing the system to highest
performance level which would consume a lot of energy.

I anticipate this to be set once in init scripts. But I can see how this can be
modified later because for instance the device is charging and power isn't an
issue so get the max performance anyway.

Also different power save mode can modify this value at runtime.

I think this would benefit mobile and laptop equally.

Keep in mind that kthreads and irq_threads are RT tasks too. So not all
RT tasks in the system are user triggered.

> 
> > If the uclamp_util_min of an RT task is 0, then the RT utilization of
> > the rq is used to drive the frequency selection in schedutil for RT
> > tasks.
> 
> Did cpu_uclamp_write() forget to check for input<0 ?

Hmm just tried that and it seems so

# echo -1 > cpu.uclamp.min
# cat cpu.uclamp.min
42949671.96

capacity_from_percent(); we check for

7301                 if (req.percent > UCLAMP_PERCENT_SCALE) {
7302                         req.ret = -ERANGE;
7303                         return req;
7304                 }

But req.percent is s64, maybe it should be u64?

Thanks

--
Qais Yousef
