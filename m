Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8393B315A62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 00:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhBIX6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 18:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhBIX3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:29:23 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A6C061786;
        Tue,  9 Feb 2021 15:28:43 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p20so502221ejb.6;
        Tue, 09 Feb 2021 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LOfUnbs2rjrDJJHm6hAN6K5xB7iMF06eg0OTBY+XJI=;
        b=hKF40R8ujeaEK9QaHJwh3Q7/gcPxTTRo5CzSQA00Xy0IB4Rlp5wrTBlxulJ/nZNuWl
         ig5yRREg4tHynFKLjKxxMFXAld1Ak51jizmo9hBLZRKrv5alMEw66nsxcVKS9SY+DOd3
         E3nquhWnhwlXdJI4ryoHT93MXr+M84K31KgQSaJCUwhZoXzgnnxmosqCyWkCx8QM5p1o
         pZqQKFYs2wtVqk+laCxEy+DaymqTmm4syXbjCvN2qtuzcLfNf8jTC9DMT8vJtWYs7D6q
         Zvyl4ETPdD+01p4h7VOkIHpkXs+9U4vl15aC/JcR+FGplyeTK3Q70Z5xsouHfreVcpj5
         MX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LOfUnbs2rjrDJJHm6hAN6K5xB7iMF06eg0OTBY+XJI=;
        b=mPSTONrOgZ7Bos4AYJIj8OyeyioR6W/vA0OiwORWX8GjEM9skur/lkM96YAaRCH4MZ
         frPEZnFGSScicdErZBgvY5BwHXxYzPaP1JwGsR+Ko04cjLpa3JjuLa+56HEx+bxNpqQg
         +lsR955hlb+szFHAuNgktUjRpa4DAx42h0wRILJr2gzLo66aibWQepS3k7m0+R2z5Pj9
         hErtcVgyQSE5GZBExwq27NWJrA95PIF5+EXIBRI4dtGmLCD3Gxh2I/fXmrPnkHGz8k0v
         9af1pgxX845/epUCS+casLui4xe1lse6KF3wjChMDSWhABvou+1Cl7UldL2+PBw/9unz
         AmAA==
X-Gm-Message-State: AOAM530ejf0d1k3AIqzGj3pna+NcWzinXIWYKYFn4AQi9xzaYRWWZOWa
        bHiXzo9XxMZ4nKx91WjPB9jqgqr7wLZdZ703xa8=
X-Google-Smtp-Source: ABdhPJy1/Q8eKamyH3M828qG9CNSWbfUR6JpVHCh723gGoVDjpQDzXNQgifkrKdm9F4jXpJcVEXg8oUMrI1xW3q1/gQ=
X-Received: by 2002:a17:906:2e85:: with SMTP id o5mr127772eji.238.1612913321899;
 Tue, 09 Feb 2021 15:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-4-shy828301@gmail.com>
 <20210209203307.GF524633@carbon.DHCP.thefacebook.com>
In-Reply-To: <20210209203307.GF524633@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 9 Feb 2021 15:28:30 -0800
Message-ID: <CAHbLzkqgd0U7pH2czz23HvRcbwOeSRzaHyCTZptfdX5mkgXqTA@mail.gmail.com>
Subject: Re: [v7 PATCH 03/12] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
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

On Tue, Feb 9, 2021 at 12:33 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Feb 09, 2021 at 09:46:37AM -0800, Yang Shi wrote:
> > Since memcg_shrinker_map_size just can be changed under holding shrinker_rwsem
> > exclusively, the read side can be protected by holding read lock, so it sounds
> > superfluous to have a dedicated mutex.
> >
> > Kirill Tkhai suggested use write lock since:
> >
> >   * We want the assignment to shrinker_maps is visible for shrink_slab_memcg().
> >   * The rcu_dereference_protected() dereferrencing in shrink_slab_memcg(), but
> >     in case of we use READ lock in alloc_shrinker_maps(), the dereferrencing
> >     is not actually protected.
> >   * READ lock makes alloc_shrinker_info() racy against memory allocation fail.
> >     alloc_shrinker_info()->free_shrinker_info() may free memory right after
> >     shrink_slab_memcg() dereferenced it. You may say
> >     shrink_slab_memcg()->mem_cgroup_online() protects us from it? Yes, sure,
> >     but this is not the thing we want to remember in the future, since this
> >     spreads modularity.
> >
> > And a test with heavy paging workload didn't show write lock makes things worse.
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Roman Gushchin <guro@fb.com>
>
> with a small nit (below):
>
> > ---
> >  mm/vmscan.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 96b08c79f18d..e4ddaaaeffe2 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >  #ifdef CONFIG_MEMCG
> >
> >  static int memcg_shrinker_map_size;
> > -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
> >
> >  static void free_shrinker_map_rcu(struct rcu_head *head)
> >  {
> > @@ -200,8 +199,6 @@ static int expand_one_shrinker_map(struct mem_cgroup *memcg,
> >       struct memcg_shrinker_map *new, *old;
> >       int nid;
> >
> > -     lockdep_assert_held(&memcg_shrinker_map_mutex);
> > -
>
> Why not check that shrinker_rwsem is down here?

No special reason, just because we know it was acquired before. We
could add the check, but not here. I think it'd be better to have the
assert in expand_shrinker_maps() since the rwsem was acquired before
calling it.

>
> >       for_each_node(nid) {
> >               old = rcu_dereference_protected(
> >                       mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> > @@ -249,7 +246,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
> >       if (mem_cgroup_is_root(memcg))
> >               return 0;
> >
> > -     mutex_lock(&memcg_shrinker_map_mutex);
> > +     down_write(&shrinker_rwsem);
> >       size = memcg_shrinker_map_size;
> >       for_each_node(nid) {
> >               map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
> > @@ -260,7 +257,7 @@ int alloc_shrinker_maps(struct mem_cgroup *memcg)
> >               }
> >               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
> >       }
> > -     mutex_unlock(&memcg_shrinker_map_mutex);
> > +     up_write(&shrinker_rwsem);
> >
> >       return ret;
> >  }
> > @@ -275,9 +272,8 @@ static int expand_shrinker_maps(int new_id)
> >       if (size <= old_size)
> >               return 0;
> >
> > -     mutex_lock(&memcg_shrinker_map_mutex);
>
> And here as well. It will make the locking model more obvious and will help
> to avoid errors in the future.
>
> >       if (!root_mem_cgroup)
> > -             goto unlock;
> > +             goto out;
> >
> >       memcg = mem_cgroup_iter(NULL, NULL, NULL);
> >       do {
> > @@ -286,13 +282,13 @@ static int int new_id)
> >               ret = expand_one_shrinker_map(memcg, size, old_size);
> >               if (ret) {
> >                       mem_cgroup_iter_break(NULL, memcg);
> > -                     goto unlock;
> > +                     goto out;
> >               }
> >       } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> > -unlock:
> > +out:
> >       if (!ret)
> >               memcg_shrinker_map_size = size;
> > -     mutex_unlock(&memcg_shrinker_map_mutex);
> > +
> >       return ret;
> >  }
> >
> > --
> > 2.26.2
> >
