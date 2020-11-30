Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D4A2C87AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgK3PU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgK3PU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:20:59 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CD6C061A4C
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b10so9196866pfo.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vdDREmbmInhjdApsMpNN6yHRVfI2DjGpJbOKZ/lZXg=;
        b=epMoITOmeG5CH4Z4wxEHfhRF2KZrYA9MSwC3V6MgUXw+B8xY/YltjyTJcp49naqMrE
         KVAwnA8qhKlxpEk0Z1Y5/egH56S6DgbvxhPWRwt0fsKxYBu6mVnkDsR+wlPiKN+b8QCk
         fUS20mBdGOOmsa7CrGlkUH6DvGJqey5m15PcbXjPH3uKxuDHHwYCXeDJmprURRHpB7SX
         Bq0e8OOM64KBCXvZXNmy0qckm3ao/2r+rBk9V493coS58NmdxmlWGrOK0uxGN9+sRteo
         X5eF34RkZwL6ddMpLuUYviRqgGUXGGVSL1YKYUq4mYGbWLQKssPMhtM6ljNljcl5wUTe
         WsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vdDREmbmInhjdApsMpNN6yHRVfI2DjGpJbOKZ/lZXg=;
        b=ufR0jOMTfq1SOORRFOZdVE15T3IwZuWPzUaj6xUnjaZVxIziiYSE47qaiAxBm+6exn
         q6enMObX+mkKT2Hy71nPNM7WyAuR9mddltkL/FRcrC1AU+v+aC3Wz8jduD8KuWtkd2uI
         MhJezR1g/wupIalC61M/BmYMeN/zDDWj0F44vrGYG5m8QtVswh4rMbk0QTO7A9z8RPdK
         gx7ig5H9XLpuEleRlOAogjbVnNkGpqFN/VkGvK6T/5HPsV1A4moEmcAdYIin4jwxZeoJ
         3v5mxioIHbor8MwAaMMRuZbEEPDVF+9GpQenglC7pYcf399Ih4Ei1YuBzjwFr6U4/Lvp
         geUw==
X-Gm-Message-State: AOAM533f4op33j2n8j3LfP9YYSHl5m+paLWAWm/TFD/Kt7t5RKC4DqZU
        xydRfRlLG/iTcfDqmpmO6X18Hw==
X-Google-Smtp-Source: ABdhPJy8wd6DEoTVKlaxsLRoxXEZiFbmiJmb9K9qEfnalXvr859l2pIATie6wECmyool3BTsBkzlkw==
X-Received: by 2002:a62:75c6:0:b029:18a:d510:ff60 with SMTP id q189-20020a6275c60000b029018ad510ff60mr18879498pfc.35.1606749602318;
        Mon, 30 Nov 2020 07:20:02 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.19.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:20:01 -0800 (PST)
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
Subject: [PATCH v7 04/15] mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
Date:   Mon, 30 Nov 2020 23:18:27 +0800
Message-Id: <20201130151838.11208-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c    | 129 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    |  20 ++++++++
 5 files changed, 156 insertions(+)
 create mode 100644 mm/hugetlb_vmemmap.c
 create mode 100644 mm/hugetlb_vmemmap.h

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..4efeccb7192c 100644
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
index 1f3bf1710b66..25f9e8e9fc4a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -42,6 +42,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/page_owner.h>
 #include "internal.h"
+#include "hugetlb_vmemmap.h"
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
@@ -3206,6 +3207,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
+	hugetlb_vmemmap_init(h);
+
 	parsed_hstate = h;
 }
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
new file mode 100644
index 000000000000..51152e258f39
--- /dev/null
+++ b/mm/hugetlb_vmemmap.c
@@ -0,0 +1,129 @@
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
+ */
+#define pr_fmt(fmt)	"HugeTLB vmemmap: " fmt
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
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * system, the others page will map to the first tail page. So there
+	 * are the remaining pages that can be freed.
+	 *
+	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
+	 * on some architectures (e.g. aarch64). See Documentation/arm64/
+	 * hugetlbpage.rst for more details.
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

