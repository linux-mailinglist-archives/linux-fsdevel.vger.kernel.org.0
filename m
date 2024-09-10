Return-Path: <linux-fsdevel+bounces-29020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0249738D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB721C24832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E84E192D7A;
	Tue, 10 Sep 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ql4vqC8b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178114F12C;
	Tue, 10 Sep 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975727; cv=none; b=VHhwkZCj+LcR+927F0xs69yt9kNVr6EQFKjzzCKJWTtgeC1uFw8raFSlQdReTya5lHvztIMuQ8Ck1ZGvTu6QvRYwWwGo0OZ1KDizrUctnc8eAnqCtc1xzb3vwGRWOjwK1m2WpJg1EeF1HptQe++T5Hrw/YLr0u/lA4Vufdrn/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975727; c=relaxed/simple;
	bh=T1DrTVHH1sfUlag/CA8DuPaKKivrIip5vD+w1SHJCO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQiCPiZs9ylcmzwcIVTktQHbIp7kVqInKEnoyewN/UXfLcp5j6qbcKvR5osSF141YyZN//8HiQwuLy7LvlVHl38sB+a0mZ0SKvL8l+dnAyQh3ISchFaog05N0yoiVIOy7tKokZFhJqbKw0YXTqXBR6Gzb+O907yEA8XfyYgk4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ql4vqC8b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wxzBgx3kqKVoI3jlEN02U0lcelhmIv1peZoDYksnKQE=; b=Ql4vqC8boH+fZrAUoC8Aa6Psgt
	RErCIrXi9ls6VySEg6mIvd5hNzYoDFZSKEE6w4Arli+Aomfx2k3AURv9IZ3Kq1epkDAwAQjQKn9/i
	bdIHlb6dv6AcFIp5giL3Z44FyGQFNieKtbiAFfOFmYChI7TokimX33nB17CcKexqNaagFgQnuYSUe
	lW6RaJtU/ATEI1WyTW2IeJ6aPH9c/nH6dQWFaPAnTTAVoVCgam2fDn62Bq8/zTH+MXWY717GziaJv
	iT+Smj0GKJzb/HC8YKyB5p9m9J/58ZrBG/Mh9dmVp4oeUm7NI6VzeLt0ZcigAvPv6y+dUCpJf672/
	cPFt8iiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1so17l-0000000BLwy-1gHR;
	Tue, 10 Sep 2024 13:41:41 +0000
Date: Tue, 10 Sep 2024 14:41:41 +0100
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
Message-ID: <ZuBMlUK-v24-9m3G@casper.infradead.org>
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <c7026449473790e2844bb82012216c57047c7639.1725941415.git-series.apopple@nvidia.com>
 <Zt_PbIADa4baLEBw@casper.infradead.org>
 <87v7z4gfi7.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7z4gfi7.fsf@nvdebian.thelocal>

On Tue, Sep 10, 2024 at 04:57:41PM +1000, Alistair Popple wrote:
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Tue, Sep 10, 2024 at 02:14:29PM +1000, Alistair Popple wrote:
> >> @@ -337,6 +341,7 @@ struct folio {
> >>  	/* private: */
> >>  				};
> >>  	/* public: */
> >> +			struct dev_pagemap *pgmap;
> >
> > Shouldn't that be indented by one more tab stop?
> >
> > And for ease of reading, perhaps it should be placed either immediately
> > before or after 'struct list_head lru;'?
> >
> >> +++ b/include/linux/mmzone.h
> >> @@ -1134,6 +1134,12 @@ static inline bool is_zone_device_page(const struct page *page)
> >>  	return page_zonenum(page) == ZONE_DEVICE;
> >>  }
> >>  
> >> +static inline struct dev_pagemap *page_dev_pagemap(const struct page *page)
> >> +{
> >> +	WARN_ON(!is_zone_device_page(page));
> >> +	return page_folio(page)->pgmap;
> >> +}
> >
> > I haven't read to the end yet, but presumably we'll eventually want:
> >
> > static inline struct dev_pagemap *folio_dev_pagemap(const struct folio *folio)
> > {
> > 	WARN_ON(!folio_is_zone_device(folio))
> > 	return folio->pgmap;
> > }
> >
> > and since we'll want it eventually, maybe now is the time to add it,
> > and make page_dev_pagemap() simply call it?
> 
> Sounds reasonable. I had open-coded folio->pgmap where it's needed
> because at those points it's "obviously" a ZONE_DEVICE folio. Will add
> it.

Oh, if it's obvious then just do the dereference.

