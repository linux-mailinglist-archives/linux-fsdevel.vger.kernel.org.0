Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD0A302DA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 22:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbhAYVTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 16:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732535AbhAYVSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:18:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEC2C061794;
        Mon, 25 Jan 2021 13:17:00 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id 6so20125837ejz.5;
        Mon, 25 Jan 2021 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dwqXqhjQ8zEPnFxA0A+0bd5DdgcE17BPfbHWcB0f6ys=;
        b=LCDRx6bSq74Was2Bk6Rk2Ikl1TrmFK4GgYZmZWa1RnXfjayQ9/xUkjDED948ynxDzC
         kUF/kr10hC8z6CHGku4M8tL457UUGkyF3o0YwfLVWCe9kgS9RofDeCz6kzZ06zXTWeYy
         O5ZcScxT4zg97Sj8uuaaYBKEuNYdCYCPrTw9dYHH533JRAA9Hs3MWN6w4VLZ7IGWSwja
         SlxHzzi7YgEJFSiMNgH7/NhbbTVISHYUyQwzpW1QqnuWNmOZIaZk8+mIEaSN8I+mTTWz
         t23sSioUtO6zgufuNvSr4McT27eZBV9GNQ7UuC+cprAWf2P6BbJxxHL33MJJ/UYxDjfg
         maZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dwqXqhjQ8zEPnFxA0A+0bd5DdgcE17BPfbHWcB0f6ys=;
        b=NDtiP5nBF+wp9Vkjn7j4F/X9Iw8F8puMiviI9uP39J6T7Jcc+j7mi2f4m/rfRbcztg
         7DJxjFin6d/NgI9lp66nGO3OPQli4tU/LpR2rBK4xllL/zByRXMyL9KLZWoo3lpKRPBl
         TdU+raAe05cAHuw8k8XrbelWMq+AYpt/zdUrX+wCPCe7kic9Zpj9xldcJWZsP3d8CDQF
         u659HCWr1g+Vp49Qq/bgpo90OA9PYUdaE8xHvrx75oniN+Qv6rU23EUO+jnZi/cqe/Y1
         t3g9O3k9Ce8t4tjDY1yn2G5u793hoXt64k/cw9doQBLg1JtTnJr9afzo4Hvqrg9kqJOb
         JIyQ==
X-Gm-Message-State: AOAM5306NMvIcRdHCtWcPDIggrFgRVmM3cFKwqQQvkm8bPrBztjvSp6a
        fSDJXWd+CTgQEU2dJFM1ULfyy8Iz4DPrhDOw1z8=
X-Google-Smtp-Source: ABdhPJx0r28g69ouyKcK0BLxv3/RM/72ferKw/WSDH564mxsmHe0pp/HLAUOb2MwZrvrJwVdkIvPvDsE1mZCEB55lnc=
X-Received: by 2002:a17:906:e42:: with SMTP id q2mr1544379eji.25.1611609418997;
 Mon, 25 Jan 2021 13:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20210121230621.654304-1-shy828301@gmail.com> <20210121230621.654304-9-shy828301@gmail.com>
 <bbfaaf59-ad56-81ef-347b-92003b8cbebe@virtuozzo.com>
In-Reply-To: <bbfaaf59-ad56-81ef-347b-92003b8cbebe@virtuozzo.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 25 Jan 2021 13:16:47 -0800
Message-ID: <CAHbLzkoHSxZp0e6-xnOUdexXVmb5ORwQnjVugy9pEtwLuyAihg@mail.gmail.com>
Subject: Re: [v4 PATCH 08/11] mm: vmscan: use per memcg nr_deferred of shrinker
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 1:35 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 22.01.2021 02:06, Yang Shi wrote:
> > Use per memcg's nr_deferred for memcg aware shrinkers.  The shrinker's =
nr_deferred
> > will be used in the following cases:
> >     1. Non memcg aware shrinkers
> >     2. !CONFIG_MEMCG
> >     3. memcg is disabled by boot parameter
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/vmscan.c | 81 +++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 69 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 722aa71b13b2..d8e77ea13815 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -359,6 +359,27 @@ static void unregister_memcg_shrinker(struct shrin=
ker *shrinker)
> >       up_write(&shrinker_rwsem);
> >  }
> >
> > +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker=
,
> > +                                 struct mem_cgroup *memcg)
> > +{
> > +     struct shrinker_info *info;
> > +
> > +     info =3D rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker=
_info,
> > +                                      true);
>
> Since now these rcu_dereference_protected() are in separate functions and=
 there is
> no taking a lock near them, it seems it would be better to underling the =
desired
> lock with rcu_dereference_protected(, lockdep_assert_held(lock_you_need_h=
ere_locked));

Sure. Will incorporate in v5. BTW I noticed using
lockdep_assert_held() in the parameter of the functions will result in
compilation failure with gcc 10.0.1 (shipped with Fedora 32), but fine
with gcc 8.3.1.

In file included from ./include/linux/rbtree.h:22,
                 from ./include/linux/mm_types.h:10,
                 from ./include/linux/mmzone.h:21,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/mm.h:10,
                 from mm/vmscan.c:15:
mm/vmscan.c: In function =E2=80=98shrinker_info_protected=E2=80=99:
./include/linux/lockdep.h:386:34: error: expected expression before =E2=80=
=98do=E2=80=99
  386 | #define lockdep_assert_held(l)   do { (void)(l); } while (0)
      |                                  ^~
