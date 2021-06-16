Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636603A982B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhFPKzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhFPKzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:55:53 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E6C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 03:53:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w31so1638929pga.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F4wIVc8giBEj/L0sF2igfGJYRrfDn+2p/3gu13P4iGo=;
        b=EGr3khoOq9ZikVKPXclpZ8YBX9VWKVDA7hoWh/jrdjCUbc56UdyDTdzY9wOnbku7bX
         n1y4NybwxtyAzr6saEeTcWps48wuLbe7IxbfCFExfwqTdxYGgPeiD5Fbs/Gx8a5XwJ6E
         XW1GtEXbfbf5v5CPXmMnZI/Y7c8EGzOiKk2/1+fj0QWrBKiC2Xv8ckfsRW7MAPCR69Md
         xvir2sVm65gObQe607bJO4OZn4ZWNMZgGsIkF2lVzVdljOQ8bc4HaRDkFKTcQc2XTRQV
         yfDoSPLgyFx6uqFHc9GHiJPSSRF3Oqg6qth7lM3GupgeJcXM0C1K9xVikdssTcYk7SK/
         eAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4wIVc8giBEj/L0sF2igfGJYRrfDn+2p/3gu13P4iGo=;
        b=rJr/7Yvu74WJpcGh7w8cHWzM3dPPfj4uzPttCxcTbH9vSKzMtwDsMQhw8fAE7r1VB6
         hOwBKJ/sXtO7Jr9fxLYB+/SZ6ldLjRJLcW4RoBFoFEbGZ4T3YvB9HJXeJyldBgC0qIms
         3JYwfvbsJSQ6iuM9Mp3bvTnO+FceHFUmQEeGQlBShGs0bx+e1wMwkfCDBD9X0vcmrlUn
         1P/UrcsDq/tjvP8CwAn3h/5ppKgE4vdkdpPcZ5QQhS7zQsdFACon1ZBhMfEtyIusEcCV
         MV4/TBMZC2e3PDjBkojlmJZSFhBs2xbhqF23nKHbF0jieEzQXLptoeyainpJGIq2WWUe
         fx1Q==
X-Gm-Message-State: AOAM532A0gvcroM37VuHt0JKly9Q/f1av0WRG7l2kanuCKQBklCjT53+
        cZdBuBOojA49J7tFn6BpEbtSDEdsffRsl3zqkA1ISA==
X-Google-Smtp-Source: ABdhPJz2SStD2vaD/Sam6WHfe7R84x09NcfgsDobs0AW5U13LfaWe0xGg3raWvhbnHD7Kc41mE1wPAp2ahOjS0QALzw=
X-Received: by 2002:a63:6547:: with SMTP id z68mr4318448pgb.341.1623840826929;
 Wed, 16 Jun 2021 03:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210527062148.9361-1-songmuchun@bytedance.com>
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Jun 2021 18:53:09 +0800
Message-ID: <CAMZfGtUREhSDqurY5E=e-otSvN3LvZSrFX8WvP6zt3kaNgpS8g@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] Optimize list lru memory consumption
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm very sorry to bother everyone. Ping guys. Any comments on this series?

