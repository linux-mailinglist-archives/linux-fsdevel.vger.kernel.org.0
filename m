Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5795A2E6C4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Dec 2020 00:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgL1Wzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgL1UEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:04:22 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C926C0613D6;
        Mon, 28 Dec 2020 12:03:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i24so10744912edj.8;
        Mon, 28 Dec 2020 12:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6wLs3O3NbOgM5Ikne900yyPCAu6Ee+BSm2CLHZBcHs=;
        b=j0cC9TO1gDQxvqxWiUNWhnTF78mOXGz1VUQ1QK2ltNTP+r3WsgDcHAbjiDuEaUT/aW
         BU0DPotHLrWwj+fUP8C8oGxaI24drzA97kJTPgcsRlFnoK7vBNsgEt+r4l8qaOFXcNtI
         yP7hGvEnJb/CdBzcs/1QXTuNfQRZv4T0RMPWVRbhvpp8XdrrSpP4l0Z/WP6nLH7cx9yD
         XnsWySG9f289D+LXaTGmaWZK+9SJvNfEL/nDWQVOss/+3cAKUysEgpLAdOJXVo5d7I0s
         c8I/p6AtgpOPK+ELH4w8pbzu47Xx2FnJo9Gn37gWXeoFPSPV0YaA72or2DSb3EX6FWCy
         zk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6wLs3O3NbOgM5Ikne900yyPCAu6Ee+BSm2CLHZBcHs=;
        b=ONTo/1WTINAd5o4U7LBEnKW80c//Lw7v1E62Y8T5dXBbSVdwGm/WOsgqcEIcP0J7Hc
         z0PWw0/JwkRFu1k2moj4PocDr7Uw6ruPaeOrkyK9E8VH7c0DwgHvfyRJBWPFqAvON43M
         4jwaRrh3NxXlYZNIjU2lPe3y8zbZGS3Al/ZNcquxKiXiVmWC8JE0CS0gWtVvDGfE20BF
         Dxw08Be/zR1dumA7tom8qdR3zTrM3ima5ZqkICl5//w0wfp49SGydqZ1xrPMvkIFUXeN
         y6yPKlEMkYZhkPmZtGbTxSwr+71BA3RumNEBD5A8ayal+RlU+hv4QuUIhho0GxQFAaKC
         toDQ==
X-Gm-Message-State: AOAM530xgco16M47JHswi1vfgZl1EfLS7j7ksslaVfIiaaCXGRH5lKVm
        eTupK2Qz3aSPOGp9vLw6NRoZNKIX+4rjnH2ZKwE=
X-Google-Smtp-Source: ABdhPJwlQf5wLF9FUY8a25sToNVh5qWgpnEg5KLjLvsGQ1lxQga3FI+dAsDiqTRhVt44lfrT95MqTjsmPwE91/1tbV8=
X-Received: by 2002:a05:6402:1c8a:: with SMTP id cy10mr43621201edb.151.1609185820234;
 Mon, 28 Dec 2020 12:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-4-shy828301@gmail.com>
 <20201215171439.GC385334@cmpxchg.org> <CAHbLzkrzv48S3ks-x8M=2sHxRS_+c-hLXdt4ScaWD6mC4ZFe8w@mail.gmail.com>
In-Reply-To: <CAHbLzkrzv48S3ks-x8M=2sHxRS_+c-hLXdt4ScaWD6mC4ZFe8w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 28 Dec 2020 12:03:28 -0800
Message-ID: <CAHbLzkrxKOdfn8quHDCNwPMTLAe4rB3vyhmuzaL2KA+F23fr8Q@mail.gmail.com>
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

I think Johannes's point makes sense to me. If the shrinker_maps is
not initialized yet it means the memcg is too young to have a number
of reclaimable slab caches. It sounds fine to just skip it.

And, with consolidating shrinker_maps and shrinker_deferred into one
struct, we could just check the pointer of the struct. So, it seems
this patch is not necessary anymore. This patch will be dropped in v3.

On Tue, Dec 15, 2020 at 12:31 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 9:16 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Dec 14, 2020 at 02:37:16PM -0800, Yang Shi wrote:
> > > The shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> > > in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that we will see
> > > memcg->nodeinfo[nid]->shrinker_maps != NULL.  This may occur because of processor reordering
> > > on !x86.
> > >
> > > This seems like the below case:
> > >
> > >            CPU A          CPU B
> > > store shrinker_map      load CSS_ONLINE
> > > store CSS_ONLINE        load shrinker_map
> >
> > But we have a separate check on shrinker_maps, so it doesn't matter
> > that it isn't guaranteed, no?
>
> IIUC, yes. Checking shrinker_maps is the alternative way to detect the
> reordering to prevent from seeing NULL shrinker_maps per Kirill.
>
> We could check shrinker_deferred too, then just walk away if it is NULL.
>
> >
> > The only downside I can see is when CSS_ONLINE isn't visible yet and
> > we bail even though we'd be ready to shrink. Although it's probably
> > unlikely that there would be any objects allocated already...
>
> Yes, it seems so.
>
> >
> > Can somebody remind me why we check mem_cgroup_online() at all?
>
> IIUC it should be mainly used to skip offlined memcgs since there is
> nothing on offlined memcgs' LRU because all objects have been
> reparented. But shrinker_map won't be freed until .css_free is called.
> So the shrinkers might be called in vain.
>
> >
> > If shrinker_map is set, we can shrink: .css_alloc is guaranteed to be
> > complete, and by using RCU for the shrinker_map pointer, the map is
> > also guaranteed to be initialized. There is nothing else happening
> > during onlining that you may depend on.
> >
> > If shrinker_map isn't set, we cannot iterate the bitmap. It does not
> > really matter whether CSS_ONLINE is reordered and visible already.
>
> As I mentioned above it should be used to skip offlined memcgs, but it
> also opens the race condition due to memory reordering. As Kirill
> explained in the earlier email, we could either check the pointer or
> use memory barriers.
>
> If the memory barriers seems overkilling, I could definitely switch
> back to NULL pointer check approach.
>
> >
> > Agreed with Dave: if we need that synchronization around onlining, it
> > needs to happen inside the cgroup core. But I wouldn't add that until
> > somebody actually required it.
