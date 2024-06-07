Return-Path: <linux-fsdevel+bounces-21195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E28900374
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C9228A3BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666CC1957F6;
	Fri,  7 Jun 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpBUm9KA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF3194A53
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763055; cv=none; b=GqrKPlz5L+rxeIDi/F1WLns04eWEf2VYVuVrOfn78T1vlPr2YAo80xLoOfJ3g1tl7yHvjxzILUiUgfj9HEhnulv++KLpWQcrKfpNSrCUGdRG1gyIMpdF8fqwZUWFlhwdNKZC5YDbgewi/POo2eVUOz7XqjnOhn/3+KYXNmvVbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763055; c=relaxed/simple;
	bh=D8neSebn0iVXy/d3rMysrVlVhegLU3wixnvVMIn532U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toaIMSRbFSyHwfl2chvbBs/2bXoIzO0rmM1LNWaJQweAio9MEQCvqe7no9XNEOr72pA28OG/Fzow08jAYZuYas0yGqwIsiNMHKP/xEb+2mdsVmlTCFWTf+Tew9x7bcr2eyK4HKHRg43H2Eh5ZDsHv3PdLwzbAAp38jYWnLrSpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpBUm9KA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeGZgl6bcZJYszXPuGofZHugwXu/JCr74XswxhNWa/0=;
	b=YpBUm9KA7Pdms+2fdRQjYlU7vdAfVC79xBFWH2VX8dJWrWROP7eanbCIs2Fw7+JALPMp42
	MzdIYNjYdGJqJb+GFkmms7vV2lXeaIWw0DO/Je45bkhL1bUKVGOWPqGXc+Unf9TSMIibMx
	9NFiZM217uHyuDbSh2tfJ/mnLItLMKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-PkT7xXgBOK2Dyd-86yhZpg-1; Fri, 07 Jun 2024 08:24:11 -0400
X-MC-Unique: PkT7xXgBOK2Dyd-86yhZpg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00F2E185A780;
	Fri,  7 Jun 2024 12:24:11 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72622492BCE;
	Fri,  7 Jun 2024 12:24:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 5/6] fs/proc: move page_mapcount() to fs/proc/internal.h
Date: Fri,  7 Jun 2024 14:23:56 +0200
Message-ID: <20240607122357.115423-6-david@redhat.com>
In-Reply-To: <20240607122357.115423-1-david@redhat.com>
References: <20240607122357.115423-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

... and rename it to folio_precise_page_mapcount(). fs/proc is the last
remaining user, and that should stay that way.

While at it, cleanup kpagecount_read() a bit: there are still some legacy
leftovers -- when the interface was introduced it returned the page
refcount, but was changed briefly afterwards to return the page
mapcount. Further, some simple folio conversion.

Once we stop using the per-page mapcounts of large folios, all
folio_precise_page_mapcount() users will have to implement an
alternative way to achieve what they are trying to achieve, possibly in
a less precise way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/internal.h | 33 +++++++++++++++++++++++++++++++++
 fs/proc/page.c     | 21 ++++++++++-----------
 fs/proc/task_mmu.c | 35 ++++++++++++++++++++++-------------
 include/linux/mm.h | 27 +--------------------------
 4 files changed, 66 insertions(+), 50 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a71ac5379584a..a8a8576d8592e 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -13,6 +13,7 @@
 #include <linux/binfmts.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
+#include <linux/mm.h>
 
 struct ctl_table_header;
 struct mempolicy;
@@ -142,6 +143,38 @@ unsigned name_to_int(const struct qstr *qstr);
 /* Worst case buffer size needed for holding an integer. */
 #define PROC_NUMBUF 13
 
+/**
+ * folio_precise_page_mapcount() - Number of mappings of this folio page.
+ * @folio: The folio.
+ * @page: The page.
+ *
+ * The number of present user page table entries that reference this page
+ * as tracked via the RMAP: either referenced directly (PTE) or as part of
+ * a larger area that covers this page (e.g., PMD).
+ *
+ * Use this function only for the calculation of existing statistics
+ * (USS, PSS, mapcount_max) and for debugging purposes (/proc/kpagecount).
+ *
+ * Do not add new users.
+ *
+ * Returns: The number of mappings of this folio page. 0 for
+ * folios that are not mapped to user space or are not tracked via the RMAP
+ * (e.g., shared zeropage).
+ */
+static inline int folio_precise_page_mapcount(struct folio *folio,
+		struct page *page)
+{
+	int mapcount = atomic_read(&page->_mapcount) + 1;
+
+	/* Handle page_has_type() pages */
+	if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
+		mapcount = 0;
+	if (folio_test_large(folio))
+		mapcount += folio_entire_mapcount(folio);
+
+	return mapcount;
+}
+
 /*
  * array.c
  */
diff --git a/fs/proc/page.c b/fs/proc/page.c
index 2fb64bdb64eb1..e8440db8cfbf9 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -37,21 +37,19 @@ static inline unsigned long get_max_dump_pfn(void)
 #endif
 }
 
-/* /proc/kpagecount - an array exposing page counts
+/* /proc/kpagecount - an array exposing page mapcounts
  *
  * Each entry is a u64 representing the corresponding
- * physical page count.
+ * physical page mapcount.
  */
 static ssize_t kpagecount_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
 	const unsigned long max_dump_pfn = get_max_dump_pfn();
 	u64 __user *out = (u64 __user *)buf;
-	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
 	ssize_t ret = 0;
