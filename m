Return-Path: <linux-fsdevel+bounces-63710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4FBCB596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67604354EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE9D26FDAC;
	Fri, 10 Oct 2025 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gsFRymlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA5269CE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059216; cv=none; b=NlgoA2FlDbpf459REcauDJbb9gsynMLaR1Q74HzgKQjkRCkOD/+3tDc6H/pbxPjaCB7gYbuJ6mngSQHSNoeiXHGyx7e7cs50JGn8geuYe/hihHD1iB8ukBL6aZ8Ea6nhZHVR6fHOrCw701t7YVdLXkEmkuLzyC2knGZBKZ8mwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059216; c=relaxed/simple;
	bh=oyemZIe+YmeGtd9SCcDsGnEDPdQlvUm05tKLh3ceOSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pbMomiuJjRXm9M+mkW3l+nAQs69P97afpcmzGV5NgUSQAJzad77jvcagIOAj4EsecfY665xu+oJYRX3Wxt1IxOE43GACFR3774+4BncMGuXoDdrTNv5RA5OmdUFPmyEeHLtkPLurGNN2dWlmRaw4T9T132j/VAIXDx4p9GIhgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gsFRymlZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b60992e3b27so2482969a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059214; x=1760664014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrde2qlU5hqI2CpGGepvHr5s2l9yi26YQf6xU7aW9eE=;
        b=gsFRymlZ+Y96mJXgowjOaL4nbZn8xqz9wFAIIalnn0mClLRL5KwcCKvSBeZmcHvfV8
         qh69VoknRSIwt5xeBKRWrS4FRTvpcpUX6f2ki5S0hJlkw5HBJbVRxuYuMLk+IsgeN7rt
         P23NzJ2EP852ziE0ZUjvcATbQ+rjsWMLKrLgTE7wdPjEiyNkj2/FY2WVfouwV8lDJ+Xt
         5XdAkrH2+MHWjpzKzp4peTlM/laFk5BluNBjhjfI/jw6ye3lsyY6z/malwM6I3ZEVxgY
         vB2s5RYvLOoqtJhjq7Hq4MCiKZyzpREyvBAbWpqohAz6W5sIc7pCcYVlbtEROwf3DZng
         uI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059214; x=1760664014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrde2qlU5hqI2CpGGepvHr5s2l9yi26YQf6xU7aW9eE=;
        b=avCCD2prTWG4c+qv2wBVK+a/rtXUgi/5bimlVN5qdrCy8Ym/0tmQtHCTskbf7exoh2
         Mp2PLmMktlKVCccu8D5ipclPxi1va7ZH3VBOJCG+ShJll2Zs5NqdFen2ePeqZsA6Pwfx
         CKWGyJQ2FOBEKNusR/sFvuV+BdMM2Wu/5a3+HS+vkthkxHmFttFkMeHJo1S7BYG/pkUo
         Ff8c7kQgBc0c34nyhsBbzKuTUWuCLcIOZQ/Ay2z2GRx+0LgTpds34iR6WqdA70nPCmFo
         rsFH1r7VVyIRNT3kME+C+Q1p2EBMH3xwdyWejnCV9wQWDwTF6eoa4J983Dq+/LU/6Kj1
         qv9A==
X-Forwarded-Encrypted: i=1; AJvYcCVQm6t6fYyqBGqrsmHPVtICwIInTqKYImeN9VK4s0ITidlqPz4JP1LGaPD9m5RhpepTszXOpJzZNq0yutH2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh4zc6F5a6ribhFp4QQ7kfoueYyT+TK3PAfmej/3JDXL8GeeOQ
	KnuePJRoSLQnU7zK31c2n09exJ6TBPirWtiKx/oKby64P6FF/yVoRqRsaj8LIqAJaRMSXCk1sKD
	gX742VA==
X-Google-Smtp-Source: AGHT+IHv8uHGO40bLuN/jD5N/hL/DXXvgcz7LG4u+TAflEKVP3j7kuuG1LjFXB0Jk3SVlTNaWflJDBbA6Ac=
X-Received: from pgew27.prod.google.com ([2002:a63:af1b:0:b0:b55:794f:64bb])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12ce:b0:309:48d8:cf0a
 with SMTP id adf61e73a8af0-32da8462fb2mr12231761637.54.1760059213708; Thu, 09
 Oct 2025 18:20:13 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:51 -0700