./include/linux/rcupdate.h:337:52: note: in definition of macro
=E2=80=98RCU_LOCKDEP_WARN=E2=80=99
  337 | #define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
      |                                                    ^
./include/linux/rcupdate.h:554:2: note: in expansion of macro
=E2=80=98__rcu_dereference_protected=E2=80=99
  554 |  __rcu_dereference_protected((p), (c), __rcu)
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmscan.c:389:9: note: in expansion of macro =E2=80=98rcu_dereference_pro=
tected=E2=80=99
  389 |  return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_in=
fo,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~
mm/vmscan.c:390:7: note: in expansion of macro =E2=80=98lockdep_assert_held=
=E2=80=99
  390 |       lockdep_assert_held(&shrinker_rwsem));
      |       ^~~~~~~~~~~~~~~~~~~


I didn't dig into the root cause. Just use lockdep_is_held() instead
of lockdep_assert_held().

>
>
> > +     return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
> > +}
> > +
> > +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *s=
hrinker,
> > +                               struct mem_cgroup *memcg)
> > +{
> > +     struct shrinker_info *info;
> > +
> > +     info =3D rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker=
_info,
> > +                                      true);
> > +
> > +     return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id=
]);
> > +}
> > +
> >  static bool cgroup_reclaim(struct scan_control *sc)
> >  {
> >       return sc->target_mem_cgroup;
> > @@ -397,6 +418,18 @@ static void unregister_memcg_shrinker(struct shrin=
ker *shrinker)
> >  {
> >  }
> >
> > +static long count_nr_deferred_memcg(int nid, struct shrinker *shrinker=
,
> > +                                 struct mem_cgroup *memcg)
> > +{
> > +     return 0;
> > +}
> > +
> > +static long set_nr_deferred_memcg(long nr, int nid, struct shrinker *s=
hrinker,
> > +                               struct mem_cgroup *memcg)
> > +{
> > +     return 0;
> > +}
> > +
> >  static bool cgroup_reclaim(struct scan_control *sc)
> >  {
> >       return false;
> > @@ -408,6 +441,39 @@ static bool writeback_throttling_sane(struct scan_=
control *sc)
> >  }
> >  #endif
> >
> > +static long count_nr_deferred(struct shrinker *shrinker,
> > +                           struct shrink_control *sc)
> > +{
> > +     int nid =3D sc->nid;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid =3D 0;
> > +
> > +     if (sc->memcg &&
> > +         (shrinker->flags & SHRINKER_MEMCG_AWARE))
> > +             return count_nr_deferred_memcg(nid, shrinker,
> > +                                            sc->memcg);
> > +
> > +     return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +}
> > +
> > +
> > +static long set_nr_deferred(long nr, struct shrinker *shrinker,
> > +                         struct shrink_control *sc)
> > +{
> > +     int nid =3D sc->nid;
> > +
> > +     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > +             nid =3D 0;
> > +
> > +     if (sc->memcg &&
> > +         (shrinker->flags & SHRINKER_MEMCG_AWARE))
> > +             return set_nr_deferred_memcg(nr, nid, shrinker,
> > +                                          sc->memcg);
> > +
> > +     return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
> > +}
> > +
> >  /*
> >   * This misses isolated pages which are not accounted for to save coun=
ters.
> >   * As the data only determines if reclaim or compaction continues, it =
is
> > @@ -544,14 +610,10 @@ static unsigned long do_shrink_slab(struct shrink=
_control *shrinkctl,
> >       long freeable;
> >       long nr;
> >       long new_nr;
> > -     int nid =3D shrinkctl->nid;
> >       long batch_size =3D shrinker->batch ? shrinker->batch
> >                                         : SHRINK_BATCH;
> >       long scanned =3D 0, next_deferred;
> >
> > -     if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> > -             nid =3D 0;
> > -
> >       freeable =3D shrinker->count_objects(shrinker, shrinkctl);
> >       if (freeable =3D=3D 0 || freeable =3D=3D SHRINK_EMPTY)
> >               return freeable;
> > @@ -561,7 +623,7 @@ static unsigned long do_shrink_slab(struct shrink_c=
ontrol *shrinkctl,
> >        * and zero it so that other concurrent shrinker invocations
> >        * don't also do this scanning work.
> >        */
> > -     nr =3D atomic_long_xchg(&shrinker->nr_deferred[nid], 0);
> > +     nr =3D count_nr_deferred(shrinker, shrinkctl);
> >
> >       total_scan =3D nr;
> >       if (shrinker->seeks) {
> > @@ -652,14 +714,9 @@ static unsigned long do_shrink_slab(struct shrink_=
control *shrinkctl,
> >               next_deferred =3D 0;
> >       /*
> >        * move the unused scan count back into the shrinker in a
> > -      * manner that handles concurrent updates. If we exhausted the
> > -      * scan, there is no need to do an update.
> > +      * manner that handles concurrent updates.
> >        */
> > -     if (next_deferred > 0)
> > -             new_nr =3D atomic_long_add_return(next_deferred,
> > -                                             &shrinker->nr_deferred[ni=
d]);
> > -     else
> > -             new_nr =3D atomic_long_read(&shrinker->nr_deferred[nid]);
> > +     new_nr =3D set_nr_deferred(next_deferred, shrinker, shrinkctl);
> >
> >       trace_mm_shrink_slab_end(shrinker, shrinkctl->nid, freed, nr, new=
_nr, total_scan);
> >       return freed;
> >
>
>
