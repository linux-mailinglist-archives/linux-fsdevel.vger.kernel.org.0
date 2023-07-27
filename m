Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7D764A9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjG0IK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjG0IKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:10:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8526BA
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:06:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f74a8992so77080b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445148; x=1691049948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdw/R1TEr1q6uUENoD+Woah5iYuWx4u9kScfP8x1rxA=;
        b=UUJaeFKAdq/JSi5KDicB1qh4QBmRcV8RkxHtwurNfyrC9pvt0PpJjH65AQH5l7q+9C
         LBSbbXBKaKVPiOBm5Fcd7UwqnCv/nEH/yt0y5LrhuYjiTeYJnf52fAGE42aPOuO3ed4I
         CH7E03GStk9tqzsUMP9cj27lKTUxq4yf7rn8YSn3a1/cGCpMeTGgVRRuuMbsr0zMmRBv
         oFevVOT5MMhRX1z1WtEnmwtuG+UoVxDf5GDWIQJoDIkeB0n3AbOwh1FoMsy9IWleLQsE
         a2RKQ5yrgmmGdYoGmSpmONZKAmN9Gsyqp+HtxmVjQ9FehgBv4a+hpgIRjC2ZmCuobuW+
         eCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445148; x=1691049948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdw/R1TEr1q6uUENoD+Woah5iYuWx4u9kScfP8x1rxA=;
        b=YODz5thgjby9v7e2gfMnq7S03QNgFPv952TZi0HOMPWEvZxO01YjN+VGg+d8MnBsIK
         2tta0lXCc0XENGsEQMBtiYls20DsKUVoqykRT8814Vj0JH1y+esXGgGdOUAmSPH6xBv6
         Jai+A1mz4MU7x7WH036UUrDEgjVaDAhnsTqUs7BqFPRZwakMDJ6zSbZLUMA1LwKyVY16
         02MQLrxkMB2vac/ocDBZLqyTRcKgJQljbBgC/JlyuJvoV/QA5SC/pQoiXfhEkHn2j5Aj
         U5VUTKMIg+hcwQ+nAgMtv/ugK00JrHo4GcJzqTqXPupJSukk43jtAeWMxZ9fY2f1JM+r
         cw4Q==
X-Gm-Message-State: ABy/qLYrRMWzsULqNZ0rZw3fJulSoOLyHxcwAR+51tf9D+WtGkyLickF
        vnfFjhXy9sTcIk9QYO+UKvVb1FIalzHPrIWKBvw=
X-Google-Smtp-Source: APBJJlHb1kgnpQXfb8RS/UAhh8zGcgdqY4J3wYE+oXj/zAg8rYeLxmGzIhYoi+ua72NIH6S8sFTnXQ==
X-Received: by 2002:a05:6a20:1595:b0:137:30db:bc1e with SMTP id h21-20020a056a20159500b0013730dbbc1emr5685837pzj.3.1690445147652;
        Thu, 27 Jul 2023 01:05:47 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:05:47 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 00/49] use refcount+RCU method to implement lockless slab shrink
Date:   Thu, 27 Jul 2023 16:04:13 +0800
Message-Id: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

For case a, the memory of shrinker instance is never freed. For case b, the
memory of shrinker instance will be freed after synchronize_rcu() when the
module is unloaded. For case c, the memory of shrinker instance will be freed
along with the structure it is embedded in.

In preparation for implementing lockless slab shrink, we need to dynamically
allocate those shrinker instances in case c, then the memory can be dynamically
freed alone by calling kfree_rcu().

This patchset adds the following new APIs for dynamically allocating shrinker,
and add a private_data field to struct shrinker to record and get the original
embedded structure.

1. shrinker_alloc()
2. shrinker_register()
3. shrinker_free()

In order to simplify shrinker-related APIs and make shrinker more independent of
other kernel mechanisms, this patchset uses the above APIs to convert all
shrinkers (including case a and b) to dynamically allocated, and then remove all
existing APIs. This will also have another advantage mentioned by Dave Chinner:

```
The other advantage of this is that it will break all the existing out of tree
code and third party modules using the old API and will no longer work with a
kernel using lockless slab shrinkers. They need to break (both at the source and
binary levels) to stop bad things from happening due to using uncoverted
shrinkers in the new setup.
```

Then we free the shrinker by calling call_rcu(), and use rcu_read_{lock,unlock}()
to ensure that the shrinker instance is valid. And the shrinker::refcount
mechanism ensures that the shrinker instance will not be run again after
unregistration. So the structure that records the pointer of shrinker instance
can be safely freed without waiting for the RCU read-side critical section.

In this way, while we implement the lockless slab shrink, we don't need to be
blocked in unregister_shrinker() to wait RCU read-side critical section.

PATCH 1: fix memory leak in binder_init()
PATCH 2: move some shrinker-related function declarations to mm/internal.h
PATCH 3: move shrinker-related code into a separate file
PATCH 4: remove redundant shrinker_rwsem in debugfs operations
PATCH 5: add infrastructure for dynamically allocating shrinker
PATCH 6 ~ 23: dynamically allocate the shrinker instances in case a and b
PATCH 24 ~ 42: dynamically allocate the shrinker instances in case c
PATCH 43: remove old APIs
PATCH 44: introduce pool_shrink_rwsem to implement private synchronize_shrinkers()
PATCH 45: add a secondary array for shrinker_info::{map, nr_deferred}
PATCH 46 ~ 47: implement the lockless slab shrink
PATCH 48 ~ 49: convert shrinker_rwsem to mutex

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
    echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
    for i in `seq 0 $1`;
    do
        mkdir -p /sys/fs/cgroup/memory/test/$i;
        echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
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

perf top -U -F 999

1) Before applying this patchset:

  40.44%  [kernel]            [k] down_read_trylock
  17.59%  [kernel]            [k] up_read
  13.64%  [kernel]            [k] pv_native_safe_halt
  11.90%  [kernel]            [k] shrink_slab
   8.21%  [kernel]            [k] idr_find
   2.71%  [kernel]            [k] _find_next_bit
   1.36%  [kernel]            [k] shrink_node
   0.81%  [kernel]            [k] shrink_lruvec
   0.80%  [kernel]            [k] __radix_tree_lookup
   0.50%  [kernel]            [k] do_shrink_slab
   0.21%  [kernel]            [k] list_lru_count_one
   0.16%  [kernel]            [k] mem_cgroup_iter

2) After applying this patchset:

  60.17%  [kernel]           [k] shrink_slab
  20.42%  [kernel]           [k] pv_native_safe_halt
   3.03%  [kernel]           [k] do_shrink_slab
   2.73%  [kernel]           [k] shrink_node
   2.27%  [kernel]           [k] shrink_lruvec
   2.00%  [kernel]           [k] __rcu_read_unlock
   1.92%  [kernel]           [k] mem_cgroup_iter
   0.98%  [kernel]           [k] __rcu_read_lock
   0.91%  [kernel]           [k] osq_lock
   0.63%  [kernel]           [k] mem_cgroup_calculate_protection
   0.55%  [kernel]           [k] shrinker_put
   0.46%  [kernel]           [k] list_lru_count_one

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
ramfs            735238     60.00     12.37    363.70     12253.05        1955.08
for a 60.01s run time:
   1440.27s available CPU time
     12.36s user time   (  0.86%)
    363.70s system time ( 25.25%)
    376.06s total time  ( 26.11%)
load average: 10.79 4.47 1.69
passed: 9: ramfs (9)
failed: 0
skipped: 0
successful run completed in 60.01s (1 min, 0.01 secs)

2) After applying this patchset:

setting to a 60 second run per stressor
dispatching hogs: 9 ramfs
stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
                          (secs)    (secs)    (secs)   (real time) (usr+sys time)
