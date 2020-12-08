Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8D2D30C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 18:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgLHROs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 12:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgLHROs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:14:48 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D5C061749;
        Tue,  8 Dec 2020 09:14:01 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so20708371ljk.1;
        Tue, 08 Dec 2020 09:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUpZuflX/fflZb691Vksxu0oOE9kBri4IqZLX4977hA=;
        b=ToGq7tig3WXqleiJrdh4iBHR1FC6IaIV5nVE+7umT2hPvT2/L0mioUKcxhuREzcubc
         fNewEov5HtB3wzXZ9xfn8yIAVpo5uSg5yydxU4yjXZ5Qi277Q7JSpWOgYm04lq+Mufvl
         +7KtmAqC0hhBoIb/H/vo3iERYAffwTtucJjBrZhOBukoUwG03i2pOI5E9Mv6AY+EsKDy
         fR5D67+ylXTWijkVzFtkrx6T+a5EFezPbK0N4c0MHfYOHaOkftlWByQNY7GOUuUrI2On
         1BObGECZcYeOzN/I6KiHrZnZF89XqbUJw5OF6K/Add2G1uttgzY6IRliPFEvHyEYGt4P
         wsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUpZuflX/fflZb691Vksxu0oOE9kBri4IqZLX4977hA=;
        b=Y+msMn9Hk8M4AjvVNCJ1/47JX/iNhoxhXatTMhormckFME1RbJcQFQeHOg6jgp9WmI
         hDMH3TjtL+qQtVkQo0E+cfQ1N5Hc9y4Ws713Xk5YIbxTGWsiroohDZwyTzQiwQ/+B2BZ
         77R2RRPsATCgUFMRdXWjrIGmuDcKVgWs53xUV2n6CGyUPJa7L4L/9HSAOYVKZXQn15EW
         5PNl+L0BEfxvWHmJTJUxRzPQdE+TTiGWQiR8khjr1qOdsl2mxJHj7bFIoN9VIKXQPl7M
         cwvKX2P8Qq5UOwoBawq4fBmLJVujbkbWmZWOVusEeD7KbHEpv+FG5oah1gIIOQ6+6kcs
         zc5Q==
X-Gm-Message-State: AOAM531S1b4r8kmUU4sp73mWBqX/V3xcmUQpRgzX1i9C5hv+ig7Rj584
        BF9YKu26s/Zp1cllTc4TGUPX/zqnFC7riLt7d7C5ufsDIZ8=
X-Google-Smtp-Source: ABdhPJx1cPCyxZJsBseFknmMFJytItPZ2gixASvcbkTzLl9+dE0kfoov9mNYZGtELWGQz6wvAQTtUcwmHPKF3oFjmg4=
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr3689073ljm.121.1607447640230;
 Tue, 08 Dec 2020 09:14:00 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201202182725.265020-7-shy828301@gmail.com>
 <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com>
In-Reply-To: <49464720-675d-5144-043c-eba6852a9c06@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 8 Dec 2020 09:13:47 -0800
Message-ID: <CAHbLzkoiTmNLXj1Tx0-PggEdcYQ6nj71DUX3ya6mj3VNZ5ho4A@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 3:40 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 02.12.2020 21:27, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 82 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index cba0bc8d4661..d569fdcaba79 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -203,6 +203,12 @@ static DECLARE_RWSEM(shrinker_rwsem);
> >  static DEFINE_IDR(shrinker_idr);
> >  static int shrinker_nr_max;
> >
> > +static inline bool is_deferred_memcg_aware(struct shrinker *shrinker)
> > +{
> > +     return (shrinker->flags & SHRINKER_MEMCG_AWARE) &&
> > +             !mem_cgroup_disabled();
> > +}
> > +
> >  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> >  {
> >       int id, ret = -ENOMEM;
> > @@ -271,7 +277,58 @@ static bool writeback_throttling_sane(struct scan_control *sc)
> >  #endif
> >       return false;
> >  }
> > +
> > +static inline long count_nr_deferred(struct shrinker *shrinker,
> > +                                  struct shrink_control *sc)
> > +{
> > +     bool per_memcg_deferred = is_deferred_memcg_aware(shrinker) && sc->memcg;
> > +     struct memcg_shrinker_deferred *deferred;
> > +     struct mem_cgroup *memcg = sc->memcg;
> > +     int nid = sc->nid;
> > +     int id = shrinker->id;
> > +     long nr;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid = 0;
> > +
> > +     if (per_memcg_deferred) {
> > +             deferred = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_deferred,
> > +                                                  true);
>
> My comment is about both 5/9 and 6/9 patches.

Sorry for the late reply, I don't know why Gmail filtered this out to spam.

>
> shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that you will see
> memcg->nodeinfo[nid]->shrinker_deferred != NULL in count_nr_deferred(). This may occur
> because of processor reordering on !x86 (there is no a common lock or memory barriers).
>
> Regarding to shrinker_map this is not a problem due to map check in shrink_slab_memcg().
> The map can't be NULL there.
>
> Regarding to shrinker_deferred you should prove either this is not a problem too,
> or to add proper synchronization (maybe, based on barriers) or to add some similar check
> (maybe, in shrink_slab_memcg() too).

It seems shrink_slab_memcg() might see shrinker_deferred as NULL
either due to the same reason. I don't think there is a guarantee it
won't happen.

We just need guarantee CSS_ONLINE is seen after shrinker_maps and
shrinker_deferred are allocated, so I'm supposed barriers before
"css->flags |= CSS_ONLINE" should work.

So the below patch may be ok:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index df128cab900f..9f7fb0450d69 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5539,6 +5539,12 @@ static int mem_cgroup_css_online(struct
cgroup_subsys_state *css)
                return -ENOMEM;
        }


+       /*
+        * Barrier for CSS_ONLINE, so that shrink_slab_memcg() sees
shirnker_maps
+        * and shrinker_deferred before CSS_ONLINE.
+        */
+       smp_mb();
+
        /* Online state pins memcg ID, memcg ID pins CSS */
        refcount_set(&memcg->id.ref, 1);
        css_get(css);


Or add one more check for shrinker_deferred sounds acceptable as well.

> Kirill
>
