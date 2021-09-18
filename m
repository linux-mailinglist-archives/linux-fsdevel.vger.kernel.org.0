Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97C410486
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 08:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbhIRG5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 02:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhIRG5w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:57:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0BFC061574;
        Fri, 17 Sep 2021 23:56:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g41so9159195lfv.1;
        Fri, 17 Sep 2021 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TGq9sE9dP8uqZ0KtTlDXfc0qlJ4gv3+4miCEYgoKI3U=;
        b=PaYHNnwjUEJz2L6BXjzOfab7R94e/1HTmCkn3cuUCR4ShSD8t4PuALNglL8z9yWxmH
         /y1V3aYsGrEvNa+emHxJ0u9Bq4uVGVjGGUXTQJH8pcfpkdlpF8Qr3t2OtjjgCbRQy/sb
         9H+Ej+fQKOau0z15R/GZqEFWowuPbV/3eKS3RZ7+XvsBCfAg6iPMy0rYEB6L5Bhb83Tp
         M3AswFUtSCzL3stixuW4Mt5UtlBlBXGxPt7imTVG0icgKOnb2Y2lbiKYmmYwKyIvi5XJ
         InRRR0N3EWgVaQuw6Fd31VRTD17bi5oDqMBOy+jO0BbDNyZCuefkWBlXGb2BxRsW7jo2
         At5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TGq9sE9dP8uqZ0KtTlDXfc0qlJ4gv3+4miCEYgoKI3U=;
        b=7UVtAsJjbHR1wlXbpp000t0wdok6zbsgIt2lX3rey8Ue361x2N9Nvz/goDSXvP96gn
         C7MXx7wMJHmWqufCYIZ1tWGbOzLSAMbZ3MiZ8H3e6OdJerPuIJWOqJ1iwsjtHE7ULnEp
         14bmV1vR9GMOaA8ITbqw1V5u5omBsxmECyY/Qs5wd0DkAHYcNh/vcQmlpSzyY1qSGYxF
         BQBECCegvu9fuRNUk3t4dA6JBvrM9D4rLKqI26YltgFN402T8ixx6Dzmqoz66QHa2yRP
         g+UbF4M4GNFBYnIt+3A7C11zGRiziyCm/4MvAh305k3cyJCzFUN64oD7NR/7ZJXRtQCn
         VVcw==
X-Gm-Message-State: AOAM530S45f4v6FMUHJo3ECBCdga/XGW+bm4KygDH8mttv4F2chctW70
        O46kKRgKN3K/dkhwync0nsexyQKF1tcH/A==
X-Google-Smtp-Source: ABdhPJxinhtdb6ex3THZ/u1wX9OZ78n8h2ICKMe3j+I9BXMqLgIHweFuXvciLECl9k+cY5lmiVXp6A==
X-Received: by 2002:a2e:a224:: with SMTP id i4mr12817397ljm.168.1631948187063;
        Fri, 17 Sep 2021 23:56:27 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id a7sm702400lfs.309.2021.09.17.23.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 23:56:26 -0700 (PDT)
Date:   Sat, 18 Sep 2021 09:56:24 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v3 00/76] Optimize list lru memory consumption
Message-ID: <20210918065624.dbaar4lss5olrfhu@kari-VirtualBox>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 03:28:22PM +0800, Muchun Song wrote:
> We introduced alloc_inode_sb() in previous version 2, which sets up the
> inode reclaim context properly, to allocate filesystems specific inode.
> So we have to convert to new API for all filesystems, which is done in
> one patch. Some filesystems are easy to convert (just replace
> kmem_cache_alloc() to alloc_inode_sb()), while other filesystems need to
> do more work. In order to make it easy for maintainers of different
> filesystems to review their own maintained part, I split the patch into
> patches which are per-filesystem in this version. I am not sure if this
> is a good idea, because there is going to be more commits.
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
> reduced to a suitable value. It leads to waste a lot of memory. If we want
> to reduce memcg_nr_cache_ids, we have to *reboot* the server. This is not
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
> Patch 8 introduces kmem_cache_alloc_lru()
> Patch 9 introduces alloc_inode_sb()
> Patch 10-66 convert all filesystems to alloc_inode_sb() respectively.

There is now days also ntfs3. If you do not plan to convert this please
CC me atleast so that I can do it when these lands.

  Argillander

