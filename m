Return-Path: <linux-fsdevel+bounces-57987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0CB27CF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 11:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C75B1D21280
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76771262D0C;
	Fri, 15 Aug 2025 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k64qKfJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0834248891;
	Fri, 15 Aug 2025 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249157; cv=none; b=JI+V65cY2eHHojZ/e8wuICqipEHoBbCAGh3TCstVa2569FJ5Cb/ivHAzoJVxjfBfASyYtMjrgTwIL9Vmh2afBxvU9U4YiQUMWXi27pWjrxzQMGJGyXdK3V64We+YJ+PPNdXmaYav1mOBgJtAEwRONw8MB0MpvZwntajCQrkj9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249157; c=relaxed/simple;
	bh=NCVfEVQN6LHwkNoCyqO9selISDvFLOPAgNrIg0ejz0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JniuZN8wD8ZYubEAW3MoKWWtH4KH4YnhpEw7tpgG3rFPrs94cPAlUijpv+sAj8lpkoniQhk4qT3Z2iQY0Yp5B43M9WEiPcg25uu5MBL6CoYcIFGlj6UG9b1ne4+KxVqbUehk1sXgRcmjs5gJAMozrIvOmbHMl+lE0BiT41sCQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k64qKfJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ED2C4CEEB;
	Fri, 15 Aug 2025 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755249154;
	bh=NCVfEVQN6LHwkNoCyqO9selISDvFLOPAgNrIg0ejz0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k64qKfJ6zNJDhsnuWxR0fgqX3BVaqQwvdZElR/klQAEoCxi1g56cxeHTAZN0/wswK
	 Pq+3GThmFMau+x8U6BogKChu5yqp5BwT3RbxGdJVY+yxVsA/3n3361XvguUQYtAzo0
	 CwsxkbStJHs9RAUy1BQLHDF5j08YA23EQWtialVtSTBmcZtV4ZgvbsnBJMyvgGhChp
	 CJH00Qs5o00iwlgrtxYWMVa2jp4VjDFoGjgtjzcCsiVePDp+01FqKPujeYxhNnJ5cJ
	 L4zaOZ7N9WkPfF3VfgjAaCkkSQpngOXjnWintiz60FKc8w0raVBwqKL8kvbukYzLFm
	 Bt1jthD93yq4g==
Date: Fri, 15 Aug 2025 12:12:10 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
Message-ID: <aJ756q-wWJV37fMm@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com>
 <20250814132233.GB802098@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814132233.GB802098@nvidia.com>

On Thu, Aug 14, 2025 at 10:22:33AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 07, 2025 at 01:44:13AM +0000, Pasha Tatashin wrote:
> > +int kho_unpreserve_phys(phys_addr_t phys, size_t size)
> > +{
> 
> Why are we adding phys apis? Didn't we talk about this before and
> agree not to expose these?
> 
> The places using it are goofy:
> 
> +static int luo_fdt_setup(void)
> +{
> +       fdt_out = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> +                                          get_order(LUO_FDT_SIZE));
> 
> +       ret = kho_preserve_phys(__pa(fdt_out), LUO_FDT_SIZE);
> 
> +       WARN_ON_ONCE(kho_unpreserve_phys(__pa(fdt_out), LUO_FDT_SIZE));
> 
> It literally allocated a page and then for some reason switches to
> phys with an open coded __pa??
> 
> This is ugly, if you want a helper to match __get_free_pages() then
> make one that works on void * directly. You can get the order of the
> void * directly from the struct page IIRC when using GFP_COMP.
> 
> Which is perhaps another comment, if this __get_free_pages() is going
> to be a common pattern (and I guess it will be) then the API should be
> streamlined alot more:
> 
>  void *kho_alloc_preserved_memory(gfp, size);
>  void kho_free_preserved_memory(void *);

This looks backwards to me. KHO should not deal with memory allocation,
it's responsibility to preserve/restore memory objects it supports.

For __get_free_pages() the natural KHO API is kho_(un)preserve_pages().
With struct page/mesdesc we always have page_to_<specialized object> from
one side and page_to_pfn from the other side.

Then folio and phys/virt APIS just become a thin wrappers around the _page
APIs. And down the road we can add slab and maybe vmalloc. 

Once folio won't overlap struct page, we'll have a hard time with only
kho_preserve_folio() for memory that's not actually folio (i.e. anon and
page cache)
 
> Which can wrapper the get_free_pages and the preserve logic and gives
> a nice path to possibly someday supporting non-PAGE_SIZE allocations.
> 
> Jason
> 

-- 
Sincerely yours,
Mike.

