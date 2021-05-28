Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFAB393C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 05:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhE1Dpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 23:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhE1Dpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 23:45:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41C7C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 20:44:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1729773pjb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 20:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh+EYCLoUcN5j6D/Y+n/b8ai24Cn5mqFXxFcteegjFo=;
        b=vozsVGeqo0Ckn0+Y2O/TK9Dbw7JR8a9ngc9iFrch/sN3pXDdiz1RJXvthFLjcFcuQi
         zBas4i1V6UykahH0BLxKklVImiDhHYXKsfSFOTNVYQmzhXbBYtKHBnvMHb/Fjw5QAXWu
         zH+nhDvQ1EE3mJlbDtCL+Q+Um2Pb3HKG6XKNKgGbBk3TtZnAVjCsJZUjx0RQmmCC0yB2
         gOrpVaL4wBbOpQ1kt03atdfWrbQa2ebWu2gEQfzxhgxZpdhqJGrUbCQX1AqTMQHVwU+Z
         OF4Jwrk94JM5/+5AzDpuAS8OR39XhxeAFBFbayLMucDFunIhBkTkm6ZkRcMsZxbpPs7g
         BdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh+EYCLoUcN5j6D/Y+n/b8ai24Cn5mqFXxFcteegjFo=;
        b=sMicm3OOV7gK/XuHA/xu/V4Rs7OMFCb49PrYai4W/H80gnVrMtVlfpfdwGperiBqt7
         0OWVykZeHPq2l5c0Y42oL31PRjcnxWb30cQOXQZndG42FjcyDlShoPx8Q2W9jH+9kHIu
         9lAxh2oBOEeNAC4N+ZWIsd0N1VtQJG1vZMxthGVeVsJv4KS+KoKd4SpSbwQOa5m/npdX
         6CBqbdAWZNjmAtcqR2Tl4qEoCz9ZWnlbOpHLZMxEXPxzHW/LWJya0dyPFfkVxoxZOyHL
         kM6Fp01bB8hXcE2eUJq8sMWbzmix5FddCa/jzS3z1R1KlU8fEWllr97DHK2gz7qWjqrU
         NcdQ==
X-Gm-Message-State: AOAM5303SVFUpY/HEbGO8sJQpcO93CutPgc3n/xHMukg580HEDnHBEW0
        pfKpB0H7jb/FOE7nzn/9kMZ3RZX40kC/xyGfv+6wOA==
X-Google-Smtp-Source: ABdhPJxVg/yaMOcm8kfjg+lyfSkRngQO04M367IWDQJgFRhkfJgKJsl/ryGstDi7um2yVreMtfAldziCbcHmzYltWGM=
X-Received: by 2002:a17:902:d2c8:b029:fe:cd9a:a6bb with SMTP id
 n8-20020a170902d2c8b02900fecd9aa6bbmr5516453plc.34.1622173448368; Thu, 27 May
 2021 20:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210527062148.9361-1-songmuchun@bytedance.com>
 <20210527062148.9361-18-songmuchun@bytedance.com> <YK+LhWvabd+KQWOJ@casper.infradead.org>
In-Reply-To: <YK+LhWvabd+KQWOJ@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 28 May 2021 11:43:29 +0800
Message-ID: <CAMZfGtWUNBaGmSq-WKXc+DJTbTiSi96SzmGVZsnc-SQ=UiL=QQ@mail.gmail.com>
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

