Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9233112A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 21:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhBES5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 13:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbhBEPDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:03:02 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A956C061574;
        Fri,  5 Feb 2021 08:41:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s5so9484902edw.8;
        Fri, 05 Feb 2021 08:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPAfhUCESjqYxvhklcWSyjS56rINMVKFprAe6haqawU=;
        b=rXFe1jhCZeNcdBQhuNY4eZo7BsFOPNT9L/SeY1Il1LFvC5cRCZno6NhfHj7FJU2/aS
         ZpkOyBQA83Gzvr1roqPK0C2VPfPJ4P7qzogYHxGTJIZjX6wo1n6A976sQTd4nnodQXdi
         Neu1bYFA/oBqHSlCbsgJFj/24TLw/FKc9fl7FNiZHJ6qUfqFW8aXyiDf3M82QMWfDwKx
         ao9TgB3qk6EnVHolvpvVHjynOdD8FrAII075zLTP6CA6pkQ2uezXZFTPhdo4JRpeXrOo
         hXCGpadCpsTRD5r5Wv9Ohzv24WPMmNzlgqmV2sshp4+i0NTR09Iz64N9XvJX/p/hQAiV
         3CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPAfhUCESjqYxvhklcWSyjS56rINMVKFprAe6haqawU=;
        b=pWWCMQj97zwC3g4ndy0eAnfqQgG8xetFVpmt2R8PfHv6RCW8kbeZNlhwduXDELxPQN
         pPaziHDDJTZ23mJXBgN+L/TUqelaI3qG1yGEh6xzKDFsfPK6f+ZshRBBeDuc3ySIsK+b
         h8qry1fgo0aXD+6CZsK+YyC90ivB4eZ7W2S/hG0KsqEonpxYUtjvxF17Zv9bCToCqv5F
         MFGrrueIEEKnuSj9prWD5ZpdjLt0cMR2kZ46jI0MbJbI3oswkKrK+lV1SWy2Xvm4XNdl
         SZr4Fb2yZfxrRyb+mCm9YCEGRGhsc1yQuRpuZAKy4jdklzmowVGouhud+fXM4P9HD0Px
         mUdw==
X-Gm-Message-State: AOAM530Rg6CeOrXzBowLUHWOwfC5KrpIPdIcUzwlx6UsNubiADUAw2t5
        s6FhtzBxtYnGWWPJvWUsO0VPKafoZq6Nr0dI08M=
X-Google-Smtp-Source: ABdhPJy01/k0tVwbX+Xs5TBFDIZkLFpNMKVuWBQrv7nsSZ6X7Y8KqfscMem94WPBqFn4/q4K4rcTUioRNWEiI2HImYc=
X-Received: by 2002:a05:6402:3069:: with SMTP id bs9mr2945760edb.151.1612543266826;
 Fri, 05 Feb 2021 08:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20210203172042.800474-1-shy828301@gmail.com> <20210203172042.800474-9-shy828301@gmail.com>
 <44cc18d2-5a47-91d0-dad2-599c251a3a8b@virtuozzo.com> <CAHbLzkqysaU9WGUeeCFLHdnRiRm7uPXf6ikm7-TkRetRZyMLfg@mail.gmail.com>
 <ea64b512-863a-da37-f925-09ba07d621e6@virtuozzo.com>
In-Reply-To: <ea64b512-863a-da37-f925-09ba07d621e6@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 5 Feb 2021 08:40:55 -0800
Message-ID: <CAHbLzkptDuAckKB_GCY8ct2U_6FjLHJt7FKhU1qfg7G-RmbBSQ@mail.gmail.com>
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

