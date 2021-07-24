Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538103D444B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 04:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhGXBXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 21:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhGXBXd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 21:23:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE7DC061575;
        Fri, 23 Jul 2021 19:04:05 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id n6so3844107ljp.9;
        Fri, 23 Jul 2021 19:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JRhtYPLybNJwcgnJP8HfuZI7PNUTaAlWJppJtdWcRvc=;
        b=GXfg42VlQV6TSuE7SMG54+5e4Wm5/bUTC+SZPv62iZGgAu+lxXZXoEz7OYyUxtwdmb
         uCBs3NOZZs5fitM9rDVyp52LEL+hPzPpn0+lwyqEc6FPaVw2ZOygQN/PkNJAfvB6D796
         rOAh9m87t4Zu5p/KOd+bX8yt3NpfxG+cPAi7VleUwktj3JOPyUxEWR7NOah7hvAN9tgO
         6AopFYdIr4/fKUzyXW+XEoiVt6EyGP+hQssGZ0jli410iYydcd8KnAJ9CgsYP0Q7a4CM
         XoD119IMcx5leIRGjJqa1LYqqtDFKJIwWHToLfG8LiJ2xF1qUvGPLHwbEilER9Yxo5fQ
         j+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JRhtYPLybNJwcgnJP8HfuZI7PNUTaAlWJppJtdWcRvc=;
        b=MOdxcuu+jA4+psUoFdCI2SsHYPJX447mk/kY5BtC8XQdvYyAsUYf42S4DjzXWq3LUx
         xVFap+gVrRViY+3uzCG9qk+CEuxcRQDq126LpO3zL62t/6j+3a7onjOYuXy+tNL9MWRT
         ULYGGGj1XChanX9renpbhXB7bGr/u1zjMI24sLothw15PJeCDA+JNcB8TvV3YCpqFu8S
         pBwONXfhyT9jmwsBDJVwMQTuPfLQz69/mLYIFnuVhNHGrU5fsF/i0YTYKNEtSFyiNbWU
         B/D6C8yPagbtVH87ZV50kCGwx9aIVqdetcZzSJX0koGpt5ESBsOifsEuc3ygQhUMUb4p
         5qFw==
X-Gm-Message-State: AOAM531yi4Il/H/cG4Kop1EQx++jC8zQxBOka4pVdXno6dVdWdPZ9GOr
        FYe/ZdirhrdR2aW69OiGn3YtnHGM7L8nYcHC8Ww=
X-Google-Smtp-Source: ABdhPJxNJS4oSyR2hw/z+Hqx8OU/eqpikPfIP+BOzCOnrCjphT+y3AstzMTqSYFxvKnpf3OUzGTvD5d701hEWqID39c=
X-Received: by 2002:a2e:b0cb:: with SMTP id g11mr4960465ljl.227.1627092243482;
 Fri, 23 Jul 2021 19:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210721075751.542-1-xuewen.yan94@gmail.com> <d8e14c3c-0eab-2d4d-693e-fb647c7f7c8c@arm.com>
In-Reply-To: <d8e14c3c-0eab-2d4d-693e-fb647c7f7c8c@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Sat, 24 Jul 2021 10:03:49 +0800
Message-ID: <CAB8ipk9rO7majqxo0eTnPf5Xs-c4iF8TPQqonCjv6sCd2J6ONA@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Introduce a method to transform UCLAMP_MIN
 into BOOST
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:19 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 21/07/2021 09:57, Xuewen Yan wrote:
> > From: Xuewen Yan <xuewen.yan@unisoc.com>
> >
> > The uclamp can clamp the util within uclamp_min and uclamp_max,
> > it is benifit to some tasks with small util, but for those tasks
> > with middle util, it is useless.
> >
> > To speed up those tasks, convert UCLAMP_MIN to BOOST,
> > the BOOST as schedtune does:
>
> Maybe it's important to note here that schedtune is the `out-of-tree`
> predecessor of uclamp used in some Android versions.

Yes, and the patch is indeed used on Android which kernel version is 5.4+.
Because the kernel used in Android do not have the schedtune, and the
uclamp can not
boost all the util, and this is the reason for the design of the patch.

>
> > boot =3D uclamp_min / SCHED_CAPACITY_SCALE;
> > margin =3D boost * (uclamp_max - util)
> > boost_util =3D util + margin;
>
> This is essentially the functionality from schedtune_margin() in
> Android, right?

YES!

>
> So in your implementation, the margin (i.e. what is added to the task
> util) not only depends on uclamp_min, but also on `uclamp_max`?

Yes, because we do not want to convert completely the uclamp to schedtune,
we also want user can limit some tasks, so the UCLAMP_MAX's meaning
has not been changed=EF=BC=8C
meanwhile, the UCLAMP_MAX also can affect the margin.

>
> > Scenario:
> > if the task_util =3D 200, {uclamp_min, uclamp_max} =3D {100, 1024}
> >
> > without patch:
> > clamp_util =3D 200;
> >
> > with patch:
> > clamp_util =3D 200 + (100 / 1024) * (1024 - 200) =3D 280;
>
> The same could be achieved by using {uclamp_min, uclamp_max} =3D {280, 10=
24}?

Yes, for per-task, that is no problem, but for per-cgroup, most times,
we can not always only put the special task into the cgroup.
For example, in Android , there is a cgroup named "top-app", often all
the threads of a app would be put into it.
But, not all threads of this app need to be boosted, if we set the
uclamp_min too big, the all the small task would be clamped to
uclamp_min,
the power consumption would be increased, howerever, if setting the
uclamp_min smaller, the performance may be increased.
Such as:
a task's util is 50,  {uclamp_min, uclamp_max} =3D {100, 1024}
the boost_util =3D  50 + (100 / 1024) * (1024 - 50) =3D 145;
but if we set {uclamp_min, uclamp_max} =3D {280, 1024}, without patch:
the clamp_util =3D 280.

>
> Uclamp_min is meant to be the final `boost( =3D util + margin)`
> information. You just have to set it appropriately to the task (via
> per-task and/or per-cgroup interface).

As said above, it is difficult to set the per-cgroup's uclamp_min for
all tasks in Android sometimes.

>
> Uclamp_min is for `boosting`, Uclamp max is for `capping` CPU frequency.

Yes!

>

Thanks!
xuewen
