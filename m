Return-Path: <linux-fsdevel+bounces-63707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3333BCB578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 577214ED8BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5325C6EE;
	Fri, 10 Oct 2025 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ft0cEvhy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29F22D9ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059210; cv=none; b=m1o4wyakMckKt95dx68ysh7aK6pCchTZWU5hUo6g97hToNmA8J1hVRsYC8C4tXVJPrPJeWYGMOnYHa5SoG2Fc3iI6Kcso7Me54gEnUpi9uvRQMkgfdiC8nxqAWFFnK6EFTNfCmx7+vA47Nivp4y2CWEiGHoe5HsymWXFlZUV1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059210; c=relaxed/simple;
	bh=VRxXrZZF2VXTYZ8iIq1VsjEC5bkGWZOb9Rg6YcJl7ZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q1tbDcw3sRLqxHSvhCV6Lfh6jZfC1sK/of1BKNdGu9/pqEa4pMpQutDdAeiNmMXE6t5N2aBQ5Of4lhwy4ShFDj5ZoEH02fu64HBsT/l/aQ17ikrkGyCpNVRyE6meEnCfvQKcHciOhGJELPnCUncOFctQqKxRh3zN7mc0OaWiV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ft0cEvhy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e538b5f23so29626605ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059207; x=1760664007; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEIUd4ZHclhGCkol/EpGDU6dqFXNl4VLKrOL2ZuQAlU=;
        b=Ft0cEvhyhiTFZ2+PEFVmDwsHgKsVMYkRlLvN7WXeiLeq65/qRMVuUjlvJrAEnikO47
         jL/3z5jMuWFUDs7ofHI/bRyXhG4bzecMTsjErODXVAe1lagfZG2YJTip6vJgcQ/QMyZi
         1+ACipDWfzEBiGEzmnIFGpP6YdqP1/YFv2Y+L9cH/1dLUGDQ6sTe7cB22Rj6FnLnbGLm
         Mvo5HcpXPMMdSHzinBFlZSmmJnaLPx9SZSuD+8coIasAd1reKQPjGwk20fb3tOhKj66b
         KC79fhbCkog2YUh+x4UVydMK8EHjEu2JN+2Ao7DsyDj2DgDhFcnTgKjSpTJ4GU1PiZmj
         GlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059207; x=1760664007;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEIUd4ZHclhGCkol/EpGDU6dqFXNl4VLKrOL2ZuQAlU=;
        b=RcBeAwg4VmAr/+U3Q/sTr6p2I6Ifj87hah4ixqLOo1p+IXgh1p/d9NRpRk+fABnTlI
         ZqSdSJfDRw0Bh+v/SDOlcwXhGwUZLzM5iiIflC7F7f37kWHQDHuqcoJshOfgVi5ROziV
         yLJPDcUPJJ3MJWS8PrSTPaKkpQozLNjIBKFkOQjADZ8kYbgq5cr1IBOiE5vHKGhnyfq8
         1lCUTYsEBfihoI1DvR4Mh5G8oiG1NQ4tNNMWGbTa73GVk0EKmM12xhHzBgq+BNvtrKj+
         XTV77xqjLNjgejBm5lOG1WPSjLgBrk99hlFFog2LXRFract6nsrJqbv8Hh8I3Xk/saGR
         sUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGV2wxsbMV7n9uVMoc/TVTZqU+y3Yyl6JHUt/3lLwpD5tbg/i72+Bc/4STv3XFq7EUt/ju94rHC2jMxAX8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WcyFMvPeuHbQW/H7W9rBSjCtce77X/CFPGrDbt2V5tu+54Cb
	n6xFI45UbCoN7Cj02VT6bLwzRyYdkWSQAz72upSmumcBb2baP9zY8f2IGc6sZ/8r9CNrN0eY8qf
	9D0fSdw==
X-Google-Smtp-Source: AGHT+IHEfcZb//+A/XoFxHeEt6Ogc1LHbtC/aY5NYrm9NviJtA9b0iGFosX3+0YfoF7OGZYkFgLjPVJGLKw=
X-Received: from plps24.prod.google.com ([2002:a17:902:9898:b0:267:de1d:2687])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e943:b0:264:f714:8dce
 with SMTP id d9443c01a7336-290272c2542mr118120205ad.36.1760059207349; Thu, 09
 Oct 2025 18:20:07 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:48 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-6-surenb@google.com>
