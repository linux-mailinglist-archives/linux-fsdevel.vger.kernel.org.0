Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97BB61530F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 21:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKAUSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 16:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiKAUSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F701C91F
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eYNCdZwcLjMI7GB0XNxQj7wwgiWVGtsawTmuXyBbwQo=; b=YjQXs8pdzIbVgYkxU5Agq6SABo
        iipCwLn1LTtgEz0L2m8wVsDtvCL/Q7wYoW4QOAwrlVwj/SI09BYG8W6M5MoUoouo8JC/m0ZkOW0Wp
        e3yHvlCxxCRvZQKrChkYAk2xEdljpEp5vfeNuh5gIZTV+9HUwbzBVG6T7LAbY1SGRGQmfCZpOyUPB
        3SjK4vzjxbg6RKdK8zyAYDK3W8EfKLMhSJYgBf6W3Yr/dNmB0a3WJYrtOOZbg7rHP66aaXlqRiVOZ
        0rG2/To1/jCCGQPyG15Ve0dhuez88XeiacTiLXeUK+mfEfK0NtFG/MxcMp+vrt9yXpiNpDyjMBL5D
        GkZyrKew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opxiP-004uUU-Mv; Tue, 01 Nov 2022 20:18:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 1/2] vmalloc: Factor vmap_alloc() out of vm_map_ram()
Date:   Tue,  1 Nov 2022 20:18:27 +0000
Message-Id: <20221101201828.1170455-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221101201828.1170455-1-willy@infradead.org>
References: <20221101201828.1170455-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce vmap_alloc() to simply get the address space.  This allows
for code sharing in the next patch.

Suggested-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmalloc.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ccaa461998f3..dcab1d3cf185 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2230,6 +2230,27 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 }
 EXPORT_SYMBOL(vm_unmap_ram);
 
+static void *vmap_alloc(size_t size, int node)
+{
+	void *mem;
+
+	if (likely(size <= (VMAP_MAX_ALLOC * PAGE_SIZE))) {
+		mem = vb_alloc(size, GFP_KERNEL);
+		if (IS_ERR(mem))
+			mem = NULL;
+	} else {
+		struct vmap_area *va;
+		va = alloc_vmap_area(size, PAGE_SIZE,
+				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
+		if (IS_ERR(va))
+			mem = NULL;
+		else
+			mem = (void *)va->va_start;
+	}
+
+	return mem;
+}
+
 /**
  * vm_map_ram - map pages linearly into kernel virtual address (vmalloc space)
  * @pages: an array of pointers to the pages to be mapped
@@ -2247,24 +2268,8 @@ EXPORT_SYMBOL(vm_unmap_ram);
 void *vm_map_ram(struct page **pages, unsigned int count, int node)
 {
 	unsigned long size = (unsigned long)count << PAGE_SHIFT;
-	unsigned long addr;
-	void *mem;
-
-	if (likely(count <= VMAP_MAX_ALLOC)) {
-		mem = vb_alloc(size, GFP_KERNEL);
-		if (IS_ERR(mem))
-			return NULL;
-		addr = (unsigned long)mem;
-	} else {
-		struct vmap_area *va;
-		va = alloc_vmap_area(size, PAGE_SIZE,
-				VMALLOC_START, VMALLOC_END, node, GFP_KERNEL);
-		if (IS_ERR(va))
-			return NULL;
-
-		addr = va->va_start;
-		mem = (void *)addr;
-	}
+	void *mem = vmap_alloc(size, node);
+	unsigned long addr = (unsigned long)mem;
 
 	if (vmap_pages_range(addr, addr + size, PAGE_KERNEL,
 				pages, PAGE_SHIFT) < 0) {
-- 
2.35.1

