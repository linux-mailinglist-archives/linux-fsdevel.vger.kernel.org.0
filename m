Return-Path: <linux-fsdevel+bounces-8951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B7083C878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5263296301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD21386C5;
	Thu, 25 Jan 2024 16:43:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08BD131E2B;
	Thu, 25 Jan 2024 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201016; cv=none; b=WQOp7qVAkXPU0nYPnKB2xChC/qBjUXz4mYhqxPhrWoq7JukhX9Aa/bmuV9TuOJ3hZzGl7/7l8rnP8OExevurMj0+4/pfGGXTCDj6O5JJRZ4UJ4CFzxrQOKmHWZXg/rpVMWydG5VV4lMPGi+gP4FtalrmuDyNM354s9cPlk+iRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201016; c=relaxed/simple;
	bh=xx28PConicQPxXYQSYkxUqN0YBKscjpZEHw3dfmUj4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nsnf2rj6FWLvPUVB+LQ2zbHDHVUZe8xwRVIgfWrEdmhh0KsX/cMnfYWD3lvHbbYmjqmKENOSE9VI5OzG4UuhxBQzolDH/SC0MkSBXYC/cRpsrnJ91SEvkTqmehx/nGE27fVARrMXYSMdNjg3YJIvGNtI4zIVWXmeOIlzbgL8GB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E191516;
	Thu, 25 Jan 2024 08:44:17 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41E03F5A1;
	Thu, 25 Jan 2024 08:43:27 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 08/35] mm: cma: Introduce cma_alloc_range()
Date: Thu, 25 Jan 2024 16:42:29 +0000
Message-Id: <20240125164256.4147-9-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today, cma_alloc() is used to allocate a contiguous memory region. The
function allows the caller to specify the number of pages to allocate, but
not the starting address. cma_alloc() will walk over the entire CMA region
trying to allocate the first available range of the specified size.

Introduce cma_alloc_range(), which makes CMA more versatile by allowing the
caller to specify a particular range in the CMA region, defined by the
start pfn and the size.

arm64 will make use of this function when tag storage management will be
implemented: cma_alloc_range() will be used to reserve the tag storage
associated with a tagged page.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch.

 include/linux/cma.h        |  2 +
 include/trace/events/cma.h | 59 ++++++++++++++++++++++++++
 mm/cma.c                   | 86 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 63873b93deaa..e32559da6942 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -50,6 +50,8 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
+extern int cma_alloc_range(struct cma *cma, unsigned long start, unsigned long count,
+			   unsigned tries, gfp_t gfp);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
 extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
 
diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
index 25103e67737c..a89af313a572 100644
--- a/include/trace/events/cma.h
+++ b/include/trace/events/cma.h
@@ -36,6 +36,65 @@ TRACE_EVENT(cma_release,
 		  __entry->count)
 );
 
