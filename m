Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B372D4800
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgLIRdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 12:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgLIRdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:33:31 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6972C0613CF;
        Wed,  9 Dec 2020 09:32:50 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id bo9so3266924ejb.13;
        Wed, 09 Dec 2020 09:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCTu9SYS4xAxD6fbbi1HzsiCoR2Dn8r2H8c6zyF7DTI=;
        b=RDQPsXg/3vW9HZUFWux/wmqLbdK5YLbvHnMQAGT/VPDCsX77rEmD/49Xpf0BPbqWzi
         veyHP8O/LbBWcN3gnRO4YJ3eknxH+VVlPCV1PzsyE03xgqqfjhx1ZhBzpmwLn2MEuzJR
         w6DX5SND8/JKdEQSkaoVLxeno798Xz9gWj8HqY04jEtUwvjSvskoIxxlAiyIoQd/KwKI
         RP/N+hVKcoyo2L/rHovy8nJTtvekg/emT/+ofSDko9yblBzKHuJX4XVmm5Hg3n58ypPW
         tKktiwWBpf+1iPDoC11RAeVBugE6YARtx/3tbk9fVZpbR2nSi8LsSyZpAum4Qu+P971b
         5fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCTu9SYS4xAxD6fbbi1HzsiCoR2Dn8r2H8c6zyF7DTI=;
        b=K/SaWD7wQOXkJbJqDScUTjW4RZG7YBxwW2vOOqXcjJilIerrZVvy+eEq43oi04nn3u
         7TkwHTXymbWB60sm3gYXqqFCvZpVrbgwyHEghqLLD8Z6doULobFxFhB8VQMqgxI/Gf0K
         Hbmm1XNPbCvMob5RUSD6fpmCvsE8xAIDg8dEbLcd0q3eJ0pGVeWF7j8i3b/E2tLosfDQ
         18YvIcoyctxASHY3l0/cDy/NO3471yxYfZqC/87L35VOq5WtX4pdT61ArlSkELXlr/wg
         IxxBvXwRLr+n7r4VA2cUCQngP7pIgYp3Yfmz8DjIr3wTS76PCTDQrzgT+wKs00jxa+bO
         ZWNg==
X-Gm-Message-State: AOAM533I+nOULEcYkL+YLpOoeBHxiI+3CLlG75bV9Oy2B3GLkltxC2tG
        +8fMqmQOtMuWBYqTCSkudJsn6gqjP3Y+j0nC0s8=
X-Google-Smtp-Source: ABdhPJyX22yOKJwAo5RsbC9l4EZnf1ndp1QDw/Wv2fCvk/9ohTuzEt/5+LZi6rr83b5nFfCsUevVc9AV8nE5HdfzJbs=
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr2907593ejb.499.1607535169602;
 Wed, 09 Dec 2020 09:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-7-shy828301@gmail.com>
 <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com> <CAHbLzkoiTmNLXj1Tx0-PggEdcYQ6nj71DUX3ya6mj3VNZ5ho4A@mail.gmail.com>
 <d5454f6d-6739-3252-fba0-ac39c6c526c4@virtuozzo.com>
In-Reply-To: <d5454f6d-6739-3252-fba0-ac39c6c526c4@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Dec 2020 09:32:37 -0800
Message-ID: <CAHbLzkqu5X-kFKt1vWYc8U=fK=NBWauP-=Kz+A9=GUuQ32+gAQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
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

