Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC46A739AF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjFVIzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjFVIy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:54:28 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9461BFA
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b693afe799so2463495ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1687424042; x=1690016042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18F0YS9tzXnhZD6XOWg4z/iuVQH+DQZqb8vPxg9LKNc=;
        b=bUEjGGPBWzIMiiRBz0Z9HpEnEYWJQPKAu3xmR2QNx+U2rfpQIaz0QKy6Y8Lr0rwlY7
         1OLme9KEsNQn8XGK2qGb8bZZEKsTy6KCerwTW6t8BlrnGEHcJPoTeYVlsTwqVPjOayrF
         dsEDpR3qeM/IUUmwBI2Ol2NBy7oFP9Se6fdmGr198St9q6UTySsYC0xYY8Zy/QXRUyEy
         AG08aZMF6NePIP4V69qmLzCv7Cf9ff6kYyyIu+49L68vu9KAD2GfEPQ4jIPGdqKLdU8u
         4wTK5NlERU3NRVU+OLlSCld8xhStDAuDuZWrYsxpaNciHdM6zTbgIxYaNbWQg2PSdYTJ
         19HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424042; x=1690016042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18F0YS9tzXnhZD6XOWg4z/iuVQH+DQZqb8vPxg9LKNc=;
        b=EYZxnXn0Xl9PUQmnDv2TNPU3gyMhZjig1meG2ZHKWiKdb6UI3xR/xD7v5zLXJ8RMXi
         kGBeQIj/PvotDrNHjQCOm8GkBEJkuzBPoAuNIOPodWYVekIsGdIkBUPGVkML54+qHuFz
         a2XUHLKTnBWOTuIkeOFEUxmlFlswCcxH3LWC4mnjbvBLA8Ixqy7kPng9sKuARouZ2DS0
         oTjHOEoVNZc1gChNv7TgzmzS3W5vawu29RUxzpmc8tkXqdPTXd34uZTVFpvyOEzVg/I7
         wMXIBPojWEjrvyCu3YjYz8qVyBQcQJLgMLyUqwzPj6bnh3UcwR5BmuudvuVGUnhE4BcV
         7zzg==
X-Gm-Message-State: AC+VfDznk5IP/M5lCx/Ud7wORkSlQtSEylSHD/ejbDYIQACB7ofgODv4
        EhyjXcOt7i8I+G9bqblTHWnTmA==
X-Google-Smtp-Source: ACHHUZ7tnYlzDA7Fu4iKKHZ/SyjbSwiKqkCQ8vesEKB/Fu9/UuDv/k/NRhRg959nnXG3X3ZwdczzWg==
X-Received: by 2002:a17:902:ea01:b0:1a9:6467:aa8d with SMTP id s1-20020a170902ea0100b001a96467aa8dmr21668996plg.1.1687424042552;
        Thu, 22 Jun 2023 01:54:02 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b001b549fce345sm4806971plw.230.2023.06.22.01.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:54:02 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, dm-devel@redhat.com,
        linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 00/29] use refcount+RCU method to implement lockless slab shrink
Date:   Thu, 22 Jun 2023 16:53:06 +0800
Message-Id: <20230622085335.77010-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

1. Background
=============

We used to implement the lockless slab shrink with SRCU [1], but then kernel
test robot reported -88.8% regression in stress-ng.ramfs.ops_per_sec test
case [2], so we reverted it [3].

This patch series aims to re-implement the lockless slab shrink using the
refcount+RCU method proposed by Dave Chinner [4].

[1]. https://lore.kernel.org/lkml/20230313112819.38938-1-zhengqi.arch@bytedance.com/
[2]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[3]. https://lore.kernel.org/all/20230609081518.3039120-1-qi.zheng@linux.dev/
[4]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

2. Implementation
=================

Currently, the shrinker instances can be divided into the following three types:

a) global shrinker instance statically defined in the kernel, such as
   workingset_shadow_shrinker.

b) global shrinker instance statically defined in the kernel modules, such as
   mmu_shrinker in x86.

c) shrinker instance embedded in other structures.

For *case a*, the memory of shrinker instance is never freed. For *case b*, the
memory of shrinker instance will be freed after the module is unloaded. But we
will call synchronize_rcu() in free_module() to wait for RCU read-side critical
section to exit. For *case c*, we need to dynamically allocate these shrinker
instances, then the memory of shrinker instance can be dynamically freed alone
by calling kfree_rcu(). Then we can use rcu_read_{lock,unlock}() to ensure that
the shrinker instance is valid.

The shrinker::refcount mechanism ensures that the shrinker instance will not be
run again after unregistration. So the structure that records the pointer of
shrinker instance can be safely freed without waiting for the RCU read-side
critical section.

