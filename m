Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0218979BF2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbjIKU4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbjIKJvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA44E44
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3c4eafe95so471595ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425890; x=1695030690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZ/9E5fVY8FPsUp4wjjHgLtQNfwCba8B+s0lf1gVAsM=;
        b=BJoxDX3nlaOw49gQ8vg3wMQxRI1dCYp5UxKdwwVqZVAyNiq08pzXeQXtAXE2H0g+rk
         hmLTxHhmFxhl/85sisUQoJCoDGe/xPVm9VPCOfgDRZeh/qMERZ1SA8aVyr863uSWW0W5
         AecMzaYeHpWzj0pGZ40UId4HbbRl1fyGS+p0nggDWDxGFGEMU/M88vz6pwDsKjevwMg+
         4u3m5l4NiPWKA0SXgwOLY8q/XyLmkeoBPZn6au3942ecv3bLoCjAMAuGrVnhwRDnItE4
         hjWNE+H0pLdjWw1w7NFrXZwJ6OJEe+zK7w4HWoEIjSjrjRdl/6eGm6M+PXLghDExZy9U
         fOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425890; x=1695030690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ/9E5fVY8FPsUp4wjjHgLtQNfwCba8B+s0lf1gVAsM=;
        b=UCXKhDhjo2aeBogCAfsQQzrAK3iSLHKNrKGPaJWiPqSjv4ealGyFE3mtkCD317v6UF
         +JXmsKzBFhmbsU+M2iY/WBiqfmyyoqukYh8oHFRA88evyQ7EAPpkU5/Yi0l3qA3ZoV41
         7gMEgequoJFANftxKoD44VzvhRAGZjBD0nXtaXGhTHDcauEWbbmf6FBMUmupsiltFcgo
         WLyZ0d98FUuYbemejeinGGI/mHSNBe+HljX3WAde2C3d3VOvxJ02aYA0lzuTeE9fQJCv
         MdMmYvZQnBDGFR1ZbjVfJWpE+HFpVv8lYzxsyi/6+5tnrjvzt4HRDyzOuupl5C1b2aPp
         8ong==
X-Gm-Message-State: AOJu0YzzD8Uv78i3uK48oFTCma2OjteuLuK0ToG83U3qZsZ7Qp3oNb24
        S5lsccn73uyIDzC0HVWQ7Um78w==
X-Google-Smtp-Source: AGHT+IHVmg0SPBTxibarM4Nfz7v4+7j0jTley3X4jyAk2nq0f4+4LMApDrslEJNjDGHU4l29lE3i3A==
X-Received: by 2002:a17:902:d645:b0:1c3:c687:478a with SMTP id y5-20020a170902d64500b001c3c687478amr334044plh.2.1694425889725;
        Mon, 11 Sep 2023 02:51:29 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:51:29 -0700 (PDT)
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
Subject: [PATCH v6 42/45] mm: shrinker: make global slab shrink lockless
Date:   Mon, 11 Sep 2023 17:44:41 +0800
Message-Id: <20230911094444.68966-43-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The shrinker_rwsem is a global read-write lock in shrinkers subsystem,
which protects most operations such as slab shrink, registration and
unregistration of shrinkers, etc. This can easily cause problems in the
following cases.

1) When the memory pressure is high and there are many filesystems
   mounted or unmounted at the same time, slab shrink will be affected
   (down_read_trylock() failed).

   Such as the real workload mentioned by Kirill Tkhai:

   ```
   One of the real workloads from my experience is start
   of an overcommitted node containing many starting
   containers after node crash (or many resuming containers
   after reboot for kernel update). In these cases memory
   pressure is huge, and the node goes round in long reclaim.
   ```

2) If a shrinker is blocked (such as the case mentioned
   in [1]) and a writer comes in (such as mount a fs),
   then this writer will be blocked and cause all
   subsequent shrinker-related operations to be blocked.

Even if there is no competitor when shrinking slab, there may still be a
problem. The down_read_trylock() may become a perf hotspot with frequent
calls to shrink_slab(). Because of the poor multicore scalability of
atomic operations, this can lead to a significant drop in IPC
(instructions per cycle).