On Thu, May 27, 2021 at 2:24 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
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
>
> Every mount will register 2 list lrus, one is for inode, another is for
> dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> MB (~5.6GB). But now the number of memory cgroups is less than 500. So I
> guess more than 12286 memory cgroups have been created on this machine (I
> do not know why there are so many cgroups, it may be a user's bug or
> the user really want to do that). Because memcg_nr_cache_ids has not been
> reduced to a suitable value. This can waste a lot of memory. If we want
> to reduce memcg_nr_cache_ids, we have to reboot the server. This is not
> what we want.
>
> In order to reduce memcg_nr_cache_ids, I had posted a patchset [1] to do
> this. But this did not fundamentally solve the problem.
>
> We currently allocate scope for every memcg to be able to tracked on every
> superblock instantiated in the system, regardless of whether that superblock
> is even accessible to that memcg.
>
> These huge memcg counts come from container hosts where memcgs are confined
> to just a small subset of the total number of superblocks that instantiated
> at any given point in time.
>
> For these systems with huge container counts, list_lru does not need the
> capability of tracking every memcg on every superblock.
>
> What it comes down to is that the list_lru is only needed for a given memcg
> if that memcg is instatiating and freeing objects on a given list_lru.
>
> As Dave said, "Which makes me think we should be moving more towards 'add the
> memcg to the list_lru at the first insert' model rather than 'instantiate
> all at memcg init time just in case'."
>
> This patchset aims to optimize the list lru memory consumption from different
> aspects.
>
> Patch 1-6 are code simplification.
> Patch 7 converts the array from per-memcg per-node to per-memcg
> Patch 8 is code simplification.
> Patch 9-15 let list_lru allocation dynamically.
> Patch 16 is code cleanup.
> Patch 17 use xarray to optimize per memcg pointer array size.
> Patch 18-21 is code simplification.
>
> I had done a easy test to show the optimization. I create 10k memory cgroups
> and mount 10k filesystems in the systems. We use free command to show how many
> memory does the systems comsumes after this operation (There are 2 numa nodes
> in the system).
>
>         +-----------------------+------------------------+
>         |      condition        |   memory consumption   |
>         +-----------------------+------------------------+
>         | without this patchset |        24464 MB        |
>         +-----------------------+------------------------+
>         |     after patch 7     |        21957 MB        | <--------+
>         +-----------------------+------------------------+          |
>         |     after patch 15    |         6895 MB        |          |
>         +-----------------------+------------------------+          |
>         |     after patch 17    |         4367 MB        |          |
>         +-----------------------+------------------------+          |
>                                                                     |
>         The more the number of nodes, the more obvious the effect---+
>
> BTW, there was a recent discussion [2] on the same issue.
>
> [1] https://lore.kernel.org/linux-fsdevel/20210428094949.43579-1-songmuchun@bytedance.com/
> [2] https://lore.kernel.org/linux-fsdevel/20210405054848.GA1077931@in.ibm.com/
>
> Changelog in v2:
>   1. Update Documentation/filesystems/porting.rst suggested by Dave.
>   2. Add a comment above alloc_inode_sb() suggested by Dave.
>   2. Rework some patch's commit log.
>   3. Add patch 18-21.
>
>   Thanks Dave.
>
> Muchun Song (21):
>   mm: list_lru: fix list_lru_count_one() return value
>   mm: memcontrol: remove kmemcg_id reparenting
>   mm: memcontrol: remove the kmem states
>   mm: memcontrol: do it in mem_cgroup_css_online to make the kmem online
>   mm: list_lru: remove lru node locking from memcg_update_list_lru_node
>   mm: list_lru: only add the memcg aware lrus to the list_lrus
>   mm: list_lru: optimize the array of per memcg lists memory consumption
>   mm: list_lru: remove memcg_aware field from struct list_lru
>   mm: introduce kmem_cache_alloc_lru
>   fs: introduce alloc_inode_sb() to allocate filesystems specific inode
>   mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
>   xarray: use kmem_cache_alloc_lru to allocate xa_node
>   mm: workingset: use xas_set_lru() to pass shadow_nodes
>   nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
>   mm: list_lru: allocate list_lru_one only when needed
>   mm: list_lru: rename memcg_drain_all_list_lrus to
>     memcg_reparent_list_lrus
>   mm: list_lru: replace linear array with xarray
>   mm: memcontrol: reuse memory cgroup ID for kmem ID
>   mm: memcontrol: fix cannot alloc the maximum memcg ID
>   mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
>   mm: memcontrol: rename memcg_cache_id to memcg_kmem_id
>
>  Documentation/filesystems/porting.rst |   5 +
>  drivers/dax/super.c                   |   2 +-
>  fs/9p/vfs_inode.c                     |   2 +-
>  fs/adfs/super.c                       |   2 +-
>  fs/affs/super.c                       |   2 +-
>  fs/afs/super.c                        |   2 +-
>  fs/befs/linuxvfs.c                    |   2 +-
>  fs/bfs/inode.c                        |   2 +-
>  fs/block_dev.c                        |   2 +-
>  fs/btrfs/inode.c                      |   2 +-
>  fs/ceph/inode.c                       |   2 +-
>  fs/cifs/cifsfs.c                      |   2 +-
>  fs/coda/inode.c                       |   2 +-
>  fs/dcache.c                           |   3 +-
>  fs/ecryptfs/super.c                   |   2 +-
>  fs/efs/super.c                        |   2 +-
>  fs/erofs/super.c                      |   2 +-
>  fs/exfat/super.c                      |   2 +-
>  fs/ext2/super.c                       |   2 +-
>  fs/ext4/super.c                       |   2 +-
>  fs/f2fs/super.c                       |   2 +-
>  fs/fat/inode.c                        |   2 +-
>  fs/freevxfs/vxfs_super.c              |   2 +-
>  fs/fuse/inode.c                       |   2 +-
>  fs/gfs2/super.c                       |   2 +-
>  fs/hfs/super.c                        |   2 +-
>  fs/hfsplus/super.c                    |   2 +-
>  fs/hostfs/hostfs_kern.c               |   2 +-
>  fs/hpfs/super.c                       |   2 +-
>  fs/hugetlbfs/inode.c                  |   2 +-
>  fs/inode.c                            |   2 +-
>  fs/isofs/inode.c                      |   2 +-
>  fs/jffs2/super.c                      |   2 +-
>  fs/jfs/super.c                        |   2 +-
>  fs/minix/inode.c                      |   2 +-
>  fs/nfs/inode.c                        |   2 +-
>  fs/nfs/nfs42xattr.c                   |  95 ++++----
>  fs/nilfs2/super.c                     |   2 +-
>  fs/ntfs/inode.c                       |   2 +-
>  fs/ocfs2/dlmfs/dlmfs.c                |   2 +-
>  fs/ocfs2/super.c                      |   2 +-
>  fs/openpromfs/inode.c                 |   2 +-
>  fs/orangefs/super.c                   |   2 +-
>  fs/overlayfs/super.c                  |   2 +-
>  fs/proc/inode.c                       |   2 +-
>  fs/qnx4/inode.c                       |   2 +-
>  fs/qnx6/inode.c                       |   2 +-
>  fs/reiserfs/super.c                   |   2 +-
>  fs/romfs/super.c                      |   2 +-
>  fs/squashfs/super.c                   |   2 +-
>  fs/sysv/inode.c                       |   2 +-
>  fs/ubifs/super.c                      |   2 +-
>  fs/udf/super.c                        |   2 +-
>  fs/ufs/super.c                        |   2 +-
>  fs/vboxsf/super.c                     |   2 +-
>  fs/xfs/xfs_icache.c                   |   3 +-
>  fs/zonefs/super.c                     |   2 +-
>  include/linux/fs.h                    |  11 +
>  include/linux/list_lru.h              |  18 +-
>  include/linux/memcontrol.h            |  48 ++--
>  include/linux/slab.h                  |   4 +
>  include/linux/swap.h                  |   5 +-
>  include/linux/xarray.h                |   9 +-
>  ipc/mqueue.c                          |   2 +-
>  lib/xarray.c                          |  10 +-
>  mm/list_lru.c                         | 447 +++++++++++++++++-----------------
>  mm/memcontrol.c                       | 185 ++------------
>  mm/shmem.c                            |   2 +-
>  mm/slab.c                             |  39 ++-
>  mm/slab.h                             |  17 +-
>  mm/slub.c                             |  42 ++--
>  mm/workingset.c                       |   2 +-
>  net/socket.c                          |   2 +-
>  net/sunrpc/rpc_pipe.c                 |   2 +-
>  74 files changed, 480 insertions(+), 577 deletions(-)
>
> --
> 2.11.0
>
