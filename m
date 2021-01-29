Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EABC308BC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 18:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhA2RmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 12:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhA2Riy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:38:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E90C061574;
        Fri, 29 Jan 2021 09:38:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id n6so11438856edt.10;
        Fri, 29 Jan 2021 09:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnJUFKT7mpJJkpoBZtT7iuNHzt9Orb+KaxsIyTb16E0=;
        b=COLNvH5yFRc1iWLXYNI9oTIMBzlO2VZPd5qpEtrEHo3ATyUwzRkkJJpBybh7Sz+E7U
         KvaZ9Bxx2aaqlmREglpeNGMhk56HaIXO0h+lDWOxIaJZ+ZTGyU2lVMXVkGt/rllLdPpF
         B4uGOZbB57eHeRUTts2Dtf9oq72yibbhAsgUzQAD2FNZioeMUtQZoSOPk3hlhlpKE3BB
         DoP8GVKEZp8ANV7wNZzt7gBfCS236/IPAc6fIBZ3A68VtKn92HJ9+ckCmbBH8jrVgKkw
         J/7fnDwyuruh8q8W9YgQljs3+wtLFQAiY72nmWSD/mYM1/TLTzCL8XphSe8jnRCsH8ZX
         FSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnJUFKT7mpJJkpoBZtT7iuNHzt9Orb+KaxsIyTb16E0=;
        b=EgdY/wOWgN9CkaDFpzxQmjFUg3Fv671HzdLl9lAndyFNQxDQCXmAsS1sO1jI5cXmQM
         CFZgKwXsKzNhMNXCdFItg195ZcnAuarunFBMJf/kChbZ3w6jflK61oRxVLxvXtzY7wlp
         0sTgdRR5gZeIyYtpmpJdrbyTuRRHZbwwv5MYhdR85XuOjfV78lNtJQFjmpyd11em8O9g
         hQ1+1pL05NBBzRZHFvnk8jzjtKH6JBsdGxgkMRpr3q+c8hW5R9/hyHJHrKWg+YEJT2mH
         pDU/Bohgk4jYU7Yiu0tKhexyeSVKb15J/Zkdq3wxjoqyB+gwmdPtnfDgX4IfoV1Z8WEI
         yBHQ==
X-Gm-Message-State: AOAM531CAnfb+lP4dab6bYwCcsRG0gJ0SvL/jO275ZZLMkzGkNHNtS/a
        +d1tRbil3EbP7th5D/4MMB1YBu0/viz4ZxCrGMs=
X-Google-Smtp-Source: ABdhPJxd629ibdjBhMM1erN6M0LiJ+fYgjJUKGph/ldUDOSSCcPf87XqaVqV8gqhPLw7e+VdSYNXLyCfr+VoUSdorV4=
X-Received: by 2002:a05:6402:312e:: with SMTP id dd14mr6486295edb.366.1611941892968;
 Fri, 29 Jan 2021 09:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-11-shy828301@gmail.com>
 <0eee1cbd-4149-9f03-615d-18c81b8a85af@suse.cz>
In-Reply-To: <0eee1cbd-4149-9f03-615d-18c81b8a85af@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 09:38:01 -0800
Message-ID: <CAHbLzkoE9DN7_5VCfy7yaVPKnrqW6ohCMxpvmKMC3-Tw5-pGgA@mail.gmail.com>
Subject: Re: [v5 PATCH 10/11] mm: memcontrol: reparent nr_deferred when memcg offline
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
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

On Fri, Jan 29, 2021 at 7:52 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 12:33 AM, Yang Shi wrote:
> > Now shrinker's nr_deferred is per memcg for memcg aware shrinkers, add to parent's
> > corresponding nr_deferred when memcg offline.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> A question somewhat outside of the scope of the series. Should we shrink before
> reparenting on memcg offline? Would it make more sense than assume the kmemcg
> objects that are still cached are used also by others?

TBH, I'm not sure. I think it depends on workload. For example, the
build server may prefer to keep the objects cached since the samce
objects may be reused by multiple build jobs.

>
> > ---
> >  include/linux/memcontrol.h |  1 +
> >  mm/memcontrol.c            |  1 +
> >  mm/vmscan.c                | 31 +++++++++++++++++++++++++++++++
> >  3 files changed, 33 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index e0384367e07d..fe1375f08881 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1586,6 +1586,7 @@ extern int alloc_shrinker_info(struct mem_cgroup *memcg);
> >  extern void free_shrinker_info(struct mem_cgroup *memcg);
> >  extern void set_shrinker_bit(struct mem_cgroup *memcg,
> >                            int nid, int shrinker_id);
> > +extern void reparent_shrinker_deferred(struct mem_cgroup *memcg);
> >  #else
> >  #define mem_cgroup_sockets_enabled 0
> >  static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f64ad0d044d9..21f36b73f36a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5282,6 +5282,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
> >       page_counter_set_low(&memcg->memory, 0);
> >
> >       memcg_offline_kmem(memcg);
> > +     reparent_shrinker_deferred(memcg);
> >       wb_memcg_offline(memcg);
> >
> >       drain_all_stock(memcg);
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 0373d7619d7b..55ad91a26ba3 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -386,6 +386,37 @@ static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
> >       return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
> >  }
> >
> > +static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> > +                                                  int nid)
> > +{
> > +     return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> > +                                      lockdep_is_held(&shrinker_rwsem));
> > +}
> > +
> > +void reparent_shrinker_deferred(struct mem_cgroup *memcg)
> > +{
> > +     int i, nid;
> > +     long nr;
> > +     struct mem_cgroup *parent;
> > +     struct shrinker_info *child_info, *parent_info;
> > +
> > +     parent = parent_mem_cgroup(memcg);
> > +     if (!parent)
> > +             parent = root_mem_cgroup;
> > +
> > +     /* Prevent from concurrent shrinker_info expand */
> > +     down_read(&shrinker_rwsem);
> > +     for_each_node(nid) {
> > +             child_info = shrinker_info_protected(memcg, nid);
> > +             parent_info = shrinker_info_protected(parent, nid);
> > +             for (i = 0; i < shrinker_nr_max; i++) {
> > +                     nr = atomic_long_read(&child_info->nr_deferred[i]);
> > +                     atomic_long_add(nr, &parent_info->nr_deferred[i]);
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
