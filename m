Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30ACD2ED5BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 18:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbhAGRfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 12:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGRfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:35:04 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC2C0612F9;
        Thu,  7 Jan 2021 09:34:23 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id g20so10895461ejb.1;
        Thu, 07 Jan 2021 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQ12CGkmsZ588z03Qrv4ljGlLr+mgktMbZfEUWQnT+U=;
        b=aWwbpsRZWpN8azZmoJ8ZKsZRpo+KwtmXdqB6AmgeDXDyArkkP8tLKLdF+i8AuSh3ZZ
         CuyiIh4PVHHLYulaAjcGeZjKjYUH3pYOD9q/GC9Ooo8hbAk8uYtkd2lL44DzwRqgmz5y
         abREfKBD86UgFO+qmYkSkN3DvUzCr7Yo4hg8sszt8GddM5gDOgfB9v3ABfHcCKxNhWGY
         k1bRUdt1uXOM72RZ5SYumyFvmgBmhHUcXd+9h1A9k8fJGXohUoUpzcrWcHFVzEi9fQi9
         UgmdY2VjlIfBxCtCmK7LOsrnxIebzewLaHjiyBBBzWPFC4hu5pMsMQYARF/I4WCqM7JK
         iznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQ12CGkmsZ588z03Qrv4ljGlLr+mgktMbZfEUWQnT+U=;
        b=USKhmX8dExcDjA+mJRoBg589P05chJ/cC0VvegdAQjiikEN0katlHl1QHOOyR3q1Pb
         HCBRbvq/ep2wQWpt0wzjorNgkOryuCaan5yIKP9QPjlEOet76/z9gY3e1TNMzHwfJ/FT
         mk19D1EBE5m253uL5llwZl7HXXk6iPwPeuShm+HEM28u+yH4RLtMz38ijI48loIRfff1
         tgE52TazCtpIDT3WYZHF4OcMqfrikdeRq4zSHMK4tSwbVEHUvuxRRVS1/z9ycuFLGK5Y
         NQwS/7gqO+RSOi/ZqbPk50JOYAPr9NeoV7nOyWwxj2c9RP4Y1Q9jAnorc4MOwrlD4k8N
         9ApQ==
X-Gm-Message-State: AOAM531Cm6iE7o+3jMK0IKzV6DjT4ceyYdnYg91elOoMK2feDOrEzOl0
        hCONLfa4116vXiCgc7UfL6nWKYaDkcJ0D8v4tFQ=
X-Google-Smtp-Source: ABdhPJxqop3zUol+OgKZtYiRLV3NGeb2FFaPZGfo13pfn1TbEQh/jFMxV2lPuel+7Lyz5BC+EXbCkBAkQuGQv7tNcdw=
X-Received: by 2002:a17:907:546:: with SMTP id wk6mr6928484ejb.238.1610040862110;
 Thu, 07 Jan 2021 09:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-9-shy828301@gmail.com>
 <20210107001728.GE1110904@carbon.dhcp.thefacebook.com>
