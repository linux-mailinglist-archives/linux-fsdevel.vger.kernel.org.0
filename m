Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C672C2230
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 10:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgKXJ4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbgKXJ4x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:56:53 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954E3C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:56:52 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t8so17979952pfg.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2Lt/HFpEA/hqI+q/d/AJuv9tCMbUi3JtA5McU8GXbw=;
        b=SD+KS5uvf85wZygHvM6VuOj/q9MWvEqgHDaOhJAxS/fuRX0jUABkCNlNI3uoVyFoQA
         ezFZkS+/O6sABeHcUQJZW7vg/nMTPM5/FZmbKRzAnNAq3bPiatsRZCx1/g/SKd9EFJka
         qizjYvyk5jbw7z5kdlrk267neQpt+XgJuR1ID69zMYxq3eijYm3k6rqWcfZ1cKzHSQLr
         uHY3d6GeiQ6LMQ0M31Pihl3znzF6kbj+2nnSaseMJyPN3AeaKXICcQThr+2f5l+eXnw9
         L5CSK4/voD2+CCKcePXOwFcgnW7tFe9ZCZJWOwCYsKx1nulH34SKUoi8+2yMgRUX7BNa
         vogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2Lt/HFpEA/hqI+q/d/AJuv9tCMbUi3JtA5McU8GXbw=;
        b=STkxpp0A7AFcs+fYrSMv3yoFs9XIDgr3c+4ydgHsfkg3SStLKyE4kEHEIS0ImmLkex
         1lO6v7dB+E+wcdm7greGI3zWHcT2FXQ6Bgjy4GuFK0TLQaq/2rNwTQjI8bAjIN/7a7YJ
         TcOjMuq++/YN+dMm6hRsfk3JCY8Qpx6rmbVACepvfDyYGN0cLL8sGmzbe4CN2R3eWuhK
         Nwd8Xlhi6htaZxBqhwRmWmpg6APMGatw1NeoQbnKN6v5GtasSU3q7h9H3au4/oAwZ0SW
         xw/uh4tiH1J46m5i1Nks6B33n5YEBXddrfCdSwgGqrU4+7Z/bzMi2TkDxxnRH5/zSLD3
         RJ3Q==
X-Gm-Message-State: AOAM531Rc73ScrKKthu5O//wHilz4lW/VUo3AV7iUnnhK+25LE+yNFin
        ofvZqJeqJPtFiQ44anXE2rwVgg==
X-Google-Smtp-Source: ABdhPJzp/9DPSL6qdSc4EfvMRU4B+3Up+ULDVqhx32Clvk+mqXOtMo2HlqmFg7ndm2X8taRYCkmmVQ==
X-Received: by 2002:a65:684f:: with SMTP id q15mr3070892pgt.125.1606211812062;
        Tue, 24 Nov 2020 01:56:52 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.56.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:56:51 -0800 (PST)
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
Subject: [PATCH v6 01/16] mm/memory_hotplug: Move bootmem info registration API to bootmem_info.c
Date:   Tue, 24 Nov 2020 17:52:44 +0800
Message-Id: <20201124095259.58755-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move bootmem info registration common API to individual bootmem_info.c
for later patch use. This is just code movement without any functional
change.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/mm/init_64.c          |  1 +
 include/linux/bootmem_info.h   | 27 ++++++++++++
 include/linux/memory_hotplug.h | 23 ----------
 mm/Makefile                    |  1 +
 mm/bootmem_info.c              | 99 ++++++++++++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c            | 91 +-------------------------------------
 6 files changed, 129 insertions(+), 113 deletions(-)
 create mode 100644 include/linux/bootmem_info.h
 create mode 100644 mm/bootmem_info.c

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4033d3..c7f7ad55b625 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/bootmem_info.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
new file mode 100644
index 000000000000..65bb9b23140f
--- /dev/null
+++ b/include/linux/bootmem_info.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_BOOTMEM_INFO_H
+#define __LINUX_BOOTMEM_INFO_H
+
+#include <linux/mmzone.h>
+
+/*
+ * Types for free bootmem stored in page->lru.next. These have to be in
+ * some random range in unsigned long space for debugging purposes.
+ */
+enum {
+	MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE = 12,
+	SECTION_INFO = MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE,
+	MIX_SECTION_INFO,
+	NODE_INFO,
+	MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE = NODE_INFO,
+};
+
+#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
+void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
+#else
+static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
+{
+}
+#endif
+
+#endif /* __LINUX_BOOTMEM_INFO_H */
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 51a877fec8da..19e5d067294c 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -33,18 +33,6 @@ struct vmem_altmap;
 	___page;						   \
 })
 