In this way, while we implement the lockless slab shrink, we don't need to be
blocked in unregister_shrinker() to wait RCU read-side critical section.

PATCH 1 ~ 2: infrastructure for dynamically allocating shrinker instances
PATCH 3 ~ 21: dynamically allocate the shrinker instances in case c
PATCH 22: introduce pool_shrink_rwsem to implement private synchronize_shrinkers()
PATCH 23 ~ 28: implement the lockless slab shrink
PATCH 29: move shrinker-related code into a separate file

3. Testing
==========

3.1 slab shrink stress test
---------------------------

We can reproduce the down_read_trylock() hotspot through the following script:

```

DIR="/root/shrinker/memcg/mnt"

do_create()
{
    mkdir -p /sys/fs/cgroup/memory/test
    mkdir -p /sys/fs/cgroup/perf_event/test
    echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
    for i in `seq 0 $1`;
    do
        mkdir -p /sys/fs/cgroup/memory/test/$i;
        echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
        echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
        mkdir -p $DIR/$i;
    done
}

do_mount()
{
    for i in `seq $1 $2`;
    do
        mount -t tmpfs $i $DIR/$i;
    done
}

do_touch()
{
    for i in `seq $1 $2`;
    do
        echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
        echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
            dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
    done
}

case "$1" in
  touch)
    do_touch $2 $3
    ;;
  test)
    do_create 4000
    do_mount 0 4000
    do_touch 0 3000
    ;;
  *)
    exit 1
    ;;
esac
```

Save the above script, then run test and touch commands. Then we can use the
following perf command to view hotspots:

perf top -U -F 999 [-g]

1) Before applying this patchset:

  35.34%  [kernel]             [k] down_read_trylock
  18.44%  [kernel]             [k] shrink_slab
  15.98%  [kernel]             [k] pv_native_safe_halt
  15.08%  [kernel]             [k] up_read
   5.33%  [kernel]             [k] idr_find
   2.71%  [kernel]             [k] _find_next_bit
   2.21%  [kernel]             [k] shrink_node
   1.29%  [kernel]             [k] shrink_lruvec
   0.66%  [kernel]             [k] do_shrink_slab
   0.33%  [kernel]             [k] list_lru_count_one
   0.33%  [kernel]             [k] __radix_tree_lookup
   0.25%  [kernel]             [k] mem_cgroup_iter

-   82.19%    19.49%  [kernel]                  [k] shrink_slab
   - 62.00% shrink_slab
        36.37% down_read_trylock
        15.52% up_read
        5.48% idr_find
        3.38% _find_next_bit
      + 0.98% do_shrink_slab

2) After applying this patchset:

  46.83%  [kernel]           [k] shrink_slab
  20.52%  [kernel]           [k] pv_native_safe_halt
   8.85%  [kernel]           [k] do_shrink_slab
   7.71%  [kernel]           [k] _find_next_bit
   1.72%  [kernel]           [k] xas_descend
   1.70%  [kernel]           [k] shrink_node
   1.44%  [kernel]           [k] shrink_lruvec
   1.43%  [kernel]           [k] mem_cgroup_iter
   1.28%  [kernel]           [k] xas_load
   0.89%  [kernel]           [k] super_cache_count
   0.84%  [kernel]           [k] xas_start
   0.66%  [kernel]           [k] list_lru_count_one

-   65.50%    40.44%  [kernel]                  [k] shrink_slab
   - 22.96% shrink_slab
        13.11% _find_next_bit
      - 9.91% do_shrink_slab
         - 1.59% super_cache_count
              0.92% list_lru_count_one

We can see that the first perf hotspot becomes shrink_slab, which is what we
expect.

3.2 registeration and unregisteration stress test
-------------------------------------------------

Run the command below to test:

stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &

1) Before applying this patchset:

 setting to a 60 second run per stressor
 dispatching hogs: 9 ramfs
 stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
 ramfs            880623     60.02      7.71    226.93     14671.45        3753.09
 ramfs:
          1 System Management Interrupt
 for a 60.03s run time:
    5762.40s available CPU time
       7.71s user time   (  0.13%)
     226.93s system time (  3.94%)
     234.64s total time  (  4.07%)
 load average: 8.54 3.06 2.11
 passed: 9: ramfs (9)
 failed: 0
 skipped: 0
 successful run completed in 60.03s (1 min, 0.03 secs)

2) After applying this patchset:

 setting to a 60 second run per stressor
 dispatching hogs: 9 ramfs
 stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
 ramfs            847562     60.02      7.44    230.22     14120.66        3566.23
 ramfs:
          4 System Management Interrupts
 for a 60.12s run time:
    5771.95s available CPU time
       7.44s user time   (  0.13%)
     230.22s system time (  3.99%)
     237.66s total time  (  4.12%)
 load average: 8.18 2.43 0.84
 passed: 9: ramfs (9)
 failed: 0
 skipped: 0
 successful run completed in 60.12s (1 min, 0.12 secs)

