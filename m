Return-Path: <linux-fsdevel+bounces-65648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF43C0B341
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 21:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2403A8BE9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989032FFFAD;
	Sun, 26 Oct 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFA4sbsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEDE2F7AAC
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510989; cv=none; b=ToovUoYoN6cix+ERofR+JadJ1Ac8VzhcYx2Uit0uctCsG5PGqxWNjKDIHAIspisjkRnj9YddAAPsIzii7SwvpGoKpOYmobEiCQQEbnnkpnkiG4apbLblWVQ4gRtuZ9bydCod8PSoQ34e5niHWfWolxqadu1nWIXlCKvpG8EAKQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510989; c=relaxed/simple;
	bh=Ewf7d8dzz80mYCLF3eYnDfn+135PfKWViEkDOugG40w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=slnqlGCft32mAXLhIKESKCgkiEBD1f6+pLZhaDoNyBp+aay7Wa1UkQNKqnrcWaHKLkRGq5o21MLdnFaU0a80VxRY5N1Ln+Qt/O0RYaZRkGamofgGHxPoYOhZIrowiltrHcis+/cJZFsPLPEnGfHkD5hNBIeLuJzsgIusPQFFgns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFA4sbsm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so3178530a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510986; x=1762115786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=USSd8AHtteHb2nV8AbO7svrSO39Djo3Im1//raAWLJU=;
        b=QFA4sbsmhu9unqFn3wjidCV4uzitzM6oi+sNUTPy2bo/g8CEy9B9wyht6kKDlx5G5W
         1z6izZhYMo9V883Um0TECm8Ajl/LneibqAHusFJ+EpBvPmR8LTDl5+yrJYehiC6fbDQU
         wCko4w6sB1hZs1wZNvqaUR3eUUJr0l2Cdxg/e8Xh92klgEMZLE9COQHRU5HY0pTMh6+r
         78VF9Amubmqpsjvb7xRwaBAQNYMBF7Ae+4DLs6CpjMMaayX4483v2PHERRtyYQ46TC5e
         ILAqBbUX2BqgSNPl5wdHm1+cSlCauSlarT0hzGp96/ukRUifjVjqHGzFcVxeki0YXgYt
         yuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510986; x=1762115786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USSd8AHtteHb2nV8AbO7svrSO39Djo3Im1//raAWLJU=;
        b=iMIIg6j3YkP7Mm81W4SCyno2Ux13ijB5J84cppRmVCWoabCnTs+cBq7af7IAuAL6VI
         WF/HeMqFINoszsbVBsz+UyuTWrh/fd6rtqwjGoagaTbnOrl6LCNAkxt8ef8ICA2sOtq4
         g3ssyJWrMaO+eml0AH/OqQTMXrpaOeaTotdAZskXownUBpjjxMFZBkWH7Rxh6kWmY0+D
         dnhErGzIYblf8U4S706LVk0DL3G2Ri2vYBfzMwaDa95U51IOuAqAOL8Brsfyvsi/fWgZ
         lVdynYmJF+DyoBrybyHhRxfNJiG051kZhhzk5FaV5qEjNX+KpieqpsQPfuoHyoe08Jfp
         REww==
X-Forwarded-Encrypted: i=1; AJvYcCUtNDyuxrfbApkRvEKKQ8IW9z+sGvyefUwLSihipZJIrZxL5ndZpJsprQGfpIdeWZxcUhxQ1qEwYfKS6BMa@vger.kernel.org
X-Gm-Message-State: AOJu0YyouiH7l0V7rr5/QQd0J9QcpYMjuDbUY+u/qE7Q0xlXHR0HYWXG
	K9S4HHjWQr3pJoHIP5d8YWqYQwG0g1/FK7Zx1Gz4Yxvxi+sJUBeSEQfuFnLkjWy/DO7bu+oiImQ
	V77yNCw==
