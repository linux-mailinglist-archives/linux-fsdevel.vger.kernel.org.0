Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8737A30FA7F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhBDSAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbhBDRYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:24:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15533C061786;
        Thu,  4 Feb 2021 09:23:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b2so5753593lfq.0;
        Thu, 04 Feb 2021 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOpxaL4F7/t3m09dYg6Q1YNaEeZ7LpVIXPASZszs72E=;
        b=nFG6ZBYASoDax1mzyo0ROoo/1XMgng/0r7hfeCpFfliypD4BMdnKaR/ZyivpCI8+f+
         dQG8Gcr9hgGVc6POWB7TLAYNjtU8tdSspA/fO6kCtlZtEaehH6JWXvkNllWzlvoVNvQm
         oj/LkgAntoCVloIVFhkI3m3UUR/ZTaY0kYncMEKSyPzaBEJLdX3bkmVoInpL1RbYiPWA
         a/8BXKNXUvXSWb9SDU1bkDCwDBnGpZneMgkNMgt5McKrWj7ZyLoUzyvfoj4nhnzzPdt8
         5t5aHAX4UliigvHJZ6E7g6lYY+Vfnez7cDKlGyt5CSeuV6fOQxa/4oPUelTUxTF/cA1i
         kYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOpxaL4F7/t3m09dYg6Q1YNaEeZ7LpVIXPASZszs72E=;
        b=LeS51xfG92A7OADwlpjItaOLAFtI4gqfM+S9/+HYdep6Lg2zQXW2/vtlG9vCOlVwTG
         nUZzj+A8EPj2WrTymNfrRyrklSYj0j8KbGH85C0I/XLbvKamBcahU5/QbIhTxq0F0uc1
         Z81CdSvGpY+ug85JC1YmPRcTrhFXENfDI4ckjrp5Adkz8abzn1HluqjNwSSaZ8Yb6mmI
         foGCs/qGT4SMQPbLNTohdiM5aoVsWRP1Uw8AMaTDAp5kmwps0OX7pqA+wDLdvTvsdEHC
         fNbTO6i959/QtgQozlc+zFD523MpHctqRIDW/dZnxVMdUrDGP+zuqVyF/NB69r17tRvY
         Bh6A==
X-Gm-Message-State: AOAM5305tUBcxTj7eKTroepfOXTCL8acyygGJqz62YOFtZ5TWIgvP2wx
        DwcoMfNcyFeRakzQgCgGhg4+qmLC3FiRLAUVtzU=
X-Google-Smtp-Source: ABdhPJy0MvRn9VwTz+6zZuX6AS/s2RZ+aX6qZ1urrTTk2HSFYQBE2vlSWzf2Sv2cg1LqY6+qWwngdjDotOPHjiMX0Ks=
X-Received: by 2002:a19:6447:: with SMTP id b7mr240129lfj.206.1612459420567;
 Thu, 04 Feb 2021 09:23:40 -0800 (PST)
MIME-Version: 1.0
References: <20210203172042.800474-1-shy828301@gmail.com> <20210203172042.800474-9-shy828301@gmail.com>
 <44cc18d2-5a47-91d0-dad2-599c251a3a8b@virtuozzo.com>
In-Reply-To: <44cc18d2-5a47-91d0-dad2-599c251a3a8b@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 4 Feb 2021 09:23:27 -0800
Message-ID: <CAHbLzkqysaU9WGUeeCFLHdnRiRm7uPXf6ikm7-TkRetRZyMLfg@mail.gmail.com>
Subject: Re: [v6 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
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

On Thu, Feb 4, 2021 at 12:42 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 03.02.2021 20:20, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 94 +++++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 77 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d9126f12890f..545422d2aeec 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -190,6 +190,13 @@ static int shrinker_nr_max;
> >  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> >       (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
> >
> > +static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> > +                                                  int nid)
> > +{
> > +     return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > +                                      lockdep_is_held(&shrinker_rwsem));
> > +}
>
> Thanks for the helper. Why not to introduce and become to use it in old places
> in a separate patch?

What do you mean about "old places"? Where was it introduced in v5 (in
patch #10)?

>
> > +
> >  static void free_shrinker_info_rcu(struct rcu_head *head)
> >  {
> >       kvfree(container_of(head, struct shrinker_info, rcu));
> > @@ -204,8 +211,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >       int size = m_size + d_size;
> >
> >       for_each_node(nid) {
> > -             old = rcu_dereference_protected(
> > -                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
> > +             old = shrinker_info_protected(memcg, nid);
> >               /* Not yet online memcg */
> >               if (!old)
> >                       return 0;
> > @@ -239,7 +245,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
> >
> >       for_each_node(nid) {
> >               pn = mem_cgroup_nodeinfo(memcg, nid);
> > -             info = rcu_dereference_protected(pn->shrinker_info, true);
> > +             info = shrinker_info_protected(memcg, nid);
> >               kvfree(info);
> >               rcu_assign_pointer(pn->shrinker_info, NULL);
> >       }
> > @@ -358,6 +364,25 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > +
> > +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> > +                                 struct mem_cgroup *memcg)
> > +{
> > +     struct shrinker_info *info;
> > +
> > +     info = shrinker_info_protected(memcg, nid);
> > +     return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> > +}
> > +
> > +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> > +                               struct mem_cgroup *memcg)
> > +{
> > +     struct shrinker_info *info;
> > +
> > +     info = shrinker_info_protected(memcg, nid);
> > +     return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> > +}
>
> Names confuse me a little bit. What about xchg_nr_deferred_memcg() and add_nr_deferred_memcg()?

add_nr_deferred_memcg() sounds more self-explained to me.

>
> >  static bool cgroup_reclaim(struct scan_control *sc)
> >  {
> >       return sc->target_mem_cgroup;
> > @@ -396,6 +421,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
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
> > @@ -407,6 +444,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
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
> > @@ -539,14 +609,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
> > @@ -556,7 +622,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >        * and zero it so that other concurrent shrinker invocations
> >        * don't also do this scanning work.
> >        */
> > -     nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +     nr = count_nr_deferred(shrinker, shrinkctl);
> >
> >       total_scan = nr;
> >       if (shrinker->seeks) {
> > @@ -647,14 +713,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
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
> > @@ -674,8 +735,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >       if (!down_read_trylock(&shrinker_rwsem))
> >               return 0;
> >
> > -     info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > -                                      true);
> > +     info = shrinker_info_protected(memcg, nid);
> >       if (unlikely(!info))
> >               goto unlock;
> >
> >
>
>