We used to implement the lockless slab shrink with SRCU [2], but then
kernel test robot reported -88.8% regression in
stress-ng.ramfs.ops_per_sec test case [3], so we reverted it [4].

This commit uses the refcount+RCU method [5] proposed by Dave Chinner
to re-implement the lockless global slab shrink. The memcg slab shrink is
handled in the subsequent patch.

For now, all shrinker instances are converted to dynamically allocated and
will be freed by call_rcu(). So we can use rcu_read_{lock,unlock}() to
ensure that the shrinker instance is valid.

And the shrinker instance will not be run again after unregistration. So
the structure that records the pointer of shrinker instance can be safely
freed without waiting for the RCU read-side critical section.

In this way, while we implement the lockless slab shrink, we don't need to
be blocked in unregister_shrinker().

The following are the test results:

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

[1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
[2]. https://lore.kernel.org/lkml/20230313112819.38938-1-zhengqi.arch@bytedance.com/
[3]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[4]. https://lore.kernel.org/all/20230609081518.3039120-1-qi.zheng@linux.dev/
[5]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/shrinker.h | 24 +++++++++++
 mm/shrinker.c            | 89 ++++++++++++++++++++++++++++++----------
 2 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index eb342994675a..4908109d924f 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -4,6 +4,8 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
+#include <linux/refcount.h>
+#include <linux/completion.h>
 
 #define SHRINKER_UNIT_BITS	BITS_PER_LONG
 
@@ -87,6 +89,17 @@ struct shrinker {
 	int seeks;	/* seeks to recreate an obj */
 	unsigned flags;
 
+	/*
+	 * The reference count of this shrinker. Registered shrinker have an
+	 * initial refcount of 1, then the lookup operations are now allowed
+	 * to use it via shrinker_try_get(). Later in the unregistration step,
+	 * the initial refcount will be discarded, and will free the shrinker
+	 * asynchronously via RCU after its refcount reaches 0.
+	 */
+	refcount_t refcount;
+	struct completion done;	/* use to wait for refcount to reach 0 */
+	struct rcu_head rcu;
+
 	void *private_data;
 
 	/* These are for internal use */
@@ -120,6 +133,17 @@ struct shrinker *shrinker_alloc(unsigned int flags, const char *fmt, ...);
 void shrinker_register(struct shrinker *shrinker);
 void shrinker_free(struct shrinker *shrinker);
 
+static inline bool shrinker_try_get(struct shrinker *shrinker)
+{
+	return refcount_inc_not_zero(&shrinker->refcount);
+}
+
+static inline void shrinker_put(struct shrinker *shrinker)
+{
+	if (refcount_dec_and_test(&shrinker->refcount))
+		complete(&shrinker->done);
+}
+
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int __printf(2, 3) shrinker_debugfs_rename(struct shrinker *shrinker,
 						  const char *fmt, ...);
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 0b9a43ce2d6f..82dc61133c5b 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -2,6 +2,7 @@
 #include <linux/memcontrol.h>
 #include <linux/rwsem.h>
 #include <linux/shrinker.h>
+#include <linux/rculist.h>
 #include <trace/events/vmscan.h>
 
 #include "internal.h"
@@ -576,33 +577,50 @@ unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
-	if (!down_read_trylock(&shrinker_rwsem))
-		goto out;
-
-	list_for_each_entry(shrinker, &shrinker_list, list) {
+	/*
+	 * lockless algorithm of global shrink.
+	 *
+	 * In the unregistration setp, the shrinker will be freed asynchronously
+	 * via RCU after its refcount reaches 0. So both rcu_read_lock() and
+	 * shrinker_try_get() can be used to ensure the existence of the shrinker.
+	 *
+	 * So in the global shrink:
+	 *  step 1: use rcu_read_lock() to guarantee existence of the shrinker
+	 *          and the validity of the shrinker_list walk.
+	 *  step 2: use shrinker_try_get() to try get the refcount, if successful,
+	 *          then the existence of the shrinker can also be guaranteed,
+	 *          so we can release the RCU lock to do do_shrink_slab() that
+	 *          may sleep.
+	 *  step 3: *MUST* to reacquire the RCU lock before calling shrinker_put(),
+	 *          which ensures that neither this shrinker nor the next shrinker
+	 *          will be freed in the next traversal operation.
+	 *  step 4: do shrinker_put() paired with step 2 to put the refcount,
+	 *          if the refcount reaches 0, then wake up the waiter in
+	 *          shrinker_free() by calling complete().
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(shrinker, &shrinker_list, list) {
 		struct shrink_control sc = {
 			.gfp_mask = gfp_mask,
 			.nid = nid,
 			.memcg = memcg,
 		};
 
+		if (!shrinker_try_get(shrinker))
+			continue;
+
+		rcu_read_unlock();
+
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY)
 			ret = 0;
 		freed += ret;
-		/*
-		 * Bail out if someone want to register a new shrinker to
-		 * prevent the registration from being stalled for long periods
-		 * by parallel ongoing shrinking.
-		 */
-		if (rwsem_is_contended(&shrinker_rwsem)) {
-			freed = freed ? : 1;
-			break;
-		}
+
+		rcu_read_lock();
+		shrinker_put(shrinker);
 	}
 
-	up_read(&shrinker_rwsem);
-out:
+	rcu_read_unlock();
 	cond_resched();
 	return freed;
 }
@@ -671,13 +689,29 @@ void shrinker_register(struct shrinker *shrinker)
 	}
 
 	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