In-Reply-To: <20210107001728.GE1110904@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Jan 2021 09:34:10 -0800
Message-ID: <CAHbLzkrehm3BpubU6u7aVaEGZxj-4_dQg4nFBDZAyxYob51fjw@mail.gmail.com>
Subject: Re: [v3 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Wed, Jan 6, 2021 at 4:17 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jan 05, 2021 at 02:58:14PM -0800, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
>
> It's better to depend on CONFIG_MEMCG_KMEM rather than CONFIG_MEMCG.
> Without CONFIG_MEMCG_KMEM the kernel memory accounting is off, so
> per-memcg shrinkers do not make any sense. The same applies for many
> places in the patchset.

That is because not only does kmem use shrinker. The deferred split
THP does get split by shrinker and it is memcg aware as well. And it
is not the conventional "kmem".

Actually it was CONFIG_MEMCG_KMEM before, it was changed to
CONFIG_MEMCG by memcg-aware deferred split THP patches.

>
> PS I like this version of the patchset much more than the previous one,
> so it looks like it's going in the right direction.

Thanks a lot for the help from you folks.

>
> Thanks!
>
>
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 81 +++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 69 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 72259253e414..f20ed8e928c2 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -372,6 +372,27 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> > +                                 struct mem_cgroup *memcg)
> > +{
> > +     struct memcg_shrinker_info *info;
> > +
> > +     info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > +                                      true);
> > +     return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> > +}
> > +
> > +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> > +                               struct mem_cgroup *memcg)
> > +{
> > +     struct memcg_shrinker_info *info;
> > +
> > +     info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > +                                      true);
> > +
> > +     return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> > +}
> > +
> >  static bool cgroup_reclaim(struct scan_control *sc)
> >  {
> >       return sc->target_mem_cgroup;
> > @@ -410,6 +431,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >  {
> >  }
> >
> > +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> > +                                 struct mem_cgroup *memcg)
> > +{
> > +     return 0;
> > +}
> > +
> > +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> > +                               struct mem_cgroup *memcg)
> > +{
> > +     return 0;
> > +}
> > +
> >  static bool cgroup_reclaim(struct scan_control *sc)
> >  {
> >       return false;
> > @@ -421,6 +454,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >  }
> >  #endif
> >
> > +static long count_nr_deferred(struct shrinker *shrinker,
> > +                           struct shrink_control *sc)
> > +{
> > +     int nid = sc->nid;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid = 0;
> > +
> > +     if (sc->memcg &&
> > +         (shrinker->flags & SHRINKER_MEMCG_AWARE))
> > +             return count_nr_deferred_memcg(nid, shrinker,
> > +                                            sc->memcg);
> > +
> > +     return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +}
> > +
> > +
> > +static long set_nr_deferred(long nr, struct shrinker *shrinker,
> > +                         struct shrink_control *sc)
> > +{
> > +     int nid = sc->nid;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid = 0;
> > +
> > +     if (sc->memcg &&
> > +         (shrinker->flags & SHRINKER_MEMCG_AWARE))
> > +             return set_nr_deferred_memcg(nr, nid, shrinker,
> > +                                          sc->memcg);
> > +
> > +     return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> > +}
> > +
> >  /*
> >   * This misses isolated pages which are not accounted for to save counters.
> >   * As the data only determines if reclaim or compaction continues, it is
> > @@ -558,14 +624,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >       long freeable;
> >       long nr;
> >       long new_nr;
> > -     int nid = shrinkctl->nid;
> >       long batch_size = shrinker->batch ? shrinker->batch
> >                                         : SHRINK_BATCH;
> >       long scanned = 0, next_deferred;
> >
> > -     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > -             nid = 0;
> > -
> >       freeable = shrinker->count_objects(shrinker, shrinkctl);
> >       if (freeable == 0 || freeable == SHRINK_EMPTY)
> >               return freeable;
> > @@ -575,7 +637,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >        * and zero it so that other concurrent shrinker invocations
> >        * don't also do this scanning work.
> >        */
> > -     nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +     nr = count_nr_deferred(shrinker, shrinkctl);
> >
> >       total_scan = nr;
> >       if (shrinker->seeks) {
> > @@ -666,14 +728,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >               next_deferred = 0;
> >       /*
> >        * move the unused scan count back into the shrinker in a
> > -      * manner that handles concurrent updates. If we exhausted the
> > -      * scan, there is no need to do an update.
> > +      * manner that handles concurrent updates.
> >        */
> > -     if (next_deferred > 0)
> > -             new_nr = atomic_long_add_return(next_deferred,
> > -                                             &shrinker->nr_deferred[nid]);
> > -     else
> > -             new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
> > +     new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
> >
> >       trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
> >       return freed;
> > --
> > 2.26.2
> >