On Thu, May 27, 2021 at 8:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 27, 2021 at 02:21:44PM +0800, Muchun Song wrote:
> > If we run 10k containers in the system, the size of the
> > list_lru_memcg->lrus can be ~96KB per list_lru. When we decrease the
> > number containers, the size of the array will not be shrinked. It is
> > not scalable. The xarray is a good choice for this case. We can save
> > a lot of memory when there are tens of thousands continers in the
> > system. If we use xarray, we also can remove the logic code of
> > resizing array, which can simplify the code.
>
> I am all for this, in concept.  Some thoughts below ...
>
> > @@ -56,10 +51,8 @@ struct list_lru {
> >  #ifdef CONFIG_MEMCG_KMEM
> >       struct list_head        list;
> >       int                     shrinker_id;
> > -     /* protects ->memcg_lrus->lrus[i] */
> > -     spinlock_t              lock;
> >       /* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
> > -     struct list_lru_memcg   __rcu *memcg_lrus;
> > +     struct xarray           *xa;
> >  #endif
>
> Normally, we embed an xarray in its containing structure instead of
> allocating it.  It's only a pointer, int and spinlock, so generally
> 16 bytes, as opposed to the 8 bytes for the pointer and a 16 byte
> allocation.  There is a minor wrinkle in that currently 'NULL' is
> used to indicate "is not cgroup aware".  Maybe there's another way
> to indicate that?

Sure. I can drop patch 8 in this series. In that case, we can use
->memcg_aware to indicate that.


>
> > @@ -51,22 +51,12 @@ static int lru_shrinker_id(struct list_lru *lru)
> >  static inline struct list_lru_one *
> >  list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
> >  {
> > -     struct list_lru_memcg *memcg_lrus;
> > -     struct list_lru_node *nlru = &lru->node[nid];
> > +     if (list_lru_memcg_aware(lru) && idx >= 0) {
> > +             struct list_lru_per_memcg *mlru = xa_load(lru->xa, idx);
> >
> > -     /*
> > -      * Either lock or RCU protects the array of per cgroup lists
> > -      * from relocation (see memcg_update_list_lru).
> > -      */
> > -     memcg_lrus = rcu_dereference_check(lru->memcg_lrus,
> > -                                        lockdep_is_held(&nlru->lock));
> > -     if (memcg_lrus && idx >= 0) {
> > -             struct list_lru_per_memcg *mlru;
> > -
> > -             mlru = rcu_dereference_check(memcg_lrus->lrus[idx], true);
> >               return mlru ? &mlru->nodes[nid] : NULL;
> >       }
> > -     return &nlru->lru;
> > +     return &lru->node[nid].lru;
> >  }
>
> ... perhaps we move the xarray out from under the #ifdef and use index 0
> for non-memcg-aware lrus?  The XArray is specially optimised for arrays
> which only have one entry at 0.

Sounds like a good idea. I can do a try.

>
> >  int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t gfp)
> >  {
> > +     XA_STATE(xas, lru->xa, 0);
> >       unsigned long flags;
> > -     struct list_lru_memcg *memcg_lrus;
> > -     int i;
> > +     int i, ret = 0;
> >
> >       struct list_lru_memcg_table {
> >               struct list_lru_per_memcg *mlru;
> > @@ -601,22 +522,45 @@ int list_lru_memcg_alloc(struct list_lru *lru, struct mem_cgroup *memcg, gfp_t g
> >               }
> >       }
> >
> > -     spin_lock_irqsave(&lru->lock, flags);
> > -     memcg_lrus = rcu_dereference_protected(lru->memcg_lrus, true);
> > +     xas_lock_irqsave(&xas, flags);
> >       while (i--) {
> >               int index = memcg_cache_id(table[i].memcg);
> >               struct list_lru_per_memcg *mlru = table[i].mlru;
> >
> > -             if (index < 0 || rcu_dereference_protected(memcg_lrus->lrus[index], true))
> > +             xas_set(&xas, index);
> > +retry:
> > +             if (unlikely(index < 0 || ret || xas_load(&xas))) {
> >                       kfree(mlru);
> > -             else
> > -                     rcu_assign_pointer(memcg_lrus->lrus[index], mlru);
> > +             } else {
> > +                     ret = xa_err(xas_store(&xas, mlru));
>
> This is mixing advanced and normal XArray concepts ... sorry to have
> confused you.  I think what you meant to do here was:
>
>                         xas_store(&xas, mlru);
>                         ret = xas_error(&xas);

Sure. Thanks for pointing it out. It's my bad usage.

>
> Or you can avoid introducing 'ret' at all, and keep your errors in the
> xa_state.  You're kind of mirroring the xa_state errors into 'ret'
> anyway, so that seems easier to understand?

Make sense. I will do this in the next version. Thanks for your
all suggestions.

>
> > -     memcg_id = memcg_alloc_cache_id();
> > +     memcg_id = ida_simple_get(&memcg_cache_ida, 0, MEMCG_CACHES_MAX_SIZE,
> > +                               GFP_KERNEL);
>
>         memcg_id = ida_alloc_max(&memcg_cache_ida,
>                         MEMCG_CACHES_MAX_SIZE - 1, GFP_KERNEL);
>
> ... although i think there's actually a fencepost error, and this really
> should be MEMCG_CACHES_MAX_SIZE.

Totally agree. I have fixed this issue in patch 19.

>
> >       objcg = obj_cgroup_alloc();
> >       if (!objcg) {
> > -             memcg_free_cache_id(memcg_id);
> > +             ida_simple_remove(&memcg_cache_ida, memcg_id);
>
>                 ida_free(&memcg_cache_ida, memcg_id);

I Will update to this new API.

>
