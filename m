Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472E42DB682
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 23:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgLOW2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 17:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbgLOW2L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:28:11 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E775CC061793;
        Tue, 15 Dec 2020 14:27:30 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so29915940ejb.12;
        Tue, 15 Dec 2020 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7aPdqvRqJdLQv00aCJ+/E9W+p1nZGyEz+7ylHTtPMo=;
        b=XaL9nsunMMT+noKx6MZUlQafJRFGsAEjL1q+/hjxZrM7wm5qXyh/fUp+9fWtNuD1W6
         9YWjDRhXlGP7KJMzqecTvcaVFz/unew/U7nbviK2jCg6J2X6wqfyJB+yvJxnckSpecYg
         131LAre0Rmliapwfv1dL+x7+4E2Y2tW6Mz2xGcol8d+6OnDjTFLxQPtngCymAvtvyHQ/
         KsIQV3TNq7eH1M3cx1a9gEBHBJB64lpAOwlpAN+RIODdcgF8TvGimeMGlp46THjiX4Ix
         FyZ3WuA/x1x5FaNmcpEVG1DNNUXsh+q8rp1ePrnkpQL1v+xsDP+x1LxOER6nC9KmGz4l
         iRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7aPdqvRqJdLQv00aCJ+/E9W+p1nZGyEz+7ylHTtPMo=;
        b=Q9OL09hWsS+rbODjf4jfP63qapEbPPA+AhcqSmkqCKWlypVeiiyEK/HakGD+nSVsUl
         VlN5d7zAMw2LtU8C2OgWiAhZUbfE9AY0g1RF0eNaft2N8p7T7jBUNiGrWKjeJGBaAOaB
         V+OzCZ+X5DzYT0XPZ2TSkAGyVi/U3kPPhBcusWy5r58JSav2gRIfaYDsZWJvZhWQpBMQ
         gFAcwaPDo6kqFONOAcqV7LzG4Pmbfpx+2Jk6DJijs8g2kH2pqEIqgjQjnYrYLx2uThxC
         uscdGdjADv8SDFf2cf5/cX4+H3Wtg28h/tFAV9p3PNmq14pa9j6ludIeVDZeQBga0IJe
         9f8w==
X-Gm-Message-State: AOAM533dSHqqHiiKDNLZGC7D5eqPgRCHt4QQheYGrgDlNblJLr8bkp+U
        vviTlKB+2P2T5UBvB0BxPczyr5ekt9uKocBN6bE=
X-Google-Smtp-Source: ABdhPJzO6Ko/h2biCIhij7Dwhzxk/22hDs6IxS5BZKD+/z3szPShMe/VADlbWcGIqGlXzslJwNmjSl75z66ph7+3GAU=
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr28006844ejb.499.1608071249662;
 Tue, 15 Dec 2020 14:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-7-shy828301@gmail.com>
 <20201215024637.GM3913616@dread.disaster.area>
In-Reply-To: <20201215024637.GM3913616@dread.disaster.area>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Dec 2020 14:27:18 -0800
Message-ID: <CAHbLzkpgFO_WmxRwmSa_eb4KrQ3WXmHT0kOfn85HJAsfqvyC1Q@mail.gmail.com>
Subject: Re: [v2 PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Dave Chinner <david@fromorbit.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
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

On Mon, Dec 14, 2020 at 6:46 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Dec 14, 2020 at 02:37:19PM -0800, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Lots of lines way over 80 columns.

I thought that has been lifted to 100 columns.

>
> > ---
> >  mm/vmscan.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 83 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bf34167dd67e..bce8cf44eca2 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -203,6 +203,12 @@ DECLARE_RWSEM(shrinker_rwsem);
> >  static DEFINE_IDR(shrinker_idr);
> >  static int shrinker_nr_max;
> >
> > +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> > +{
> > +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> > +             !mem_cgroup_disabled();
> > +}
>
> Why do we care if mem_cgroup_disabled() is disabled here? The return
> of this function is then && sc->memcg, so if memcgs are disabled,
> sc->memcg will never be set and this mem_cgroup_disabled() check is
> completely redundant, right?

Yes, correct. I missed this point.

>
> > +
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  {
> >       int id, ret = -ENOMEM;
> > @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >  #endif
> >       return false;
> >  }
> > +
> > +static inline long count_nr_deferred(struct shrinker *shrinker,
> > +                                  struct shrink_control *sc)
> > +{
> > +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> > +     struct memcg_shrinker_deferred *deferred;
> > +     struct mem_cgroup *memcg = sc->memcg;
> > +     int nid = sc->nid;
> > +     int id = shrinker->id;
> > +     long nr;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid = 0;
> > +
> > +     if (per_memcg_deferred) {
> > +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> > +                                                  true);
> > +             nr = atomic_long_xchg(&deferred->nr_deferred[id], 0);
> > +     } else
> > +             nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +
> > +     return nr;
> > +}
> > +
> > +static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
> > +                                struct shrink_control *sc)
> > +{
> > +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> > +     struct memcg_shrinker_deferred *deferred;
> > +     struct mem_cgroup *memcg = sc->memcg;
> > +     int nid = sc->nid;
> > +     int id = shrinker->id;
>
> Oh, that's a nasty trap. Nobody knows if you mean "id" or "nid" in
> any of the code and a single letter type results in a bug.

Sure, will come up with more descriptive names. Maybe "nid" and "shrinker_id"?

>
> > +     long new_nr;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid = 0;
> > +
> > +     if (per_memcg_deferred) {
> > +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> > +                                                  true);
> > +             new_nr = atomic_long_add_return(nr, &deferred->nr_deferred[id]);
> > +     } else
> > +             new_nr = atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> > +
> > +     return new_nr;
> > +}
> >  #else
> > +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> > +{
> > +     return false;
> > +}
> > +
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  {
> >       return 0;
> > @@ -290,6 +347,29 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >  {
> >       return true;
> >  }
> > +
> > +static inline long count_nr_deferred(struct shrinker *shrinker,
> > +                                  struct shrink_control *sc)
> > +{
> > +     int nid = sc->nid;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid = 0;
> > +
> > +     return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +}
> > +
> > +static inline long set_nr_deferred(long nr, struct shrinker *shrinker,
> > +                                struct shrink_control *sc)
> > +{
> > +     int nid = sc->nid;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid = 0;
> > +
> > +     return atomic_long_add_return(nr,
> > +                                   &shrinker->nr_deferred[nid]);
> > +}
> >  #endif
>
> This is pretty ... verbose. It doesn't need to be this complex at
> all, and you shouldn't be duplicating code in multiple places. THere
> is also no need for any of these to be "inline" functions. The
> compiler will do that for static functions automatically if it makes
> sense.
>
> Ok, so you only do the memcg nr_deferred thing if NUMA_AWARE &&
> sc->memcg is true. so....
>
> static long shrink_slab_set_nr_deferred_memcg(...)
> {
>         int nid = sc->nid;
>
>         deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
>                                              true);
>         return atomic_long_add_return(nr, &deferred->nr_deferred[id]);
> }
>
> static long shrink_slab_set_nr_deferred(...)
> {
>         int nid = sc->nid;
>
>         if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>                 nid = 0;
>         else if (sc->memcg)
>                 return shrink_slab_set_nr_deferred_memcg(...., nid);
>
>         return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> }
>
> And now there's no duplicated code.

Thanks for the suggestion. Will incorporate in v3.

>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
