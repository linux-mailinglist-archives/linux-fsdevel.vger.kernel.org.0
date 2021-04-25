Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9C836A553
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhDYHNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhDYHNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:13:36 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77395C061756
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 00:12:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so2254966pfn.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTitpq7JLqAqElYXIvGRft3HWmQzQ47ggWClz6iEgnU=;
        b=pU8vIx9iRJPyT9CsJsExnVG6MBHKs0scS20kkgcwkzKlNA8SBCfmuHJykE+gMjH9pM
         t4XSyompTUOE/59wdVhQKd9q/v+9kVRwDn1p00793oH9HciDY7BaEgilTah5jm+V3sM9
         It2NKepDSgXLxS6vjKPMNenHoD2jrxGtB56X8YNhHxZRA2Cr0mFweZMSfvcOvBq5ONVU
         C6F3hHp+X1C12apsXF6gAu/xZe4d4pdXUCrGt3zYlwEUhEJ1DOarWSscEvEi/39uDRJP
         mQ/EtLKk2pWPHNp3/VkzFVzrwalUATKhFVuOyrocTDe4yqCO/nNr/KG9P4QF4ANtsEmB
         2Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTitpq7JLqAqElYXIvGRft3HWmQzQ47ggWClz6iEgnU=;
        b=lbaKnz4gnwqiOgY6Hmfl+2awSA8hN+VFDTAw/XDAmhwtAO9cTMPDERqpwcySuA/p/v
         RuS7womQYPrusrcO0cn4Xjc0+sx8a5StuuoSFP6pwrq2EeTscEEZAbVu7imxXx9FnHYj
         AgWjmMsVVcW/XRVWSz908lhzFOvlh6OOYjXMBIS+0yMEw/Lky9eIPmdJxGSkTuJJrUgR
         4P4bgS2833AggA47XZrqeCbNT7h/WaAWHhcBOfNn7e0TFZFEqvK1gDBmzLhoqWZavTNR
         rzGiSbOPVuyJWvAgHmWd8nHXy1rNePi1yLYvlAG582kdbksf5ObqF4otz5zltdx1+6+a
         zjdQ==
X-Gm-Message-State: AOAM531kVk6duQUSoQD6THa5orZEQM+Itzs5h/MP7JQ+gWeXD9i3a12C
        0Lh7NUYX1F+IKFJb666xhRxy9w==
X-Google-Smtp-Source: ABdhPJzUBR/7bAGgFE7j6bMAVtwwCwcarXfsMLvvmWaWkbpvoXzObeBPRKtexTDj4LzM5Xaqwz87nA==
X-Received: by 2002:a63:5f88:: with SMTP id t130mr11539800pgb.403.1619334776996;
        Sun, 25 Apr 2021 00:12:56 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h8sm8767125pjt.17.2021.04.25.00.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 00:12:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v21 1/9] mm: memory_hotplug: factor out bootmem core functions to bootmem_info.c
Date:   Sun, 25 Apr 2021 15:07:44 +0800
Message-Id: <20210425070752.17783-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210425070752.17783-1-songmuchun@bytedance.com>
References: <20210425070752.17783-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move bootmem info registration common API to individual bootmem_info.c.
And we will use {get,put}_page_bootmem() to initialize the page for the
vmemmap pages or free the vmemmap pages to buddy in the later patch.
So move them out of CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code
movement without any functional change.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
---
 arch/sparc/mm/init_64.c        |   1 +
 arch/x86/mm/init_64.c          |   3 +-
 include/linux/bootmem_info.h   |  40 +++++++++++++
 include/linux/memory_hotplug.h |  27 ---------
 mm/Makefile                    |   1 +
 mm/bootmem_info.c              | 127 +++++++++++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c            | 116 -------------------------------------
 mm/sparse.c                    |   1 +
 8 files changed, 172 insertions(+), 144 deletions(-)
 create mode 100644 include/linux/bootmem_info.h
 create mode 100644 mm/bootmem_info.c

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index e454f179cf5d..ac9d8b161e0c 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -27,6 +27,7 @@
 #include <linux/percpu.h>
 #include <linux/mmzone.h>
 #include <linux/gfp.h>
+#include <linux/bootmem_info.h>
 
 #include <asm/head.h>
 #include <asm/page.h>
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e527d829e1ed..3aaf1d30c777 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -33,6 +33,7 @@
 #include <linux/nmi.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
