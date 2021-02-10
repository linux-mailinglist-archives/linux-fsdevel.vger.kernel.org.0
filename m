Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4CF315CB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 02:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhBJB5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 20:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhBJB4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:56:42 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF6C061574;
        Tue,  9 Feb 2021 17:56:00 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so1178422ejc.1;
        Tue, 09 Feb 2021 17:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXzyQRaZuZLiOTft75iVeWNV8ABt+eviKyZflZxsDf0=;
        b=u9N40c8pqBcVi9ZVa541u8zKrGM31TNWTLaGjuuPlHIqKIlniAMMx03F5z1VbsYoiy
         FwXtnI4Hbt+EzMVF3ER6DN8dGFQBT/bZqQN4RZSrGWFYFTfkVBUSaDSGiAQO+//uAQsL
         o4XxSPyazRzGjGDHi8CG9kekMyoDbiujY9lBPwA5Ysr0d0LJEn9aqSsc3nbxnvD2jRkA
         kNDE88N8AkpPJ4ZDkRdHLWhQ28UhezV6SXHSWESE9uD/hhQbPFTbvoknYbBQ2i6AV7Go
         pXy6iomX5fmp+xE+WJG86XTQMjk+Odjkbb24nWcUuAk/Ta1iJGz+sMuZXfQg7l4eNav/
         MYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXzyQRaZuZLiOTft75iVeWNV8ABt+eviKyZflZxsDf0=;
        b=LbBC9G78d/1DMMVfwm5olbsy9d1ygk4AzSnLzPyn3VDIxqFFtB8SZwyMu5m2kf98Ii
         DYXDUmrt8CqABDj+5CKnRZGuxLYW/cJ7iUN+GTCxNnrZhjDs6FUY6N4z6vlh7LmsR4ZA
         v3IJYoswAuD8Re4MNBTWI87dPVgRuHr+WIVPFM149ndA4EClxJxJFOJ2L4vH4jBWfbDH
         ZRy+kpG3/aiF6CbAENN+FTiQjnVXod4gsjb5WdmTlmMbtVZGmsmMe7g4roAfafPqBw9h
         LXHpWazN8qmYV+56Hagph8vxT81DhgbRyuhh4QDhgDK6ol7N7Pd2ZGsLiyMd5UJaQSgG
         hBqg==
X-Gm-Message-State: AOAM531IZ5cDHD/b2eXBd/JrD6BPss7RwZ/iz9WmYfwKF0QoJCk4lisR
        MwQqeJyf32PoKH+0KTnqgDf3pKQpXySvVIG1vGc=
X-Google-Smtp-Source: ABdhPJxoECQS7fASBKCTB+FlHMhofqjM9YkRBKoLEyTGobjb5HQlARul98/mUTVsWv82ITqGiioeJh6PZqP1RsyZlMU=
X-Received: by 2002:a17:906:eca5:: with SMTP id qh5mr565421ejb.161.1612922159247;
 Tue, 09 Feb 2021 17:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-8-shy828301@gmail.com>
 <20210210003943.GK524633@carbon.DHCP.thefacebook.com> <CAHbLzkq2_=b-_4adsf-8vwcG6io6Zx_2o82207S6z8J7ShfTMw@mail.gmail.com>
 <20210210013404.GQ524633@carbon.DHCP.thefacebook.com>
In-Reply-To: <20210210013404.GQ524633@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Feb 2021 17:55:47 -0800
Message-ID: <CAHbLzkp9ffgubk=_8vLTv+gdby1_puAx65-7JeSA9=v-735vgQ@mail.gmail.com>
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

