Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F769370FEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhEBX7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 19:59:42 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:51896 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbhEBX7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 19:59:41 -0400
Received: from dread.disaster.area (pa49-179-143-157.pa.nsw.optusnet.com.au [49.179.143.157])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 15E8E80BF85;
        Mon,  3 May 2021 09:58:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ldLz1-000fG8-Ou; Mon, 03 May 2021 09:58:43 +1000
Date:   Mon, 3 May 2021 09:58:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [External] Re: [PATCH 0/9] Shrink the list lru size on memory
 cgroup removal
Message-ID: <20210502235843.GJ1872259@dread.disaster.area>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area>
 <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
 <20210430032739.GG1872259@dread.disaster.area>
 <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=I9rzhn+0hBG9LkCzAun3+g==:117 a=I9rzhn+0hBG9LkCzAun3+g==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=HzlZ7A7n1z-OYlPo8Y0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 04:32:39PM +0800, Muchun Song wrote:
> On Fri, Apr 30, 2021 at 11:27 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Apr 29, 2021 at 06:39:40PM -0700, Roman Gushchin wrote:
> > > On Fri, Apr 30, 2021 at 10:49:03AM +1000, Dave Chinner wrote:
> > > > On Wed, Apr 28, 2021 at 05:49:40PM +0800, Muchun Song wrote:
> > > > > In our server, we found a suspected memory leak problem. The kmalloc-32
> > > > > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > > > > memory.
> > > > >
> > > > > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > > > > cache is the cause of list_lru_one allocation.
> > > > >
> > > > >   crash> p memcg_nr_cache_ids
> > > > >   memcg_nr_cache_ids = $2 = 24574
> > > > >
> > > > > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > > > > can be calculated with the following formula.
> > > > >
> > > > >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> > > > >
> > > > > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> > > > >
> > > > >   crash> list super_blocks | wc -l
> > > > >   952
> > > >
> > > > The more I see people trying to work around this, the more I think
> > > > that the way memcgs have been grafted into the list_lru is back to
> > > > front.
> > > >
> > > > We currently allocate scope for every memcg to be able to tracked on
> > > > every not on every superblock instantiated in the system, regardless
> > > > of whether that superblock is even accessible to that memcg.
> > > >
> > > > These huge memcg counts come from container hosts where memcgs are
> > > > confined to just a small subset of the total number of superblocks
> > > > that instantiated at any given point in time.
> > > >
> > > > IOWs, for these systems with huge container counts, list_lru does
> > > > not need the capability of tracking every memcg on every superblock.
> > > >
> > > > What it comes down to is that the list_lru is only needed for a
> > > > given memcg if that memcg is instatiating and freeing objects on a
> > > > given list_lru.
> > > >
> > > > Which makes me think we should be moving more towards "add the memcg
> > > > to the list_lru at the first insert" model rather than "instantiate
> > > > all at memcg init time just in case". The model we originally came
> > > > up with for supprting memcgs is really starting to show it's limits,
> > > > and we should address those limitations rahter than hack more
> > > > complexity into the system that does nothing to remove the
> > > > limitations that are causing the problems in the first place.
> > >
> > > I totally agree.
> > >
> > > It looks like the initial implementation of the whole kernel memory accounting
> > > and memcg-aware shrinkers was based on the idea that the number of memory
> > > cgroups is relatively small and stable.
> >
> > Yes, that was one of the original assumptions - tens to maybe low
> > hundreds of memcgs at most. The other was that memcgs weren't NUMA
> > aware, and so would only need a single LRU list per memcg. Hence the
> > total overhead even with "lots" of memcgsi and superblocks the
> > overhead wasn't that great.
> >
> > Then came "memcgs need to be NUMA aware" because of the size of the
> > machines they were being use for resrouce management in, and that
> > greatly increased the per-memcg, per LRU overhead. Now we're talking
> > about needing to support a couple of orders of magnitude more memcgs
> > and superblocks than were originally designed for.
> >
> > So, really, we're way beyond the original design scope of this
> > subsystem now.
> 
> Got it. So it is better to allocate the structure of the list_lru_node
> dynamically. We should only allocate it when it is really demanded.
> But allocating memory by using GFP_ATOMIC in list_lru_add() is
> not a good idea. So we should allocate the memory out of
> list_lru_add(). I can propose an approach that may work.
> 
> Before start, we should know about the following rules of list lrus.
> 
> - Only objects allocated with __GFP_ACCOUNT need to allocate
>   the struct list_lru_node.

