Return-Path: <linux-fsdevel+bounces-16834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9248A391E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DAD1C21096
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBD8F48;
	Sat, 13 Apr 2024 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="vhHNxpf0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3817C74
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967930; cv=none; b=Tk7mtK+9EG+XArOzY+nNvejbYBkHDEMtlo7SIgbR+tzvy1RtEI0g5Cohi9evsCF2v3zsKk8DqbPby+HZ+KWJmyeNX4EGPJ1FPJ4hbHCbvVzBnDWecPI9mdwE3LelyylKCg/KoTWjN3mWRnSNhC7w1pkgM/eoLOXBIc1+/usQpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967930; c=relaxed/simple;
	bh=dqmGqtIw5mvf23pF0vSm1mRwqN8N/hHMc5kMh/R4cpU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0h9ZrPBDGog7rk+fyUjrC1ixoBE3lcZPAE0SmSK8OV8gjX5KppMPQBgahXlPeLh8MVgnxw+cDG8gZByhvfH88kK75yCMkRyuzP+97v3IatGwZX1Nw+DtEQD66GHK1poLBA3JisYIsHv3fmpDr1kOEDODnZzKJajoKgwTKTYTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=vhHNxpf0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78ebc7e1586so247567085a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712967926; x=1713572726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiP8UC90cd5KxXzrbJg0GLX3uruD53Hpy3rdG4dJgI4=;
        b=vhHNxpf03dPadh35z9hesU+Fj0o3pkrqm0JLDB+k3/31RioEwAh6TsvZe9sszU4OGk
         zEXx7d+HX103Onj0IWBAf72qtst6PCkKfaNgpvcBPc7iPpTl8HpTbNCVmQuvbIPFKcC7
         GA8YweZpX8MoEL8xe7P1/h+CSkkhkCVTf100R/kOASwIUQzAXPD0mdfkhSY420pyYVYf
         9Z3aybXFriSMAdPK/TwwXsco9mD68W/QYEd3Beri7R9fLSpej/euqjLlcVJFhyPTQEV4
         04tfsFn8NzYGT57Tw3X0fDmDJef/i6wyQBQmn9TgH1na0fYpLPgHubK/hOcuknZNcIps
         xIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967926; x=1713572726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiP8UC90cd5KxXzrbJg0GLX3uruD53Hpy3rdG4dJgI4=;
        b=R8XKpWC4+BfnI7H3B5oN3tgtU8/9z7o6jB3m5oUIDtFEUv/1zkAzqN/PN6tMzBG1bL
         rL8PR3PPyBrud+eBCYuf9++gmIge07D8khTlHp+fAYVoiNUkT97zMHeLQg0HRh2kyfr9
         asp2kRq0SM8xwH7yDT/9SyAMrf+KdleEQVm28JMkSMAQMNBljscXZ/bL8feBgkAefeaV
         66tEDKELNpceXmeAJkjLvYHIOOZWtbgkhcn6TgEshBzrAMKfMS+hZV3YmnRGzqRIzre9
         UiXViIJ6U9qrcelXVosZcob7ISh3cEfmGbHoSeBxLB7UVH9vDxIWfgvw+JnAoVpLGcmr
         vrdg==
X-Forwarded-Encrypted: i=1; AJvYcCV2tygNBQJpnCr3AHtEsPDi5fZMUct2QY28OSJw8WKA4iK1hWkvyvtLUOWt9lYOamqykwiFJj4oYOA+f5jq1tqW/hGxxuqIhKHca9JbvQ==
X-Gm-Message-State: AOJu0YzpKOXE637X9cukf3CGbMgF29d5Zlczv3PK7pFEpz0VZ1zNzzQn
	eVCwA1lT4QcTOY+v4lMKaS6kIV19hkF1ixO8LTuvkt99g8kC2cTaSgw/XFaimP8=
X-Google-Smtp-Source: AGHT+IH1tL1T2UBZKwUG+40tYDzHI0evrIR/OJeSig+4+S3Y2HeJ3HZ8yc2wtJwmzZSSxRzAx0lscA==
X-Received: by 2002:a05:620a:28c6:b0:78e:c654:2ff0 with SMTP id l6-20020a05620a28c600b0078ec6542ff0mr8918726qkp.23.1712967926229;
        Fri, 12 Apr 2024 17:25:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (128.174.85.34.bc.googleusercontent.com. [34.85.174.128])
        by smtp.gmail.com with ESMTPSA id wl25-20020a05620a57d900b0078d5fece9a6sm3053490qkn.101.2024.04.12.17.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:25:25 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v6 01/11] iommu/vt-d: add wrapper functions for page allocations
