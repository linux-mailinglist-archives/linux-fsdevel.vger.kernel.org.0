Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84C12DC88B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 22:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgLPV5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 16:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgLPV5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 16:57:16 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F35C061794;
        Wed, 16 Dec 2020 13:56:34 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cm17so26531407edb.4;
        Wed, 16 Dec 2020 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rz3D7Z1Bny17M4DtMxExyzcSYtaGB9n+Fa4koylWtr4=;
        b=NAeLLRXZZ2r+OAiBYybLcvF56hzbt9lWaC7A6YIY0pF30vVqsfQpbM7lFgiAH4gMOU
         6VOnXb/Bvge7/gxVIImSQ/Avdi/XotzW1BlIgR/LUCEFeeuSK93U5O8EeblTSdC5w4x1
         Xt85rAyjeI0niQhN29NU7qEZNg3PcGaRopE+22mXTHfdaOC55YAYFuBm5j396hDtR0Wr
         AjzW/y0yE+/dfmqFZLCJulQXrTwf3GniVdgD6x804G+Earxur7e0Xzp6Cyy910XUFIRV
         2XxkZvqVLWR91gWmkU0gc07r8ehi/eiZUboT1Qt77VEPksJ/LUsPeChTDJtOtCdErTce
         04ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rz3D7Z1Bny17M4DtMxExyzcSYtaGB9n+Fa4koylWtr4=;
        b=NEfoMBQA++dT2nKh0VHCScaVnP4Pudb8ERBiaweqYgo4gCVj6ZB8F5y9bY5o9S0KGM
         //nSKwnHLzJ8GfnZxIUpkWaqPjJsnopGN3+AcjQevUPfNKakEWydQYP/jqzcxBn+7AIB
         aT6JMfdV2/PgqZjGKk7coOq4HGCR1VmuYSze1MgRXtyeICPOCLrPu6dVADvdA8ibo8HF
         Au26RMBeNkysuIqoe71NG5T/zjKxdeW7hSuJT34r67i1cN+FGtWb/QiGqLua1H52Lzke
         253iTXsd6RBV2TO6izDAMLoCa++aEZtGu/JhHCLOV+wILL93Xlng/3bPoAI2TYkH7EPW
         SnDQ==
X-Gm-Message-State: AOAM531e7wu908nugkHBCkovJiKT/AbvF4Yw+4oT5DIaFTmToxjAK+gQ
        XDo/I9+jdKz7xMD+HjohEz906QKp2gLo3mUwg0g=
X-Google-Smtp-Source: ABdhPJz+Fd4iYOKNIJ7kbyJ6dlwoaWHO2UWRVOzEliR8g/MSAsKHDbjj8K79sLAItPEEAQHXSPXJvtnv6hr9B/H1URg=
X-Received: by 2002:a05:6402:746:: with SMTP id p6mr36022194edy.313.1608155792687;
 Wed, 16 Dec 2020 13:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-3-shy828301@gmail.com>
 <20201215020957.GK3913616@dread.disaster.area> <20201215135348.GC379720@cmpxchg.org>
 <20201215215938.GQ3913616@dread.disaster.area> <20201216191204.GA395124@cmpxchg.org>
