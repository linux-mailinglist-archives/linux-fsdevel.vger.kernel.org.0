Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AEC30F9F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 18:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbhBDRkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 12:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbhBDRdk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:33:40 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C606C06178C;
        Thu,  4 Feb 2021 09:33:00 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a8so5719874lfi.8;
        Thu, 04 Feb 2021 09:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D9/da0TYqc2IuJFpJdibkLommX5XSKGKPIxcqiy6/RM=;
        b=jxK2pLrz7T9ANF2wqKTw7AKiJ7M0bYH1vM2tXWf0st/UY2Rz50ckQfB2Y+448RVr/L
         nME7/yCM2E7dYcUxLvVSNnM6Vjk513mgj8U70Dldayl76491r/G/A9Dh23SxOsLyXgJx
         Guo2P4wrf/AJrs6P97SVbPy1odjB4an45VuapaMlWVyd44lkoptaeaoML48Bs0/Wu/T3
         zQ9rVePBSS5p1+JaPwCUBaAIdWMTLKlFE371UGwkFlWyux23z1klAJAH/mbnaN6iXEIA
         M0HdoEVCue+e0/30e+am4lqWGZweIchKO0te8189gBrR0rwe3bSP1v9SFql6qFfAdfIH
         luxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D9/da0TYqc2IuJFpJdibkLommX5XSKGKPIxcqiy6/RM=;
        b=Z2U/vZK6e6+BwVFg23kwObpBgewSFLgnfWQh88+GKaGths5aPdMLRBvR0Q2+DQoAp4
         sroVErYqctAVhClo5bafYrwlRr1IqPoV43sis0KV/Y6g0uvhH2Y+UTlquCplSN+oVwfK
         jMFBAWxNYizK2/yxTVkNBFqSR0OJ6Kx3Lkfhxo6NyTz6xI+r3OIqMS/yR+YbWIb48JFa
         3R7PiCHpd751wXqB0HyiiHk4gFQpDOhve89AesNPE0RN1QjI4Q0M4gsYtW6EY10hW7ZV
         nXDr/lY7+XCf9h+waOCLtBOBmCwQvbu2ISSBxKukX8YnbGBZhm45WQX1dP9ftjAE2mJA
         pJYw==
X-Gm-Message-State: AOAM530W+6SOGiEFjwju7jJ31vVERNMmnE96Kz9hOJnb3xKSslkjKDEx
        cMm55Gz3eJlX94vCcFlrhz01MvlprdkoRFYyKhM=
X-Google-Smtp-Source: ABdhPJxskkEcudNmLMXwFbaywk0AsuzD69Nc7ex/EdDYH309v5vJBCtwQYOtDY9HFfxdJeg3cOVUTdY5u+uCKQ7uncc=
X-Received: by 2002:a05:6512:3772:: with SMTP id z18mr243698lft.620.1612459978869;
 Thu, 04 Feb 2021 09:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20210203172042.800474-1-shy828301@gmail.com> <20210203172042.800474-10-shy828301@gmail.com>
 <656865f5-bb56-4f4c-b88d-ec933a042b4c@virtuozzo.com> <5e335e4a-1556-e694-8f0b-192d924f99e5@virtuozzo.com>
In-Reply-To: <5e335e4a-1556-e694-8f0b-192d924f99e5@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 4 Feb 2021 09:32:46 -0800
Message-ID: <CAHbLzkpy+bg+7HMb5qG_1gocXhkuuxip0Wn9Afu3Tx6-FMoMig@mail.gmail.com>
Subject: Re: [v6 PATCH 09/11] mm: vmscan: don't need allocate
 shrinker->nr_deferred for memcg aware shrinkers
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
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