> Patch 70 let list_lru allocation dynamically.
> Patch 72 use xarray to optimize per memcg pointer array size.
> Patch 73-76 is code simplification.
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
>         |     after patch 70    |         6895 MB        |          |
>         +-----------------------+------------------------+          |
>         |     after patch 72    |         4367 MB        |          |
>         +-----------------------+------------------------+          |
>                                                                     |
>         The more the number of nodes, the more obvious the effect---+
> 
> BTW, there was a recent discussion [2] on the same issue.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20210428094949.43579-1-songmuchun@bytedance.com/
> [2] https://lore.kernel.org/linux-fsdevel/20210405054848.GA1077931@in.ibm.com/
> 
> This series not only optimizes the memory usage of list_lru but also
> simplifies the code.
> 
> Changelog in v3:
>   - Fix mixing advanced and normal XArray concepts (Thanks to Matthew).
>   - Split one patch into per-filesystem patches.
> 
> Changelog in v2:
>   - Update Documentation/filesystems/porting.rst suggested by Dave.
>   - Add a comment above alloc_inode_sb() suggested by Dave.
>   - Rework some patch's commit log.
>   - Add patch 18-21.
> 
>   Thanks Dave.
> 
> Muchun Song (76):
>   mm: list_lru: fix the return value of list_lru_count_one()
>   mm: memcontrol: remove kmemcg_id reparenting
>   mm: memcontrol: remove the kmem states
>   mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
>   mm: list_lru: remove holding lru lock
>   mm: list_lru: only add memcg-aware lrus to the global lru list
>   mm: list_lru: optimize memory consumption of arrays
>   mm: introduce kmem_cache_alloc_lru
>   fs: introduce alloc_inode_sb() to allocate filesystems specific inode
>   dax: allocate inode by using alloc_inode_sb()
>   9p: allocate inode by using alloc_inode_sb()
>   adfs: allocate inode by using alloc_inode_sb()
>   affs: allocate inode by using alloc_inode_sb()
>   afs: allocate inode by using alloc_inode_sb()
>   befs: allocate inode by using alloc_inode_sb()
>   bfs: allocate inode by using alloc_inode_sb()
>   block: allocate inode by using alloc_inode_sb()
>   btrfs: allocate inode by using alloc_inode_sb()
>   ceph: allocate inode by using alloc_inode_sb()
>   cifs: allocate inode by using alloc_inode_sb()
>   coda: allocate inode by using alloc_inode_sb()
>   ecryptfs: allocate inode by using alloc_inode_sb()
>   efs: allocate inode by using alloc_inode_sb()
>   erofs: allocate inode by using alloc_inode_sb()
>   exfat: allocate inode by using alloc_inode_sb()
>   ext2: allocate inode by using alloc_inode_sb()
>   ext4: allocate inode by using alloc_inode_sb()
>   fat: allocate inode by using alloc_inode_sb()
>   freevxfs: allocate inode by using alloc_inode_sb()
>   fuse: allocate inode by using alloc_inode_sb()
>   gfs2: allocate inode by using alloc_inode_sb()
>   hfs: allocate inode by using alloc_inode_sb()
>   hfsplus: allocate inode by using alloc_inode_sb()
>   hostfs: allocate inode by using alloc_inode_sb()
>   hpfs: allocate inode by using alloc_inode_sb()
>   hugetlbfs: allocate inode by using alloc_inode_sb()
>   isofs: allocate inode by using alloc_inode_sb()
>   jffs2: allocate inode by using alloc_inode_sb()
>   jfs: allocate inode by using alloc_inode_sb()
>   minix: allocate inode by using alloc_inode_sb()
>   nfs: allocate inode by using alloc_inode_sb()
>   nilfs2: allocate inode by using alloc_inode_sb()
>   ntfs: allocate inode by using alloc_inode_sb()
>   ocfs2: allocate inode by using alloc_inode_sb()
>   openpromfs: allocate inode by using alloc_inode_sb()
>   orangefs: allocate inode by using alloc_inode_sb()
>   overlayfs: allocate inode by using alloc_inode_sb()
>   proc: allocate inode by using alloc_inode_sb()
>   qnx4: allocate inode by using alloc_inode_sb()
>   qnx6: allocate inode by using alloc_inode_sb()
>   reiserfs: allocate inode by using alloc_inode_sb()
>   romfs: allocate inode by using alloc_inode_sb()
>   squashfs: allocate inode by using alloc_inode_sb()
>   sysv: allocate inode by using alloc_inode_sb()
>   ubifs: allocate inode by using alloc_inode_sb()
>   udf: allocate inode by using alloc_inode_sb()
>   ufs: allocate inode by using alloc_inode_sb()
>   vboxsf: allocate inode by using alloc_inode_sb()
>   xfs: allocate inode by using alloc_inode_sb()
>   zonefs: allocate inode by using alloc_inode_sb()
>   ipc: allocate inode by using alloc_inode_sb()
>   shmem: allocate inode by using alloc_inode_sb()
>   net: allocate inode by using alloc_inode_sb()
>   rpc: allocate inode by using alloc_inode_sb()
>   f2fs: allocate inode by using alloc_inode_sb()
>   nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
>   mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
>   xarray: use kmem_cache_alloc_lru to allocate xa_node
>   mm: workingset: use xas_set_lru() to pass shadow_nodes
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
>  fs/f2fs/super.c                       |   8 +-
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
>  fs/nfs/nfs42xattr.c                   |  95 ++++---
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
>  fs/xfs/xfs_icache.c                   |   2 +-
>  fs/zonefs/super.c                     |   2 +-
>  include/linux/fs.h                    |  11 +
>  include/linux/list_lru.h              |  16 +-
>  include/linux/memcontrol.h            |  49 ++--
>  include/linux/slab.h                  |   3 +
>  include/linux/swap.h                  |   5 +-
>  include/linux/xarray.h                |   9 +-
>  ipc/mqueue.c                          |   2 +-
>  lib/xarray.c                          |  10 +-
>  mm/list_lru.c                         | 472 ++++++++++++++++------------------
>  mm/memcontrol.c                       | 190 ++------------
>  mm/shmem.c                            |   2 +-
>  mm/slab.c                             |  39 ++-
>  mm/slab.h                             |  17 +-
>  mm/slob.c                             |   6 +
>  mm/slub.c                             |  42 ++-
>  mm/workingset.c                       |   2 +-
>  net/socket.c                          |   2 +-
>  net/sunrpc/rpc_pipe.c                 |   2 +-
>  75 files changed, 498 insertions(+), 598 deletions(-)
> 
> -- 
> 2.11.0
> 