In-Reply-To: <20201216191204.GA395124@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 16 Dec 2020 13:56:20 -0800
Message-ID: <CAHbLzkp+wNTQQXdOtM20Rk8aLZoomupxyO9gaK3fR-EM9X1a1Q@mail.gmail.com>
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>, Roman Gushchin <guro@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 11:14 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Dec 16, 2020 at 08:59:38AM +1100, Dave Chinner wrote:
> > On Tue, Dec 15, 2020 at 02:53:48PM +0100, Johannes Weiner wrote:
> > > On Tue, Dec 15, 2020 at 01:09:57PM +1100, Dave Chinner wrote:
> > > > On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> > > > > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > > > > exclusively, the read side can be protected by holding read lock, so it sounds
> > > > > superfluous to have a dedicated mutex.
> > > >
> > > > I'm not sure this is a good idea. This couples the shrinker
> > > > infrastructure to internal details of how cgroups are initialised
> > > > and managed. Sure, certain operations might be done in certain
> > > > shrinker lock contexts, but that doesn't mean we should share global
> > > > locks across otherwise independent subsystems....
> > >
> > > They're not independent subsystems. Most of the memory controller is
> > > an extension of core VM operations that is fairly difficult to
> > > understand outside the context of those operations. Then there are a
> > > limited number of entry points from the cgroup interface. We used to
> > > have our own locks for core VM structures (private page lock e.g.) to
> > > coordinate VM and cgroup, and that was mostly unintelligble.
> >
> > Yes, but OTOH you can CONFIG_MEMCG=n and the shrinker infrastructure
> > and shrinkers all still functions correctly.  Ergo, the shrinker
> > infrastructure is independent of memcgs. Yes, it may have functions
> > to iterate and manipulate memcgs, but it is not dependent on memcgs
> > existing for correct behaviour and functionality.
>
> Okay, but now do it the other way round and explain the memcg bits in
> a world where shrinkers don't exist ;-)
>
> Anyway, we seem to be mostly in agreement below.
>
> > > We have since established that those two components coordinate with
> > > native VM locking and lifetime management. If you need to lock the
> > > page, you lock the page - instead of having all VM paths that already
> > > hold the page lock acquire a nested lock to exclude one cgroup path.
> > >
> > > In this case, we have auxiliary shrinker data, subject to shrinker
> > > lifetime and exclusion rules. It's much easier to understand that
> > > cgroup creation needs a stable shrinker list (shrinker_rwsem) to
> > > manage this data, than having an aliased lock that is private to the
> > > memcg callbacks and obscures this real interdependency.
> >
> > Ok, so the way to do this is to move all the stuff that needs to be
> > done under a "subsystem global" lock to the one file, not turn a
> > static lock into a globally visible lock and spray it around random
> > source files.
>
> Sure, that works as well.
>
> > The shrinker map should be generic functionality for all shrinker
> > invocations because even a non-memcg machine can have thousands of
> > registered shrinkers that are mostly idle all the time.
>
> Agreed.
>
> > IOWs, I think the shrinker map management is not really memcg
> > specific - it's just allocation and assignment of a structure, and
> > the only memcg bit is the map is being stored in a memcg structure.
> > Therefore, if we are looking towards tighter integration then we
> > should acutally move the map management to the shrinker code, not
> > split the shrinker infrastructure management across different files.
> > There's already a heap of code in vmscan.c under #ifdef
> > CONFIG_MEMCG, like the prealloc_shrinker() code path:
> >
> > prealloc_shrinker()                           vmscan.c
> >   if (MEMCG_AWARE)                            vmscan.c
> >     prealloc_memcg_shrinker                   vmscan.c
> > #ifdef CONFIG_MEMCG                           vmscan.c
> >       down_write(shrinker_rwsem)              vmscan.c
> >       if (id > shrinker_id_max)                       vmscan.c
> >       memcg_expand_shrinker_maps              memcontrol.c
> >         for_each_memcg                        memcontrol.c
> >           reallocate shrinker map             memcontrol.c
> >           replace shrinker map                memcontrol.c
> >       shrinker_id_max = id                    vmscan.c
> >       down_write(shrinker_rwsem)              vmscan.c
> > #endif
> >
> > And, really, there's very little code in memcg_expand_shrinker_maps()
> > here - the only memcg part is the memcg iteration loop, and we
> > already have them in vmscan.c (e.g. shrink_node_memcgs(),
> > age_active_anon(), drop_slab_node()) so there's precedence for
> > moving this memcg iteration for shrinker map management all into
> > vmscan.c.
> >
> > Doing so would formalise the shrinker maps as first class shrinker
> > infrastructure rather than being tacked on to the side of the memcg
> > infrastructure. At this point it makes total sense to serialise map
> > manipulations under the shrinker_rwsem.
>
> Yes, that's a great idea.
>
> > That is, for the medium term, I think  we should be getting rid of
> > the "legacy" non-memcg shrinker path and everything runs under
> > memcgs.  With this patchset moving all the deferred counts to be
> > memcg aware, the only reason for keeping the non-memcg path around
> > goes away.  If sc->memcg is null, then after this patch set we can
> > simply use the root memcg and just use it's per-node accounting
> > rather than having a separate construct for non-memcg aware per-node
> > accounting.
> >
> > Hence if SHRINKER_MEMCG_AWARE is set, it simply means we should run
> > the shrinker if sc->memcg is set.  There is no difference in setup
> > of shrinkers, the duplicate non-memcg/memcg paths go away, and a
> > heap of code drops out of the shrinker infrastructure. It becomes
> > much simpler overall.
>
> Agreed as well.
>
> > It also means we have a path for further integrating memcg aware
> > shrinkers into the shrinker infrastructure because we can always
> > rely on the shrinker infrastructure being memcg aware. And with that
> > in mind, I think we should probably also be moving the shrinker code
> > out of vmscan.c into it's own file as it's really completely
> > separate infrastructure from the vast majority of page reclaim
> > infrastructure in vmscan.c...
>
> Right again.
>
> > That's the view I'm looking at this patchset from. Not just as a
> > standalone bug fix, but also from the perspective of what the
> > architectural change implies and the directions for tighter
> > integration it opens up for us.
>
> Makes sense, but I'm not sure it's getting in the way of that: a
> generalized first-class map would be managed under the shrinker_rwsem,
> so ditching the private lock is good progress. The widened lock scope
> (temporarily, and still mm/) is easy to reverse later on.
>
> That said, moving the map handling code from memcontrol.c to vmscan.c
> in preparation, and/or even reworking the shrinker around the concept
> of a memcg, indeed are great ideas.
>
> I'd support patches doing that.

Thanks a lot for all the great ideas and suggestions! Per the
discussion I will consolidate all shrinker map related code into
vmscan.c in v3 since the changeset seems manageable and won't get the
patch set bloat.

I will look into further cleanup/refactor for mid/long term once this
patch set is done.