On Fri, Feb 5, 2021 at 6:42 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 04.02.2021 20:23, Yang Shi wrote:
> > On Thu, Feb 4, 2021 at 12:42 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 03.02.2021 20:20, Yang Shi wrote:
> >>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> >>> will be used in the following cases:
> >>>     1. Non memcg aware shrinkers
> >>>     2. !CONFIG_MEMCG
> >>>     3. memcg is disabled by boot parameter
> >>>
> >>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >>> ---
> >>>  mm/vmscan.c | 94 +++++++++++++++++++++++++++++++++++++++++++----------
> >>>  1 file changed, 77 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index d9126f12890f..545422d2aeec 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -190,6 +190,13 @@ static int shrinker_nr_max;
> >>>  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
> >>>       (DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
> >>>
> >>> +static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> >>> +                                                  int nid)
> >>> +{
> >>> +     return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> >>> +                                      lockdep_is_held(&shrinker_rwsem));
> >>> +}
> >>
> >> Thanks for the helper. Why not to introduce and become to use it in old places
> >> in a separate patch?
> >
> > What do you mean about "old places"? Where was it introduced in v5 (in
> > patch #10)?
>
> I mean existing places touched by this patch, which became to use the new helper
> in this patch: free_shrinker_info(), expand_one_shrinker_info(), shrink_slab_memcg().

Aha, I see. So, you mean add the helper before in a separate patch.
Right after patch #5 (which rename shrinker_map to shrinker_info)
should be a good place.

>
> >>
> >>> +
> >>>  static void free_shrinker_info_rcu(struct rcu_head *head)
> >>>  {
> >>>       kvfree(container_of(head, struct shrinker_info, rcu));
> >>> @@ -204,8 +211,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >>>       int size = m_size + d_size;
> >>>
> >>>       for_each_node(nid) {
> >>> -             old = rcu_dereference_protected(
> >>> -                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_info, true);
> >>> +             old = shrinker_info_protected(memcg, nid);
> >>>               /* Not yet online memcg */
> >>>               if (!old)
> >>>                       return 0;
> >>> @@ -239,7 +245,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
> >>>
> >>>       for_each_node(nid) {
> >>>               pn = mem_cgroup_nodeinfo(memcg, nid);
> >>> -             info = rcu_dereference_protected(pn->shrinker_info, true);
> >>> +             info = shrinker_info_protected(memcg, nid);
> >>>               kvfree(info);
> >>>               rcu_assign_pointer(pn->shrinker_info, NULL);
> >>>       }
> >>> @@ -358,6 +364,25 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >>>       up_write(&shrinker_rwsem);
> >>>  }
> >>>
> >>> +
> >>> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> >>> +                                 struct mem_cgroup *memcg)
> >>> +{
> >>> +     struct shrinker_info *info;
> >>> +
> >>> +     info = shrinker_info_protected(memcg, nid);
> >>> +     return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> >>> +}
> >>> +
> >>> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> >>> +                               struct mem_cgroup *memcg)
> >>> +{
> >>> +     struct shrinker_info *info;
> >>> +
> >>> +     info = shrinker_info_protected(memcg, nid);
> >>> +     return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> >>> +}
> >>
> >> Names confuse me a little bit. What about xchg_nr_deferred_memcg() and add_nr_deferred_memcg()?
> >
> > add_nr_deferred_memcg() sounds more self-explained to me.
> >
> >>
> >>>  static bool cgroup_reclaim(struct scan_control *sc)
> >>>  {
> >>>       return sc->target_mem_cgroup;
> >>> @@ -396,6 +421,18 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >>>  {
> >>>  }
> >>>
> >>> +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker,
> >>> +                                 struct mem_cgroup *memcg)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> >>> +                               struct mem_cgroup *memcg)
> >>> +{
> >>> +     return 0;
> >>> +}
> >>> +
> >>>  static bool cgroup_reclaim(struct scan_control *sc)
> >>>  {
> >>>       return false;
> >>> @@ -407,6 +444,39 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >>>  }
> >>>  #endif
> >>>
> >>> +static long count_nr_deferred(struct shrinker *shrinker,
> >>> +                           struct shrink_control *sc)
> >>> +{
> >>> +     int nid = sc->nid;
> >>> +
> >>> +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >>> +             nid = 0;
> >>> +
> >>> +     if (sc->memcg &&
> >>> +         (shrinker->flags & SHRINKER_MEMCG_AWARE))
> >>> +             return count_nr_deferred_memcg(nid, shrinker,
> >>> +                                            sc->memcg);
> >>> +
> >>> +     return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> >>> +}
> >>> +
> >>> +
> >>> +static long set_nr_deferred(long nr, struct shrinker *shrinker,
> >>> +                         struct shrink_control *sc)
> >>> +{
> >>> +     int nid = sc->nid;
> >>> +
> >>> +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >>> +             nid = 0;
> >>> +
> >>> +     if (sc->memcg &&
> >>> +         (shrinker->flags & SHRINKER_MEMCG_AWARE))
> >>> +             return set_nr_deferred_memcg(nr, nid, shrinker,
> >>> +                                          sc->memcg);
> >>> +
> >>> +     return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> >>> +}
> >>> +
> >>>  /*
> >>>   * This misses isolated pages which are not accounted for to save counters.
> >>>   * As the data only determines if reclaim or compaction continues, it is
> >>> @@ -539,14 +609,10 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >>>       long freeable;
> >>>       long nr;
> >>>       long new_nr;
> >>> -     int nid = shrinkctl->nid;
> >>>       long batch_size = shrinker->batch ? shrinker->batch
> >>>                                         : SHRINK_BATCH;
> >>>       long scanned = 0, next_deferred;
> >>>
> >>> -     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >>> -             nid = 0;
> >>> -
> >>>       freeable = shrinker->count_objects(shrinker, shrinkctl);
> >>>       if (freeable == 0 || freeable == SHRINK_EMPTY)
> >>>               return freeable;
> >>> @@ -556,7 +622,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >>>        * and zero it so that other concurrent shrinker invocations
> >>>        * don't also do this scanning work.
> >>>        */
> >>> -     nr = atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> >>> +     nr = count_nr_deferred(shrinker, shrinkctl);
> >>>
> >>>       total_scan = nr;
> >>>       if (shrinker->seeks) {
> >>> @@ -647,14 +713,9 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> >>>               next_deferred = 0;
> >>>       /*
> >>>        * move the unused scan count back into the shrinker in a
> >>> -      * manner that handles concurrent updates. If we exhausted the
> >>> -      * scan, there is no need to do an update.
> >>> +      * manner that handles concurrent updates.
> >>>        */
> >>> -     if (next_deferred > 0)
> >>> -             new_nr = atomic_long_add_return(next_deferred,
> >>> -                                             &shrinker->nr_deferred[nid]);
> >>> -     else
> >>> -             new_nr = atomic_long_read(&shrinker->nr_deferred[nid]);
> >>> +     new_nr = set_nr_deferred(next_deferred, shrinker, shrinkctl);
> >>>
> >>>       trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new_nr, total_scan);
> >>>       return freed;
> >>> @@ -674,8 +735,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >>>       if (!down_read_trylock(&shrinker_rwsem))
> >>>               return 0;
> >>>
> >>> -     info = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> >>> -                                      true);
> >>> +     info = shrinker_info_protected(memcg, nid);
> >>>       if (unlikely(!info))
> >>>               goto unlock;
> >>>
> >>>
> >>
> >>
>
>
