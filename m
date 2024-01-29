Return-Path: <linux-fsdevel+bounces-9356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9484040A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD441F213C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 11:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4D5EE62;
	Mon, 29 Jan 2024 11:46:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC715BADE;
	Mon, 29 Jan 2024 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528762; cv=none; b=GxYTyeN9l02JKaTSjodp8ovkcKtWDQ9L/3flwDU10vIdtm5nQb0MsR+snNt8zZDeWPnTi3PpofxTOyXPe3Yi0SuWHDO+O2EhHxnAKfc2t24x83Jd0YiCgNUjudTUik0rWV2zY6o4lKTp29fJQ5Dmc/PS1GZLL+DLd58d4dN+Hj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528762; c=relaxed/simple;
	bh=Rh5mn4CKsyKpqvlMVq9P6kv1kgOQqVKTjZ/qLYOpu1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upsNR1IZXghSLstMxYqdQJow+keiRz8oBgQy3Cqm7/6kvl4mQYGXwr+gp1PAfhtCX+TqgOuDrVZ518m11rtPFLL95a8TUE5YrDX6CFXhL3567jk6y5uEgFu3cKevdXzPCOslZuvBhdHjPyqz5SIo103xITI8HfHQ76daQbVrwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FA1E1FB;
	Mon, 29 Jan 2024 03:46:43 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72E63F5A1;
	Mon, 29 Jan 2024 03:45:53 -0800 (PST)
Date: Mon, 29 Jan 2024 11:45:51 +0000
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
Subject: Re: [PATCH RFC v3 03/35] mm: page_alloc: Add an arch hook to filter
 MIGRATE_CMA allocations
Message-ID: <ZbeP77VaM-_z9mA7@raptor>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-4-alexandru.elisei@arm.com>
 <a5f593c7-0e5f-46e9-a394-a2c0dad03c8f@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f593c7-0e5f-46e9-a394-a2c0dad03c8f@arm.com>

Hi,

On Mon, Jan 29, 2024 at 02:14:16PM +0530, Anshuman Khandual wrote:
> 
> 
> On 1/25/24 22:12, Alexandru Elisei wrote:
> > As an architecture might have specific requirements around the allocation
> > of CMA pages, add an arch hook that can disable allocations from
> > MIGRATE_CMA, if the allocation was otherwise allowed.
> > 
> > This will be used by arm64, which will put tag storage pages on the
> > MIGRATE_CMA list, and tag storage pages cannot be tagged. The filter will
> > be used to deny using MIGRATE_CMA for __GFP_TAGGED allocations.
> 
> Just wondering how allocation requests would be blocked for direct
> alloc_contig_range() requests ?

alloc_contig_range() does page allocation in __alloc_contig_migrate_range()
-> alloc_migration_target(); __alloc_contig_migrate_range() ignores the
gfp_mask parameter passed to alloc_contig_range() when building struct
migration_target_control, even though it's available in the struct
compact_control argument. That looks like a bug to me, as the decription
for the gfp_mask parameter says: "GFP mask to use during compaction".

Regardless, when tag storage page T1 is migrated to it can be used to
storage tags, it doesn't matter if it is replaced by another tag storage
page T2 or a regular page, as long as the replacement isn't also tagged. If
the replacement is also tagged, the code to reserve tag storage would
recurse and deadlock. See patch #16 ("KVM: arm64: Don't deny VM_PFNMAP VMAs
when kvm_has_mte()") [1] for the code.

Does that make sense?

[1] https://lore.kernel.org/linux-mm/20240125164256.4147-24-alexandru.elisei@arm.com/

> 
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >  include/linux/pgtable.h | 7 +++++++
> >  mm/page_alloc.c         | 3 ++-
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 6d98d5fdd697..c5ddec6b5305 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -905,6 +905,13 @@ static inline void arch_do_swap_page(struct mm_struct *mm,
> >  static inline void arch_free_pages_prepare(struct page *page, int order) { }
> >  #endif
> >  
> > +#ifndef __HAVE_ARCH_ALLOC_CMA
> 
> Same as last patch i.e __HAVE_ARCH_ALLOC_CMA could be avoided via
> a direct check on #ifndef arch_alloc_cma instead.

include/linux/pgtable.h uses __HAVE_ARCH_*, and I would rather keep it
consistent.

Thanks,
Alex

> 
> > +static inline bool arch_alloc_cma(gfp_t gfp)
> > +{
> > +	return true;
> > +}
> > +#endif
> > +
> >  #ifndef __HAVE_ARCH_UNMAP_ONE
> >  /*
> >   * Some architectures support metadata associated with a page. When a
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 27282a1c82fe..a96d47a6393e 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3157,7 +3157,8 @@ static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
> >  						  unsigned int alloc_flags)
> >  {
> >  #ifdef CONFIG_CMA
> > -	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> > +	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE &&
> > +	    arch_alloc_cma(gfp_mask))
> >  		alloc_flags |= ALLOC_CMA;
> >  #endif
> >  	return alloc_flags;

