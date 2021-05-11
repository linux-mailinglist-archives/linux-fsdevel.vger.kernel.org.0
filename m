Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058E437A4F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 12:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhEKKwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 06:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhEKKwV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 06:52:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5DCC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q2so15726589pfh.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WnvzW/xYy8cgKeY3BJToq570QsNMa+jR4L3j90K1VY=;
        b=vA8vOqBZtHHMUZ7d3stnW17giisFlwF7Ac7hXjsusCKoM1ueM9wjL5bVAXFwabEUdE
         q0tJp5xGeii60/lEgv116oUvQaSOlMT/5MD2kqAHCXgfleHweaZDkXcxhoRLqdikFIee
         g2T6R8IrNZRb2T31fBx+rfzXMgCl6Wzis/gTWtzILzWoQNf+NV17LyltBUGF8X+4E/Yx
         842kZLYPeTSEgzx5NbFndhCwi5YaZmV/pM9kqHyFrW2D0FbKpMZEA172MlPdLDG+DgwE
         WxcKYbtJJTz0nHV1amO6u1BeJ8QLWhyFAO0tmd59vrygWluFBgJ/8qS27/GKhzggq4kx
         ecgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WnvzW/xYy8cgKeY3BJToq570QsNMa+jR4L3j90K1VY=;
        b=k/IP62CXoAmtZb+uAs3o0DDSYV8jgz/l6B4DQY6NQ2XMMGSwZAnpfHkUZnWqnhGEr2
         h1fQRRfasn/qN4MgCMM27/ZerbFIbWcH8ppTZjo/WWtc1kRC3tlcohkq29a2BKyy9lqQ
         RyrF3Yy4kpzqdNkQU4bNIE+9qFLnh9IgRIAkD67GkyxE5Vaaw1RLJ12TuNl+HZd28YiL
         T2Ani7Ui94dCpOhw6+ZlJRCn2c9ThfqbaaEgYn7tS+xKIS2Le9ZBQXwiZLq2G7vrpvSZ
         /2/ggQGQegZrD5qxLruKP96ju8W+dgIe5FEeNtOCtTIJ6zVKKnHvzkPLjabja02X/HQr
         0SFA==
X-Gm-Message-State: AOAM530GDYd+xc9OeNguEM02a10xL1av9fxnfHsTzpDBn7V0BGQwyae4
        okU1pgMBgWQqyMq27LpP986nCw==
X-Google-Smtp-Source: ABdhPJyv4KHbQ9iBEM+pjtGhSBFOo9k+in+yCCuIlUsxm4052W1LmVWn6wShS1oWNryGdsMNFJ6JAA==
X-Received: by 2002:a63:4b18:: with SMTP id y24mr29632095pga.438.1620730275411;
        Tue, 11 May 2021 03:51:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n18sm13501952pgj.71.2021.05.11.03.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 May 2021 03:51:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 00/17] Optimize list lru memory consumption
Date:   Tue, 11 May 2021 18:46:30 +0800
Message-Id: <20210511104647.604-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In our server, we found a suspected memory leak problem. The kmalloc-32
consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
memory.

After our in-depth analysis, the memory consumption of kmalloc-32 slab
cache is the cause of list_lru_one allocation.

  crash> p memcg_nr_cache_ids
  memcg_nr_cache_ids = $2 = 24574

memcg_nr_cache_ids is very large and memory consumption of each list_lru
can be calculated with the following formula.

  num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)

There are 4 numa nodes in our system, so each list_lru consumes ~3MB.

  crash> list super_blocks | wc -l
  952

Every mount will register 2 list lrus, one is for inode, another is for
dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
MB (~5.6GB). But now the number of memory cgroups is less than 500. So I
guess more than 12286 memory cgroups have been created on this machine (I
do not know why there are so many cgroups, it may be a user's bug or
the user really want to do that). Because memcg_nr_cache_ids has not been
reduced to a suitable value. This can waste a lot of memory. If we want
to reduce memcg_nr_cache_ids, we have to reboot the server. This is not
what we want.

In order to reduce memcg_nr_cache_ids, I had posted a patchset [1] to do
this. But this did not fundamentally solve the problem.

We currently allocate scope for every memcg to be able to tracked on every
not on every superblock instantiated in the system, regardless of whether
that superblock is even accessible to that memcg.

These huge memcg counts come from container hosts where memcgs are confined
to just a small subset of the total number of superblocks that instantiated
at any given point in time.

For these systems with huge container counts, list_lru does not need the
capability of tracking every memcg on every superblock.

What it comes down to is that the list_lru is only needed for a given memcg
if that memcg is instatiating and freeing objects on a given list_lru.

As Dave said, "Which makes me think we should be moving more towards 'add the
memcg to the list_lru at the first insert' model rather than 'instantiate
all at memcg init time just in case'."

This patchset aims to optimize the list lru memory consumption from different
aspects.

Patch 1-6 are code simplification.
Patch 7 converts the array from per-memcg per-node to per-memcg
Patch 9-15 let list_lru allocation dynamically.
Patch 17 use xarray to optimize per memcg pointer array size.

