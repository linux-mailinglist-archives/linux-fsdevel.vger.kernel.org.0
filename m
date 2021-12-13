Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E9F473249
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhLMQyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhLMQyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:54:18 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F33C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:54:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id j11so15079548pgs.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqjSN5Zf68fDFKSv1YC0dtDeC2MHBxNuGQn4JvLKQpU=;
        b=MYZQ1oXTn5YhzAhbHSKzhDte1Z1gE+M1dwIod9vuuytj0SAaYXmayPvGCtAhFt+ydY
         vRxj3wF33ym/r+p9LiXTOFqS0m5GnJtRlzwxpNiUhipl81MOB212ybfVdSgBEPtAFCrT
         tq1am/fBB7tLByx7qRlMh5A81fn3uUjqUQAvMuu1PRlupNZ0JaIjOTQOzx9MgJ7KEwxo
         h3AZnqjyQ9Jgo51C+85INnW6fxNhBVPpqdiO5wPe0ew2Z3MxgdLPlbE74BDsBdEsbXl5
         JrJkFPA24BUEDd34SPBdymXyZsD4PED/EG8coHRs+ZDjszZ2jbTPeyptW8RQJJijNC4r
         ot7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gqjSN5Zf68fDFKSv1YC0dtDeC2MHBxNuGQn4JvLKQpU=;
        b=SzpmVa97YKJvHK1t/ueOJlh+z3C2QGZa3Ms5E7c5ClG2o5vtrMNFwvO7OvmyjsfCEp
         juIP+yEQmbr+v3kxTq8CIHbVa57b69BwG3HmxQD0YC+rXAijqVn3v8VSHyepBImDDZLE
         NEKaI8SJspYHbrlOfq0eLOqAkCzHsuqwPBFGXNV56H7apT9Vx4UG+i65nkJ2eMekkLPq
         XKYIdT2UwffS9ehQSUM+03pqX4I15JwUutJqhNi7/DG1NO9OKg7j5qr6p9gH3f3pNpPt
         Sq9sqbL8FNFPdqKgR+LjRJTRb3sHqr2xRDtSd7Q4tzIYpYfyPh6emdTZhL9PAJYYXDiu
         qV/Q==
X-Gm-Message-State: AOAM5315PsTzPQ3mnl1q9YS+uzKPjNiexMP7367yaRet5JISbQK1gnWl
        UBBzH7JGjhfpmMYWHyirF3fT+w==
X-Google-Smtp-Source: ABdhPJyJWKTSuYCj5LBirqVQPTSh2Tb5D3YLHBN5B9T+/njJbhxKak2vo5R7P3pqm3ctL3LFEU5kBQ==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr53922737pgc.76.1639414457586;
        Mon, 13 Dec 2021 08:54:17 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.54.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:54:17 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 00/17] Optimize list lru memory consumption
Date:   Tue, 14 Dec 2021 00:53:25 +0800
Message-Id: <20211213165342.74704-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series is based on Linux 5.16-rc3.

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
reduced to a suitable value. It leads to waste a lot of memory. If we want
to reduce memcg_nr_cache_ids, we have to *reboot* the server. This is not
what we want.

In order to reduce memcg_nr_cache_ids, I had posted a patchset [1] to do
this. But this did not fundamentally solve the problem.

We currently allocate scope for every memcg to be able to tracked on every
superblock instantiated in the system, regardless of whether that superblock
is even accessible to that memcg.

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

I had done a easy test to show the optimization. I create 10k memory cgroups
and mount 10k filesystems in the systems. We use free command to show how many
memory does the systems comsumes after this operation (There are 2 numa nodes
in the system).

        +-----------------------+------------------------+
        |      condition        |   memory consumption   |
        +-----------------------+------------------------+
        | without this patchset |        24464 MB        |
        +-----------------------+------------------------+
        |     after patch 1     |        21957 MB        | <--------+
        +-----------------------+------------------------+          |
        |     after patch 11    |         6895 MB        |          |
        +-----------------------+------------------------+          |
        |     after patch 13    |         4367 MB        |          |
        +-----------------------+------------------------+          |
                                                                    |
        The more the number of nodes, the more obvious the effect---+

BTW, there was a recent discussion [2] on the same issue.

[1] https://lore.kernel.org/linux-fsdevel/20210428094949.43579-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/linux-fsdevel/20210405054848.GA1077931@in.ibm.com/

This series not only optimizes the memory usage of list_lru but also
simplifies the code.

Changelog in v4:
  - Remove some code cleanup patches since they are already merged.
  - Collect Acked-by from Theodore.
  - Fix ntfs3 (Thanks Argillander).

Changelog in v3:
  - Fix mixing advanced and normal XArray concepts (Thanks to Matthew).
  - Split one patch into per-filesystem patches.

Changelog in v2:
  - Update Documentation/filesystems/porting.rst suggested by Dave.
  - Add a comment above alloc_inode_sb() suggested by Dave.
  - Rework some patch's commit log.
  - Add patch 18-21.

  Thanks Dave.

