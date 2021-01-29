Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3434308B70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 18:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhA2RXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 12:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhA2RW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:22:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1006C061573;
        Fri, 29 Jan 2021 09:22:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c2so11384925edr.11;
        Fri, 29 Jan 2021 09:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jMPBcH5Hii5Z/IhKWkdbAh1C9dd7EBdelppvl4SiIw=;
        b=PK1xfj09tP+01uheFIWbCQc6laIlltYPmC4NcUiZlgM+LnOKqchn8+Rq/8WCq22xoY
         DMpJTUtRd2aka8LrEMJTLkVSaBUjlkzEHsDUZ3hDkVLMtedmE/bKIKmcwDamH4X29UdS
         azZ7NIBNJDlH/p3ZSGwOW8RKgAa8KaGKgLy+c2I39zibADldDDiSeJjB99bfYK+3nzJn
         ArM1b6Ch9YozH4cs1E3mA0/iv9r1sRF93N5P9qeAvlbdwONCaQaY6PRtRO811NVkY86t
         9oqSd7CegyzgnC2soucu81gGIQ0ZJESWOCYqdWoq3SlMP9DMh9YiRgQOIeIaZoA3sjNg
         vv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jMPBcH5Hii5Z/IhKWkdbAh1C9dd7EBdelppvl4SiIw=;
        b=CKx+J4JybBB2vobTPMKaC3m6p1FQycJ0ZO2C4KHHGJc9yusRM7Jiib6BYEzgWynXCT
         +rHeXZRn3c3b+RRFayFy8jkc6LaD/eTyjzt1fVq4FIvFUfPUD0xUczTgUF3ky8ivkyoI
         5epEtTX5HTylHlFWBaRlqIEG5I1FdwArBWpDK0WYcuuKF4YVepMQ3KNkZtUqkvjsdOf+
         9qxrfTHPQGZjuCVn9Bm77a9IoGfEf/lKgeCnHd08HmZpCkmrzyfBRHw9C9RNhpkOzpyh
         fkLJDanxHT2RALMD0dmSza6OXiWIn7U73Hz0E1ZDSGJ5TKsDWJrZAMn/JXQrGp0CThUa
         ch/g==
X-Gm-Message-State: AOAM531YrDulT7iXObrWYrNN3azEI+2tScvdYhvA26aybKpa7AfyLIZV
        9UGAf/KXY8/KNVyw/oaQPzE/G6ekV7l95tcSFek=
X-Google-Smtp-Source: ABdhPJxpwXu1vxBEysF+v5JL3vgVQlczm1769e4KAPZ+HjtqgV5OmuC2y9n/9vFsEAHurGu8ufV+9bmRcFmeymATWAI=
X-Received: by 2002:a50:e8c1:: with SMTP id l1mr6288647edn.168.1611940936530;
 Fri, 29 Jan 2021 09:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-9-shy828301@gmail.com>
 <fcb536e1-6808-5926-6688-89b98cfae7ad@virtuozzo.com> <7c0152a2-f846-c696-4dec-63f285d20ae5@virtuozzo.com>
