Return-Path: <linux-fsdevel+bounces-44629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B757EA6AC33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E928D7AD4B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B562225A2C;
	Thu, 20 Mar 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFEAv2vt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB5225A3B
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492380; cv=none; b=HsBvr8V1WYxyEcToUp+BClUzfiE7UQzCDfISyiKiW+IlzG/6nk8UlgfobznZyem9Lt9jqjEjhEjuQZ4vEJWFrSFuB35Y9uGS2U5ViZYkX+H+WAmZIHyHU1CWodtnY6dz3yRQp2G+Ginrzc1/yMtOva8q/0iymIsjFIxgg1OwpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492380; c=relaxed/simple;
	bh=VwfgS6WXj1TrKYaJltsQong3sPVjoe/dIpzx4v9M28A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SVjk/PPP9/frpiCq/NMsd2xlhzJACiUXKC9NWOof+X1mRt3jIsTcW5KIbwHMHJhS5MnS5SokiY2nTGHRcZWZtFDQMo5x7Fejgs7aIKkZatyhRhKvXcmzccwVjB7FuUGPtg64UYI5np5JkibbiktzmpZY0X45Wt/en2IFEx0Iz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFEAv2vt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so1508172a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 10:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742492378; x=1743097178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=utO18jM3DqI43jAs46xftkc+iTkKZEsg2nm4Y+WIpWw=;
        b=sFEAv2vtabWpueDKVsdr75bjXXjsvAcAtM9v/U3F3876im28jARkxxefwj9YiGzyJD
         LzlenxPVBwuhFWhtAFAbJtGjYUwFIwsLgmf69LVEpfjJwQCCKmortyC62kJSVvE1Vr5B
         8+XwGm4l/K7OYTbNra5MNvpiJBfbKQu8EnHknI34gaoYWZdmlqF+kF5DPJDSmHJXLbWe
         Kk/tDI4Y0CaKIlsX6+C6hoYTQ8KhfkpCXtxLS5XgVoUNpe9u5SFiehOQ3wqwtLAyTcU+
         uGl1MFLWuCwXroCcz9ecmTN7mGD0c+DW+gAOp5dPvK1Mk1iYniQuQjfJt8IltmQXWBy0
         DkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492378; x=1743097178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utO18jM3DqI43jAs46xftkc+iTkKZEsg2nm4Y+WIpWw=;
        b=FvDdNFS84mH5ydMOUzwuuJnvJDc1ZpRLj8AJfgsi0bN5SJkUwnbupav6ISb5+YMWUQ
         UTQJ8ebr8Xr36vCKPhmxb/ebGuvvV7Lhvbtf6GT+1VAphUQCQw1ei0nXgwnFHbWaH0Vh
         w7mHpOApXK0ac/l0nvXLZKRCFE7e2MFBXHJZVZ/lVQDr7mukBojz7YmnZuG0npWMLFmm
         SOsx3O7Nx9CsZJVIlK66pbzO6DLzGk2odqC+1vJxr3zK6EIjEJGMgFkKqsmL18wJqth7
         7qTjrStI6u1e2Fw4WOxcP9d2AtCXsxGd3csTu940LCqvgUvqvaH4Gk2kn35452c+62uI
         gJhw==
X-Forwarded-Encrypted: i=1; AJvYcCWeJfyRdIQL5vKtLvy5X+4Rea6DTR00H86rqayqHsUBGzGtS6yYY1PdDsRZq5XZKUiwO8CJopAhHa+8QVBB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx19B85iDY+0d76an0e1NXgKDQDsmskK+RoRfDHlsJ5Kww7Yx6k
	P65vSXpmtXVOWSYwzszl4w+hu5Looa/vQmb4+pxqsuq2gk2lqRLlBcxJ1Worj/e2nUjwKPHNV8F
	DAA==
X-Google-Smtp-Source: AGHT+IGjhRps2uk6ZFQZIC7R3fpxDHdrRFbLqUZ0BLeU3xJE1wYlTDOJepff3lsj9OvAu2ohK9dAI+Xpphc=
X-Received: from pjf11.prod.google.com ([2002:a17:90b:3f0b:b0:2fa:1803:2f9f])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2743:b0:2ff:5a9d:9390
 with SMTP id 98e67ed59e1d1-3030fe779bbmr123144a91.8.1742492378297; Thu, 20
 Mar 2025 10:39:38 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:39:30 -0700
In-Reply-To: <20250320173931.1583800-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320173931.1583800-1-surenb@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320173931.1583800-3-surenb@google.com>
Subject: [RFC 2/3] mm: introduce GCMA
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@redhat.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, alexandru.elisei@arm.com, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, mina86@mina86.com, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
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
 include/linux/gcma.h |  12 ++++
 mm/Kconfig           |  15 +++++
 mm/Makefile          |   1 +
 mm/gcma.c            | 155 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/gcma.c

