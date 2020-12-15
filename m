Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5B2DB1E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgLOQvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 11:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgLOQrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:47:02 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05DFC0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:46:21 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id j22so10654800eja.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nw8qJctXIvsPyQDncdd+p7Hbk4k+GUcjFuipoh6BEs4=;
        b=0R0b5iOpq46F/ltkqP5QUZtIM2vKLRP3r8+5Fw6C7tXoQFcZhivRhlMfBDF2uIfHR9
         ciTSidoRlUqKtNVf7Y1vOFeoushrB+SrI9Oqph290PQicm2d8z2Yu8bTMfyk3RtIA5uE
         qaw8fswZRGA3gEnZjS0BAuIziHW4h5sh46iKfUfI5ORZiCWvqbjRoNVEs7OQ3CFLcV1Z
         pAAJUIW02QC0RyvGMtvFk87LTsPrAb9InBUIOkgqr71ZEARJ36hjGS+HsihZb+KMAM6p
         d3YMtLURwEHhU7ThUVpwsqnyYI+PTz7YSICpImA5XGYMMvm0X1CC//XOh0kctyLNO2Yq
         wCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nw8qJctXIvsPyQDncdd+p7Hbk4k+GUcjFuipoh6BEs4=;
        b=JGFrBflN1P4leqtTXayIGGmJBp7s6sd40StzXLB+gnVwPwWYWhGOEy9DD+py5aVG/8
         P6PNfEyfPOpr1SyciZZDA4yg6OaYKbEGIABd/pfVerAITBISj8hJ6G5fRMoaShqJVvNP
         r1tfbBUFN1abALZFrhZAmVupmRqGT2T1P8XmX1ZL1mnB9KIbg1qGEshdl4T4jAyxYhWG
         f5iztL+uOfAEgAiOg0NTYMwbrWB8eNNMnauRs26RTBj42nzHznQj6G0lkZVuA225mwUO
         eyJxaFeiW9QcrCrmml5TgGqL+K2YZpS2k60LsZnn2MG4mxwqADRnBCcbETNIS+nH71Ib
         hMYA==
X-Gm-Message-State: AOAM5324qF+oa/6Xp/8gpPEatf9tmw+zc7FOryPZh/pHNIh1QmPPkDA3
        yvIrOyai6XskbUOUnBALHjvviA==
X-Google-Smtp-Source: ABdhPJzXBrdogiiXI+Aubbw34P37afkwkySvpYIYVZdjbxX3UHqiyoshLsRXNbgF83diYQGkkMczJQ==
X-Received: by 2002:a17:906:27c2:: with SMTP id k2mr6901718ejc.211.1608050780506;
        Tue, 15 Dec 2020 08:46:20 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:d6dd])
        by smtp.gmail.com with ESMTPSA id e3sm1764803ejq.96.2020.12.15.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:46:19 -0800 (PST)
Date:   Tue, 15 Dec 2020 17:44:12 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/9] mm: vmscan: use per memcg nr_deferred of shrinker
Message-ID: <20201215164412.GA385334@cmpxchg.org>
References: <20201202182725.265020-1-shy828301@gmail.com>
 <20201202182725.265020-7-shy828301@gmail.com>
 <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com>
 <CAHbLzkoiTmNLXj1Tx0-PggEdcYQ6nj71DUX3ya6mj3VNZ5ho4A@mail.gmail.com>
 <d5454f6d-6739-3252-fba0-ac39c6c526c4@virtuozzo.com>
 <CAHbLzkqu5X-kFKt1vWYc8U=fK=NBWauP-=Kz+A9=GUuQ32+gAQ@mail.gmail.com>
 <20201210151331.GD264602@cmpxchg.org>
 <6ffd6aa1-2c55-f4d3-a60a-56786d40531a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ffd6aa1-2c55-f4d3-a60a-56786d40531a@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 06:17:54PM +0300, Kirill Tkhai wrote:
