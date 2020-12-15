Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3552DB54D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgLOUjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 15:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgLOUcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:32:35 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960BC06179C;
        Tue, 15 Dec 2020 12:31:54 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id u19so22501230edx.2;
        Tue, 15 Dec 2020 12:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4MqXJE1WpUroQSdWeJy7N6P27SgA/o/vOUTsiq4UGU=;
        b=aCEQsVu4ztzKElektxZLqPkzyF+ME+Az+cjVjCwwImjpx91qvS2jkA/JibObHa+KX8
         bORcIpxo7lyupA6EJ9JBmyqFk4ksJi5pFrh0gv9+FtPU4aTZJV18KVS3EiY1LxEKGmMQ
         WnUbVoGOgoLLDazZkYayD0qkzlqrwYVRyM060quSjtdsniql8lqNl4wyyGmhW4v6zgaS
         GyE9pBsR2W1Tgojj6BVHHlPmBBiLcoVNjrkvUc3ZxIK44ogGqN5pgYwUT6+npoLxl0QX
         nAV9UIOfc410K0EgZUztr4/aYhNwPtleDOX1ilFyklqcYLi4+gW+VMZqUpJfaUGxK3kv
         PVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4MqXJE1WpUroQSdWeJy7N6P27SgA/o/vOUTsiq4UGU=;
        b=BESpDEb+hGenLmRVTq8pZA6I6fp1eMLBTwm8c6tDOYPoziDAjTJKKkyfZdP0quhTUk
         OPNh3Xy8niErrmJH+mp81kFB8oVN8/lVup1q+cNUYCavPKaXKPnyBRWSzsV1+DyAiY3q
         X66iJapvYPmJvk9j7CcPqS5U/dT5F+6nf1VR5GrQHmlXYXrVT2vdWC/Jh7OwFfdiHU8i
         Urx37Myiqn5weuC3Z4RUrVFfxhqCBwrIwGiA+fBOP/leI0+8Nl3vdDQ6bo0E7VnNDiZ9
         ZpNatM5Fkqlz3XxsC6E8wU+8HfIQI6Miyyoj1K4DyCYIP6FZ5Wyj6jWOrU0tSc7b4KnM
         B9QQ==
X-Gm-Message-State: AOAM5306jga7aKHzhqFdsBi54ekJbjqwL3DJQOMDlF+eR2H6qAWXVKBE
        V5zylvh5EYoKRnkOdnpgab4i3PGdnBzlvlTZVvAZuwrDG2U=
X-Google-Smtp-Source: ABdhPJzy/4u52BgHE95l5R3HmUK4R4EAUHQXrg4K1dxBPDyHRMQpsNhgeEC/oxN+Yasz5fPeJPsR9v51gxP9Dg5C0PU=
X-Received: by 2002:aa7:c3d3:: with SMTP id l19mr31904848edr.366.1608064313418;
 Tue, 15 Dec 2020 12:31:53 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-4-shy828301@gmail.com>
 <20201215171439.GC385334@cmpxchg.org>
In-Reply-To: <20201215171439.GC385334@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Dec 2020 12:31:41 -0800
Message-ID: <CAHbLzkrzv48S3ks-x8M=2sHxRS_+c-hLXdt4ScaWD6mC4ZFe8w@mail.gmail.com>
Subject: Re: [v2 PATCH 3/9] mm: vmscan: guarantee shrinker_slab_memcg() sees
 valid shrinker_maps for online memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 9:16 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Dec 14, 2020 at 02:37:16PM -0800, Yang Shi wrote:
> > The shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> > in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that we will see
> > memcg->nodeinfo[nid]->shrinker_maps != NULL.  This may occur because of processor reordering
> > on !x86.
> >
> > This seems like the below case:
> >
> >            CPU A          CPU B
> > store shrinker_map      load CSS_ONLINE
> > store CSS_ONLINE        load shrinker_map
>
> But we have a separate check on shrinker_maps, so it doesn't matter
> that it isn't guaranteed, no?

IIUC, yes. Checking shrinker_maps is the alternative way to detect the
reordering to prevent from seeing NULL shrinker_maps per Kirill.

We could check shrinker_deferred too, then just walk away if it is NULL.

>
> The only downside I can see is when CSS_ONLINE isn't visible yet and
> we bail even though we'd be ready to shrink. Although it's probably
> unlikely that there would be any objects allocated already...

Yes, it seems so.

>
> Can somebody remind me why we check mem_cgroup_online() at all?

IIUC it should be mainly used to skip offlined memcgs since there is
nothing on offlined memcgs' LRU because all objects have been
reparented. But shrinker_map won't be freed until .css_free is called.
So the shrinkers might be called in vain.

>
> If shrinker_map is set, we can shrink: .css_alloc is guaranteed to be
> complete, and by using RCU for the shrinker_map pointer, the map is
> also guaranteed to be initialized. There is nothing else happening
> during onlining that you may depend on.
>
> If shrinker_map isn't set, we cannot iterate the bitmap. It does not
> really matter whether CSS_ONLINE is reordered and visible already.

As I mentioned above it should be used to skip offlined memcgs, but it
also opens the race condition due to memory reordering. As Kirill
explained in the earlier email, we could either check the pointer or
use memory barriers.

If the memory barriers seems overkilling, I could definitely switch
back to NULL pointer check approach.

>
> Agreed with Dave: if we need that synchronization around onlining, it
> needs to happen inside the cgroup core. But I wouldn't add that until
> somebody actually required it.
