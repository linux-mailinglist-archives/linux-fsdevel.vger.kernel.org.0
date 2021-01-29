Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF6308B21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 18:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhA2RMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 12:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhA2RMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:12:06 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6819FC061573;
        Fri, 29 Jan 2021 09:11:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s11so11380639edd.5;
        Fri, 29 Jan 2021 09:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OnFDzNj7cWGJLqBGJzUfbO1T+zEBVXf+QBk+hdV1M8=;
        b=JFOKixycertfCRFfIMeQwiMaAZ1sXlZ/BBZFI+ikVCB/mqqsGeeNcm4TXTRawPyC/6
         s0u89JJAajce85Vm8tddYY+oT1KOP+IbnGy3ctMDynAQ34l+BIRYbOFEeD9FCHA/Mx4f
         G5mcNUCDmIFAZ40OEAU8y2DE1a0wYMAo55RjhsCcPh8LPGMatXqjmBmyLKKke14JMpmn
         zPcnDNLLwTLr7RL6Jc4MjtEIoWfAIPake90Uq3r0hyJM0zUhiUeWsVlf2r932c388VOT
         N1CB7Kj7AbNwZ/tsu1i+iNZ0bTOuj7sACId77zCedUQCOQvr6CoasHY0rjlbEyjC8X/O
         6dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OnFDzNj7cWGJLqBGJzUfbO1T+zEBVXf+QBk+hdV1M8=;
        b=hkk8x4E1pAG5+tcq4eOR/nfA1GgMBF7D49FcOq9teiN77O0K0Z9RdamwFyj6Npsi5O
         4SJMLrvykuwWTUP/Nt//CKL3LVML1u39Er4JZjRvErpxk8UsvE9lwI02kUo26M+I7MSl
         2T68f+e2nmf0gu7FNsuzptJG+w6byGa12DZyvEA1sdQ41pWjPWMnsw/jeFXEpkN5iC/u
         gUdWCXa/L0TlzvWEy6qPBiokiN73/GkAVtfkeLFKHb0zciR8zZMew4zx/fjG8PUrqeoL
         N499ZFzyfz4EifBzFc7drqLK4VfyA+aV91/me8VavCqTcDDDxeIkYB7lfaoWa6g0GqM1
         g84g==
X-Gm-Message-State: AOAM531sudW4RRkbcdN2cmvSPVQE+aPYUu1U4lNcuTtwtkkPjyOGtaHV
        5Vwp//GVrhKQW7OSk3OAxLcEyEmAaVci1ut6zno=
X-Google-Smtp-Source: ABdhPJxNo5UKRFKAnQEu7lxYJQb+oktSl279qRMZuC9O4q9/BkqszRKkA9rP6JhWHw7Ug9SgvWlfmdVQRfLTvE5bATM=
X-Received: by 2002:a50:fc04:: with SMTP id i4mr6266684edr.137.1611940285054;
 Fri, 29 Jan 2021 09:11:25 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-3-shy828301@gmail.com>
 <4d7a1b21-39d5-0c18-19bf-0846385ab1f6@virtuozzo.com>