diff --git a/include/linux/gcma.h b/include/linux/gcma.h
new file mode 100644
index 000000000000..2ce40fcc74a5
--- /dev/null
+++ b/include/linux/gcma.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __GCMA_H__
+#define __GCMA_H__
+
+#include <linux/types.h>
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count);
+void gcma_alloc_range(unsigned long start_pfn, unsigned long count);
+void gcma_free_range(unsigned long start_pfn, unsigned long count);
+
+#endif /* __GCMA_H__ */
diff --git a/mm/Kconfig b/mm/Kconfig
index d6ebf0fb0432..85268ef901b6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1002,6 +1002,21 @@ config CMA_AREAS
 
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
 config MEM_SOFT_DIRTY
 	bool "Track memory changes"
 	depends on CHECKPOINT_RESTORE && HAVE_ARCH_SOFT_DIRTY && PROC_FS
diff --git a/mm/Makefile b/mm/Makefile
index 084dbe9edbc4..2173d395d371 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -149,3 +149,4 @@ obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
 obj-$(CONFIG_CLEANCACHE) += cleancache.o
+obj-$(CONFIG_GCMA)	+= gcma.o
diff --git a/mm/gcma.c b/mm/gcma.c
new file mode 100644
index 000000000000..263e63da0c89
--- /dev/null
+++ b/mm/gcma.c
@@ -0,0 +1,155 @@
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
+
+#define MAX_GCMA_AREAS		64
+#define GCMA_AREA_NAME_MAX_LEN	32
+
+struct gcma_area {
+	int area_id;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	char name[GCMA_AREA_NAME_MAX_LEN];
+};
+
+static struct gcma_area areas[MAX_GCMA_AREAS];
+static atomic_t nr_gcma_area = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(gcma_area_lock);
+
+static void alloc_page_range(struct gcma_area *area,
+			     unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long scanned = 0;
+	unsigned long pfn;
+	struct page *page;
+	int err;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		page = pfn_to_page(pfn);
+		err = cleancache_backend_get_folio(area->area_id, page_folio(page));
+		VM_BUG_ON(err);
+	}
+}
+
+static void free_page_range(struct gcma_area *area,
+			    unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long scanned = 0;
+	unsigned long pfn;
+	struct page *page;
+	int err;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		if (!(++scanned % XA_CHECK_SCHED))
+			cond_resched();
+
+		page = pfn_to_page(pfn);
+		err = cleancache_backend_put_folio(area->area_id,
+						   page_folio(page));
+		VM_BUG_ON(err);
+	}
+}
+
+int gcma_register_area(const char *name,
+		       unsigned long start_pfn, unsigned long count)
+{
+	LIST_HEAD(folios);
+	int i, area_id;
+	int nr_area;
+	int ret = 0;
+
+	for (i = 0; i < count; i++) {
+		struct folio *folio;
+
+		folio = page_folio(pfn_to_page(start_pfn + i));
+		list_add(&folio->lru, &folios);
+	}
+
+	area_id = cleancache_register_backend(name, &folios);
+	if (area_id < 0)
+		return area_id;
+
+	spin_lock(&gcma_area_lock);
+
+	nr_area = atomic_read(&nr_gcma_area);
+	if (nr_area < MAX_GCMA_AREAS) {
+		struct gcma_area *area = &areas[nr_area];
+
+		area->area_id = area_id;
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
+void gcma_alloc_range(unsigned long start_pfn, unsigned long count)
+{
+	int nr_area = atomic_read_acquire(&nr_gcma_area);
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	int i;
+
+	for (i = 0; i < nr_area; i++) {
+		unsigned long s_pfn, e_pfn;
+
+		area = &areas[i];
+		if (area->end_pfn <= start_pfn)
+			continue;
+
+		if (area->start_pfn > end_pfn)
+			continue;
+
+		s_pfn = max(start_pfn, area->start_pfn);
+		e_pfn = min(end_pfn, area->end_pfn);
+		alloc_page_range(area, s_pfn, e_pfn);
+	}
+}
+EXPORT_SYMBOL_GPL(gcma_alloc_range);
+
+void gcma_free_range(unsigned long start_pfn, unsigned long count)
+{
+	int nr_area = atomic_read_acquire(&nr_gcma_area);
+	unsigned long end_pfn = start_pfn + count;
+	struct gcma_area *area;
+	int i;
+
+	for (i = 0; i < nr_area; i++) {
+		unsigned long s_pfn, e_pfn;
+
+		area = &areas[i];
+		if (area->end_pfn <= start_pfn)
+			continue;
+
+		if (area->start_pfn > end_pfn)
+			continue;
+
+		s_pfn = max(start_pfn, area->start_pfn);
+		e_pfn = min(end_pfn, area->end_pfn);
+		free_page_range(area, s_pfn, e_pfn);
+	}
+}
+EXPORT_SYMBOL_GPL(gcma_free_range);
-- 
2.49.0.rc1.451.g8f38331e32-goog


