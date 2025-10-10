Return-Path: <linux-fsdevel+bounces-63709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364C4BCB599
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D093401009
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A326B75F;
	Fri, 10 Oct 2025 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awxNyvXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07534BA58
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059214; cv=none; b=ZuWtLwR4vkwEiOHsWwyUniMkYVp4Bf6Sfhrh+fcbt6+HUBrNu0MQ8tKmVdkizPQH2sM9R/mYkzF0i79yM/y4UFmQ/L4ONGPchzbRp5OyIZledG3Q3QIWaHZxvjXH6cK5+S/eNGVwkBZ1GNkvjKleWnZnbXVpO8ijsfvTa0Xz4LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059214; c=relaxed/simple;
	bh=2Kc+vG/8MkGEpxWJcD4ifjS1MgE6MwSmoOS8ymE7jeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fY3FGfceuFH6QHplVbKf4eCtb+pXT5VS+5Ze2NOStntBYhRjNyuDtFIqpmCgUJ9aeAXBtSu23BC1GXc3yr9En5s+r88cTJW/RpwcTcxSDWb6ht0AbLjdgqXwEhUvTacrQKXcOeokwgp/6uJiyqrTXjUaN6xn5nE6JnAaVxQoJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awxNyvXl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6fbaso35616955ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 18:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059211; x=1760664011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMspCuJAq7oIjVtiLnvMgH+BOK3foud4K2myRpZR2Ss=;
        b=awxNyvXl+ijY1RCQm6mHIVE9wySJvO1dlrvcLl5Dr/5nLnFp6vlL3axKr5CueA8QMF
         0gg+kYcu7g0EGpQ7tf1nw3I54Cjv19bfKGMNlRNwckqZmZOPvc98pbmojy3ipEsVurJ4
         gE1VfpgHvjZtBQ5z7fiS9aXVCZM/rxYG/LJeMcrZzmMd5boTIxofnqfNb8PVWvGRP69U
         gYIAySDSsHF+oyXAMjmJ3nT7uU3vzzR6AgtCZSJAwxP43kyzL4AfVDn3HQHuKXSgau5C
         tYoUDatBLySucc8JuX0w/LOp24jhO/Xc5+zklAPfAwUGtj26+I9Ofcn/Xzu2QbRaDKDD
         ZFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059211; x=1760664011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMspCuJAq7oIjVtiLnvMgH+BOK3foud4K2myRpZR2Ss=;
        b=YS/Vrq4OD06jPapQcGxAZZO2hsQl2PlgXgxzMRls6UWvw/4DNRvvBZzuUEOcTES7AG
         pZ/Buega23vYbdWrGHJmOcvj6PRSflmnwrC9G2YRIuatICI3k9A0valWpja3kO6R9oFC
         m1Z3SfHj3e9KIWsB01DyrtCiHs+YnEf87RP7rTc6OAj7nXfBxDsFWIm/Gtmhp/RamEuE
         gq/1ZvXqh93LQv0/k0h04jBPVJ76AxrivYi1pAz9fkP4nS9+unULxYeZES4OewNm02SZ
         CRhetCIh3+5twp9caO8MaSNckKCQ3/HUKPgt8hWx1/Wz8Lzg5Jf5ordtD3Rc+aPRMuAQ
         MZbg==
X-Forwarded-Encrypted: i=1; AJvYcCVk+/JfKvczfqi3zU5QzFq5CCfH/MX/prnPjCOe0xr2IfZ1Qz5kfz0SS4Yi/WxMNpPsyIgkAgxt/nKyKEgY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40q8MdK/yVXuJvx/pIsEvCrHUOPrbAlN7Fdm1pgUmheZ9KXMQ
	jnjofvMQrfPmNlIwZNdiBP+YFZv6TBdXiS+yI6k8zdpXyHLSKz7cCxtJUOuwS4g58cMRkGu8DcM
	fVB9rwA==
X-Google-Smtp-Source: AGHT+IEWKkEivo5xkxXtogAKm07PhNF4ozYnoXCJEzQk/zOL2Y/TNZ+SlYrB9tiZy0+b63lcurI0GuhAwZk=
X-Received: from plas15.prod.google.com ([2002:a17:903:200f:b0:25f:48ba:97e1])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2d0:b0:25e:78db:4a0d
 with SMTP id d9443c01a7336-290273eddd5mr117013065ad.36.1760059211496; Thu, 09
 Oct 2025 18:20:11 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:50 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-8-surenb@google.com>
Subject: [PATCH 7/8] mm: introduce GCMA
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
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Minchan Kim <minchan@google.com>

This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
cleacache backend which reserves some amount of memory at the boot
and then donates it to store clean file-backed pages in the cleancache.
GCMA aims to guarantee contiguous memory allocation success as well as
low and deterministic allocation latency.

Notes:
Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
Later Minchan reworked it to be used in Android as a reference for
Android vendors to use [2].

