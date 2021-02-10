Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFADA316F33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 19:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhBJSur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 13:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhBJSsk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:48:40 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A5CC06178C;
        Wed, 10 Feb 2021 10:45:57 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id t5so4190653eds.12;
        Wed, 10 Feb 2021 10:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSwRklUKEgerO/ruJtc6qqr8RfBeesHl4VyXwtXPq+s=;
        b=Ghey7JkDfj7BDM2QOpDU7sxDB95ZxYv6chQC2f5IfAnzRVsCaEcRyKJsBLtQM6v8Ew
         dOzHFVagORKvEpNJM/t0vzv9CO3yTsBuTm5e/yQPILsWDan17pfpLiwC+q1+AUZslfD0
         W0gF7/Ora4jXcRecqWBrkpX4QKSoY1E2DM2CmVuoSUQ+eq+Z8adbXcMwJKcDzYukOmOm
         ZLD+CfyFe2JtlPPTH6ZcoUI+7UQvNdFcpHmBNEPiVmahFXd8wA0ygc+50zBiR1yjIpuO
         a5Iy/FoT8KLw5glqNS3wJzfYMscMlWpVDxPbcjNVN6+vWak//beFuvNl4euYiyFNGkgg
         qNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSwRklUKEgerO/ruJtc6qqr8RfBeesHl4VyXwtXPq+s=;
        b=jM8b/G7/M/ERUrSr3oyK/laYmyTKV2F1R8JN1cvKeja8Tn5pq3GFqo5IH5gtepYqUD
         K607vY4q61vd60enYGxCqfKWgYFr2ywLHbQKTSp8bisKIwLQVRRBMDW9U5qgVjC0pPth
         YwON+QyC6Ko4q4sEEI5YFVL8b4nvGbTYJ34L1lJqZ5dxm96JkJ7O6bGoUO3IeAXMIvRp
         d506atkIfAEKJ5fpK0ciSssfMRQGZh1vl/URZ4tcVCPCP1Uv6af+LK+IfdrWI20flMhZ
         OskFC0wvY1/lkXloUI1iqxxT31vZiwv4FxJQz7G8ytWE8fRT1M0jNbR5L9ESY8KfmmnF
         BpMA==
X-Gm-Message-State: AOAM532ar7bIC49ucrJsNGrVJ1L+xvZE6u9ayTi5sI0wgIX8WkeNDyxj
        9xOwBFG2MI5YzFNDhLO20Fc1NxWopforGGeHmKY=
X-Google-Smtp-Source: ABdhPJyLpbdb7DJiKsbSwvNmBlEpo5PXtG3A6Ujq1MjCd5prIOyDPwfzC/l21m4dy9YDaZIgJgadqTvRJE4+yZkEAM8=
X-Received: by 2002:aa7:c804:: with SMTP id a4mr4465864edt.168.1612982756190;
 Wed, 10 Feb 2021 10:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-8-shy828301@gmail.com>
 <20210210003943.GK524633@carbon.DHCP.thefacebook.com>
In-Reply-To: <20210210003943.GK524633@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Feb 2021 10:45:44 -0800
Message-ID: <CAHbLzkpvzt=zwvSfGY2qXWmhLCY2WiRrbVFvj8J3vEq=x=54CA@mail.gmail.com>
Subject: Re: [v7 PATCH 07/12] mm: vmscan: use a new flag to indicate shrinker
 is registered
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

On Tue, Feb 9, 2021 at 4:39 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Feb 09, 2021 at 09:46:41AM -0800, Yang Shi wrote:
> > Currently registered shrinker is indicated by non-NULL shrinker->nr_deferred.
> > This approach is fine with nr_deferred at the shrinker level, but the following
> > patches will move MEMCG_AWARE shrinkers' nr_deferred to memcg level, so their
> > shrinker->nr_deferred would always be NULL.  This would prevent the shrinkers
> > from unregistering correctly.
> >
> > Remove SHRINKER_REGISTERING since we could check if shrinker is registered
> > successfully by the new flag.
> >
> > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/shrinker.h |  7 ++++---
> >  mm/vmscan.c              | 31 +++++++++----------------------
> >  2 files changed, 13 insertions(+), 25 deletions(-)
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
> > index 273efbf4d53c..a047980536cf 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -315,19 +315,6 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
> >       }
> >  }
> >
> > -/*
> > - * We allow subsystems to populate their shrinker-related
> > - * LRU lists before register_shrinker_prepared() is called
> > - * for the shrinker, since we don't want to impose
> > - * restrictions on their internal registration order.
> > - * In this case shrink_slab_memcg() may find corresponding
> > - * bit is set in the shrinkers map.
> > - *
> > - * This value is used by the function to detect registering
> > - * shrinkers and to skip do_shrink_slab() calls for them.
> > - */
> > -#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
> > -
> >  static DEFINE_IDR(shrinker_idr);
> >
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> > @@ -336,7 +323,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >
> >       down_write(&shrinker_rwsem);
> >       /* This may call shrinker, so it must use down_read_trylock() */
> > -     id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
> > +     id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> >       if (id < 0)
> >               goto unlock;
> >
> > @@ -499,10 +486,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
> >  {
> >       down_write(&shrinker_rwsem);
> >       list_add_tail(&shrinker->list, &shrinker_list);
> > -#ifdef CONFIG_MEMCG
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             idr_replace(&shrinker_idr, shrinker, shrinker->id);
> > -#endif
> > +     shrinker->flags |= SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > @@ -522,13 +506,16 @@ EXPORT_SYMBOL(register_shrinker);
> >   */
> >  void unregister_shrinker(struct shrinker *shrinker)
> >  {
> > -     if (!shrinker->nr_deferred)
> > +     if (!(shrinker->flags & SHRINKER_REGISTERED))
> >               return;
> > -     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > -             unregister_memcg_shrinker(shrinker);
> > +
> >       down_write(&shrinker_rwsem);
> >       list_del(&shrinker->list);
> > +     shrinker->flags &= ~SHRINKER_REGISTERED;
> >       up_write(&shrinker_rwsem);
> > +
> > +     if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > +             unregister_memcg_shrinker(shrinker);
>
> Because unregister_memcg_shrinker() will take and release shrinker_rwsem once again,
> I wonder if it's better to move it into the locked section and change the calling
> convention to require the caller to take the semaphore?

BTW, I think lockdep_assert_held() in unregister_memcg_shrinker()
seems good enough.

>
> >       kfree(shrinkrem->nr_deferred);
> >       shrinker->nr_deferred = NULL;
> >  }
> > @@ -693,7 +680,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> >               struct shrinker *shrinker;
> >
> >               shrinker = idr_find(&shrinker_idr, i);
> > -             if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
> > +             if (unlikely(!shrinker || !(shrinker->flags & SHRINKER_REGISTERED))) {
> >                       if (!shrinker)
> >                               clear_bit(i, info->map);
> >                       continue;
> > --
> > 2.26.2
> >
