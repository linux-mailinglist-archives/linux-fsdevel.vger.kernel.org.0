Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738903D658C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 19:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhGZQhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 12:37:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240553AbhGZQgw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:36:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60EC36D;
        Mon, 26 Jul 2021 10:17:20 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 499353F66F;
        Mon, 26 Jul 2021 10:17:18 -0700 (PDT)
Date:   Mon, 26 Jul 2021 18:17:16 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/uclamp: Introduce a method to transform UCLAMP_MIN
 into BOOST
Message-ID: <20210726171716.jow6qfbxx6xr5q3t@e107158-lin.cambridge.arm.com>
References: <20210721075751.542-1-xuewen.yan94@gmail.com>
 <d8e14c3c-0eab-2d4d-693e-fb647c7f7c8c@arm.com>
 <CAB8ipk9rO7majqxo0eTnPf5Xs-c4iF8TPQqonCjv6sCd2J6ONA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk9rO7majqxo0eTnPf5Xs-c4iF8TPQqonCjv6sCd2J6ONA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xuewen

On 07/24/21 10:03, Xuewen Yan wrote:
> On Fri, Jul 23, 2021 at 11:19 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> >
> > On 21/07/2021 09:57, Xuewen Yan wrote:
> > > From: Xuewen Yan <xuewen.yan@unisoc.com>
> > >
> > > The uclamp can clamp the util within uclamp_min and uclamp_max,
> > > it is benifit to some tasks with small util, but for those tasks
> > > with middle util, it is useless.

It's not really useless, it works as it's designed ;-)

As Dietmar highlighted, you need to pick a higher boost value that gives you
the best perf/watt for your use case.

> > >
> > > To speed up those tasks, convert UCLAMP_MIN to BOOST,
> > > the BOOST as schedtune does:
> >
> > Maybe it's important to note here that schedtune is the `out-of-tree`
> > predecessor of uclamp used in some Android versions.
> 
> Yes, and the patch is indeed used on Android which kernel version is 5.4+.

I assume that this is a patch in your own Android 5.4 kernel, right? I'm not
aware of any such patch in Android Common Kernel. If it's there, do you mind
pointing me to the gerrit change that introduced it?

> Because the kernel used in Android do not have the schedtune, and the
> uclamp can not
> boost all the util, and this is the reason for the design of the patch.

Do you have a specific workload in mind here that is failing? It would help if
you can explain in detail the mode of failure you're seeing to help us
understand the problem better.

> 
> >
> > > boot = uclamp_min / SCHED_CAPACITY_SCALE;
> > > margin = boost * (uclamp_max - util)
> > > boost_util = util + margin;
> >
> > This is essentially the functionality from schedtune_margin() in
> > Android, right?
> 
> YES!
> 
> >
> > So in your implementation, the margin (i.e. what is added to the task
> > util) not only depends on uclamp_min, but also on `uclamp_max`?
> 
> Yes, because we do not want to convert completely the uclamp to schedtune,
> we also want user can limit some tasks, so the UCLAMP_MAX's meaning
> has not been changed，
> meanwhile, the UCLAMP_MAX also can affect the margin.
> 
> >
> > > Scenario:
> > > if the task_util = 200, {uclamp_min, uclamp_max} = {100, 1024}
> > >
> > > without patch:
> > > clamp_util = 200;
> > >
> > > with patch:
> > > clamp_util = 200 + (100 / 1024) * (1024 - 200) = 280;

If a task util was 200, how long does it take for it to reach 280? Why do you
need to have this immediate boost value applied and can't wait for this time to
lapse? I'm not sure, but ramping up by 80 points shouldn't take *that* long,
but don't quote me on this :-)

> >
> > The same could be achieved by using {uclamp_min, uclamp_max} = {280, 1024}?
> 
> Yes, for per-task, that is no problem, but for per-cgroup, most times,
> we can not always only put the special task into the cgroup.
> For example, in Android , there is a cgroup named "top-app", often all
> the threads of a app would be put into it.
> But, not all threads of this app need to be boosted, if we set the
> uclamp_min too big, the all the small task would be clamped to
> uclamp_min,
> the power consumption would be increased, howerever, if setting the
> uclamp_min smaller, the performance may be increased.
> Such as:
> a task's util is 50,  {uclamp_min, uclamp_max} = {100, 1024}
> the boost_util =  50 + (100 / 1024) * (1024 - 50) = 145;
> but if we set {uclamp_min, uclamp_max} = {280, 1024}, without patch:
> the clamp_util = 280.

I assume {uclamp_min, uclamp_max} = {145, 1024} is not good enough because you
want this 200 task to be boosted to 280. One can argue that not all tasks at
200 need to be boosted to 280 too. So the question is, like above, what type
of tasks that are failing here and how do you observe this failure? It seems
there's a class of performance critical tasks that need this fast boosting.
Can't you identify them and boost them individually?

There's nothing that prevents you to change the uclamp_min of the cgroup
dynamically by the way. Like for instance when an app launches you can choose
a high boost value then lower it once it started up. Or if you know the top-app
is a game and you want to guarantee a good minimum performance for it; you
can choose to increase the top-app uclamp_min value too in a special gaming
mode or something.

For best perf/watt, using the per-task API is the best way forward. But
I understand it'll take time for apps/android framework to learn how to use the
per-task API most effectively. But it is what we should be aiming for.

Cheers

--
Qais Yousef

> 
> >
> > Uclamp_min is meant to be the final `boost( = util + margin)`
> > information. You just have to set it appropriately to the task (via
> > per-task and/or per-cgroup interface).
> 
> As said above, it is difficult to set the per-cgroup's uclamp_min for
> all tasks in Android sometimes.
> 
> >
> > Uclamp_min is for `boosting`, Uclamp max is for `capping` CPU frequency.
> 
> Yes!
> 
> >
> 
> Thanks!
> xuewen
