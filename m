Return-Path: <linux-fsdevel+bounces-28998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E80972891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4AF1C2390C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA1A16ABC6;
	Tue, 10 Sep 2024 04:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LCK1EnCF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4013AA32;
	Tue, 10 Sep 2024 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943694; cv=none; b=Gly0Lan2Srj+DPVFpfO5pqZ+GChzy42o9M3eQP4VRtB09m+MXKjlAWKDqGK3Jw0ZB/zPYS6DOL4NuRPImBMVdB6d9anY9YhHXGd/fUcVE7xv1zfdJtfYR9GVHilRtNBrwGlQDCBduODBFnjZZn6sf0O7Ig5Ay8KniTpOHvvIT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943694; c=relaxed/simple;
	bh=Lqpkkyp7wuRuCbghjDbuUpHEMw+hIua6js1Gbi52msE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8z8RxJ4bfRoZ6VhRwDhid8O6ECsTJgpJ1UYbkyiqioUixukqNrsx7o/5M3Qpn5wojDP83+AFQ393cRJzzQeKurwe6cSj2YnHAU1wyGc4TX7pk7IfYLurfBJOIPGqBk9YkduneZCs03Fd0BBNpNGj1kEbzOeeGk/2uX4i5RNjYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LCK1EnCF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c0/KMxGI62d39aIfqydXbjcfGL/DQ5/n5haroblqj80=; b=LCK1EnCFN8sE7ipvGAc8UQ2cYA
	x0qquDQQJXVrrzzdKi4N4M+3xPY367t9udRzgrjwbuaaV/t/EOPA18CtPCtGpeg5g2S6mq9UPTVMY
	qOorwFK7L+qbEqWzmGd/ADQLtdWzdM2yuTGiVya3mW7Rp1LoTyT26SLecZAa3jYEcBVscKOsE6wjS
	3fh454fYf5iaCmgBbCxWSvcTMiKeJDd3OLFSSuDCieAc/LX0nhmzj4323V7hPCPHpQUcm57lRkjir
	ysN1fMLF0KDjVx20FCu9CZ7wGsfxPB18U67jSno24eKa7XBE1NVWnSD08C0xQoywBYznZ7D5X/VkY
	OG0n4GAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snsmy-000000050uo-2esU;
	Tue, 10 Sep 2024 04:47:40 +0000
Date: Tue, 10 Sep 2024 05:47:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, vishal.l.verma@intel.com,
	dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
	jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
	will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ira.weiny@intel.com, djwong@kernel.org,
	tytso@mit.edu, linmiaohe@huawei.com, david@redhat.com,
	peterx@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 04/12] mm: Allow compound zone device pages
Message-ID: <Zt_PbIADa4baLEBw@casper.infradead.org>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>

On Tue, Sep 10, 2024 at 02:14:29PM +1000, Alistair Popple wrote:
> @@ -337,6 +341,7 @@ struct folio {
>  	/* private: */
>  				};
>  	/* public: */
> +			struct dev_pagemap *pgmap;

Shouldn't that be indented by one more tab stop?

And for ease of reading, perhaps it should be placed either immediately
before or after 'struct list_head lru;'?

> +++ b/include/linux/mmzone.h
> @@ -1134,6 +1134,12 @@ static inline bool is_zone_device_page(const struct page *page)
>  	return page_zonenum(page) == ZONE_DEVICE;
>  }
>  
> +static inline struct dev_pagemap *page_dev_pagemap(const struct page *page)
> +{
> +	WARN_ON(!is_zone_device_page(page));
> +	return page_folio(page)->pgmap;
> +}

I haven't read to the end yet, but presumably we'll eventually want:

static inline struct dev_pagemap *folio_dev_pagemap(const struct folio *folio)
{
	WARN_ON(!folio_is_zone_device(folio))
	return folio->pgmap;
}

and since we'll want it eventually, maybe now is the time to add it,
and make page_dev_pagemap() simply call it?