Date: Sat, 13 Apr 2024 00:25:12 +0000
Message-ID: <20240413002522.1101315-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
References: <20240413002522.1101315-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to improve observability and accountability of IOMMU layer, we
must account the number of pages that are allocated by functions that
are calling directly into buddy allocator.

This is achieved by first wrapping the allocation related functions into a
separate inline functions in new file:

drivers/iommu/iommu-pages.h

Convert all page allocation calls under iommu/intel to use these new
functions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: David Rientjes <rientjes@google.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/iommu/intel/dmar.c          |  16 +--
 drivers/iommu/intel/iommu.c         |  47 +++------
 drivers/iommu/intel/iommu.h         |   2 -
 drivers/iommu/intel/irq_remapping.c |  16 +--
 drivers/iommu/intel/pasid.c         |  18 ++--
 drivers/iommu/intel/svm.c           |  11 +-
 drivers/iommu/iommu-pages.h         | 154 ++++++++++++++++++++++++++++
 7 files changed, 201 insertions(+), 63 deletions(-)
 create mode 100644 drivers/iommu/iommu-pages.h

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..87ad996e5257 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -32,6 +32,7 @@
 
 #include "iommu.h"
 #include "../irq_remapping.h"
+#include "../iommu-pages.h"
 #include "perf.h"
 #include "trace.h"
 #include "perfmon.h"
@@ -1187,7 +1188,7 @@ static void free_iommu(struct intel_iommu *iommu)
 	}
 
 	if (iommu->qi) {
-		free_page((unsigned long)iommu->qi->desc);
+		iommu_free_page(iommu->qi->desc);
 		kfree(iommu->qi->desc_status);
 		kfree(iommu->qi);
 	}
@@ -1755,7 +1756,8 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
 int dmar_enable_qi(struct intel_iommu *iommu)
 {
 	struct q_inval *qi;
-	struct page *desc_page;
+	void *desc;
+	int order;
 
 	if (!ecap_qis(iommu->ecap))
 		return -ENOENT;
@@ -1776,19 +1778,19 @@ int dmar_enable_qi(struct intel_iommu *iommu)
 	 * Need two pages to accommodate 256 descriptors of 256 bits each
 	 * if the remapping hardware supports scalable mode translation.
 	 */
-	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
-				     !!ecap_smts(iommu->ecap));
-	if (!desc_page) {
+	order = ecap_smts(iommu->ecap) ? 1 : 0;
+	desc = iommu_alloc_pages_node(iommu->node, GFP_ATOMIC, order);
+	if (!desc) {
 		kfree(qi);
 		iommu->qi = NULL;
 		return -ENOMEM;
 	}
 
-	qi->desc = page_address(desc_page);
+	qi->desc = desc;
 
 	qi->desc_status = kcalloc(QI_LENGTH, sizeof(int), GFP_ATOMIC);
 	if (!qi->desc_status) {
-		free_page((unsigned long) qi->desc);
+		iommu_free_page(qi->desc);
 		kfree(qi);
 		iommu->qi = NULL;
 		return -ENOMEM;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a7ecd90303dc..daaa7a22595e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -27,6 +27,7 @@
 #include "iommu.h"
 #include "../dma-iommu.h"
 #include "../irq_remapping.h"
+#include "../iommu-pages.h"
 #include "pasid.h"
 #include "cap_audit.h"
 #include "perfmon.h"
@@ -298,22 +299,6 @@ static int __init intel_iommu_setup(char *str)
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
-void *alloc_pgtable_page(int node, gfp_t gfp)
-{
-	struct page *page;
-	void *vaddr = NULL;
-
-	page = alloc_pages_node(node, gfp | __GFP_ZERO, 0);
-	if (page)
-		vaddr = page_address(page);
-	return vaddr;
-}
-
-void free_pgtable_page(void *vaddr)
-{
-	free_page((unsigned long)vaddr);
-}
-
 static int domain_type_is_si(struct dmar_domain *domain)
 {
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
@@ -545,7 +530,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 		if (!alloc)
 			return NULL;
 
-		context = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+		context = iommu_alloc_page_node(iommu->node, GFP_ATOMIC);
 		if (!context)
 			return NULL;
 
@@ -719,17 +704,17 @@ static void free_context_table(struct intel_iommu *iommu)
 	for (i = 0; i < ROOT_ENTRY_NR; i++) {
 		context = iommu_context_addr(iommu, i, 0, 0);
 		if (context)
-			free_pgtable_page(context);
+			iommu_free_page(context);
 
 		if (!sm_supported(iommu))
 			continue;
 
 		context = iommu_context_addr(iommu, i, 0x80, 0);
 		if (context)
-			free_pgtable_page(context);
+			iommu_free_page(context);
 	}
 
-	free_pgtable_page(iommu->root_entry);
+	iommu_free_page(iommu->root_entry);
 	iommu->root_entry = NULL;
 }
 
@@ -867,7 +852,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 		if (!dma_pte_present(pte)) {
 			uint64_t pteval;
 
-			tmp_page = alloc_pgtable_page(domain->nid, gfp);
+			tmp_page = iommu_alloc_page_node(domain->nid, gfp);
 
 			if (!tmp_page)
 				return NULL;
@@ -879,7 +864,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
-				free_pgtable_page(tmp_page);
+				iommu_free_page(tmp_page);
 			else
 				domain_flush_cache(domain, pte, sizeof(*pte));
 		}
@@ -992,7 +977,7 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 		      last_pfn < level_pfn + level_size(level) - 1)) {
 			dma_clear_pte(pte);
 			domain_flush_cache(domain, pte, sizeof(*pte));
-			free_pgtable_page(level_pte);
+			iommu_free_page(level_pte);
 		}
 next:
 		pfn += level_size(level);
