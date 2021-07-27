Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97A93D74E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhG0MRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhG0MQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:16:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A064C061760;
        Tue, 27 Jul 2021 05:16:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n6so15599822ljp.9;
        Tue, 27 Jul 2021 05:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NQBBwSPgfulflqvM+/aw3aE83WUUfrNneUJN71v6DU=;
        b=VGmxvd/JkEHXxZIUtB4QfEi2ADwVpb15bwucZuagRFH+Ele852Bp3uTFg/yHwmVyrp
         r3i9I1mu65mOLKGc1S5koH2I4RXe/d9vfqK07hfQbtQFL5ab8RkmjmwWe3hnsWdiFZBH
         9zxfjcZoSpTm2IbwD42YleGpwQ7h3kCWo5NxDlkOVRf3HsY8tpSZg/UFmnL546H3dUll
         hy8XOu8RMVHOGnZysxuBb+rcCe2TFlR7Kgcr4k/Cw2T6S2KgR9MaJO2VjoqwpWda6lvq
         +JSBfGTVcxLWs4ylRj58K7lkIO4LWs3YQpQPL4sjaMRHUWf6TQqpuQVWTsto2G9fwmPP
         nxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NQBBwSPgfulflqvM+/aw3aE83WUUfrNneUJN71v6DU=;
        b=dW9lzyFuoux1F/888YOdNS/aldKaVS8CzcBJ1yXzJe3Vb4G86NKwpUjJFJRyuv1+X3
         3lj/17/FAtBYl6lqeUZoQbM4we/5LBVhuZTy3exMNiP3+tq3KYJqwGy2/k3oznP1W/MV
         lyq78ZjdUZ44SsG+ZyP6uSDo2KyNoyTbQTlMAmknauICb2wnL9JrUzNN1PMZhih8gJX7
         fKLO2jOUoge0LO/4bfJv93M1NAq3GBjhWUtCXAH9GPYbsTqkhBz7Qss7jXZ8KFWxcrHG
         ykRJw+3c8cZI8qjtN37iDdxIGCQ2sAFyRIr198GIsFDchoYZIfKsSoOnqVJJl03pGELt
         Kdmg==
X-Gm-Message-State: AOAM530e7ERvh/xYd33XYfF+bsLuoIZzwBeudx1Ik79+7SjDa8LFZ/NO
        bKAJ+DGbve62Gh4Rd2JfM+OOY33HNkEnbvASh8c=
X-Google-Smtp-Source: ABdhPJwQmboxXO1VA4JaD4Tyg8n6eD+/Fml8aIDqg5fs2lYShSbBvXO+CQFnI4at0npMT0KZd/w1i1NlXg0QUv8fvZc=
X-Received: by 2002:a2e:7a18:: with SMTP id v24mr15267937ljc.420.1627388217937;
 Tue, 27 Jul 2021 05:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210721075751.542-1-xuewen.yan94@gmail.com> <d8e14c3c-0eab-2d4d-693e-fb647c7f7c8c@arm.com>
 <CAB8ipk9rO7majqxo0eTnPf5Xs-c4iF8TPQqonCjv6sCd2J6ONA@mail.gmail.com> <20210726171716.jow6qfbxx6xr5q3t@e107158-lin.cambridge.arm.com>
In-Reply-To: <20210726171716.jow6qfbxx6xr5q3t@e107158-lin.cambridge.arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 27 Jul 2021 20:16:25 +0800
Message-ID: <CAB8ipk9cZ4amrarQSN9TtqEwc42RFM1cBUGsTYKuF0maRFx4Zw@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Introduce a method to transform UCLAMP_MIN
 into BOOST
To:     Qais Yousef <qais.yousef@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qais

On Tue, Jul 27, 2021 at 1:17 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> > > >
> > > > The uclamp can clamp the util within uclamp_min and uclamp_max,
> > > > it is benifit to some tasks with small util, but for those tasks
> > > > with middle util, it is useless.
>
> It's not really useless, it works as it's designed ;-)

