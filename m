Return-Path: <linux-fsdevel+bounces-23124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EAF927642
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8188B2197E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FA21AD9D9;
	Thu,  4 Jul 2024 12:47:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A613BADF
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097236; cv=none; b=WEXhW4QIoK81TWozE4AF1PPwrC2B1owTsnXQDmX4Pi6cr5zFAFZ7XL+YH1B+ZxTMN6q9Mn5kElHoA8I6lBiqfIaKpxRVDmjhebEzq3NNclHTu6zE5vJ518QXrxUedNga7gJM+tf32VKd+AQUhyAUPLAtgTXHKLQmmljed2Thktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097236; c=relaxed/simple;
	bh=CkfWZCKITynqRfS7TMnTh8xeNwILNPLBc2I97gVJAbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m37Uq/s90GjBahPvKUGCkZt1O7nmxTMWvMp0HPiHRCwRBEFfw46n86enH7znu/2KtS1PmySAl4N4Q4o3rQ7t5mX+igUNoWpWdPBI1uIp12l8WyXcz5eydJtjinjzmlZk1ZTC81mRw8nk5o4vHup3mGTKSPo2F20yLEu+BUJ5RHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AE77367;
	Thu,  4 Jul 2024 05:47:38 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A177D3F762;
	Thu,  4 Jul 2024 05:47:09 -0700 (PDT)
Date: Thu, 4 Jul 2024 13:47:04 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Amit Daniel Kachhap <amitdaniel.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 13/29] arm64: convert protection key into vm_flags and
 pgprot values
Message-ID: <20240704124704.GA3548388@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-14-joey.gouly@arm.com>
 <4f7d8691-fe19-4e8a-95e5-9f7680c82021@arm.com>
 <ZnMLKb_gWsbLgMf3@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnMLKb_gWsbLgMf3@arm.com>

Hi,

On Wed, Jun 19, 2024 at 05:45:29PM +0100, Catalin Marinas wrote:
> On Tue, May 28, 2024 at 12:24:57PM +0530, Amit Daniel Kachhap wrote:
> > On 5/3/24 18:31, Joey Gouly wrote:
> > > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > > index 5966ee4a6154..ecb2d18dc4d7 100644
> > > --- a/arch/arm64/include/asm/mman.h
> > > +++ b/arch/arm64/include/asm/mman.h
> > > @@ -7,7 +7,7 @@
> > >   #include <uapi/asm/mman.h>
> > >   static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > > -	unsigned long pkey __always_unused)
> > > +	unsigned long pkey)
> > >   {
> > >   	unsigned long ret = 0;
> > > @@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > >   	if (system_supports_mte() && (prot & PROT_MTE))
> > >   		ret |= VM_MTE;
> > > +#if defined(CONFIG_ARCH_HAS_PKEYS)
> > 
> > Should there be system_supports_poe() check like above?
> 
> I think it should, otherwise we end up with these bits in the pte even
> when POE is not supported.

I think it can't get here due to the flow of the code, but I will add it to be
defensive (since it's just an alternative that gets patched).
I still need the defined(CONFIG_ARCH_HAS_PKEYS) check, since the VM_PKEY_BIT*
are only defined then.

> 
> > > +	ret |= pkey & 0x1 ? VM_PKEY_BIT0 : 0;
> > > +	ret |= pkey & 0x2 ? VM_PKEY_BIT1 : 0;
> > > +	ret |= pkey & 0x4 ? VM_PKEY_BIT2 : 0;
> > > +#endif
> > > +
> > >   	return ret;
> > >   }
> > >   #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)

Thanks,
Joey

