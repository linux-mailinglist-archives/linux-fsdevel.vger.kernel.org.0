Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA936F48C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 05:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhD3D2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 23:28:31 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:53559 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhD3D2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:28:31 -0400
Received: from dread.disaster.area (pa49-179-143-157.pa.nsw.optusnet.com.au [49.179.143.157])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 0B4A367642;
        Fri, 30 Apr 2021 13:27:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lcJoZ-00EAl0-Vo; Fri, 30 Apr 2021 13:27:39 +1000
Date:   Fri, 30 Apr 2021 13:27:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, willy@infradead.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, shy828301@gmail.com,
        alexs@kernel.org, alexander.h.duyck@linux.intel.com,
        richard.weiyang@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/9] Shrink the list lru size on memory cgroup removal
Message-ID: <20210430032739.GG1872259@dread.disaster.area>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area>
 <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=I9rzhn+0hBG9LkCzAun3+g==:117 a=I9rzhn+0hBG9LkCzAun3+g==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=XWMAvtMH4rRcoei1LcIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 29, 2021 at 06:39:40PM -0700, Roman Gushchin wrote:
> On Fri, Apr 30, 2021 at 10:49:03AM +1000, Dave Chinner wrote:
> > On Wed, Apr 28, 2021 at 05:49:40PM +0800, Muchun Song wrote:
> > > In our server, we found a suspected memory leak problem. The kmalloc-32
> > > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > > memory.
> > > 
> > > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > > cache is the cause of list_lru_one allocation.
> > > 
> > >   crash> p memcg_nr_cache_ids
> > >   memcg_nr_cache_ids = $2 = 24574
> > > 
> > > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > > can be calculated with the following formula.
> > > 
> > >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> > > 
> > > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> > > 
> > >   crash> list super_blocks | wc -l
> > >   952
> > 
> > The more I see people trying to work around this, the more I think
> > that the way memcgs have been grafted into the list_lru is back to
> > front.
> > 
> > We currently allocate scope for every memcg to be able to tracked on
> > every not on every superblock instantiated in the system, regardless
> > of whether that superblock is even accessible to that memcg.
> > 
> > These huge memcg counts come from container hosts where memcgs are
> > confined to just a small subset of the total number of superblocks
> > that instantiated at any given point in time.
> > 
> > IOWs, for these systems with huge container counts, list_lru does
> > not need the capability of tracking every memcg on every superblock.
> > 
> > What it comes down to is that the list_lru is only needed for a
> > given memcg if that memcg is instatiating and freeing objects on a
> > given list_lru.
> > 
> > Which makes me think we should be moving more towards "add the memcg
> > to the list_lru at the first insert" model rather than "instantiate
> > all at memcg init time just in case". The model we originally came
> > up with for supprting memcgs is really starting to show it's limits,
> > and we should address those limitations rahter than hack more
> > complexity into the system that does nothing to remove the
> > limitations that are causing the problems in the first place.
> 
> I totally agree.
> 
> It looks like the initial implementation of the whole kernel memory accounting
> and memcg-aware shrinkers was based on the idea that the number of memory
> cgroups is relatively small and stable.

Yes, that was one of the original assumptions - tens to maybe low
hundreds of memcgs at most. The other was that memcgs weren't NUMA
aware, and so would only need a single LRU list per memcg. Hence the
total overhead even with "lots" of memcgsi and superblocks the
overhead wasn't that great.

Then came "memcgs need to be NUMA aware" because of the size of the
machines they were being use for resrouce management in, and that
greatly increased the per-memcg, per LRU overhead. Now we're talking
about needing to support a couple of orders of magnitude more memcgs
and superblocks than were originally designed for.

So, really, we're way beyond the original design scope of this
subsystem now.

> With systemd creating a separate cgroup
> for everything including short-living processes it simple not true anymore.

Yeah, that too. Everything is much more dynamic these days...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