This seems .... misguided. inode and dentry caches are already
marked as accounted, so individual calls to allocate from these
slabs do not need this annotation.

> - The caller of allocating memory must know which list_lru the
>   object will insert.
> 
> So we can allocate struct list_lru_node when allocating the
> object instead of allocating it when list_lru_add().  It is easy, because
> we already know the list_lru and memcg which the object belongs
> to. So we can introduce a new helper to allocate the object and
> list_lru_node. Like below.
> 
> void *list_lru_kmem_cache_alloc(struct list_lru *lru, struct kmem_cache *s,
>                                 gfp_t gfpflags)
> {
>         void *ret = kmem_cache_alloc(s, gfpflags);
> 
>         if (ret && (gfpflags & __GFP_ACCOUNT)) {
>                 struct mem_cgroup *memcg = mem_cgroup_from_obj(ret);
> 
>                 if (mem_cgroup_is_root(memcg))
>                         return ret;
> 
>                 /* Allocate per-memcg list_lru_node, if it already
> allocated, do nothing. */
>                 memcg_list_lru_node_alloc(lru, memcg,
> page_to_nid(virt_to_page(ret)), gfpflags);

If we are allowing kmem_cache_alloc() to fail, then we can allow
memcg_list_lru_node_alloc() to fail, too.

Also, why put this outside kmem_cache_alloc()? Node id and memcg is
already known internally to kmem_cache_alloc() when allocating from
a slab, so why not associate the slab allocation with the LRU
directly when doing the memcg accounting and so avoid doing costly
duplicate work on every allocation?

i.e. the list-lru was moved inside the mm/ dir because "it's a mm
specific construct only", so why not actually make use of that
designation to internalise this entire memcg management issue into
the slab allocation routines? i.e.  an API like
kmem_cache_alloc_lru(cache, lru, gfpflags) allows this to be
completely internalised and efficiently implemented with minimal
change to callers. It also means that memory allocation callers
don't need to know anything about memcg management, which is always
a win....

>         }
> 
>         return ret;
> }
> 
> If the user wants to insert the allocated object to its lru list in
> the feature. The
> user should use list_lru_kmem_cache_alloc() instead of kmem_cache_alloc().
> I have looked at the code closely. There are 3 different kmem_caches that
> need to use this new API to allocate memory. They are inode_cachep,
> dentry_cache and radix_tree_node_cachep. I think that it is easy to migrate.

It might work, but I think you may have overlooked the complexity
of inode allocation for filesystems. i.e.  alloc_inode() calls out
to filesystem allocation functions more often than it allocates
directly from the inode_cachep.  i.e.  Most filesystems provide
their own ->alloc_inode superblock operation, and they allocate
inodes out of their own specific slab caches, not the inode_cachep.

And then you have filesystems like XFS, where alloc_inode() will
never be called, and implement ->alloc_inode as:

/* Catch misguided souls that try to use this interface on XFS */
STATIC struct inode *
xfs_fs_alloc_inode(
        struct super_block      *sb)
{
	BUG();
	return NULL;
}

Because all the inode caching and allocation is internal to XFS and
VFS inode management interfaces are not used.

So I suspect that an external wrapper function is not the way to go
here - either internalising the LRU management into the slab
allocation or adding the memcg code to alloc_inode() and filesystem
specific routines would make a lot more sense to me.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
