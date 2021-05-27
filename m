Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B2B392754
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 08:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhE0GZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhE0GZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 02:25:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B628C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lr4-20020a17090b4b84b02901600455effdso592873pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOTZxfCEr4ZNWQOtZn8X4+7qZY2gbC2MR3ZoQCk6Qkc=;
        b=vvZ3oWYZXlqGw30FL5OCcoEShT4Jd9B4fAD2B1abrSVHonScGSrRJKqspTK63Lygb+
         mIorpIrfSts5eSKAl9Znz+vaa2zuIrlLJlKQ218nkf902HldyO47p4IGwK6+Yq+VzW8Y
         uPNozKtSea8hI+zcEAEFn++fd+gFEI1j6DRt4HRghdZW+TUWRLhhugkrpZgh2D8yT05U
         yibV6+AlhQVlkSS+0+bi9n/GU3eaZNPg+ooulu01TSp9sdGMO1uOueRFRf0/vVidBDRN
         7ZqqWUjFBvdJtSwuVtTE9lJyl6THSEV27RAIADbnTGVSBXTr0DT/wvPDvXrcHEL8tKwa
         QX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOTZxfCEr4ZNWQOtZn8X4+7qZY2gbC2MR3ZoQCk6Qkc=;
        b=HS/XTMKx0rYl/RPqAmBxUK87QM+sfvglfEAYZ/sC4P8EgZcwi1KLuXwwjN8ezHWcUy
         YNpwVTiyrDx7IoFz99bMCNhvHbArMsPVkNyPYi2dWpjitQ6AY5goHQaNLAxOLm1IFgv4
         Y68iWdx0SlMLxhGdog1ZDqsO1OLtQ0zyUq+cOhq02/jVSQlf8i9EkBTbgUaWwCiLhoJA
         cUCeVpM5akSN2RQ3i+J6hKDiCdQekHsORuBm9gHqlC00pM/15bu65ndFSYWz7WSx6aPv
         4hUQxMD2jo1RP2obV+allLfiqdxROPpZgyg9r1BJETqQjfJ43zX9EU1x0Z2fWVEaaTpr
         F6XA==
X-Gm-Message-State: AOAM531Eleo3tHIpVz7vG0dhsCuQm0Hy5KkUCEdHqs0A2ENV8NkRjgOr
        mZbxeo+Xcd3iBf5FeopezDGEug==
X-Google-Smtp-Source: ABdhPJztM2gdTpq3LWt1dphs56P5VbOl0qn5Dk80JuZ1V4JijOEM3mtuwuEEXzhP7u5fnq0AqYqtbg==
X-Received: by 2002:a17:903:1c3:b029:f4:9624:2c69 with SMTP id e3-20020a17090301c3b02900f496242c69mr1872542plh.51.1622096652636;
        Wed, 26 May 2021 23:24:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.24.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:24:12 -0700 (PDT)
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
Subject: [PATCH v2 00/21] Optimize list lru memory consumption
Date:   Thu, 27 May 2021 14:21:27 +0800
Message-Id: <20210527062148.9361-1-songmuchun@bytedance.com>
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

Patch 1-6 are code simplification.
Patch 7 converts the array from per-memcg per-node to per-memcg
Patch 8 is code simplification.
Patch 9-15 let list_lru allocation dynamically.
Patch 16 is code cleanup.
Patch 17 use xarray to optimize per memcg pointer array size.
Patch 18-21 is code simplification.

I had done a easy test to show the optimization. I create 10k memory cgroups
and mount 10k filesystems in the systems. We use free command to show how many
memory does the systems comsumes after this operation (There are 2 numa nodes
in the system).

        +-----------------------+------------------------+
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

Changelog in v2:
  1. Update Documentation/filesystems/porting.rst suggested by Dave.
  2. Add a comment above alloc_inode_sb() suggested by Dave.
  2. Rework some patch's commit log.
  3. Add patch 18-21.

  Thanks Dave.

Muchun Song (21):
  mm: list_lru: fix list_lru_count_one() return value
  mm: memcontrol: remove kmemcg_id reparenting
  mm: memcontrol: remove the kmem states
  mm: memcontrol: do it in mem_cgroup_css_online to make the kmem online
  mm: list_lru: remove lru node locking from memcg_update_list_lru_node
  mm: list_lru: only add the memcg aware lrus to the list_lrus
  mm: list_lru: optimize the array of per memcg lists memory consumption
  mm: list_lru: remove memcg_aware field from struct list_lru
  mm: introduce kmem_cache_alloc_lru
  fs: introduce alloc_inode_sb() to allocate filesystems specific inode
  mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
  xarray: use kmem_cache_alloc_lru to allocate xa_node
  mm: workingset: use xas_set_lru() to pass shadow_nodes
  nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
  mm: list_lru: allocate list_lru_one only when needed
  mm: list_lru: rename memcg_drain_all_list_lrus to
    memcg_reparent_list_lrus
  mm: list_lru: replace linear array with xarray
  mm: memcontrol: reuse memory cgroup ID for kmem ID
  mm: memcontrol: fix cannot alloc the maximum memcg ID
  mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
  mm: memcontrol: rename memcg_cache_id to memcg_kmem_id

 Documentation/filesystems/porting.rst |   5 +
 drivers/dax/super.c                   |   2 +-
 fs/9p/vfs_inode.c                     |   2 +-
 fs/adfs/super.c                       |   2 +-
 fs/affs/super.c                       |   2 +-
 fs/afs/super.c                        |   2 +-
 fs/befs/linuxvfs.c                    |   2 +-
 fs/bfs/inode.c                        |   2 +-
 fs/block_dev.c                        |   2 +-
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
 fs/f2fs/super.c                       |   2 +-
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
 fs/xfs/xfs_icache.c                   |   3 +-
 fs/zonefs/super.c                     |   2 +-
 include/linux/fs.h                    |  11 +
 include/linux/list_lru.h              |  18 +-
 include/linux/memcontrol.h            |  48 ++--
 include/linux/slab.h                  |   4 +
 include/linux/swap.h                  |   5 +-
 include/linux/xarray.h                |   9 +-
 ipc/mqueue.c                          |   2 +-
 lib/xarray.c                          |  10 +-
 mm/list_lru.c                         | 447 +++++++++++++++++-----------------
 mm/memcontrol.c                       | 185 ++------------
 mm/shmem.c                            |   2 +-
 mm/slab.c                             |  39 ++-
 mm/slab.h                             |  17 +-
 mm/slub.c                             |  42 ++--
 mm/workingset.c                       |   2 +-
 net/socket.c                          |   2 +-
 net/sunrpc/rpc_pipe.c                 |   2 +-
 74 files changed, 480 insertions(+), 577 deletions(-)

-- 
2.11.0

