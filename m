Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0082C2D5F54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 16:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbgLJPQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 10:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389815AbgLJPQT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:16:19 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0B1C0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:15:38 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id g185so5690750wmf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T8TYr8U3ruZBc+gFJ9Co9TnsVkvfLvOx2ydXd1OODM0=;
        b=WU51H6MlxI70ZfH97X4nphb6PeCVXPQICtS2n8J7/oPyV0L/0dPwJpf89kQhONT5mc
         Gy4hnVV19Gw9BelWveMRbSKPCjt/mTw3X634a71iuCnPSDKAOq8sdcyET5/iHIsedXRK
         B8pxA/hTm5+yQzRzC5qVvkrTUb3DybjHXGd1tew3jYlJYqQOrSBfiU4DY43CCS7EICXg
         As1YITr4s7ajmG2pPGGHBNDmPcVG/ltzv75N08tmGh/IbyknAhYkhG13J1WarMTFfCvN
         qIVfao7RoPIA4SVTrd/p/1ILgz2/Pu5+IStfEkTU5CoJlgZkajUAbYsJVV+1+Vmu8vdW
         40Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8TYr8U3ruZBc+gFJ9Co9TnsVkvfLvOx2ydXd1OODM0=;
        b=tJCeNsBcOnmx5CjpBnEFhoEHdir7PaNsqRiX+JrvgFNLQ/BakJ2nv9geRv2x6fZ5E9
         4n9c9h8QmDPH5YadsGyy6iT4s4Cuf+ULsr8ZdwoABbTHm50xRZiMDfEmaSTMaP7EeBOX
         nS3LC94FDzOkpYB8p0UbKeA4ihSyFBxm5BNLo0xwnUGSyIl/UX5RUzZ0Rc7fwx3jCLUU
         Y7Uf9M6HV7JJoFANn13y5txjfsv+rKnkb3Q4CYPNAs/WlCuQ6+gBKPNSXD1TWxNb2Vc4
         UCvdBjuMLP1gkGVdHh5EE2SflhHlK8QkSZWhodvTbFtz1owjpD0zImeLMfOj659wtcoA
         /+pA==
X-Gm-Message-State: AOAM5314hCHhNvupCLNKtXaaoSxdG73lkUXScUNXi95RCAxsIVADwFxw
        Mxh+NPhSsIsRDOxSybpSGSQPXQ==
X-Google-Smtp-Source: ABdhPJwvKg+10LY1GmSOlXuxo/XAN8MG6kMammXBvryoac7bz1FVX7xDo+2biy1GWPoESwlU2T2lJQ==
X-Received: by 2002:a1c:c305:: with SMTP id t5mr8890217wmf.63.1607613337568;
        Thu, 10 Dec 2020 07:15:37 -0800 (PST)
Received: from localhost (p4fdabc80.dip0.t-ipconnect.de. [79.218.188.128])
        by smtp.gmail.com with ESMTPSA id z2sm10467139wml.23.2020.12.10.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 07:15:36 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:13:31 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
Message-ID: <20201210151331.GD264602@cmpxchg.org>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-7-shy828301@gmail.com>
 <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com>
 <CAHbLzkoiTmNLXj1Tx0-PggEdcYQ6nj71DUX3ya6mj3VNZ5ho4A@mail.gmail.com>
 <d5454f6d-6739-3252-fba0-ac39c6c526c4@virtuozzo.com>
 <CAHbLzkqu5X-kFKt1vWYc8U=fK=NBWauP-=Kz+A9=GUuQ32+gAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqu5X-kFKt1vWYc8U=fK=NBWauP-=Kz+A9=GUuQ32+gAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:32:37AM -0800, Yang Shi wrote:
