Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C319479B827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjIKUxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjIKJv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:51:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED44CE4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf11a7cf9fso7706865ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425913; x=1695030713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLAG3LFr2H9IpWa0Q1CUXr98GG6fWERP+Y/K9cMxF58=;
        b=RvyF4pPKBy5hOAHnud4//9lFEclFjxmW5j3JQfPkPaYaOMsFxQKMu/UxmJy6OMi3L3
         BPHS90rjo/y+fJR4oQcJLLXxnegjER8MQ9SUp3AoMyxNlZGd19xUSPuVNKUkl/O8r5KO
         p/dBHDDtkSqe4NAGtbDMzIR6jPPdMvwCI7pfWUX4/FV6PonfGVB+4MvIaK+hda/WfsnZ
         qHnwGtJjGtsZagqjLDfHppIiOMsEfJWBVeVDuCv3hROmy87gDA1aKjvePgTDAErDfkNe
         mu1ZdExuZMtTEDH3tdoN2B12n5DpbHFbAms9lc97RAG88IR62CVRMxoQy26Tm8VDwJm7
         Cf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425913; x=1695030713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLAG3LFr2H9IpWa0Q1CUXr98GG6fWERP+Y/K9cMxF58=;
        b=rRb6DLfGFDjnfxUQ1BMS+JuZZdlTNVrfmvMakqNQF1eebmN6/M12acQjQ/T5580bzh
         kWZy1J9Jph1/vb39cdxqlwdKMcCI4+F0JP8RELfPH/xjMy9GCOrpu1eInhncIyRW4Ac/
         CTQC8SzoVZWPkP6pWBl+J8t/WbSyUSWxk26phOUixpDK+0htvni/0snwdf08yWjkNPCn
         TrZ61lL987ZMruzzLfXQgvTeizN6tnf2KZSNeK1W3Llplt8Y9Ltem06CKKjDmIz88eRW
         ijTIs2uxKgbRmCqyGXZyCJEHRa+VlR3dk/zoNP7baigI6Wgz8iRCMwKbqM3QOSS7/lS7
         sDow==
X-Gm-Message-State: AOJu0YyVzObH9RDuaC8krcxNhk+Pybmq82kT/4KZ4OYbjUok1VXPaEUz
        zy9B3WRPBpcItF8H3MsZ4SxyUA==
X-Google-Smtp-Source: AGHT+IGwEyIZI7e/UGLTPntdnRUQTR+mAjNl7rxKGC9aX+dD26VCCxP8WJPLnCYFs0FvhQRvA39K8A==
X-Received: by 2002:a17:902:f155:b0:1c3:a4f2:7c99 with SMTP id d21-20020a170902f15500b001c3a4f27c99mr5142339plb.4.1694425913461;
        Mon, 11 Sep 2023 02:51:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:51:53 -0700 (PDT)
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
Subject: [PATCH v6 45/45] mm: shrinker: convert shrinker_rwsem to mutex
Date:   Mon, 11 Sep 2023 17:44:44 +0800
Message-Id: <20230911094444.68966-46-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now there are no readers of shrinker_rwsem, so we can simply replace it
with mutex lock.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/dm-cache-metadata.c |  2 +-
 fs/super.c                     |  2 +-
 mm/shrinker.c                  | 28 ++++++++++++++--------------
 mm/shrinker_debug.c            | 14 +++++++-------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index acffed750e3e..9e0c69958587 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1828,7 +1828,7 @@ int dm_cache_metadata_abort(struct dm_cache_metadata *cmd)
 	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
 	 * cmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
 	 * shrinker associated with the block manager's bufio client vs cmd root_lock).
-	 * - must take shrinker_rwsem without holding cmd->root_lock
+	 * - must take shrinker_mutex without holding cmd->root_lock
 	 */
 	new_bm = dm_block_manager_create(cmd->bdev, DM_CACHE_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
 					 CACHE_MAX_CONCURRENT_LOCKS);
diff --git a/fs/super.c b/fs/super.c
index adadf6689611..816a22a5cad1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -178,7 +178,7 @@ static void super_wake(struct super_block *sb, unsigned int flag)
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
  * If that happens we could trigger unregistering the shrinker from within the
