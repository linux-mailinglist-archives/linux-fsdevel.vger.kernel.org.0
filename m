Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504532BA272
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgKTGqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTGq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:46:29 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762ECC0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:28 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so6465237pgg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQYB74FkwOxFI1h+l2VXl2pw2h4ZcuxqFh5PVtqZk4E=;
        b=pwmEpgczKBWSrmu3+OTWkDG1aT41ToDlPRJelOynJ/7xzSG5T0D4fsfdFjuI7ljqAy
         U+cpoGvvk2ZqTCKQVrnjxeLcs/1S5G/LaBpHsKXLzxkxuSGwA1N9l29P5WZiN7PqciiW
         ffE3Iq2mUoM+CLcwlifGlIqqMbzHmRS2hLZcqvXkm7tFQn9U45LGm7QRnmlIRNitgh5u
         pl2alLzUNNEtAwOXUSelwHy8bCkcjSJGg1zejEhwXm3ifjS4D/LAAtYotCCMVBQEAd18
         +CQ3jM7fB89tnMcGuyu8wj55wbRW2jrodEQLFvqI97FbnQO4kyees+R6oXAAAW/KuWSJ
         TFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQYB74FkwOxFI1h+l2VXl2pw2h4ZcuxqFh5PVtqZk4E=;
        b=KRtXPv17wBXADsY47d8Bg7Sw9RGHmGomy6IIa0ahIp2CB1C5nKho4wohxBhjP6fV57
         MJkLRUmeFua6kg/fInq/k6oyiA4Yz3CYEeuCaOlafubEJl8NAZ71osfjbrNIVNfLnrIa
         /SeZ4gX7cryZhVNdmXdOdqbX30x1NTG/Oixslw9+kx0fgLL43Xbtc8EuWvWUTkiAKrqh
         391fNFK615BYAUPuYVNGMtU1XPlCbiDCSsAO9hpV3U2LU2tZ/tq5rJ9kdvqjsLiMyfsR
         nXWbsFNkAjJ+j4LKcisLZOzm8Yhu3VZYr1mcEniWwahAS+qCGsLCpQij6zUUR+3scBOA
         Sg7A==
X-Gm-Message-State: AOAM530AHWx8Iob3QkpbaWrG/DZoShzfdvVOioJRKSvd1XlitbzWP4zT
        5voTeKZf2mzcpeXu9SZPDvczog==
X-Google-Smtp-Source: ABdhPJy/Lr2EMMaN4T7P86gH4a5O1RgE6FVFDvRJ7NZ9ZPNffEsEmVe1gyL+ORGEMts78lSncyF5dA==
X-Received: by 2002:a17:90a:5e43:: with SMTP id u3mr7794752pji.216.1605854788065;
        Thu, 19 Nov 2020 22:46:28 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:46:27 -0800 (PST)
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
Subject: [PATCH v5 02/21] mm/memory_hotplug: Move {get,put}_page_bootmem() to bootmem_info.c
Date:   Fri, 20 Nov 2020 14:43:06 +0800
Message-Id: <20201120064325.34492-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the later patch, we will use {get,put}_page_bootmem() to initialize
the page for vmemmap or free vmemmap page to buddy. So move them out of
CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code movement without any
functional change.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/mm/init_64.c          |  2 +-
 include/linux/bootmem_info.h   | 13 +++++++++++++
 include/linux/memory_hotplug.h |  4 ----
 mm/bootmem_info.c              | 25 +++++++++++++++++++++++++
 mm/memory_hotplug.c            | 27 ---------------------------
 mm/sparse.c                    |  1 +
 6 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index c7f7ad55b625..0a45f062826e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1572,7 +1572,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return err;
 }
 
-#if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HAVE_BOOTMEM_INFO_NODE)
+#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 void register_page_bootmem_memmap(unsigned long section_nr,
 				  struct page *start_page, unsigned long nr_pages)
 {
diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 65bb9b23140f..4ed6dee1adc9 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -18,10 +18,23 @@ enum {
 
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
+
+void get_page_bootmem(unsigned long info, struct page *page,
+		      unsigned long type);
+void put_page_bootmem(struct page *page);
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
 }
+
+static inline void put_page_bootmem(struct page *page)
+{
+}
+
+static inline void get_page_bootmem(unsigned long info, struct page *page,
+				    unsigned long type)
+{
+}
 #endif
 
 #endif /* __LINUX_BOOTMEM_INFO_H */
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 19e5d067294c..c9f3361fe84b 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -197,10 +197,6 @@ static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
-extern void put_page_bootmem(struct page *page);
-extern void get_page_bootmem(unsigned long ingo, struct page *page,
-			     unsigned long type);
-
 void get_online_mems(void);
 void put_online_mems(void);
 
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 39fa8fc120bc..fcab5a3f8cc0 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -10,6 +10,31 @@
 #include <linux/bootmem_info.h>
 #include <linux/memory_hotplug.h>
 
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
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
 static void register_page_bootmem_info_section(unsigned long start_pfn)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2da4ad071456..ae57eedc341f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -21,7 +21,6 @@
 #include <linux/memory.h>
 #include <linux/memremap.h>
 #include <linux/memory_hotplug.h>
-#include <linux/bootmem_info.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
@@ -142,32 +141,6 @@ static void release_memory_resource(struct resource *res)
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
 static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 		const char *reason)
 {
diff --git a/mm/sparse.c b/mm/sparse.c
index b25ad8e64839..a4138410d890 100644
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

