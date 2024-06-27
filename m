Return-Path: <linux-fsdevel+bounces-22595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A886919E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 07:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC412834CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 05:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5BC1CD35;
	Thu, 27 Jun 2024 05:23:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F1A1B94F;
	Thu, 27 Jun 2024 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719465787; cv=none; b=b1ZWFGnUxPkRsfvVkTNxmTCeDBfHvUG95qNgIRVTk9pW5Hz1DRMCVvN625p5IoOl8qNTsaiegWQ9LSPbluIsjqItlhyeMaGIpsNAIZC+AGFQ81gelL58OohJTivsaNBTah0oWCGj9VcnEsONx8aT2KoEcN5DcdFc9aXTwPb3NNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719465787; c=relaxed/simple;
	bh=FJS3XMhZZmqbpsRqFI1wxC9jK+f50RCr1O8Ebbaclhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCohH+RiD8VDFlSsu3CH5M9LKsgzq2IDe/y2l7qcKRswQeusC3jfM3fPk3p5xkjn0HuuMvn806tNLbi/3wwVL57OnuHAWMZwV7Omv71+Fxf173HlnFCgxynF7DwFUphAPHkD/Q+9cTybUY49oeGvdTsSlP3EBEVldXjnyYw41uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 316B468AFE; Thu, 27 Jun 2024 07:22:59 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:22:59 +0200
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
Subject: Re: [PATCH 06/13] mm/memory: Add dax_insert_pfn
Message-ID: <20240627052259.GA14837@lst.de>
References: <cover.66009f59a7fe77320d413011386c3ae5c2ee82eb.1719386613.git-series.apopple@nvidia.com> <50013c1ee52b5bb1213571bff66780568455f54c.1719386613.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50013c1ee52b5bb1213571bff66780568455f54c.1719386613.git-series.apopple@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 27, 2024 at 10:54:21AM +1000, Alistair Popple wrote:
> +extern void prep_compound_page(struct page *page, unsigned int order);

No need for the extern.

>  static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
> -			unsigned long addr, struct page *page, pgprot_t prot)
> +			unsigned long addr, struct page *page, pgprot_t prot, bool mkwrite)

Overly long line.

> +	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot, mkwrite);

.. same here.

> +vm_fault_t dax_insert_pfn(struct vm_area_struct *vma,
> +		unsigned long addr, pfn_t pfn_t, bool write)

This could probably use a kerneldoc comment.