Muchun Song (17):
  mm: list_lru: optimize memory consumption of arrays of per cgroup
    lists
  mm: introduce kmem_cache_alloc_lru
  fs: introduce alloc_inode_sb() to allocate filesystems specific inode
  fs: allocate inode by using alloc_inode_sb()
  f2fs: allocate inode by using alloc_inode_sb()
  nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
  mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
  xarray: use kmem_cache_alloc_lru to allocate xa_node
  mm: workingset: use xas_set_lru() to pass shadow_nodes
  mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
  mm: list_lru: allocate list_lru_one only when needed
  mm: list_lru: rename memcg_drain_all_list_lrus to
    memcg_reparent_list_lrus
  mm: list_lru: replace linear array with xarray
  mm: memcontrol: reuse memory cgroup ID for kmem ID
  mm: memcontrol: fix cannot alloc the maximum memcg ID
  mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
  mm: memcontrol: rename memcg_cache_id to memcg_kmem_id

 Documentation/filesystems/porting.rst |   5 +
 block/bdev.c                          |   2 +-
 drivers/dax/super.c                   |   2 +-
 fs/9p/vfs_inode.c                     |   2 +-
 fs/adfs/super.c                       |   2 +-
 fs/affs/super.c                       |   2 +-
 fs/afs/super.c                        |   2 +-
 fs/befs/linuxvfs.c                    |   2 +-
 fs/bfs/inode.c                        |   2 +-
 fs/btrfs/inode.c                      |   2 +-
 fs/ceph/inode.c                       |   2 +-
 fs/cifs/cifsfs.c                      |   2 +-
 fs/coda/inode.c                       |   2 +-
 fs/dcache.c                           |   3 +-
 fs/ecryptfs/super.c                   |   2 +-
 fs/efs/super.c                        |   2 +-
 fs/erofs/super.c                      |   2 +-
 fs/exfat/super.c                      |   2 +-
 fs/ext2/super.c                       |   2 +-
 fs/ext4/super.c                       |   2 +-
 fs/f2fs/super.c                       |   8 +-
 fs/fat/inode.c                        |   2 +-
 fs/freevxfs/vxfs_super.c              |   2 +-
 fs/fuse/inode.c                       |   2 +-
 fs/gfs2/super.c                       |   2 +-
 fs/hfs/super.c                        |   2 +-
 fs/hfsplus/super.c                    |   2 +-
 fs/hostfs/hostfs_kern.c               |   2 +-
 fs/hpfs/super.c                       |   2 +-
 fs/hugetlbfs/inode.c                  |   2 +-
 fs/inode.c                            |   2 +-
 fs/isofs/inode.c                      |   2 +-
 fs/jffs2/super.c                      |   2 +-
 fs/jfs/super.c                        |   2 +-
 fs/minix/inode.c                      |   2 +-
 fs/nfs/inode.c                        |   2 +-
 fs/nfs/nfs42xattr.c                   |  95 ++++----
 fs/nilfs2/super.c                     |   2 +-
 fs/ntfs/inode.c                       |   2 +-
 fs/ntfs3/super.c                      |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                |   2 +-
 fs/ocfs2/super.c                      |   2 +-
 fs/openpromfs/inode.c                 |   2 +-
 fs/orangefs/super.c                   |   2 +-
 fs/overlayfs/super.c                  |   2 +-
 fs/proc/inode.c                       |   2 +-
 fs/qnx4/inode.c                       |   2 +-
 fs/qnx6/inode.c                       |   2 +-
 fs/reiserfs/super.c                   |   2 +-
 fs/romfs/super.c                      |   2 +-
 fs/squashfs/super.c                   |   2 +-
 fs/sysv/inode.c                       |   2 +-
 fs/ubifs/super.c                      |   2 +-
 fs/udf/super.c                        |   2 +-
 fs/ufs/super.c                        |   2 +-
 fs/vboxsf/super.c                     |   2 +-
 fs/xfs/xfs_icache.c                   |   2 +-
 fs/zonefs/super.c                     |   2 +-
 include/linux/fs.h                    |  11 +
 include/linux/list_lru.h              |  17 +-
 include/linux/memcontrol.h            |  42 ++--
 include/linux/slab.h                  |   3 +
 include/linux/swap.h                  |   5 +-
 include/linux/xarray.h                |   9 +-
 ipc/mqueue.c                          |   2 +-
 lib/xarray.c                          |  10 +-
 mm/list_lru.c                         | 423 ++++++++++++++++------------------
 mm/memcontrol.c                       | 164 +++----------
 mm/shmem.c                            |   2 +-
 mm/slab.c                             |  39 +++-
 mm/slab.h                             |  25 +-
 mm/slob.c                             |   6 +
 mm/slub.c                             |  42 ++--
 mm/workingset.c                       |   2 +-
 net/socket.c                          |   2 +-
 net/sunrpc/rpc_pipe.c                 |   2 +-
 76 files changed, 486 insertions(+), 539 deletions(-)

-- 
2.11.0

