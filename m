Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1464F6FCBF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjEIQ6E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjEIQ53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:57:29 -0400
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040E230EC
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SY6fXe4pdNkKgId+Z2KcjRoSaHIjUmN9p3hLtNQFQOM=;
        b=E343AoWginlmYA0XNC7JmuE92IbwRHmxwqnCWVBaeQu8jZ05EtSZ5jzp35SoalYgdAyVi2
        mGxFIQ5f5mTuLhPjrCK1pmI755V80kOd3XnWhwPE3Gk3/WusCJYaQLjuq0KStuhsVRV+f0
        42/iLxS5+Ar2E2XYNjjpc2Zygm9+MFY=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 07/32] mm: Bring back vmalloc_exec
Date:   Tue,  9 May 2023 12:56:32 -0400
Message-Id: <20230509165657.1735798-8-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This is needed for bcachefs, which dynamically generates per-btree node
unpack functions.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org
---
 include/linux/vmalloc.h |  1 +
 kernel/module/main.c    |  4 +---
 mm/nommu.c              | 18 ++++++++++++++++++
 mm/vmalloc.c            | 21 +++++++++++++++++++++
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 69250efa03..ff147fe115 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -145,6 +145,7 @@ extern void *vzalloc(unsigned long size) __alloc_size(1);
 extern void *vmalloc_user(unsigned long size) __alloc_size(1);
 extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
+extern void *vmalloc_exec(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
 extern void *vmalloc_32(unsigned long size) __alloc_size(1);
 extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
 extern void *__vmalloc(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d3be89de70..9eaa89e84c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1607,9 +1607,7 @@ static void dynamic_debug_remove(struct module *mod, struct _ddebug_info *dyndbg
 
 void * __weak module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __builtin_return_address(0));
+	return vmalloc_exec(size, GFP_KERNEL);
 }
 
 bool __weak module_init_section(const char *name)
diff --git a/mm/nommu.c b/mm/nommu.c
index 57ba243c6a..8d9ab19e39 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -280,6 +280,24 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
+/**
+ *	vmalloc_exec  -  allocate virtually contiguous, executable memory
+ *	@size:		allocation size
+ *
+ *	Kernel-internal function to allocate enough pages to cover @size
+ *	the page level allocator and map them into contiguous and
+ *	executable kernel virtual space.
+ *
+ *	For tight control over page level allocator and protection flags
+ *	use __vmalloc() instead.
+ */
+
+void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
+{
+	return __vmalloc(size, gfp_mask);
+}
+EXPORT_SYMBOL_GPL(vmalloc_exec);
+
 /**
  * vmalloc_32  -  allocate virtually contiguous memory (32bit addressable)
  *	@size:		allocation size
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 31ff782d36..2ebb9ea7f0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3401,6 +3401,27 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
+/**
+ * vmalloc_exec - allocate virtually contiguous, executable memory
+ * @size:	  allocation size
+ *
+ * Kernel-internal function to allocate enough pages to cover @size
+ * the page level allocator and map them into contiguous and
+ * executable kernel virtual space.
+ *
+ * For tight control over page level allocator and protection flags
+ * use __vmalloc() instead.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+void *vmalloc_exec(unsigned long size, gfp_t gfp_mask)
+{
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+			gfp_mask, PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS,
+			NUMA_NO_NODE, __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(vmalloc_exec);
+
 #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
 #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
 #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
-- 
2.40.1

