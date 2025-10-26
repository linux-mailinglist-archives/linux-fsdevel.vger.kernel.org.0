Return-Path: <linux-fsdevel+bounces-65647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B4FC0B335
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 21:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89653A481A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EEA2FF669;
	Sun, 26 Oct 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xmk8ioc4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1BF2FF66B
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510987; cv=none; b=FZEJwjaZiXmuXlN9A6NR6cIFCkxMBwJ2SJgkFGjjs1xZKWys+H/Zg0uVWgLcsVnK3g3fI87Cxria2N8QEMMdOPq5Ku/s8s90FifljhkCHD3JUDlbZVA0e/weeAy6IdXbOb87owVI4Ng+74D/hyY5krdkd4XxDCoFV16IBSWtwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510987; c=relaxed/simple;
	bh=O7tmpME1aiHpwR0QCaYrfD8rkF5CU50jhYMdiVqZmAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M8RkhZsOmxOVIcd8UbxmER39tY8CCSxt2LNBqyd7CWh8zBAobddmbPC77lBHH6GBtwtq9wNqez5teKkGVR2M8spX7C3JrQjiK/ha+cT3xVoJYZOG5CTKP0qqOZfemgUXErxSIuVCjnpjzUsjmMYLiIWnCVo0Us9nP6kNIDmqHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xmk8ioc4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso2941676a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510984; x=1762115784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ6iXUx7fdxDQQtP216r+2zXM18ReAZgBiEpXox9Qzk=;
        b=Xmk8ioc4u+NqO8zY4PoVwRZKL5ZBnmnfRM1E+nEKoU4l32VtEXbf0tOsf1ZhmI80+m
         DLTLmi83qjE6UACurvOYqnZ5aqxVLirRMlM6movf/c4lRbdPtUe3Yd8HcfsEgs9mT1S+
         hJ+MCRHeF4g0qY0owId7nKWPE3F3Db6hVNUHkn3Q+o1I4Ee2xqXjZBbE8b9HOs//Bdup
         p85sELCFj/Q/qzAHtYotqRHl/xU9BWzfUHnl6Qg77IJ3ONUQBehT9gtv+1HYIKUqOzhD
         L8KHYOiCFg1KGJWqEymWLFDfWytvosUpWI4qiXf9XT2U6kDbIi/1Me7pIrDLZRTFhm+4
         MO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510984; x=1762115784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ6iXUx7fdxDQQtP216r+2zXM18ReAZgBiEpXox9Qzk=;
        b=Bm4lMDayIrzKFXsI4M1DDSOxIc/HjxsEgVMfLpvLSA5UUzv/TWQvW20kGTQiTyULR8
         O49pPxFOBwtZlMv79Xezwb5r9vj8a14v46KEA+axGDr4pCGmSBmSkv4vc+SYkmzHwMvO
         eAWXCKqo5RbM20vRBeM3C3mbw0FWqVGj4QJ6EjfAmnrTaccRZ1XexdsSpj1BP/hT323B
         OcFzo3DZbmlRxXdbO7JWxbpfLx3WnDWuUn2d3X4MQ5IBr2U8bIIGchkOSXfnHBAnHQ3r
         RsMOtSojQGJmmJjfPE2pdYX47uA5ElB/yatTknPjucaYbql5Y/L2RZahtQkgPTgQF11U
         9o8g==
X-Forwarded-Encrypted: i=1; AJvYcCUDNCURrxIF2nye9ZhhSI0L3gH4w8TSer4wz/MwLZVsWGSFMdnPKw6F+bZPciEZPd8tTyOGs9NXDTSY67kd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CPc9fTlQDIFJtCfYWLIrGZNCoCo7+xrybwT9Q6QTKWJ+/05a
	RxL6dVQTwXpt2TDcfG9BpyvOfJ+UHv7AoOd5JgU5SttVwl2T0/XjISdWAsciWzMt5EWmMv08ULQ
	x8lq4nA==
X-Google-Smtp-Source: AGHT+IFuTXFJaYUk8PlETNcdc2dA3jjCPbMMSpMoPQFxxPNRetezNstDACl0wQ0NFejn/XrjXpIWmWOUlEM=
X-Received: from pjbiq12.prod.google.com ([2002:a17:90a:fb4c:b0:32b:ae4c:196c])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164a:b0:30a:4874:5397
 with SMTP id 98e67ed59e1d1-33fafbaabb4mr15962311a91.9.1761510984182; Sun, 26
 Oct 2025 13:36:24 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:07 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-5-surenb@google.com>
