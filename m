Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3642037B2BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 01:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhEKXlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 19:41:55 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:52466 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhEKXlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 19:41:55 -0400
Received: from dread.disaster.area (pa49-179-143-157.pa.nsw.optusnet.com.au [49.179.143.157])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id ADB8A1082A9;
        Wed, 12 May 2021 09:40:43 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lgbzV-00EYIv-Js; Wed, 12 May 2021 09:40:41 +1000
Date:   Wed, 12 May 2021 09:40:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Subject: Re: [PATCH 10/17] fs: introduce alloc_inode_sb() to allocate
 filesystems specific inode
Message-ID: <20210511234041.GP1872259@dread.disaster.area>
References: <20210511104647.604-1-songmuchun@bytedance.com>
 <20210511104647.604-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511104647.604-11-songmuchun@bytedance.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=I9rzhn+0hBG9LkCzAun3+g==:117 a=I9rzhn+0hBG9LkCzAun3+g==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=eDM3njHHF8h-SXrJDeMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 06:46:40PM +0800, Muchun Song wrote:
> The allocated inode cache will be added into its memcg lru list later,
> but we do not allocate list_lru in the later patch. So the caller should
> call kmem_cache_alloc_lru() to allocate inode and related list_lru.
> Introduce alloc_inode_sb() to do that and convert all inodes allocation
> to it.

FWIW, this probably needs a documentation update to mention that
inodes should always be allocated through alloc_inode_sb() rather
than kmem_cache_alloc(). It's a "** mandatory **" requirement as per
Documentation/filesytems/porting.rst.

Also,

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..d8d5d4eb68d6 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -41,6 +41,7 @@
>  #include <linux/stddef.h>
>  #include <linux/mount.h>
>  #include <linux/cred.h>
> +#include <linux/slab.h>
>  
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> @@ -3200,6 +3201,12 @@ extern void free_inode_nonrcu(struct inode *inode);
>  extern int should_remove_suid(struct dentry *);
>  extern int file_remove_privs(struct file *);
>  
> +static inline void *
> +alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
> +{
> +	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
> +}
> +

This really needs a kerneldoc comment explaining that it must be
used for allocating inodes to set up the inode reclaim context
correctly....

/me wonders if we should add a BUG_ON() check in inode_init_always()
to capture filesystems that don't call through
kmem_cache_alloc_lru() for inodes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