-	u64 pcount;
 
 	pfn = src / KPMSIZE;
 	if (src & KPMMASK || count & KPMMASK)
@@ -61,18 +59,19 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
 
 	while (count > 0) {
+		struct page *page;
+		u64 mapcount = 0;
+
 		/*
 		 * TODO: ZONE_DEVICE support requires to identify
 		 * memmaps that were actually initialized.
 		 */
-		ppage = pfn_to_online_page(pfn);
-
-		if (!ppage)
-			pcount = 0;
-		else
-			pcount = page_mapcount(ppage);
+		page = pfn_to_online_page(pfn);
+		if (page)
+			mapcount = folio_precise_page_mapcount(page_folio(page),
+							       page);
 
-		if (put_user(pcount, out)) {
+		if (put_user(mapcount, out)) {
 			ret = -EFAULT;
 			break;
 		}
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 67d9b406c7586..631371cb80a05 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -488,12 +488,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		return;
 	}
 	/*
-	 * The page_mapcount() is called to get a snapshot of the mapcount.
-	 * Without holding the folio lock this snapshot can be slightly wrong as
-	 * we cannot always read the mapcount atomically.
+	 * We obtain a snapshot of the mapcount. Without holding the folio lock
+	 * this snapshot can be slightly wrong as we cannot always read the
+	 * mapcount atomically.
 	 */
 	for (i = 0; i < nr; i++, page++) {
-		int mapcount = page_mapcount(page);
+		int mapcount = folio_precise_page_mapcount(folio, page);
 		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
 		if (mapcount >= 2)
 			pss /= mapcount;
@@ -1424,6 +1424,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 {
 	u64 frame = 0, flags = 0;
 	struct page *page = NULL;
+	struct folio *folio;
 
 	if (pte_present(pte)) {
 		if (pm->show_pfn)
@@ -1461,10 +1462,14 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			flags |= PM_UFFD_WP;
 	}
 
-	if (page && !PageAnon(page))
-		flags |= PM_FILE;
-	if (page && (flags & PM_PRESENT) && page_mapcount(page) == 1)
-		flags |= PM_MMAP_EXCLUSIVE;
+	if (page) {
+		folio = page_folio(page);
+		if (!folio_test_anon(folio))
+			flags |= PM_FILE;
+		if ((flags & PM_PRESENT) &&
+		    folio_precise_page_mapcount(folio, page) == 1)
+			flags |= PM_MMAP_EXCLUSIVE;
+	}
 	if (vma->vm_flags & VM_SOFTDIRTY)
 		flags |= PM_SOFT_DIRTY;
 
@@ -1487,6 +1492,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		u64 flags = 0, frame = 0;
 		pmd_t pmd = *pmdp;
 		struct page *page = NULL;
+		struct folio *folio;
 
 		if (vma->vm_flags & VM_SOFTDIRTY)
 			flags |= PM_SOFT_DIRTY;
@@ -1525,15 +1531,18 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		}
 #endif
 
-		if (page && !PageAnon(page))
-			flags |= PM_FILE;
+		if (page) {
+			folio = page_folio(page);
+			if (!folio_test_anon(folio))
+				flags |= PM_FILE;
+		}
 
 		for (; addr != end; addr += PAGE_SIZE, idx++) {
 			unsigned long cur_flags = flags;
 			pagemap_entry_t pme;
 
-			if (page && (flags & PM_PRESENT) &&
-			    page_mapcount(page + idx) == 1)
+			if (folio && (flags & PM_PRESENT) &&
+			    folio_precise_page_mapcount(folio, page + idx) == 1)
 				cur_flags |= PM_MMAP_EXCLUSIVE;
 
 			pme = make_pme(frame, cur_flags);
@@ -2572,7 +2581,7 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
 	struct folio *folio = page_folio(page);
-	int count = page_mapcount(page);
+	int count = folio_precise_page_mapcount(folio, page);
 
 	md->pages += nr_pages;
 	if (pte_dirty || folio_test_dirty(folio))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 04795a5090267..42e3752b5eed5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1197,8 +1197,7 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 /*
  * How many times the entire folio is mapped as a single unit (eg by a
  * PMD or PUD entry).  This is probably not what you want, except for
- * debugging purposes - it does not include PTE-mapped sub-pages; look
- * at folio_mapcount() or page_mapcount() instead.
+ * debugging purposes or implementation of other core folio_*() primitives.
  */
 static inline int folio_entire_mapcount(const struct folio *folio)
 {
@@ -1206,30 +1205,6 @@ static inline int folio_entire_mapcount(const struct folio *folio)
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
-/**
- * page_mapcount() - Number of times this precise page is mapped.
- * @page: The page.
- *
- * The number of times this page is mapped.  If this page is part of
- * a large folio, it includes the number of times this page is mapped
- * as part of that folio.
- *
- * Will report 0 for pages which cannot be mapped into userspace, eg
- * slab, page tables and similar.
- */
-static inline int page_mapcount(struct page *page)
-{
-	int mapcount = atomic_read(&page->_mapcount) + 1;
-
-	/* Handle page_has_type() pages */
-	if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
-		mapcount = 0;
-	if (unlikely(PageCompound(page)))
-		mapcount += folio_entire_mapcount(page_folio(page));
-
-	return mapcount;
-}
-
 static inline int folio_large_mapcount(const struct folio *folio)
 {
 	VM_WARN_ON_FOLIO(!folio_test_large(folio), folio);
-- 
2.45.2


