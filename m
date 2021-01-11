Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77D32F1DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390352AbhAKSST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390056AbhAKSST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:18:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0DDC061795;
        Mon, 11 Jan 2021 10:17:38 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id 6so995644ejz.5;
        Mon, 11 Jan 2021 10:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HR2yya3rEhjyoFHghdM9H+zzVIak5D+Mg99fwtlBy0=;
        b=uccSzMfhv+MJ/yyDhYaTeiciitkkoQrrtsZ38UW6OuSdnuG+c9uwmdYv+aXMbLfnVc
         +w3dcskYN9SbcJm+5q3Gdo55QIVI+MN/MbiWT6l5TodUBkGLl9qv1SmlsKhafi5S0ul2
         1NGky+Qs6Fv7chzE9vjTXfPL1AopKwPjGK2Hl4t+WkpsJWAnO6Vt02PXX1/PFIZonFPo
         T/3cBWq6V1NALGOykqorxztCLXNZhG7yVBtvegIBlcjYYAhYjzIeRUhychQYgigqCN7I
         R8bKY7Cvdb7BgerA+3GEmlqniOhAk1gj71+O+QQ+PVUKOW7xs1x1NDtmNrPc8HNsmLoE
         lDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HR2yya3rEhjyoFHghdM9H+zzVIak5D+Mg99fwtlBy0=;
        b=QZlNsRJb66cciPUNEUtc+ERm71uBwvMSwzEAx8zMT97UACG81gavYuMIi8NjvH99pV
         gfgiM2sm9DC5NHYmn2Wh0c0XK1cgJaaWC31HOAtAS1nyl8ImdJpEGSwajfi+vJ0iCfSZ
         VG8S3QxbprZ0v5zn3+PMjdTsMWV8cXix6prVFNZpruRlU+TxmFAksq9ALpN7X7s02ojp
         W74AhvoZOJuSC4dbDEmWgjEA2ZvxZJ63IiqmM3ik7z/g2dq1+AETVnELRq3QYsYWnLlF
         ZXLjrd82Dmxxg1xSZPlLTe5nucleu8jmL/aJkdMEPkMAeUok913yeh49MdUFTmj9wzUi
         IFxA==
X-Gm-Message-State: AOAM530KHP85UC6CoGyFwDpmo4neq5G32KSCY7v4MxzovJuzgdu5/T2U
        pscZdayMcmdegu4Ddsg36BsX+K7Hs+8RuhcgLFk=
X-Google-Smtp-Source: ABdhPJyRyrzpvUSXDYm8hrLQbJY/N1WQX20rHB1kkjGw3lluI6obLTHbnob3FibmX03jboDaSvc89z5PWTXjHvr2r/A=
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr470797ejb.499.1610389057657;
 Mon, 11 Jan 2021 10:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-6-shy828301@gmail.com>
 <bdf650e0-6728-4481-3454-c865649bbdcf@virtuozzo.com>
In-Reply-To: <bdf650e0-6728-4481-3454-c865649bbdcf@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 10:17:25 -0800
Message-ID: <CAHbLzkqZ7Hmo7DSQijrgoKaDQDaOb3+tTGeJ2xU8drFKZ6jv4A@mail.gmail.com>
Subject: Re: [v3 PATCH 05/11] mm: vmscan: use a new flag to indicate shrinker
 is registered
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

On Wed, Jan 6, 2021 at 2:22 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.01.2021 01:58, Yang Shi wrote:
> > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > This approach is fine with nr_deferred at the shrinker level, but the following
> > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > from unregistering correctly.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/shrinker.h |  7 ++++---
> >  mm/vmscan.c              | 13 +++++++++----
> >  2 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> > index 0f80123650e2..1eac79ce57d4 100644
> > --- a/include/linux/shrinker.h
> > +++ b/include/linux/shrinker.h
> > @@ -79,13 +79,14 @@ struct shrinker {
> >  #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
> >
> >  /* Flags */
> > -#define SHRINKER_NUMA_AWARE  (1 << 0)
> > -#define SHRINKER_MEMCG_AWARE (1 << 1)
> > +#define SHRINKER_REGISTERED  (1 << 0)
> > +#define SHRINKER_NUMA_AWARE  (1 << 1)
> > +#define SHRINKER_MEMCG_AWARE (1 << 2)
> >  /*
> >   * It just makes sense when the shrinker is also MEMCG_AWARE for now,
> >   * non-MEMCG_AWARE shrinker should not have this flag set.
> >   */
> > -#define SHRINKER_NONSLAB     (1 << 2)
> > +#define SHRINKER_NONSLAB     (1 << 3)
> >
> >  extern int prealloc_shrinker(struct shrinker *shrinker);
> >  extern void register_shrinker_prepared(struct shrinker *shrinker);
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 8da765a85569..9761c7c27412 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -494,6 +494,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >       if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> >               idr_replace(&shrinker_idr, shrinker, shrinker->id);
> >  #endif
> > +     shrinker->flags |= SHRINKER_REGISTERED;
>
> In case of we introduce this new flag, we should kill old flag SHRINKER_REGISTERING,
> which are not needed anymore (we should you the new flag instead of that).

The only think that I'm confused with is the check in
shrink_slab_memcg, it does:

shrinker = idr_find(&shrinker_idr, i);
if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {

When allocating idr, the shrinker is associated with
SHRINKER_REGISTERING. But, shrink_slab_memcg does acquire read
shrinker_rwsem, and idr_alloc is called with holding write
shrinker_rwsem, so I'm supposed shrink_slab_memcg should never see
shrinker is registering. If so it seems easy to remove
SHRINKER_REGISTERING.

We just need change that check to:
!shrinker || !(shrinker->flags & SHRINKER_REGISTERED)

> >       up_write(&shrinker_rwsem);
> >  }
> >
> > @@ -513,13 +514,17 @@ EXPORT_SYMBOL(register_shrinker);
> >   */
> >  void unregister_shrinker(struct shrinker *shrinker)
> >  {
> > -     if (!shrinker->nr_deferred)
> > -             return;
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             unregister_memcg_shrinker(shrinker);
> >       down_write(&shrinker_rwsem);
>
> I do not think there are some users which registration may race with unregistration.
> So, I think we should check SHRINKER_REGISTERED unlocked similar to we used to check
> shrinker->nr_deferred unlocked.

Yes, I agree.

>
> > +     if (!(shrinker->flags & SHRINKER_REGISTERED)) {
> > +             up_write(&shrinker_rwsem);
> > +             return;
> > +     }
> >       list_del(&shrinker->list);
> > +     shrinker->flags &= ~SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> > +
> > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > +             unregister_memcg_shrinker(shrinker);
> >       kfree(shrinker->nr_deferred);
> >       shrinker->nr_deferred = NULL;
> >  }
> >
>
>
