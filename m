Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5572047237A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 10:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhLMJGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 04:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhLMJGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:06:51 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D73C061574;
        Mon, 13 Dec 2021 01:06:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so50382427edu.4;
        Mon, 13 Dec 2021 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cr6D9X2rQDBDAjTNF+GT+xNI92Fsq0xePeLlYSfvP8=;
        b=C+piuoW1mF8N6riS96wsQU0Bv5li477K0kGbpWFxNtfSzpo4balyFWBhu1LJ+2/Nf1
         QlCdLzeRPcamd2NLCFDdRQcGUV54Dhc5tOC3kEKLSyiuKsup24cVAD/P1/tu16rwOhbg
         ich/p5e3Lb7qs7x1sVAqF1fInb4gyIb/f9Zomezb2tcEWhzWRLCpVuxcvwyQ92HdGqwf
         oLmaubtMNFxcI5Jh5w2OpS9R/KdZ84e/3SvZwYyAbRhvnTHJpGrMBDhgpUpKvR13oZuY
         kgORuIM1oi8sAbW1p5v1o7WHljesio4Vu2cr0N6i6a3siABVeu0d6x3kQT1Unv4Hn7Es
         ihew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cr6D9X2rQDBDAjTNF+GT+xNI92Fsq0xePeLlYSfvP8=;
        b=tgStteQIXewkzYMu2Wdu1GjHQenKzHd6seIDTGcfkIdv9uY8xGNMVKmQXyGe/q37TN
         1siDg88z2dVok7ih7p69kA1ikNFxfiCDHd5ph5fLMt13/ukmLpe1XYBGIg16EYbubO6V
         Alq0plvcGTs1kQe+J4iAGwjCIJkNdgDzzK/yGSAtLqLXg0z4q1F/Li/Ij8Tl4qJi3zj0
         rnmvpfW3dPPUUiak3Mz2+nHoYq3878KubsNcJLtfG4uwTM2iaaRFKnr0nl/X2UXxQZMx
         iQO02oN6hfyFLf7M3E4ei1Iw/SpGYQAGVQXpLWEZ41ecOeYbIIctIhLbziO/71IFQ2z2
         8Wcw==
X-Gm-Message-State: AOAM531Etr8IJM4jA2jO8mImJrdu66qeIsKfDsZ+a/doXefPFROrGus9
        hmOuznoPHqB3zWNJiXcs1Jn411HMGsOYQZwxA8s=
X-Google-Smtp-Source: ABdhPJzz8oBOy2H/iB5BN+e8Y0Dv89Ldehxl5xRR9Mq8bhm3SyG+UEfSDnYPq3378eeJkn9M8nc5YlVHiSqgkYinnrc=
X-Received: by 2002:a05:6402:544:: with SMTP id i4mr63041261edx.9.1639386409639;
 Mon, 13 Dec 2021 01:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20211130201652.2218636d@mail.inbox.lv> <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org> <20211213051521.21f02dd2@mail.inbox.lv>
In-Reply-To: <20211213051521.21f02dd2@mail.inbox.lv>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 13 Dec 2021 22:06:38 +1300
Message-ID: <CAGsJ_4wZbtP6aBVDHB033xkvEDr9tvkqimMsfWrmfHSf-hbaog@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working set
To:     Alexey Avramov <hakavlad@inbox.lv>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        ValdikSS <iam@valdikss.org.ru>, Linux-MM <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, hdanton@sina.com,
        riel@surriel.com, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:23 AM Alexey Avramov <hakavlad@inbox.lv> wrote:
>
> > I don't think that the limits should be "N bytes on the current node".
>
> It's not a problem to add a _ratio knobs. How the tunables should look and
> what their default values should be can still be discussed. Now my task is
> to prove that the problem exists and the solution I have proposed is
> effective and correct.
>
> > the various zones have different size as well.
>
> I'll just point out the precedent: sc->file_is_tiny works the same way
> (per node) as suggested sc->clean_below_min etc.
>
> > We do already have a lot of sysctls for controlling these sort of
> > things.
>
> There are many of them, but there are no most important ones for solving
> the problem - those that are proposed in the patch.
>
> > Was much work put into attempting to utilize the existing
> > sysctls to overcome these issues?
>
> Oh yes! This is all I have been doing for the last 4 years. At the end of
> 2017, I was forced to write my own userspace OOM killer [1] to resist
> freezes (I didn't know then that earlyoom already existed).

I'd like to understand the problem of the existing sysctls.  For example,
if we want to keep more free memory, the min free kbytes can help. On
the other hand, if we want to keep more file-backed memory,  a big
swappiness will help.
I believe you have tried all of the above and they have all failed to satisfy
your use cases, but I really expect a more detailed explanation why they
don't work.

>
> In 2018, Facebook came on the scene with its oomd [2]:
>
> > The traditional Linux OOM killer works fine in some cases, but in others
> > it kicks in too late, resulting in the system entering a livelock for an
> > indeterminate period.
>
> Here we can assume that Facebook's engineers haven't found the kernel
> sysctl tunables that would satisfy them.
>
> In 2019 LKML people could not offer Artem S. Tashkinov a simple solution to
> the problem he described [3]. In addition to discussing user-space
> solutions, 2 kernel-side solutions are proposed:
>
> - PSI-based solution was proposed by Johannes Weiner [4].
> - Reserve a fixed (configurable) amount of RAM for caches, and trigger OOM
>   killer earlier, before most UI code is evicted from memory was suggested
>   by ndrw [5]. This is what I propose to accept in the mainline. It is the
>   right way to go.

isn't this something like setting a bigger min_free_kbytes?

>
> None of the suggestions posted in that thread were accepted in the
> mainline.
>
> In 2019, at the same time, Fedora Workstation group discussed [6]
> Issue #98 Better interactivity in low-memory situations.
> As a result, it was decided to enable earlyoom by default for Fedora
> Workstation 32. No existing sysctl was found to be of much help.
> It was also suggested to use a swap on zram and to enable the cgroup-based
> uresourced daemon to protect the user session.
>
> So, the problem described by Artem S. Tashkinov in 2019 is still easily
> reproduced in 2021. The assurances of the maintainers that they consider
> the thrashing and near-OOM stalls to be a serious problems are difficult to
> take seriously while they ignore the obvious solution: if reclaiming file
> caches leads to thrashing, then you just need to prohibit deleting the file
> cache. And allow the user to control its minimum amount.
> By the way, the implementation of such an idea has been known [7] since
> 2010 and was even used in Chrome OS.
>
> Bonus: demo: https://youtu.be/ZrLqUWRodh4
> Debian 11 on VM, Linux 5.14 with the patch, no swap space,
> playing SuperTux while 1000 `tail /dev/zero` started simultaneously:
> 1. No freezes with vm.clean_min_kbytes=300000, I/O pressure was closed to
>    zero, memory pressure was moderate (70-80 some, 12-17 full), all tail
>    processes has been killed in 2 minutes (0:06 - 2:14), it's about
>    8 processes reaped by oom_reaper per second;
> 2. Complete UI freeze without the working set protection (since 3:40).

I do agree we need some way to stop the thrashing of memory especially when
free memory is low and we are very close to OOM.
Mainly you are mentioning the benefit of keeping shared libraries, so
what is the
purpose of vm.anon_min_kbytes?
And will switching multiple applications under the low memory
situation still trigger
thrashing of memory, for example, a library kicks another library out?
anon pages
of one application kick  anon pages of another application out?

>
> [1] https://github.com/hakavlad/nohang
> [2] https://engineering.fb.com/2018/07/19/production-engineering/oomd/
> [3] https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/
> [4] https://lore.kernel.org/lkml/20190807205138.GA24222@cmpxchg.org/
> [5] https://lore.kernel.org/lkml/806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk/
> [6] https://pagure.io/fedora-workstation/issue/98
> [7] https://lore.kernel.org/lkml/20101028191523.GA14972@google.com/
>

Thanks
Barry