@@ -1016,7 +1001,7 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 
 	/* free pgd */
 	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
-		free_pgtable_page(domain->pgd);
+		iommu_free_page(domain->pgd);
 		domain->pgd = NULL;
 	}
 }
@@ -1118,7 +1103,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
 	struct root_entry *root;
 
-	root = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
+	root = iommu_alloc_page_node(iommu->node, GFP_ATOMIC);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
 			iommu->name);
@@ -1841,7 +1826,7 @@ static void domain_exit(struct dmar_domain *domain)
 		LIST_HEAD(freelist);
 
 		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
-		put_pages_list(&freelist);
+		iommu_put_pages_list(&freelist);
 	}
 
 	if (WARN_ON(!list_empty(&domain->devices)))
@@ -2497,7 +2482,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			if (!old_ce)
 				goto out;
 
-			new_ce = alloc_pgtable_page(iommu->node, GFP_KERNEL);
+			new_ce = iommu_alloc_page_node(iommu->node, GFP_KERNEL);
 			if (!new_ce)
 				goto out_unmap;
 
@@ -3426,7 +3411,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 					start_vpfn, mhp->nr_pages,
 					list_empty(&freelist), 0);
 			rcu_read_unlock();
-			put_pages_list(&freelist);
+			iommu_put_pages_list(&freelist);
 		}
 		break;
 	}
@@ -3833,7 +3818,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	domain->max_addr = 0;
 
 	/* always allocate the top pgd */
-	domain->pgd = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
+	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_ATOMIC);
 	if (!domain->pgd)
 		return -ENOMEM;
 	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
@@ -3987,7 +3972,7 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 		pte = dmar_domain->pgd;
 		if (dma_pte_present(pte)) {
 			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
-			free_pgtable_page(pte);
+			iommu_free_page(pte);
 		}
 		dmar_domain->agaw--;
 	}
@@ -4141,7 +4126,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 	if (dmar_domain->nested_parent)
 		parent_domain_flush(dmar_domain, start_pfn, nrpages,
 				    list_empty(&gather->freelist));
-	put_pages_list(&gather->freelist);
+	iommu_put_pages_list(&gather->freelist);
 }
 
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 404d2476a877..8d081d8c6f41 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1085,8 +1085,6 @@ void domain_update_iommu_cap(struct dmar_domain *domain);
 
 int dmar_ir_support(void);
 
-void *alloc_pgtable_page(int node, gfp_t gfp);
-void free_pgtable_page(void *vaddr);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 566297bc87dd..39cd9626eb8d 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -22,6 +22,7 @@
 
 #include "iommu.h"
 #include "../irq_remapping.h"
