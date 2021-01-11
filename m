Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5692F1E2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbhAKSld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbhAKSld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:41:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D30C061786;
        Mon, 11 Jan 2021 10:40:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jx16so1048463ejb.10;
        Mon, 11 Jan 2021 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rS0nEqqY5DIX8IroGa7HDMwSqP/T08ubGIh3ZHP9MdQ=;
        b=KoopstLFG8lFj0hWFtj6nVkK7PfeCadabPt/cVWpYuurqwNCGr5HcVM9IpQqysgXWu
         eoL0+xH2ueOe7ttTIxc0NU9+qQI4MFLsmf+XScnEiM+RR1fb4XuO+1uOHqQlYnDDoJiU
         azpQjqsMTLaxMH9ryiI+TvWahy6tLzFECwUBDfjy9kBl/5PcFcCNXE2i3BljlR9U/Gpw
         hlRdGgZj4axJ36LDkwmQruRdSDvT6ZuvySqS/0K6b6JzuV1fBQbwmWCbL9Igqhgr0P7U
         HLsxu/EiPDdl7xO1QMcyjvpG49Lf0wdBqDoVczIb+GBxLQtY47JDPJzzfzJ/jDjUkxeX
         iqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rS0nEqqY5DIX8IroGa7HDMwSqP/T08ubGIh3ZHP9MdQ=;
        b=VBRFUx4UzqG0sDEfZkkZ3b0srudCoVo0RK3Ve5aebEFnEUdv28GR6jY0ynRcpACCcy
         kXoUgGgIf3/I3uglIpUVxmg3ZmclimM5ff2EH4aPdm7TDzhDU1wzZ9tb1DtyAgC6GeaX
         WVlifoRpP2P1uhNsQUmZYVk5hg0KMEct+TBmujx6go0rq9ceDFP6XZF55xEfqBAFjtXA
         aQv5qUUxGx7zNDuTgJ25K1B04AFSfDmnmnVIQhlAEFV1qjwXJAUt6tRRzSjmiUdYMdN/
         +uY6XtUV8sd0CDOTejYJUwgmfQhHK7uqhc8/mrdhwaAWWdFKJirtRwM40tRgQdeYBF7S
         mEDg==
X-Gm-Message-State: AOAM5304Nme8kksBzQbHVDILnHN6qCoNXkg/6tc1fA1Si6O6Rxv6fku2
        T8Ip6u1FtO5iZc8CcYBBMJBMQInZj315jdX8S2E=
X-Google-Smtp-Source: ABdhPJwf+tdgfN0w4ATlKhBKd1YYSdVZCkGOdMtIk9GGBjXLr//8F4SyPXsWKNyM6demYoG/JcOXNtJCdyDRN9nFmVU=
X-Received: by 2002:a17:907:546:: with SMTP id wk6mr567401ejb.238.1610390451514;
 Mon, 11 Jan 2021 10:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-10-shy828301@gmail.com>
 <7c591313-08fd-4f98-6021-6dfa59f01aff@virtuozzo.com>
In-Reply-To: <7c591313-08fd-4f98-6021-6dfa59f01aff@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 10:40:39 -0800
Message-ID: <CAHbLzkrFA6DTjJzxhrsAVCNMcLS7bXATUyF79EC1sov2D1VYqg@mail.gmail.com>
Subject: Re: [v3 PATCH 09/11] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
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

On Wed, Jan 6, 2021 at 3:16 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.01.2021 01:58, Yang Shi wrote:
> > Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> > allocate shrinker->nr_deferred for such shrinkers anymore.
> >
> > The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
> > by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
> > This makes the implementation of this patch simpler.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f20ed8e928c2..d9795fb0f1c5 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -340,6 +340,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  {
> >       int id, ret = -ENOMEM;
> >
> > +     if (mem_cgroup_disabled())
> > +             return -ENOSYS;
> > +
> >       down_write(&shrinker_rwsem);
> >       /* This may call shrinker, so it must use down_read_trylock() */
> >       id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> > @@ -424,7 +427,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >  #else
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  {
> > -     return 0;
> > +     return -ENOSYS;
> >  }
> >
> >  static void unregister_memcg_shrinker(struct shrinker *shrinker)
> > @@ -535,8 +538,20 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
> >   */
> >  int prealloc_shrinker(struct shrinker *shrinker)
> >  {
> > -     unsigned int size = sizeof(*shrinker->nr_deferred);
> > +     unsigned int size;
> > +     int err;
> > +
> > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > +             err = prealloc_memcg_shrinker(shrinker);
> > +             if (!err)
> > +                     return 0;
> > +             if (err != -ENOSYS)
> > +                     return err;
> > +
> > +             shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
>
> This looks very confusing.
>
> In case of you want to disable preallocation branch for !MEMCG case,
> you should firstly consider something like the below:

Not only !CONFIG_MEMCG, but also "cgroup_disable=memory" case.

>
> #ifdef CONFIG_MEMCG
> #define SHRINKER_MEMCG_AWARE    (1 << 2)
> #else
> #define SHRINKER_MEMCG_AWARE    0
> #endif

This could handle !CONFIG_MEMCG case, but can't deal with
"cgroup_disable=memory" case. We could consider check
mem_cgroup_disabled() when initializing shrinker, but this may result
in touching fs codes like below:

--- a/fs/super.c
+++ b/fs/super.c
@@ -266,7 +266,9 @@ static struct super_block *alloc_super(struct
file_system_type *type, int flags,
        s->s_shrink.scan_objects = super_cache_scan;
        s->s_shrink.count_objects = super_cache_count;
        s->s_shrink.batch = 1024;
-       s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
+       s->s_shrink.flags = SHRINKER_NUMA_AWARE;
+       if (!mem_cgroup_disabled())
+               s->s_shrink.flags |= SHRINKER_MEMCG_AWARE;
        if (prealloc_shrinker(&s->s_shrink))
                goto fail;
        if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))


>
> > +     }
> >
> > +     size = sizeof(*shrinker->nr_deferred);
> >       if (shrinker->flags & SHRINKER_NUMA_AWARE)
> >               size *= nr_node_ids;
> >
> > @@ -544,26 +559,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
> >       if (!shrinker->nr_deferred)
> >               return -ENOMEM;
> >
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> > -             if (prealloc_memcg_shrinker(shrinker))
> > -                     goto free_deferred;
> > -     }
> >
> >       return 0;
> > -
> > -free_deferred:
> > -     kfree(shrinker->nr_deferred);
> > -     shrinker->nr_deferred = NULL;
> > -     return -ENOMEM;
> >  }
> >
> >  void free_prealloced_shrinker(struct shrinker *shrinker)
> >  {
> > -     if (!shrinker->nr_deferred)
> > -             return;
> > -
> >       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             unregister_memcg_shrinker(shrinker);
> > +             return unregister_memcg_shrinker(shrinker);
> >
> >       kfree(shrinker->nr_deferred);
> >       shrinker->nr_deferred = NULL;
> >
>
>
