Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E055B467CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382491AbhLCRyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 12:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382478AbhLCRye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:54:34 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0FFC061751
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 09:51:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u3so8373823lfl.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Dec 2021 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xm0FOcKnB1VB3SyGY+sZgit/QboKHbPIM25nrSjiVeY=;
        b=N0n18KpBckGWjsg5X9h/A83ty0o4Y2ajbVK+oq8W2DGblpELSt9Dhvxst6zT5umQca
         l22wF2EXENaFxvBlgmOdgP9MwEyAzpw27Kext1rqCrvLVpBAfvt6zXCP1lqyoIF7zGoe
         P+afmkfI0PbMaFi7yUICWBHgB7jiKFB1ZYccLqS1kg83qgtm00eMb3dXtX5nf8A8RqV0
         lEvR4CQfkt7+jF9vNelvn1aufiBq4DbTy/UFIBtrH8tnqAZHskqzMXZd37eO4HSU2juD
         s0Zgxp4s9rj+X0058T9NaXCB8niGEAjIdKnzglKON6QX0G+Z6kZ7R6kXSQU4Mxiu8c+J
         Gh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xm0FOcKnB1VB3SyGY+sZgit/QboKHbPIM25nrSjiVeY=;
        b=UfYQD7yscB6ym7aRl7BWkRvLXkhXcIsYj3Iw0P3SLJdSJ5rg8r47kD//U0CVyRHXpj
         bABmCknO6LeJxAByZ5KQpbyt54VM8KPqR72jL0mqTeDqSCvjsrK2Z1APDlXa8irw6os8
         1OndDv3CdY7FOO0iU6Z9ZuDNPIld2yk3ZlgsojsNA000Z3Flce0yxFQysfa/ZIBBRqi5
         5wtxkKQIfTzgOwyMdpaUp84j2SKhIajsHKEkL+OIXiQBmoPL/p30MfkBadzNz2WFPUdP
         eLylhKYJxs4y2fsHhkDa8vwdTdiU0TeD7VbMgd5+fucpD/8MzNPhS5duxXaonv7k6f5i
         EVDg==
X-Gm-Message-State: AOAM533F5uuKoMgwifK5G3f0z7GPvG3jpRlNUzQJhExjV13ALGsTQeei
        7kQgu0R9Y26TClO1wKcgApQ/1cOfJWrUqWSRPFntFA==
X-Google-Smtp-Source: ABdhPJy+QmtD0vN6/vIdbzeiC2xsRqs0giW2uF6k3loJjaViYyrjKE72ZpAM7vEUEZc+Y+AUnuF0gnrkB9wwTa1wxWk=
X-Received: by 2002:a05:6512:5c2:: with SMTP id o2mr18773168lfo.8.1638553863883;
 Fri, 03 Dec 2021 09:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
 <20211202165220.GZ3366@techsingularity.net> <CALvZod5tiDgEz4JwxMHQvkzLxYeV0OtNGGsX5ZdT5mTQdUdUUA@mail.gmail.com>
 <20211203090137.GA3366@techsingularity.net>
In-Reply-To: <20211203090137.GA3366@techsingularity.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 3 Dec 2021 09:50:51 -0800
Message-ID: <CALvZod46SFiNvUSLCJWEVccsXKx=NwT4=gk9wS6Nt8cZd0WOgg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 3, 2021 at 1:01 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
[...]
>
> Not recently that I'm aware of but historically reclaim has been plagued by
> at least two classes of problems -- premature OOM and excessive CPU usage
> churning through the LRU. Going back, the solution was basically to sleep
> something like "disable kswapd if it fails to make progress for too long".
> Commit 69392a403f49 addressed a case where calling congestion_wait might as
> well have been schedule_timeout_uninterruptible(HZ/10) because congestion
> is no longer tracked by the block layer.
>
> Hence 69392a403f49 allows reclaim to throttle on NOPROGRESS but if
> another task makes progress, the throttled tasks can be woken before the
> timeout. The flaw was throttling too easily or for too long delaying OOM
> being properly detected.
>

To remove congestion_wait of mem_cgroup_force_empty_write(), the
commit 69392a403f49 has changed the behavior of all memcg reclaim
codepaths as well as direct global reclaimers. Were there other
congestion_wait() instances which commit 69392a403f49 was targeting
but those congestion_wait() were replaced/removed by different
commits?

[...]

> >
> > Isn't it better that the reclaim returns why it is failing instead of
> > littering the reclaim code with 'is this global reclaim', 'is this
> > memcg reclaim', 'am I kswapd' which is also a layering violation. IMO
> > this is the direction we should be going towards though not asking to
> > do this now.
> >
>
> It's not clear why you think the page allocator can make better decisions
> about reclaim than reclaim can. It might make sense if callers were
> returned enough information to make a decision but even if they could,
> it would not be popular as the API would be difficult to use properly.
>

The above is a separate discussion for later.

> Is your primary objection the cgroup_reclaim(sc) check?

No, I am of the opinion that we should revert 69392a403f49 and we
should have just replaced congestion_wait in
mem_cgroup_force_empty_write with a simple
schedule_timeout_interruptible. The memory.force_empty is a cgroup v1
interface (to be deprecated) and it is very normal to expect that the
user will trigger that interface multiple times. We should not change
the behavior of all the memcg reclaimers and direct global reclaimers
so that we can remove congestion_wait from
mem_cgroup_force_empty_write.

> If so, I can
> remove it. While there is a mild risk that OOM would be delayed, it's very
> unlikely because a memcg failing to make progress in the local case will
> probably call cond_resched() if there are not lots of of pages pending
> writes globally.
>
> > Regarding this patch and 69392a403f49, I am still confused on the main
> > motivation behind 69392a403f49 to change the behavior of 'direct
> > reclaimers from page allocator'.
> >
>
> The main motivation of the series overall was to remove the reliance on
> congestion_wait and wait_iff_congested because both are fundamentally
> broken when congestion is not tracked by the block layer. Replacing with
> schedule_timeout_uninterruptible() would be silly because where possible
> decisions on whether to pause or throttle should be based on events,
> not time. For example, if there are too many pages waiting on writeback
> then throttle but if writeback completes, wake the throttled tasks
> instead of "sleep some time and hope for the best".
>

I am in agreement with the motivation of the whole series. I am just
making sure that the motivation of VMSCAN_THROTTLE_NOPROGRESS based
throttle is more than just the congestion_wait of
mem_cgroup_force_empty_write.

thanks,
Shakeel