Subject: [PATCH v2 4/8] mm/cleancache: add sysfs interface
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Create sysfs API under /sys/kernel/mm/cleancache/ to report the following
metrics:
  stored      - number of successful cleancache folio stores
  skipped     - number of folios skipped during cleancache store operation
  restored    - number of successful cleancache folio restore operations
  missed      - number of failed cleancache folio restore operations
  reclaimed   - number of folios dropped due to their age
  recalled    - number of folios dropped because cleancache backend took
                them back
  invalidated - number of folios dropped due to invalidation
  cached      - number of folios currently cached in the cleancache

In addition each pool creates a /sys/kernel/mm/cleancache/<pool name>
directory containing the following metrics:
  size        - number of folios in the pool
  cached      - number of folios currently cached in the pool
  recalled    - number of folios dropped from the pool because cleancache
                backend took them back

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS           |   2 +
 mm/Kconfig            |   8 ++
 mm/Makefile           |   1 +
 mm/cleancache.c       | 113 +++++++++++++++++++++--
 mm/cleancache_sysfs.c | 209 ++++++++++++++++++++++++++++++++++++++++++
 mm/cleancache_sysfs.h |  58 ++++++++++++
 6 files changed, 383 insertions(+), 8 deletions(-)
 create mode 100644 mm/cleancache_sysfs.c
 create mode 100644 mm/cleancache_sysfs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 90a6fc0e742c..84c65441925c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6060,6 +6060,8 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	include/linux/cleancache.h
 F:	mm/cleancache.c
+F:	mm/cleancache_sysfs.c
+F:	mm/cleancache_sysfs.h
 
 CLK API
 M:	Russell King <linux@armlinux.org.uk>
diff --git a/mm/Kconfig b/mm/Kconfig
index 1255b543030b..e1a169d5e5de 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1049,6 +1049,14 @@ config CLEANCACHE
 
 	  If unsure, say N.
 
+config CLEANCACHE_SYSFS
+	bool "Cleancache information through sysfs interface"
+	depends on CLEANCACHE && SYSFS
+	help
+	  This option exposes sysfs attributes to get information from
+	  cleancache. The user space can use this interface for querying
+	  cleancache and individual cleancache pool metrics.
+
 config CMA
 	bool "Contiguous Memory Allocator"
 	depends on MMU
diff --git a/mm/Makefile b/mm/Makefile
index b78073b87aea..a7a635f762ee 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
+obj-$(CONFIG_CLEANCACHE_SYSFS)	+= cleancache_sysfs.o
diff --git a/mm/cleancache.c b/mm/cleancache.c
index 6be86938c8fe..e05393fb6cbc 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -11,6 +11,8 @@
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
 
+#include "cleancache_sysfs.h"
+
 /*
  * Lock nesting:
  *	ccinode->folios.xa_lock
@@ -56,6 +58,8 @@ struct cleancache_inode {
 struct cleancache_pool {
 	struct list_head folio_list;
 	spinlock_t lock; /* protects folio_list */
+	char *name;
+	struct cleancache_pool_stats *stats;
 };
 
 #define CLEANCACHE_MAX_POOLS	64
@@ -104,6 +108,7 @@ static void attach_folio(struct folio *folio, struct cleancache_inode *ccinode,
 
 	folio->cc_inode = ccinode;
 	folio->cc_index = offset;
+	cleancache_pool_stat_inc(folio_pool(folio)->stats, POOL_CACHED);
 }
 
 static void detach_folio(struct folio *folio)
@@ -112,6 +117,7 @@ static void detach_folio(struct folio *folio)
 
 	folio->cc_inode = NULL;
 	folio->cc_index = 0;
