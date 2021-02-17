Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADE431D33D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBQAOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 19:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBQAOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 19:14:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF79C061574;
        Tue, 16 Feb 2021 16:13:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id b21so7338300pgk.7;
        Tue, 16 Feb 2021 16:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90gfnMARQAcrnt8N8qfPDPkOz3+A1rWq0avKglF5JvU=;
        b=L5I0exfNaCtnFMqyzbx712lS5SL7RZe4oxMXrXuqqZlGILW8DhI4tAWCz6SLy9zOGP
         jpdpWeuThaUG3OdRZgxE3rLRsy05n3qAxrwkPKnf04wr3m1FwfN1uBue24+ArqOlztfC
         jIyl9CzWNFa0BJ0nTEALWHERZ7NP21DbCcMRVd6/R2dokh/u0DA6pAzBvXtgylwRmsA8
         +UG6WrcelEh626kh4sAIf/i3h6VuNZ5S2jFSZYH6sxFAu8rjySH95NFFs8hHTaZ2ul2l
         JzqfIJ3eB3Y86S9RjmASEkbJ3YoqdcWvXwVwd0jzbRyrbGq/SErvIYuL1t4CmjgCQjXh
         cftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=90gfnMARQAcrnt8N8qfPDPkOz3+A1rWq0avKglF5JvU=;
        b=ka+/lKQsyqpO0LwCwj/M7yI5OupYPDyRsjn3i3YVV1ABRpxTb/yNpqAa9RUU1B4SVF
         /gkw3mhnTbaTZbqbFziSwADs59XX+wM4Crp63JupIDiArIu4opYQolERR+Z7hYGO3IFv
         gEn2ft+H9G4OmGGwK9bxZ4G5mBKFbFAVtDun9jU7iOgQ/RALqOwyQbLsnGAiyTHieck/
         3qhghjR9hY79Xb5VGYnm/v+yzg9or/98akNxJIFpeY2FXNhQTm7PCN3GXGUAcl/Iy5BC
         YjqdOIBljMp81Uy9LBVsH2FlWwCS6kvF0z2r06c0G/US5ohhtd3BaoDL3eifXxAJmo7g
         F8ng==
X-Gm-Message-State: AOAM5309LYHQOe0Kssy8JJwSAPkXMixw43yhgBSsmM2P1Y7rfh+xXJBb
        IMDzHqWPtmwNYe2ExOp6UbSj4k/ZLuE=
X-Google-Smtp-Source: ABdhPJzYUf+5VZa396XK07fla+GhquQ9qedfEWecSmz++e+bVImxzUojHBHUijkZIeVjdj6ghSlL3g==
X-Received: by 2002:a65:4c08:: with SMTP id u8mr13174117pgq.203.1613520808776;
        Tue, 16 Feb 2021 16:13:28 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id y12sm99220pjc.56.2021.02.16.16.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 16:13:27 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, vbabka@suse.cz,
        shakeelb@google.com, david@fromorbit.com, hannes@cmpxchg.org,
        mhocko@suse.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v8 PATCH 00/13] Make shrinker's nr_deferred memcg aware
Date:   Tue, 16 Feb 2021 16:13:09 -0800
Message-Id: <20210217001322.2226796-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Changelog
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