X-Google-Smtp-Source: AGHT+IG5e+sJ763+GZbRcz9p1ZEjxUkQ3y8UIF+B9Xw83UG2kCj7XuwlvfMaiyl2KkKiIAV8c3TlzB8PfA0=
X-Received: from pjur16.prod.google.com ([2002:a17:90a:d410:b0:32d:dbd4:5cf3])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c48:b0:32e:d9db:7a86
 with SMTP id 98e67ed59e1d1-33bcf85313bmr46310640a91.7.1761510986299; Sun, 26
 Oct 2025 13:36:26 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:08 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-6-surenb@google.com>
Subject: [PATCH v2 5/8] mm/tests: add cleancache kunit test
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

Introduce a kunit test that creates fake inodes, fills them with folios
with predefined content, registers a cleancache pool, allocates and
donates folios to the new pool. After this initialization it runs
several scenarios:
1. cleancache_restore_test - stores fake inode pages into cleancache,
then restores them into auxiliary folios and checks restored content;
2. cleancache_invalidate_test - stores a folio, successfully restores
it, invalidates it and tries to restore again expecting a failure;
3. cleancache_reclaim_test - fills up the cleancache, stores one
more folio and verifies that the oldest folio got reclaimed;
4. cleancache_backend_api_test - takes all donated folios and puts them
back verifying the results;

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS                 |   1 +
 mm/Kconfig.debug            |  13 ++
 mm/Makefile                 |   1 +
 mm/cleancache.c             |  35 ++-
 mm/tests/Makefile           |   6 +
 mm/tests/cleancache_kunit.c | 420 ++++++++++++++++++++++++++++++++++++
 6 files changed, 475 insertions(+), 1 deletion(-)
 create mode 100644 mm/tests/Makefile
 create mode 100644 mm/tests/cleancache_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 84c65441925c..eb35973e10c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6062,6 +6062,7 @@ F:	include/linux/cleancache.h
 F:	mm/cleancache.c
 F:	mm/cleancache_sysfs.c
 F:	mm/cleancache_sysfs.h
+F:	mm/tests/cleancache_kunit.c
 
 CLK API
 M:	Russell King <linux@armlinux.org.uk>
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..c3482f7bc977 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -309,3 +309,16 @@ config PER_VMA_LOCK_STATS
 	  overhead in the page fault path.
 
 	  If in doubt, say N.
+
+config CLEANCACHE_KUNIT
+	tristate "KUnit test for cleancache" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on CLEANCACHE
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the cleancache unit test.
+	  Tests the clencache functionality.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/mm/Makefile b/mm/Makefile
index a7a635f762ee..845841a140e3 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -70,6 +70,7 @@ obj-y += init-mm.o
 obj-y += memblock.o
 obj-y += $(memory-hotplug-y)
 obj-y += slub.o
+obj-y += tests/
 
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
diff --git a/mm/cleancache.c b/mm/cleancache.c
index e05393fb6cbc..0ed67afd23ec 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -10,6 +10,8 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <kunit/test-bug.h>
+#include <kunit/test.h>
 
 #include "cleancache_sysfs.h"
 
@@ -72,6 +74,28 @@ static DEFINE_SPINLOCK(pools_lock); /* protects pools */
 static LIST_HEAD(cleancache_lru);
 static DEFINE_SPINLOCK(lru_lock); /* protects cleancache_lru */
 