ramfs            746698     60.00     12.45    376.16     12444.02        1921.47
for a 60.01s run time:
   1440.28s available CPU time
     12.44s user time   (  0.86%)
    376.16s system time ( 26.12%)
    388.60s total time  ( 26.98%)
load average: 9.01 3.85 1.49
passed: 9: ramfs (9)
failed: 0
skipped: 0
successful run completed in 60.01s (1 min, 0.01 secs)

We can see that the ops/s has hardly changed.

This series is based on next-20230726.

Comments and suggestions are welcome.

Thanks,
Qi

Changelog in v2 -> v3:
 - add the patch that [PATCH v3 07/49] depends on
 - move some shrinker-related function declarations to mm/internal.h
   (suggested by Muchun Song)
 - combine shrinker_free_non_registered() and shrinker_unregister() into
   shrinker_free() (suggested by Dave Chinner)
 - add missing __init and fix return value in bch_btree_cache_alloc()
   (pointed by Muchun Song)
 - remove unnecessary WARN_ON() (pointed by Steven Price)
 - go back to use completion to implement lockless slab shrink
   (pointed by Dave Chinner)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20230726.

Changelog in v1 -> v2:
 - implement the new APIs and convert all shrinkers to use it.
   (suggested by Dave Chinner)
 - fix UAF in PATCH [05/29] (pointed by Steven Price)
 - add a secondary array for shrinker_info::{map, nr_deferred}
 - re-implement the lockless slab shrink
   (Since unifying the processing of global and memcg slab shrink needs to
    modify the startup sequence (As I mentioned in https://lore.kernel.org/lkml/38b14080-4ce5-d300-8a0a-c630bca6806b@bytedance.com/),
    I finally choose to process them separately.)
 - collect Acked-bys

Qi Zheng (49):
  binder: fix memory leak in binder_init()
  mm: move some shrinker-related function declarations to mm/internal.h
  mm: vmscan: move shrinker-related code into a separate file
  mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
  mm: shrinker: add infrastructure for dynamically allocating shrinker
  kvm: mmu: dynamically allocate the x86-mmu shrinker
  binder: dynamically allocate the android-binder shrinker
  drm/ttm: dynamically allocate the drm-ttm_pool shrinker
  xenbus/backend: dynamically allocate the xen-backend shrinker
  erofs: dynamically allocate the erofs-shrinker
  f2fs: dynamically allocate the f2fs-shrinker
  gfs2: dynamically allocate the gfs2-glock shrinker
  gfs2: dynamically allocate the gfs2-qd shrinker
  NFSv4.2: dynamically allocate the nfs-xattr shrinkers
  nfs: dynamically allocate the nfs-acl shrinker
  nfsd: dynamically allocate the nfsd-filecache shrinker
  quota: dynamically allocate the dquota-cache shrinker
  ubifs: dynamically allocate the ubifs-slab shrinker
  rcu: dynamically allocate the rcu-lazy shrinker
  rcu: dynamically allocate the rcu-kfree shrinker
  mm: thp: dynamically allocate the thp-related shrinkers
  sunrpc: dynamically allocate the sunrpc_cred shrinker
  mm: workingset: dynamically allocate the mm-shadow shrinker
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
  nfsd: dynamically allocate the nfsd-client shrinker
  nfsd: dynamically allocate the nfsd-reply shrinker
  xfs: dynamically allocate the xfs-buf shrinker
  xfs: dynamically allocate the xfs-inodegc shrinker
  xfs: dynamically allocate the xfs-qm shrinker
  zsmalloc: dynamically allocate the mm-zspool shrinker
  fs: super: dynamically allocate the s_shrink
  mm: shrinker: remove old APIs
  drm/ttm: introduce pool_shrink_rwsem
  mm: shrinker: add a secondary array for shrinker_info::{map,
    nr_deferred}
  mm: shrinker: make global slab shrink lockless
  mm: shrinker: make memcg slab shrink lockless
  mm: shrinker: hold write lock to reparent shrinker nr_deferred
  mm: shrinker: convert shrinker_rwsem to mutex

 arch/x86/kvm/mmu/mmu.c                        |  18 +-
 drivers/android/binder.c                      |   1 +
 drivers/android/binder_alloc.c                |  35 +-
 drivers/android/binder_alloc.h                |   1 +
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |  30 +-
 drivers/gpu/drm/i915/i915_drv.h               |   2 +-
 drivers/gpu/drm/msm/msm_drv.c                 |   4 +-
 drivers/gpu/drm/msm/msm_drv.h                 |   4 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |  34 +-
 drivers/gpu/drm/panfrost/panfrost_device.h    |   2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   6 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h       |   2 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  30 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  38 +-
 drivers/md/bcache/bcache.h                    |   2 +-
 drivers/md/bcache/btree.c                     |  27 +-
 drivers/md/bcache/sysfs.c                     |   3 +-
 drivers/md/dm-bufio.c                         |  26 +-
 drivers/md/dm-cache-metadata.c                |   2 +-
 drivers/md/dm-zoned-metadata.c                |  28 +-
 drivers/md/raid5.c                            |  25 +-
 drivers/md/raid5.h                            |   2 +-
 drivers/misc/vmw_balloon.c                    |  38 +-
 drivers/virtio/virtio_balloon.c               |  25 +-
 drivers/xen/xenbus/xenbus_probe_backend.c     |  18 +-
 fs/btrfs/super.c                              |   2 +-
 fs/erofs/utils.c                              |  20 +-
 fs/ext4/ext4.h                                |   2 +-
 fs/ext4/extents_status.c                      |  22 +-
 fs/f2fs/super.c                               |  32 +-
 fs/gfs2/glock.c                               |  20 +-
 fs/gfs2/main.c                                |   6 +-
 fs/gfs2/quota.c                               |  26 +-
 fs/gfs2/quota.h                               |   3 +-
 fs/jbd2/journal.c                             |  27 +-
 fs/kernfs/mount.c                             |   2 +-
 fs/mbcache.c                                  |  23 +-
 fs/nfs/nfs42xattr.c                           |  87 +-
 fs/nfs/super.c                                |  20 +-
 fs/nfsd/filecache.c                           |  22 +-
 fs/nfsd/netns.h                               |   4 +-
 fs/nfsd/nfs4state.c                           |  20 +-
 fs/nfsd/nfscache.c                            |  31 +-
 fs/proc/root.c                                |   2 +-
 fs/quota/dquot.c                              |  18 +-
 fs/super.c                                    |  38 +-
 fs/ubifs/super.c                              |  22 +-
 fs/xfs/xfs_buf.c                              |  25 +-
 fs/xfs/xfs_buf.h                              |   2 +-
 fs/xfs/xfs_icache.c                           |  26 +-
 fs/xfs/xfs_mount.c                            |   4 +-
 fs/xfs/xfs_mount.h                            |   2 +-
 fs/xfs/xfs_qm.c                               |  26 +-
 fs/xfs/xfs_qm.h                               |   2 +-
 include/linux/fs.h                            |   2 +-
 include/linux/jbd2.h                          |   2 +-
 include/linux/memcontrol.h                    |  12 +-
 include/linux/shrinker.h                      |  67 +-
 kernel/rcu/tree.c                             |  22 +-
 kernel/rcu/tree_nocb.h                        |  20 +-
 mm/Makefile                                   |   4 +-
 mm/huge_memory.c                              |  69 +-
 mm/internal.h                                 |  41 +
 mm/shrinker.c                                 | 770 ++++++++++++++++++
 mm/shrinker_debug.c                           |  45 +-
 mm/vmscan.c                                   | 701 ----------------
 mm/workingset.c                               |  27 +-
 mm/zsmalloc.c                                 |  28 +-
 net/sunrpc/auth.c                             |  19 +-
 69 files changed, 1534 insertions(+), 1234 deletions(-)
 create mode 100644 mm/shrinker.c

-- 
2.30.2

