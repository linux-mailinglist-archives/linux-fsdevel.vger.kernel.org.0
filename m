Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18B42CCE31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 06:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgLCFCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 00:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLCFCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:02:05 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692A2C061A4E;
        Wed,  2 Dec 2020 21:01:25 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id n26so1529090eju.6;
        Wed, 02 Dec 2020 21:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDiLxMMzlVhCPYFL3c1sMpl1OLJgVHvtqSY0eugUJXg=;
        b=gFVhROOfpycTkoucWqzPkT6Dq5O5dYZoperXvoo3LEYKuTjUaQ0PYyYPJkJ+9iw4Lg
         BFjvXBI0Nxq7CcBQn8h61Vx8rKpd8W3YI/9/D8FzchbOm+ojq86DvXUsiTLceThqVzMW
         Kh9DvkVcGaeICIAAEy7DVVvu6xiQIouDMuXZAcfaDURfrj/OuAdXYc7cgSl2qQs7394m
         qpy4hAToGrP9N1/e6LmzXfL8JN2nA8YJUc9gXCjQWvPRET+hSC0gZS8FIN0FcRphcVh0
         MEf80EI78yyuTfhHTull9948v+I08ODRgdug5qHcvWtyLv4HPZBl5JWoYUPVO01SQGE4
         FYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDiLxMMzlVhCPYFL3c1sMpl1OLJgVHvtqSY0eugUJXg=;
        b=TDQcRou+ri31/3dphbIXFac6vKP2h03zgnxKrKPUS8zMSTJjTf0ttO4xaQM1V0Llbh
         8iOeq4kV33CMULHFRWN752w41irlg/djP5NLEjdfVBgub/okf1U+inBtF9msE+qNBeGP
         NzOnxY7V0BDfceZxXdnWogZn2KamO8bGiKBur//TNbc2BgvAdJ0qc4eC+CEVwoi1XdRt
         FiZ+u+YoOqT40mdBuN8KWhHxk7d1eLGvBVU/drH3ziXhv3zRqCZe5vORnVBgpc/GA0N4
         n6SCINKEPsmnJCBKPSdxp3NAE1gLuSw1ZtVn6MPfLZx4p7Zh1JjO6K37sifiOqQqPgX5
         eFXw==
X-Gm-Message-State: AOAM532z8+CTxJCXp8mjypHU7iXSkF+yxNRU35BBTi6ItIj3SOc3EEx4
        kdnPw2t66d17zLntCtgHmpQ6lpgd7tvO+gAPs2E=
X-Google-Smtp-Source: ABdhPJxvKUyHaptjmY3o3caBRtGvalJO4cdx2sjUT8zU/E5TuHjwWHAIhFBitBjyWdfH9+J/qBxN7LforJ+8ny2H8lE=
X-Received: by 2002:a17:906:7cc6:: with SMTP id h6mr969315ejp.161.1606971684136;
 Wed, 02 Dec 2020 21:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-7-shy828301@gmail.com>
 <20201203030841.GH1375014@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201203030841.GH1375014@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Dec 2020 21:01:12 -0800
Message-ID: <CAHbLzkp4fa02+4p7MiRLSRJyQTrFC0x6auH9zy+ynVh1B=J87g@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
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

On Wed, Dec 2, 2020 at 7:08 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Dec 02, 2020 at 10:27:22AM -0800, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 82 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index cba0bc8d4661..d569fdcaba79 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >  static DEFINE_IDR(shrinker_idr);
> >  static int shrinker_nr_max;
> >
> > +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> > +{
> > +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> > +             !mem_cgroup_disabled();
> > +}
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
> >
> >  /*
> > @@ -429,13 +509,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
> >
> >       freeable = shrinker->count_objects(shrinker, shrinkctl);
> >       if (freeable == 0 || freeable == SHRINK_EMPTY)
> > @@ -446,7 +523,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >        * and zero it so that other concurrent shrinker invocations
> >        * don't also do this scanning work.
> >        */
> > -     nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +     nr = count_nr_deferred(shrinker, shrinkctl);
> >
> >       total_scan = nr;
> >       if (shrinker->seeks) {
> > @@ -539,8 +616,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >        * move the unused scan count back into the shrinker in a
> >        * manner that handles concurrent updates.
> >        */
> > -     new_nr = atomic_long_add_return(next_deferred,
> > -                                     &shrinker->nr_deferred[nid]);
> > +     new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
>
> Ok, I think patch (1) can be just merged into this and then it would make total sense.

Sure. Makes sense to me.