On Wed, Dec 9, 2020 at 7:42 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 08.12.2020 20:13, Yang Shi wrote:
> > On Thu, Dec 3, 2020 at 3:40 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 02.12.2020 21:27, Yang Shi wrote:
> >>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> >>> will be used in the following cases:
> >>>     1. Non memcg aware shrinkers
> >>>     2. !CONFIG_MEMCG
> >>>     3. memcg is disabled by boot parameter
> >>>
> >>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >>> ---
> >>>  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
> >>>  1 file changed, 82 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index cba0bc8d4661..d569fdcaba79 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >>>  static DEFINE_IDR(shrinker_idr);
> >>>  static int shrinker_nr_max;
> >>>
> >>> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> >>> +{
> >>> +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> >>> +             !mem_cgroup_disabled();
> >>> +}
> >>> +
> >>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >>>  {
> >>>       int id, ret = -ENOMEM;
> >>> @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >>>  #endif
> >>>       return false;
> >>>  }
> >>> +
> >>> +static inline long count_nr_deferred(struct shrinker *shrinker,
> >>> +                                  struct shrink_control *sc)
> >>> +{
> >>> +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> >>> +     struct memcg_shrinker_deferred *deferred;
> >>> +     struct mem_cgroup *memcg = sc->memcg;
> >>> +     int nid = sc->nid;
> >>> +     int id = shrinker->id;
> >>> +     long nr;
> >>> +
> >>> +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >>> +             nid = 0;
> >>> +
> >>> +     if (per_memcg_deferred) {
> >>> +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> >>> +                                                  true);
> >>
> >> My comment is about both 5/9 and 6/9 patches.
> >
> > Sorry for the late reply, I don't know why Gmail filtered this out to spam.
> >
> >>
> >> shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> >> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that you will see
> >> memcg->nodeinfo[nid]->shrinker_deferred != NULL in count_nr_deferred(). This may occur
> >> because of processor reordering on !x86 (there is no a common lock or memory barriers).
> >>
> >> Regarding to shrinker_map this is not a problem due to map check in shrink_slab_memcg().
> >> The map can't be NULL there.
> >>
> >> Regarding to shrinker_deferred you should prove either this is not a problem too,
> >> or to add proper synchronization (maybe, based on barriers) or to add some similar check
> >> (maybe, in shrink_slab_memcg() too).
> >
> > It seems shrink_slab_memcg() might see shrinker_deferred as NULL
> > either due to the same reason. I don't think there is a guarantee it
> > won't happen.
> >
> > We just need guarantee CSS_ONLINE is seen after shrinker_maps and
> > shrinker_deferred are allocated, so I'm supposed barriers before
> > "css->flags |= CSS_ONLINE" should work.
> >
> > So the below patch may be ok:
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index df128cab900f..9f7fb0450d69 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5539,6 +5539,12 @@ static int mem_cgroup_css_online(struct
> > cgroup_subsys_state *css)
> >                 return -ENOMEM;
> >         }
> >
> >
> > +       /*
> > +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
> > shirnker_maps
> > +        * and shrinker_deferred before CSS_ONLINE.
> > +        */
> > +       smp_mb();
> > +
> >         /* Online state pins memcg ID, memcg ID pins CSS */
> >         refcount_set(&memcg->id.ref, 1);
> >         css_get(css);
>
> smp barriers synchronize data access from different cpus. They should go in a pair.
> In case of you add the smp barrier into mem_cgroup_css_online(), we should also
> add one more smp barrier in another place, which we want to synchonize with this.
> Also, every place should contain a comment referring to its pair: "Pairs with...".

Thanks, I think you are correct. Looked into it further, it seems the
race pattern looks like:

CPU A                                                                  CPU B
store shrinker_maps pointer                      load CSS_ONLINE
store CSS_ONLINE                                   load shrinker_maps pointer

By checking the memory-barriers document, it seems we need write
barrier/read barrier pair as below:

CPU A                                                                  CPU B
store shrinker_maps pointer                       load CSS_ONLINE
<write barrier>                                             <read barrier>
store CSS_ONLINE                                    load shrinker_maps pointer


So, the patch should look like:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index df128cab900f..489c0a84f82b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5539,6 +5539,13 @@ static int mem_cgroup_css_online(struct
cgroup_subsys_state *css)
                return -ENOMEM;
        }

+       /*
+        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
shirnker_maps
+        * and shrinker_deferred before CSS_ONLINE. It pairs with the
read barrier
+        * in shrink_slab_memcg().
+        */
+       smp_wmb();
+
        /* Online state pins memcg ID, memcg ID pins CSS */
        refcount_set(&memcg->id.ref, 1);
        css_get(css);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9d2a6485e982..fc9bda576d98 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -603,13 +603,15 @@ static unsigned long shrink_slab_memcg(gfp_t
gfp_mask, int nid,
        if (!mem_cgroup_online(memcg))
                return 0;

+       /* Pairs with write barrier in mem_cgroup_css_online */
+       smp_rmb();
+
        if (!down_read_trylock(&shrinker_rwsem))
                return 0;

+       /* Once memcg is online it can't be NULL */
        map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
                                        true);
-       if (unlikely(!map))
-               goto unlock;

        for_each_set_bit(i, map->map, shrinker_nr_max) {
                struct shrink_control sc = {


Does this seem correct?

>
> Kirill
>
