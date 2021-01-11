Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B112F1BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 18:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbhAKRKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 12:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbhAKRKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:10:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CF6C0617A4;
        Mon, 11 Jan 2021 09:08:59 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw4so606081ejb.12;
        Mon, 11 Jan 2021 09:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSHsnpaTqaEkArYwkMNNFsZmn9AnEAryiNdCrNxhEoE=;
        b=BN087SlKLrNpiyOXyf60UmGoQ7ZpTK0Qq52MW+BQtHNuR/esIafv1mbnDd8/SGw7rJ
         2E9dcSXdZ7TxMWi0xNTvb65aQBHrTjGV6w+tUbn2Qex1Rb2ZDSV/zYGhdIaNik16dwFX
         jUBU3IITql0WM+ELoixyxR1CDvUyI1Asn7r8ZM8LX8gz4L3xd/Yu+dQabsTqPw4iLZyI
         uM8Mw1gq62Sum7EB6aXAt0SJK9nkPwhlPOwiC4my3hGszS/4X3hJgOgq0RwvQ6ICwhSp
         1r1enI6HcKD6jUK+yGPElDXsrsxplkPWgJgGMjrqYwLxAtitq+HeXbdxS4gVYOqtniTC
         DcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSHsnpaTqaEkArYwkMNNFsZmn9AnEAryiNdCrNxhEoE=;
        b=XxYfYmj/h7bMRuJaJmFPc2SZHRRu/mtACU5pZxAbN8SX0hdU7NqhUSG3wUU/vdr04q
         ih89G0AY8LcbfE8bHyvBP/fB+wfy+J+sZ6QV0+Qu2DGS/eAbEoILcY48O9Cnyc8zpuK4
         EX+zp+0ssEdCUe0brbIfgy+rHQiKsFaxfCNfxA2pkSS47SGKJigvorugSfdmK+vdM6m1
         NHDzQ1CZa8QHqJHYoOaEA5zupajaK20WtTmLSS+DeBONbNAQfrYoYP2Hvy4cvfPyXsEK
         ZW8yMFOJXl6vRtwUCIL2UIk4XVMykgUY3qTdJR3vHODAI212nLrxTlcTDfzU5dUlMSpb
         S7iQ==
X-Gm-Message-State: AOAM531M7Mml8mbBJo4ZxaGcOU+LqfLpyG5Fj2dw/lBTMiYPHQbg3LPq
        x/hdQ9IUrV8aF8ZPtNjBpEDAYeDU9qtWNou9ETA=
X-Google-Smtp-Source: ABdhPJxFj5JH/o64LnuDkCdMO9Ola5OitTMkeU/UbF9uTC/pV9hUZAAI59khrlylGOAxBlo4tfWNKCaVcO5sUoSdudk=
X-Received: by 2002:a17:906:720e:: with SMTP id m14mr297288ejk.161.1610384938231;
 Mon, 11 Jan 2021 09:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-4-shy828301@gmail.com>
 <56d26993-1577-3747-2d89-1275d92f7a15@virtuozzo.com>
In-Reply-To: <56d26993-1577-3747-2d89-1275d92f7a15@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 09:08:46 -0800
Message-ID: <CAHbLzkqS2b7Eb_xDU3-6wR=LN5yr4nDeyyaynfLCzFJOinuUZw@mail.gmail.com>
Subject: Re: [v3 PATCH 03/11] mm: vmscan: use shrinker_rwsem to protect
 shrinker_maps allocation
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

On Wed, Jan 6, 2021 at 1:55 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.01.2021 01:58, Yang Shi wrote:
> > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > exclusively, the read side can be protected by holding read lock, so it sounds
> > superfluous to have a dedicated mutex.  This should not exacerbate the contention
> > to shrinker_rwsem since just one read side critical section is added.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 9db7b4d6d0ae..ddb9f972f856 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -187,7 +187,6 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >  #ifdef CONFIG_MEMCG
> >
> >  static int memcg_shrinker_map_size;
> > -static DEFINE_MUTEX(memcg_shrinker_map_mutex);
> >
> >  static void memcg_free_shrinker_map_rcu(struct rcu_head *head)
> >  {
> > @@ -200,8 +199,6 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> >       struct memcg_shrinker_map *new, *old;
> >       int nid;
> >
> > -     lockdep_assert_held(&memcg_shrinker_map_mutex);
> > -
> >       for_each_node(nid) {
> >               old = rcu_dereference_protected(
> >                       mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> > @@ -250,7 +247,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> >       if (mem_cgroup_is_root(memcg))
> >               return 0;
> >
> > -     mutex_lock(&memcg_shrinker_map_mutex);
> > +     down_read(&shrinker_rwsem);
> >       size = memcg_shrinker_map_size;
> >       for_each_node(nid) {
> >               map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> > @@ -261,7 +258,7 @@ int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> >               }
> >               rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, map);
>
> Here we do STORE operation, and since we want the assignment is visible
> for shrink_slab_memcg() under down_read(), we have to use down_write()
> in memcg_alloc_shrinker_maps().

I apologize for the late reply, these emails went to my SPAM again.

Before this patch it was not serialized by any lock either, right? Do
we have to serialize it? As Johannes mentioned if shrinker_maps has
not been initialized yet, it means the memcg is a newborn, there
should not be significant amount of reclaimable slab caches, so it is
fine to skip it. The point makes some sense to me.

So, the read lock seems good enough.

>
> >       }
> > -     mutex_unlock(&memcg_shrinker_map_mutex);
> > +     up_read(&shrinker_rwsem);
> >
> >       return ret;
> >  }
> > @@ -276,9 +273,8 @@ static int memcg_expand_shrinker_maps(int new_id)
> >       if (size <= old_size)
> >               return 0;
> >
> > -     mutex_lock(&memcg_shrinker_map_mutex);
> >       if (!root_mem_cgroup)
> > -             goto unlock;
> > +             goto out;
> >
> >       memcg = mem_cgroup_iter(NULL, NULL, NULL);
> >       do {
> > @@ -287,13 +283,13 @@ static int memcg_expand_shrinker_maps(int new_id)
> >               ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
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
> >
>
>