We can see that the ops/s has hardly changed.

This series is based on next-20230613.

Comments and suggestions are welcome.

Thanks,
Qi.

Qi Zheng (29):
  mm: shrinker: add shrinker::private_data field
  mm: vmscan: introduce some helpers for dynamically allocating shrinker
  drm/i915: dynamically allocate the i915_gem_mm shrinker
  drm/msm: dynamically allocate the drm-msm_gem shrinker
  drm/panfrost: dynamically allocate the drm-panfrost shrinker
  dm: dynamically allocate the dm-bufio shrinker
  dm zoned: dynamically allocate the dm-zoned-meta shrinker
  md/raid5: dynamically allocate the md-raid5 shrinker
  bcache: dynamically allocate the md-bcache shrinker
  vmw_balloon: dynamically allocate the vmw-balloon shrinker
  virtio_balloon: dynamically allocate the virtio-balloon shrinker
  mbcache: dynamically allocate the mbcache shrinker
  ext4: dynamically allocate the ext4-es shrinker
  jbd2,ext4: dynamically allocate the jbd2-journal shrinker
  NFSD: dynamically allocate the nfsd-client shrinker
  NFSD: dynamically allocate the nfsd-reply shrinker
  xfs: dynamically allocate the xfs-buf shrinker
  xfs: dynamically allocate the xfs-inodegc shrinker
  xfs: dynamically allocate the xfs-qm shrinker
  zsmalloc: dynamically allocate the mm-zspool shrinker
  fs: super: dynamically allocate the s_shrink
  drm/ttm: introduce pool_shrink_rwsem
  mm: shrinker: add refcount and completion_wait fields
  mm: vmscan: make global slab shrink lockless
  mm: vmscan: make memcg slab shrink lockless
  mm: shrinker: make count and scan in shrinker debugfs lockless
  mm: vmscan: hold write lock to reparent shrinker nr_deferred
  mm: shrinkers: convert shrinker_rwsem to mutex
  mm: shrinker: move shrinker-related code into a separate file

 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |  27 +-
 drivers/gpu/drm/i915/i915_drv.h               |   3 +-
 drivers/gpu/drm/msm/msm_drv.h                 |   2 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |  25 +-
 drivers/gpu/drm/panfrost/panfrost_device.h    |   2 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  24 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  15 +
 drivers/md/bcache/bcache.h                    |   2 +-
 drivers/md/bcache/btree.c                     |  23 +-
 drivers/md/bcache/sysfs.c                     |   2 +-
 drivers/md/dm-bufio.c                         |  23 +-
 drivers/md/dm-cache-metadata.c                |   2 +-
 drivers/md/dm-thin-metadata.c                 |   2 +-
 drivers/md/dm-zoned-metadata.c                |  25 +-
 drivers/md/raid5.c                            |  28 +-
 drivers/md/raid5.h                            |   2 +-
 drivers/misc/vmw_balloon.c                    |  16 +-
 drivers/virtio/virtio_balloon.c               |  26 +-
 fs/btrfs/super.c                              |   2 +-
 fs/ext4/ext4.h                                |   2 +-
 fs/ext4/extents_status.c                      |  21 +-
 fs/jbd2/journal.c                             |  32 +-
 fs/kernfs/mount.c                             |   2 +-
 fs/mbcache.c                                  |  39 +-
 fs/nfsd/netns.h                               |   4 +-
 fs/nfsd/nfs4state.c                           |  20 +-
 fs/nfsd/nfscache.c                            |  33 +-
 fs/proc/root.c                                |   2 +-
 fs/super.c                                    |  40 +-
 fs/xfs/xfs_buf.c                              |  25 +-
 fs/xfs/xfs_buf.h                              |   2 +-
 fs/xfs/xfs_icache.c                           |  27 +-
 fs/xfs/xfs_mount.c                            |   4 +-
 fs/xfs/xfs_mount.h                            |   2 +-
 fs/xfs/xfs_qm.c                               |  24 +-
 fs/xfs/xfs_qm.h                               |   2 +-
 include/linux/fs.h                            |   2 +-
 include/linux/jbd2.h                          |   2 +-
 include/linux/shrinker.h                      |  35 +-
 mm/Makefile                                   |   4 +-
 mm/shrinker.c                                 | 750 ++++++++++++++++++
 mm/shrinker_debug.c                           |  26 +-
 mm/vmscan.c                                   | 702 ----------------
 mm/zsmalloc.c                                 |  28 +-
 44 files changed, 1128 insertions(+), 953 deletions(-)
 create mode 100644 mm/shrinker.c

-- 
2.30.2