In-Reply-To: <7c0152a2-f846-c696-4dec-63f285d20ae5@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 09:22:04 -0800
Message-ID: <CAHbLzkqkv4Z01G0NmNbJyF-dDnavHtAwC0U0YnpL_N=xhQ9kJQ@mail.gmail.com>
Subject: Re: [v5 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
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

On Fri, Jan 29, 2021 at 6:59 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 29.01.2021 17:55, Kirill Tkhai wrote:
> > On 28.01.2021 02:33, Yang Shi wrote:
> >> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> >> will be used in the following cases:
> >>     1. Non memcg aware shrinkers
> >>     2. !CONFIG_MEMCG
> >>     3. memcg is disabled by boot parameter
> >>
> >> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >> ---
> >>  mm/vmscan.c | 87 ++++++++++++++++++++++++++++++++++++++++++++---------
> >>  1 file changed, 73 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 20be0db291fe..e1f8960f5cf6 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -205,7 +205,8 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >>
> >>      for_each_node(nid) {
> >>              old = rcu_dereference_protected(
> >> -                    mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
> >> +                    mem_cgroup_nodeinfo(memcg, nid)->shrinker_info,
> >> +                    lockdep_is_held(&shrinker_rwsem));
> >
> > Won't it better to pack this repeating pattern into helper function, e.g.:
> >
> > static struct shrinker_info memcg_shrinker_info(struct mem_cgroup *memcg, int nid)
> > {
> >       return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> >                                          lockdep_is_held(&shrinker_rwsem));
> > }
> >
> > ?
> >
> > Even shrink_slab_memcg() may want to use it.
>
> Hm, I see you already introduced a helper in [10/11], but it is used in only place.
> Then, we should use it for all places (introduce the helper earlier).

Yes, good point. Will fix in v6.

>
> >>              /* Not yet online memcg */
> >>              if (!old)
> >>                      return 0;
> >> @@ -239,7 +240,8 @@ void free_shrinker_info(struct mem_cgroup *memcg)
> >>
> >>      for_each_node(nid) {
> >>              pn = mem_cgroup_nodeinfo(memcg, nid);
> >> -            info = rcu_dereference_protected(pn->shrinker_info, true);
> >> +            info = rcu_dereference_protected(pn->shrinker_info,
> >> +                                             lockdep_is_held(&shrinker_rwsem));
> >>              if (info)
> >>                      kvfree(info);
> >>              rcu_assign_pointer(pn->shrinker_info, NULL);
> >> @@ -360,6 +362,27 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >>      up_write(&shrinker_rwsem);
> >>  }
> >>
> >> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> >> +                                struct mem_cgroup *memcg)
> >> +{
> >> +    struct shrinker_info *info;
> >> +
> >> +    info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> >> +                                     lockdep_is_held(&shrinker_rwsem));
> >> +    return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> >> +}
> >> +
> >> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> >> +                              struct mem_cgroup *memcg)
> >> +{
> >> +    struct shrinker_info *info;
> >> +
> >> +    info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> >> +                                     lockdep_is_held(&shrinker_rwsem));
> >> +
> >> +    return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> >> +}
> >> +
> >>  static bool cgroup_reclaim(struct scan_control *sc)
> >>  {
> >>      return sc->target_mem_cgroup;
> >> @@ -398,6 +421,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >>  {
> >>  }
> >>
> >> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> >> +                                struct mem_cgroup *memcg)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> >> +                              struct mem_cgroup *memcg)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >>  static bool cgroup_reclaim(struct scan_control *sc)
> >>  {
> >>      return false;
> >> @@ -409,6 +444,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >>  }
> >>  #endif
> >>
> >> +static long count_nr_deferred(struct shrinker *shrinker,
> >> +                          struct shrink_control *sc)
> >> +{
> >> +    int nid = sc->nid;
> >> +
> >> +    if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >> +            nid = 0;
> >> +
> >> +    if (sc->memcg &&
> >> +        (shrinker->flags & SHRINKER_MEMCG_AWARE))
> >> +            return count_nr_deferred_memcg(nid, shrinker,
> >> +                                           sc->memcg);
> >> +
> >> +    return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> >> +}
> >> +
> >> +
> >> +static long set_nr_deferred(long nr, struct shrinker *shrinker,
> >> +                        struct shrink_control *sc)
> >> +{
> >> +    int nid = sc->nid;
> >> +
> >> +    if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >> +            nid = 0;
> >> +
> >> +    if (sc->memcg &&
> >> +        (shrinker->flags & SHRINKER_MEMCG_AWARE))
> >> +            return set_nr_deferred_memcg(nr, nid, shrinker,
> >> +                                         sc->memcg);
> >> +
> >> +    return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> >> +}
> >> +
> >>  /*
> >>   * This misses isolated pages which are not accounted for to save counters.
> >>   * As the data only determines if reclaim or compaction continues, it is
> >> @@ -545,14 +613,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >>      long freeable;
> >>      long nr;
> >>      long new_nr;
> >> -    int nid = shrinkctl->nid;
> >>      long batch_size = shrinker->batch ? shrinker->batch
> >>                                        : SHRINK_BATCH;
> >>      long scanned = 0, next_deferred;
> >>
> >> -    if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >> -            nid = 0;
> >> -
> >>      freeable = shrinker->count_objects(shrinker, shrinkctl);
> >>      if (freeable == 0 || freeable == SHRINK_EMPTY)
> >>              return freeable;
> >> @@ -562,7 +626,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >>       * and zero it so that other concurrent shrinker invocations
> >>       * don't also do this scanning work.
> >>       */
> >> -    nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> >> +    nr = count_nr_deferred(shrinker, shrinkctl);
> >>
> >>      total_scan = nr;
> >>      if (shrinker->seeks) {
> >> @@ -653,14 +717,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >>              next_deferred = 0;
> >>      /*
> >>       * move the unused scan count back into the shrinker in a
> >> -     * manner that handles concurrent updates. If we exhausted the
> >> -     * scan, there is no need to do an update.
> >> +     * manner that handles concurrent updates.
> >>       */
> >> -    if (next_deferred > 0)
> >> -            new_nr = atomic_long_add_return(next_deferred,
> >> -                                            &shrinker->nr_deferred[nid]);
> >> -    else
> >> -            new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
> >> +    new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
> >>
> >>      trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
> >>      return freed;
> >>
> >
>
>
