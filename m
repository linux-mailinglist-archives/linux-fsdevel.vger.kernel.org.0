Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5F32D528E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 05:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbgLJEGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 23:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbgLJD66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:58:58 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE00C0611CB
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 19:58:05 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id r4so2090783pls.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 19:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUlcbnGtbE7EttBC0VM6GF2IqhVd2JwZTJqGGAZ8Gg8=;
        b=qpudnCc751/6vrl93oH5mbjFU2XOJYRR1/do4by2wvNYw0drkdVvn4nB4R0fQoTcMI
         LiG4Cf8bObokfCogsIt1a8dMiCPzX+uhPdrf7BjIysXZ4OmSo1KYtF311YSYolLIHKSK
         C5crJNIKBx7g/CGAYQ6FgMeoGQvZ5yMz36Me6m/O1MgAXfjV2SZwVsTjC6h8pvKgkdoQ
         0899Ry9b9ZNXPhJqXREwg2MhCKukj29kcasV+vGMCNuS0VfAGcvC8Y2+ZvZh9NXYRvlB
         K1yxv0BFJ5ZwujVIcNbJul+u/UswJpJ9OAByD24X5gOAL2bmhDYEk1BErJNogvK3E79v
         vUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUlcbnGtbE7EttBC0VM6GF2IqhVd2JwZTJqGGAZ8Gg8=;
        b=Ngka/R4Y/Mx2UbQz/Z/2MNhCXbZD1Qyjkx/Jc+rxFS0t8CRvOqsYL2tIXBosWOF5za
         sfn4C3WJCyKO70ggCGiOTXoZNHy2PQrLSA/Ai1P5QG5qJjpsKhbOr5LAw0HIZJW9pxjw
         t8EtlzczPDauuzBMNfp7lUxeJs6L1ncaAJzpWa3NUGyC/+etDGyHFO30xoBRHsHrLmTk
         tIHiiDm88eFJCg0f7+deqBTkmZ1DylLrz93jdYtUbjvPQRoU87RUVdTznQNRs0w8G/vF
         cqrz5uFdq5dIF305qI5JjgLpmau1ns480quL26QELlv3WvYFyqMbYIT6nvooe85rOJQn
         56Vw==
X-Gm-Message-State: AOAM533HPUQXuQkiiJVBjowTbQh5cweRm2RaepNZ60qAPpUcxkoKVVTk
        4dw5NYleiUriuWCBTxS+VfuTQQ==
X-Google-Smtp-Source: ABdhPJz+sauo3bcNru2lrjBi8cFw3a26HycChM9ENwcDekytvbCF7loe1G9O/V+5DwOEqfkfV1Oxxw==
X-Received: by 2002:a17:902:d351:b029:db:d63d:d0e with SMTP id l17-20020a170902d351b02900dbd63d0d0emr3018628plk.75.1607572685064;
        Wed, 09 Dec 2020 19:58:05 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.57.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:58:04 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 04/12] mm/hugetlb: Free the vmemmap pages associated with each HugeTLB page
Date:   Thu, 10 Dec 2020 11:55:18 +0800
Message-Id: <20201210035526.38938-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Every HugeTLB has more than one struct page structure. We __know__ that
we only use the first 4(HUGETLB_CGROUP_MIN_ORDER) struct page structures
to store metadata associated with each HugeTLB.

There are a lot of struct page structures associated with each HugeTLB
page. For tail pages, the value of compound_head is the same. So we can
reuse first page of tail page structures. We map the virtual addresses
of the remaining pages of tail page structures to the first tail page
struct, and then free these page frames. Therefore, we need to reserve
two pages as vmemmap areas.

When we allocate a HugeTLB page from the buddy, we can free some vmemmap
pages associated with each HugeTLB page. It is more appropriate to do it
in the prep_new_huge_page().

The free_vmemmap_pages_per_hpage() which indicate that how many vmemmap
pages associated with a HugeTLB page that can be freed to the buddy
allocator just returns zero now, because all infrastructure is not
ready. Once all the infrastructure is ready, we will rework this
function to support the feature.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/Makefile          |   1 +
 mm/hugetlb.c         |   3 +
 mm/hugetlb_vmemmap.c | 340 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h |  20 +++
 4 files changed, 364 insertions(+)
 create mode 100644 mm/hugetlb_vmemmap.c
 create mode 100644 mm/hugetlb_vmemmap.h

diff --git a/mm/Makefile b/mm/Makefile
index ed4b88fa0f5e..056801d8daae 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_FRONTSWAP)	+= frontswap.o
 obj-$(CONFIG_ZSWAP)	+= zswap.o
 obj-$(CONFIG_HAS_DMA)	+= dmapool.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