[1] https://lwn.net/Articles/619865/
[2] https://android-review.googlesource.com/q/topic:%22gcma_6.12%22

Signed-off-by: Minchan Kim <minchan@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 MAINTAINERS          |   2 +
 include/linux/gcma.h |  36 +++++++
 mm/Kconfig           |  15 +++
 mm/Makefile          |   1 +
 mm/gcma.c            | 231 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 285 insertions(+)
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/gcma.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 441e68c94177..95b5ad26ec11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16361,6 +16361,7 @@ F:	Documentation/admin-guide/mm/
 F:	Documentation/mm/
 F:	include/linux/cma.h
 F:	include/linux/dmapool.h
+F:	include/linux/gcma.h
 F:	include/linux/ioremap.h
 F:	include/linux/memory-tiers.h
 F:	include/linux/page_idle.h
@@ -16372,6 +16373,7 @@ F:	mm/dmapool.c
 F:	mm/dmapool_test.c
 F:	mm/early_ioremap.c
 F:	mm/fadvise.c
+F:	mm/gcma.c
 F:	mm/ioremap.c
 F:	mm/mapping_dirty_helpers.c
 F:	mm/memory-tiers.c
diff --git a/include/linux/gcma.h b/include/linux/gcma.h
new file mode 100644
index 000000000000..20b2c85de87b
--- /dev/null
+++ b/include/linux/gcma.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GCMA_H__
+#define __GCMA_H__
+
+#include <linux/types.h>
+
+#ifdef CONFIG_GCMA
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count);
+
+/*
+ * NOTE: allocated pages are still marked reserved and when freeing them
+ * the caller should ensure they are isolated and not referenced by anyone
+ * other than the caller.
+ */
+int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp_t gfp);
+int gcma_free_range(unsigned long start_pfn, unsigned long count);
+
+#else /* CONFIG_GCMA */
+
+static inline int gcma_register_area(const char *name,
+				     unsigned long start_pfn,
+				     unsigned long count)
+		{ return -EOPNOTSUPP; }
+static inline int gcma_alloc_range(unsigned long start_pfn,
+				   unsigned long count, gfp_t gfp)
+		{ return -EOPNOTSUPP; }
+
+static inline int gcma_free_range(unsigned long start_pfn,
+				   unsigned long count)
+		{ return -EOPNOTSUPP; }
+
+#endif /* CONFIG_GCMA */
+
+#endif /* __GCMA_H__ */
diff --git a/mm/Kconfig b/mm/Kconfig
index 9f4da8a848f4..41ce5ef8db55 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1013,6 +1013,21 @@ config CMA_AREAS
 
 	  If unsure, leave the default value "8" in UMA and "20" in NUMA.
 
+config GCMA
+       bool "GCMA (Guaranteed Contiguous Memory Allocator)"
+       depends on CLEANCACHE
+	help
+	  This enables the Guaranteed Contiguous Memory Allocator to allow
+	  low latency guaranteed contiguous memory allocations. Memory
+	  reserved by GCMA is donated to cleancache to be used as pagecache
+	  extension. Once GCMA allocation is requested, necessary pages are
+	  taken back from the cleancache and used to satisfy the request.
+	  Cleancache guarantees low latency successful allocation as long
+	  as the total size of GCMA allocations does not exceed the size of
+	  the memory donated to the cleancache.
+
+	  If unsure, say "N".
+
 #
 # Select this config option from the architecture Kconfig, if available, to set
 # the max page order for physically contiguous allocations.
diff --git a/mm/Makefile b/mm/Makefile
index 845841a140e3..05aee66a8b07 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -149,3 +149,4 @@ obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
 obj-$(CONFIG_CLEANCACHE_SYSFS)	+= cleancache_sysfs.o
