Return-Path: <linux-fsdevel+bounces-16111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508D089871D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 14:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB51C2262D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118C2129E8D;
	Thu,  4 Apr 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fxrtnFAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C512A163;
	Thu,  4 Apr 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233077; cv=none; b=nmHQiXINi72c+mFwZebZ97Hovm5IAQAjwCytJD0k2pXRdqkATAMlR0rSvfc4ePWSY6H30/HqKMLwUFFLo3cP+rcWr2njxezTBgMqD3CBxj3qHyVt0+qn6LT9On3FtrOLfZCGDTLPlQNI5+3G3/GF/ET8snRJmdja+DHJ0o2UnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233077; c=relaxed/simple;
	bh=3wO5KYb4Jg3XvOszZEVnc9napAmW3+mYjTSGe8bQvEY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fhp12MPoA9tajdZjowH96/hUMWxhxAlmULQi7wyDDWfakZntgYJnt+uA35uGOdg6CUyflSVsB9oXC9+J6uwu+/7NZK60WO0gsVXChWlgO9q26o5zj+Gkm73gh7B4hfY4iS8YCWFkxbvVkrHJuBnrhpSN53BzDHaHGx9d+xDpEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fxrtnFAZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434A6eFr001681;
	Thu, 4 Apr 2024 05:16:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=WFNH2xqWyxV1VpCkW8vjvZ
	z0yWgDDXkQw2ZrEetuygg=; b=fxrtnFAZsRo3LBMg9SekQ8XXVsKvxh4ys+Gtxs
	7IrhPd+UqS5JjF/1Ub6DhFlH0oMyExmad9ElCxqajXghzvYSFib+hjlWLS4OcZXY
	wSnm3Cs55EEUBqcw2oq2p4vI9Wr9pfETFNUJtVmHsI6621SDNhBPyKSv9U4eefcx
	7I6zX6CowwxBhZ63KIWQqMFuJ2/Y00YU5RJVHhJPc4cMg2mDpGVyUEbQ2FlNBkTo
	RcuDqOanfEGSnx8+Fr3IxmZhqvaLtrowxakBZO8mInlYYICsI6B724skjI+Mo8b5
	n127RaqaMdnC1ryIw0qrbMIAeKpojpD2fs+t23znUNKHbUVA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em6j8b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 05:16:41 -0700 (PDT)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 434CGFI5029994;
	Thu, 4 Apr 2024 05:16:41 -0700
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x9em6j8b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 05:16:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 05:16:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 4 Apr 2024 05:16:40 -0700
Received: from hyd1403.caveonetworks.com (unknown [10.29.37.84])
	by maili.marvell.com (Postfix) with SMTP id 473A53F7071;
	Thu,  4 Apr 2024 05:16:26 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:46:25 +0530
From: Linu Cherian <lcherian@marvell.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
CC: <akpm@linux-foundation.org>, <alim.akhtar@samsung.com>,
        <alyssa@rosenzweig.io>, <asahi@lists.linux.dev>,
        <baolu.lu@linux.intel.com>, <bhelgaas@google.com>,
        <cgroups@vger.kernel.org>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw2@infradead.org>, <hannes@cmpxchg.org>, <heiko@sntech.de>,
        <iommu@lists.linux.dev>, <jernej.skrabec@gmail.com>,
        <jonathanh@nvidia.com>, <joro@8bytes.org>,
        <krzysztof.kozlowski@linaro.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-rockchip@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <linux-tegra@vger.kernel.org>, <lizefan.x@bytedance.com>,
        <marcan@marcan.st>, <mhiramat@kernel.org>, <m.szyprowski@samsung.com>,
        <paulmck@kernel.org>, <rdunlap@infradead.org>, <robin.murphy@arm.com>,
        <samuel@sholland.org>, <suravee.suthikulpanit@amd.com>,
        <sven@svenpeter.dev>, <thierry.reding@gmail.com>, <tj@kernel.org>,
        <tomas.mudrunka@gmail.com>, <vdumpa@nvidia.com>, <wens@csie.org>,
        <will@kernel.org>, <yu-cheng.yu@intel.com>, <rientjes@google.com>,
        <bagasdotme@gmail.com>, <mkoutny@suse.com>
