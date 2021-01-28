Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C2308218
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 00:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhA1Xsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 18:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1Xsu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:48:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA96DC061573;
        Thu, 28 Jan 2021 15:48:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gx5so10356156ejb.7;
        Thu, 28 Jan 2021 15:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDptI0q5U2/k2B8+Dz8XvhuiC5p5Hg1baqnbya2iA58=;
        b=KrMIGBIJjYTOYTJaUf/dWAxgCpZjVe7BL453jkSk8NzKOXuenPQHDs4bDK6hLyU9/c
         W69nCP88c/yFbqyJgqMxBWQSvGfUaHFICxVld+pQ5G9A6YznDKqsdGGY/6lWM12KY9Kx
         FXVtPOq1n7JQcZme766f5TXo3PDrylPiiu7USTDHW/0EPaAJjQPDXpU+oOOwcjo8G/jY
         lmCbB5b7bF9ZSXqlVFz3+n/G4iEnIfXzIZpQF1B5MRYyhFeZ5NzBP17ffDnPAN7YV9vd
         Vxjk/PGmJnwqhgnHBGBeVHcdGyJMyVkrQ8rJeQTKcrQepBsPLSugUN7BRnWvGgge+cPY
         mS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDptI0q5U2/k2B8+Dz8XvhuiC5p5Hg1baqnbya2iA58=;
        b=a/IJ32W9iqSipLzfXA6fcvzm1o0hj/7H0CNgyShmKnyPk1d+04VkRir7MMrbimfnSj
         hfK2LO4N9DTT2xVVAPamj83C+mh09sA1G8KMA2uusY3A88lRib+sOn0Ea9ujN4Un7ZKB
         5DPCjjeKcwYNNmTzbbANTPwzHfN88ecwAuEpQOnj6OE0KIiDMVqpTFKgAZqzj7PQUGcI
         kOpzSaguxpPTWSoJVDd5dTyB8B9dwDsyHHo9kCzmG7Lk88uxuoAjyoWoZbcRgEazyvat
         vRUOwKEE/FBcxDTcyvzxkLorvzC+SBXV0ljK7JIFFOSahMIxbkn26o8Moh+/4BeZvtT4
         MPnA==
X-Gm-Message-State: AOAM532l7uF29pgstiUMXT+mT7RrnpbUHqiDNY+BOO+whGm3KDU7IN0V
        zBz5a9Q2a4lyPEACa+27e80XWDsJ/FW8bS59zi0=
X-Google-Smtp-Source: ABdhPJxHWY3YYf7E4ssc7BG59Xe9mPWshRcDa2IS/0fi1MiGaCNL8O2JDnmyd35cPnb+xMgZIQ9zwdiwKRWRghIOsoo=
X-Received: by 2002:a17:906:f841:: with SMTP id ks1mr1855372ejb.507.1611877688626;
 Thu, 28 Jan 2021 15:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-7-shy828301@gmail.com>
 <df26e4ae-ec84-227e-08e1-5849f7fb7be3@suse.cz>
In-Reply-To: <df26e4ae-ec84-227e-08e1-5849f7fb7be3@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Jan 2021 15:47:57 -0800
Message-ID: <CAHbLzkr1ab9c6hMQgtF7Ys--9LsdDGAi0SqotHwpTzvv0wJ2TA@mail.gmail.com>
Subject: Re: [v5 PATCH 06/11] mm: vmscan: use a new flag to indicate shrinker
 is registered
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Thu, Jan 28, 2021 at 9:56 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 12:33 AM, Yang Shi wrote:
> > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > This approach is fine with nr_deferred at the shrinker level, but the following
> > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > from unregistering correctly.
> >
> > Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> > successfully by the new flag.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/shrinker.h |  7 ++++---
> >  mm/vmscan.c              | 27 +++++++++------------------
> >  2 files changed, 13 insertions(+), 21 deletions(-)
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
> > index 92e917033797..256896d157d4 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -308,19 +308,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
> > @@ -329,7 +316,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >
> >       down_write(&shrinker_rwsem);
> >       /* This may call shrinker, so it must use down_read_trylock() */
> > -     id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> > +     id = idr_alloc(&shrinker_idr, NULL, 0, 0, GFP_KERNEL);
>
> Is it still needed to register a NULL and then replace it with real pointer,
> given the SHRINKER_REGISTERED flag?

Good question. Should not need this alloc-replace sequence anymore.
The shrinker_slab_memcg() should see SHRINKER_REGISTERED set when the
shrinker is really registered since the registration is protected by
write shrinker_rwsem.

Will fix this in v6.

>
> >       if (id < 0)
> >               goto unlock;
> >
> > @@ -496,6 +483,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >               idr_replace(&shrinker_idr, shrinker, shrinker->id);
> >  #endif
> > +     shrinker->flags |= SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > @@ -515,13 +503,16 @@ EXPORT_SYMBOL(register_shrinker);
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
> >       kfree(shrinker->nr_deferred);
> >       shrinker->nr_deferred = NULL;
> >  }
> > @@ -687,7 +678,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >               struct shrinker *shrinker;
> >
> >               shrinker = idr_find(&shrinker_idr, i);
> > -             if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> > +             if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
> >                       if (!shrinker)
> >                               clear_bit(i, info->map);
> >                       continue;
> >
>
