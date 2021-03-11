Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9CC337D39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 20:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhCKTJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 14:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhCKTI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 14:08:59 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF53C061574;
        Thu, 11 Mar 2021 11:08:59 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id a188so197901pfb.4;
        Thu, 11 Mar 2021 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tdhYJCYiOt2eSgI8PfK4axYaL2BrnhaEAO2Wlh0WvDk=;
        b=nkBpaQcgW9RD/fIGp5Tdbkr5WTg1wBsbwaUQV7yY3y/LPIFCyfx4v36reJKQuA53SM
         TLMBz5oHk9fNzyQdW0EevD1FmwpvpbVZ8TfpZWVXjgZ5lJC52aYEcgBm3/n6wSEsD7vN
         +7MwtIdbWmR9wVzlPW0AQGjkQlBlOO32/Rek16G0LSXch98dKfsyUB0xmDQfbKaPtCbp
         pA+m5X2soGbLm/2bEqarfQVLB2buA8mbEBcY1K6TP7xyqe5iadoJuO538gc7dZsdHQ3c
         OT9jiG9x5tmNK5KFg4O3Lm82WpCVKCRUY3TQgHGIaNAzAyW2rPVJta434DJbBsAy3ecy
         tRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tdhYJCYiOt2eSgI8PfK4axYaL2BrnhaEAO2Wlh0WvDk=;
        b=MQHFwfd2BaEBqRdeIFvas3ooyjHc0Vm5NMYJOz7pOmp7AoOh7p+f1BnygQbVG+2SYo
         d7w2XYt2efM/bERKHUv2cvp6eSul2MO2g8GWy1lJnD67WF/jXXpcgv7mGnpRuLjt28Wq
         z+eCOke2KjFEX3+K+Ime6rNtGiMkiu5A5GXvez3ZydsuxbaNKyi0MoKRQsQHbOXdPTX1
         tnMZidQp9IOvxHfnY+n++hVCN0ZShPomX9y+U1WQG03aOtptz3E/VXpmL9woCVLnxB3u
         hW8g8zcH9iUQcQe6OThv8sfXYDGuvauwdmGVHW1w3tKyei2en4TiOXilXU2RWwKbC4V7
         Eg0g==
X-Gm-Message-State: AOAM530GU9A1B09jpAr0gNT9GpwSOi9d6SRHQdBtAO+UXN4AJ5VKuIcP
        mflKPIPoSqikORitCheDdRk=
X-Google-Smtp-Source: ABdhPJyUbP6xv80HKAJya3p5gm4s9WjVOXrNwskZg3sKRrEtQuXYKtNBqp20EDyyoHhz0h2vkihVwQ==
X-Received: by 2002:a63:c02:: with SMTP id b2mr8396753pgl.53.1615489739228;
        Thu, 11 Mar 2021 11:08:59 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id t12sm2999111pfe.203.2021.03.11.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 11:08:58 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v10 PATCH 00/13] Make shrinker's nr_deferred memcg aware
Date:   Thu, 11 Mar 2021 11:08:32 -0800
Message-Id: <20210311190845.9708-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Changelog
v9 --> v10:
    * Rebased onto next-20210310 of linux-next to solve the conflict with
      "mm: memcontrol: switch to rstat" series. 
v8 --> v9:
    * Used two parameters form of kvfree_rcu() per Shakeel.
    * Amended commit log about allocating shrinker_info for root memcg for
      patch 09/13 per Shakeel.
    * Colleted more ack and review tags.
    * Rebased onto 5.12-rc2.
v7 --> v8:
    * Added lockdep assert in expand_shrinker_info() per Roman.
    * Added patch 05/13 to use kvfree_rcu() instead of call_rcu() per Roman
      and Kirill.
    * Moved rwsem acquire/release out of unregister_memcg_shrinker() per Roman.
    * Renamed count_nr_deferred_{memcg} to xchg_nr_deferred_{memcg} per Roman.
    * Fixed the next_deferred logic per Vlastimil.
    * Misc minor code cleanup, refactor and spelling correction per Roman
      and Shakeel.
    * Collected more ack and review tags from Roman, Shakeel and Vlastimil.
