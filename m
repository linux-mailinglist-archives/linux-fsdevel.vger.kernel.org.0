Return-Path: <linux-fsdevel+bounces-22596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC86919E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 07:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571CFB2210B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 05:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B91CFB9;
	Thu, 27 Jun 2024 05:31:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB331799D;
	Thu, 27 Jun 2024 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466268; cv=none; b=kbUzNIY//uecM262qdxx4iABTXZvKIE157KfnKNkdoDRAsCzQRq10T/bJAOJpt92ERiku6axW7TKdeEBVPqFrWWBLjDNQb6GMl6uHbFL4xeIlHxxWgP8LDZw2fHxl5s7hyDbZnsAYknVqwiN35hIEzYhINPH/G1Cgi0+VkuoYb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466268; c=relaxed/simple;
	bh=7/T+ZFgsryO4b5FVi1kOhQcQrGU98uElwA4aOnC32Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wrp+ApYYAn7CViB8U8LcB456xsoxVU521EarDYVOZtSWglmBQ/9YKCCHypG6zJXHlab5Rv4JRnKZbeqOvWLN7hIzgfIqX5ppVFgHxxxyqkTxMNUYBrSjCALOK9tuTCB8HpZd1734+QMjDJC3E0QQ9HjE1Z6a7nrgFR83pqAujd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9748A68AFE; Thu, 27 Jun 2024 07:30:59 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:30:59 +0200
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
Subject: Re: [PATCH 02/13] pci/p2pdma: Don't initialise page refcount to one
Message-ID: <20240627053059.GB14837@lst.de>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com> <c66cc5c5142813049ffdf9af75302f5064048241.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66cc5c5142813049ffdf9af75302f5064048241.1719386613.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 10:54:17AM +1000, Alistair Popple wrote:
> The reference counts for ZONE_DEVICE private pages should be
> initialised by the driver when the page is actually allocated by the
> driver allocator, not when they are first created. This is currently
> the case for MEMORY_DEVICE_PRIVATE and MEMORY_DEVICE_COHERENT pages
> but not MEMORY_DEVICE_PCI_P2PDMA pages so fix that up.
> 
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

Can we have a comment here?  Without that it feels a bit too much like
black magic when reading the code.

> +	if (folio->page.pgmap->type == MEMORY_DEVICE_PRIVATE ||
> +	    folio->page.pgmap->type == MEMORY_DEVICE_COHERENT)
> +		put_dev_pagemap(folio->page.pgmap);
> +	else if (folio->page.pgmap->type != MEMORY_DEVICE_PCI_P2PDMA)
>  		/*
>  		 * Reset the refcount to 1 to prepare for handing out the page
>  		 * again.
>  		 */
>  		folio_set_count(folio, 1);

Where the else if evaluates to MEMORY_DEVICE_FS_DAX ||
MEMORY_DEVICE_GENERIC.  Maybe make this a switch statement handling
all cases of the enum to make it clear and have the compiler generate
a warning when a new type is added without being handled here?

> @@ -1014,7 +1015,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	 * which will set the page count to 1 when allocating the page.
>  	 */
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
> +	    pgmap->type == MEMORY_DEVICE_COHERENT ||
> +	    pgmap->type == MEMORY_DEVICE_PCI_P2PDMA)
>  		set_page_count(page, 0);

Similarly here a switch with explanation of what will be handled and
what not would be nice.


