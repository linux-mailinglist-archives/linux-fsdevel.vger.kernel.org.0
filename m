Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143AE3D770D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbhG0NpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 09:45:15 -0400
Received: from foss.arm.com ([217.140.110.172]:39180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236576AbhG0NpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:45:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 394DC1FB;
        Tue, 27 Jul 2021 06:45:14 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8BCF3F66F;
        Tue, 27 Jul 2021 06:45:11 -0700 (PDT)
Date:   Tue, 27 Jul 2021 14:45:09 +0100
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
Message-ID: <20210727134509.j2fhimhp4dht3hir@e107158-lin.cambridge.arm.com>
References: <20210721075751.542-1-xuewen.yan94@gmail.com>
 <d8e14c3c-0eab-2d4d-693e-fb647c7f7c8c@arm.com>
 <CAB8ipk9rO7majqxo0eTnPf5Xs-c4iF8TPQqonCjv6sCd2J6ONA@mail.gmail.com>
 <20210726171716.jow6qfbxx6xr5q3t@e107158-lin.cambridge.arm.com>
 <CAB8ipk9cZ4amrarQSN9TtqEwc42RFM1cBUGsTYKuF0maRFx4Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk9cZ4amrarQSN9TtqEwc42RFM1cBUGsTYKuF0maRFx4Zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xuewen

On 07/27/21 20:16, Xuewen Yan wrote:
> Hi Qais
> 
> On Tue, Jul 27, 2021 at 1:17 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > > > >
> > > > > The uclamp can clamp the util within uclamp_min and uclamp_max,
> > > > > it is benifit to some tasks with small util, but for those tasks
> > > > > with middle util, it is useless.
> >
> > It's not really useless, it works as it's designed ;-)
> 
> Yes, my expression problem...

No worries, I understood what you meant. But I had to highlight that this is
the intended design behavior :-)

> 
> >
> > As Dietmar highlighted, you need to pick a higher boost value that gives you
> > the best perf/watt for your use case.
> >
> > I assume that this is a patch in your own Android 5.4 kernel, right? I'm not
> 
> Yes, the patch indeed is used in my own Android12 with kernel5.4.
> 
> > aware of any such patch in Android Common Kernel. If it's there, do you mind
> > pointing me to the gerrit change that introduced it?
> 
> emmm, sorry I kind of understand what that means.  Your means is  what
> I need to do is to send this patch to google?

Oh no. I meant if you are *not* carrying this patch in your own, I'd appreciate
getting a link to when it was merged into Google' tree. But you already said
you carry this patch on your own kernel, so there's nothing to do :)

> 
> >
> > > Because the kernel used in Android do not have the schedtune, and the
> > > uclamp can not
> > > boost all the util, and this is the reason for the design of the patch.
> >
> > Do you have a specific workload in mind here that is failing? It would help if
> > you can explain in detail the mode of failure you're seeing to help us
> > understand the problem better.
> 
> The patch has has been working with me for a while, I can redo this
> data, but this might take a while :)

But there must have been a reason you introduced it in the first place, what
was that reason?

> 
> > >
> > > >
> > > > > Scenario:
> > > > > if the task_util = 200, {uclamp_min, uclamp_max} = {100, 1024}
> > > > >
> > > > > without patch:
> > > > > clamp_util = 200;
> > > > >
> > > > > with patch:
> > > > > clamp_util = 200 + (100 / 1024) * (1024 - 200) = 280;
> >
> > If a task util was 200, how long does it take for it to reach 280? Why do you
> > need to have this immediate boost value applied and can't wait for this time to
> > lapse? I'm not sure, but ramping up by 80 points shouldn't take *that* long,
> > but don't quote me on this :-)
> 
> Here is just one example to illustrate that , with this patch, It also
> can boost the util which in {UCLAMP_MIN, UCLAMP_MAX}...
> 
> >
> > > >
> > > > The same could be achieved by using {uclamp_min, uclamp_max} = {280, 1024}?
> > >
> > > Yes, for per-task, that is no problem, but for per-cgroup, most times,
> > > we can not always only put the special task into the cgroup.
> > > For example, in Android , there is a cgroup named "top-app", often all
> > > the threads of a app would be put into it.
> > > But, not all threads of this app need to be boosted, if we set the
> > > uclamp_min too big, the all the small task would be clamped to
> > > uclamp_min,
> > > the power consumption would be increased, howerever, if setting the
> > > uclamp_min smaller, the performance may be increased.
> > > Such as:
> > > a task's util is 50,  {uclamp_min, uclamp_max} = {100, 1024}
> > > the boost_util =  50 + (100 / 1024) * (1024 - 50) = 145;
> > > but if we set {uclamp_min, uclamp_max} = {280, 1024}, without patch:
> > > the clamp_util = 280.
> >
> > I assume {uclamp_min, uclamp_max} = {145, 1024} is not good enough because you
> > want this 200 task to be boosted to 280. One can argue that not all tasks at
> > 200 need to be boosted to 280 too. So the question is, like above, what type
> > of tasks that are failing here and how do you observe this failure? It seems
> > there's a class of performance critical tasks that need this fast boosting.
> > Can't you identify them and boost them individually?
> 
> Yes, the best way to do that is boosting them individually, but
> usually, it may not be so easy...

Yes I appreciate that, but cgroup is a coarse grain controller. Even with your
approach, you will still have to find the best compromise because some tasks
will get more boosting than they really need to and waste power even with your
approach.

For best outcome with uclamp; the cgroup should be used to specify the minimum
performance requirement of a class of tasks, then use the per-task API to fine
tune the settings for specific tasks.

I appreciate it'll take time to get there, but this is the best way forward.

If you have a specific use case that's failing, it will still be good to share
the details to think more if there's something we can do about it at the kernel
level.

Thanks

--
Qais Yousef
