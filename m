Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D132F1E30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390214AbhAKSoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390054AbhAKSoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:44:14 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC5C061786;
        Mon, 11 Jan 2021 10:43:34 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v26so768150eds.13;
        Mon, 11 Jan 2021 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdavPfho2y2aZPaSzJ50dkLev1j8QD0jxgYpMcuQTxo=;
        b=qD8xUYRdDKGqeMdTnSxWls6Jl/yNJ5ruqkG/XcNRXfZX+T4BdbjtK0o5I9jmPVn/ce
         B1vYupIurWRK8Ripfkjh9RZ3Xb+Y6nLJMbpPocyjLxcCoWr9RJcKG6VYZWdFfCGLor2/
         0hEnjDBxzrMNKyuFAYJuEVMRWlb+Ot34fRTIPGe9LImLoG/eAQCRnR+Hl6v/obd5kViB
         JQrkMo6EakYHJpOicqguAI2E+5c7K3LmuXBokuV+5xx1jgHTju64Osy+M4MQkwplx0hV
         rgPn9LiebSR79SiwTfP+jipp+5QZPjxm9Hkupu8D7UQENDXA2aresoMBMIRN0yHdDLfc
         RWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdavPfho2y2aZPaSzJ50dkLev1j8QD0jxgYpMcuQTxo=;
        b=Jl0r/RPloKCe0JDMasy+Tcz8PPf8HZA0NAOzNnIrWAKIx8d7NEj3HYvigf7+Edm7C6
         XCkuhHKljAr8EhOJAh0/LV+6sW7JbYYJDaApSOugym1exudo/oNTKAdYJhtZt4NXrKa4
         r6Mm9+j27jrhMn+8ySPD+Slns0m+/2vHuQyszI1VUhNn+prfDPyvNJK3A5cs7+EEEn+a
         KoTUoGCKVkvRpMlQrhgrw2PcNS4eKXDFT/MIBqtdnJkhjcVCP4M2kz8LExHYL/kO9yEq
         5Yq67Mfcn8rW8XqJxQbfwIlQyRvcvMtII2wjtlQhRUhieRniShCfDzfON4zSoCUlfr7T
         6hTA==
X-Gm-Message-State: AOAM533+XfG2Hr52mBcJ1gcVQP1oq+lEoLuhjWHkVdBS5rH0/33slDY5
        RAz1U3LEzR3NFlldMvUS3/8UOEgRlGcry9NOg64=
X-Google-Smtp-Source: ABdhPJzTsIe/iQOwZjvQaOYH8kv6w6GD4dQu8EwThJ5A/fDtjZbMK6SYYVlOsmOQY3B4Iojo1tH7nyJeXbt5Y+fbTHs=
X-Received: by 2002:a50:d552:: with SMTP id f18mr553663edj.168.1610390612990;
 Mon, 11 Jan 2021 10:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-11-shy828301@gmail.com>
 <777d47b3-65f7-5727-2d21-dbef93e7d1ed@virtuozzo.com>
In-Reply-To: <777d47b3-65f7-5727-2d21-dbef93e7d1ed@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 10:43:20 -0800
Message-ID: <CAHbLzkp+DKXLgAPtkPXZsSgS2QVtyFcPFBuC7oJXXH+f73j+kw@mail.gmail.com>
Subject: Re: [v3 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg offline
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

On Wed, Jan 6, 2021 at 3:35 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.01.2021 01:58, Yang Shi wrote:
> > Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> > corresponding nr_deferred when memcg offline.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/memcontrol.h |  1 +
> >  mm/memcontrol.c            |  1 +
> >  mm/vmscan.c                | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 5599082df623..d1e52e916cc2 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1586,6 +1586,7 @@ extern int memcg_alloc_shrinker_info(struct mem_cgroup *memcg);
> >  extern void memcg_free_shrinker_info(struct mem_cgroup *memcg);
> >  extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> >                                  int nid, int shrinker_id);
> > +extern void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg);
> >  #else
> >  #define mem_cgroup_sockets_enabled 0
> >  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 126f1fd550c8..19e555675582 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5284,6 +5284,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
> >       page_counter_set_low(&memcg->memory, 0);
> >
> >       memcg_offline_kmem(memcg);
> > +     memcg_reparent_shrinker_deferred(memcg);
> >       wb_memcg_offline(memcg);
> >
> >       drain_all_stock(memcg);
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d9795fb0f1c5..71056057d26d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -396,6 +396,35 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> >       return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> >  }
> >
> > +void memcg_reparent_shrinker_deferred(struct mem_cgroup *memcg)
> > +{
> > +     int i, nid;
> > +     long nr;
> > +     struct mem_cgroup *parent;
> > +     struct memcg_shrinker_info *child_info, *parent_info;
> > +
> > +     parent = parent_mem_cgroup(memcg);
> > +     if (!parent)
> > +             parent = root_mem_cgroup;
> > +
> > +     /* Prevent from concurrent shrinker_info expand */
> > +     down_read(&shrinker_rwsem);
> > +     for_each_node(nid) {
> > +             child_info = rcu_dereference_protected(
> > +                                     memcg->nodeinfo[nid]->shrinker_info,
> > +                                     true);
> > +             parent_info = rcu_dereference_protected(
> > +                                     parent->nodeinfo[nid]->shrinker_info,
> > +                                     true);
>
> Simple assignment can't take such lots of space, we have to do something with that.
>
> Number of these
>
>         rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info, true)
>
> became too big, and we can't allow every of them takes 3 lines.
>
> We should introduce a short helper to dereferrence this, so we will be able to give
> out attention to really difficult logic instead of wasting it on parsing this.
>
>                 child_info = memcg_shrinker_info(memcg, nid);
> or
>                 child_info = memcg_shrinker_info_protected(memcg, nid);
>
> Both of them fit in single line.
>
> struct memcg_shrinker_info *memcg_shrinker_info_protected(
>                                         struct mem_cgroup *memcg, int nid)
> {
>         return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
>                                          lockdep_assert_held(&shrinker_rwsem));
> }

Thanks for the suggestion, it makes sense to me. Will incorporate it in v4.

>
>
> > +             for (i = 0; i < shrinker_nr_max; i++) {
> > +                     nr = atomic_long_read(&child_info->nr_deferred[i]);
> > +                     atomic_long_add(nr,
> > +                                     &parent_info->nr_deferred[i]);
>
> Why new line is here? In case of you merge it up, it will be even shorter then previous line.

Just keep in 80 lines. We could relax it.

>
> > +             }
> > +     }
> > +     up_read(&shrinker_rwsem);
> > +}
> > +
> >  static bool cgroup_reclaim(struct scan_control *sc)
> >  {
> >       return sc->target_mem_cgroup;
> >
>
>
