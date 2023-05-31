Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E68717CBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjEaKEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbjEaKEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:04:23 -0400
Received: from out-19.mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EDD10F
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 03:04:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685527095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PItdhrJgOO6Uf9HQuBa9pn2dZV15hG06si+vWLwhY4U=;
        b=HibbmKwHH6i0eqMj0ivFsqhZE4MS2V1GSStWp+7t0p4zPvhN090WskQM6WID4MuKhmoHYh
        HbPpUh5MXnJlOxmVcpX5w1o3mJx5mVhfQl/IvoUYnLrgBzNTOTzS1pmFtZVvKS5aN8F/hC
        8xlSAR6vOuOlLS1YfL7BM8u6CG2jE14=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/8] make unregistration of super_block shrinker more faster
Date:   Wed, 31 May 2023 09:57:34 +0000
Message-Id: <20230531095742.2480623-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

Hi all,

This patch series aims to make unregistration of super_block shrinker more
faster.

1. Background
=============

The kernel test robot noticed a -88.8% regression of stress-ng.ramfs.ops_per_sec
on commit f95bdb700bc6 ("mm: vmscan: make global slab shrink lockless"). More
details can be seen from the link[1] below.

[1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/

We can just use the following command to reproduce the result:

stress-ng --timeout 60 --times --verify --metrics-brief --ramfs 9 &

1) before commit f95bdb700bc6b:

stress-ng: info:  [11023] dispatching hogs: 9 ramfs
stress-ng: info:  [11023] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
stress-ng: info:  [11023]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [11023] ramfs            774966     60.00     10.18    169.45     12915.89        4314.26
stress-ng: info:  [11023] for a 60.00s run time:
stress-ng: info:  [11023]    1920.11s available CPU time
stress-ng: info:  [11023]      10.18s user time   (  0.53%)
stress-ng: info:  [11023]     169.44s system time (  8.82%)
stress-ng: info:  [11023]     179.62s total time  (  9.35%)
stress-ng: info:  [11023] load average: 8.99 2.69 0.93
stress-ng: info:  [11023] successful run completed in 60.00s (1 min, 0.00 secs)

2) after commit f95bdb700bc6b:

stress-ng: info:  [37676] dispatching hogs: 9 ramfs
stress-ng: info:  [37676] stressor       bogo ops real time  usrtime  sys time   bogo ops/s     bogo ops/s
stress-ng: info:  [37676]                           (secs)    (secs)   (secs)   (real time) (usr+sys time)
stress-ng: info:  [37676] ramfs            168673     60.00     1.61    39.66      2811.08        4087.47
stress-ng: info:  [37676] for a 60.10s run time:
stress-ng: info:  [37676]    1923.36s available CPU time
stress-ng: info:  [37676]       1.60s user time   (  0.08%)
stress-ng: info:  [37676]      39.66s system time (  2.06%)
stress-ng: info:  [37676]      41.26s total time  (  2.15%)
stress-ng: info:  [37676] load average: 7.69 3.63 2.36
stress-ng: info:  [37676] successful run completed in 60.10s (1 min, 0.10 secs)

The root cause is that SRCU has to be careful to not frequently check for srcu
read-side critical section exits. Paul E. McKenney gave a detailed explanation:

```
In practice, the act of checking to see if there is anyone in an SRCU
read-side critical section is a heavy-weight operation, involving at
least one cache miss per CPU along with a number of full memory barriers.
```

Therefore, even if no one is currently in the SRCU read-side critical section,
synchronize_srcu() cannot return quickly. That's why unregister_shrinker() has
become slower.

2. Idea
=======

2.1 use synchronize_srcu_expedited() ?
--------------------------------------

The synchronize_srcu_expedited() will let SRCU to be much more aggressive.
If we use it to replace synchronize_srcu() in the unregister_shrinker(), the
ops/s will return to previous levels:

stress-ng: info:  [13159] dispatching hogs: 9 ramfs
stress-ng: info:  [13159] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
stress-ng: info:  [13159]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [13159] ramfs            710062     60.00      9.63    157.26     11834.18        4254.75
stress-ng: info:  [13159] for a 60.00s run time:
stress-ng: info:  [13159]    1920.14s available CPU time
stress-ng: info:  [13159]       9.62s user time   (  0.50%)
stress-ng: info:  [13159]     157.26s system time (  8.19%)
stress-ng: info:  [13159]     166.88s total time  (  8.69%)
stress-ng: info:  [13159] load average: 9.49 4.02 1.65
stress-ng: info:  [13159] successful run completed in 60.00s (1 min, 0.00 secs)

But because SRCU (Sleepable RCU) is used here, the reader is allowed to sleep in
the read-side critical section, so synchronize_srcu_expedited() may cause a lot
of CPU consumption, so this is not a good choice.

2.2 move synchronize_srcu() to the asynchronous delayed work
------------------------------------------------------------

Kirill Tkhai proposed a better idea[2] in 2018: move synchronize_srcu() to the
asynchronous delayed work, then it doesn't affect on user-visible unregistration
speed.

[2]. https://lore.kernel.org/lkml/153365636747.19074.12610817307548583381.stgit@localhost.localdomain/

After applying his patches ([PATCH RFC 04/10]~[PATCH RFC 10/10], with few
conflicts), the ops/s is of course back to the previous levels:

stress-ng: info:  [11506] setting to a 60 second run per stressor
stress-ng: info:  [11506] dispatching hogs: 9 ramfs
stress-ng: info:  [11506] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
stress-ng: info:  [11506]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: info:  [11506] ramfs            829462     60.00     10.81    174.25     13824.14        4482.08
stress-ng: info:  [11506] for a 60.00s run time:
stress-ng: info:  [11506]    1920.12s available CPU time
stress-ng: info:  [11506]      10.81s user time   (  0.56%)
stress-ng: info:  [11506]     174.25s system time (  9.07%)
stress-ng: info:  [11506]     185.06s total time  (  9.64%)
stress-ng: info:  [11506] load average: 8.96 2.60 0.89
stress-ng: info:  [11506] successful run completed in 60.00s (1 min, 0.00 secs)

In order to continue to advance this patch set, I rebase these patches onto the
next-20230525. Any comments and suggestions are welcome.

Note: This patch serise is only for super_block shrinker, all further
time-critical for unregistration places may be written in the same conception.

Thanks,
Qi

Kirill Tkhai (7):
  mm: vmscan: split unregister_shrinker()
  fs: move list_lru_destroy() to destroy_super_work()
  fs: shrink only (SB_ACTIVE|SB_BORN) superblocks in super_cache_scan()
  fs: introduce struct super_operations::destroy_super() callback
  xfs: introduce xfs_fs_destroy_super()
  shmem: implement shmem_destroy_super()
  fs: use unregister_shrinker_delayed_{initiate, finalize} for
    super_block shrinker

Qi Zheng (1):
  mm: vmscan: move shrinker_debugfs_remove() before synchronize_srcu()

 fs/super.c               | 32 ++++++++++++++++++--------------
 fs/xfs/xfs_super.c       | 25 ++++++++++++++++++++++---
 include/linux/fs.h       |  6 ++++++
 include/linux/shrinker.h |  2 ++
 mm/shmem.c               |  8 ++++++++
 mm/vmscan.c              | 26 ++++++++++++++++++++------
 6 files changed, 76 insertions(+), 23 deletions(-)

-- 
2.30.2

