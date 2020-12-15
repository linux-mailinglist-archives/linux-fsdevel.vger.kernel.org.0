Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408832DB633
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgLOWAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 17:00:46 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:37543 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbgLOWAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:00:31 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 462641AC3A3;
        Wed, 16 Dec 2020 08:59:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kpIM6-004M4N-M4; Wed, 16 Dec 2020 08:59:38 +1100
Date:   Wed, 16 Dec 2020 08:59:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
Message-ID: <20201215215938.GQ3913616@dread.disaster.area>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-3-shy828301@gmail.com>
 <20201215020957.GK3913616@dread.disaster.area>
 <20201215135348.GC379720@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215135348.GC379720@cmpxchg.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=lEa4DKvhuYFUtTyFDrcA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 02:53:48PM +0100, Johannes Weiner wrote:
> On Tue, Dec 15, 2020 at 01:09:57PM +1100, Dave Chinner wrote:
> > On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> > > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > > exclusively, the read side can be protected by holding read lock, so it sounds
> > > superfluous to have a dedicated mutex.
> > 
> > I'm not sure this is a good idea. This couples the shrinker
> > infrastructure to internal details of how cgroups are initialised
> > and managed. Sure, certain operations might be done in certain
> > shrinker lock contexts, but that doesn't mean we should share global
> > locks across otherwise independent subsystems....
> 
> They're not independent subsystems. Most of the memory controller is
> an extension of core VM operations that is fairly difficult to
> understand outside the context of those operations. Then there are a
> limited number of entry points from the cgroup interface. We used to
> have our own locks for core VM structures (private page lock e.g.) to
> coordinate VM and cgroup, and that was mostly unintelligble.

Yes, but OTOH you can CONFIG_MEMCG=n and the shrinker infrastructure
and shrinkers all still functions correctly.  Ergo, the shrinker
infrastructure is independent of memcgs. Yes, it may have functions
to iterate and manipulate memcgs, but it is not dependent on memcgs
existing for correct behaviour and functionality.

Yet.

> We have since established that those two components coordinate with
> native VM locking and lifetime management. If you need to lock the
> page, you lock the page - instead of having all VM paths that already
> hold the page lock acquire a nested lock to exclude one cgroup path.
> 
> In this case, we have auxiliary shrinker data, subject to shrinker
> lifetime and exclusion rules. It's much easier to understand that
> cgroup creation needs a stable shrinker list (shrinker_rwsem) to
> manage this data, than having an aliased lock that is private to the
> memcg callbacks and obscures this real interdependency.

Ok, so the way to do this is to move all the stuff that needs to be
done under a "subsystem global" lock to the one file, not turn a
static lock into a globally visible lock and spray it around random
source files. There's already way too many static globals to manage
separate shrinker and memcg state..

I certainly agree that shrinkers and memcg need to be more closely
integrated.  I've only been saying that for ... well, since memcgs
essentially duplicated the top level shrinker path so the shrinker
map could be introduced to avoid calling shrinkers that have no work
to do for memcgs. The shrinker map should be generic functionality
for all shrinker invocations because even a non-memcg machine can
have thousands of registered shrinkers that are mostly idle all the
time.

IOWs, I think the shrinker map management is not really memcg
specific - it's just allocation and assignment of a structure, and
the only memcg bit is the map is being stored in a memcg structure.
Therefore, if we are looking towards tighter integration then we
should acutally move the map management to the shrinker code, not
split the shrinker infrastructure management across different files.
There's already a heap of code in vmscan.c under #ifdef
CONFIG_MEMCG, like the prealloc_shrinker() code path:

prealloc_shrinker()				vmscan.c
  if (MEMCG_AWARE)				vmscan.c
    prealloc_memcg_shrinker			vmscan.c
#ifdef CONFIG_MEMCG				vmscan.c
      down_write(shrinker_rwsem)		vmscan.c
      if (id > shrinker_id_max)			vmscan.c
	memcg_expand_shrinker_maps		memcontrol.c
	  for_each_memcg			memcontrol.c
	    reallocate shrinker map		memcontrol.c
	    replace shrinker map		memcontrol.c
	shrinker_id_max = id			vmscan.c
      down_write(shrinker_rwsem)		vmscan.c
#endif

And, really, there's very little code in memcg_expand_shrinker_maps()
here - the only memcg part is the memcg iteration loop, and we
already have them in vmscan.c (e.g. shrink_node_memcgs(),
age_active_anon(), drop_slab_node()) so there's precedence for
moving this memcg iteration for shrinker map management all into
vmscan.c.

Doing so would formalise the shrinker maps as first class shrinker
infrastructure rather than being tacked on to the side of the memcg
infrastructure. At this point it makes total sense to serialise map
manipulations under the shrinker_rwsem.

IOWs, I'm not disagreeing with the direction this patch takes us in,
I'm disagreeing with the implementation as published in the patch
because it doesn't move us closer to a clean, concise single
shrinker infrastructure implementation.

That is, for the medium term, I think  we should be getting rid of
the "legacy" non-memcg shrinker path and everything runs under
memcgs.  With this patchset moving all the deferred counts to be
memcg aware, the only reason for keeping the non-memcg path around
goes away.  If sc->memcg is null, then after this patch set we can
simply use the root memcg and just use it's per-node accounting
rather than having a separate construct for non-memcg aware per-node
accounting.

Hence if SHRINKER_MEMCG_AWARE is set, it simply means we should run
the shrinker if sc->memcg is set.  There is no difference in setup
of shrinkers, the duplicate non-memcg/memcg paths go away, and a
heap of code drops out of the shrinker infrastructure. It becomes
much simpler overall.

It also means we have a path for further integrating memcg aware
shrinkers into the shrinker infrastructure because we can always
rely on the shrinker infrastructure being memcg aware. And with that
in mind, I think we should probably also be moving the shrinker code
out of vmscan.c into it's own file as it's really completely
separate infrastructure from the vast majority of page reclaim
infrastructure in vmscan.c...

That's the view I'm looking at this patchset from. Not just as a
standalone bug fix, but also from the perspective of what the
architectural change implies and the directions for tighter
integration it opens up for us.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
