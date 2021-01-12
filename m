Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B92F3D05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438116AbhALVhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 16:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437094AbhALU7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:59:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BADAC061575;
        Tue, 12 Jan 2021 12:58:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d17so5437454ejy.9;
        Tue, 12 Jan 2021 12:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2488YfIKw2/IPkOU3jNJR+xLgk8bwBEm0EMuKAKYdtE=;
        b=r+7U1RgXJGA5UAOTqwDP6UL0+Qi7sfZ73exStFoFDpTEiR6aKOE5DcB5y6NaDIlH7W
         9eb4xzc9BLBdVVNB5eTriTQMOmGqaA+uEuASwVTCHuUeeqJA4wMAw/o9sYpHRMpv4FHC
         K24MzipXIz4HRSsDVeBnNjd75HEf2tP3lYmDUJJtg9dnq69AaKvc3uA0PKvZMC847DzF
         4qBpMwiInB5opME2tonWYmB9vo7vVBTxxls3tDZRpPQROsfvWRVZPeyAtDxrwEvhVyp6
         f+gyJJFejYSdW6pkitd/La9X5P+E/R0FTVxLOIFs1j1vJGDymh5xJQHsutbcLwhljkUb
         XbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2488YfIKw2/IPkOU3jNJR+xLgk8bwBEm0EMuKAKYdtE=;
        b=GzeSpDkXKQaYaEt3Vek2dTT0bjB17zEFDvLJuC4ddqW0xqxat4mlSwBdUgWSoGQstx
         gWROH8KGfJP1088Jqscea6xUUp/E6KQBrBR8+9PG5wpgBlmrEN0PwAjAipqn2A/mZ+Iu
         bKU81kpsfVOvwuv2+vdXRG4wkJLy+Li5iUpSc6dpsyFaqoV1H4Gf5ulUwf5/SmW4qOVD
         p6rJYKTqsRYSs8eX7ElDW75hr6wTPZcnwKx5jCS4eqboIxfTJiIaX/pi19oz/edTaRKg
         BjzADpRvF+iISTZUev7KZUn9QnV51+MgVWrBXj+DpvGQ5qW6GEr/Gnf3+BnCBnjBO1US
         trgA==
X-Gm-Message-State: AOAM530KzNY9VzpNFR0PiDepy+FIlLWIQWj2//i/O45kHokL/4etF3+v
        PuKraDy9RtWL4oUY8Ucqk7Bg9Hcc0tvo7lBVJ9I=
X-Google-Smtp-Source: ABdhPJywiChfAqj+hTD+lWNPDRLSpKCj8jiEW6HWfM7CeSy44afF60mxJ8fD+ZgkFhrLb+rqeT2kS7vvOifHe5uef6U=
X-Received: by 2002:a17:906:6a45:: with SMTP id n5mr486085ejs.514.1610485101796;
 Tue, 12 Jan 2021 12:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-6-shy828301@gmail.com>
 <bdf650e0-6728-4481-3454-c865649bbdcf@virtuozzo.com> <CAHbLzkqZ7Hmo7DSQijrgoKaDQDaOb3+tTGeJ2xU8drFKZ6jv4A@mail.gmail.com>
 <ff0d1ed1-e2ae-3e0c-e780-e8d2287cc99b@virtuozzo.com>
