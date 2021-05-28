Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED8393E67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhE1IGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhE1IGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 04:06:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF115C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 01:04:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f22so2682315pfn.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 May 2021 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhQPjLykR01Qp+NSeFFJI6fs6yER95zPQTTz3vzX0YM=;
        b=olovBvIActNmkePfVD5Pug5meGIIltnoam/DS0feX69PrH5AWeqb/+XlZ1XTzUaESW
         ZcTXp0PKgC71S5Rp1U8usKjBcZdSfrRdFFeNZ0dWNZsaMFmYJycBNUmWyeCv3cCuP2IR
         Ibx6sRQElSaZkYu0Y3JuU0j7Ou+928szLcOwGMobKVEEqq762kkW95+nX8+7hb4zotV/
         obpKtG1JfIq3N3ZNFOO0+ZGUm3GIIb8BtC1tLsav+PcMHC1gqwUivohdBa/j9zqxQouL
         dAoLqxJem+D6o2Py5pPf2IvpM7Pv9MR1xIUhY8RFGmRsWEWaBEW7VaqgKe1dOeAzfcZE
         kN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhQPjLykR01Qp+NSeFFJI6fs6yER95zPQTTz3vzX0YM=;
        b=CXX6djngcHfZBHpynCqCKDqTZTImshBkFpswI4LJ2j8dOQATrPg3lRFxZeIQuau/x/
         f+hDyfp/L2JiZ0ESOtIBgRKSVYbkxslYnm6ni+xJ+qFgZZyZmiVmz0kThfhKtR1K65nn
         9j0lO1cQad//Jl3HuQD9/67gX7TNADcIjAsaoyPClSv9HEmjfxG70ermIG4dItuiPafU
         zckmCotcbpAiJWMP7afoLzE6q1q9pQgSI7u3wQ4QGD9AEZSNwUX+pCVrKgUAOaB/duEc
         HCgQbHgfcsmExYWED1up/5SHqw7UdrIa7aYcDEeUxU9JbTZ1TjVsA3VabaGzmuGG46pl
         E22g==
X-Gm-Message-State: AOAM533Ag3hJNtobX7e0Nmfp6tczOCuZPnPA7BdwcmGeAvoNeJm+MNp6
        RxvUih9pgQw9Zu50YvtO3RPPiQ8uh9xlm8M684wfFQ==
X-Google-Smtp-Source: ABdhPJzIQiwrZqUIU/7odmrvbjoVqWScYQNEHtklusDGA07cMOOcTJxGQSELDjMuvbe6w5bzfvVdGVzjsS64c1m7uyw=
X-Received: by 2002:a62:7b07:0:b029:2e3:b540:707f with SMTP id
 w7-20020a627b070000b02902e3b540707fmr2602202pfc.59.1622189084220; Fri, 28 May
 2021 01:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210527062148.9361-1-songmuchun@bytedance.com>
 <20210527062148.9361-18-songmuchun@bytedance.com> <YK+LhWvabd+KQWOJ@casper.infradead.org>
 <CAMZfGtWUNBaGmSq-WKXc+DJTbTiSi96SzmGVZsnc-SQ=UiL=QQ@mail.gmail.com>
In-Reply-To: <CAMZfGtWUNBaGmSq-WKXc+DJTbTiSi96SzmGVZsnc-SQ=UiL=QQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 28 May 2021 16:04:07 +0800
Message-ID: <CAMZfGtXeDC+dy4gnoB3e=CqpTRNB8MHQF+b+r2TsbMt8924T6g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 17/21] mm: list_lru: replace linear
 array with xarray
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 28, 2021 at 11:43 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, May 27, 2021 at 8:08 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, May 27, 2021 at 02:21:44PM +0800, Muchun Song wrote:
> > > If we run 10k containers in the system, the size of the
> > > list_lru_memcg->lrus can be ~96KB per list_lru. When we decrease the
> > > number containers, the size of the array will not be shrinked. It is
> > > not scalable. The xarray is a good choice for this case. We can save
> > > a lot of memory when there are tens of thousands continers in the
> > > system. If we use xarray, we also can remove the logic code of
> > > resizing array, which can simplify the code.
> >
> > I am all for this, in concept.  Some thoughts below ...
> >
> > > @@ -56,10 +51,8 @@ struct list_lru {
> > >  #ifdef CONFIG_MEMCG_KMEM
> > >       struct list_head        list;
> > >       int                     shrinker_id;
> > > -     /* protects ->memcg_lrus->lrus[i] */
> > > -     spinlock_t              lock;
> > >       /* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
> > > -     struct list_lru_memcg   __rcu *memcg_lrus;
> > > +     struct xarray           *xa;
> > >  #endif
> >
> > Normally, we embed an xarray in its containing structure instead of
> > allocating it.  It's only a pointer, int and spinlock, so generally
> > 16 bytes, as opposed to the 8 bytes for the pointer and a 16 byte
> > allocation.  There is a minor wrinkle in that currently 'NULL' is
> > used to indicate "is not cgroup aware".  Maybe there's another way
> > to indicate that?
>
> Sure. I can drop patch 8 in this series. In that case, we can use
> ->memcg_aware to indicate that.
>
>
> >
> > > @@ -51,22 +51,12 @@ static int lru_shrinker_id(struct list_lru *lru)
> > >  static inline struct list_lru_one *
> > >  list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
> > >  {
> > > -     struct list_lru_memcg *memcg_lrus;
> > > -     struct list_lru_node *nlru = &lru->node[nid];
> > > +     if (list_lru_memcg_aware(lru) && idx >= 0) {
> > > +             struct list_lru_per_memcg *mlru = xa_load(lru->xa, idx);
> > >
> > > -     /*
> > > -      * Either lock or RCU protects the array of per cgroup lists
> > > -      * from relocation (see memcg_update_list_lru).
> > > -      */
> > > -     memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
> > > -                                        lockdep_is_held(&nlru->lock));
> > > -     if (memcg_lrus && idx >= 0) {
> > > -             struct list_lru_per_memcg *mlru;
> > > -
> > > -             mlru = rcu_dereference_check(memcg_lrus->lrus[idx], true);
> > >               return mlru ? &mlru->nodes[nid] : NULL;
> > >       }
> > > -     return &nlru->lru;
> > > +     return &lru->node[nid].lru;
> > >  }
> >
> > ... perhaps we move the xarray out from under the #ifdef and use index 0
> > for non-memcg-aware lrus?  The XArray is specially optimised for arrays
> > which only have one entry at 0.
>
> Sounds like a good idea. I can do a try.