In-Reply-To: <4d7a1b21-39d5-0c18-19bf-0846385ab1f6@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 09:11:12 -0800
Message-ID: <CAHbLzkrt6vAn-ShOTkVMMxrw8DTnz4AujDnXM92L3oNko_QCxQ@mail.gmail.com>
Subject: Re: [v5 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling code
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

On Fri, Jan 29, 2021 at 6:34 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 28.01.2021 02:33, Yang Shi wrote:
> > The shrinker map management is not purely memcg specific, it is at the intersection
> > between memory cgroup and shrinkers.  It's allocation and assignment of a structure,
> > and the only memcg bit is the map is being stored in a memcg structure.  So move the
> > shrinker_maps handling code into vmscan.c for tighter integration with shrinker code,
> > and remove the "memcg_" prefix.  There is no functional change.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/memcontrol.h |  12 ++--
> >  mm/huge_memory.c           |   4 +-
> >  mm/list_lru.c              |   6 +-
> >  mm/memcontrol.c            | 130 +------------------------------------
> >  mm/vmscan.c                | 130 ++++++++++++++++++++++++++++++++++++-
> >  5 files changed, 142 insertions(+), 140 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index eeb0b52203e9..0ee2924991fb 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1581,10 +1581,10 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
> >       return false;
> >  }
> >
> > -extern int memcg_expand_shrinker_maps(int new_id);
> > -
> > -extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> > -                                int nid, int shrinker_id);
> > +extern int alloc_shrinker_maps(struct mem_cgroup *memcg);
> > +extern void free_shrinker_maps(struct mem_cgroup *memcg);
> > +extern void set_shrinker_bit(struct mem_cgroup *memcg,
> > +                          int nid, int shrinker_id);
> >  #else
> >  #define mem_cgroup_sockets_enabled 0
> >  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> > @@ -1594,8 +1594,8 @@ static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
> >       return false;
> >  }
> >
> > -static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> > -                                       int nid, int shrinker_id)
> > +static inline void set_shrinker_bit(struct mem_cgroup *memcg,
> > +                                 int nid, int shrinker_id)
> >  {
> >  }
> >  #endif
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9237976abe72..05190d7f32ae 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2823,8 +2823,8 @@ void deferred_split_huge_page(struct page *page)
> >               ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
> >               if (memcg)
> > -                     memcg_set_shrinker_bit(memcg, page_to_nid(page),
> > -                                            deferred_split_shrinker.id);
> > +                     set_shrinker_bit(memcg, page_to_nid(page),
> > +                                      deferred_split_shrinker.id);
> >  #endif
> >       }
> >       spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index fe230081690b..628030fa5f69 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -125,8 +125,8 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
> >               list_add_tail(item, &l->list);
> >               /* Set shrinker bit if the first element was added */
> >               if (!l->nr_items++)
> > -                     memcg_set_shrinker_bit(memcg, nid,
> > -                                            lru_shrinker_id(lru));
> > +                     set_shrinker_bit(memcg, nid,
> > +                                      lru_shrinker_id(lru));
> >               nlru->nr_items++;
> >               spin_unlock(&nlru->lock);
> >               return true;
> > @@ -548,7 +548,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> >
> >       if (src->nr_items) {
> >               dst->nr_items += src->nr_items;
> > -             memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> > +             set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> >               src->nr_items = 0;
> >       }
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e2de77b5bcc2..f5c9a0d2160b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -397,130 +397,6 @@ DEFINE_STATIC_KEY_FALSE(memcg_kmem_enabled_key);
> >  EXPORT_SYMBOL(memcg_kmem_enabled_key);
> >  #endif
> >
> > -static int memcg_shrinker_map_size;
> > -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
> > -
> > -static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
> > -{
> > -     kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > -}
> > -
> > -static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> > -                                      int size, int old_size)
> > -{
> > -     struct memcg_shrinker_map *new, *old;
> > -     int nid;
> > -
> > -     lockdep_assert_held(&memcg_shrinker_map_mutex);
> > -
> > -     for_each_node(nid) {
> > -             old = rcu_dereference_protected(
> > -                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> > -             /* Not yet online memcg */
> > -             if (!old)
> > -                     return 0;
> > -
> > -             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> > -             if (!new)
> > -                     return -ENOMEM;
> > -
> > -             /* Set all old bits, clear all new bits */
> > -             memset(new->map, (int)0xff, old_size);
> > -             memset((void *)new->map + old_size, 0, size - old_size);
> > -
> > -             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > -             call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
> > -{
> > -     struct mem_cgroup_per_node *pn;
> > -     struct memcg_shrinker_map *map;
> > -     int nid;
> > -
> > -     if (mem_cgroup_is_root(memcg))
> > -             return;
> > -
> > -     for_each_node(nid) {
> > -             pn = mem_cgroup_nodeinfo(memcg, nid);
> > -             map = rcu_dereference_protected(pn->shrinker_map, true);
> > -             if (map)
> > -                     kvfree(map);
> > -             rcu_assign_pointer(pn->shrinker_map, NULL);
> > -     }
> > -}
> > -
> > -static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> > -{
> > -     struct memcg_shrinker_map *map;
> > -     int nid, size, ret = 0;
> > -
> > -     if (mem_cgroup_is_root(memcg))
> > -             return 0;
> > -
> > -     mutex_lock(&memcg_shrinker_map_mutex);
> > -     size = memcg_shrinker_map_size;
> > -     for_each_node(nid) {
> > -             map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> > -             if (!map) {
> > -                     memcg_free_shrinker_maps(memcg);
> > -                     ret = -ENOMEM;
> > -                     break;
> > -             }
> > -             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> > -     }
> > -     mutex_unlock(&memcg_shrinker_map_mutex);
> > -
> > -     return ret;
> > -}
> > -
> > -int memcg_expand_shrinker_maps(int new_id)
> > -{
> > -     int size, old_size, ret = 0;
> > -     struct mem_cgroup *memcg;
> > -
> > -     size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> > -     old_size = memcg_shrinker_map_size;
> > -     if (size <= old_size)
> > -             return 0;
> > -
> > -     mutex_lock(&memcg_shrinker_map_mutex);
> > -     if (!root_mem_cgroup)
> > -             goto unlock;
> > -
> > -     for_each_mem_cgroup(memcg) {
> > -             if (mem_cgroup_is_root(memcg))
> > -                     continue;
> > -             ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> > -             if (ret) {
> > -                     mem_cgroup_iter_break(NULL, memcg);
> > -                     goto unlock;
> > -             }
> > -     }
> > -unlock:
> > -     if (!ret)
> > -             memcg_shrinker_map_size = size;
> > -     mutex_unlock(&memcg_shrinker_map_mutex);
> > -     return ret;
> > -}
> > -
> > -void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> > -{
> > -     if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
> > -             struct memcg_shrinker_map *map;
> > -
> > -             rcu_read_lock();
> > -             map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> > -             /* Pairs with smp mb in shrink_slab() */
> > -             smp_mb__before_atomic();
> > -             set_bit(shrinker_id, map->map);
> > -             rcu_read_unlock();
> > -     }
> > -}
> > -
> >  /**
> >   * mem_cgroup_css_from_page - css of the memcg associated with a page
> >   * @page: page of interest
> > @@ -5370,11 +5246,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
> >       struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> >
> >       /*
> > -      * A memcg must be visible for memcg_expand_shrinker_maps()
> > +      * A memcg must be visible for expand_shrinker_maps()
> >        * by the time the maps are allocated. So, we allocate maps
> >        * here, when for_each_mem_cgroup() can't skip it.
> >        */
> > -     if (memcg_alloc_shrinker_maps(memcg)) {
> > +     if (alloc_shrinker_maps(memcg)) {
> >               mem_cgroup_id_remove(memcg);
> >               return -ENOMEM;
> >       }
> > @@ -5438,7 +5314,7 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
> >       vmpressure_cleanup(&memcg->vmpressure);
> >       cancel_work_sync(&memcg->high_work);
> >       mem_cgroup_remove_from_trees(memcg);
> > -     memcg_free_shrinker_maps(memcg);
> > +     free_shrinker_maps(memcg);
> >       memcg_free_kmem(memcg);
> >       mem_cgroup_free(memcg);
> >  }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index b512dd5e3a1c..d950cead66ca 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -185,6 +185,132 @@ static LIST_HEAD(shrinker_list);
> >  static DECLARE_RWSEM(shrinker_rwsem);
> >
> >  #ifdef CONFIG_MEMCG
> > +
> > +static int memcg_shrinker_map_size;
> > +static DEFINE_MUTEX(memcg_shrinker_map_mutex);
> > +
> > +static void free_shrinker_map_rcu(struct rcu_head *head)
> > +{
> > +     kvfree(container_of(head, struct memcg_shrinker_map, rcu));
> > +}
> > +
> > +static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> > +                                int size, int old_size)
> > +{
> > +     struct memcg_shrinker_map *new, *old;
> > +     int nid;
> > +
> > +     lockdep_assert_held(&memcg_shrinker_map_mutex);
> > +
> > +     for_each_node(nid) {
> > +             old = rcu_dereference_protected(
> > +                     mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> > +             /* Not yet online memcg */
> > +             if (!old)
> > +                     return 0;
> > +
> > +             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> > +             if (!new)
> > +                     return -ENOMEM;
> > +
> > +             /* Set all old bits, clear all new bits */
> > +             memset(new->map, (int)0xff, old_size);
> > +             memset((void *)new->map + old_size, 0, size - old_size);
> > +
> > +             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> > +             call_rcu(&old->rcu, free_shrinker_map_rcu);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void free_shrinker_maps(struct mem_cgroup *memcg)
> > +{
> > +     struct mem_cgroup_per_node *pn;
> > +     struct memcg_shrinker_map *map;
> > +     int nid;
> > +
> > +     if (mem_cgroup_is_root(memcg))
> > +             return;
> > +
> > +     for_each_node(nid) {
> > +             pn = mem_cgroup_nodeinfo(memcg, nid);
> > +             map = rcu_dereference_protected(pn->shrinker_map, true);
> > +             if (map)
> > +                     kvfree(map);
>
> We should to forget about below patch and kill "if (map)" check here:
>
> https://lore.kernel.org/linux-mm/1611216029-34397-1-git-send-email-abaci-bugfix@linux.alibaba.com/

Aha, thanks for reminding me. I didn't notice that patch. It seems it
has been in the -mm tree. Will rebase on top of that patch.

>
> > +             rcu_assign_pointer(pn->shrinker_map, NULL);
> > +     }
> > +}
> > +
> > +int alloc_shrinker_maps(struct mem_cgroup *memcg)
> > +{
> > +     struct memcg_shrinker_map *map;
> > +     int nid, size, ret = 0;
> > +
> > +     if (mem_cgroup_is_root(memcg))
> > +             return 0;
> > +
> > +     mutex_lock(&memcg_shrinker_map_mutex);
> > +     size = memcg_shrinker_map_size;
> > +     for_each_node(nid) {
> > +             map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> > +             if (!map) {
> > +                     free_shrinker_maps(memcg);
> > +                     ret = -ENOMEM;
> > +                     break;
> > +             }
> > +             rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> > +     }
> > +     mutex_unlock(&memcg_shrinker_map_mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static int expand_shrinker_maps(int new_id)
> > +{
> > +     int size, old_size, ret = 0;
> > +     struct mem_cgroup *memcg;
> > +
> > +     size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
> > +     old_size = memcg_shrinker_map_size;
> > +     if (size <= old_size)
> > +             return 0;
> > +
> > +     mutex_lock(&memcg_shrinker_map_mutex);
> > +     if (!root_mem_cgroup)
> > +             goto unlock;
> > +
> > +     memcg = mem_cgroup_iter(NULL, NULL, NULL);
> > +     do {
> > +             if (mem_cgroup_is_root(memcg))
> > +                     continue;
> > +             ret = expand_one_shrinker_map(memcg, size, old_size);
> > +             if (ret) {
> > +                     mem_cgroup_iter_break(NULL, memcg);
> > +                     goto unlock;
> > +             }
> > +     } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> > +unlock:
> > +     if (!ret)
> > +             memcg_shrinker_map_size = size;
> > +     mutex_unlock(&memcg_shrinker_map_mutex);
> > +     return ret;
> > +}
> > +
> > +void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> > +{
> > +     if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
> > +             struct memcg_shrinker_map *map;
> > +
> > +             rcu_read_lock();
> > +             map = rcu_dereference(memcg->nodeinfo[nid]->shrinker_map);
> > +             /* Pairs with smp mb in shrink_slab() */
> > +             smp_mb__before_atomic();
> > +             set_bit(shrinker_id, map->map);
> > +             rcu_read_unlock();
> > +     }
> > +}
> > +
> >  /*
> >   * We allow subsystems to populate their shrinker-related
> >   * LRU lists before register_shrinker_prepared() is called
> > @@ -212,7 +338,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >               goto unlock;
> >
> >       if (id >= shrinker_nr_max) {
> > -             if (memcg_expand_shrinker_maps(id)) {
> > +             if (expand_shrinker_maps(id)) {
> >                       idr_remove(&shrinker_idr, id);
> >                       goto unlock;
> >               }
> > @@ -601,7 +727,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >                       if (ret == SHRINK_EMPTY)
> >                               ret = 0;
> >                       else
> > -                             memcg_set_shrinker_bit(memcg, nid, i);
> > +                             set_shrinker_bit(memcg, nid, i);
> >               }
> >               freed += ret;
> >
> >
>
>