- * shrinker path and that leads to deadlock on the shrinker_rwsem. Hence we
+ * shrinker path and that leads to deadlock on the shrinker_mutex. Hence we
  * take a passive reference to the superblock to avoid this from occurring.
  */
 static unsigned long super_cache_scan(struct shrinker *shrink,
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 471c07d75c4a..2c44c3d7afe9 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -8,7 +8,7 @@
 #include "internal.h"
 
 LIST_HEAD(shrinker_list);
-DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_MUTEX(shrinker_mutex);
 
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
@@ -80,7 +80,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	int nid, ret = 0;
 	int array_size = 0;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	array_size = shrinker_unit_size(shrinker_nr_max);
 	for_each_node(nid) {
 		info = kvzalloc_node(sizeof(*info) + array_size, GFP_KERNEL, nid);
@@ -91,7 +91,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 			goto err;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	return ret;
 
@@ -104,7 +104,7 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 						     int nid)
 {
 	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
-					 lockdep_is_held(&shrinker_rwsem));
+					 lockdep_is_held(&shrinker_mutex));
 }
 
 static int expand_one_shrinker_info(struct mem_cgroup *memcg, int new_size,
@@ -154,7 +154,7 @@ static int expand_shrinker_info(int new_id)
 	if (!root_mem_cgroup)
 		goto out;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	new_size = shrinker_unit_size(new_nr_max);
 	old_size = shrinker_unit_size(shrinker_nr_max);
@@ -217,7 +217,7 @@ static int shrinker_memcg_alloc(struct shrinker *shrinker)
 	if (mem_cgroup_disabled())
 		return -ENOSYS;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -231,7 +231,7 @@ static int shrinker_memcg_alloc(struct shrinker *shrinker)
 	shrinker->id = id;
 	ret = 0;
 unlock:
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 	return ret;
 }
 
@@ -241,7 +241,7 @@ static void shrinker_memcg_remove(struct shrinker *shrinker)
 
 	BUG_ON(id < 0);
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	idr_remove(&shrinker_idr, id);
 }
@@ -292,7 +292,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -305,7 +305,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			}
 		}
 	}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 }
 #else
 static int shrinker_memcg_alloc(struct shrinker *shrinker)
@@ -735,11 +735,11 @@ void shrinker_register(struct shrinker *shrinker)
 		return;
 	}
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	init_completion(&shrinker->done);
 	/*
@@ -779,7 +779,7 @@ void shrinker_free(struct shrinker *shrinker)
 		wait_for_completion(&shrinker->done);
 	}
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	if (shrinker->flags & SHRINKER_REGISTERED) {
 		/*
 		 * Now we can safely remove it from the shrinker_list and then
@@ -794,7 +794,7 @@ void shrinker_free(struct shrinker *shrinker)
 
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		shrinker_memcg_remove(shrinker);
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	if (debugfs_entry)
 		shrinker_debugfs_remove(debugfs_entry, debugfs_id);
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 38452f539f40..c80fd124f605 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -9,7 +9,7 @@
 #include "internal.h"
 
 /* defined in vmscan.c */
-extern struct rw_semaphore shrinker_rwsem;
+extern struct mutex shrinker_mutex;
 extern struct list_head shrinker_list;
 
 static DEFINE_IDA(shrinker_debugfs_ida);
@@ -165,7 +165,7 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	char buf[128];
 	int id;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	/* debugfs isn't initialized yet, add debugfs entries later. */
 	if (!shrinker_debugfs_root)
@@ -222,7 +222,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 	if (!new)
 		return -ENOMEM;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 
 	old = shrinker->name;
 	shrinker->name = new;
@@ -240,7 +240,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 			shrinker->debugfs_entry = entry;
 	}
 
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	kfree_const(old);
 
@@ -253,7 +253,7 @@ struct dentry *shrinker_debugfs_detach(struct shrinker *shrinker,
 {
 	struct dentry *entry = shrinker->debugfs_entry;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	shrinker_debugfs_name_free(shrinker);
 
@@ -281,14 +281,14 @@ static int __init shrinker_debugfs_init(void)
 	shrinker_debugfs_root = dentry;
 
 	/* Create debugfs entries for shrinkers registered at boot */
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	list_for_each_entry(shrinker, &shrinker_list, list)
 		if (!shrinker->debugfs_entry) {
 			ret = shrinker_debugfs_add(shrinker);
 			if (ret)
 				break;
 		}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	return ret;
 }
-- 
2.30.2