v6 --> v7:
    * Expanded shrinker_info in a batch of BITS_PER_LONG per Kirill.
    * Added patch 06/12 to introduce a helper for dereferencing shrinker_info
      per Kirill.
    * Renamed set_nr_deferred_memcg to add_nr_deferred_memcg per Kirill.
    * Collected Acked-by from Kirill.
v5 --> v6:
    * Rebased on top of https://lore.kernel.org/linux-mm/1611216029-34397-1-git-send-email-abaci-bugfix@linux.alibaba.com/
      per Kirill.
    * Don't register shrinker idr with NULL and remove idr_replace() per Vlastimil.
    * Move nr_deferred before map to guarantee the alignment per Vlastimil.
    * Misc minor code cleanup and refactor per Kirill and Vlastimil.
    * Added Acked-by from Vlastimil for path #1, #2, #3, #5, #9 and #10.
v4 --> v5:
    * Incorporated the comments from Kirill.
    * Rebased to v5.11-rc5.
v3 --> v4:
    * Removed "memcg_" prefix for shrinker_maps related functions per Roman.
    * Use write lock instead of read lock per Kirill. Also removed Johannes's ack
      since write lock is used.
    * Incorporated the comments from Kirill.
    * Removed RFC.
    * Rebased to v5.11-rc4.
v2 --> v3:
    * Moved shrinker_maps related code to vmscan.c per Dave.
    * Removed memcg_shrinker_map_size. Calcuated the size of map via shrinker_nr_max
      per Johannes.
    * Consolidated shrinker_deferred with shrinker_maps into one struct per Dave.
    * Simplified the nr_deferred related code.
    * Dropped the memory barrier from v2.
    * Moved nr_deferred reparent code to vmscan.c per Dave.
    * Added test coverage information in patch #11. Dave is concerned about the
      potential regression. I didn't notice regression with my tests, but suggestions
      about more test coverage is definitely welcome. And it may help spot regression
      with this patch in -mm tree then linux-next tree so I keep it in this version.
    * The code cleanup and consolidation resulted in the series grow to 11 patches.
    * Rebased onto 5.11-rc2. 
v1 --> v2:
    * Use shrinker->flags to store the new SHRINKER_REGISTERED flag per Roman.
    * Folded patch #1 into patch #6 per Roman.
    * Added memory barrier to prevent shrink_slab_memcg from seeing NULL shrinker_maps/
      shrinker_deferred per Kirill.
    * Removed memcg_shrinker_map_mutex. Protcted shrinker_map/shrinker_deferred
      allocations from expand with shrinker_rwsem per Johannes.

Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
it turned out there were huge amount accumulated nr_deferred objects seen by the
shrinker.

On our production machine, I saw absurd number of nr_deferred shown as the below
tracing result: 

<...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
9300 cache items 1667 delta 11 total_scan 833

There are 2.5 trillion deferred objects on one node, assuming all of them
are dentry (192 bytes per object), so the total size of deferred on
one node is ~480TB. It is definitely ridiculous.

I managed to reproduce this problem with kernel build workload plus negative dentry
generator.

First step, run the below kernel build test script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

cd /root/Buildarea/linux-stable

for i in `seq 1500`; do
        cgcreate -g memory:kern_build
        echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes

        echo 3 > /proc/sys/vm/drop_caches
        cgexec -g memory:kern_build make clean > /dev/null 2>&1
        cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1

        cgdelete -g memory:kern_build
done

Then run the below negative dentry generator script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

mkdir /sys/fs/cgroup/memory/test
echo $$ > /sys/fs/cgroup/memory/test/tasks

for i in `seq $NR_CPUS`; do
        while true; do
                FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
                cat $FILE 2>/dev/null
        done &
