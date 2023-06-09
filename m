Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A940A7292C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbjFIISZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 04:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjFIIRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:17:51 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE26D3A9A
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 01:17:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686298638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fW5UuGuy06FRX8Px/N9YG/QTNF0coGlqdNSj4AuBaaM=;
        b=tddMOX9hrmBcUy1TaN6PYmjZr8N6htWv1AKIwBbCiMwwdMPB0GeJMYgG8Z8I93aOe/HBvd
        5BXFnyv6bfT5hursOmsbSE208IL5wiQKL+bwZlti5+T99GzbUZ4tm7iuHx6iPsFe8QHCGt
        jtNfOoIRqSFtiW109WCZ6dTaNr7m36M=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     david@fromorbit.com, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, muchun.song@linux.dev, yujie.liu@intel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 4/7] Revert "mm: shrinkers: make count and scan in shrinker debugfs lockless"
Date:   Fri,  9 Jun 2023 08:15:15 +0000
Message-Id: <20230609081518.3039120-5-qi.zheng@linux.dev>
In-Reply-To: <20230609081518.3039120-1-qi.zheng@linux.dev>
References: <20230609081518.3039120-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

This reverts commit 20cd1892fcc3efc10a7ac327cc3790494bec46b5.

Kernel test robot reports -88.8% regression in stress-ng.ramfs.ops_per_sec
test case [1], which is caused by commit f95bdb700bc6 ("mm: vmscan: make
global slab shrink lockless"). The root cause is that SRCU has to be careful
to not frequently check for SRCU read-side critical section exits. Therefore,
even if no one is currently in the SRCU read-side critical section,
synchronize_srcu() cannot return quickly. That's why unregister_shrinker()
has become slower.

We will try to use the refcount+RCU method [2] proposed by Dave Chinner
to continue to re-implement the lockless slab shrink. So revert the
shrinker_srcu related changes first.

[1]. https://lore.kernel.org/lkml/202305230837.db2c233f-yujie.liu@intel.com/
[2]. https://lore.kernel.org/lkml/ZIJhou1d55d4H1s0@dread.disaster.area/

Reported-by: kernel test robot <yujie.liu@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305230837.db2c233f-yujie.liu@intel.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/shrinker_debug.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 2be15b8a6d0b..3ab53fad8876 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -5,12 +5,10 @@
 #include <linux/seq_file.h>
 #include <linux/shrinker.h>
 #include <linux/memcontrol.h>
-#include <linux/srcu.h>
 
 /* defined in vmscan.c */
 extern struct rw_semaphore shrinker_rwsem;
 extern struct list_head shrinker_list;
-extern struct srcu_struct shrinker_srcu;
 
 static DEFINE_IDA(shrinker_debugfs_ida);
 static struct dentry *shrinker_debugfs_root;
@@ -51,13 +49,18 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 	struct mem_cgroup *memcg;
 	unsigned long total;
 	bool memcg_aware;
-	int ret = 0, nid, srcu_idx;
+	int ret, nid;
 
 	count_per_node = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
 	if (!count_per_node)
 		return -ENOMEM;
 
-	srcu_idx = srcu_read_lock(&shrinker_srcu);
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret) {
+		kfree(count_per_node);
+		return ret;
+	}
+	rcu_read_lock();
 
 	memcg_aware = shrinker->flags & SHRINKER_MEMCG_AWARE;
 
@@ -88,7 +91,8 @@ static int shrinker_debugfs_count_show(struct seq_file *m, void *v)
 		}
 	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 
-	srcu_read_unlock(&shrinker_srcu, srcu_idx);
+	rcu_read_unlock();
+	up_read(&shrinker_rwsem);
 
 	kfree(count_per_node);
 	return ret;
@@ -111,8 +115,9 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		.gfp_mask = GFP_KERNEL,
 	};
 	struct mem_cgroup *memcg = NULL;
-	int nid, srcu_idx;
+	int nid;
 	char kbuf[72];
+	ssize_t ret;
 
 	read_len = size < (sizeof(kbuf) - 1) ? size : (sizeof(kbuf) - 1);
 	if (copy_from_user(kbuf, buf, read_len))
@@ -141,7 +146,11 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 		return -EINVAL;
 	}
 
-	srcu_idx = srcu_read_lock(&shrinker_srcu);
+	ret = down_read_killable(&shrinker_rwsem);
+	if (ret) {
+		mem_cgroup_put(memcg);
+		return ret;
+	}
 
 	sc.nid = nid;
 	sc.memcg = memcg;
@@ -150,7 +159,7 @@ static ssize_t shrinker_debugfs_scan_write(struct file *file,
 
 	shrinker->scan_objects(shrinker, &sc);
 
-	srcu_read_unlock(&shrinker_srcu, srcu_idx);
+	up_read(&shrinker_rwsem);
 	mem_cgroup_put(memcg);
 
 	return size;
-- 
2.30.2

