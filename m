Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD64315BFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhBJBPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbhBJBNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:13:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D086C061574;
        Tue,  9 Feb 2021 17:13:04 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id i8so970609ejc.7;
        Tue, 09 Feb 2021 17:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NyVpcKF9IDJOlvqTT3/NHGSaLgusSzNFcBiCjC++Xk=;
        b=Jsi4eD4g8f/QE/oCmAZsem7AxqzyIZQJc51NfsnXl2wpUTQeQOJFAaM9pzcQ8ABUxL
         UVH9e/4Sl26vu2vRD3PixHniJ+9QdUqhX2YHnuMRwv8KWYfhbPc2wUh5qKHTockiebjy
         cdx7icfst5jHw+Ne3kyptnYNL5ZigC8QHrCZpLY6APS8F4w7kjGDW9QZiOqi2etu8ALS
         RUiZdfSG+BruveE8wc9tDlFevLTGiJ1+7hNu8Cm5ujAeRm8MGQi9jMH7Bm4mw3XlUepL
         KeF+cJdunFSYGD4uuhAbvzBWZU9CZaGzGmlWi8u9PMAyKxbAL+WNBumwO1qBkU4FDFF1
         3UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NyVpcKF9IDJOlvqTT3/NHGSaLgusSzNFcBiCjC++Xk=;
        b=H6kACDnun5+9vXE7xzfr/qBbB+Is97iqGXTbvakzuaer1u8qHC/67hmDCVD+nWtDMn
         v+qcXZuN9xHPwPSbnu5QQyqNl7E3eMH7qp74Ig36zafvIWg1teXLH6r2X1Tornlzv2rf
         28x+hleSBE8D9XK+mE7S5WWH29OPOWxG0H3Yznpa6zARFwmhGcLR880hd3vVrkn0u7nI
         wR6rwmWgTKnGW1vMeNTynXZVIOh7XYoGj5p6/GhCHrzNr7aK1MIhbpPTOOhPgZ8Qai6r
         S5f9WF0P5Swl/4/MspJf6iR5LtGiukOPuCLsLnDTgi06befVuNtPcdVBRH6XVEu02K2R
         ADbg==
X-Gm-Message-State: AOAM530HUn/8zF73J5BHI82kvx3YCef3W4GAxO+LWu9czCa6YAafwhQE
        wLTosuE/9vocFlb3l7dGkA7hImyl44wiFHFl31DWX2lARRE=
X-Google-Smtp-Source: ABdhPJyTWutKg/k2AEX+z3Y966q4sikpTAQVazuE+L9ySrzGkceIVyL2ltn6UlSwcmWSiHhR6gSRkmfiSfip9KkACbM=
X-Received: by 2002:a17:906:eca5:: with SMTP id qh5mr429264ejb.161.1612919583218;
 Tue, 09 Feb 2021 17:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-8-shy828301@gmail.com>
 <20210210003943.GK524633@carbon.DHCP.thefacebook.com>
In-Reply-To: <20210210003943.GK524633@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Feb 2021 17:12:51 -0800
Message-ID: <CAHbLzkq2_=b-_4adsf-8vwcG6io6Zx_2o82207S6z8J7ShfTMw@mail.gmail.com>
Subject: Re: [v7 PATCH 07/12] mm: vmscan: use a new flag to indicate shrinker
 is registered
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
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

On Tue, Feb 9, 2021 at 4:39 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Feb 09, 2021 at 09:46:41AM -0800, Yang Shi wrote:
> > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > This approach is fine with nr_deferred at the shrinker level, but the following
> > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > from unregistering correctly.
> >
> > Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> > successfully by the new flag.
> >
> > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/shrinker.h |  7 ++++---
> >  mm/vmscan.c              | 31 +++++++++----------------------
> >  2 files changed, 13 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 0f80123650e2..1eac79ce57d4 100644
> > --- a/include/linux/shrinker.h
> > +++ b/include/linux/shrinker.h
> > @@ -79,13 +79,14 @@ struct shrinker {
> >  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
> >
> >  /* Flags */
> > -#define SHRINKER_NUMA_AWARE  (1 << 0)
> > -#define SHRINKER_MEMCG_AWARE (1 << 1)
> > +#define SHRINKER_REGISTERED  (1 << 0)
> > +#define SHRINKER_NUMA_AWARE  (1 << 1)
> > +#define SHRINKER_MEMCG_AWARE (1 << 2)
> >  /*
> >   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
> >   * non-MEMCG_AWARE shrinker should not have this flag set.
> >   */
> > -#define SHRINKER_NONSLAB     (1 << 2)
> > +#define SHRINKER_NONSLAB     (1 << 3)
> >
> >  extern int prealloc_shrinker(struct shrinker *shrinker);
> >  extern void register_shrinker_prepared(struct shrinker *shrinker);
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 273efbf4d53c..a047980536cf 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -315,19 +315,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> >       }
> >  }
> >
> > -/*
> > - * We allow subsystems to populate their shrinker-related
> > - * LRU lists before register_shrinker_prepared() is called
> > - * for the shrinker, since we don't want to impose
> > - * restrictions on their internal registration order.
> > - * In this case shrink_slab_memcg() may find corresponding
> > - * bit is set in the shrinkers map.
> > - *
> > - * This value is used by the function to detect registering
> > - * shrinkers and to skip do_shrink_slab() calls for them.
> > - */
> > -#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> > -
> >  static DEFINE_IDR(shrinker_idr);
> >
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> > @@ -336,7 +323,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >
> >       down_write(&shrinker_rwsem);
> >       /* This may call shrinker, so it must use down_read_trylock() */
> > -     id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> > +     id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> >       if (id < 0)
> >               goto unlock;
> >
> > @@ -499,10 +486,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >  {
> >       down_write(&shrinker_rwsem);
> >       list_add_tail(&shrinker->list, &shrinker_list);
> > -#ifdef CONFIG_MEMCG
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             idr_replace(&shrinker_idr, shrinker, shrinker->id);
> > -#endif
> > +     shrinker->flags |= SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > @@ -522,13 +506,16 @@ EXPORT_SYMBOL(register_shrinker);
> >   */
> >  void unregister_shrinker(struct shrinker *shrinker)
> >  {
> > -     if (!shrinker->nr_deferred)
> > +     if (!(shrinker->flags & SHRINKER_REGISTERED))
> >               return;
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             unregister_memcg_shrinker(shrinker);
> > +
> >       down_write(&shrinker_rwsem);
> >       list_del(&shrinker->list);
> > +     shrinker->flags &= ~SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> > +
> > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > +             unregister_memcg_shrinker(shrinker);
>
> Because unregister_memcg_shrinker() will take and release shrinker_rwsem once again,
> I wonder if it's better to move it into the locked section and change the calling
> convention to require the caller to take the semaphore?

I don't think we could do that since unregister_memcg_shrinker() is
called by free_prealloced_shrinker() which is called without holding
the shrinker_rwsem by fs and workingset code.

We could add a bool parameter to indicate if the rwsem was acquired or
not, but IMHO it seems not worth it.

>
> >       kfree(shrinkrem->nr_deferred);
> >       shrinker->nr_deferred = NULL;
> >  }
> > @@ -693,7 +680,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >               struct shrinker *shrinker;
> >
> >               shrinker = idr_find(&shrinker_idr, i);
> > -             if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> > +             if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
> >                       if (!shrinker)
> >                               clear_bit(i, info->map);
> >                       continue;
> > --
> > 2.26.2
> >
