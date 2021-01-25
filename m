Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F0E302D59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbhAYVLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbhAYVJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:09:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB79C061573;
        Mon, 25 Jan 2021 13:08:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gx5so20050828ejb.7;
        Mon, 25 Jan 2021 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNXeXc3vGhxTCm0XPiMscGdXWu7Ggi1oyXI1subSlPc=;
        b=eNT5m3XBY71AOp5C+JofQOqSiVSnVIHplG8Hv4i4ZXn0o3BHGJ68hHRKj/jS3KgtW9
         tKhGTx+B9nQkKCdr76/T+W0hf7jUvHT/cMdrBiq0QPDYooOKCCVQDLTGAjtV5OLNulqq
         MtLz2U3ObznDzaFsCT/1ArxlbsiSZq9wedFqEiwylDJHJ+pNGSmDBklA2LJvqbcPIpq3
         rSVtuWp6B1N9FnRWY8+0mheqDDGnyWJBXK6XOepbN+yltO58LL4C23mmlZEhpV942pQQ
         MdNToxw4s+8ADzWI+fHC+LL0I02wjVHIu61oOuv6BseNeg/PQ9pkIVNpXTEIRto6hGQC
         vZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNXeXc3vGhxTCm0XPiMscGdXWu7Ggi1oyXI1subSlPc=;
        b=cXjoKLyY+H/p5Lvbf+sWTiVo0IEpm48JQsxcgocDbausu2LuklNqIe67QJhAjtEXT4
         gk8+DAoFhJmgbbqC/BaB7b0Sr/OcI3F4hFUOacLRmt56IKN0pA+enFeGesfrWrPCOtdY
         TRipUjqWrGpOGu2CYDLl9Q2ENTr33JI7j70ygoR8LcFGA2BZZPl0IZKP8dPHd39yUTw8
         seca5Tec3ECmyyIe4Dz09WLcnDuwexGEz9rS8QkiqDwsNp9xGJPwuNCh+ApsWSohXbCh
         U1oIdX3dBA99szKFesz8VZmcAzhAZ/+/WPfg/rMmYHijqUMqCYnwTCsKXO3IhIAFcLHz
         dTjQ==
X-Gm-Message-State: AOAM5319qMNuXQOheAlbaC6Vwevmp4vH3OmGaHfkwymhccL2zODcKnXN
        VfCy4n++LPHaVydOtUjbeBvjiEaXyHmzRNJCRSmivweRu1s=
X-Google-Smtp-Source: ABdhPJwhZLoyEyyuQP9vDiDAuzHGfDislX6Yw/pL7fd9JAcf0IFFTYreblvhZn3h5HVUFyQ9FMmMbPGDFxdk4xCN9K8=
X-Received: by 2002:a17:906:f841:: with SMTP id ks1mr1477717ejb.507.1611608915557;
 Mon, 25 Jan 2021 13:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20210121230621.654304-1-shy828301@gmail.com> <20210121230621.654304-8-shy828301@gmail.com>
 <1c621cd8-7d13-ddfa-bb83-d4260a1bb754@virtuozzo.com>
In-Reply-To: <1c621cd8-7d13-ddfa-bb83-d4260a1bb754@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 25 Jan 2021 13:08:23 -0800
Message-ID: <CAHbLzkrnWy5wB0mhGjZ__ikUSoH09zbbb59jhXHmf6k+A3netw@mail.gmail.com>
Subject: Re: [v4 PATCH 07/11] mm: vmscan: add per memcg shrinker nr_deferred
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