Subject: Re: [PATCH v5 01/11] iommu/vt-d: add wrapper functions for page
 allocations
Message-ID: <20240404121625.GB102637@hyd1403.caveonetworks.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
 <20240222173942.1481394-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222173942.1481394-2-pasha.tatashin@soleen.com>
X-Proofpoint-ORIG-GUID: ml5ER6014kXSnT0Ebw1dOx2QJIXx5OyA
X-Proofpoint-GUID: 9OBRWJvB46jCkAc7cBBSeZFwPQdY4s0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_08,2024-04-04_01,2023-05-22_02

Hi Pasha,

On 2024-02-22 at 23:09:27, Pasha Tatashin (pasha.tatashin@soleen.com) wrote:
> In order to improve observability and accountability of IOMMU layer, we
> must account the number of pages that are allocated by functions that
> are calling directly into buddy allocator.
> 
> This is achieved by first wrapping the allocation related functions into a
> separate inline functions in new file:
> 
> drivers/iommu/iommu-pages.h
> 
> Convert all page allocation calls under iommu/intel to use these new
> functions.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/iommu/intel/dmar.c          |  16 +--
>  drivers/iommu/intel/iommu.c         |  47 +++------
>  drivers/iommu/intel/iommu.h         |   2 -
>  drivers/iommu/intel/irq_remapping.c |  16 +--
>  drivers/iommu/intel/pasid.c         |  18 ++--
>  drivers/iommu/intel/svm.c           |  11 +-
>  drivers/iommu/iommu-pages.h         | 154 ++++++++++++++++++++++++++++
>  7 files changed, 201 insertions(+), 63 deletions(-)
>  create mode 100644 drivers/iommu/iommu-pages.h


Few minor nits.

> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23cb80d62a9a..ff6045ae8e97 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -32,6 +32,7 @@
>  
>  #include "iommu.h"
>  #include "../irq_remapping.h"
> +#include "../iommu-pages.h"
>  #include "perf.h"
>  #include "trace.h"
>  #include "perfmon.h"
> @@ -1185,7 +1186,7 @@ static void free_iommu(struct intel_iommu *iommu)
>  	}
>  
>  	if (iommu->qi) {
> -		free_page((unsigned long)iommu->qi->desc);
> +		iommu_free_page(iommu->qi->desc);
>  		kfree(iommu->qi->desc_status);
>  		kfree(iommu->qi);
>  	}
> @@ -1731,7 +1732,8 @@ static void __dmar_enable_qi(struct intel_iommu *iommu)
>  int dmar_enable_qi(struct intel_iommu *iommu)
>  {
>  	struct q_inval *qi;
> -	struct page *desc_page;
> +	void *desc;
> +	int order;
>  
>  	if (!ecap_qis(iommu->ecap))
>  		return -ENOENT;
> @@ -1752,19 +1754,19 @@ int dmar_enable_qi(struct intel_iommu *iommu)
>  	 * Need two pages to accommodate 256 descriptors of 256 bits each
>  	 * if the remapping hardware supports scalable mode translation.
>  	 */
> -	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
> -				     !!ecap_smts(iommu->ecap));
> -	if (!desc_page) {
> +	order = ecap_smts(iommu->ecap) ? 1 : 0;
> +	desc = iommu_alloc_pages_node(iommu->node, GFP_ATOMIC, order);
> +	if (!desc) {
>  		kfree(qi);
>  		iommu->qi = NULL;
>  		return -ENOMEM;
>  	}
>  
> -	qi->desc = page_address(desc_page);
> +	qi->desc = desc;
>  
>  	qi->desc_status = kcalloc(QI_LENGTH, sizeof(int), GFP_ATOMIC);
>  	if (!qi->desc_status) {
> -		free_page((unsigned long) qi->desc);
> +		iommu_free_page(qi->desc);
>  		kfree(qi);
>  		iommu->qi = NULL;
>  		return -ENOMEM;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6fb5f6fceea1..2c676f46e38c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -28,6 +28,7 @@
>  #include "../dma-iommu.h"
>  #include "../irq_remapping.h"
>  #include "../iommu-sva.h"
> +#include "../iommu-pages.h"
>  #include "pasid.h"
>  #include "cap_audit.h"
>  #include "perfmon.h"
> @@ -224,22 +225,6 @@ static int __init intel_iommu_setup(char *str)
>  }
>  __setup("intel_iommu=", intel_iommu_setup);
>  
> -void *alloc_pgtable_page(int node, gfp_t gfp)
> -{
> -	struct page *page;
> -	void *vaddr = NULL;
> -
> -	page = alloc_pages_node(node, gfp | __GFP_ZERO, 0);
> -	if (page)
> -		vaddr = page_address(page);
> -	return vaddr;
> -}
> -
> -void free_pgtable_page(void *vaddr)
> -{
> -	free_page((unsigned long)vaddr);
> -}
> -
>  static int domain_type_is_si(struct dmar_domain *domain)
>  {
>  	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
> @@ -473,7 +458,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>  		if (!alloc)
>  			return NULL;
>  
> -		context = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
> +		context = iommu_alloc_page_node(iommu->node, GFP_ATOMIC);
>  		if (!context)
>  			return NULL;
>  
> @@ -647,17 +632,17 @@ static void free_context_table(struct intel_iommu *iommu)
>  	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>  		context = iommu_context_addr(iommu, i, 0, 0);
>  		if (context)
> -			free_pgtable_page(context);
> +			iommu_free_page(context);
>  
>  		if (!sm_supported(iommu))
>  			continue;
>  
>  		context = iommu_context_addr(iommu, i, 0x80, 0);
>  		if (context)
> -			free_pgtable_page(context);
> +			iommu_free_page(context);
>  	}
>  
> -	free_pgtable_page(iommu->root_entry);
> +	iommu_free_page(iommu->root_entry);
>  	iommu->root_entry = NULL;
>  }
>  
> @@ -795,7 +780,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>  		if (!dma_pte_present(pte)) {
>  			uint64_t pteval;
>  
> -			tmp_page = alloc_pgtable_page(domain->nid, gfp);
> +			tmp_page = iommu_alloc_page_node(domain->nid, gfp);
>  
>  			if (!tmp_page)
>  				return NULL;
> @@ -807,7 +792,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>  
>  			if (cmpxchg64(&pte->val, 0ULL, pteval))
>  				/* Someone else set it while we were thinking; use theirs. */
> -				free_pgtable_page(tmp_page);
> +				iommu_free_page(tmp_page);
>  			else
>  				domain_flush_cache(domain, pte, sizeof(*pte));
>  		}
> @@ -920,7 +905,7 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
>  		      last_pfn < level_pfn + level_size(level) - 1)) {
>  			dma_clear_pte(pte);
>  			domain_flush_cache(domain, pte, sizeof(*pte));
> -			free_pgtable_page(level_pte);
> +			iommu_free_page(level_pte);
>  		}
>  next:
>  		pfn += level_size(level);
> @@ -944,7 +929,7 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
>  
>  	/* free pgd */
>  	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
> -		free_pgtable_page(domain->pgd);
> +		iommu_free_page(domain->pgd);
>  		domain->pgd = NULL;
>  	}
>  }
> @@ -1046,7 +1031,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
>  {
>  	struct root_entry *root;
>  
> -	root = alloc_pgtable_page(iommu->node, GFP_ATOMIC);
> +	root = iommu_alloc_page_node(iommu->node, GFP_ATOMIC);
>  	if (!root) {
>  		pr_err("Allocating root entry for %s failed\n",
>  			iommu->name);
> @@ -1718,7 +1703,7 @@ static void domain_exit(struct dmar_domain *domain)
>  		LIST_HEAD(freelist);
>  
>  		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
> -		put_pages_list(&freelist);
> +		iommu_put_pages_list(&freelist);
>  	}
>  
>  	if (WARN_ON(!list_empty(&domain->devices)))
> @@ -2452,7 +2437,7 @@ static int copy_context_table(struct intel_iommu *iommu,
>  			if (!old_ce)
>  				goto out;
>  
> -			new_ce = alloc_pgtable_page(iommu->node, GFP_KERNEL);
> +			new_ce = iommu_alloc_page_node(iommu->node, GFP_KERNEL);
>  			if (!new_ce)
>  				goto out_unmap;
>  
> @@ -3385,7 +3370,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
>  					start_vpfn, mhp->nr_pages,
>  					list_empty(&freelist), 0);
>  			rcu_read_unlock();
> -			put_pages_list(&freelist);
> +			iommu_put_pages_list(&freelist);
>  		}
>  		break;
>  	}
> @@ -3816,7 +3801,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
>  	domain->max_addr = 0;
>  
>  	/* always allocate the top pgd */
> -	domain->pgd = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
> +	domain->pgd = iommu_alloc_page_node(domain->nid, GFP_ATOMIC);
>  	if (!domain->pgd)
>  		return -ENOMEM;
>  	domain_flush_cache(domain, domain->pgd, PAGE_SIZE);
> @@ -3960,7 +3945,7 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
>  		pte = dmar_domain->pgd;
>  		if (dma_pte_present(pte)) {
>  			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
> -			free_pgtable_page(pte);
> +			iommu_free_page(pte);
>  		}
>  		dmar_domain->agaw--;
>  	}
> @@ -4107,7 +4092,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
>  				      start_pfn, nrpages,
>  				      list_empty(&gather->freelist), 0);
>  
> -	put_pages_list(&gather->freelist);
> +	iommu_put_pages_list(&gather->freelist);
>  }
>  
>  static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index d02f916d8e59..9fe04cea29c4 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1069,8 +1069,6 @@ void domain_update_iommu_cap(struct dmar_domain *domain);
>  
>  int dmar_ir_support(void);
>  
> -void *alloc_pgtable_page(int node, gfp_t gfp);
> -void free_pgtable_page(void *vaddr);
>  void iommu_flush_write_buffer(struct intel_iommu *iommu);
>  struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>  					       const struct iommu_user_data *user_data);
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 566297bc87dd..39cd9626eb8d 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -22,6 +22,7 @@
>  
>  #include "iommu.h"
>  #include "../irq_remapping.h"
> +#include "../iommu-pages.h"
>  #include "cap_audit.h"
>  
>  enum irq_mode {
> @@ -527,7 +528,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
>  	struct ir_table *ir_table;
>  	struct fwnode_handle *fn;
>  	unsigned long *bitmap;
> -	struct page *pages;
> +	void *ir_table_base;
>  
>  	if (iommu->ir_table)
>  		return 0;
> @@ -536,9 +537,9 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
>  	if (!ir_table)
>  		return -ENOMEM;
>  
> -	pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO,
> -				 INTR_REMAP_PAGE_ORDER);
> -	if (!pages) {
> +	ir_table_base = iommu_alloc_pages_node(iommu->node, GFP_KERNEL,
> +					       INTR_REMAP_PAGE_ORDER);
> +	if (!ir_table_base) {
>  		pr_err("IR%d: failed to allocate pages of order %d\n",
>  		       iommu->seq_id, INTR_REMAP_PAGE_ORDER);
>  		goto out_free_table;
> @@ -573,7 +574,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
>  	else
>  		iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
>  
> -	ir_table->base = page_address(pages);
> +	ir_table->base = ir_table_base;
>  	ir_table->bitmap = bitmap;
>  	iommu->ir_table = ir_table;
>  
> @@ -622,7 +623,7 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
>  out_free_bitmap:
>  	bitmap_free(bitmap);
>  out_free_pages:
> -	__free_pages(pages, INTR_REMAP_PAGE_ORDER);
> +	iommu_free_pages(ir_table_base, INTR_REMAP_PAGE_ORDER);
>  out_free_table:
>  	kfree(ir_table);
>  
> @@ -643,8 +644,7 @@ static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
>  			irq_domain_free_fwnode(fn);
>  			iommu->ir_domain = NULL;
>  		}
> -		free_pages((unsigned long)iommu->ir_table->base,
> -			   INTR_REMAP_PAGE_ORDER);
> +		iommu_free_pages(iommu->ir_table->base, INTR_REMAP_PAGE_ORDER);
>  		bitmap_free(iommu->ir_table->bitmap);
>  		kfree(iommu->ir_table);
>  		iommu->ir_table = NULL;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3239cefa4c33..d46f661dd971 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -20,6 +20,7 @@
>  
>  #include "iommu.h"
>  #include "pasid.h"
> +#include "../iommu-pages.h"
>  
>  /*
>   * Intel IOMMU system wide PASID name space:
> @@ -38,7 +39,7 @@ int intel_pasid_alloc_table(struct device *dev)
>  {
>  	struct device_domain_info *info;
>  	struct pasid_table *pasid_table;
> -	struct page *pages;
> +	struct pasid_dir_entry *dir;
>  	u32 max_pasid = 0;
>  	int order, size;
>  
> @@ -59,14 +60,13 @@ int intel_pasid_alloc_table(struct device *dev)
>  
>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>  	order = size ? get_order(size) : 0;
> -	pages = alloc_pages_node(info->iommu->node,
> -				 GFP_KERNEL | __GFP_ZERO, order);
> -	if (!pages) {
> +	dir = iommu_alloc_pages_node(info->iommu->node, GFP_KERNEL, order);
> +	if (!dir) {
>  		kfree(pasid_table);
>  		return -ENOMEM;
>  	}
>  
> -	pasid_table->table = page_address(pages);
> +	pasid_table->table = dir;
>  	pasid_table->order = order;
>  	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);
>  	info->pasid_table = pasid_table;
> @@ -97,10 +97,10 @@ void intel_pasid_free_table(struct device *dev)
>  	max_pde = pasid_table->max_pasid >> PASID_PDE_SHIFT;
>  	for (i = 0; i < max_pde; i++) {
>  		table = get_pasid_table_from_pde(&dir[i]);
> -		free_pgtable_page(table);
> +		iommu_free_page(table);
>  	}
>  
> -	free_pages((unsigned long)pasid_table->table, pasid_table->order);
> +	iommu_free_pages(pasid_table->table, pasid_table->order);
>  	kfree(pasid_table);
>  }
>  
> @@ -146,7 +146,7 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>  retry:
>  	entries = get_pasid_table_from_pde(&dir[dir_index]);
>  	if (!entries) {
> -		entries = alloc_pgtable_page(info->iommu->node, GFP_ATOMIC);
> +		entries = iommu_alloc_page_node(info->iommu->node, GFP_ATOMIC);
>  		if (!entries)
>  			return NULL;
>  
> @@ -158,7 +158,7 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>  		 */
>  		if (cmpxchg64(&dir[dir_index].val, 0ULL,
>  			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
> -			free_pgtable_page(entries);
> +			iommu_free_page(entries);
>  			goto retry;
>  		}
>  		if (!ecap_coherent(info->iommu->ecap)) {
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 40edd282903f..a691f917456c 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -23,6 +23,7 @@
>  #include "pasid.h"
>  #include "perf.h"
>  #include "../iommu-sva.h"
> +#include "../iommu-pages.h"
>  #include "trace.h"
>  
>  static irqreturn_t prq_event_thread(int irq, void *d);
> @@ -64,16 +65,14 @@ svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
>  int intel_svm_enable_prq(struct intel_iommu *iommu)
>  {
>  	struct iopf_queue *iopfq;
> -	struct page *pages;
>  	int irq, ret;
>  
> -	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
> -	if (!pages) {
> +	iommu->prq = iommu_alloc_pages(GFP_KERNEL, PRQ_ORDER);
> +	if (!iommu->prq) {
>  		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
>  			iommu->name);
>  		return -ENOMEM;
>  	}
> -	iommu->prq = page_address(pages);
>  
>  	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
>  	if (irq <= 0) {
> @@ -118,7 +117,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
>  	dmar_free_hwirq(irq);
>  	iommu->pr_irq = 0;
>  free_prq:
> -	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
> +	iommu_free_pages(iommu->prq, PRQ_ORDER);
>  	iommu->prq = NULL;
>  
>  	return ret;
> @@ -141,7 +140,7 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
>  		iommu->iopf_queue = NULL;
>  	}
>  
> -	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
> +	iommu_free_pages(iommu->prq, PRQ_ORDER);
>  	iommu->prq = NULL;
>  
>  	return 0;
> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> new file mode 100644
> index 000000000000..35bfa369b134
> --- /dev/null
> +++ b/drivers/iommu/iommu-pages.h
> @@ -0,0 +1,154 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +
> +#ifndef __IOMMU_PAGES_H
> +#define __IOMMU_PAGES_H
> +
> +#include <linux/vmstat.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +
> +/*
> + * All page allocations that should be reported to as "iommu-pagetables" to
> + * userspace must use on of the functions below.  This includes allocations of
> + * page-tables and other per-iommu_domain configuration structures.

/s/use on/use one/?

> + *
> + * This is necessary for the proper accounting as IOMMU state can be rather
> + * large, i.e. multiple gigabytes in size.
> + */
> +
> +/**
> + * __iommu_alloc_pages - allocate a zeroed page of a given order.
> + * @gfp: buddy allocator flags

Shall we keep the comments generic here(avoid reference to allocator
algo)  ?

> + * @order: page order
> + *
> + * returns the head struct page of the allocated page.
> + */
> +static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> +{
> +	struct page *page;
> +
> +	page = alloc_pages(gfp | __GFP_ZERO, order);
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	return page;
> +}
> +
> +/**
> + * __iommu_free_pages - free page of a given order
> + * @page: head struct page of the page
> + * @order: page order
> + */
> +static inline void __iommu_free_pages(struct page *page, int order)
> +{
> +	if (!page)
> +		return;
> +
> +	__free_pages(page, order);
> +}
> +
> +/**
> + * iommu_alloc_pages_node - allocate a zeroed page of a given order from
> + * specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags

Same here for this one and other references below.

> + * @order: page order
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
> +{
> +	struct page *page = alloc_pages_node(nid, gfp | __GFP_ZERO, order);
> +
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	return page_address(page);
> +}
> +
> +/**
> + * iommu_alloc_pages - allocate a zeroed page of a given order
> + * @gfp: buddy allocator flags
> + * @order: page order
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_pages(gfp_t gfp, int order)
> +{
> +	struct page *page = __iommu_alloc_pages(gfp, order);
> +
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	return page_address(page);
> +}
> +
> +/**
> + * iommu_alloc_page_node - allocate a zeroed page at specific NUMA node.
> + * @nid: memory NUMA node id
> + * @gfp: buddy allocator flags
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
> +{
> +	return iommu_alloc_pages_node(nid, gfp, 0);
> +}
> +
> +/**
> + * iommu_alloc_page - allocate a zeroed page
> + * @gfp: buddy allocator flags
> + *
> + * returns the virtual address of the allocated page
> + */
> +static inline void *iommu_alloc_page(gfp_t gfp)
> +{
> +	return iommu_alloc_pages(gfp, 0);
> +}
> +
> +/**
> + * iommu_free_pages - free page of a given order
> + * @virt: virtual address of the page to be freed.
> + * @order: page order
> + */
> +static inline void iommu_free_pages(void *virt, int order)
> +{
> +	if (!virt)
> +		return;
> +
> +	__iommu_free_pages(virt_to_page(virt), order);
> +}
> +
> +/**
> + * iommu_free_page - free page
> + * @virt: virtual address of the page to be freed.
> + */
> +static inline void iommu_free_page(void *virt)
> +{
> +	iommu_free_pages(virt, 0);
> +}
> +
> +/**
> + * iommu_put_pages_list - free a list of pages.
> + * @page: the head of the lru list to be freed.
> + *
> + * There are no locking requirement for these pages, as they are going to be
> + * put on a free list as soon as refcount reaches 0. Pages are put on this LRU
> + * list once they are removed from the IOMMU page tables. However, they can
> + * still be access through debugfs.
> + */
> +static inline void iommu_put_pages_list(struct list_head *page)
> +{
> +	while (!list_empty(page)) {
> +		struct page *p = list_entry(page->prev, struct page, lru);
> +
> +		list_del(&p->lru);
> +		put_page(p);
> +	}
> +}
> +
> +#endif	/* __IOMMU_PAGES_H */
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

