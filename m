Return-Path: <linux-fsdevel+bounces-2460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7727E62AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 04:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7760B1C20865
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 03:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAF5697;
	Thu,  9 Nov 2023 03:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n5nLAt33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A853B8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 03:31:32 +0000 (UTC)
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 19:31:31 PST
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1FE26A8
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:31:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699500357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNM/9AevUF/j2VNxIIJfzv4M+2rCeqcsvFMA+tau3Ik=;
	b=n5nLAt33vu68n5XOR8wfuoMwuOsrYmFbqUormWmo3tffPeqYeIiAiUe5LDLU86jzAvB8b7
	i3Z0y+6mVqQQrIj2np5f3kbeRycc+XToQwL/sDcYB+8+ZUH+no3gv0dHD1+ZtvCMNJZPfa
	+4AihrFRti7/kLoDX6Sh56JxhizH7b8=
From: Jeff Xie <jeff.xie@linux.dev>
To: akpm@linux-foundation.org,
	iamjoonsoo.kim@lge.com,
	vbabka@suse.cz,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	willy@infradead.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chensong_2000@189.cn,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [RFC][PATCH 2/4] mm, slub: implement slub allocate post callback for page_owner
Date: Thu,  9 Nov 2023 11:25:19 +0800
Message-Id: <20231109032521.392217-3-jeff.xie@linux.dev>
In-Reply-To: <20231109032521.392217-1-jeff.xie@linux.dev>
References: <20231109032521.392217-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement the callback function slab_alloc_post_page_owner for the page_owner
to make the owner of the slab page clearer

For example, for slab page, a line is added to the result of page_owner

added: "SLAB_PAGE slab_name:kmalloc-32"

Page allocated via order 0, mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 340615384 ns
SLAB_PAGE slab_name:kmalloc-32
PFN 0x4be0 type Unmovable Block 37 type Unmovable Flags 0x1fffc0000000800(slab|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 allocate_slab+0x31f/0x410
 ___slab_alloc+0x3e8/0x850
 __kmem_cache_alloc_node+0x111/0x2b0
 kmalloc_trace+0x29/0x90
 iommu_setup_dma_ops+0x299/0x470
 bus_iommu_probe+0xe1/0x150
 iommu_device_register+0xad/0x120
 intel_iommu_init+0xe3a/0x1260
 pci_iommu_init+0x12/0x40
 do_one_initcall+0x45/0x210
 kernel_init_freeable+0x1a4/0x2e0
 kernel_init+0x1a/0x1c0

added: "SLAB_PAGE slab_name:mm_struct"

Page allocated via order 3, mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), \
pid 86, tgid 86 (linuxrc), ts 1121118666 ns 
SLAB_PAGE slab_name:mm_struct
PFN 0x6388 type Unmovable Block 49 type Unmovable Flags 0x1fffc0000000840(slab|head|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 allocate_slab+0x31f/0x410
 ___slab_alloc+0x3e8/0x850
 kmem_cache_alloc+0x2b8/0x2f0
 mm_alloc+0x1a/0x50
 alloc_bprm+0x8a/0x300
 do_execveat_common.isra.0+0x68/0x240
 __x64_sys_execve+0x37/0x50
 do_syscall_64+0x42/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
 include/linux/slab.h |  8 +++++++-
 mm/slub.c            | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d6d6ffeeb9a2..c8969eb4f322 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -795,5 +795,11 @@ int slab_dead_cpu(unsigned int cpu);
 #define slab_prepare_cpu	NULL
 #define slab_dead_cpu		NULL
 #endif
-
+#ifndef CONFIG_PAGE_OWNER
+static inline int slab_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
+		void *data, char *kbuf, size_t count)
+{
+	return 0;
+}
+#endif
 #endif	/* _LINUX_SLAB_H */
diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..7ab8c7aa78e5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -44,6 +44,7 @@
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
+#include <linux/page_owner.h>
 
 #include "internal.h"
 
@@ -1993,6 +1994,19 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
+#ifdef CONFIG_PAGE_OWNER
+static int slab_alloc_post_page_owner(struct folio *folio, struct task_struct *tsk,
+			void *data, char *kbuf, size_t count)
+{
+	int ret;
+	struct kmem_cache *kmem_cache = data;
+
+	ret = scnprintf(kbuf, count, "SLAB_PAGE slab_name:%s\n", kmem_cache->name);
+
+	return ret;
+}
+#endif
+
 static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
 	struct slab *slab;
@@ -2028,6 +2042,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		stat(s, ORDER_FALLBACK);
 	}
 
+	set_folio_alloc_post_page_owner(slab_folio(slab), slab_alloc_post_page_owner, s);
 	slab->objects = oo_objects(oo);
 	slab->inuse = 0;
 	slab->frozen = 0;
-- 
2.34.1