In-Reply-To: <ff0d1ed1-e2ae-3e0c-e780-e8d2287cc99b@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Jan 2021 12:58:10 -0800
Message-ID: <CAHbLzkrOfSSMDhHyemSFWdQ4aSGLytM+9u=s2-BNWsKkLVGgEg@mail.gmail.com>
Subject: Re: [v3 PATCH 05/11] mm: vmscan: use a new flag to indicate shrinker
 is registered
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 1:38 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 11.01.2021 21:17, Yang Shi wrote:
> > On Wed, Jan 6, 2021 at 2:22 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 06.01.2021 01:58, Yang Shi wrote:
> >>> Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> >>> This approach is fine with nr_deferred at the shrinker level, but the following
> >>> patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> >>> shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> >>> from unregistering correctly.
> >>>
> >>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >>> ---
> >>>  include/linux/shrinker.h |  7 ++++---
> >>>  mm/vmscan.c              | 13 +++++++++----
> >>>  2 files changed, 13 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> >>> index 0f80123650e2..1eac79ce57d4 100644
> >>> --- a/include/linux/shrinker.h
> >>> +++ b/include/linux/shrinker.h
> >>> @@ -79,13 +79,14 @@ struct shrinker {
> >>>  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
> >>>
> >>>  /* Flags */
> >>> -#define SHRINKER_NUMA_AWARE  (1 << 0)
> >>> -#define SHRINKER_MEMCG_AWARE (1 << 1)
> >>> +#define SHRINKER_REGISTERED  (1 << 0)
> >>> +#define SHRINKER_NUMA_AWARE  (1 << 1)
> >>> +#define SHRINKER_MEMCG_AWARE (1 << 2)
> >>>  /*
> >>>   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
> >>>   * non-MEMCG_AWARE shrinker should not have this flag set.
> >>>   */
> >>> -#define SHRINKER_NONSLAB     (1 << 2)
> >>> +#define SHRINKER_NONSLAB     (1 << 3)
> >>>
> >>>  extern int prealloc_shrinker(struct shrinker *shrinker);
> >>>  extern void register_shrinker_prepared(struct shrinker *shrinker);
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index 8da765a85569..9761c7c27412 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -494,6 +494,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >>>       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >>>               idr_replace(&shrinker_idr, shrinker, shrinker->id);
> >>>  #endif
> >>> +     shrinker->flags |= SHRINKER_REGISTERED;
> >>
> >> In case of we introduce this new flag, we should kill old flag SHRINKER_REGISTERING,
> >> which are not needed anymore (we should you the new flag instead of that).
> >
> > The only think that I'm confused with is the check in
> > shrink_slab_memcg, it does:
> >
> > shrinker = idr_find(&shrinker_idr, i);
> > if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> >
> > When allocating idr, the shrinker is associated with
> > SHRINKER_REGISTERING. But, shrink_slab_memcg does acquire read
> > shrinker_rwsem, and idr_alloc is called with holding write
> > shrinker_rwsem, so I'm supposed shrink_slab_memcg should never see
> > shrinker is registering.
>
> After prealloc_shrinker() shrinker is visible for shrink_slab_memcg().
> This is the moment shrink_slab_memcg() sees SHRINKER_REGISTERED.

Yes, this exactly is what I'm supposed.

>
> > If so it seems easy to remove
> > SHRINKER_REGISTERING.
> >
> > We just need change that check to:
> > !shrinker || !(shrinker->flags & SHRINKER_REGISTERED)
> >
> >>>       up_write(&shrinker_rwsem);
> >>>  }
> >>>
> >>> @@ -513,13 +514,17 @@ EXPORT_SYMBOL(register_shrinker);
> >>>   */
> >>>  void unregister_shrinker(struct shrinker *shrinker)
> >>>  {
> >>> -     if (!shrinker->nr_deferred)
> >>> -             return;
> >>> -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >>> -             unregister_memcg_shrinker(shrinker);
> >>>       down_write(&shrinker_rwsem);
> >>
> >> I do not think there are some users which registration may race with unregistration.
> >> So, I think we should check SHRINKER_REGISTERED unlocked similar to we used to check
> >> shrinker->nr_deferred unlocked.
> >
> > Yes, I agree.
> >
> >>
> >>> +     if (!(shrinker->flags & SHRINKER_REGISTERED)) {
> >>> +             up_write(&shrinker_rwsem);
> >>> +             return;
> >>> +     }
> >>>       list_del(&shrinker->list);
> >>> +     shrinker->flags &= ~SHRINKER_REGISTERED;
> >>>       up_write(&shrinker_rwsem);
> >>> +
> >>> +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >>> +             unregister_memcg_shrinker(shrinker);
> >>>       kfree(shrinker->nr_deferred);
> >>>       shrinker->nr_deferred = NULL;
> >>>  }
> >>>
> >>
> >>
>
>