In-Reply-To: <20251010011951.2136980-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-9-surenb@google.com>
Subject: [PATCH 8/8] mm: integrate GCMA with CMA using dt-bindings
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new "guarantee" property for shared-dma-pool to enable
GCMA-backed memory pools. Memory allocations from such pools will
have low latency and will be guaranteed to succeed as long as there
is contiguous space inside the reservation.
dt-schema for shared-dma-pool [1] will need to be updated once this
patch is accepted.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/shared-dma-pool.yaml

Signed-off-by: Minchan Kim <minchan@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/cma.h     | 11 +++++++++--
 kernel/dma/contiguous.c | 11 ++++++++++-
 mm/Kconfig              |  2 +-
 mm/cma.c                | 37 +++++++++++++++++++++++++++----------
 mm/cma.h                |  1 +
 mm/cma_sysfs.c          | 10 ++++++++++
 mm/gcma.c               |  2 +-
 7 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 62d9c1cf6326..3ec2e76a8666 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -43,10 +43,17 @@ static inline int __init cma_declare_contiguous(phys_addr_t base,
 extern int __init cma_declare_contiguous_multi(phys_addr_t size,
 			phys_addr_t align, unsigned int order_per_bit,
 			const char *name, struct cma **res_cma, int nid);
-extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
+extern int __cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
-					struct cma **res_cma);
+					struct cma **res_cma, bool gcma);
+static inline int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
+					unsigned int order_per_bit,
+					const char *name,
+					struct cma **res_cma)
+{
+	return __cma_init_reserved_mem(base, size, order_per_bit, name, res_cma, false);
+}
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d9b9dcba6ff7..73a699ef0377 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -461,6 +461,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
+	bool gcma;
 	int err;
 
 	if (size_cmdline != -1 && default_cma) {
@@ -478,7 +479,15 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EINVAL;
 	}
 
-	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
+	gcma = !!of_get_flat_dt_prop(node, "guarantee", NULL);
+#ifndef CONFIG_GCMA
+	if (gcma) {
+		pr_err("Reserved memory: unable to setup GCMA region, GCMA is not enabled\n");
+		return -EINVAL;
+	}
+#endif
+	err = __cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
+				      &cma, gcma);
 	if (err) {
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
diff --git a/mm/Kconfig b/mm/Kconfig
index 41ce5ef8db55..729f150369cc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1015,7 +1015,7 @@ config CMA_AREAS
 
 config GCMA
        bool "GCMA (Guaranteed Contiguous Memory Allocator)"
-       depends on CLEANCACHE
+       depends on CLEANCACHE && CMA
 	help
 	  This enables the Guaranteed Contiguous Memory Allocator to allow
 	  low latency guaranteed contiguous memory allocations. Memory
diff --git a/mm/cma.c b/mm/cma.c
index 813e6dc7b095..71fb494ef2a4 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -28,6 +28,7 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/kmemleak.h>
+#include <linux/gcma.h>
 #include <trace/events/cma.h>
 
 #include "internal.h"
@@ -161,11 +162,18 @@ static void __init cma_activate_area(struct cma *cma)
 			count = early_pfn[r] - cmr->base_pfn;
 			bitmap_count = cma_bitmap_pages_to_bits(cma, count);
 			bitmap_set(cmr->bitmap, 0, bitmap_count);
+		} else {
+			count = 0;
 		}
 
-		for (pfn = early_pfn[r]; pfn < cmr->base_pfn + cmr->count;
-		     pfn += pageblock_nr_pages)
-			init_cma_reserved_pageblock(pfn_to_page(pfn));
+		if (cma->gcma) {
+			gcma_register_area(cma->name, early_pfn[r],
+					   cma->count - count);
+		} else {
+			for (pfn = early_pfn[r]; pfn < cmr->base_pfn + cmr->count;
+			     pfn += pageblock_nr_pages)
+				init_cma_reserved_pageblock(pfn_to_page(pfn));
+		}
 	}
 
 	spin_lock_init(&cma->lock);
