Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28B727E2AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgI3Hb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 03:31:56 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:51982 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725535AbgI3Hb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:31:56 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4D5008282AC;
        Wed, 30 Sep 2020 17:31:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kNWae-0002Ke-HS; Wed, 30 Sep 2020 17:31:52 +1000
Date:   Wed, 30 Sep 2020 17:31:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Remove shrinker's nr_deferred
Message-ID: <20200930073152.GH12096@dread.disaster.area>
References: <20200916185823.5347-1-shy828301@gmail.com>
 <20200917023742.GT12096@dread.disaster.area>
 <CAHbLzkrGB_=KBgD1sMpW33QjWSGTXNnLy3JtVUyHc2Omsa3gWA@mail.gmail.com>
 <20200921003231.GZ12096@dread.disaster.area>
 <CAHbLzkqAWiO4uhGBmbUjgs6EmQazYQXHPxR2-MWo4X8zxZ7gfQ@mail.gmail.com>
 <CAHbLzkoidoBWtLtd_3DjuSvm7dAJV1gSJAMmWY95=e8N7Hy=TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoidoBWtLtd_3DjuSvm7dAJV1gSJAMmWY95=e8N7Hy=TQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=UfYygaMNmWWEh68mB8UA:9 a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 26, 2020 at 01:31:36PM -0700, Yang Shi wrote:
> Hi Dave,
> 
> I was exploring to make the "nr_deferred" per memcg. I looked into and
> had some prototypes for two approaches so far:
> 1. Have per memcg data structure for each memcg aware shrinker, just
> like what shrinker_map does.
> 2. Have "nr_deferred" on list_lru_one for memcg aware lists.
> 
> Both seem feasible, however the latter one looks much cleaner, I just
> need to add two new APIs for shrinker which gets and sets
> "nr_deferred" respectively. And, just memcg aware shrinkers need
> define those two callouts. We just need to care about memcg aware
> shrinkers, and the most memcg aware shrinkers (inode/dentry, nfs and
> workingset) use list_lru, so I'd prefer the latter one.

The list_lru is completely separate from the shrinker context. The
structure that tracks objects in a subsystem is not visible or aware
of how the high level shrinker scanning algorithms work. Not to
mention that subsystem shrinkers can be memcg aware without using
list_lru structures to index objects owned by a given memcg. Hence I
really don't like the idea of tying the shrinker control data deeply
into subsystem cache indexing....


> But there are two memcg aware shrinkers are not that straightforward
> to deal with:
> 1. The deferred split THP. It doesn't use list_lru, but actually I
> don't worry about this one, since it is not cache just some partial
> unmapped THPs. I could try to convert it to use list_lru later on or
> just kill deferred split by making vmscan split partial unmapped THPs.
> So TBH I don't think it is a blocker.

What a fantastic abuse of the reclaim infrastructure. :/

First it was just defered work. Then it became NUMA_AWARE. THen it
became MEMCG_AWARE and....

Oh, man what a nasty hack that SHRINKER_NONSLAB flag is so that it
runs through shrink_slab_memcg() even when memcgs are configured in
but kmem tracking disabled. We have heaps of shrinkers that reclaim
from things that aren't slab caches, but this one is just nuts.

> 2. The fs_objects. This one looks weird. It shares the same shrinker
> with inode/dentry. The only user is XFS currently. But it looks it is
> not really memcg aware at all, right?

It most definitely is.

The VFS dentry and inode cache reclaim are memcg aware. The
fs_objects callout is for filesystem level object garbage collection
that can be done as a result of the dentry and inode caches being
reclaimed.

i.e. once the VFS has reclaimed the inode attached to the memcg, it
is no longer attached and accounted to the memcg anymore. It is
owned by the filesystem at this point, and it is entirely up to the
filesytem to when it can then be freed. Most filesystems do it in
the inode cache reclaim via the ->destroy method. XFS, OTOH, tags
freeable inodes in it's internal radix trees rather than freeing
them immediately because it still may have to clean the inode before
it can be freed. Hence we defer freeing of inodes until the
->fs_objects pass....

> They are managed by radix tree
> which is not per memcg by looking into xfs code, so the "per list_lru
> nr_deferred" can't work for it.  I thought of a couple of ways to
> tackle it off the top of my head:
>     A. Just ignore it. If the amount of fs_objects are negligible
> comparing to inode/dentry, then I think it can be just ignored and
> kept it as is.

Ah, no, they are not negliable. Under memory pressure, the number of
objects is typically 1/3rd dentries, 1/3rd VFS inodes, 1/3rd fs
objects to be reclaimed. The dentries and VFS inodes are owned by
VFS level caches and associated with memcgs, the fs_objects are only
visible to the filesystem.

>     B. Move it out of inode/dentry shrinker. Add a dedicated shrinker
> for it, for example, sb->s_fs_obj_shrink.

No, they are there because the reclaim has to be kept in exact
proportion to the dentry and inode reclaim quantities. That's the
reason I put that code there in the first place: a separate inode
filesystem cache shrinker just didn't work well at all.

>     C. Make it really memcg aware and use list_lru.

Two things. Firstly, objects are owned by the filesystem at this
point, not memcgs. Memcgs were detatched at the VFS inode reclaim
layer.

Secondly, list-lru does not scale well enough for the use needed by
XFS. We use radix trees so we can do lockless batch lookups and
IO-efficient inode-order reclaim passes. We also have concurrent
reclaim capabilities because of the lockless tag lookup walks.
Using a list_lru for this substantially reduces reclaim performance
and greatly increases CPU usage of reclaim because of contention on
the internal list lru locks. Been there, measured that....

> I don't have any experience on XFS code, #C seems the most optimal,
> but should be the most time consuming, I'm not sure if it is worth it
> or not. So, #B sounds more preferred IMHO.

I think you're going completely in the wrong direction. The problem
that needs solving is integrating shrinker scanning control state
with memcgs more tightly, not force every memcg aware shrinker to
use list_lru for their subsystem shrinker implementations....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