+TRACE_EVENT(cma_alloc_range_start,
+
+	TP_PROTO(const char *name, unsigned long start, unsigned long count,
+		 unsigned tries),
+
+	TP_ARGS(name, start, count, tries),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(unsigned long, start)
+		__field(unsigned long, count)
+		__field(unsigned, tries)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->start = start;
+		__entry->count = count;
+		__entry->tries = tries;
+	),
+
+	TP_printk("name=%s start=%lx count=%lu tries=%u",
+		  __get_str(name),
+		  __entry->start,
+		  __entry->count,
+		  __entry->tries)
+);
+
+TRACE_EVENT(cma_alloc_range_finish,
+
+	TP_PROTO(const char *name, unsigned long start, unsigned long count,
+		 unsigned attempts, int err),
+
+	TP_ARGS(name, start, count, attempts, err),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(unsigned long, start)
+		__field(unsigned long, count)
+		__field(unsigned, attempts)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->start = start;
+		__entry->count = count;
+		__entry->attempts = attempts;
+		__entry->err = err;
+	),
+
+	TP_printk("name=%s start=%lx count=%lu attempts=%u err=%d",
+		  __get_str(name),
+		  __entry->start,
+		  __entry->count,
+		  __entry->attempts,
+		  __entry->err)
+);
+
 TRACE_EVENT(cma_alloc_start,
 
 	TP_PROTO(const char *name, unsigned long count, unsigned int align),
diff --git a/mm/cma.c b/mm/cma.c
index 543bb6b3be8e..4a0f68b9443b 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -416,6 +416,92 @@ static void cma_debug_show_areas(struct cma *cma)
 static inline void cma_debug_show_areas(struct cma *cma) { }
 #endif
 
+/**
+ * cma_alloc_range() - allocate pages in a specific range
+ * @cma:   Contiguous memory region for which the allocation is performed.
+ * @start: Starting pfn of the allocation.
+ * @count: Requested number of pages
+ * @tries: Number of tries if the range is busy
+ * @no_warn: Avoid printing message about failed allocation
+ *
+ * This function allocates part of contiguous memory from a specific contiguous
+ * memory area, from the specified starting address. The 'start' pfn and the the
+ * 'count' number of pages must be aligned to the CMA bitmap order per bit.
+ */
+int cma_alloc_range(struct cma *cma, unsigned long start, unsigned long count,
+		    unsigned tries, gfp_t gfp)
+{
+	unsigned long bitmap_maxno, bitmap_no, bitmap_start, bitmap_count;
+	unsigned long i = 0;
+	struct page *page;
+	int err = -EINVAL;
+
+	if (!cma || !cma->count || !cma->bitmap)
+		goto out_stats;
+
+	trace_cma_alloc_range_start(cma->name, start, count, tries);
+
+	if (!count || start < cma->base_pfn ||
+	    start + count > cma->base_pfn + cma->count)
+		goto out_stats;
+
+	if (!IS_ALIGNED(start | count, 1 << cma->order_per_bit))
+		goto out_stats;
+
+	bitmap_start = (start - cma->base_pfn) >> cma->order_per_bit;
+	bitmap_maxno = cma_bitmap_maxno(cma);
+	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
+
+	spin_lock_irq(&cma->lock);
+	bitmap_no = bitmap_find_next_zero_area(cma->bitmap, bitmap_maxno,
+					       bitmap_start, bitmap_count, 0);
+	if (bitmap_no != bitmap_start) {
+		spin_unlock_irq(&cma->lock);
+		err = -EEXIST;
+		goto out_stats;
+	}
+	bitmap_set(cma->bitmap, bitmap_start, bitmap_count);
+	spin_unlock_irq(&cma->lock);
+
+	for (i = 0; i < tries; i++) {
+		mutex_lock(&cma_mutex);
+		err = alloc_contig_range(start, start + count, MIGRATE_CMA, gfp);
+		mutex_unlock(&cma_mutex);
+
+		if (err != -EBUSY)
+			break;
+	}
+
+	if (err) {
+		cma_clear_bitmap(cma, start, count);
+	} else {
+		page = pfn_to_page(start);
+
+		/*
+		 * CMA can allocate multiple page blocks, which results in
+		 * different blocks being marked with different tags. Reset the
+		 * tags to ignore those page blocks.
+		 */
+		for (i = 0; i < count; i++)
+			page_kasan_tag_reset(nth_page(page, i));
+	}
+
+out_stats:
+	trace_cma_alloc_range_finish(cma->name, start, count, i, err);
+
+	if (err) {
+		count_vm_events(CMA_ALLOC_FAIL, count);
+		if (cma)
+			cma_sysfs_account_fail_pages(cma, count);
+	} else {
+		count_vm_events(CMA_ALLOC_SUCCESS, count);
+		cma_sysfs_account_success_pages(cma, count);
+	}
+
+	return err;
+}
+
+
 /**
  * cma_alloc() - allocate pages from contiguous area
  * @cma:   Contiguous memory region for which the allocation is performed.
-- 
2.43.0


