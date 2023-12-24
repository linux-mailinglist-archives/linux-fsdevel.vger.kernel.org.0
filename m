Return-Path: <linux-fsdevel+bounces-6889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E623E81DCC8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 22:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7707FB2108E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 21:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38411078E;
	Sun, 24 Dec 2023 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oP0ArS5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27DFBEF;
	Sun, 24 Dec 2023 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iS4XqJ2iABVTA87UAP3QHDG9uzTMdMhBSMobX+j7nkw=; b=oP0ArS5XMerkIUplOafUOc2jkf
	xd6inAczmxuCSkcupZtjzZwLdPR450XFbqVXVdOoMu+ZgEVMSuXyBqVXwLEj+cvFCdjyaQ+TZlMeN
	GPOAZmWo5vwwIoSDRpkjzeZd01Ff1VKdrXgltm6g3/O7LKt01JtGOFz06MdIJNKq41AoANV1GBtj3
	PhNxXHKxaT0oXm1YvIs1BY1OMqYslvGZF/l6iqnZ/PzN0NVBoFRKY3Jw9xZriwpXUM5iuZAbG0inV
	SHNsGQLdXhf87JrqnW9GEnwoHW0R+6ZiRH01SK2HXETJ5P1bOkUJ1WUd+OiIFkLTH3xg6no19SMEl
	/vYubegA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rHWKG-00Ek0R-Do; Sun, 24 Dec 2023 21:48:01 +0000
Date: Sun, 24 Dec 2023 21:48:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Rientjes <rientjes@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>, alim.akhtar@samsung.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	baolu.lu@linux.intel.com, bhelgaas@google.com,
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
	iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, joro@8bytes.org,
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
	will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page
 allocations
Message-ID: <ZYinEGCdl8mZjmXi@casper.infradead.org>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-2-pasha.tatashin@soleen.com>
 <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
 <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
 <1fd66377-030c-2e48-e658-4669bbf037e9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd66377-030c-2e48-e658-4669bbf037e9@google.com>

On Sun, Dec 24, 2023 at 01:30:50PM -0800, David Rientjes wrote:
> > > s/pages/page/ here and later in this file.
> > 
> > In this file, where there a page with an "order", I reference it with
> > "pages", when no order (i.e. order = 0), I reference it with "page"
> > 
> > I.e.: __iommu_alloc_page vs. __iommu_alloc_pages
> > 
> 
> Eh, the struct page points to a (potentially compound) page, not a set or 
> list of pages.  I won't bikeshed on it, but "struct page *pages" never 
> makes sense unless it's **pages or *pages[] :)

I'd suggest that 'pages' also makes sense when _not_ using __GFP_COMP,
as we do in fact allocate an array of pages in that case.

That said, we shouldn't encourage the use of non-compound allocations.
It would also be good for someone to define a memdesc for iommu memory
like we have already for slab.  We'll need it eventually, and it'll work
out better if someone who understands iommus (ie not me) does it.