+#include "../iommu-pages.h"
 #include "cap_audit.h"
 
 enum irq_mode {
@@ -527,7 +528,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	struct ir_table *ir_table;
 	struct fwnode_handle *fn;
 	unsigned long *bitmap;
-	struct page *pages;
+	void *ir_table_base;
 
 	if (iommu->ir_table)
 		return 0;
@@ -536,9 +537,9 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	if (!ir_table)
 		return -ENOMEM;
 
-	pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO,
-				 INTR_REMAP_PAGE_ORDER);
-	if (!pages) {
+	ir_table_base = iommu_alloc_pages_node(iommu->node, GFP_KERNEL,
+					       INTR_REMAP_PAGE_ORDER);
+	if (!ir_table_base) {
 		pr_err("IR%d: failed to allocate pages of order %d\n",
 		       iommu->seq_id, INTR_REMAP_PAGE_ORDER);
 		goto out_free_table;
@@ -573,7 +574,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	else
 		iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
-	ir_table->base = page_address(pages);
+	ir_table->base = ir_table_base;
 	ir_table->bitmap = bitmap;
 	iommu->ir_table = ir_table;
 
@@ -622,7 +623,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 out_free_bitmap:
 	bitmap_free(bitmap);
 out_free_pages:
-	__free_pages(pages, INTR_REMAP_PAGE_ORDER);
+	iommu_free_pages(ir_table_base, INTR_REMAP_PAGE_ORDER);
 out_free_table:
 	kfree(ir_table);
 
@@ -643,8 +644,7 @@ static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
 			irq_domain_free_fwnode(fn);
 			iommu->ir_domain = NULL;
 		}
-		free_pages((unsigned long)iommu->ir_table->base,
-			   INTR_REMAP_PAGE_ORDER);
+		iommu_free_pages(iommu->ir_table->base, INTR_REMAP_PAGE_ORDER);
 		bitmap_free(iommu->ir_table->bitmap);
 		kfree(iommu->ir_table);
 		iommu->ir_table = NULL;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 11f0b856d74c..abce19e2ad6f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -20,6 +20,7 @@
 
 #include "iommu.h"
 #include "pasid.h"
+#include "../iommu-pages.h"
 
 /*
  * Intel IOMMU system wide PASID name space:
@@ -38,7 +39,7 @@ int intel_pasid_alloc_table(struct device *dev)
 {
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
-	struct page *pages;
+	struct pasid_dir_entry *dir;
 	u32 max_pasid = 0;
 	int order, size;
 
@@ -59,14 +60,13 @@ int intel_pasid_alloc_table(struct device *dev)
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
 	order = size ? get_order(size) : 0;
-	pages = alloc_pages_node(info->iommu->node,
-				 GFP_KERNEL | __GFP_ZERO, order);
-	if (!pages) {
+	dir = iommu_alloc_pages_node(info->iommu->node, GFP_KERNEL, order);
+	if (!dir) {
 		kfree(pasid_table);
 		return -ENOMEM;
 	}
 
-	pasid_table->table = page_address(pages);
+	pasid_table->table = dir;
 	pasid_table->order = order;
 	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);
 	info->pasid_table = pasid_table;
@@ -97,10 +97,10 @@ void intel_pasid_free_table(struct device *dev)
 	max_pde = pasid_table->max_pasid >> PASID_PDE_SHIFT;
 	for (i = 0; i < max_pde; i++) {
 		table = get_pasid_table_from_pde(&dir[i]);
-		free_pgtable_page(table);
+		iommu_free_page(table);
 	}
 
-	free_pages((unsigned long)pasid_table->table, pasid_table->order);
+	iommu_free_pages(pasid_table->table, pasid_table->order);
 	kfree(pasid_table);
 }
 
@@ -146,7 +146,7 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 retry:
 	entries = get_pasid_table_from_pde(&dir[dir_index]);
 	if (!entries) {
-		entries = alloc_pgtable_page(info->iommu->node, GFP_ATOMIC);
+		entries = iommu_alloc_page_node(info->iommu->node, GFP_ATOMIC);
 		if (!entries)
 			return NULL;
 
@@ -158,7 +158,7 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 		 */
 		if (cmpxchg64(&dir[dir_index].val, 0ULL,
 			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
-			free_pgtable_page(entries);
+			iommu_free_page(entries);
 			goto retry;
 		}
 		if (!ecap_coherent(info->iommu->ecap)) {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ee3b469e2da1..71c1b2a0ca16 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -22,6 +22,7 @@
 #include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
+#include "../iommu-pages.h"
 #include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
@@ -63,16 +64,14 @@ svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct iopf_queue *iopfq;
-	struct page *pages;
 	int irq, ret;
 
-	pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
-	if (!pages) {
+	iommu->prq = iommu_alloc_pages_node(iommu->node, GFP_KERNEL, PRQ_ORDER);
+	if (!iommu->prq) {
 		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
 			iommu->name);
 		return -ENOMEM;
 	}
-	iommu->prq = page_address(pages);
 
 	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
 	if (irq <= 0) {
@@ -117,7 +116,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	dmar_free_hwirq(irq);
 	iommu->pr_irq = 0;
 free_prq:
-	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
 	iommu->prq = NULL;
 
 	return ret;
@@ -140,7 +139,7 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 		iommu->iopf_queue = NULL;
 	}
 
-	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
 	iommu->prq = NULL;
 
 	return 0;
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
new file mode 100644
index 000000000000..5a222d0ad25c
--- /dev/null
+++ b/drivers/iommu/iommu-pages.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef __IOMMU_PAGES_H
+#define __IOMMU_PAGES_H
+
+#include <linux/vmstat.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+
+/*
+ * All page allocations that should be reported to as "iommu-pagetables" to
+ * userspace must use one of the functions below.  This includes allocations of
+ * page-tables and other per-iommu_domain configuration structures.
+ *
+ * This is necessary for the proper accounting as IOMMU state can be rather
+ * large, i.e. multiple gigabytes in size.
+ */
+
+/**
+ * __iommu_alloc_pages - allocate a zeroed page of a given order.
+ * @gfp: buddy allocator flags
+ * @order: page order
+ *
+ * returns the head struct page of the allocated page.
+ */
+static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
+{
+	struct page *page;
+
+	page = alloc_pages(gfp | __GFP_ZERO, order);
+	if (unlikely(!page))
+		return NULL;
+
+	return page;
+}
+
+/**
+ * __iommu_free_pages - free page of a given order
+ * @page: head struct page of the page
+ * @order: page order
+ */
+static inline void __iommu_free_pages(struct page *page, int order)
+{
+	if (!page)
+		return;
+
+	__free_pages(page, order);
+}
+
+/**
+ * iommu_alloc_pages_node - allocate a zeroed page of a given order from
+ * specific NUMA node.
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ * @order: page order
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
+{
+	struct page *page = alloc_pages_node(nid, gfp | __GFP_ZERO, order);
+
+	if (unlikely(!page))
+		return NULL;
+
+	return page_address(page);
+}
+
+/**
+ * iommu_alloc_pages - allocate a zeroed page of a given order
+ * @gfp: buddy allocator flags
+ * @order: page order
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_pages(gfp_t gfp, int order)
+{
+	struct page *page = __iommu_alloc_pages(gfp, order);
+
+	if (unlikely(!page))
+		return NULL;
+
+	return page_address(page);
+}
+
+/**
+ * iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
+ * @nid: memory NUMA node id
+ * @gfp: buddy allocator flags
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
+{
+	return iommu_alloc_pages_node(nid, gfp, 0);
+}
+
+/**
+ * iommu_alloc_page - allocate a zeroed page
+ * @gfp: buddy allocator flags
+ *
+ * returns the virtual address of the allocated page
+ */
+static inline void *iommu_alloc_page(gfp_t gfp)
+{
+	return iommu_alloc_pages(gfp, 0);
+}
+
+/**
+ * iommu_free_pages - free page of a given order
+ * @virt: virtual address of the page to be freed.
+ * @order: page order
+ */
+static inline void iommu_free_pages(void *virt, int order)
+{
+	if (!virt)
+		return;
+
+	__iommu_free_pages(virt_to_page(virt), order);
+}
+
+/**
+ * iommu_free_page - free page
+ * @virt: virtual address of the page to be freed.
+ */
+static inline void iommu_free_page(void *virt)
+{
+	iommu_free_pages(virt, 0);
+}
+
+/**
+ * iommu_put_pages_list - free a list of pages.
+ * @page: the head of the lru list to be freed.
+ *
+ * There are no locking requirement for these pages, as they are going to be
+ * put on a free list as soon as refcount reaches 0. Pages are put on this LRU
+ * list once they are removed from the IOMMU page tables. However, they can
+ * still be access through debugfs.
+ */
+static inline void iommu_put_pages_list(struct list_head *page)
+{
+	while (!list_empty(page)) {
+		struct page *p = list_entry(page->prev, struct page, lru);
+
+		list_del(&p->lru);
+		put_page(p);
+	}
+}
+
+#endif	/* __IOMMU_PAGES_H */
-- 
2.44.0.683.g7961c838ac-goog