Yes, my expression problem...

>
> As Dietmar highlighted, you need to pick a higher boost value that gives you
> the best perf/watt for your use case.
>
> I assume that this is a patch in your own Android 5.4 kernel, right? I'm not

Yes, the patch indeed is used in my own Android12 with kernel5.4.

> aware of any such patch in Android Common Kernel. If it's there, do you mind
> pointing me to the gerrit change that introduced it?

emmm, sorry I kind of understand what that means.  Your means is  what
I need to do is to send this patch to google?

>
> > Because the kernel used in Android do not have the schedtune, and the
> > uclamp can not
> > boost all the util, and this is the reason for the design of the patch.
>
> Do you have a specific workload in mind here that is failing? It would help if
> you can explain in detail the mode of failure you're seeing to help us
> understand the problem better.

The patch has has been working with me for a while, I can redo this
data, but this might take a while :)

> >
> > >
> > > > Scenario:
> > > > if the task_util = 200, {uclamp_min, uclamp_max} = {100, 1024}
> > > >
> > > > without patch:
> > > > clamp_util = 200;
> > > >
> > > > with patch:
> > > > clamp_util = 200 + (100 / 1024) * (1024 - 200) = 280;
>
> If a task util was 200, how long does it take for it to reach 280? Why do you
> need to have this immediate boost value applied and can't wait for this time to
> lapse? I'm not sure, but ramping up by 80 points shouldn't take *that* long,
> but don't quote me on this :-)

Here is just one example to illustrate that , with this patch, It also
can boost the util which in {UCLAMP_MIN, UCLAMP_MAX}...

>
> > >
> > > The same could be achieved by using {uclamp_min, uclamp_max} = {280, 1024}?
> >
> > Yes, for per-task, that is no problem, but for per-cgroup, most times,
> > we can not always only put the special task into the cgroup.
> > For example, in Android , there is a cgroup named "top-app", often all
> > the threads of a app would be put into it.
> > But, not all threads of this app need to be boosted, if we set the
> > uclamp_min too big, the all the small task would be clamped to
> > uclamp_min,
> > the power consumption would be increased, howerever, if setting the
> > uclamp_min smaller, the performance may be increased.
> > Such as:
> > a task's util is 50,  {uclamp_min, uclamp_max} = {100, 1024}
> > the boost_util =  50 + (100 / 1024) * (1024 - 50) = 145;
> > but if we set {uclamp_min, uclamp_max} = {280, 1024}, without patch:
> > the clamp_util = 280.
>
> I assume {uclamp_min, uclamp_max} = {145, 1024} is not good enough because you
> want this 200 task to be boosted to 280. One can argue that not all tasks at
> 200 need to be boosted to 280 too. So the question is, like above, what type
> of tasks that are failing here and how do you observe this failure? It seems
> there's a class of performance critical tasks that need this fast boosting.
> Can't you identify them and boost them individually?

Yes, the best way to do that is boosting them individually, but
usually, it may not be so easy...

>
> There's nothing that prevents you to change the uclamp_min of the cgroup
> dynamically by the way. Like for instance when an app launches you can choose
> a high boost value then lower it once it started up. Or if you know the top-app
> is a game and you want to guarantee a good minimum performance for it; you
> can choose to increase the top-app uclamp_min value too in a special gaming
> mode or something.
>
> For best perf/watt, using the per-task API is the best way forward. But
> I understand it'll take time for apps/android framework to learn how to use the
> per-task API most effectively. But it is what we should be aiming for.

Yes, and I have learned that there is an ADPF framework in Android12,
It can dynamically adjust the per-task's  uclamp_min/max to boost the
task.
Compared to the rough behavior of patch, ADPF may perform better , but
I need to test and compare them...

Thanks!
xuewen.yan