On Mon, Jan 25, 2021 at 1:31 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 22.01.2021 02:06, Yang Shi wrote:
> > Currently the number of deferred objects are per shrinker, but some slabs, for example,
> > vfs inode/dentry cache are per memcg, this would result in poor isolation among memcgs.
> >
> > The deferred objects typically are generated by __GFP_NOFS allocations, one memcg with
> > excessive __GFP_NOFS allocations may blow up deferred objects, then other innocent memcgs
> > may suffer from over shrink, excessive reclaim latency, etc.
> >
> > For example, two workloads run in memcgA and memcgB respectively, workload in B is vfs
> > heavy workload.  Workload in A generates excessive deferred objects, then B's vfs cache
> > might be hit heavily (drop half of caches) by B's limit reclaim or global reclaim.
> >
> > We observed this hit in our production environment which was running vfs heavy workload
> > shown as the below tracing log:
> >
> > <...>-409454 [016] .... 28286961.747146: mm_shrink_slab_start: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > nid: 1 objects to shrink 3641681686040 gfp_flags GFP_HIGHUSER_MOVABLE|__GFP_ZERO pgs_scanned 1 lru_pgs 15721
> > cache items 246404277 delta 31345 total_scan 123202138
> > <...>-409454 [022] .... 28287105.928018: mm_shrink_slab_end: super_cache_scan+0x0/0x1a0 ffff9a83046f3458:
> > nid: 1 unused scan count 3641681686040 new scan count 3641798379189 total_scan 602
> > last shrinker return val 123186855
> >
> > The vfs cache and page cache ration was 10:1 on this machine, and half of caches were dropped.
> > This also resulted in significant amount of page caches were dropped due to inodes eviction.
> >
> > Make nr_deferred per memcg for memcg aware shrinkers would solve the unfairness and bring
> > better isolation.
> >
> > When memcg is not enabled (!CONFIG_MEMCG or memcg disabled), the shrinker's nr_deferred
> > would be used.  And non memcg aware shrinkers use shrinker's nr_deferred all the time.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/memcontrol.h |  7 +++---
> >  mm/vmscan.c                | 49 +++++++++++++++++++++++++-------------
> >  2 files changed, 36 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 62b888b88a5f..e0384367e07d 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -93,12 +93,13 @@ struct lruvec_stat {
> >  };
> >
> >  /*
> > - * Bitmap of shrinker::id corresponding to memcg-aware shrinkers,
> > - * which have elements charged to this memcg.
> > + * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
> > + * shrinkers, which have elements charged to this memcg.
> >   */
> >  struct shrinker_info {
> >       struct rcu_head rcu;
> > -     unsigned long map[];
> > +     unsigned long *map;
> > +     atomic_long_t *nr_deferred;
> >  };
> >
> >  /*
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 018e1beb24c9..722aa71b13b2 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -192,11 +192,13 @@ static void free_shrinker_info_rcu(struct rcu_head *head)
> >       kvfree(container_of(head, struct shrinker_info, rcu));
> >  }
> >
> > -static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> > -                                int size, int old_size)
> > +static int expand_one_shrinker_info(struct mem_cgroup *memcg, int nr_max,
> > +                                 int m_size, int d_size,
> > +                                 int old_m_size, int old_d_size)
> >  {
> >       struct shrinker_info *new, *old;
> >       int nid;
> > +     int size = m_size + d_size;
> >
> >       for_each_node(nid) {
> >               old = rcu_dereference_protected(
> > @@ -209,9 +211,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> >               if (!new)
> >                       return -ENOMEM;
> >
> > -             /* Set all old bits, clear all new bits */
> > -             memset(new->map, (int)0xff, old_size);
> > -             memset((void *)new->map + old_size, 0, size - old_size);
> > +             new->map = (unsigned long *)(new + 1);
> > +             new->nr_deferred = (atomic_long_t *)(new->map +
> > +                                     nr_max / BITS_PER_LONG + 1);
>
> Why not
>
>                 new->nr_deferred = (void *)new->map + m_size;
> ?
>
> > +
> > +             /* map: set all old bits, clear all new bits */
> > +             memset(new->map, (int)0xff, old_m_size);
> > +             memset((void *)new->map + old_m_size, 0, m_size - old_m_size);
> > +             /* nr_deferred: copy old values, clear all new values */
> > +             memcpy(new->nr_deferred, old->nr_deferred, old_d_size);
> > +             memset((void *)new->nr_deferred + old_d_size, 0, d_size - old_d_size);
> >
> >               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, new);
> >               call_rcu(&old->rcu, free_shrinker_info_rcu);
> > @@ -226,9 +235,6 @@ void free_shrinker_info(struct mem_cgroup *memcg)
> >       struct shrinker_info *info;
> >       int nid;
> >
> > -     if (mem_cgroup_is_root(memcg))
> > -             return;
> > -
> >       for_each_node(nid) {
> >               pn = mem_cgroup_nodeinfo(memcg, nid);
> >               info = rcu_dereference_protected(pn->shrinker_info, true);
> > @@ -242,12 +248,13 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> >  {
> >       struct shrinker_info *info;
> >       int nid, size, ret = 0;
> > -
> > -     if (mem_cgroup_is_root(memcg))
> > -             return 0;
> > +     int m_size, d_size = 0;
> >
> >       down_write(&shrinker_rwsem);
> > -     size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> > +     m_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> > +     d_size = shrinker_nr_max * sizeof(atomic_long_t);
> > +     size = m_size + d_size;
> > +
> >       for_each_node(nid) {
> >               info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
> >               if (!info) {
> > @@ -255,6 +262,9 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
> >                       ret = -ENOMEM;
> >                       break;
> >               }
> > +             info->map = (unsigned long *)(info + 1);
> > +             info->nr_deferred = (atomic_long_t *)(info->map +
> > +                                     shrinker_nr_max / BITS_PER_LONG + 1);
>
> Why not:
>                 info->nr_deferred = (void*)info->map + m_size;

Yes, definitely. Will fix in v5.

> ?
>
> >               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
> >       }
> >       up_write(&shrinker_rwsem);
> > @@ -266,10 +276,16 @@ static int expand_shrinker_info(int new_id)
> >  {
> >       int size, old_size, ret = 0;
> >       int new_nr_max = new_id + 1;
> > +     int m_size, d_size = 0;
> > +     int old_m_size, old_d_size = 0;
> >       struct mem_cgroup *memcg;
> >
> > -     size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> > -     old_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> > +     m_size = (new_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
> > +     d_size = new_nr_max * sizeof(atomic_long_t);
> > +     size = m_size + d_size;
> > +     old_m_size = (shrinker_nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long);
>
> Could you please pack this twice repeating pattern into some macro? E.g.,
>
> #define NR_MAX_TO_SHR_MAP_SIZE(nr_max)  \
>         ((nr_max / BITS_PER_LONG + 1) * sizeof(unsigned long))

Sure. Will incorporate in v5.

>
> > +     old_d_size = shrinker_nr_max * sizeof(atomic_long_t);
> > +     old_size = old_m_size + old_d_size;
> >       if (size <= old_size)
> >               return 0;
> >
> > @@ -278,9 +294,8 @@ static int expand_shrinker_info(int new_id)
> >
> >       memcg = mem_cgroup_iter(NULL, NULL, NULL);
> >       do {
> > -             if (mem_cgroup_is_root(memcg))
> > -                     continue;
> > -             ret = expand_one_shrinker_info(memcg, size, old_size);
> > +             ret = expand_one_shrinker_info(memcg, new_nr_max, m_size, d_size,
> > +                                            old_m_size, old_d_size);
> >               if (ret) {
> >                       mem_cgroup_iter_break(NULL, memcg);
> >                       goto out;
> >
>
>