+obj-$(CONFIG_GCMA)	+= gcma.o
diff --git a/mm/gcma.c b/mm/gcma.c
new file mode 100644
index 000000000000..3ee0e1340db3
--- /dev/null
+++ b/mm/gcma.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GCMA (Guaranteed Contiguous Memory Allocator)
+ *
+ */
+
+#define pr_fmt(fmt) "gcma: " fmt
+
+#include <linux/cleancache.h>
+#include <linux/gcma.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/xarray.h>
+#include "internal.h"
+
+#define MAX_GCMA_AREAS		64
+#define GCMA_AREA_NAME_MAX_LEN	32
+
+struct gcma_area {
+	int pool_id;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	char name[GCMA_AREA_NAME_MAX_LEN];
+};
+
+static struct gcma_area areas[MAX_GCMA_AREAS];
+static atomic_t nr_gcma_area = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(gcma_area_lock);
+
+static int free_folio_range(struct gcma_area *area,
+			     unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long scanned = 0;
+	struct folio *folio;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		int err;
+
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		folio = pfn_folio(pfn);
+		err = cleancache_backend_put_folio(area->pool_id, folio);
+		if (WARN(err, "PFN %lu: folio is still in use\n", pfn))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int alloc_folio_range(struct gcma_area *area,
+			      unsigned long start_pfn, unsigned long end_pfn,
+			      gfp_t gfp)
+{
+	unsigned long scanned = 0;
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		int err;
+
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		err = cleancache_backend_get_folio(area->pool_id, pfn_folio(pfn));
+		if (err) {
+			free_folio_range(area, start_pfn, pfn);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static struct gcma_area *find_area(unsigned long start_pfn, unsigned long end_pfn)
+{
+	int nr_area = atomic_read_acquire(&nr_gcma_area);
+	int i;
+
+	for (i = 0; i < nr_area; i++) {
+		struct gcma_area *area = &areas[i];
+
+		if (area->end_pfn <= start_pfn)
+			continue;
+
+		if (area->start_pfn > end_pfn)
+			continue;
+
+		/* The entire range should belong to a single area */
+		if (start_pfn < area->start_pfn || end_pfn > area->end_pfn)
+			break;
+
+		/* Found the area containing the entire range */
+		return area;
+	}
+
+	return NULL;
+}
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count)
+{
+	LIST_HEAD(folios);
+	int i, pool_id;
+	int nr_area;
+	int ret = 0;
+
+	pool_id = cleancache_backend_register_pool(name);
+	if (pool_id < 0)
+		return pool_id;
+
+	for (i = 0; i < count; i++) {
+		struct folio *folio;
+
+		folio = pfn_folio(start_pfn + i);
+		folio_clear_reserved(folio);
+		folio_set_count(folio, 0);
+		list_add(&folio->lru, &folios);
+	}
+
+	cleancache_backend_put_folios(pool_id, &folios);
+
+	spin_lock(&gcma_area_lock);
+
+	nr_area = atomic_read(&nr_gcma_area);
+	if (nr_area < MAX_GCMA_AREAS) {
+		struct gcma_area *area = &areas[nr_area];
+
+		area->pool_id = pool_id;
+		area->start_pfn = start_pfn;
+		area->end_pfn = start_pfn + count;
+		strscpy(area->name, name);
+		/* Ensure above stores complete before we increase the count */
+		atomic_set_release(&nr_gcma_area, nr_area + 1);
+	} else {
+		ret = -ENOMEM;
+	}
+
+	spin_unlock(&gcma_area_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gcma_register_area);
+
+int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp_t gfp)
+{
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	struct folio *folio;
+	int err, order = 0;
+
+	gfp = current_gfp_context(gfp);
+	if (gfp & __GFP_COMP) {
+		if (!is_power_of_2(count))
+			return -EINVAL;
+
+		order = ilog2(count);
+		if (order >= MAX_PAGE_ORDER)
+			return -EINVAL;
+	}
+
+	area = find_area(start_pfn, end_pfn);
+	if (!area)
+		return -EINVAL;
+
+	err = alloc_folio_range(area, start_pfn, end_pfn, gfp);
+	if (err)
+		return err;
+
+	/*
+	 * GCMA returns pages with refcount 1 and expects them to have
+	 * the same refcount 1 when they are freed.
+	 */
+	if (order) {
+		folio = pfn_folio(start_pfn);
+		set_page_count(&folio->page, 1);
+		prep_compound_page(&folio->page, order);
+	} else {
+		for (unsigned long pfn = start_pfn; pfn < end_pfn; pfn++) {
+			folio = pfn_folio(pfn);
+			set_page_count(&folio->page, 1);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gcma_alloc_range);
+
+int gcma_free_range(unsigned long start_pfn, unsigned long count)
+{
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	struct folio *folio;
+
+	area = find_area(start_pfn, end_pfn);
+	if (!area)
+		return -EINVAL;
+
+	folio = pfn_folio(start_pfn);
+	if (folio_test_large(folio)) {
+		int expected = folio_nr_pages(folio);
+
+		if (WARN(count != expected, "PFN %lu: count %lu != expected %d\n",
+			  start_pfn, count, expected))
+			return -EINVAL;
+
+		if (WARN(!folio_ref_dec_and_test(folio),
+			 "PFN %lu: invalid folio refcount when freeing\n", start_pfn))
+			return -EINVAL;
+
+		free_pages_prepare(&folio->page, folio_order(folio));
+	} else {
+		for (unsigned long pfn = start_pfn; pfn < end_pfn; pfn++) {
+			folio = pfn_folio(pfn);
+			if (folio_nr_pages(folio) == 1)
+				count--;
+
+			if (WARN(!folio_ref_dec_and_test(folio),
+				 "PFN %lu: invalid folio refcount when freeing\n", pfn))
+				return -EINVAL;
+
+			free_pages_prepare(&folio->page, 0);
+		}
+		WARN(count != 0, "%lu pages are still in use!\n", count);
+	}
+
+	return free_folio_range(area, start_pfn, end_pfn);
+}
+EXPORT_SYMBOL_GPL(gcma_free_range);
-- 
2.51.0.740.g6adb054d12-goog


