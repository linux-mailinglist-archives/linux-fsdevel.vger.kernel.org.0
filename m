Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE0C37337D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 03:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEEBOe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 21:14:34 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:36043 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231408AbhEEBOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 21:14:32 -0400
Received: from dread.disaster.area (pa49-179-143-157.pa.nsw.optusnet.com.au [49.179.143.157])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id C72B31AF823;
        Wed,  5 May 2021 11:13:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1le66V-003pXr-Mo; Wed, 05 May 2021 11:13:31 +1000
Date:   Wed, 5 May 2021 11:13:31 +1000
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
Message-ID: <20210505011331.GM1872259@dread.disaster.area>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area>
 <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
 <20210430032739.GG1872259@dread.disaster.area>
 <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
 <20210502235843.GJ1872259@dread.disaster.area>
 <CAMZfGtVK2Sracf=ongpNJqacafmC2ZsNy-KxEL67fVCAGXz3xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVK2Sracf=ongpNJqacafmC2ZsNy-KxEL67fVCAGXz3xA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=I9rzhn+0hBG9LkCzAun3+g==:117 a=I9rzhn+0hBG9LkCzAun3+g==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=sqVQysubuN6EyXWE9wQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 03, 2021 at 02:33:21PM +0800, Muchun Song wrote:
> On Mon, May 3, 2021 at 7:58 AM Dave Chinner <david@fromorbit.com> wrote:
> > > If the user wants to insert the allocated object to its lru list in
> > > the feature. The
> > > user should use list_lru_kmem_cache_alloc() instead of kmem_cache_alloc().
> > > I have looked at the code closely. There are 3 different kmem_caches that
> > > need to use this new API to allocate memory. They are inode_cachep,
> > > dentry_cache and radix_tree_node_cachep. I think that it is easy to migrate.
> >
> > It might work, but I think you may have overlooked the complexity
> > of inode allocation for filesystems. i.e.  alloc_inode() calls out
> > to filesystem allocation functions more often than it allocates
> > directly from the inode_cachep.  i.e.  Most filesystems provide
> > their own ->alloc_inode superblock operation, and they allocate
> > inodes out of their own specific slab caches, not the inode_cachep.
> 
> I didn't realize this before. You are right. Most filesystems
> have their own kmem_cache instead of inode_cachep.
> We need a lot of filesystems special to be changed.
> Thanks for your reminder.
> 
> >
> > And then you have filesystems like XFS, where alloc_inode() will
> > never be called, and implement ->alloc_inode as:
> >
> > /* Catch misguided souls that try to use this interface on XFS */
> > STATIC struct inode *
> > xfs_fs_alloc_inode(
> >         struct super_block      *sb)
> > {
> >         BUG();
> >         return NULL;
> > }
> >
> > Because all the inode caching and allocation is internal to XFS and
> > VFS inode management interfaces are not used.
> >
> > So I suspect that an external wrapper function is not the way to go
> > here - either internalising the LRU management into the slab
> > allocation or adding the memcg code to alloc_inode() and filesystem
> > specific routines would make a lot more sense to me.
> 
> Sure. If we introduce kmem_cache_alloc_lru, all filesystems
> need to migrate to kmem_cache_alloc_lru. I cannot figure out
> an approach that does not need to change filesystems code.

Right, I don't think there's a way to avoid changing all the
filesystem code if we are touching the cache allocation routines.
However, if we hide it all inside the allocation routine, then
the changes to each filesystem is effectively just a 1-liner like:

-	inode = kmem_cache_alloc(inode_cache, GFP_NOFS);
+	inode = kmem_cache_alloc_lru(inode_cache, sb->s_inode_lru, GFP_NOFS);

Or perhaps, define a generic wrapper function like:

static inline void *
alloc_inode_sb(struct superblock *sb, struct kmem_cache *cache, gfp_flags_t gfp)
{
	return kmem_cache_alloc_lru(cache, sb->s_inode_lru, gfp);
}

And then each filesystem ends up with:

-	inode = kmem_cache_alloc(inode_cache, GFP_NOFS);
+	inode = alloc_inode_sb(sb, inode_cache, GFP_NOFS);

so that all the superblock LRU stuff is also hidden from the
filesystems...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
