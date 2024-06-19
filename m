Return-Path: <linux-fsdevel+bounces-21932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3BF90F462
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 18:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21E91F22C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3A154423;
	Wed, 19 Jun 2024 16:45:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225DF2262B;
	Wed, 19 Jun 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815537; cv=none; b=jOkOv5qgQDWvjSYAL8TzI/otorPIeLdz7bH6XaiJe9N50v7o2jrulFdEJDDm9GJpSpVi2rDbHbZc4REddberCOUNFELsvX704FRCNm+aDtRAeelprP2yo+4WW2wUtTNBCXu6I7Ty9dEGRKGO1tesZP2iS1nkayBngMz9GOuLc5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815537; c=relaxed/simple;
	bh=P2oWftT14YMia0FjGGbhP1AWG3nlhxxm36t98Fii8Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxFhaZe0b7SecrbyPdDRj5aHAp87i+4m9ewuhG5l9q5S0rmTpP9mVtCN8LLDyx2PMzUKSapnelGwvEL/t5/g2rTH3FxxPZ++cZcSAb+8OWkXZA0ZJrrjnfOwRhMmJiILYrek19/uSxRWHDSJ1Lc5XPVE9CGiinow/DgqUWMZqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47094C2BBFC;
	Wed, 19 Jun 2024 16:45:32 +0000 (UTC)
Date: Wed, 19 Jun 2024 17:45:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 13/29] arm64: convert protection key into vm_flags and
 pgprot values
Message-ID: <ZnMLKb_gWsbLgMf3@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-14-joey.gouly@arm.com>
 <4f7d8691-fe19-4e8a-95e5-9f7680c82021@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7d8691-fe19-4e8a-95e5-9f7680c82021@arm.com>

On Tue, May 28, 2024 at 12:24:57PM +0530, Amit Daniel Kachhap wrote:
> On 5/3/24 18:31, Joey Gouly wrote:
> > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > index 5966ee4a6154..ecb2d18dc4d7 100644
> > --- a/arch/arm64/include/asm/mman.h
> > +++ b/arch/arm64/include/asm/mman.h
> > @@ -7,7 +7,7 @@
> >   #include <uapi/asm/mman.h>
> >   static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > -	unsigned long pkey __always_unused)
> > +	unsigned long pkey)
> >   {
> >   	unsigned long ret = 0;
> > @@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> >   	if (system_supports_mte() && (prot & PROT_MTE))
> >   		ret |= VM_MTE;
> > +#if defined(CONFIG_ARCH_HAS_PKEYS)
> 
> Should there be system_supports_poe() check like above?

I think it should, otherwise we end up with these bits in the pte even
when POE is not supported.

> > +	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
> > +	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
> > +	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
> > +#endif
> > +
> >   	return ret;
> >   }
> >   #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)

-- 
Catalin