> On 10.12.2020 18:13, Johannes Weiner wrote:
> > On Wed, Dec 09, 2020 at 09:32:37AM -0800, Yang Shi wrote:
> >> On Wed, Dec 9, 2020 at 7:42 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>
> >>> On 08.12.2020 20:13, Yang Shi wrote:
> >>>> On Thu, Dec 3, 2020 at 3:40 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>>>
> >>>>> On 02.12.2020 21:27, Yang Shi wrote:
> >>>>>> Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> >>>>>> will be used in the following cases:
> >>>>>>     1. Non memcg aware shrinkers
> >>>>>>     2. !CONFIG_MEMCG
> >>>>>>     3. memcg is disabled by boot parameter
> >>>>>>
> >>>>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >>>>>> ---
> >>>>>>  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
> >>>>>>  1 file changed, 82 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>>>> index cba0bc8d4661..d569fdcaba79 100644
> >>>>>> --- a/mm/vmscan.c
> >>>>>> +++ b/mm/vmscan.c
> >>>>>> @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >>>>>>  static DEFINE_IDR(shrinker_idr);
> >>>>>>  static int shrinker_nr_max;
> >>>>>>
> >>>>>> +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> >>>>>> +{
> >>>>>> +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> >>>>>> +             !mem_cgroup_disabled();
> >>>>>> +}
> >>>>>> +
> >>>>>>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >>>>>>  {
> >>>>>>       int id, ret = -ENOMEM;
> >>>>>> @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >>>>>>  #endif
> >>>>>>       return false;
> >>>>>>  }
> >>>>>> +
> >>>>>> +static inline long count_nr_deferred(struct shrinker *shrinker,
> >>>>>> +                                  struct shrink_control *sc)
> >>>>>> +{
> >>>>>> +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> >>>>>> +     struct memcg_shrinker_deferred *deferred;
> >>>>>> +     struct mem_cgroup *memcg = sc->memcg;
> >>>>>> +     int nid = sc->nid;
> >>>>>> +     int id = shrinker->id;
> >>>>>> +     long nr;
> >>>>>> +
> >>>>>> +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> >>>>>> +             nid = 0;
> >>>>>> +
> >>>>>> +     if (per_memcg_deferred) {
> >>>>>> +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> >>>>>> +                                                  true);
> >>>>>
> >>>>> My comment is about both 5/9 and 6/9 patches.
> >>>>
> >>>> Sorry for the late reply, I don't know why Gmail filtered this out to spam.
> >>>>
> >>>>>
> >>>>> shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> >>>>> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that you will see
> >>>>> memcg->nodeinfo[nid]->shrinker_deferred != NULL in count_nr_deferred(). This may occur
> >>>>> because of processor reordering on !x86 (there is no a common lock or memory barriers).
> >>>>>
> >>>>> Regarding to shrinker_map this is not a problem due to map check in shrink_slab_memcg().
> >>>>> The map can't be NULL there.
> >>>>>
> >>>>> Regarding to shrinker_deferred you should prove either this is not a problem too,
> >>>>> or to add proper synchronization (maybe, based on barriers) or to add some similar check
> >>>>> (maybe, in shrink_slab_memcg() too).
> >>>>
> >>>> It seems shrink_slab_memcg() might see shrinker_deferred as NULL
> >>>> either due to the same reason. I don't think there is a guarantee it
> >>>> won't happen.
> >>>>
> >>>> We just need guarantee CSS_ONLINE is seen after shrinker_maps and
> >>>> shrinker_deferred are allocated, so I'm supposed barriers before
> >>>> "css->flags |= CSS_ONLINE" should work.
> >>>>
> >>>> So the below patch may be ok:
> >>>>
> >>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>> index df128cab900f..9f7fb0450d69 100644
> >>>> --- a/mm/memcontrol.c
> >>>> +++ b/mm/memcontrol.c
> >>>> @@ -5539,6 +5539,12 @@ static int mem_cgroup_css_online(struct
> >>>> cgroup_subsys_state *css)
> >>>>                 return -ENOMEM;
> >>>>         }
> >>>>
> >>>>
> >>>> +       /*
> >>>> +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
> >>>> shirnker_maps
> >>>> +        * and shrinker_deferred before CSS_ONLINE.
> >>>> +        */
> >>>> +       smp_mb();
> >>>> +
> >>>>         /* Online state pins memcg ID, memcg ID pins CSS */
> >>>>         refcount_set(&memcg->id.ref, 1);
> >>>>         css_get(css);
> >>>
> >>> smp barriers synchronize data access from different cpus. They should go in a pair.
> >>> In case of you add the smp barrier into mem_cgroup_css_online(), we should also
> >>> add one more smp barrier in another place, which we want to synchonize with this.
> >>> Also, every place should contain a comment referring to its pair: "Pairs with...".
> >>
> >> Thanks, I think you are correct. Looked into it further, it seems the
> >> race pattern looks like:
> >>
> >> CPU A                                                                  CPU B
> >> store shrinker_maps pointer                      load CSS_ONLINE
> >> store CSS_ONLINE                                   load shrinker_maps pointer
> >>
> >> By checking the memory-barriers document, it seems we need write
> >> barrier/read barrier pair as below:
> >>
> >> CPU A                                                                  CPU B
> >> store shrinker_maps pointer                       load CSS_ONLINE
> >> <write barrier>                                             <read barrier>
> >> store CSS_ONLINE                                    load shrinker_maps pointer
> >>
> >>
> >> So, the patch should look like:
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index df128cab900f..489c0a84f82b 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -5539,6 +5539,13 @@ static int mem_cgroup_css_online(struct
> >> cgroup_subsys_state *css)
> >>                 return -ENOMEM;
> >>         }
> >>
> >> +       /*
> >> +        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
> >> shirnker_maps
> >> +        * and shrinker_deferred before CSS_ONLINE. It pairs with the
> >> read barrier
> >> +        * in shrink_slab_memcg().
> >> +        */
> >> +       smp_wmb();
> > 
> > Is there a reason why the shrinker allocations aren't done in
> > .css_alloc()? That would take care of all necessary ordering:
> 
> The reason is that allocations have to be made in a place, where
> mem-cgroup_iter() can't miss it, since memcg_expand_shrinker_maps()
> shouldn't miss allocated shrinker maps.

I see, because we could have this:

.css_alloc()
  memcg_alloc_shrinker_maps()
    down_read(&shrinker_sem)
    map = alloc(shrinker_nr_max * sizeof(long));
    rcu_assign_pointer(memcg->...->shrinker_map = map);
    up_read(&shrinker_sem);
                                                            register_shrinker()
                                                              down_write(&shrinker_sem)
                                                              shrinker_nr_max = id + 1;
                                                              memcg_expand_shrinker_maps()
                                                                for_each_mem_cgroup()
                                                                  realloc
                                                              up_write(&shrinker_sem)
  list_add_tail_rcu(&css->sibling, &parent->children);

  /* boom: missed new shrinker, map too small */

Thanks for the clarification.