+#if IS_ENABLED(CONFIG_CLEANCACHE_KUNIT)
+
+static bool is_pool_allowed(int pool_id)
+{
+	struct kunit *test = kunit_get_current_test();
+
+	/* Restrict kunit tests to using only the test pool */
+	return test && *((int *)test->priv) == pool_id;
+}
+
+#else /* CONFIG_CLEANCACHE_KUNIT */
+
+static bool is_pool_allowed(int pool_id) { return true; }
+
+#endif /* CONFIG_CLEANCACHE_KUNIT */
+
+#if IS_MODULE(CONFIG_CLEANCACHE_KUNIT)
+#define EXPORT_SYMBOL_FOR_KUNIT(x) EXPORT_SYMBOL(x)
+#else
+#define EXPORT_SYMBOL_FOR_KUNIT(x)
+#endif
+
 static inline void init_cleancache_folio(struct folio *folio, int pool_id)
 {
 	/* Folio is being donated and has no refs. No locking is needed. */
@@ -178,7 +202,7 @@ static struct folio *pick_folio_from_any_pool(void)
 	for (int i = 0; i < count; i++) {
 		pool = &pools[i];
 		spin_lock(&pool->lock);
-		if (!list_empty(&pool->folio_list)) {
+		if (!list_empty(&pool->folio_list) && is_pool_allowed(i)) {
 			folio = list_last_entry(&pool->folio_list,
 						struct folio, lru);
 			WARN_ON(!remove_folio_from_pool(folio, pool));
@@ -737,6 +761,7 @@ int cleancache_add_fs(struct super_block *sb)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_add_fs);
 
 void cleancache_remove_fs(struct super_block *sb)
 {
@@ -754,6 +779,7 @@ void cleancache_remove_fs(struct super_block *sb)
 	/* free the object */
 	put_fs(fs);
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_remove_fs);
 
 bool cleancache_store_folio(struct inode *inode, struct folio *folio)
 {
@@ -783,6 +809,7 @@ bool cleancache_store_folio(struct inode *inode, struct folio *folio)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_store_folio);
 
 bool cleancache_restore_folio(struct inode *inode, struct folio *folio)
 {
@@ -810,6 +837,7 @@ bool cleancache_restore_folio(struct inode *inode, struct folio *folio)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_restore_folio);
 
 bool cleancache_invalidate_folio(struct inode *inode, struct folio *folio)
 {
@@ -840,6 +868,7 @@ bool cleancache_invalidate_folio(struct inode *inode, struct folio *folio)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_invalidate_folio);
 
 bool cleancache_invalidate_inode(struct inode *inode)
 {
@@ -863,6 +892,7 @@ bool cleancache_invalidate_inode(struct inode *inode)
 
 	return count > 0;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_invalidate_inode);
 
 struct cleancache_inode *
 cleancache_start_inode_walk(struct inode *inode, unsigned long count)
@@ -891,6 +921,7 @@ cleancache_start_inode_walk(struct inode *inode, unsigned long count)
 
 	return ccinode;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_start_inode_walk);
 
 void cleancache_end_inode_walk(struct cleancache_inode *ccinode)
 {
@@ -899,6 +930,7 @@ void cleancache_end_inode_walk(struct cleancache_inode *ccinode)
 	put_inode(ccinode);
 	put_fs(fs);
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_end_inode_walk);
 
 bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
 				   struct folio *folio)
@@ -925,6 +957,7 @@ bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_restore_from_inode);
 
 /* Backend API */
 /*
diff --git a/mm/tests/Makefile b/mm/tests/Makefile
new file mode 100644
index 000000000000..fac2e964b4d5
--- /dev/null
+++ b/mm/tests/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for tests of kernel mm subsystem.
+
+# KUnit tests
+obj-$(CONFIG_CLEANCACHE_KUNIT) += cleancache_kunit.o
diff --git a/mm/tests/cleancache_kunit.c b/mm/tests/cleancache_kunit.c
new file mode 100644
index 000000000000..bb431f8021a6
--- /dev/null
+++ b/mm/tests/cleancache_kunit.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit test for the Cleancache.
+ *
+ * Copyright (C) 2025, Google LLC.
+ * Author: Suren Baghdasaryan <surenb@google.com>
+ */
+#include <kunit/test.h>
+
+#include <linux/cleancache.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+
+#include "../internal.h"
+
+#define INODE_COUNT		5
+#define FOLIOS_PER_INODE	4
+#define FOLIO_COUNT		(INODE_COUNT * FOLIOS_PER_INODE)
+
+static const u32 TEST_CONTENT = 0xBADCAB32;
+
+struct inode_data {
+	struct address_space mapping;
+	struct inode inode;
+	struct folio *folios[FOLIOS_PER_INODE];
+};
+
+static struct test_data {
+	/* Mock a fs */
+	struct super_block sb;
+	struct inode_data inodes[INODE_COUNT];
+	/* Folios donated to the cleancache pools */
+	struct folio *pool_folios[FOLIO_COUNT];
+	/* Auxiliary folio */
+	struct folio *aux_folio;
+	int pool_id;
+} test_data;
+
+static void set_folio_content(struct folio *folio, u32 value)
+{
+	u32 *data;
+
+	data = kmap_local_folio(folio, 0);
+	*data = value;
+	kunmap_local(data);
+}
+
+static u32 get_folio_content(struct folio *folio)
+{
+	unsigned long value;
+	u32 *data;
+
+	data = kmap_local_folio(folio, 0);
+	value = *data;
+	kunmap_local(data);
+
+	return value;
+}
+
+static void fill_cleancache(struct kunit *test)
+{
+	struct inode_data *inode_data;
+	struct folio *folio;
+
+	/* Store inode folios into cleancache */
+	for (int inode = 0; inode < INODE_COUNT; inode++) {
+		inode_data = &test_data.inodes[inode];
+		for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+			folio = inode_data->folios[fidx];
+			KUNIT_EXPECT_NOT_NULL(test, folio);
+			folio_lock(folio); /* Folio has to be locked */
+			folio_set_workingset(folio);
+			KUNIT_EXPECT_TRUE(test, cleancache_store_folio(&inode_data->inode, folio));
+			folio_unlock(folio);
+		}
+	}
+}
+
+static int cleancache_suite_init(struct kunit_suite *suite)
+{
+	LIST_HEAD(pool_folios);
+
+	/* Add a fake fs superblock */
+	cleancache_add_fs(&test_data.sb);
+
+	/* Initialize fake inodes */
+	for (int inode = 0; inode < INODE_COUNT; inode++) {
+		struct inode_data *inode_data = &test_data.inodes[inode];
+
+		inode_data->inode.i_sb = &test_data.sb;
+		inode_data->inode.i_ino = inode;
+		inode_data->inode.i_mapping = &inode_data->mapping;
+		inode_data->mapping.host = &inode_data->inode;
+
+		/* Allocate folios for the inode  */
+		for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+			struct folio *folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+			if (!folio)
+				return -ENOMEM;
+
+			set_folio_content(folio, (u32)fidx);
+			folio->mapping = &inode_data->mapping;
+			folio->index = PAGE_SIZE * fidx;
+			inode_data->folios[fidx] = folio;
+		}
+	}
+
+	/* Register new cleancache pool and donate test folios */
+	test_data.pool_id = cleancache_backend_register_pool("kunit_pool");
+	if (test_data.pool_id < 0)
+		return -EINVAL;
+
+	/* Allocate folios and put them to cleancache  */
+	for (int fidx = 0; fidx < FOLIO_COUNT; fidx++) {
+		struct folio *folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+
+		if (!folio)
+			return -ENOMEM;
+
+		folio_ref_freeze(folio, 1);
+		test_data.pool_folios[fidx] = folio;
+		list_add(&folio->lru, &pool_folios);
+	}
+
+	cleancache_backend_put_folios(test_data.pool_id, &pool_folios);
+
+	/* Allocate auxiliary folio for testing  */
+	test_data.aux_folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!test_data.aux_folio)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void cleancache_suite_exit(struct kunit_suite *suite)
+{
+	/* Take back donated folios and free them */
+	for (int fidx = 0; fidx < FOLIO_COUNT; fidx++) {
+		struct folio *folio = test_data.pool_folios[fidx];
+
+		if (folio) {
+			if (!cleancache_backend_get_folio(test_data.pool_id,
+							  folio))
+				set_page_refcounted(&folio->page);
+			folio_put(folio);
+		}
+	}
+
+	/* Free the auxiliary folio */
+	if (test_data.aux_folio) {
+		test_data.aux_folio->mapping = NULL;
+		folio_put(test_data.aux_folio);
+	}
+
+	/* Free inode folios */
+	for (int inode = 0; inode < INODE_COUNT; inode++) {
+		for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+			struct folio *folio = test_data.inodes[inode].folios[fidx];
+
+			if (folio) {
+				folio->mapping = NULL;
+				folio_put(folio);
+			}
+		}
+	}
+
+	cleancache_remove_fs(&test_data.sb);
+}
+
+static int cleancache_test_init(struct kunit *test)
+{
+	/* Pass pool_id to cleancache to restrict pools that can be used for tests */
+	test->priv = &test_data.pool_id;
+
+	return 0;
+}
+
+static void cleancache_restore_test(struct kunit *test)
+{
+	struct inode_data *inode_data;
+	struct folio *folio;
+
+	/* Store inode folios into cleancache */
+	fill_cleancache(test);
+
+	/* Restore and validate folios stored in cleancache */
+	for (int inode = 0; inode < INODE_COUNT; inode++) {
+		inode_data = &test_data.inodes[inode];
+		for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+			folio = inode_data->folios[fidx];
+			test_data.aux_folio->mapping = folio->mapping;
+			test_data.aux_folio->index = folio->index;
+			KUNIT_EXPECT_TRUE(test, cleancache_restore_folio(&inode_data->inode,
+									 test_data.aux_folio));
+			KUNIT_EXPECT_EQ(test, get_folio_content(test_data.aux_folio),
+					get_folio_content(folio));
+		}
+	}
+}
+
+static void cleancache_walk_and_restore_test(struct kunit *test)
+{
+	struct cleancache_inode *ccinode;
+	struct inode_data *inode_data;
+	struct folio *folio;
+
+	/* Store inode folios into cleancache */
+	fill_cleancache(test);
+
+	/* Restore and validate folios stored in the first inode */
+	inode_data = &test_data.inodes[0];
+	ccinode = cleancache_start_inode_walk(&inode_data->inode, FOLIOS_PER_INODE);
+	KUNIT_EXPECT_NOT_NULL(test, ccinode);
+	for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+		folio = inode_data->folios[fidx];
+		test_data.aux_folio->mapping = folio->mapping;
+		test_data.aux_folio->index = folio->index;
+		KUNIT_EXPECT_TRUE(test, cleancache_restore_from_inode(ccinode,
+								      test_data.aux_folio));
+		KUNIT_EXPECT_EQ(test, get_folio_content(test_data.aux_folio),
+				get_folio_content(folio));
+	}
+	cleancache_end_inode_walk(ccinode);
+}
+
+static void cleancache_invalidate_test(struct kunit *test)
+{
+	struct inode_data *inode_data;
+	struct folio *folio;
+
+	/* Store inode folios into cleancache */
+	fill_cleancache(test);
+
+	/* Invalidate one folio */
+	inode_data = &test_data.inodes[0];
+	folio = inode_data->folios[0];
+	test_data.aux_folio->mapping = folio->mapping;
+	test_data.aux_folio->index = folio->index;
+	KUNIT_EXPECT_TRUE(test, cleancache_restore_folio(&inode_data->inode,
+							 test_data.aux_folio));
+	folio_lock(folio); /* Folio has to be locked */
+	KUNIT_EXPECT_TRUE(test, cleancache_invalidate_folio(&inode_data->inode,
+							    inode_data->folios[0]));
+	folio_unlock(folio);
+	KUNIT_EXPECT_FALSE(test, cleancache_restore_folio(&inode_data->inode,
+							  test_data.aux_folio));
+
+	/* Invalidate one node */
+	inode_data = &test_data.inodes[1];
+	KUNIT_EXPECT_TRUE(test, cleancache_invalidate_inode(&inode_data->inode));
+
+	/* Verify results */
+	for (int inode = 0; inode < INODE_COUNT; inode++) {
+		inode_data = &test_data.inodes[inode];
+		for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+			folio = inode_data->folios[fidx];
+			test_data.aux_folio->mapping = folio->mapping;
+			test_data.aux_folio->index = folio->index;
+			if (inode == 0 && fidx == 0) {
+				/* Folio should be missing */
+				KUNIT_EXPECT_FALSE(test,
+					cleancache_restore_folio(&inode_data->inode,
+								 test_data.aux_folio));
+				continue;
+			}
+			if (inode == 1) {
+				/* Folios in the node should be missing */
+				KUNIT_EXPECT_FALSE(test,
+					cleancache_restore_folio(&inode_data->inode,
+								 test_data.aux_folio));
+				continue;
+			}
+			KUNIT_EXPECT_TRUE(test,
+					cleancache_restore_folio(&inode_data->inode,
+								 test_data.aux_folio));
+			KUNIT_EXPECT_EQ(test, get_folio_content(test_data.aux_folio),
+					get_folio_content(folio));
+		}
+	}
+}
+
+static void cleancache_reclaim_test(struct kunit *test)
+{
+	struct inode_data *inode_data;
+	struct inode_data *inode_new;
+	unsigned long new_index;
+	struct folio *folio;
+
+	/* Store inode folios into cleancache */
+	fill_cleancache(test);
+
+	/*
+	 * Store one extra new folio. There should be no free folios, so the
+	 * oldest folio will be reclaimed to store new folio. Add it into the
+	 * last node at the next unoccupied offset.
+	 */
+	inode_new = &test_data.inodes[INODE_COUNT - 1];
+	new_index = inode_new->folios[FOLIOS_PER_INODE - 1]->index + PAGE_SIZE;
+
+	test_data.aux_folio->mapping = &inode_new->mapping;
+	test_data.aux_folio->index = new_index;
+	set_folio_content(test_data.aux_folio, TEST_CONTENT);
+	folio_lock(test_data.aux_folio); /* Folio has to be locked */
+	folio_set_workingset(test_data.aux_folio);
+	KUNIT_EXPECT_TRUE(test, cleancache_store_folio(&inode_new->inode, test_data.aux_folio));
+	folio_unlock(test_data.aux_folio);
+
+	/* Verify results */
+	for (int inode = 0; inode < INODE_COUNT; inode++) {
+		inode_data = &test_data.inodes[inode];
+		for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+			folio = inode_data->folios[fidx];
+			test_data.aux_folio->mapping = folio->mapping;
+			test_data.aux_folio->index = folio->index;
+			/*
+			 * The first folio of the first node was added first,
+			 * so it's the oldest and must have been reclaimed.
+			 */
+			if (inode == 0 && fidx == 0) {
+				/* Reclaimed folio should be missing */
+				KUNIT_EXPECT_FALSE_MSG(test,
+						cleancache_restore_folio(&inode_data->inode,
+									 test_data.aux_folio),
+						"inode %d, folio %d is invalid\n", inode, fidx);
+				continue;
+			}
+			KUNIT_EXPECT_TRUE_MSG(test,
+					cleancache_restore_folio(&inode_data->inode,
+								 test_data.aux_folio),
+								"inode %d, folio %d is invalid\n",
+								inode, fidx);
+			KUNIT_EXPECT_EQ_MSG(test, get_folio_content(test_data.aux_folio),
+					    get_folio_content(folio),
+					    "inode %d, folio %d content is invalid\n",
+					    inode, fidx);
+		}
+	}
+
+	/* Auxiliary folio should be stored */
+	test_data.aux_folio->mapping = &inode_new->mapping;
+	test_data.aux_folio->index = new_index;
+	KUNIT_EXPECT_TRUE_MSG(test,
+			      cleancache_restore_folio(&inode_new->inode, test_data.aux_folio),
+			      "inode %lu, folio %ld is invalid\n",
+			      inode_new->inode.i_ino, new_index);
+	KUNIT_EXPECT_EQ_MSG(test, get_folio_content(test_data.aux_folio), TEST_CONTENT,
+			    "inode %lu, folio %ld content is invalid\n",
+			    inode_new->inode.i_ino, new_index);
+}
+
+static void cleancache_backend_api_test(struct kunit *test)
+{
+	struct folio *folio;
+	LIST_HEAD(folios);
+	int used = 0;
+
+	/* Store inode folios into cleancache */
+	fill_cleancache(test);
+
+	/* Get all donated folios back */
+	for (int fidx = 0; fidx < FOLIO_COUNT; fidx++) {
+		KUNIT_EXPECT_EQ(test, cleancache_backend_get_folio(test_data.pool_id,
+						test_data.pool_folios[fidx]),  0);
+		set_page_refcounted(&test_data.pool_folios[fidx]->page);
+	}
+
+	/* Try putting a refcounted folio */
+	KUNIT_EXPECT_NE(test, cleancache_backend_put_folio(test_data.pool_id,
+					test_data.pool_folios[0]), 0);
+
+	/* Put some of the folios back into cleancache */
+	for (int fidx = 0; fidx < FOLIOS_PER_INODE; fidx++) {
+		folio_ref_freeze(test_data.pool_folios[fidx], 1);
+		KUNIT_EXPECT_EQ(test, cleancache_backend_put_folio(test_data.pool_id,
+						test_data.pool_folios[fidx]), 0);
+	}
+
+	/* Put the rest back into cleancache but keep half of folios still refcounted */
+	for (int fidx = FOLIOS_PER_INODE; fidx < FOLIO_COUNT; fidx++) {
+		if (fidx % 2)
+			folio_ref_freeze(test_data.pool_folios[fidx], 1);
+		else
+			used++;
+		list_add(&test_data.pool_folios[fidx]->lru, &folios);
+	}
+	KUNIT_EXPECT_NE(test, cleancache_backend_put_folios(test_data.pool_id,
+					&folios), 0);
+	/* Used folios should be still in the list */
+	KUNIT_EXPECT_EQ(test, list_count_nodes(&folios), used);
+
+	/* Release refcounts and put the remaining folios into cleancache */
+	list_for_each_entry(folio, &folios, lru)
+		folio_ref_freeze(folio, 1);
+	KUNIT_EXPECT_EQ(test, cleancache_backend_put_folios(test_data.pool_id,
+					&folios), 0);
+	KUNIT_EXPECT_TRUE(test, list_empty(&folios));
+}
+
+static struct kunit_case cleancache_test_cases[] = {
+	KUNIT_CASE(cleancache_restore_test),
+	KUNIT_CASE(cleancache_walk_and_restore_test),
+	KUNIT_CASE(cleancache_invalidate_test),
+	KUNIT_CASE(cleancache_reclaim_test),
+	KUNIT_CASE(cleancache_backend_api_test),
+	{},
+};
+
+static struct kunit_suite hashtable_test_module = {
+	.name = "cleancache",
+	.init = cleancache_test_init,
+	.suite_init = cleancache_suite_init,
+	.suite_exit = cleancache_suite_exit,
+	.test_cases = cleancache_test_cases,
+};
+
+kunit_test_suites(&hashtable_test_module);
+
+MODULE_DESCRIPTION("KUnit test for the Kernel Cleancache");
+MODULE_LICENSE("GPL");
-- 
2.51.1.851.g4ebd6896fd-goog


