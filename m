Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A78436F340
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhD3At5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 20:49:57 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45743 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhD3At4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 20:49:56 -0400
Received: from dread.disaster.area (pa49-179-143-157.pa.nsw.optusnet.com.au [49.179.143.157])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2B51C5EC55D;
        Fri, 30 Apr 2021 10:49:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lcHL5-00E0Dg-3G; Fri, 30 Apr 2021 10:49:03 +1000
Date:   Fri, 30 Apr 2021 10:49:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/9] Shrink the list lru size on memory cgroup removal
Message-ID: <20210430004903.GF1872259@dread.disaster.area>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=I9rzhn+0hBG9LkCzAun3+g==:117 a=I9rzhn+0hBG9LkCzAun3+g==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=gRuEtl0_YJUf-htUwt8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 05:49:40PM +0800, Muchun Song wrote:
> In our server, we found a suspected memory leak problem. The kmalloc-32
> consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> memory.
> 
> After our in-depth analysis, the memory consumption of kmalloc-32 slab
> cache is the cause of list_lru_one allocation.
> 
>   crash> p memcg_nr_cache_ids
>   memcg_nr_cache_ids = $2 = 24574
> 
> memcg_nr_cache_ids is very large and memory consumption of each list_lru
> can be calculated with the following formula.
> 
>   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> 
> There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> 
>   crash> list super_blocks | wc -l
>   952

The more I see people trying to work around this, the more I think
that the way memcgs have been grafted into the list_lru is back to
front.

We currently allocate scope for every memcg to be able to tracked on
every not on every superblock instantiated in the system, regardless
of whether that superblock is even accessible to that memcg.

These huge memcg counts come from container hosts where memcgs are
confined to just a small subset of the total number of superblocks
that instantiated at any given point in time.

IOWs, for these systems with huge container counts, list_lru does
not need the capability of tracking every memcg on every superblock.

What it comes down to is that the list_lru is only needed for a
given memcg if that memcg is instatiating and freeing objects on a
given list_lru.

Which makes me think we should be moving more towards "add the memcg
to the list_lru at the first insert" model rather than "instantiate
all at memcg init time just in case". The model we originally came
up with for supprting memcgs is really starting to show it's limits,
and we should address those limitations rahter than hack more
complexity into the system that does nothing to remove the
limitations that are causing the problems in the first place.

> Every mount will register 2 list lrus, one is for inode, another is for
> dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> MB (~5.6GB).  But the number of memory cgroup is less than 500. So I
> guess more than 12286 containers have been deployed on this machine (I
> do not know why there are so many containers, it may be a user's bug or
> the user really want to do that). But now there are less than 500
> containers in the system. And memcg_nr_cache_ids has not been reduced
> to a suitable value. This can waste a lot of memory. If we want to reduce
> memcg_nr_cache_ids, we have to reboot the server. This is not what we
> want.

Exactly my point. This model is broken and doesn't scale to large
counts of either memcgs or superblocks.

We need a different model for dynamically adding, removing and
mapping memcgs to LRU lists they are actually using so that we can
efficiently scale to tens of thousands of memcgs instances along
with tens of thousands of unique superblock instants. That's the
real problem that needs solving here.

> So this patchset will dynamically adjust the value of memcg_nr_cache_ids
> to keep healthy memory consumption.

Gigabytes of RAM for largely unused memcg list_lrus on every
superblock is not healthy. It's highly inefficient because the
infrastructure we currently have was never designed to scale to
these numbers of unique containers and superblocks...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
