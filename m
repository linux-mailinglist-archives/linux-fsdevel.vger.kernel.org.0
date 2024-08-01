Return-Path: <linux-fsdevel+bounces-24745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50E9449C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4B3288728
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2118453A;
	Thu,  1 Aug 2024 10:55:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1C170A32
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509714; cv=none; b=GvXbXyUihTQx9dlumrYvuOJ0YSLpk2gBHIgIvAsKwsqTu9Zj3kX44vUfLHLMpNyrNp7Tu8dmHSrh6p6L/HVjt74hBgVD5xhSnXQte6+G8w6nCLdyOFu57FtenVIDGozEDyfjGk42gzE6gfa6Zdm+2IpcZU+sAjlXuro5juf8DOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509714; c=relaxed/simple;
	bh=2YJsOeyF6QknChmNBOUpqISVegnDQDQHKri0gspXAc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6hayoLNHYIkDOw9sOnq5KJn4KiZoYwD2iCTfM0Q29l9B4kDN0WIuAxZzvw3tkwJbA2ZTofds2IAUWPphIfrZMcMbLXzMw0Lq1URTTTAODaT2gLcJbs599GMnZZZTkK0DGdYLCdil0w0MmD3bN4QVd4yyC/yVmJWM5I0ob9Fh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39A931007;
	Thu,  1 Aug 2024 03:55:37 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9023F5A1;
	Thu,  1 Aug 2024 03:55:07 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:55:02 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 13/29] arm64: convert protection key into vm_flags and
 pgprot values
Message-ID: <20240801105502.GA841837@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-14-joey.gouly@arm.com>
 <ZqJ0HqR4IbNrgX5y@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqJ0HqR4IbNrgX5y@e133380.arm.com>

On Thu, Jul 25, 2024 at 04:49:50PM +0100, Dave Martin wrote:
> On Fri, May 03, 2024 at 02:01:31PM +0100, Joey Gouly wrote:
> > Modify arch_calc_vm_prot_bits() and vm_get_page_prot() such that the pkey
> > value is set in the vm_flags and then into the pgprot value.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/mman.h | 8 +++++++-
> >  arch/arm64/mm/mmap.c          | 9 +++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > index 5966ee4a6154..ecb2d18dc4d7 100644
> > --- a/arch/arm64/include/asm/mman.h
> > +++ b/arch/arm64/include/asm/mman.h
> > @@ -7,7 +7,7 @@
> >  #include <uapi/asm/mman.h>
> >  
> >  static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > -	unsigned long pkey __always_unused)
> > +	unsigned long pkey)
> >  {
> >  	unsigned long ret = 0;
> >  
> > @@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >  	if (system_supports_mte() && (prot & PROT_MTE))
> >  		ret |= VM_MTE;
> >  
> > +#if defined(CONFIG_ARCH_HAS_PKEYS)
> > +	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
> > +	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
> > +	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
> 
> Out of interest, is this as bad as it looks or does the compiler turn
> it into a shift and mask?

Yeah, (gcc 13.2) produces good code here (this is do_mprotect_pkey after removing a lot of branching):

	and     w0, w0, #0x7
	orr     x1, x1, x0, lsl #32

> 
> 
> > +#endif
> > +
> >  	return ret;
> >  }
> >  #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> > diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> > index 642bdf908b22..86eda6bc7893 100644
> > --- a/arch/arm64/mm/mmap.c
> > +++ b/arch/arm64/mm/mmap.c
> > @@ -102,6 +102,15 @@ pgprot_t vm_get_page_prot(unsigned long vm_flags)
> >  	if (vm_flags & VM_MTE)
> >  		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
> >  
> > +#ifdef CONFIG_ARCH_HAS_PKEYS
> > +	if (vm_flags & VM_PKEY_BIT0)
> > +		prot |= PTE_PO_IDX_0;
> > +	if (vm_flags & VM_PKEY_BIT1)
> > +		prot |= PTE_PO_IDX_1;
> > +	if (vm_flags & VM_PKEY_BIT2)
> > +		prot |= PTE_PO_IDX_2;
> > +#endif
> > +
> 
> Ditto.  At least we only have three bits to cope with either way.
> 
> I'm guessing that these functions are not super-hot path.
> 
> [...]
> 
> Cheers
> ---Dave