+obj-$(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)	+= hugetlb_vmemmap.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
 obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f3bf1710b66..140135fc8113 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -42,6 +42,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
 #include "internal.h"
+#include "hugetlb_vmemmap.h"
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -1497,6 +1498,8 @@ void free_huge_page(struct page *page)
 
 static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 {
+	free_huge_page_vmemmap(h, page);
+
 	INIT_LIST_HEAD(&page->lru);
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	set_hugetlb_cgroup(page, NULL);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
new file mode 100644
index 000000000000..c464c5db8967
--- /dev/null
+++ b/mm/hugetlb_vmemmap.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free some vmemmap pages of HugeTLB
+ *
+ * Copyright (c) 2020, Bytedance. All rights reserved.
+ *
+ *     Author: Muchun Song <songmuchun@bytedance.com>
+ *
+ * The struct page structures (page structs) are used to describe a physical
+ * page frame. By default, there is a one-to-one mapping from a page frame to
+ * it's corresponding page struct.
+ *
+ * The HugeTLB pages consist of multiple base page size pages and is supported
+ * by many architectures. See hugetlbpage.rst in the Documentation directory
+ * for more details. On the x86-64 architecture, HugeTLB pages of size 2MB and
+ * 1GB are currently supported. Since the base page size on x86 is 4KB, a 2MB
+ * HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
+ * 4096 base pages. For each base page, there is a corresponding page struct.
+ *
+ * Within the HugeTLB subsystem, only the first 4 page structs are used to
+ * contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
+ * provides this upper limit. The only 'useful' information in the remaining
+ * page structs is the compound_head field, and this field is the same for all
+ * tail pages.
+ *
+ * By removing redundant page structs for HugeTLB pages, memory can returned to
+ * the buddy allocator for other uses.
+ *
+ * Different architectures support different HugeTLB pages. For example, the
+ * following table is the HugeTLB page size supported by x86 and arm64
+ * architectures. Becasue arm64 supports 4k, 16k, and 64k base pages and
+ * supports contiguous entries, so it supports many kinds of sizes of HugeTLB
+ * page.
+ *
+ * +--------------+-----------+-----------------------------------------------+
+ * | Architecture | Page Size |                HugeTLB Page Size              |
+ * +--------------+-----------+-----------+-----------+-----------+-----------+
+ * |    x86-64    |    4KB    |    2MB    |    1GB    |           |           |
+ * +--------------+-----------+-----------+-----------+-----------+-----------+
+ * |              |    4KB    |   64KB    |    2MB    |    32MB   |    1GB    |
+ * |              +-----------+-----------+-----------+-----------+-----------+
+ * |    arm64     |   16KB    |    2MB    |   32MB    |     1GB   |           |
+ * |              +-----------+-----------+-----------+-----------+-----------+
+ * |              |   64KB    |    2MB    |  512MB    |    16GB   |           |
+ * +--------------+-----------+-----------+-----------+-----------+-----------+
+ *
+ * When the system boot up, every HugeTLB page has more than one struct page
+ * structs whose size is (unit: pages):
+ *
+ *    struct_size = HugeTLB_Size / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
+ *
+ * Where HugeTLB_Size is the size of the HugeTLB page. We know that the size
+ * of the HugeTLB page is always n times PAGE_SIZE. So we can get the following
+ * relationship.
+ *
+ *    HugeTLB_Size = n * PAGE_SIZE
+ *
+ * Then,
+ *
+ *    struct_size = n * PAGE_SIZE / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
+ *                = n * sizeof(struct page) / PAGE_SIZE
+ *
+ * We can use huge mapping at the pud/pmd level for the HugeTLB page.
+ *
+ * For the pmd level mapping of the HugeTLB page, then
+ *
+ *    struct_size = n * sizeof(struct page) / PAGE_SIZE
+ *                = PAGE_SIZE / sizeof(pte_t) * sizeof(struct page) / PAGE_SIZE
+ *                = sizeof(struct page) / sizeof(pte_t)
+ *                = 64 / 8
+ *                = 8 (pages)
+ *
+ * Where n is how many pte entries which one page can contains. So the value of
+ * n is (PAGE_SIZE / sizeof(pte_t)).
+ *
+ * This optimization only supports 64-bit system, so the value of sizeof(pte_t)
+ * is 8. And this optimization also applicable only when the size of struct page
+ * is a power of two. In most cases, the size of struct page is 64 (e.g. x86-64
+ * and arm64). So if we use pmd level mapping for a HugeTLB page, the size of
+ * struct page structs of it is 8 pages whose size depends on the size of the
+ * base page.
+ *
+ * For the pud level mapping of the HugeTLB page, then
+ *
+ *    struct_size = PAGE_SIZE / sizeof(pmd_t) * struct_size(pmd)
+ *                = PAGE_SIZE / 8 * 8 (pages)
+ *                = PAGE_SIZE (pages)
+ *
+ * Where the struct_size(pmd) is the size of the struct page structs of a pmd
+ * level mapping of the HugeTLB page.
+ *
+ * Next, we take the pmd level mapping of the HugeTLB page as an example to
+ * show the internal implementation of this optimization. There are 8 pages
+ * struct page structs associated with a HugeTLB page which is pmd mapped.
+ *
+ * Here is how things look before optimization.
+ *
+ *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
+ * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
+ * |           |                     |     0     | -------------> |     0     |
+ * |           |                     +-----------+                +-----------+
+ * |           |                     |     1     | -------------> |     1     |
+ * |           |                     +-----------+                +-----------+
+ * |           |                     |     2     | -------------> |     2     |
+ * |           |                     +-----------+                +-----------+
+ * |           |                     |     3     | -------------> |     3     |
+ * |           |                     +-----------+                +-----------+
+ * |           |                     |     4     | -------------> |     4     |
+ * |    PMD    |                     +-----------+                +-----------+
+ * |   level   |                     |     5     | -------------> |     5     |
+ * |  mapping  |                     +-----------+                +-----------+
+ * |           |                     |     6     | -------------> |     6     |
+ * |           |                     +-----------+                +-----------+
+ * |           |                     |     7     | -------------> |     7     |
+ * |           |                     +-----------+                +-----------+
+ * |           |
+ * |           |
+ * |           |
+ * +-----------+
+ *
+ * The value of page->compound_head is the same for all tail pages. The first
+ * page of page structs (page 0) associated with the HugeTLB page contains the 4
+ * page structs necessary to describe the HugeTLB. The only use of the remaining
+ * pages of page structs (page 1 to page 7) is to point to page->compound_head.
+ * Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
+ * will be used for each HugeTLB page. This will allow us to free the remaining
+ * 6 pages to the buddy allocator.
+ *
+ * Here is how things look after remapping.
+ *
+ *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
+ * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
+ * |           |                     |     0     | -------------> |     0     |
+ * |           |                     +-----------+                +-----------+
+ * |           |                     |     1     | -------------> |     1     |
+ * |           |                     +-----------+                +-----------+
+ * |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
+ * |           |                     +-----------+                   | | | | |
+ * |           |                     |     3     | ------------------+ | | | |
+ * |           |                     +-----------+                     | | | |
+ * |           |                     |     4     | --------------------+ | | |
+ * |    PMD    |                     +-----------+                       | | |
+ * |   level   |                     |     5     | ----------------------+ | |
+ * |  mapping  |                     +-----------+                         | |
+ * |           |                     |     6     | ------------------------+ |
+ * |           |                     +-----------+                           |
+ * |           |                     |     7     | --------------------------+
+ * |           |                     +-----------+
+ * |           |
+ * |           |
+ * |           |
+ * +-----------+
+ *
+ * When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
+ * vmemmap pages and restore the previous mapping relationship.
+ *
+ * For the pud level mapping of the HugeTLB page. It is similar to the former.
+ * We also can use this approach to free (PAGE_SIZE - 2) vmemmap pages.
+ *
+ * Apart from the pmd/pud level mapping of the HugeTLB page, some architectures
+ * (e.g. aarch64) provides a contiguous bit in the translation table entries
+ * that hints to the MMU to indicate that it is one of a contiguous set of
+ * entries that can be cached in a single TLB entry.
+ *
+ * The contiguous bit is used to increase the mapping size at the pmd and pte
+ * (last) level. So this type of HugeTLB page can be optimized only when its
+ * size of the struct page structs is greater than 2 pages.
+ */
+#define pr_fmt(fmt)	"HugeTLB vmemmap: " fmt
+
+#include <linux/bootmem_info.h>
+#include "hugetlb_vmemmap.h"
+
+/*
+ * There are a lot of struct page structures associated with each HugeTLB page.
+ * For tail pages, the value of compound_head is the same. So we can reuse first
+ * page of tail page structures. We map the virtual addresses of the remaining
+ * pages of tail page structures to the first tail page struct, and then free
+ * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
+ */
+#define RESERVE_VMEMMAP_NR		2U
+#define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
+#define VMEMMAP_TAIL_PAGE_REUSE		-1
+
+#ifndef VMEMMAP_HPAGE_SHIFT
+#define VMEMMAP_HPAGE_SHIFT		HPAGE_SHIFT
+#endif
+#define VMEMMAP_HPAGE_ORDER		(VMEMMAP_HPAGE_SHIFT - PAGE_SHIFT)
+#define VMEMMAP_HPAGE_NR		(1 << VMEMMAP_HPAGE_ORDER)
+#define VMEMMAP_HPAGE_SIZE		(1UL << VMEMMAP_HPAGE_SHIFT)
+#define VMEMMAP_HPAGE_MASK		(~(VMEMMAP_HPAGE_SIZE - 1))
+
+#define vmemmap_hpage_addr_end(addr, end)				 \
+({									 \
+	unsigned long __boundary;					 \
+	__boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK; \
+	(__boundary - 1 < (end) - 1) ? __boundary : (end);		 \
+})
+
+/*
+ * How many vmemmap pages associated with a HugeTLB page that can be freed
+ * to the buddy allocator.
+ *
+ * Todo: Now it is zero, because all infrastructure is not ready. Once all the
+ * infrastructure is ready, we will rework this function to support the feature.
+ */
+static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return 0;
+}
+
+static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
+}
+
+static inline unsigned long vmemmap_pages_size_per_hpage(struct hstate *h)
+{
+	return (unsigned long)vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
+}
+
+/*
+ * Walk a vmemmap address to the pmd it maps.
+ */
+static pmd_t *vmemmap_to_pmd(unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return NULL;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return NULL;
+
+	return pmd;
+}
+
+static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
+				    unsigned long start, unsigned long end,
+				    struct list_head *vmemmap_pages)
+{
+	/*
+	 * Make the tail pages are mapped with read-only to catch
+	 * illegal write operation to the tail pages.
+	 */
+	pgprot_t pgprot = PAGE_KERNEL_RO;
+	pte_t entry = mk_pte(reuse, pgprot);
+	unsigned long addr;
+
+	for (addr = start; addr < end; addr += PAGE_SIZE, pte++) {
+		struct page *page;
+
+		VM_BUG_ON(pte_none(*pte));
+
+		page = pte_page(*pte);
+		list_add(&page->lru, vmemmap_pages);
+
+		set_pte_at(&init_mm, addr, pte, entry);
+	}
+}
+
+static void vmemmap_remap_range(unsigned long start, unsigned long end,
+				struct list_head *vmemmap_pages)
+{
+	pmd_t *pmd;
+	unsigned long next, addr = start;
+	struct page *reuse = NULL;
+
+	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
+	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON((start >> PUD_SHIFT) != (end >> PUD_SHIFT));
+
+	pmd = vmemmap_to_pmd(addr);
+	BUG_ON(!pmd);
+
+	do {
+		pte_t *pte = pte_offset_kernel(pmd, addr);
+
+		if (!reuse)
+			reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
+
+		next = vmemmap_hpage_addr_end(addr, end);
+		vmemmap_reuse_pte_range(reuse, pte, addr, next, vmemmap_pages);
+	} while (pmd++, addr = next, addr != end);
+
+	flush_tlb_kernel_range(start, end);
+}
+
+/*
+ * Free a vmemmap page. A vmemmap page can be allocated from the memblock
+ * allocator or buddy allocator. If the PG_reserved flag is set, it means
+ * that it allocated from the memblock allocator, just free it via the
+ * free_bootmem_page(). Otherwise, use __free_page().
+ */
+static inline void free_vmemmap_page(struct page *page)
+{
+	if (PageReserved(page))
+		free_bootmem_page(page);
+	else
+		__free_page(page);
+}
+
+static inline void free_vmemmap_page_list(struct list_head *list)
+{
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, list, lru) {
+		list_del(&page->lru);
+		free_vmemmap_page(page);
+	}
+}
+
+void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+	unsigned long start, end;
+	unsigned long vmemmap_addr = (unsigned long)head;
+	LIST_HEAD(vmemmap_pages);
+
+	if (!free_vmemmap_pages_per_hpage(h))
+		return;
+
+	start = vmemmap_addr + RESERVE_VMEMMAP_SIZE;
+	end = vmemmap_addr + vmemmap_pages_size_per_hpage(h);
+	vmemmap_remap_range(start, end, &vmemmap_pages);
+
+	free_vmemmap_page_list(&vmemmap_pages);
+}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
new file mode 100644
index 000000000000..6923f03534d5
--- /dev/null
+++ b/mm/hugetlb_vmemmap.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Free some vmemmap pages of HugeTLB
+ *
+ * Copyright (c) 2020, Bytedance. All rights reserved.
+ *
+ *     Author: Muchun Song <songmuchun@bytedance.com>
+ */
+#ifndef _LINUX_HUGETLB_VMEMMAP_H
+#define _LINUX_HUGETLB_VMEMMAP_H
+#include <linux/hugetlb.h>
+
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+#else
+static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
+{
+}
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+#endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