-/*
- * Types for free bootmem stored in page->lru.next. These have to be in
- * some random range in unsigned long space for debugging purposes.
- */
-enum {
-	MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE = 12,
-	SECTION_INFO = MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE,
-	MIX_SECTION_INFO,
-	NODE_INFO,
-	MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE = NODE_INFO,
-};
-
 /* Types for control the zone type of onlined and offlined memory */
 enum {
 	/* Offline the memory. */
@@ -209,13 +197,6 @@ static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-extern void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
-#else
-static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-}
-#endif
 extern void put_page_bootmem(struct page *page);
 extern void get_page_bootmem(unsigned long ingo, struct page *page,
 			     unsigned long type);
@@ -254,10 +235,6 @@ static inline int mhp_notimplemented(const char *func)
 	return -ENOSYS;
 }
 
-static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-}
-
 static inline int try_online_node(int nid)
 {
 	return 0;
diff --git a/mm/Makefile b/mm/Makefile
index d5649f1c12c0..752111587c99 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_FAILSLAB) += failslab.o
+obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
new file mode 100644
index 000000000000..39fa8fc120bc
--- /dev/null
+++ b/mm/bootmem_info.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/mm/bootmem_info.c
+ *
+ *  Copyright (C)
+ */
+#include <linux/mm.h>
+#include <linux/compiler.h>
+#include <linux/memblock.h>
+#include <linux/bootmem_info.h>
+#include <linux/memory_hotplug.h>
+
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
+static void register_page_bootmem_info_section(unsigned long start_pfn)
+{
+	unsigned long mapsize, section_nr, i;
+	struct mem_section *ms;
+	struct page *page, *memmap;
+	struct mem_section_usage *usage;
+
+	section_nr = pfn_to_section_nr(start_pfn);
+	ms = __nr_to_section(section_nr);
+
+	/* Get section's memmap address */
+	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
+
+	/*
+	 * Get page for the memmap's phys address
+	 * XXX: need more consideration for sparse_vmemmap...
+	 */
+	page = virt_to_page(memmap);
+	mapsize = sizeof(struct page) * PAGES_PER_SECTION;
+	mapsize = PAGE_ALIGN(mapsize) >> PAGE_SHIFT;
+
+	/* remember memmap's page */
+	for (i = 0; i < mapsize; i++, page++)
+		get_page_bootmem(section_nr, page, SECTION_INFO);
+
+	usage = ms->usage;
+	page = virt_to_page(usage);
+
+	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
+
+	for (i = 0; i < mapsize; i++, page++)
+		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
+
+}
+#else /* CONFIG_SPARSEMEM_VMEMMAP */
+static void register_page_bootmem_info_section(unsigned long start_pfn)
+{
+	unsigned long mapsize, section_nr, i;
+	struct mem_section *ms;
+	struct page *page, *memmap;
+	struct mem_section_usage *usage;
+
+	section_nr = pfn_to_section_nr(start_pfn);
+	ms = __nr_to_section(section_nr);
+
+	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
+
+	register_page_bootmem_memmap(section_nr, memmap, PAGES_PER_SECTION);
+
+	usage = ms->usage;
+	page = virt_to_page(usage);
+
+	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
+
+	for (i = 0; i < mapsize; i++, page++)
+		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
+}
+#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
+
+void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
+{
+	unsigned long i, pfn, end_pfn, nr_pages;
+	int node = pgdat->node_id;
+	struct page *page;
+
+	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
+	page = virt_to_page(pgdat);
+
+	for (i = 0; i < nr_pages; i++, page++)
+		get_page_bootmem(node, page, NODE_INFO);
+
+	pfn = pgdat->node_start_pfn;
+	end_pfn = pgdat_end_pfn(pgdat);
+
+	/* register section info */
+	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		/*
+		 * Some platforms can assign the same pfn to multiple nodes - on
+		 * node0 as well as nodeN.  To avoid registering a pfn against
+		 * multiple nodes we check that this pfn does not already
+		 * reside in some other nodes.
+		 */
+		if (pfn_valid(pfn) && (early_pfn_to_nid(pfn) == node))
+			register_page_bootmem_info_section(pfn);
+	}
+}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index baded53b9ff9..2da4ad071456 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -21,6 +21,7 @@
 #include <linux/memory.h>
 #include <linux/memremap.h>
 #include <linux/memory_hotplug.h>
