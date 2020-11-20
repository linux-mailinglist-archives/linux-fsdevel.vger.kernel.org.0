Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259592BA278
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKTGqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgKTGqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:46:48 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B02C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v21so6502348pgi.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRfIaKfSk4gw/H9VYs5z/FHDAf2tShQGD8WKzq8TDA8=;
        b=EBLSrBH7YeOd2gjIHGCeLdFlu9RrgT3qC1HA+1fPvgY+Q4xicVAgK/OeJsWKFWkYhl
         qwOQlkBpFp7Dfni0pBAXrx3dhG/9qZmVx3gOAtQcrSnpdJKAWBKyITosLbsYRV3fPfUK
         apXco7AuKdfkyRhgx1BrWO3c9YTkeTlGJ+Y4ZfEl9QdxQ4csoXUbWKF/RUMmtOtLgH8q
         4iLcypWcOd+b4+CZjYPeYTDz9hyMCqGjCTrrOtNG157N5kH17iS0S/oT8yDy0HhTasNH
         gLu4dyls4iUupLwNABjxSZMiDCVnF20ibjdo07/vhFpK4UrmmT0NsiRsx6UQPq3SLn5n
         Miiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRfIaKfSk4gw/H9VYs5z/FHDAf2tShQGD8WKzq8TDA8=;
        b=G+iWXD616nI58inYzIigNi6btPMuTQzptFj3+PW6VugsAeqaXKqxDF6V31Vt23ITbA
         h0qWbzz5aeVQDmyJKi0WQE8UgANWRibO0rr0f36dvneKDJo4KDzlXpPQB2f1YIWKlqbQ
         ftYTPYcWpFo8icgvkaPpWSWYYTEMGxJIBjeu9f8FfWlgHoauAdJ0rhqCTufvWUrHSAbB
         9ppLKyXdmgTd9loFCm5xjKqs1GoSCudWMCd4O8H37WbtpNuwydSHetkKJSUlBBQ2cUuS
         s37erxV1/8M3Zjk3p7i20R/3jIVuoHepDyeH0HsmcapdpEIUIVpBCPiHnjWjaPiCFw+Y
         UA1g==
X-Gm-Message-State: AOAM530sbYQc5A0RCJyOZWzCwvdCIsvXkSRjjwUu+KphKORg6ueEa/T5
        HTUDws5NruWwaeLz3VnM1X+eig==
X-Google-Smtp-Source: ABdhPJxQ8aHtUvLLx7J9LD29ryu8DiJo4QeNBWYWaHjPcLOfy1mi3QvFyj2UQ+zvYgJo7e2EUavhVA==
X-Received: by 2002:a62:7e81:0:b029:197:c3e2:4ad9 with SMTP id z123-20020a627e810000b0290197c3e24ad9mr5062995pfc.35.1605854808233;
        Thu, 19 Nov 2020 22:46:48 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.46.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:46:47 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 04/21] mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
Date:   Fri, 20 Nov 2020 14:43:08 +0800
Message-Id: <20201120064325.34492-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Every HugeTLB has more than one struct page structure. The 2M HugeTLB
has 512 struct page structure and 1G HugeTLB has 4096 struct page
structures. We __know__ that we only use the first 4(HUGETLB_CGROUP_MIN_ORDER)
struct page structures to store metadata associated with each HugeTLB.

There are a lot of struct page structures(8 page frames for 2MB HugeTLB
page and 4096 page frames for 1GB HugeTLB page) associated with each
HugeTLB page. For tail pages, the value of compound_head is the same.
So we can reuse first page of tail page structures. We map the virtual
addresses of the remaining pages of tail page structures to the first
tail page struct, and then free these page frames. Therefore, we need
to reserve two pages as vmemmap areas.

So we introduce a new nr_free_vmemmap_pages field in the hstate to
indicate how many vmemmap pages associated with a HugeTLB page that we
can free to buddy system.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |   3 ++
 mm/Makefile             |   1 +
 mm/hugetlb.c            |   3 ++
 mm/hugetlb_vmemmap.c    | 134 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    |  20 ++++++++
 5 files changed, 161 insertions(+)
 create mode 100644 mm/hugetlb_vmemmap.c
 create mode 100644 mm/hugetlb_vmemmap.h

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d5cc5f802dd4..eed3dd3bd626 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -492,6 +492,9 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	unsigned int nr_free_vmemmap_pages;
+#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/Makefile b/mm/Makefile
index 752111587c99..2a734576bbc0 100644
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
index 81a41aa080a5..f88032c24667 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -42,6 +42,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
 #include "internal.h"
+#include "hugetlb_vmemmap.h"
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -3285,6 +3286,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
+	hugetlb_vmemmap_init(h);
+
 	parsed_hstate = h;
 }
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
new file mode 100644
index 000000000000..1afe245395e5
--- /dev/null
+++ b/mm/hugetlb_vmemmap.c
@@ -0,0 +1,134 @@
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
+ * for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
+ * are currently supported. Since the base page size on x86 is 4KB, a 2MB
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
+ * When the system boot up, every 2M HugeTLB has 512 struct page structs which
+ * size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
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
+ * |    2MB    |                     +-----------+                +-----------+
+ * |           |                     |     5     | -------------> |     5     |
+ * |           |                     +-----------+                +-----------+
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
+ * |    2MB    |                     +-----------+                       | | |
+ * |           |                     |     5     | ----------------------+ | |
+ * |           |                     +-----------+                         | |
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
+ * Apart from 2MB HugeTLB page, we also have 1GB HugeTLB page. It is similar
+ * to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
+ * pages.
+ *
+ * In this case, for the 1GB HugeTLB page, we can save 4088 pages(There are
+ * 4096 pages for struct page structs, we reserve 2 pages for vmemmap and 8
+ * pages for page tables. So we can save 4088 pages). This is a very substantial
+ * gain.
+ */
+#define pr_fmt(fmt)	"HugeTLB Vmemmap: " fmt
+
+#include "hugetlb_vmemmap.h"
+
+/*
+ * There are a lot of struct page structures(8 page frames for 2MB HugeTLB page
+ * and 4096 page frames for 1GB HugeTLB page) associated with each HugeTLB page.
+ * For tail pages, the value of compound_head is the same. So we can reuse first
+ * page of tail page structures. We map the virtual addresses of the remaining
+ * pages of tail page structures to the first tail page struct, and then free
+ * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
+ */
+#define RESERVE_VMEMMAP_NR		2U
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int order = huge_page_order(h);
+	unsigned int vmemmap_pages;
+
+	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * system, the others page will map to the first tail page. So there
+	 * are the remaining pages that can be freed.
+	 *
+	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? This is
+	 * not expected to happen unless the system is corrupted. So on the
+	 * safe side, it is only a safety net.
+	 */
+	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+
+	pr_debug("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
+		 h->name);
+}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
new file mode 100644
index 000000000000..40c0c7dfb60d
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
+void __init hugetlb_vmemmap_init(struct hstate *h);
+#else
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
+#endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

