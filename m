Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC279AF5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjIKUwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjIKJpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:45:12 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7C8E40
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:06 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf1876ef69so11136715ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425506; x=1695030306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQYo82GcV1MpXtuH2SUItJm9g/i7Yq2i9OY6vtpG/6I=;
        b=kc/MrWN6BQv9Ph5kI5N7sU/UYa/P80dV/gHoW9rVR/bjTHYvgob9c2uKnJPFxtXVf1
         Zd/ZnsuKDlXkCf9+1z+TuOxaQ6nlrhWWF4t4trGCuoRV2SdcqUgkzR1/rNLG8IEVQIhm
         TEEuioNMklidZTmC+amwFZNTV9taTkLzybZ78EQMmOkILjZ+1wA4Nf5QMmbI6k1JhnOG
         wAVhI/nbVOLNWEx07x7lXt97ezgq0u9kTNlRr4cWb7PYry4YdElYAoSzxPwzq+Zr7tqz
         W0AFxQHbKWtcQuANIJB9Gcvr9uFHYL4AtG0h/BVP9XbhWKEdI2OddsufVBGeKJ0OOyJl
         Z0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425506; x=1695030306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQYo82GcV1MpXtuH2SUItJm9g/i7Yq2i9OY6vtpG/6I=;
        b=n7RnXPOcS9AjEpUEQPuMmMb59pFzYxvWOQk+PfH5PEDkrZYfTnxjqeXd2/jsG3jsqw
         gehCxsUO3+uuq13oMCEVvpH2MPbuQIhf/2KMRYvBuBy0Tf7bkCP4BEDZQ4s/93iyGcls
         Ob/2brpk1JRWB51z1Kqan05rE0ZKh9K4ey60tkuc+vGbTRip7HFRHmHL4aZWw21u65nO
         Wss2JDAFSDHevbU1BpUy7CVe1Q+U3lGOqPrU8K/uXIQoj9p09L7DpmtL6A3pP4eVLvT4
         p2x6ObFzfmz5xithAl+GZ0OzNxwBP2+n+jEBDazQ/N+7/a9lEsL60oyUiPLQKN/riSF1
         cZbg==
X-Gm-Message-State: AOJu0YxLj1Y4y7pyYbTo9LFoM2VQxi8RjMt+z8PyO9ZYkhwdkfdeOPj4
        tnn43QdfzBOXQt/sdnTc7XqROg==
X-Google-Smtp-Source: AGHT+IEGNcDcG63D7amuZ7Mu8IUCE6dl5UUuSxTbAskfdYh3rk1gRPySHdBx22o30l845WJoR8Ga0A==
X-Received: by 2002:a05:6a20:a10c:b0:145:3bd9:1389 with SMTP id q12-20020a056a20a10c00b001453bd91389mr11511620pzk.6.1694425505717;
        Mon, 11 Sep 2023 02:45:05 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:45:05 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 00/45] use refcount+RCU method to implement lockless slab shrink
Date:   Mon, 11 Sep 2023 17:43:59 +0800
Message-Id: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

PATCH 1: introduce new APIs
PATCH 2~38: convert all shrinnkers to use new APIs
PATCH 39: remove old APIs
PATCH 40~41: some cleanups and preparations
PATCH 42-43: implement the lockless slab shrink
PATCH 44~45: convert shrinker_rwsem to mutex

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

  33.15%  [kernel]          [k] down_read_trylock
  25.38%  [kernel]          [k] shrink_slab
  21.75%  [kernel]          [k] up_read
   4.45%  [kernel]          [k] _find_next_bit
   2.27%  [kernel]          [k] do_shrink_slab
   1.80%  [kernel]          [k] intel_idle_irq
   1.79%  [kernel]          [k] shrink_lruvec
   0.67%  [kernel]          [k] xas_descend
   0.41%  [kernel]          [k] mem_cgroup_iter
   0.40%  [kernel]          [k] shrink_node
   0.38%  [kernel]          [k] list_lru_count_one

2) After applying this patchset:

  64.56%  [kernel]          [k] shrink_slab
  12.18%  [kernel]          [k] do_shrink_slab
   3.30%  [kernel]          [k] __rcu_read_unlock
   2.61%  [kernel]          [k] shrink_lruvec
   2.49%  [kernel]          [k] __rcu_read_lock
   1.93%  [kernel]          [k] intel_idle_irq
   0.89%  [kernel]          [k] shrink_node
   0.81%  [kernel]          [k] mem_cgroup_iter
   0.77%  [kernel]          [k] mem_cgroup_calculate_protection
   0.66%  [kernel]          [k] list_lru_count_one

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
ramfs            473062     60.00      8.00    279.13      7884.12        1647.59
for a 60.01s run time:
   1440.34s available CPU time
      7.99s user time   (  0.55%)
    279.13s system time ( 19.38%)
    287.12s total time  ( 19.93%)
load average: 7.12 2.99 1.15
successful run completed in 60.01s (1 min, 0.01 secs)

2) After applying this patchset:

setting to a 60 second run per stressor
dispatching hogs: 9 ramfs
stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
                          (secs)    (secs)    (secs)   (real time) (usr+sys time)
ramfs            477165     60.00      8.13    281.34      7952.55        1648.40
for a 60.01s run time:
   1440.33s available CPU time
      8.12s user time   (  0.56%)
    281.34s system time ( 19.53%)
    289.46s total time  ( 20.10%)
load average: 6.98 3.03 1.19
successful run completed in 60.01s (1 min, 0.01 secs)