+	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
 	up_write(&shrinker_rwsem);
+
+	init_completion(&shrinker->done);
+	/*
+	 * Now the shrinker is fully set up, take the first reference to it to
+	 * indicate that lookup operations are now allowed to use it via
+	 * shrinker_try_get().
+	 */
+	refcount_set(&shrinker->refcount, 1);
 }
 EXPORT_SYMBOL_GPL(shrinker_register);
 
+static void shrinker_free_rcu_cb(struct rcu_head *head)
+{
+	struct shrinker *shrinker = container_of(head, struct shrinker, rcu);
+
+	kfree(shrinker->nr_deferred);
+	kfree(shrinker);
+}
+
 void shrinker_free(struct shrinker *shrinker)
 {
 	struct dentry *debugfs_entry = NULL;
@@ -686,9 +720,25 @@ void shrinker_free(struct shrinker *shrinker)
 	if (!shrinker)
 		return;
 
+	if (shrinker->flags & SHRINKER_REGISTERED) {
+		/* drop the initial refcount */
+		shrinker_put(shrinker);
+		/*
+		 * Wait for all lookups of the shrinker to complete, after that,
+		 * no shrinker is running or will run again, then we can safely
+		 * free it asynchronously via RCU and safely free the structure
+		 * where the shrinker is located, such as super_block etc.
+		 */
+		wait_for_completion(&shrinker->done);
+	}
+
 	down_write(&shrinker_rwsem);
 	if (shrinker->flags & SHRINKER_REGISTERED) {
-		list_del(&shrinker->list);
+		/*
+		 * Now we can safely remove it from the shrinker_list and then
+		 * free it.
+		 */
+		list_del_rcu(&shrinker->list);
 		debugfs_entry = shrinker_debugfs_detach(shrinker, &debugfs_id);
 		shrinker->flags &= ~SHRINKER_REGISTERED;
 	} else {
@@ -702,9 +752,6 @@ void shrinker_free(struct shrinker *shrinker)
 	if (debugfs_entry)
 		shrinker_debugfs_remove(debugfs_entry, debugfs_id);
 
-	kfree(shrinker->nr_deferred);
-	shrinker->nr_deferred = NULL;
-
-	kfree(shrinker);
+	call_rcu(&shrinker->rcu, shrinker_free_rcu_cb);
 }
 EXPORT_SYMBOL_GPL(shrinker_free);
-- 
2.30.2

