Return-Path: <linux-fsdevel+bounces-22600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E291E919EE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 07:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922911F253CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6928DCC;
	Thu, 27 Jun 2024 05:45:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F471CD31;
	Thu, 27 Jun 2024 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467102; cv=none; b=bSQbi/F3e2XhKCQRPPaMQcM1qgMo17Vv9c5Q/55st5i2YWIVPwpiLEjJCQwDup/elABmxGXOWtNAt06UEWe/XieQ4PIWaAL28OyqTj16Y00v8MAzql84PRJOM0nCc7doxYSJOsBb6qnTeHbmynwaUZP/Ivix3BWuEe4NrZ1BOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467102; c=relaxed/simple;
	bh=LP3kdRmSdGwbopkqhn7jCAhhTd3gb5/rE7WfLoYZXzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BogB6+cSjpfAbTA3rcqiwvDPaMf3fsOaSdocX4V4Dsgym/veEB9tbFGIQIyyiXiSrC/A2RRFouy/jmncxE+pdRhoslr5pYTOUjsiwLW1Y9Xx4NmDt1EdtakOKN+NrzeLIB3qCfpjLXpNoXkQ87DnsPKmg5ItqyUegOQrXCutkVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70CDD68AFE; Thu, 27 Jun 2024 07:44:55 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:44:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
	linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com
Subject: Re: [PATCH 10/13] fs/dax: Properly refcount fs dax pages
Message-ID: <20240627054455.GF14837@lst.de>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com> <afcfa4f164e5642c4f629c75acf794838c2ac9aa.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcfa4f164e5642c4f629c75acf794838c2ac9aa.1719386613.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index eb61598..b7a31ae 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -126,11 +126,11 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
>  		return VM_FAULT_SIGBUS;
>  	}
>  
> -	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
> +	pfn = phys_to_pfn_t(phys, 0);
>  
>  	dax_set_mapping(vmf, pfn, fault_size);
>  
> -	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
> +	return dax_insert_pfn(vmf->vma, vmf->address, pfn, vmf->flags & FAULT_FLAG_WRITE);

Plenty overly long lines here and later.

Q: hould dax_insert_pfn take a vm_fault structure instead of the vma?
Or are the potential use cases that aren't from the fault path?
similar instead of the bool write passing the fault flags might actually
make things more readable than the bool.

Also at least currently it seems like there are no modular users despite
the export, or am I missing something?

> +		blk_queue_flag_set(QUEUE_FLAG_DAX, q);

Just as a heads up, setting of these flags has changed a lot in
linux-next.

>  {
> +	/*
> +	 * Make sure we flush any cached data to the page now that it's free.
> +	 */
> +	if (PageDirty(page))
> +		dax_flush(NULL, page_address(page), page_size(page));
> +

Adding the magic dax_dev == NULL case to dax_flush and going through it
vs just calling arch_wb_cache_pmem directly here seems odd.

But I also don't quite understand how it is related to the rest
of the patch anyway.

> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -373,6 +373,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
>  	unsigned long start = addr;
>  
>  	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (vma_is_dax(vma))
> +		ptl = NULL;
>  	if (ptl) {

This feels sufficiently magic to warrant a comment.

>  		if (!pmd_present(*pmd))
>  			goto out;
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index b7e1599..f11ee0d 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1016,7 +1016,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	 */
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
>  	    pgmap->type == MEMORY_DEVICE_COHERENT ||
> -	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
> +	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA ||
> +	    pgmap->type == MEMORY_DEVICE_FS_DAX)
>  		set_page_count(page, 0);
>  }

So we'll skip this for MEMORY_DEVICE_GENERIC only.  Does anyone remember
if that's actively harmful or just not needed?  If the latter it might
be simpler to just set the page count unconditionally here.