> On Wed, Dec 9, 2020 at 7:42 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >
> > On 08.12.2020 20:13, Yang Shi wrote:
> > > On Thu, Dec 3, 2020 at 3:40 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> > >>
> > >> On 02.12.2020 21:27, Yang Shi wrote:
> > >>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > >>> will be used in the following cases:
> > >>>     1. Non memcg aware shrinkers
> > >>>     2. !CONFIG_MEMCG
> > >>>     3. memcg is disabled by boot parameter
> > >>>
> > >>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> > >>> ---
> > >>>  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
> > >>>  1 file changed, 82 insertions(+), 6 deletions(-)
> > >>>
> > >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> > >>> index cba0bc8d4661..d569fdcaba79 100644
> > >>> --- a/mm/vmscan.c
> > >>> +++ b/mm/vmscan.c
> > >>> @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
> > >>>  static DEFINE_IDR(shrinker_idr);
> > >>>  static int shrinker_nr_max;
> > >>>
> > >>> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> > >>> +{
> > >>> +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> > >>> +             !mem_cgroup_disabled();
> > >>> +}
> > >>> +
> > >>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> > >>>  {
> > >>>       int id, ret = -ENOMEM;
> > >>> @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> > >>>  #endif
> > >>>       return false;
> > >>>  }
> > >>> +
> > >>> +static inline long count_nr_deferred(struct shrinker *shrinker,
> > >>> +                                  struct shrink_control *sc)
> > >>> +{
> > >>> +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> > >>> +     struct memcg_shrinker_deferred *deferred;
> > >>> +     struct mem_cgroup *memcg = sc->memcg;
> > >>> +     int nid = sc->nid;
> > >>> +     int id = shrinker->id;
> > >>> +     long nr;
> > >>> +
> > >>> +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > >>> +             nid = 0;
> > >>> +
> > >>> +     if (per_memcg_deferred) {
> > >>> +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> > >>> +                                                  true);
> > >>
> > >> My comment is about both 5/9 and 6/9 patches.
> > >
> > > Sorry for the late reply, I don't know why Gmail filtered this out to spam.
> > >
> > >>
> > >> shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> > >> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that you will see
> > >> memcg->nodeinfo[nid]->shrinker_deferred != NULL in count_nr_deferred(). This may occur
> > >> because of processor reordering on !x86 (there is no a common lock or memory barriers).
> > >>
> > >> Regarding to shrinker_map this is not a problem due to map check in shrink_slab_memcg().
> > >> The map can't be NULL there.
> > >>
> > >> Regarding to shrinker_deferred you should prove either this is not a problem too,
> > >> or to add proper synchronization (maybe, based on barriers) or to add some similar check
> > >> (maybe, in shrink_slab_memcg() too).
> > >
> > > It seems shrink_slab_memcg() might see shrinker_deferred as NULL
> > > either due to the same reason. I don't think there is a guarantee it
> > > won't happen.
> > >
> > > We just need guarantee CSS_ONLINE is seen after shrinker_maps and
> > > shrinker_deferred are allocated, so I'm supposed barriers before
> > > "css->flags |= CSS_ONLINE" should work.
> > >
> > > So the below patch may be ok:
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index df128cab900f..9f7fb0450d69 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5539,6 +5539,12 @@ static int mem_cgroup_css_online(struct
> > > cgroup_subsys_state *css)
> > >                 return -ENOMEM;
> > >         }
> > >
> > >
> > > +       /*
> > > +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
> > > shirnker_maps
> > > +        * and shrinker_deferred before CSS_ONLINE.
> > > +        */
> > > +       smp_mb();
> > > +
> > >         /* Online state pins memcg ID, memcg ID pins CSS */
> > >         refcount_set(&memcg->id.ref, 1);
> > >         css_get(css);
> >
> > smp barriers synchronize data access from different cpus. They should go in a pair.
> > In case of you add the smp barrier into mem_cgroup_css_online(), we should also
> > add one more smp barrier in another place, which we want to synchonize with this.
> > Also, every place should contain a comment referring to its pair: "Pairs with...".
> 
> Thanks, I think you are correct. Looked into it further, it seems the
> race pattern looks like:
> 
> CPU A                                                                  CPU B
> store shrinker_maps pointer                      load CSS_ONLINE
> store CSS_ONLINE                                   load shrinker_maps pointer
> 
> By checking the memory-barriers document, it seems we need write
> barrier/read barrier pair as below:
> 
> CPU A                                                                  CPU B
> store shrinker_maps pointer                       load CSS_ONLINE
> <write barrier>                                             <read barrier>
> store CSS_ONLINE                                    load shrinker_maps pointer
> 
> 
> So, the patch should look like:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index df128cab900f..489c0a84f82b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5539,6 +5539,13 @@ static int mem_cgroup_css_online(struct
> cgroup_subsys_state *css)
>                 return -ENOMEM;
>         }
> 
> +       /*
> +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
> shirnker_maps
> +        * and shrinker_deferred before CSS_ONLINE. It pairs with the
> read barrier
> +        * in shrink_slab_memcg().
> +        */
> +       smp_wmb();

Is there a reason why the shrinker allocations aren't done in
.css_alloc()? That would take care of all necessary ordering:

      #0
      css = ->css_alloc()
      list_add_tail_rcu(css, parent->children)
        rcu_assign_pointer()
      ->css_online(css)
      css->flags |= CSS_ONLINE

      #1
      memcg = mem_cgroup_iter()
        list_entry_rcu()
	  rcu_dereference()
      shrink_slab(.., memcg)

RCU ensures that once the cgroup shows up in the reclaim cgroup it's
also fully allocated.

>         /* Online state pins memcg ID, memcg ID pins CSS */
>         refcount_set(&memcg->id.ref, 1);
>         css_get(css);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9d2a6485e982..fc9bda576d98 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -603,13 +603,15 @@ static unsigned long shrink_slab_memcg(gfp_t
> gfp_mask, int nid,
>         if (!mem_cgroup_online(memcg))
>                 return 0;

...then we should be able to delete this online check here entirely:

A not-yet online cgroup is guaranteed to have a shrinker map, just
with no bits set. The shrinker code handles that just fine.

An offlined cgroup will eventually have an empty bitmap as the called
shrinkers return SHRINK_EMPTY. This could also be shortcut by clearing
the bit in memcg_drain_list_lru_node() the same way we set it in the
parent when we move all objects upward, but seems correct as-is.