I had done a easy test to show the optimization. I create 10k memory cgroups
and mount 10k filesystems in the systems. We use free command to show how many
memory does the systems comsumes after this operation.

        +------------------------------------------------+
        |      condition        |   memory consumption   |
        +-----------------------+------------------------+
        | without this patchset |        24464 MB        |
        +-----------------------+------------------------+
        |     after patch 7     |        21957 MB        | <--------+
        +-----------------------+------------------------+          |
        |     after patch 15    |         6895 MB        |          |
        +-----------------------+------------------------+          |
        |     after patch 17    |         4367 MB        |          |
        +-----------------------+------------------------+          |
                                                                    |
        The more the number of nodes, the more obvious the effect---+

BTW, there was a recent discussion [2] on the same issue.

[1] https://lore.kernel.org/linux-fsdevel/20210428094949.43579-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/linux-fsdevel/20210405054848.GA1077931@in.ibm.com/

Muchun Song (17):
  mm: list_lru: fix list_lru_count_one() return value
  mm: memcontrol: remove kmemcg_id reparenting
  mm: memcontrol: remove the kmem states
  mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
  mm: list_lru: remove holding lru node lock
  mm: list_lru: only add the memcg aware lrus to the list
  mm: list_lru: optimize the array of per memcg lists
  mm: list_lru: remove memcg_aware from struct list_lru
  mm: introduce kmem_cache_alloc_lru
  fs: introduce alloc_inode_sb() to allocate filesystems specific inode
  mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
  xarray: replace kmem_cache_alloc with kmem_cache_alloc_lru
  mm: workingset: allocate list_lru on xa_node allocation
  nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
  mm: list_lru: allocate list_lru_one only when needed
  mm: list_lru: rename memcg_drain_all_list_lrus to
    memcg_reparent_list_lrus
  mm: list_lru: replace linear array with xarray

 drivers/dax/super.c        |   2 +-
 fs/9p/vfs_inode.c          |   2 +-
 fs/adfs/super.c            |   2 +-
 fs/affs/super.c            |   2 +-
 fs/afs/super.c             |   2 +-
 fs/befs/linuxvfs.c         |   2 +-
 fs/bfs/inode.c             |   2 +-
 fs/block_dev.c             |   2 +-
 fs/btrfs/inode.c           |   2 +-
 fs/ceph/inode.c            |   2 +-
 fs/cifs/cifsfs.c           |   2 +-
 fs/coda/inode.c            |   2 +-
 fs/dcache.c                |   3 +-
 fs/ecryptfs/super.c        |   2 +-
 fs/efs/super.c             |   2 +-
 fs/erofs/super.c           |   2 +-
 fs/exfat/super.c           |   2 +-
 fs/ext2/super.c            |   2 +-
 fs/ext4/super.c            |   2 +-
 fs/f2fs/super.c            |   2 +-
 fs/fat/inode.c             |   2 +-
 fs/freevxfs/vxfs_super.c   |   2 +-
 fs/fuse/inode.c            |   2 +-
 fs/gfs2/super.c            |   2 +-
 fs/hfs/super.c             |   2 +-
 fs/hfsplus/super.c         |   2 +-
 fs/hostfs/hostfs_kern.c    |   2 +-
 fs/hpfs/super.c            |   2 +-
 fs/hugetlbfs/inode.c       |   2 +-
 fs/inode.c                 |   2 +-
 fs/isofs/inode.c           |   2 +-
 fs/jffs2/super.c           |   2 +-
 fs/jfs/super.c             |   2 +-
 fs/minix/inode.c           |   2 +-
 fs/nfs/inode.c             |   2 +-
 fs/nfs/nfs42xattr.c        |  95 +++++-----
 fs/nilfs2/super.c          |   2 +-
 fs/ntfs/inode.c            |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c     |   2 +-
 fs/ocfs2/super.c           |   2 +-
 fs/openpromfs/inode.c      |   2 +-
 fs/orangefs/super.c        |   2 +-
 fs/overlayfs/super.c       |   2 +-
 fs/proc/inode.c            |   2 +-
 fs/qnx4/inode.c            |   2 +-
 fs/qnx6/inode.c            |   2 +-
 fs/reiserfs/super.c        |   2 +-
 fs/romfs/super.c           |   2 +-
 fs/squashfs/super.c        |   2 +-
 fs/sysv/inode.c            |   2 +-
 fs/ubifs/super.c           |   2 +-
 fs/udf/super.c             |   2 +-
 fs/ufs/super.c             |   2 +-
 fs/vboxsf/super.c          |   2 +-
 fs/xfs/xfs_icache.c        |   3 +-
 fs/zonefs/super.c          |   2 +-
 include/linux/fs.h         |   7 +
 include/linux/list_lru.h   |  24 +--
 include/linux/memcontrol.h |  31 ++--
 include/linux/slab.h       |   4 +
 include/linux/swap.h       |   5 +-
 include/linux/xarray.h     |   9 +-
 ipc/mqueue.c               |   2 +-
 lib/xarray.c               |  10 +-
 mm/list_lru.c              | 430 +++++++++++++++++++++------------------------
 mm/memcontrol.c            | 154 +++-------------
 mm/shmem.c                 |   2 +-
 mm/slab.c                  |  39 ++--
 mm/slab.h                  |  17 +-
 mm/slub.c                  |  42 +++--
 mm/workingset.c            |   2 +-
 net/socket.c               |   2 +-
 net/sunrpc/rpc_pipe.c      |   2 +-
 73 files changed, 460 insertions(+), 529 deletions(-)

-- 
2.11.0