@@ -252,7 +260,7 @@ static void __init cma_drop_area(struct cma *cma)
 }
 
 /**
- * cma_init_reserved_mem() - create custom contiguous area from reserved memory
+ * __cma_init_reserved_mem() - create custom contiguous area from reserved memory
  * @base: Base address of the reserved area
  * @size: Size of the reserved area (in bytes),
  * @order_per_bit: Order of pages represented by one bit on bitmap.
@@ -260,13 +268,14 @@ static void __init cma_drop_area(struct cma *cma)
  *        the area will be set to "cmaN", where N is a running counter of
  *        used areas.
  * @res_cma: Pointer to store the created cma region.
+ * @gcma: Flag to reserve guaranteed reserved memory area.
  *
  * This function creates custom contiguous area from already reserved memory.
  */
-int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
-				 unsigned int order_per_bit,
-				 const char *name,
-				 struct cma **res_cma)
+int __init __cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
+				   unsigned int order_per_bit,
+				   const char *name,
+				   struct cma **res_cma, bool gcma)
 {
 	struct cma *cma;
 	int ret;
@@ -297,6 +306,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	cma->ranges[0].count = cma->count;
 	cma->nranges = 1;
 	cma->nid = NUMA_NO_NODE;
+	cma->gcma = gcma;
 
 	*res_cma = cma;
 
@@ -836,7 +846,11 @@ static int cma_range_alloc(struct cma *cma, struct cma_memrange *cmr,
 		spin_unlock_irq(&cma->lock);
 
 		mutex_lock(&cma->alloc_mutex);
-		ret = alloc_contig_range(pfn, pfn + count, ACR_FLAGS_CMA, gfp);
+		if (cma->gcma)
+			ret = gcma_alloc_range(pfn, count, gfp);
+		else
+			ret = alloc_contig_range(pfn, pfn + count,
+						 ACR_FLAGS_CMA, gfp);
 		mutex_unlock(&cma->alloc_mutex);
 		if (!ret)
 			break;
@@ -1009,7 +1023,10 @@ bool cma_release(struct cma *cma, const struct page *pages,
 	if (r == cma->nranges)
 		return false;
 
-	free_contig_range(pfn, count);
+	if (cma->gcma)
+		gcma_free_range(pfn, count);
+	else
+		free_contig_range(pfn, count);
 	cma_clear_bitmap(cma, cmr, pfn, count);
 	cma_sysfs_account_release_pages(cma, count);
 	trace_cma_release(cma->name, pfn, pages, count);
diff --git a/mm/cma.h b/mm/cma.h
index c70180c36559..3b09e8619082 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -49,6 +49,7 @@ struct cma {
 	char name[CMA_MAX_NAME];
 	int nranges;
 	struct cma_memrange ranges[CMA_MAX_RANGES];
+	bool gcma;
 #ifdef CONFIG_CMA_SYSFS
 	/* the number of CMA page successful allocations */
 	atomic64_t nr_pages_succeeded;
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index 97acd3e5a6a5..4ecc36270a4d 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -80,6 +80,15 @@ static ssize_t available_pages_show(struct kobject *kobj,
 }
 CMA_ATTR_RO(available_pages);
 
+static ssize_t gcma_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	struct cma *cma = cma_from_kobj(kobj);
+
+	return sysfs_emit(buf, "%d\n", cma->gcma);
+}
+CMA_ATTR_RO(gcma);
+
 static void cma_kobj_release(struct kobject *kobj)
 {
 	struct cma *cma = cma_from_kobj(kobj);
@@ -95,6 +104,7 @@ static struct attribute *cma_attrs[] = {
 	&release_pages_success_attr.attr,
 	&total_pages_attr.attr,
 	&available_pages_attr.attr,
+	&gcma_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cma);
diff --git a/mm/gcma.c b/mm/gcma.c
index 3ee0e1340db3..8e7d7a829b49 100644
--- a/mm/gcma.c
+++ b/mm/gcma.c
@@ -119,7 +119,7 @@ int gcma_register_area(const char *name,
 		folio_set_count(folio, 0);
 		list_add(&folio->lru, &folios);
 	}
-
+	folio_zone(pfn_folio(start_pfn))->cma_pages += count;
 	cleancache_backend_put_folios(pool_id, &folios);
 
 	spin_lock(&gcma_area_lock);
-- 
2.51.0.740.g6adb054d12-goog