+	cleancache_pool_stat_dec(folio_pool(folio)->stats, POOL_CACHED);
 }
 
 static void folio_attachment(struct folio *folio,
@@ -516,7 +522,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 	ccinode = find_and_get_inode(fs, inode);
 	if (!ccinode) {
 		if (!workingset)
-			return false;
+			goto out;
 
 		ccinode = add_and_get_inode(fs, inode);
 		if (IS_ERR_OR_NULL(ccinode)) {
@@ -536,6 +542,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 	if (stored_folio) {
 		if (!workingset) {
 			move_folio_from_inode_to_pool(ccinode, offset, stored_folio);
+			cleancache_stat_inc(RECLAIMED);
 			goto out_unlock;
 		}
 		rotate_lru_folio(stored_folio);
@@ -551,6 +558,8 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			xa_lock(&ccinode->folios);
 			if (!stored_folio)
 				goto out_unlock;
+
+			cleancache_stat_inc(RECLAIMED);
 		}
 
 		if (!store_folio_in_inode(ccinode, offset, stored_folio)) {
@@ -562,6 +571,7 @@ static bool store_into_inode(struct cleancache_fs *fs,
 			spin_unlock(&pool->lock);
 			goto out_unlock;
 		}
+		cleancache_stat_inc(STORED);
 		add_folio_to_lru(stored_folio);
 	}
 	copy_folio_content(folio, stored_folio);
@@ -573,6 +583,8 @@ static bool store_into_inode(struct cleancache_fs *fs,
 		remove_inode_if_empty(ccinode);
 	xa_unlock(&ccinode->folios);
 	put_inode(ccinode);
+out:
+	cleancache_stat_inc(SKIPPED);
 
 	return ret;
 }
@@ -583,23 +595,26 @@ static bool load_from_inode(struct cleancache_fs *fs,
 {
 	struct cleancache_inode *ccinode;
 	struct folio *stored_folio;
-	bool ret = false;
 
 	ccinode = find_and_get_inode(fs, inode);
-	if (!ccinode)
+	if (!ccinode) {
+		cleancache_stat_inc(MISSED);
 		return false;
+	}
 
 	xa_lock(&ccinode->folios);
 	stored_folio = xa_load(&ccinode->folios, offset);
 	if (stored_folio) {
 		rotate_lru_folio(stored_folio);
 		copy_folio_content(stored_folio, folio);
-		ret = true;
+		cleancache_stat_inc(RESTORED);
+	} else {
+		cleancache_stat_inc(MISSED);
 	}
 	xa_unlock(&ccinode->folios);
 	put_inode(ccinode);
 
-	return ret;
+	return !!stored_folio;
 }
 
 static bool invalidate_folio(struct cleancache_fs *fs,
@@ -614,8 +629,10 @@ static bool invalidate_folio(struct cleancache_fs *fs,
 
 	xa_lock(&ccinode->folios);
 	folio = xa_load(&ccinode->folios, offset);
-	if (folio)
+	if (folio) {
 		move_folio_from_inode_to_pool(ccinode, offset, folio);
+		cleancache_stat_inc(INVALIDATED);
+	}
 	xa_unlock(&ccinode->folios);
 	put_inode(ccinode);
 
@@ -636,6 +653,7 @@ static unsigned int invalidate_inode(struct cleancache_fs *fs,
 		ret = erase_folios_from_inode(ccinode, &xas);
 		xas_unlock(&xas);
 		put_inode(ccinode);
+		cleancache_stat_add(INVALIDATED, ret);
 
 		return ret;
 	}
@@ -643,6 +661,53 @@ static unsigned int invalidate_inode(struct cleancache_fs *fs,
 	return 0;
 }
 
+/* Sysfs helpers */
+#ifdef CONFIG_CLEANCACHE_SYSFS
+
+static struct kobject *kobj_sysfs_root;
+
+static void __init cleancache_sysfs_init(void)
+{
+	struct cleancache_pool *pool;
+	int pool_id, pool_count;
+	struct kobject *kobj;
+
+	kobj = cleancache_sysfs_create_root();
+	if (IS_ERR(kobj)) {
+		pr_warn("Failed to create cleancache sysfs root\n");
+		return;
+	}
+
+	kobj_sysfs_root = kobj;
+	if (!kobj_sysfs_root)
+		return;
+
+	pool_count = atomic_read(&nr_pools);
+	pool = &pools[0];
+	for (pool_id = 0; pool_id < pool_count; pool_id++, pool++)
+		if (cleancache_sysfs_create_pool(kobj_sysfs_root, pool->stats, pool->name))
+			pr_warn("Failed to create sysfs nodes for \'%s\' cleancache backend\n",
+				pool->name);
+}
+
+static void cleancache_sysfs_pool_init(struct cleancache_pool_stats *pool_stats,
+				       const char *name)
+{
+	/* Skip if sysfs was not initialized yet. */
+	if (!kobj_sysfs_root)
+		return;
+
+	if (cleancache_sysfs_create_pool(kobj_sysfs_root, pool_stats, name))
+		pr_warn("Failed to create sysfs nodes for \'%s\' cleancache backend\n",
+			name);
+}
+
+#else /* CONFIG_CLEANCACHE_SYSFS */
+static inline void cleancache_sysfs_init(void) {}
+static inline void cleancache_sysfs_pool_init(struct cleancache_pool_stats *pool_stats,
+					      const char *name) {}
+#endif /* CONFIG_CLEANCACHE_SYSFS */
+
 /* Hooks into MM and FS */
 int cleancache_add_fs(struct super_block *sb)
 {
@@ -820,6 +885,7 @@ cleancache_start_inode_walk(struct inode *inode, unsigned long count)
 	ccinode = find_and_get_inode(fs, inode);
 	if (!ccinode) {
 		put_fs(fs);
+		cleancache_stat_add(MISSED, count);
 		return NULL;
 	}
 
@@ -850,7 +916,10 @@ bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
 		memcpy(dst, src, PAGE_SIZE);
 		kunmap_local(dst);
 		kunmap_local(src);
+		cleancache_stat_inc(RESTORED);
 		ret = true;
+	} else {
+		cleancache_stat_inc(MISSED);
 	}
 	xa_unlock(&ccinode->folios);
 
@@ -864,9 +933,18 @@ bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
  */
 int cleancache_backend_register_pool(const char *name)
 {
+	struct cleancache_pool_stats *pool_stats;
 	struct cleancache_pool *pool;
+	char *pool_name;
 	int pool_id;
 
+	if (!name)
+		return -EINVAL;
+
+	pool_name = kstrdup(name, GFP_KERNEL);
+	if (!pool_name)
+		return -ENOMEM;
+
 	/* pools_lock prevents concurrent registrations */
 	spin_lock(&pools_lock);
 	pool_id = atomic_read(&nr_pools);
@@ -878,12 +956,22 @@ int cleancache_backend_register_pool(const char *name)
 	pool = &pools[pool_id];
 	INIT_LIST_HEAD(&pool->folio_list);
 	spin_lock_init(&pool->lock);
+	pool->name = pool_name;
 	/* Ensure above stores complete before we increase the count */
 	atomic_set_release(&nr_pools, pool_id + 1);
 	spin_unlock(&pools_lock);
 
+	pool_stats = cleancache_create_pool_stats(pool_id);
+	if (!IS_ERR(pool_stats)) {
+		pool->stats = pool_stats;
+		cleancache_sysfs_pool_init(pool_stats, pool->name);
+	} else {
+		pr_warn("Failed to create pool stats for \'%s\' cleancache backend\n",
+			pool->name);
+	}
+
 	pr_info("Registered \'%s\' cleancache backend, pool id %d\n",
-		name ? : "none", pool_id);
+		name, pool_id);
 
 	return pool_id;
 }
@@ -930,10 +1018,13 @@ int cleancache_backend_get_folio(int pool_id, struct folio *folio)
 		goto again;
 	}
 
+	cleancache_stat_inc(RECALLED);
+	cleancache_pool_stat_inc(folio_pool(folio)->stats, POOL_RECALLED);
 	put_inode(ccinode);
 out:
 	VM_BUG_ON_FOLIO(folio_ref_count(folio) != 0, (folio));
 	clear_cleancache_folio(folio);
+	cleancache_pool_stat_dec(pool->stats, POOL_SIZE);
 
 	return 0;
 }
@@ -955,6 +1046,7 @@ int cleancache_backend_put_folio(int pool_id, struct folio *folio)
 	INIT_LIST_HEAD(&folio->lru);
 	spin_lock(&pool->lock);
 	add_folio_to_pool(folio, pool);
+	cleancache_pool_stat_inc(pool->stats, POOL_SIZE);
 	spin_unlock(&pool->lock);
 
 	return 0;
@@ -967,6 +1059,7 @@ int cleancache_backend_put_folios(int pool_id, struct list_head *folios)
 	LIST_HEAD(unused_folios);
 	struct folio *folio;
 	struct folio *tmp;
+	int count = 0;
 
 	list_for_each_entry_safe(folio, tmp, folios, lru) {
 		/* Do not support large folios yet */
@@ -976,10 +1069,12 @@ int cleancache_backend_put_folios(int pool_id, struct list_head *folios)
 
 		init_cleancache_folio(folio, pool_id);
 		list_move(&folio->lru, &unused_folios);
+		count++;
 	}
 
 	spin_lock(&pool->lock);
 	list_splice_init(&unused_folios, &pool->folio_list);
+	cleancache_pool_stat_add(pool->stats, POOL_SIZE, count);
 	spin_unlock(&pool->lock);
 
 	return list_empty(folios) ? 0 : -EINVAL;
@@ -992,6 +1087,8 @@ static int __init init_cleancache(void)
 	if (!slab_inode)
 		return -ENOMEM;
 
+	cleancache_sysfs_init();
+
 	return 0;
 }
-core_initcall(init_cleancache);
+subsys_initcall(init_cleancache);
diff --git a/mm/cleancache_sysfs.c b/mm/cleancache_sysfs.c
new file mode 100644
index 000000000000..5ad7ae84ca1d
--- /dev/null
+++ b/mm/cleancache_sysfs.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kobject.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include "cleancache_sysfs.h"
+
+static atomic64_t stats[CLEANCACHE_STAT_NR];
+
+void cleancache_stat_inc(enum cleancache_stat type)
+{
+	atomic64_inc(&stats[type]);
+}
+
+void cleancache_stat_add(enum cleancache_stat type, unsigned long delta)
+{
+	atomic64_add(delta, &stats[type]);
+}
+
+void cleancache_pool_stat_inc(struct cleancache_pool_stats *pool_stats,
+			      enum cleancache_pool_stat type)
+{
+	atomic64_inc(&pool_stats->stats[type]);
+}
+
+void cleancache_pool_stat_dec(struct cleancache_pool_stats *pool_stats,
+			      enum cleancache_pool_stat type)
+{
+	atomic64_dec(&pool_stats->stats[type]);
+}
+
+void cleancache_pool_stat_add(struct cleancache_pool_stats *pool_stats,
+			      enum cleancache_pool_stat type, long delta)
+{
+	atomic64_add(delta, &pool_stats->stats[type]);
+}
+
+#define CLEANCACHE_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+static inline struct cleancache_pool_stats *kobj_to_stats(struct kobject *kobj)
+{
+	return container_of(kobj, struct cleancache_pool_stats, kobj);
+}
+
+static ssize_t stored_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[STORED]));
+}
+CLEANCACHE_ATTR_RO(stored);
+
+static ssize_t skipped_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[SKIPPED]));
+}
+CLEANCACHE_ATTR_RO(skipped);
+
+static ssize_t restored_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[RESTORED]));
+}
+CLEANCACHE_ATTR_RO(restored);
+
+static ssize_t missed_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[MISSED]));
+}
+CLEANCACHE_ATTR_RO(missed);
+
+static ssize_t reclaimed_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[RECLAIMED]));
+}
+CLEANCACHE_ATTR_RO(reclaimed);
+
+static ssize_t recalled_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[RECALLED]));
+}
+CLEANCACHE_ATTR_RO(recalled);
+
+static ssize_t invalidated_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&stats[INVALIDATED]));
+}
+CLEANCACHE_ATTR_RO(invalidated);
+
+static ssize_t cached_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	s64 dropped = atomic64_read(&stats[INVALIDATED]) +
+			atomic64_read(&stats[RECLAIMED]) +
+			atomic64_read(&stats[RECALLED]);
+
+	return sysfs_emit(buf, "%llu\n", (u64)(atomic64_read(&stats[STORED]) - dropped));
+}
+CLEANCACHE_ATTR_RO(cached);
+
+static struct attribute *cleancache_attrs[] = {
+	&stored_attr.attr,
+	&skipped_attr.attr,
+	&restored_attr.attr,
+	&missed_attr.attr,
+	&reclaimed_attr.attr,
+	&recalled_attr.attr,
+	&invalidated_attr.attr,
+	&cached_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cleancache);
+
+#define CLEANCACHE_POOL_ATTR_RO(_name) \
+	static struct kobj_attribute _name##_pool_attr = {		\
+		.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+		.show	= _name##_pool_show,				\
+}
+
+static ssize_t size_pool_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+		(u64)atomic64_read(&kobj_to_stats(kobj)->stats[POOL_SIZE]));
+}
+CLEANCACHE_POOL_ATTR_RO(size);
+
+static ssize_t cached_pool_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+		(u64)atomic64_read(&kobj_to_stats(kobj)->stats[POOL_CACHED]));
+}
+CLEANCACHE_POOL_ATTR_RO(cached);
+
+static ssize_t recalled_pool_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%llu\n",
+		(u64)atomic64_read(&kobj_to_stats(kobj)->stats[POOL_RECALLED]));
+}
+CLEANCACHE_POOL_ATTR_RO(recalled);
+
+
+static struct attribute *cleancache_pool_attrs[] = {
+	&size_pool_attr.attr,
+	&cached_pool_attr.attr,
+	&recalled_pool_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(cleancache_pool);
+
+static void cleancache_pool_release(struct kobject *kobj)
+{
+	kfree(kobj_to_stats(kobj));
+}
+
+static const struct kobj_type cleancache_pool_ktype = {
+	.release = &cleancache_pool_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = cleancache_pool_groups,
+};
+
+struct cleancache_pool_stats *cleancache_create_pool_stats(int pool_id)
+{
+	struct cleancache_pool_stats *pool_stats;
+
+	pool_stats = kzalloc(sizeof(*pool_stats), GFP_KERNEL);
+	if (!pool_stats)
+		return ERR_PTR(-ENOMEM);
+
+	pool_stats->pool_id = pool_id;
+
+	return pool_stats;
+}
+
+struct kobject * __init cleancache_sysfs_create_root(void)
+{
+	struct kobject *kobj;
+	int err;
+
+	kobj = kobject_create_and_add("cleancache", mm_kobj);
+	if (unlikely(!kobj)) {
+		pr_err("Failed to create cleancache kobject\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	err = sysfs_create_group(kobj, cleancache_groups[0]);
+	if (err) {
+		kobject_put(kobj);
+		pr_err("Failed to create cleancache group kobject\n");
+		return ERR_PTR(err);
+	}
+
+	return kobj;
+}
+
+int cleancache_sysfs_create_pool(struct kobject *root_kobj,
+				 struct cleancache_pool_stats *pool_stats,
+				 const char *name)
+{
+	return kobject_init_and_add(&pool_stats->kobj, &cleancache_pool_ktype,
+				    root_kobj, name);
+}
diff --git a/mm/cleancache_sysfs.h b/mm/cleancache_sysfs.h
new file mode 100644
index 000000000000..fb8d2a72be63
--- /dev/null
+++ b/mm/cleancache_sysfs.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CLEANCACHE_SYSFS_H__
+#define __CLEANCACHE_SYSFS_H__
+
+enum cleancache_stat {
+	STORED,
+	SKIPPED,
+	RESTORED,
+	MISSED,
+	RECLAIMED,
+	RECALLED,
+	INVALIDATED,
+	CLEANCACHE_STAT_NR
+};
+
+enum cleancache_pool_stat {
+	POOL_SIZE,
+	POOL_CACHED,
+	POOL_RECALLED,
+	CLEANCACHE_POOL_STAT_NR
+};
+
+struct cleancache_pool_stats {
+	struct kobject kobj;
+	int pool_id;
+	atomic64_t stats[CLEANCACHE_POOL_STAT_NR];
+};
+
+#ifdef CONFIG_CLEANCACHE_SYSFS
+void cleancache_stat_inc(enum cleancache_stat type);
+void cleancache_stat_add(enum cleancache_stat type, unsigned long delta);
+void cleancache_pool_stat_inc(struct cleancache_pool_stats *pool_stats,
+			 enum cleancache_pool_stat type);
+void cleancache_pool_stat_dec(struct cleancache_pool_stats *pool_stats,
+			 enum cleancache_pool_stat type);
+void cleancache_pool_stat_add(struct cleancache_pool_stats *pool_stats,
+			 enum cleancache_pool_stat type, long delta);
+struct cleancache_pool_stats *cleancache_create_pool_stats(int pool_id);
+struct kobject * __init cleancache_sysfs_create_root(void);
+int cleancache_sysfs_create_pool(struct kobject *root_kobj,
+				 struct cleancache_pool_stats *pool_stats,
+				 const char *name);
+
+#else /* CONFIG_CLEANCACHE_SYSFS */
+static inline void cleancache_stat_inc(enum cleancache_stat type) {}
+static inline void cleancache_stat_add(enum cleancache_stat type, unsigned long delta) {}
+static inline void cleancache_pool_stat_inc(struct cleancache_pool_stats *pool_stats,
+				       enum cleancache_pool_stat type) {}
+static inline void cleancache_pool_stat_dec(struct cleancache_pool_stats *pool_stats,
+				       enum cleancache_pool_stat type) {}
+static inline void cleancache_pool_stat_add(struct cleancache_pool_stats *pool_stats,
+				       enum cleancache_pool_stat type, long delta) {}
+static inline
+struct cleancache_pool_stats *cleancache_create_pool_stats(int pool_id) { return NULL; }
+
+#endif /* CONFIG_CLEANCACHE_SYSFS */
+
+#endif /* __CLEANCACHE_SYSFS_H__ */
-- 
2.51.1.851.g4ebd6896fd-goog