+#include <linux/bootmem_info.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
@@ -167,96 +168,6 @@ void put_page_bootmem(struct page *page)
 	}
 }
 
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
-static void register_page_bootmem_info_section(unsigned long start_pfn)
-{
-	unsigned long mapsize, section_nr, i;
-	struct mem_section *ms;
-	struct page *page, *memmap;
-	struct mem_section_usage *usage;
-
-	section_nr = pfn_to_section_nr(start_pfn);
-	ms = __nr_to_section(section_nr);
-
-	/* Get section's memmap address */
-	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-
-	/*
-	 * Get page for the memmap's phys address
-	 * XXX: need more consideration for sparse_vmemmap...
-	 */
-	page = virt_to_page(memmap);
-	mapsize = sizeof(struct page) * PAGES_PER_SECTION;
-	mapsize = PAGE_ALIGN(mapsize) >> PAGE_SHIFT;
-
-	/* remember memmap's page */
-	for (i = 0; i < mapsize; i++, page++)
-		get_page_bootmem(section_nr, page, SECTION_INFO);
-
-	usage = ms->usage;
-	page = virt_to_page(usage);
-
-	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
-
-	for (i = 0; i < mapsize; i++, page++)
-		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
-
-}
-#else /* CONFIG_SPARSEMEM_VMEMMAP */
-static void register_page_bootmem_info_section(unsigned long start_pfn)
-{
-	unsigned long mapsize, section_nr, i;
-	struct mem_section *ms;
-	struct page *page, *memmap;
-	struct mem_section_usage *usage;
-
-	section_nr = pfn_to_section_nr(start_pfn);
-	ms = __nr_to_section(section_nr);
-
-	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
-
-	register_page_bootmem_memmap(section_nr, memmap, PAGES_PER_SECTION);
-
-	usage = ms->usage;
-	page = virt_to_page(usage);
-
-	mapsize = PAGE_ALIGN(mem_section_usage_size()) >> PAGE_SHIFT;
-
-	for (i = 0; i < mapsize; i++, page++)
-		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
-}
-#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
-
-void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-	unsigned long i, pfn, end_pfn, nr_pages;
-	int node = pgdat->node_id;
-	struct page *page;
-
-	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
-	page = virt_to_page(pgdat);
-
-	for (i = 0; i < nr_pages; i++, page++)
-		get_page_bootmem(node, page, NODE_INFO);
-
-	pfn = pgdat->node_start_pfn;
-	end_pfn = pgdat_end_pfn(pgdat);
-
-	/* register section info */
-	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		/*
-		 * Some platforms can assign the same pfn to multiple nodes - on
-		 * node0 as well as nodeN.  To avoid registering a pfn against
-		 * multiple nodes we check that this pfn does not already
-		 * reside in some other nodes.
-		 */
-		if (pfn_valid(pfn) && (early_pfn_to_nid(pfn) == node))
-			register_page_bootmem_info_section(pfn);
-	}
-}
-#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
-
 static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 		const char *reason)
 {
-- 
2.11.0