done

Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
showed:

	kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
	kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928

There were huge number of deferred objects before the shrinker was called, the behavior
does match the code but it might be not desirable from the user's stand of point.

The excessive amount of nr_deferred might be accumulated due to various reasons, for example:
    * GFP_NOFS allocation
    * Significant times of small amount scan (< scan_batch, 1024 for vfs metadata)

However the LRUs of slabs are per memcg (memcg-aware shrinkers) but the deferred objects
is per shrinker, this may have some bad effects:
    * Poor isolation among memcgs. Some memcgs which happen to have frequent limit
      reclaim may get nr_deferred accumulated to a huge number, then other innocent
      memcgs may take the fall. In our case the main workload was hit.
    * Unbounded deferred objects. There is no cap for deferred objects, it can outgrow
      ridiculously as the tracing result showed.
    * Easy to get out of control. Although shrinkers take into account deferred objects,
      but it can go out of control easily. One misconfigured memcg could incur absurd 
      amount of deferred objects in a period of time.
    * Sort of reclaim problems, i.e. over reclaim, long reclaim latency, etc. There may be
      hundred GB slab caches for vfe metadata heavy workload, shrink half of them may take
      minutes. We observed latency spike due to the prolonged reclaim.

These issues also have been discussed in https://lore.kernel.org/linux-mm/20200916185823.5347-1-shy828301@gmail.com/.
The patchset is the outcome of that discussion.

So this patchset makes nr_deferred per-memcg to tackle the problem. It does:
    * Have memcg_shrinker_deferred per memcg per node, just like what shrinker_map
      does. Instead it is an atomic_long_t array, each element represent one shrinker
      even though the shrinker is not memcg aware, this simplifies the implementation.
      For memcg aware shrinkers, the deferred objects are just accumulated to its own
      memcg. The shrinkers just see nr_deferred from its own memcg. Non memcg aware
      shrinkers still use global nr_deferred from struct shrinker.
    * Once the memcg is offlined, its nr_deferred will be reparented to its parent along
      with LRUs.
    * The root memcg has memcg_shrinker_deferred array too. It simplifies the handling of
      reparenting to root memcg.
    * Cap nr_deferred to 2x of the length of lru. The idea is borrowed from Dave Chinner's
      series (https://lore.kernel.org/linux-xfs/20191031234618.15403-1-david@fromorbit.com/)

The downside is each memcg has to allocate extra memory to store the nr_deferred array.
On our production environment, there are typically around 40 shrinkers, so each memcg
needs ~320 bytes. 10K memcgs would need ~3.2MB memory. It seems fine.

We have been running the patched kernel on some hosts of our fleet (test and production) for
months, it works very well. The monitor data shows the working set is sustained as expected.

Yang Shi (13):
      mm: vmscan: use nid from shrink_control for tracepoint
      mm: vmscan: consolidate shrinker_maps handling code
      mm: vmscan: use shrinker_rwsem to protect shrinker_maps allocation
      mm: vmscan: remove memcg_shrinker_map_size
      mm: vmscan: use kvfree_rcu instead of call_rcu
      mm: memcontrol: rename shrinker_map to shrinker_info
      mm: vmscan: add shrinker_info_protected() helper
      mm: vmscan: use a new flag to indicate shrinker is registered
      mm: vmscan: add per memcg shrinker nr_deferred
      mm: vmscan: use per memcg nr_deferred of shrinker
      mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
      mm: memcontrol: reparent nr_deferred when memcg offline
      mm: vmscan: shrink deferred objects proportional to priority

 include/linux/memcontrol.h |  23 +++---
 include/linux/shrinker.h   |   7 +-
 mm/huge_memory.c           |   4 +-
 mm/list_lru.c              |   6 +-
 mm/memcontrol.c            | 130 +------------------------------
 mm/vmscan.c                | 394 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 6 files changed, 319 insertions(+), 245 deletions(-)