+#include <linux/bootmem_info.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1623,7 +1624,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return err;
 }
 
-#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HAVE_BOOTMEM_INFO_NODE)
+#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 void register_page_bootmem_memmap(unsigned long section_nr,
 				  struct page *start_page, unsigned long nr_pages)
 {
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
new file mode 100644
index 000000000000..4ed6dee1adc9
--- /dev/null
+++ b/include/linux/bootmem_info.h
@@ -0,0 +1,40 @@
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
+
+void get_page_bootmem(unsigned long info, struct page *page,
+		      unsigned long type);
+void put_page_bootmem(struct page *page);
+#else
+static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
+{
+}
+
+static inline void put_page_bootmem(struct page *page)
+{
+}
+
+static inline void get_page_bootmem(unsigned long info, struct page *page,
+				    unsigned long type)
+{
+}
+#endif
+
+#endif /* __LINUX_BOOTMEM_INFO_H */
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 28f32fd00fe9..a7fd2c3ccb77 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -18,18 +18,6 @@ struct vmem_altmap;
 #ifdef CONFIG_MEMORY_HOTPLUG
 struct page *pfn_to_online_page(unsigned long pfn);
 
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
@@ -222,17 +210,6 @@ static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
-#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
-extern void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
-#else
-static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-}
-#endif
-extern void put_page_bootmem(struct page *page);
-extern void get_page_bootmem(unsigned long ingo, struct page *page,
-			     unsigned long type);
-
 void get_online_mems(void);
 void put_online_mems(void);
 
@@ -260,10 +237,6 @@ static inline void zone_span_writelock(struct zone *zone) {}
 static inline void zone_span_writeunlock(struct zone *zone) {}
 static inline void zone_seqlock_init(struct zone *zone) {}
 
-static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-}
-
 static inline int try_online_node(int nid)
 {
 	return 0;
diff --git a/mm/Makefile b/mm/Makefile
index a9ad6122d468..d0ccddae7a45 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -126,3 +126,4 @@ obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
 obj-$(CONFIG_IO_MAPPING) += io-mapping.o
+obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
new file mode 100644
index 000000000000..5b152dba7344
--- /dev/null
+++ b/mm/bootmem_info.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Bootmem core functions.
+ *
+ * Copyright (c) 2020, Bytedance.
+ *
+ *     Author: Muchun Song <songmuchun@bytedance.com>
+ *
+ */
+#include <linux/mm.h>
+#include <linux/compiler.h>
+#include <linux/memblock.h>
+#include <linux/bootmem_info.h>
+#include <linux/memory_hotplug.h>
+
+void get_page_bootmem(unsigned long info, struct page *page, unsigned long type)
+{
+	page->freelist = (void *)type;
+	SetPagePrivate(page);
+	set_page_private(page, info);
+	page_ref_inc(page);
+}
+
+void put_page_bootmem(struct page *page)
+{
+	unsigned long type;
+
+	type = (unsigned long) page->freelist;
+	BUG_ON(type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
+	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
+
+	if (page_ref_dec_return(page) == 1) {
+		page->freelist = NULL;
+		ClearPagePrivate(page);
+		set_page_private(page, 0);
+		INIT_LIST_HEAD(&page->lru);
+		free_reserved_page(page);
+	}
+}
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
index 9e82c842b7cd..16b3a7a1db8c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -154,122 +154,6 @@ static void release_memory_resource(struct resource *res)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
-void get_page_bootmem(unsigned long info,  struct page *page,
-		      unsigned long type)
-{
-	page->freelist = (void *)type;
-	SetPagePrivate(page);
-	set_page_private(page, info);
-	page_ref_inc(page);
-}
-
-void put_page_bootmem(struct page *page)
-{
-	unsigned long type;
-
-	type = (unsigned long) page->freelist;
-	BUG_ON(type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
-	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
-
-	if (page_ref_dec_return(page) == 1) {
-		page->freelist = NULL;
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		INIT_LIST_HEAD(&page->lru);
-		free_reserved_page(page);
-	}
-}
-
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
diff --git a/mm/sparse.c b/mm/sparse.c
index b2ada9dc00cb..7ac481353b6b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/bootmem_info.h>
 
 #include "internal.h"
 #include <asm/dma.h>
-- 
2.11.0

