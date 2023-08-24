Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A54786665
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbjHXDx1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjHXDw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:52:26 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B3D1FC9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:41 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bcde3d8657so1046840a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692849000; x=1693453800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsFx4mRVJVJC0t+ZBsw1YSpuCOjem+CIHrRc8h/J2ds=;
        b=T9bwed+G6G/CL6884wg3Clq6JVCU9mv1KCL/vTkHeAiNhxXq1l7CxJCYQU3i/WOpWC
         1A08OFSVxS0TYo1u8V+Q7GUclePfjeq6wUOtMx3bTyrvDHqvmqaHiez8fqANNfrf/CYu
         6xgEv6qLwI8zcAqLP898IiYScH6ga/SwY4ITJqqJf8g1HxU2IJUWPYtnj/zY7orQP2Ya
         vvVTWL/LR3FrZAJDXvAv5Lpw+Lg3YvW/d0CUlWyoARedi57JV+mvcDAsOpoi49Mwz89R
         V751SjSZpBzsM8eH+uc9aPFQNPKO2az8XNmdyCmByqyS9iv6/b+f3ih03+5KG8RIYbgY
         qVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692849000; x=1693453800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsFx4mRVJVJC0t+ZBsw1YSpuCOjem+CIHrRc8h/J2ds=;
        b=HJbwHe2TOny6UhVKFzbRavF1lp1PFy+3M77OUQchajnUH0jsOx7t0qnrz3HG1sqQN/
         v9wg5hxedEUy2cBFXDshickzEdW3GiThLPM+daBH8+4vzTjnOZP060psGhYaR7hIPkBJ
         vy6FiR9BtLV8Q06rQvgCSFguYPGhGQm69BMWD+1T65nVm5/tggUgUISDwp/lftaxoruf
         RxsyaEnz4e/6XlgQTbklABmYCVhopRy4hFAec/Bz2vBvvhYRIrww+BESdpdz6eCLLEoG
         veVOGHvwJDSelWj+K5MXuDxn+/jTBCn7UWZcpPsLRE1WzhrYVsg5xqIilCmCP/HvdBqw
         LEXQ==
X-Gm-Message-State: AOJu0YwNZGPbbF4TedGp6fTp3+l7afQIBo5Ff2ueHuVce633pPR8n/e3
        MI+KDKVUzhcQYYYq71oo43m2oA==
X-Google-Smtp-Source: AGHT+IFxYqS0WbiBFxFNIpIUofKVES57OXzlEkcC/FgmP0MSEuq+oaMoG3jRL1U7GjoDzEUFD1Ph8g==
X-Received: by 2002:a05:6358:c62a:b0:139:fd45:5db5 with SMTP id fd42-20020a056358c62a00b00139fd455db5mr9357334rwb.1.1692848999669;
        Wed, 23 Aug 2023 20:49:59 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:49:59 -0700 (PDT)
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
Subject: [PATCH v5 42/45] mm: shrinker: make global slab shrink lockless
Date:   Thu, 24 Aug 2023 11:43:01 +0800
Message-Id: <20230824034304.37411-43-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 578599c9e12e..2b8c1f1bbf2d 100644
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
@@ -670,13 +688,29 @@ void shrinker_register(struct shrinker *shrinker)
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
@@ -685,9 +719,25 @@ void shrinker_free(struct shrinker *shrinker)
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
@@ -701,9 +751,6 @@ void shrinker_free(struct shrinker *shrinker)
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