I have thought more about this. If we do this, we need to allocate a
list_lru_per_memcg structure for the root memcg. Since the structure
of list_lru_node already aligns with cache line size. From this point
of view, this just wastes memory. We do not gain anything. Right?

Another approach is introducing a new structure of list_lru_nodes,
which is described as following.

struct list_lru_nodes {
         struct list_lru_node nodes[0];
};

Then we insert struct list_lru_nodes to the XArray (index == 0).
There will be two different types in the XArray. If index == 0,
the xa_load() returns list_lru_nodes pointer, otherwise, it returns
list_lru_per_memcg pointer. So list_lru_from_memcg_idx() still
need to handle different cases.

It looks like both approaches do not have any obvious
advantages.

What do you think about this, Mattew?

>
> >
> > >  int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t gfp)
> > >  {
> > > +     XA_STATE(xas, lru->xa, 0);
> > >       unsigned long flags;
> > > -     struct list_lru_memcg *memcg_lrus;
> > > -     int i;
> > > +     int i, ret = 0;
> > >
> > >       struct list_lru_memcg_table {
> > >               struct list_lru_per_memcg *mlru;
> > > @@ -601,22 +522,45 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
> > >               }
> > >       }
> > >
> > > -     spin_lock_irqsave(&lru->lock, flags);
> > > -     memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
> > > +     xas_lock_irqsave(&xas, flags);
> > >       while (i--) {
> > >               int index = memcg_cache_id(table[i].memcg);
> > >               struct list_lru_per_memcg *mlru = table[i].mlru;
> > >
> > > -             if (index < 0 || rcu_dereference_protected(memcg_lrus->lrus[index], true))
> > > +             xas_set(&xas, index);
> > > +retry:
> > > +             if (unlikely(index < 0 || ret || xas_load(&xas))) {
> > >                       kfree(mlru);
> > > -             else
> > > -                     rcu_assign_pointer(memcg_lrus->lrus[index], mlru);
> > > +             } else {
> > > +                     ret = xa_err(xas_store(&xas, mlru));
> >
> > This is mixing advanced and normal XArray concepts ... sorry to have
> > confused you.  I think what you meant to do here was:
> >
> >                         xas_store(&xas, mlru);
> >                         ret = xas_error(&xas);
>
> Sure. Thanks for pointing it out. It's my bad usage.
>
> >
> > Or you can avoid introducing 'ret' at all, and keep your errors in the
> > xa_state.  You're kind of mirroring the xa_state errors into 'ret'
> > anyway, so that seems easier to understand?
>
> Make sense. I will do this in the next version. Thanks for your
> all suggestions.
>
> >
> > > -     memcg_id = memcg_alloc_cache_id();
> > > +     memcg_id = ida_simple_get(&memcg_cache_ida, 0, MEMCG_CACHES_MAX_SIZE,
> > > +                               GFP_KERNEL);
> >
> >         memcg_id = ida_alloc_max(&memcg_cache_ida,
> >                         MEMCG_CACHES_MAX_SIZE - 1, GFP_KERNEL);
> >
> > ... although i think there's actually a fencepost error, and this really
> > should be MEMCG_CACHES_MAX_SIZE.
>
> Totally agree. I have fixed this issue in patch 19.
>
> >
> > >       objcg = obj_cgroup_alloc();
> > >       if (!objcg) {
> > > -             memcg_free_cache_id(memcg_id);
> > > +             ida_simple_remove(&memcg_cache_ida, memcg_id);
> >
> >                 ida_free(&memcg_cache_ida, memcg_id);
>
> I Will update to this new API.
>
> >
