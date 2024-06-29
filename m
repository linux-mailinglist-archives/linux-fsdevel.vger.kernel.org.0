Return-Path: <linux-fsdevel+bounces-22823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A4A91CF31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 23:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528921C20C15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741761422DC;
	Sat, 29 Jun 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnqFJx5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FE374FA;
	Sat, 29 Jun 2024 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719696533; cv=none; b=ZmmPN+DDth5AUs+dVA3Zy1q67VoTFIY6mqLgXd4HHgCf9QwTljhM2adx2t7uPxdkhpYtnUWkdtHxKWWaFrOykx9JocDNXDjfMO6yC+iLsXuFghAbFrIPrwa36gjMkhFPB0PLk1d6FneoxAVHahetaID1BAG+DVaoUWzZv2MbOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719696533; c=relaxed/simple;
	bh=HtXt70x632jQVkvZVa5+viDAiEo/vLpbpyG46HWBjMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=moRBVwhoy0/uBa4JVJZd8I9XbLatM31IwIrc27PcHBuyN3hDwIKJRgCQOLAhonAiTxO+IGqEjh9svFvk5m+cm64fLp1Xs971OLHI74lRWhy8YNv3UwfdSqLx1dmTK5eCOH1hkxTUgvb/9cRo0KxeiOhfuAfqHip7Xn5Tss+jTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnqFJx5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CE9C2BBFC;
	Sat, 29 Jun 2024 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719696533;
	bh=HtXt70x632jQVkvZVa5+viDAiEo/vLpbpyG46HWBjMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VnqFJx5ghuBk4Ih3CVJjWYCN0/ZeQE4bA9dgueRtqlOBnEj9bpHIblRRQS9pvQOq9
	 e1eHFjHr5+rNv2dGIMrkk3IAZlqwsKX7p+rD1r1vmjoqPl5r2aEZGCjwsQpiy3/x6B
	 ysyxPdOQzeo0ZX9VEzv6T9NJsfU8dcWOxpkFNYAWzY/LBU0zuLZ2xf3++9jGcptCb1
	 Xp8Voz7uHR8O3pq3w/ncYUPGbyyGG5MBfyicJ+oqDiGO1BzaG9nKTI9pT87K9/QPad
	 WGmS2gB4YANsUc/hqolrWiMuZCznLg98Ov/R1hZ8gbO540njo89EbUIDosTqYlZeua
	 vy2FDJBTYP9+A==
Date: Sat, 29 Jun 2024 16:28:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH 02/13] pci/p2pdma: Don't initialise page refcount to one
Message-ID: <20240629212851.GA1484889@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66cc5c5142813049ffdf9af75302f5064048241.1719386613.git-series.apopple@nvidia.com>

On Thu, Jun 27, 2024 at 10:54:17AM +1000, Alistair Popple wrote:
> The reference counts for ZONE_DEVICE private pages should be
> initialised by the driver when the page is actually allocated by the
> driver allocator, not when they are first created. This is currently
> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.

If you tag the subject line with PCI, please run "git log --oneline
drivers/pci/p2pdma.c" and make yours look like previous ones
("PCI/P2PDMA").

Also recast it to say something semantically useful about what it
*does*, not what it *doesn't* do.  Maybe something about initializing
the refcount where the page is allocated?  Especially since the only
p2pdma.c change here is to "set_page_count(..., 1)", which looks like
exactly the opposite of "don't initialize refcount to one".

> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  drivers/pci/p2pdma.c | 2 ++
>  mm/memremap.c        | 8 ++++----
>  mm/mm_init.c         | 4 +++-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4f47a13..1e9ea32 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -128,6 +128,8 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		goto out;
>  	}
>  
> +	set_page_count(virt_to_page(kaddr), 1);
> +
>  	/*
>  	 * vm_insert_page() can sleep, so a reference is taken to mapping
>  	 * such that rcu_read_unlock() can be done before inserting the
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 40d4547..caccbd8 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -488,15 +488,15 @@ void free_zone_device_folio(struct folio *folio)
>  	folio->mapping = NULL;
>  	folio->page.pgmap->ops->page_free(folio_page(folio, 0));
>  
> -	if (folio->page.pgmap->type != MEMORY_DEVICE_PRIVATE &&
> -	    folio->page.pgmap->type != MEMORY_DEVICE_COHERENT)
> +	if (folio->page.pgmap->type == MEMORY_DEVICE_PRIVATE ||
> +	    folio->page.pgmap->type == MEMORY_DEVICE_COHERENT)
> +		put_dev_pagemap(folio->page.pgmap);
> +	else if (folio->page.pgmap->type != MEMORY_DEVICE_PCI_P2PDMA)
>  		/*
>  		 * Reset the refcount to 1 to prepare for handing out the page
>  		 * again.
>  		 */
>  		folio_set_count(folio, 1);
> -	else
> -		put_dev_pagemap(folio->page.pgmap);
>  }
>  
>  void zone_device_page_init(struct page *page)
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3ec0493..b7e1599 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -6,6 +6,7 @@
>   * Author Mel Gorman <mel@csn.ul.ie>
>   *
>   */
> +#include "linux/memremap.h"
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/kobject.h>
> @@ -1014,7 +1015,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	 * which will set the page count to 1 when allocating the page.
>  	 */
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
> -	    pgmap->type == MEMORY_DEVICE_COHERENT)
> +	    pgmap->type == MEMORY_DEVICE_COHERENT ||
> +	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
>  		set_page_count(page, 0);
>  }
>  
> -- 
> git-series 0.9.1

