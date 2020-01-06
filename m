Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB2130AD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2020 01:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAFARZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 19:17:25 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:49520 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbgAFARZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 19:17:25 -0500
Received: from dread.disaster.area (pa49-180-68-255.pa.nsw.optusnet.com.au [49.180.68.255])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2E04D3A17EB;
        Mon,  6 Jan 2020 11:17:16 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ioG53-0006nK-5Q; Mon, 06 Jan 2020 11:17:13 +1100
Date:   Mon, 6 Jan 2020 11:17:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2 4/5] mm: make memcg visible to lru walker isolation
 function
Message-ID: <20200106001713.GH23195@dread.disaster.area>
References: <1577174006-13025-1-git-send-email-laoar.shao@gmail.com>
 <1577174006-13025-5-git-send-email-laoar.shao@gmail.com>
 <20200104033558.GD23195@dread.disaster.area>
 <CALOAHbAzDth8g8+Z5hH9QnOp02UZ5+3eQf9wAQyJM-LAhmaL9A@mail.gmail.com>
 <20200104212331.GG23195@dread.disaster.area>
 <CALOAHbBGRSfRTH7RYXfgAqtixuYvu=tRrr7zQyAvofrzktW=vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBGRSfRTH7RYXfgAqtixuYvu=tRrr7zQyAvofrzktW=vA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=sbdTpStuSq8iNQE8viVliQ==:117 a=sbdTpStuSq8iNQE8viVliQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=goTDY2tyzamFREBFo-IA:9
        a=CzQD0rvJj-p5qLdI:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 05, 2020 at 09:43:11AM +0800, Yafang Shao wrote:
> On Sun, Jan 5, 2020 at 5:23 AM Dave Chinner <david@fromorbit.com> wrote:
> > On Sat, Jan 04, 2020 at 03:26:13PM +0800, Yafang Shao wrote:
> > > On Sat, Jan 4, 2020 at 11:36 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Tue, Dec 24, 2019 at 02:53:25AM -0500, Yafang Shao wrote:
> > > > > The lru walker isolation function may use this memcg to do something, e.g.
> > > > > the inode isolatation function will use the memcg to do inode protection in
> > > > > followup patch. So make memcg visible to the lru walker isolation function.
> > > > >
> > > > > Something should be emphasized in this patch is it replaces
> > > > > for_each_memcg_cache_index() with for_each_mem_cgroup() in
> > > > > list_lru_walk_node(). Because there's a gap between these two MACROs that
> > > > > for_each_mem_cgroup() depends on CONFIG_MEMCG while the other one depends
> > > > > on CONFIG_MEMCG_KMEM. But as list_lru_memcg_aware() returns false if
> > > > > CONFIG_MEMCG_KMEM is not configured, it is safe to this replacement.
> > > > >
> > > > > Cc: Dave Chinner <dchinner@redhat.com>
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > >
> > > > ....
> > > >
> > > > > @@ -299,17 +299,15 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> > > > >                                list_lru_walk_cb isolate, void *cb_arg,
> > > > >                                unsigned long *nr_to_walk)
> > > > >  {
> > > > > +     struct mem_cgroup *memcg;
> > > > >       long isolated = 0;
> > > > > -     int memcg_idx;
> > > > >
> > > > > -     isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> > > > > -                                   nr_to_walk);
> > > > > -     if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> > > > > -             for_each_memcg_cache_index(memcg_idx) {
> > > > > +     if (list_lru_memcg_aware(lru)) {
> > > > > +             for_each_mem_cgroup(memcg) {
> > > > >                       struct list_lru_node *nlru = &lru->node[nid];
> > > > >
> > > > >                       spin_lock(&nlru->lock);
> > > > > -                     isolated += __list_lru_walk_one(nlru, memcg_idx,
> > > > > +                     isolated += __list_lru_walk_one(nlru, memcg,
> > > > >                                                       isolate, cb_arg,
> > > > >                                                       nr_to_walk);
> > > > >                       spin_unlock(&nlru->lock);
> > > > > @@ -317,7 +315,11 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
> > > > >                       if (*nr_to_walk <= 0)
> > > > >                               break;
> > > > >               }
> > > > > +     } else {
> > > > > +             isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
> > > > > +                                           nr_to_walk);
> > > > >       }
> > > > > +
> > > >
> > > > That's a change of behaviour. The old code always runs per-node
> > > > reclaim, then if the LRU is memcg aware it also runs the memcg
> > > > aware reclaim. The new code never runs global per-node reclaim
> > > > if the list is memcg aware, so shrinkers that are initialised
> > > > with the flags SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE seem
> > > > likely to have reclaim problems with mixed memcg/global memory
> > > > pressure scenarios.
> > > >
> > > > e.g. if all the memory is in the per-node lists, and the memcg needs
> > > > to reclaim memory because of a global shortage, it is now unable to
> > > > reclaim global memory.....
> > > >
> > >
> > > Hi Dave,
> > >
> > > Thanks for your detailed explanation.
> > > But I have different understanding.
> > > The difference between for_each_mem_cgroup(memcg) and
> > > for_each_memcg_cache_index(memcg_idx) is that the
> > > for_each_mem_cgroup() includes the root_mem_cgroup while the
> > > for_each_memcg_cache_index() excludes the root_mem_cgroup because the
> > > memcg_idx of it is -1.
> >
> > Except that the "root" memcg that for_each_mem_cgroup() is not the
> > "global root" memcg - it is whatever memcg that is passed down in
> > the shrink_control, whereever that sits in the cgroup tree heirarchy.
> > do_shrink_slab() only ever passes down the global root memcg to the
> > shrinkers when the global root memcg is passed to shrink_slab(), and
> > that does not iterate the memcg heirarchy - it just wants to
> > reclaim from global caches an non-memcg aware shrinkers.
> >
> > IOWs, there are multiple changes in behaviour here - memcg specific
> > reclaim won't do global reclaim, and global reclaim will now iterate
> > all memcgs instead of just the global root memcg.
> >
> > > So it can reclaim global memory even if the list is memcg aware.
> > > Is that right ?
> >
> > If the memcg passed to this fucntion is the root memcg, then yes,
> > it will behave as you suggest. But for the majority of memcg-context
> > reclaim, the memcg is not the root memcg and so they will not do
> > global reclaim anymore...
> >
> 
> Thanks for you reply.
> But I have to clairfy that this change is in list_lru_walk_node(), and
> the memcg is not passed to this funtion from shrink_control.
> In order to make it more clear, I paste the function here.
> 
> - The new function
> unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>                                  list_lru_walk_cb isolate, void *cb_arg,
>                                  unsigned long *nr_to_walk)
> {
>         struct mem_cgroup *memcg;   <<<< A local variable
>         long isolated = 0;
> 
>         if (list_lru_memcg_aware(lru)) {
>                 for_each_mem_cgroup(memcg) {  <<<<  scan all MEMCGs,
> including root_mem_cgroup

Oh, wait, this is list_lru_walk_node(), which is not even called by
the shrinker code - this is the "iterate every object" code
path. So this isn't even part of the code path this patchset needs
the memcg for.

<does some code spelunking>

Gawd, what a mess this memcg stuff is from when you look from the
outside. After digging, I find that the root memcg has a kmemcg_id =
-1. There is special case code everywhere that checks the id for >=
0, open codes memcg == root_mem_cgroup checks, calls
mem_cgroup_is_root(), etc to avoid doing things like using the root
memcg kmemcg_id as an array index. An in the case of the list_lru,
this means it doesn't use the memcg lru indexes at all (i.e.
lru->node[nid].memcg_lrus[memcg_idx], but quietly returns the global
list at lru->node[nid].lru when kmemcg_id < 0.

So, after a couple of hours of wading through the code, I finally
remember all the details of the existing code and understand how
this new code works - it relies entirely on the special casing of
the root memcg that makes it behave like memcgs aren't configured at
all. i.e. we select the global root lists when the root memcg is
passed around rather than using a memcg specific LRU list.

The old code used for_each_memcg_cache_index(), which never
scanned the root memcg:

#define for_each_memcg_cache_index(_idx)        \
        for ((_idx) = 0; (_idx) < memcg_nr_cache_ids; (_idx)++)

because it starts at idx = 0, and the root memcg is -1. Hence the
old code always needed to scan the root memcg (the global lists)
manually itself, which made the code really nice and clear because
it was the same for both non-memcg and memcg aware lists. i.e. the
global scan was not hidden away inside the memcg scanning.

IOWs, I find the existing code is much easier to see the difference
between global and per-memcg iteration. IF we are keeping this
special "root memcg context is special" architecture (more on that
below), I'd prefer that the code keeps that distinction, because
having to understand how the root memcg is special cased just to
work out how this code iterates the global caches is a waste of time
and brain power. not every one really wants to know about memcg
internals....

We can clean up the code a lot by getting rid of the unnecessary
indenting by doing this:

	/* iterate the global lru first */
	isolated = list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
					nr_to_walk);
	if (!list_lru_memcg_aware(lru))
		return isolated;

	nlru = &lru->node[nid];
	for_each_mem_cgroup(memcg) {
		/* already scanned the root memcg above */
		if (is_root_memcg(memcg))
			continue;
		if (*nr_to_walk <= 0)
			break;
		spin_lock(&nlru->lock);
		isolated += __list_lru_walk_one(nlru, memcg,
						isolate, cb_arg,
						nr_to_walk);
		spin_unlock(&nlru->lock);
	}
	return isolated;


And so to architecture... This all makes me wonder why we still
special case the memcg LRU lists here. Ever since we went to
per-node memcg lru lists (~2015, iirc), there's been this special
hidden hack for the root memcg to use the global list. and one that
I have to read lots of code to remind myself it exists every time I
have to did into this code again.

I mean, if the list is not memcg aware, then it only needs a single
list per node - the root memcg list. That could be easily stored in
the memcg_lrus array for the node rather than a separate global
list, and then the node iteration code all starts to look like this:

	nlru = &lru->node[nid];
	for_each_mem_cgroup(memcg) {
		spin_lock(&nlru->lock);
		isolated += __list_lru_walk_one(nlru, memcg,
						isolate, cb_arg,
						nr_to_walk);
		spin_unlock(&nlru->lock);
		if (*nr_to_walk <= 0)
			break;

		/* non-memcg aware lists only have a root memcg list */
		if (!list_lru_memcg_aware(lru))
			break;
	}

Hence for the walks in the !list_lru_memcg_aware(lru) case, the
list_lru_from_memcg() call in __list_lru_walk_one() always returns
just the root list. This makes everything use the same iteration
interface, and when you configure out memcg then we simply code the
the iterator to run once and list_lru_from_memcg() always returns
the one list...

i.e. the whole reason for having the separate global and per-memcg
LRU lists went away back in 2015 when it was decided that we don't
care about the (potentially massive) memory usage of per-node memcg
LRU lists. However, the special casing of the root memcg was left in
place, but what your patch says to me is that we should really be
trying to make this special casing go away.

Moving everything in the list-lru to the memcg_lrus also means that
the global shrinker lists get the "objects in the lru to scan for
reclaim" shrinker bitmaps that optimise the high level shrinker
code. It means we could get rid of the separate global vs memcg
shrinker paths in vmscan.c - we just pass the root memcg into
shrink_slab_memcg() when we want to do global shrinker reclaim...

IMO, if memcgs are fundamental to the operation of systems these
days such that there the root memcg is treated no differently to all
other memcgs, then let's architect the whole stack that way, not
just make the code hard to read by having little bits of code hide
the special casing of the root memcg layers deep where it's raelly
hard to find....

And, FWIW, I noticed that the list_lru memcg code assumes we only
ever put objects from memcg associated slab pages in the list_lru.
It calls memcg_from_slab_page() which makes no attempt to verify the
page is actually a slab page. That's a landmine just waiting to get
boom - list-lru can store any type of object the user wants, not
just slab pages. e.g. the binder code stores pages in the list-lru,
not slab objects, and so the only reason it doesn't go boom is that
the lru-list is not configured to be memcg aware....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