Subject: [PATCH 5/8] mm/tests: add cleancache kunit test
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
 mm/tests/cleancache_kunit.c | 425 ++++++++++++++++++++++++++++++++++++
 6 files changed, 480 insertions(+), 1 deletion(-)
 create mode 100644 mm/tests/Makefile
 create mode 100644 mm/tests/cleancache_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f66307cd9c4b..1c97227e7ffa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6057,6 +6057,7 @@ F:	include/linux/cleancache.h
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
index 56dce7e03709..fd18486b0407 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -11,6 +11,8 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/xarray.h>
+#include <kunit/test-bug.h>
+#include <kunit/test.h>
 
 #include "cleancache_sysfs.h"
 
@@ -74,6 +76,28 @@ static DEFINE_SPINLOCK(pools_lock); /* protects pools */
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
 /*
  * Folio attributes:
  *	folio->_mapcount - pool_id
@@ -184,7 +208,7 @@ static struct folio *pick_folio_from_any_pool(void)
 	for (int i = 0; i < count; i++) {
 		pool = &pools[i];
 		spin_lock(&pool->lock);
-		if (!list_empty(&pool->folio_list)) {
+		if (!list_empty(&pool->folio_list) && is_pool_allowed(i)) {
 			folio = list_last_entry(&pool->folio_list,
 						struct folio, lru);
 			WARN_ON(!remove_folio_from_pool(folio, pool));
@@ -747,6 +771,7 @@ void cleancache_add_fs(struct super_block *sb)
 err:
 	sb->cleancache_id = CLEANCACHE_ID_INVALID;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_add_fs);
 
 void cleancache_remove_fs(struct super_block *sb)
 {
@@ -766,6 +791,7 @@ void cleancache_remove_fs(struct super_block *sb)
 	/* free the object */
 	put_fs(fs);
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_remove_fs);
 
 bool cleancache_store_folio(struct inode *inode, struct folio *folio)
 {
@@ -795,6 +821,7 @@ bool cleancache_store_folio(struct inode *inode, struct folio *folio)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_store_folio);
 
 bool cleancache_restore_folio(struct inode *inode, struct folio *folio)
 {
@@ -822,6 +849,7 @@ bool cleancache_restore_folio(struct inode *inode, struct folio *folio)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_restore_folio);
 
 bool cleancache_invalidate_folio(struct address_space *mapping,
 				 struct inode *inode, struct folio *folio)
@@ -853,6 +881,7 @@ bool cleancache_invalidate_folio(struct address_space *mapping,
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_invalidate_folio);
 
 bool cleancache_invalidate_inode(struct address_space *mapping,
 				 struct inode *inode)
@@ -877,6 +906,7 @@ bool cleancache_invalidate_inode(struct address_space *mapping,
 
 	return count > 0;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_invalidate_inode);
 
 struct cleancache_inode *
 cleancache_start_inode_walk(struct address_space *mapping, struct inode *inode,
@@ -906,6 +936,7 @@ cleancache_start_inode_walk(struct address_space *mapping, struct inode *inode,
 
 	return ccinode;
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_start_inode_walk);
 
 void cleancache_end_inode_walk(struct cleancache_inode *ccinode)
 {
@@ -914,6 +945,7 @@ void cleancache_end_inode_walk(struct cleancache_inode *ccinode)
 	put_inode(ccinode);
 	put_fs(fs);
 }
+EXPORT_SYMBOL_FOR_KUNIT(cleancache_end_inode_walk);
 
 bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
 				   struct folio *folio)
@@ -940,6 +972,7 @@ bool cleancache_restore_from_inode(struct cleancache_inode *ccinode,
 
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
index 000000000000..18b4386d6322
--- /dev/null
+++ b/mm/tests/cleancache_kunit.c
@@ -0,0 +1,425 @@
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
+	ccinode = cleancache_start_inode_walk(&inode_data->mapping, &inode_data->inode,
+					      FOLIOS_PER_INODE);
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
+	KUNIT_EXPECT_TRUE(test, cleancache_invalidate_folio(&inode_data->mapping,
+							    &inode_data->inode,
+							    inode_data->folios[0]));
+	folio_unlock(folio);
+	KUNIT_EXPECT_FALSE(test, cleancache_restore_folio(&inode_data->inode,
+							  test_data.aux_folio));
+
+	/* Invalidate one node */
+	inode_data = &test_data.inodes[1];
+	KUNIT_EXPECT_TRUE(test, cleancache_invalidate_inode(&inode_data->mapping,
+							    &inode_data->inode));
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
+	int unused = 0;
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
+		if (fidx % 2) {
+			folio_ref_freeze(test_data.pool_folios[fidx], 1);
+			unused++;
+		} else {
+			used++;
+		}
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
2.51.0.740.g6adb054d12-goog


