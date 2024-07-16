Return-Path: <linux-fsdevel+bounces-23743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3509322F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 11:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2031F210C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0E3196D8D;
	Tue, 16 Jul 2024 09:35:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956286FB8
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122508; cv=none; b=mei65Cx6tkiy3Tr96j9tMy7teFH5MaZhkv1YJW9jkR/2mpKgoDxTZvCG/ZTZNylWhvEWisOCpKN004W0tgMG5ZMWEGN+IkTrSA13WDtKWU+K1CgyXvSOi3MIzLxAnUtSyhKdJvqz8MuH70j+BqWapUPIe/fmFzMxYqGMAt7EUYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122508; c=relaxed/simple;
	bh=JqrE0WuGColQwOXQZhycWi4iyP5ZQb7TwrwlVioCsyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPFLtwUL2k+hnYSNDkx9PsrIpODEbP/2ZrLGb7S3UpONaRI6GOB+B9w9WSgCEs2W/lw7ULRzCkZOSpHiFFrFBFSc5dgmYRx3M0UnxE5mfB7kcGxFdrkrXP2lRpbJtc3pXmXecOnYTWu/v3C1vz2ytXNE/RLuIvXgvzVLTGICqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7EA1063;
	Tue, 16 Jul 2024 02:35:31 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB77D3F762;
	Tue, 16 Jul 2024 02:35:02 -0700 (PDT)
Date: Tue, 16 Jul 2024 10:34:57 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
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
Message-ID: <20240716093457.GA1542300@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-14-joey.gouly@arm.com>
 <0f87e51e-f790-4302-896f-9b9a74ed7495@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f87e51e-f790-4302-896f-9b9a74ed7495@arm.com>

On Tue, Jul 16, 2024 at 02:35:48PM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/3/24 18:31, Joey Gouly wrote:
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
> 0x1, 0x2, 0x4 here are standard bit positions for their corresponding
> VM_KEY_XXX based protection values ? Although this is similar to what
> x86 is doing currently, hence just trying to understand if these bit
> positions here are related to the user visible ABI, which should be
> standardized ?

The bit positions of VM_PKEY_BIT* aren't user visible. This is converting the
value of the `pkey` that was passed to the mprotect, into the internal flags.

I might replace those hex values with BIT(0), BIT(1), BIT(2), might be clearer.

> 
> Agree with previous comments about the need for system_supports_poe()
> based additional check for the above code block.
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
> >  	return __pgprot(prot);
> >  }
> >  EXPORT_SYMBOL(vm_get_page_prot);
> 

Thanks,
Joey

