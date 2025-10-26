Return-Path: <linux-fsdevel+bounces-65651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 867F7C0B34A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 21:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 273E64EBFBA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698C2FF167;
	Sun, 26 Oct 2025 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKmZFSTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740683002DE
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510995; cv=none; b=lxNdfvHiXq0aYc4s1s4S9T6bR2tclfbQdFaEeraZsXBXGb8RmYuuYQ4BbwIQAUkBRT8BKJ1LrjXLbp3nmkL8Qm1RdkQdZwzwGr35Ed2BpIkmD1X85ZBphc93Q4lLVHVUpx+nCih47mqrlLCRyLc0RBfgRVA8voOZKq++2eunvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510995; c=relaxed/simple;
	bh=SeRCzHjAZ+hqkWMI7OzvgbEtnIoiGsZ9BBowdHIKXRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bUijetNhBLcZL3l879d6giVrS8lKjuGDt05YxkRG4Gc9Nx5kCzKV55pB5BhkqpyrpU56COxTpi/HYKnpl85fQVN/FVuc/QsnmhsxqbmFfbCAxMboU1phD8OaoR8NfPTjg/GMFYQ5D452iF+0REr67QN7YgAz5A5T0+n1cMjgwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKmZFSTq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-784388e90f0so52667997b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510992; x=1762115792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldBBc2e1dfbyRaOTMu7xgu9ZtisaUPfuPL5Tr5iIwBM=;
        b=VKmZFSTqeVN16A4q4SZVlROpcnoS2QUjWsEPCVODZ4N+29eNQ4uXg6xRAF8eDQPNJz
         A8ruX3VmG4JjHTAWd71hcXOy2pfDuZl+sgkSQBaJUlPMSqvRz4P1skNGQz9rk3jq9UXb
         elkliLX4Ronli7yw8D5Vy4XiQrGFwXJb2GumN3CPZEJ0jeCpH2+v0ckMSMvw5az0a2r9
         OOZCPd+6H5wfi6wTv9zM+uNxvhQ5EHLnxwUTracPc5mFRByRkpZay6hAL1Vb9VrguQjj
         iLGfoL8a8G8TjrfR8VurG4PfVIWAjd3JdikiFknv2WY4ChQmtaD2oY86X50MV4mnQCTi
         Ew4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510992; x=1762115792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldBBc2e1dfbyRaOTMu7xgu9ZtisaUPfuPL5Tr5iIwBM=;
        b=UUi9jqp6+HUef2cGuIaJ4TPvRy+yIqftwyIsjyRCv3ZXW9W74J3GOzSgJmgSRjaKLY
         mmr0lWnd2WMTgsnxpU9ZY6l+PDV0/UT5XcwoUSlYPFymOmOPzFon7hYdYSIwZCGlb+6c
         oSqley3OKbTt1GGHrdKaJCisyn8Mbxwmnih4Q8yawUSN8ACvGC1CmVcyW6nE/CvD1TNk
         nDQsptkyoCJtcF5k+9Ak7W2bPpTMmpe6qZSsPI1I5ncgzAde1xeVqDG74rwkZh+23+L4
         vIPWkU+fjdloK8px3SEyPOB84M3u1pMGbpFtuZVRfEQiitgX/Lwx3TLAbqNqqOsQituA
         g6+g==
X-Forwarded-Encrypted: i=1; AJvYcCVekPFmC/8plYFOqJ4d1NF48OA+xdgA9AafMwMV8rCLoxo6g+VoHegW/DJshqeR1cyQeNmW2RA+kJCvppwO@vger.kernel.org
X-Gm-Message-State: AOJu0YydygbNl8AaoAvXg0OEPvZH45NC6wUhdAvc02Fu39Tz1VZZ8UDd
	lM+jEj8POaH8owULC2SuuOI91hxyNmzBhO51fHjW6xgNSXdrDFZvVBtWP5V1lX4KWzr/tzcI1Pm
	qGzukEw==
X-Google-Smtp-Source: AGHT+IHTjjYIfLTQVYwrbFnLFzysSRA0cI7//o4uCjgZD63uA+e+/DxWUL27OlXKaVk1obVSWsBkcP+KEyM=
X-Received: from yxf19.prod.google.com ([2002:a53:b113:0:b0:63f:2d9a:6526])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a53:b118:0:b0:635:4ecf:bdc6
 with SMTP id 956f58d0204a3-63f435602d0mr7203026d50.40.1761510992511; Sun, 26
 Oct 2025 13:36:32 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:11 -0700
In-Reply-To: <20251026203611.1608903-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251026203611.1608903-1-surenb@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-9-surenb@google.com>
Subject: [PATCH v2 8/8] mm: integrate GCMA with CMA using dt-bindings
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
index 3166fde83340..1c8b20d90790 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1099,7 +1099,7 @@ config CMA_AREAS
 
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
index b86f82b8fe9d..fcf1d3c0283f 100644
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
2.51.1.851.g4ebd6896fd-goog


