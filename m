Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEE4C6C17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiB1MWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 07:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiB1MWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:22:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2345070868
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:22:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i1so10557914plr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCFerXiCPxcpKLyNdx6afs6aHROa19DCxH4ZSTwVEss=;
        b=lAVHuKfps4dVgtNu+f/E9fvH0TxJ+nuX5cPLAM6rQJRwDD5sqOn8q6qdp/uwxBiBQN
         zJ3GqG+p6+iTXMPjRhL1uYpSA8Vb+t+gQG8BJLHH736MxOCU/mEZgh1KB3spCvPIJ6kV
         DtCAxFqQhw/ngttbKDuITF9zu0rgskOQr0h0aX7Qa3WjQ5XRckmcAGuaN1nJIceONSyc
         2mKL8bRK/yyLOmyBks+8BGNNQUSTo7+ledWxwSiZ/EFwv7VF9iUXFx9Jr1jL4sRzNNT0
         oLj0YfsGmAo6M31zQx3iodummLbuQhtliTq+YUzm2cQgk5rLGcxthP5fOLrEUwb0Ad2a
         LM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCFerXiCPxcpKLyNdx6afs6aHROa19DCxH4ZSTwVEss=;
        b=HtQ/tcXvktCzXfdvKtC2B5QvdoZ4LncyXHzV+SKKnbtnrn6gmoUbJiHf16bNXYiSdZ
         Hw4MTNL7raN015FJCShj82DQy3DkQ+bQz8KMVcd2byC5EFJ0cyxfXfGKgBXI50d5zCMD
         HvWmGksgs6jHxyuqtEfcYIVCjuvW0qDibcBkhRRszex/g1yZ/L+CGzHDraObo5es6BYn
         Bjm3/gDDkYM13SACkLHIbAcQrL/0+JLKYyJWn4KR0BXlL/uK+IW+W8exO0pn+qX+xpqm
         ZrtYhLmLhF/z9aHkmOMQKaxu/lLrEo61iHttWYf6KONDJWLXCAeO/nWXzZikgiChun0m
         MGag==
X-Gm-Message-State: AOAM530DK1IUl/8Se7Yc4qXTKTPCPtaMFHbCb4jfgFMu/T+Q1vLegjpO
        8mHPhAG1TntnbT2XtEQo777e1w==
X-Google-Smtp-Source: ABdhPJy0UNWl2R15dNupeH455A7bg7D94HM1445CiSwf49TsplmM/Vjq5kfgEKp1eWPtJ6EdWTEwRg==
X-Received: by 2002:a17:903:1246:b0:14f:e51e:baa7 with SMTP id u6-20020a170903124600b0014fe51ebaa7mr20311477plh.159.1646050933556;
        Mon, 28 Feb 2022 04:22:13 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:22:13 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 00/16] Optimize list lru memory consumption
Date:   Mon, 28 Feb 2022 20:21:10 +0800
Message-Id: <20220228122126.37293-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series is based on Linux v5.17-rc5. And I have replaced Roman's email
in Acked-by and Reviewed-by tags to roman.gushchin@linux.dev.

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
        |     after patch 10    |         6895 MB        |          |
        +-----------------------+------------------------+          |
        |     after patch 12    |         4367 MB        |          |
        +-----------------------+------------------------+          |
                                                                    |
        The more the number of nodes, the more obvious the effect---+

BTW, there was a recent discussion [2] on the same issue.

[1] https://lore.kernel.org/all/20210428094949.43579-1-songmuchun@bytedance.com/
[2] https://lore.kernel.org/all/20210405054848.GA1077931@in.ibm.com/

This series not only optimizes the memory usage of list_lru but also
simplifies the code.

v5: https://lore.kernel.org/all/20211220085649.8196-1-songmuchun@bytedance.com/
v4: https://lore.kernel.org/all/20211213165342.74704-1-songmuchun@bytedance.com/
v3: https://lore.kernel.org/all/20210914072938.6440-1-songmuchun@bytedance.com/
v2: https://lore.kernel.org/all/20210527062148.9361-1-songmuchun@bytedance.com/
v1: https://lore.kernel.org/all/20210511104647.604-1-songmuchun@bytedance.com/

v6:
  - Collect Acked-by from Roman and replace his old email with
    roman.gushchin@linux.dev.
  - Rework patch 1's commit log suggested by Roman.
  - Reuse memory cgroup ID for kmem ID directly suggested by Mika Penttilä.
  - Add a couple of words to Documentation/filesystems/porting.rst suggested
    by Roman.

  Thanks for your review.

v5:
  - Fix sleeping from atomic context reported by kernel test robot.
  - Add a figure to patch 1 suggested by Johannes.
  - Squash patch 9 into patch 8 suggested by Johannes.
  - Remove LRUS_CLEAR_MASK and use GFP_RECLAIM_MASK directly suggested
    by Johannes.
  - Collect Acked-by from Johannes.

v4:
  - Remove some code cleanup patches since they are already merged.
  - Collect Acked-by from Theodore.

v3:
  - Fix mixing advanced and normal XArray concepts (Thanks to Matthew).
  - Split one patch into per-filesystem patches.

v2:
  - Update Documentation/filesystems/porting.rst suggested by Dave.
  - Add a comment above alloc_inode_sb() suggested by Dave.
  - Rework some patch's commit log.
  - Add patch 18-21.

Muchun Song (16):
  mm: list_lru: transpose the array of per-node per-memcg lru lists
  mm: introduce kmem_cache_alloc_lru
  fs: introduce alloc_inode_sb() to allocate filesystems specific inode
  fs: allocate inode by using alloc_inode_sb()
  f2fs: allocate inode by using alloc_inode_sb()
  nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
  mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
  xarray: use kmem_cache_alloc_lru to allocate xa_node
  mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
  mm: list_lru: allocate list_lru_one only when needed
  mm: list_lru: rename memcg_drain_all_list_lrus to
    memcg_reparent_list_lrus
  mm: list_lru: replace linear array with xarray
  mm: memcontrol: reuse memory cgroup ID for kmem ID
  mm: memcontrol: fix cannot alloc the maximum memcg ID
  mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
  mm: memcontrol: rename memcg_cache_id to memcg_kmem_id

 Documentation/filesystems/porting.rst |   6 +
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
 include/linux/memcontrol.h            |  41 ++--
 include/linux/slab.h                  |   3 +
 include/linux/swap.h                  |   5 +-
 include/linux/xarray.h                |   9 +-
 ipc/mqueue.c                          |   2 +-
 lib/xarray.c                          |  10 +-
 mm/list_lru.c                         | 417 ++++++++++++++++------------------
 mm/memcontrol.c                       | 160 ++-----------
 mm/shmem.c                            |   2 +-
 mm/slab.c                             |  39 +++-
 mm/slab.h                             |  25 +-
 mm/slob.c                             |   6 +
 mm/slub.c                             |  42 ++--
 mm/workingset.c                       |   2 +-
 net/socket.c                          |   2 +-
 net/sunrpc/rpc_pipe.c                 |   2 +-
 76 files changed, 476 insertions(+), 539 deletions(-)

-- 
2.11.0