On Thu, Feb 4, 2021 at 2:14 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 04.02.2021 12:29, Kirill Tkhai wrote:
> > On 03.02.2021 20:20, Yang Shi wrote:
> >> Now nr_deferred is available on per memcg level for memcg aware shrinkers, so don't need
> >> allocate shrinker->nr_deferred for such shrinkers anymore.
> >>
> >> The prealloc_memcg_shrinker() would return -ENOSYS if !CONFIG_MEMCG or memcg is disabled
> >> by kernel command line, then shrinker's SHRINKER_MEMCG_AWARE flag would be cleared.
> >> This makes the implementation of this patch simpler.
> >>
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >> Signed-off-by: Yang Shi <shy828301@gmail.com>
> >> ---
> >>  mm/vmscan.c | 31 ++++++++++++++++---------------
> >>  1 file changed, 16 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 545422d2aeec..20a35d26ae12 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -334,6 +334,9 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >>  {
> >>      int id, ret = -ENOMEM;
> >>
> >> +    if (mem_cgroup_disabled())
> >> +            return -ENOSYS;
> >> +
> >>      down_write(&shrinker_rwsem);
> >>      /* This may call shrinker, so it must use down_read_trylock() */
> >>      id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> >> @@ -414,7 +417,7 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >>  #else
> >>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >>  {
> >> -    return 0;
> >> +    return -ENOSYS;
> >>  }
> >>
> >>  static void unregister_memcg_shrinker(struct shrinker *shrinker)
> >> @@ -525,8 +528,18 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
> >>   */
> >>  int prealloc_shrinker(struct shrinker *shrinker)
> >>  {
> >> -    unsigned int size = sizeof(*shrinker->nr_deferred);
> >> +    unsigned int size;
> >> +    int err;
> >> +
> >> +    if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> >> +            err = prealloc_memcg_shrinker(shrinker);
> >> +            if (err != -ENOSYS)
> >> +                    return err;
> >>
> >> +            shrinker->flags &= ~SHRINKER_MEMCG_AWARE;
> >> +    }
> >> +
> >> +    size = sizeof(*shrinker->nr_deferred);
> >>      if (shrinker->flags & SHRINKER_NUMA_AWARE)
> >>              size *= nr_node_ids;
> >
> > This may sound surprisingly, but IIRC do_shrink_slab() may be called on early boot
> > *even before* root_mem_cgroup is allocated. AFAIR, I received syzcaller crash report
> > because of this, when I was implementing shrinker_maps.
> >
> > This is a reason why we don't use shrinker_maps even in case of mem cgroup is not
> > disabled: we iterate every shrinker of shrinker_list. See check in shrink_slab():
> >
> >       if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> >
> > Possible, we should do the same for nr_deferred: 1)always allocate shrinker->nr_deferred,
> > 2)use shrinker->nr_deferred in count_nr_deferred() and set_nr_deferred().
>
> I looked over my mail box, and I can't find that crash report and conditions to reproduce.
>
> Hm, let's remain this as is, and we rework this in case of such early shrinker call is still
> possible, and there will be a report...

Sure. But I'm wondering how that could happen. On a very small machine?

>
> Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>
> With only nit:
>
> >>
> >> @@ -534,26 +547,14 @@ int prealloc_shrinker(struct shrinker *shrinker)
> >>      if (!shrinker->nr_deferred)
> >>              return -ENOMEM;
> >>
> >> -    if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> >> -            if (prealloc_memcg_shrinker(shrinker))
> >> -                    goto free_deferred;
> >> -    }
> >>
> >>      return 0;
> >> -
> >> -free_deferred:
> >> -    kfree(shrinker->nr_deferred);
> >> -    shrinker->nr_deferred = NULL;
> >> -    return -ENOMEM;
> >>  }
> >>
> >>  void free_prealloced_shrinker(struct shrinker *shrinker)
> >>  {
> >> -    if (!shrinker->nr_deferred)
> >> -            return;
> >> -
> >>      if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >> -            unregister_memcg_shrinker(shrinker);
> >> +            return unregister_memcg_shrinker(shrinker);
>
> I've never seen return of void function in linux kernel. I'm not sure this won't confuse people.

Will fix in v7.

>
> >>
> >>      kfree(shrinker->nr_deferred);
> >>      shrinker->nr_deferred = NULL;
> >>
> >
>
>