We can see that the ops/s has hardly changed.

This series is based on v6.6-rc1 and depends on the cleanup patchset [5].

Comments and suggestions are welcome.

[5]. https://lore.kernel.org/linux-mm/20230911092517.64141-1-zhengqi.arch@bytedance.com/

Thanks,
Qi

Changelog in v5 -> v6:
 - set seeks to DEFAULT_SEEKS by default in shrinker_alloc()
   (suggested by Juergen Gross)
 - set b->shrinker to NULL after shrinker_free() in [PATCH v6 27/45]
   (suggested by Nadav Amit)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the v6.6-rc1

Changelog in v4 -> v5:
 - split out some cleanups
 - split cleanup in [PATCH v4 46/48] as a separate patch
   (pointed by Dave Chinner)
 - add more comments for lockless algorithm
   (pointed by Dave Chinner)
 - remove shrinker_info_rcu() helper
   (pointed by Dave Chinner)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20230823

Changelog in v3 -> v4:
 - [PATCH v3 01/49] has been merged, so discard it.
 - fix wrong return value in patch v3 15\16\22\27\28\29\34\40.
   (pointed by Damien Le Moal)
 - fix uninitialized variable in [PATCH v3 04/49]
   (pointed by Simon Horman)
 - fix typo in [PATCH v3 05/49] (pointed by Simon Horman)
 - rebase onto the next-20230807.

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

Qi Zheng (45):
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
  mm: shrinker: add a secondary array for shrinker_info::{map,
    nr_deferred}
  mm: shrinker: rename {prealloc|unregister}_memcg_shrinker() to
    shrinker_memcg_{alloc|remove}()
  mm: shrinker: make global slab shrink lockless
  mm: shrinker: make memcg slab shrink lockless
  mm: shrinker: hold write lock to reparent shrinker nr_deferred
  mm: shrinker: convert shrinker_rwsem to mutex

 arch/x86/kvm/mmu/mmu.c                        |  18 +-
 drivers/android/binder_alloc.c                |  30 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |  29 +-
 drivers/gpu/drm/i915/i915_drv.h               |   2 +-
 drivers/gpu/drm/msm/msm_drv.c                 |   4 +-
 drivers/gpu/drm/msm/msm_drv.h                 |   4 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |  33 +-
 drivers/gpu/drm/panfrost/panfrost_device.h    |   2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   6 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h       |   2 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  29 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  23 +-
 drivers/md/bcache/bcache.h                    |   2 +-
 drivers/md/bcache/btree.c                     |  27 +-
 drivers/md/bcache/sysfs.c                     |   3 +-
 drivers/md/dm-bufio.c                         |  28 +-
 drivers/md/dm-cache-metadata.c                |   2 +-
 drivers/md/dm-zoned-metadata.c                |  28 +-
 drivers/md/raid5.c                            |  26 +-
 drivers/md/raid5.h                            |   2 +-
 drivers/misc/vmw_balloon.c                    |  38 +-
 drivers/virtio/virtio_balloon.c               |  24 +-
 drivers/xen/xenbus/xenbus_probe_backend.c     |  17 +-
 fs/btrfs/super.c                              |   2 +-
 fs/erofs/utils.c                              |  19 +-
 fs/ext4/ext4.h                                |   2 +-
 fs/ext4/extents_status.c                      |  23 +-
 fs/f2fs/super.c                               |  31 +-
 fs/gfs2/glock.c                               |  19 +-
 fs/gfs2/main.c                                |   6 +-
 fs/gfs2/quota.c                               |  25 +-
 fs/gfs2/quota.h                               |   3 +-
 fs/jbd2/journal.c                             |  29 +-
 fs/kernfs/mount.c                             |   2 +-
 fs/mbcache.c                                  |  22 +-
 fs/nfs/nfs42xattr.c                           |  87 +--
 fs/nfs/super.c                                |  21 +-
 fs/nfsd/filecache.c                           |  23 +-
 fs/nfsd/netns.h                               |   4 +-
 fs/nfsd/nfs4state.c                           |  19 +-
 fs/nfsd/nfscache.c                            |  31 +-
 fs/proc/root.c                                |   2 +-
 fs/quota/dquot.c                              |  17 +-
 fs/super.c                                    |  35 +-
 fs/ubifs/super.c                              |  21 +-
 fs/xfs/xfs_buf.c                              |  24 +-
 fs/xfs/xfs_buf.h                              |   2 +-
 fs/xfs/xfs_icache.c                           |  26 +-
 fs/xfs/xfs_mount.c                            |   4 +-
 fs/xfs/xfs_mount.h                            |   2 +-
 fs/xfs/xfs_qm.c                               |  27 +-
 fs/xfs/xfs_qm.h                               |   2 +-
 include/linux/fs.h                            |   2 +-
 include/linux/jbd2.h                          |   2 +-
 include/linux/memcontrol.h                    |  12 +-
 include/linux/shrinker.h                      |  54 +-
 kernel/rcu/tree.c                             |  21 +-
 kernel/rcu/tree_nocb.h                        |  19 +-
 mm/huge_memory.c                              |  67 +-
 mm/internal.h                                 |  11 +
 mm/shrinker.c                                 | 582 +++++++++++-------
 mm/shrinker_debug.c                           |  31 +-
 mm/workingset.c                               |  29 +-
 mm/zsmalloc.c                                 |  27 +-
 net/sunrpc/auth.c                             |  20 +-
 65 files changed, 1052 insertions(+), 734 deletions(-)

-- 
2.30.2