On Tue, Feb 9, 2021 at 5:34 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Feb 09, 2021 at 05:12:51PM -0800, Yang Shi wrote:
> > On Tue, Feb 9, 2021 at 4:39 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Feb 09, 2021 at 09:46:41AM -0800, Yang Shi wrote:
> > > > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > > > This approach is fine with nr_deferred at the shrinker level, but the following
> > > > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > > > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > > > from unregistering correctly.
> > > >
> > > > Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> > > > successfully by the new flag.
> > > >
> > > > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  include/linux/shrinker.h |  7 ++++---
> > > >  mm/vmscan.c              | 31 +++++++++----------------------
> > > >  2 files changed, 13 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > > > index 0f80123650e2..1eac79ce57d4 100644
> > > > --- a/include/linux/shrinker.h
> > > > +++ b/include/linux/shrinker.h
> > > > @@ -79,13 +79,14 @@ struct shrinker {
> > > >  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
> > > >
> > > >  /* Flags */
> > > > -#define SHRINKER_NUMA_AWARE  (1 << 0)
> > > > -#define SHRINKER_MEMCG_AWARE (1 << 1)
> > > > +#define SHRINKER_REGISTERED  (1 << 0)
> > > > +#define SHRINKER_NUMA_AWARE  (1 << 1)
> > > > +#define SHRINKER_MEMCG_AWARE (1 << 2)
> > > >  /*
> > > >   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
> > > >   * non-MEMCG_AWARE shrinker should not have this flag set.
> > > >   */
> > > > -#define SHRINKER_NONSLAB     (1 << 2)
> > > > +#define SHRINKER_NONSLAB     (1 << 3)
> > > >
> > > >  extern int prealloc_shrinker(struct shrinker *shrinker);
> > > >  extern void register_shrinker_prepared(struct shrinker *shrinker);
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index 273efbf4d53c..a047980536cf 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -315,19 +315,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> > > >       }
> > > >  }
> > > >
> > > > -/*
> > > > - * We allow subsystems to populate their shrinker-related
> > > > - * LRU lists before register_shrinker_prepared() is called
> > > > - * for the shrinker, since we don't want to impose
> > > > - * restrictions on their internal registration order.
> > > > - * In this case shrink_slab_memcg() may find corresponding
> > > > - * bit is set in the shrinkers map.
> > > > - *
> > > > - * This value is used by the function to detect registering
> > > > - * shrinkers and to skip do_shrink_slab() calls for them.
> > > > - */
> > > > -#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> > > > -
> > > >  static DEFINE_IDR(shrinker_idr);
> > > >
> > > >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> > > > @@ -336,7 +323,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> > > >
> > > >       down_write(&shrinker_rwsem);
> > > >       /* This may call shrinker, so it must use down_read_trylock() */
> > > > -     id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> > > > +     id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> > > >       if (id < 0)
> > > >               goto unlock;
> > > >
> > > > @@ -499,10 +486,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> > > >  {
> > > >       down_write(&shrinker_rwsem);
> > > >       list_add_tail(&shrinker->list, &shrinker_list);
> > > > -#ifdef CONFIG_MEMCG
> > > > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > > > -             idr_replace(&shrinker_idr, shrinker, shrinker->id);
> > > > -#endif
> > > > +     shrinker->flags |= SHRINKER_REGISTERED;
> > > >       up_write(&shrinker_rwsem);
> > > >  }
> > > >
> > > > @@ -522,13 +506,16 @@ EXPORT_SYMBOL(register_shrinker);
> > > >   */
> > > >  void unregister_shrinker(struct shrinker *shrinker)
> > > >  {
> > > > -     if (!shrinker->nr_deferred)
> > > > +     if (!(shrinker->flags & SHRINKER_REGISTERED))
> > > >               return;
> > > > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > > > -             unregister_memcg_shrinker(shrinker);
> > > > +
> > > >       down_write(&shrinker_rwsem);
> > > >       list_del(&shrinker->list);
> > > > +     shrinker->flags &= ~SHRINKER_REGISTERED;
> > > >       up_write(&shrinker_rwsem);
> > > > +
> > > > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > > > +             unregister_memcg_shrinker(shrinker);
> > >
> > > Because unregister_memcg_shrinker() will take and release shrinker_rwsem once again,
> > > I wonder if it's better to move it into the locked section and change the calling
> > > convention to require the caller to take the semaphore?
> >
> > I don't think we could do that since unregister_memcg_shrinker() is
> > called by free_prealloced_shrinker() which is called without holding
> > the shrinker_rwsem by fs and workingset code.
> >
> > We could add a bool parameter to indicate if the rwsem was acquired or
> > not, but IMHO it seems not worth it.
>
> Can free_preallocated_shrinker() just do
>
> if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
>         down_write(&shrinker_rwsem);
>         unregister_memcg_shrinker(shrinker);
>         up_write(&shrinker_rwsem);
> }
>
> ?

Aha, yes. I didn't think of that way.
