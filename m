Return-Path: <linux-fsdevel+bounces-9354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DB8403F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654D81C22A1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D28E5C8E9;
	Mon, 29 Jan 2024 11:42:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC445BAD4;
	Mon, 29 Jan 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528528; cv=none; b=VE0XAVKmAjN1YP2L7X+Ttr6KoU5XzpA4+tL0UZs0fkcOwzt0ayC1ZCjh1P93WKIt/oNlZJjYzA6nlvh7KRkQEMspPd/MaWGfvb1eCwM/hxtcS4m5gnkYGjKQda74KTibeRrfHUbV3negR1NgUu8B8Huo8DbaLiAABgTYiFpiy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528528; c=relaxed/simple;
	bh=FkFZgG4NX2Z1MIleaUvoUwxX/KFV84CBNe8KsqtTFdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwjP7EdH+opJSFrSdeHt8AUB0R1lNzrDuecB2+daqR1QzE69knJ2BivzFE8cgNtziDdTdxBtoutXLHW7RYFLkD7FGOPJsQt/RAKcrGK7Qi7akXMbVBxHPMKyUx7d7434XoNgz7EusVPnOcJoGEXCvW11BiPn76kEGYOH4iO/uoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEEA71FB;
	Mon, 29 Jan 2024 03:42:47 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86CCD3F5A1;
	Mon, 29 Jan 2024 03:41:58 -0800 (PST)
Date: Mon, 29 Jan 2024 11:41:55 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, vincenzo.frascino@arm.com, david@redhat.com,
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/35] mm: page_alloc: Add gfp_flags parameter to
 arch_alloc_page()
Message-ID: <ZbePA2dGE6Vs-58t@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-2-alexandru.elisei@arm.com>
 <de0c74b3-0c7d-4f21-8454-659e8b616ea7@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0c74b3-0c7d-4f21-8454-659e8b616ea7@arm.com>

Hi,

On Mon, Jan 29, 2024 at 11:18:59AM +0530, Anshuman Khandual wrote:
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > Extend the usefulness of arch_alloc_page() by adding the gfp_flags
> > parameter.
> 
> Although the change here is harmless in itself, it will definitely benefit
> from some additional context explaining the rationale, taking into account
> why-how arch_alloc_page() got added particularly for s390 platform and how
> it's going to be used in the present proposal.

arm64 will use it to reserve tag storage if the caller requested a tagged
page. Right now that means that __GFP_ZEROTAGS is set in the gfp mask, but
I'll rename it to __GFP_TAGGED in patch #18 ("arm64: mte: Rename
__GFP_ZEROTAGS to __GFP_TAGGED") [1].

[1] https://lore.kernel.org/lkml/20240125164256.4147-19-alexandru.elisei@arm.com/

Thanks,
Alex

> 
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> > 
> > Changes since rfc v2:
> > 
> > * New patch.
> > 
> >  arch/s390/include/asm/page.h | 2 +-
> >  arch/s390/mm/page-states.c   | 2 +-
> >  include/linux/gfp.h          | 2 +-
> >  mm/page_alloc.c              | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
> > index 73b9c3bf377f..859f0958c574 100644
> > --- a/arch/s390/include/asm/page.h
> > +++ b/arch/s390/include/asm/page.h
> > @@ -163,7 +163,7 @@ static inline int page_reset_referenced(unsigned long addr)
> >  
> >  struct page;
> >  void arch_free_page(struct page *page, int order);
> > -void arch_alloc_page(struct page *page, int order);
> > +void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags);
> >  
> >  static inline int devmem_is_allowed(unsigned long pfn)
> >  {
> > diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
> > index 01f9b39e65f5..b986c8b158e3 100644
> > --- a/arch/s390/mm/page-states.c
> > +++ b/arch/s390/mm/page-states.c
> > @@ -21,7 +21,7 @@ void arch_free_page(struct page *page, int order)
> >  	__set_page_unused(page_to_virt(page), 1UL << order);
> >  }
> >  
> > -void arch_alloc_page(struct page *page, int order)
> > +void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags)
> >  {
> >  	if (!cmma_flag)
> >  		return;
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index de292a007138..9e8aa3d144db 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -172,7 +172,7 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> >  static inline void arch_free_page(struct page *page, int order) { }
> >  #endif
> >  #ifndef HAVE_ARCH_ALLOC_PAGE
> > -static inline void arch_alloc_page(struct page *page, int order) { }
> > +static inline void arch_alloc_page(struct page *page, int order, gfp_t gfp_flags) { }
> >  #endif
> >  
> >  struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 150d4f23b010..2c140abe5ee6 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1485,7 +1485,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >  	set_page_private(page, 0);
> >  	set_page_refcounted(page);
> >  
> > -	arch_alloc_page(page, order);
> > +	arch_alloc_page(page, order, gfp_flags);
> >  	debug_pagealloc_map_pages(page, 1 << order);
> >  
> >  	/*
> 
> Otherwise LGTM.

