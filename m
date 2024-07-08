Return-Path: <linux-fsdevel+bounces-23308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C7F92A829
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367CCB2167C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C351482F5;
	Mon,  8 Jul 2024 17:22:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E63AD55;
	Mon,  8 Jul 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459349; cv=none; b=ubBgDj/Qb/2y3xNQhpYTXZs0/nNOTPa2TD8PBYtHuMjJRNu6Ot54p+2rWTNedN5tThLpVn1z885go44K6/oNQR0+3arBSs/mchz5lLYTh8FfIQ1IGp76hRaA81+Cj3K5zPaPW449Ss6gO5kY4kLy+SJVBO9hxr2DBO4QD4uOz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459349; c=relaxed/simple;
	bh=egCPeI3Ur+czV6GQo2A5wIsjxu5dg2eZAfku3PDOLeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwJmCByTkJk7n+BGSMkJ5/6zlxWpaSvp9i7NQWo20BDd+8XafuonWhmAi9OdlK2L7IdHKoccipfqud/tq+MVFY/CbKdXuYZddPVZ7MKPlSRYu7BZThn9gN+cJHuGaV8gW18fCm1aOQ7LM4xPRu6NPFqAYXLrb18QG5gXjvIfyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6469C116B1;
	Mon,  8 Jul 2024 17:22:24 +0000 (UTC)
Date: Mon, 8 Jul 2024 18:22:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
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
Message-ID: <ZowgTnjFi4rA3pHE@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-14-joey.gouly@arm.com>
 <4f7d8691-fe19-4e8a-95e5-9f7680c82021@arm.com>
 <ZnMLKb_gWsbLgMf3@arm.com>
 <20240704124704.GA3548388@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704124704.GA3548388@e124191.cambridge.arm.com>

On Thu, Jul 04, 2024 at 01:47:04PM +0100, Joey Gouly wrote:
> On Wed, Jun 19, 2024 at 05:45:29PM +0100, Catalin Marinas wrote:
> > On Tue, May 28, 2024 at 12:24:57PM +0530, Amit Daniel Kachhap wrote:
> > > On 5/3/24 18:31, Joey Gouly wrote:
> > > > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > > > index 5966ee4a6154..ecb2d18dc4d7 100644
> > > > --- a/arch/arm64/include/asm/mman.h
> > > > +++ b/arch/arm64/include/asm/mman.h
> > > > @@ -7,7 +7,7 @@
> > > >   #include <uapi/asm/mman.h>
> > > >   static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > > > -	unsigned long pkey __always_unused)
> > > > +	unsigned long pkey)
> > > >   {
> > > >   	unsigned long ret = 0;
> > > > @@ -17,6 +17,12 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > > >   	if (system_supports_mte() && (prot & PROT_MTE))
> > > >   		ret |= VM_MTE;
> > > > +#if defined(CONFIG_ARCH_HAS_PKEYS)
> > > 
> > > Should there be system_supports_poe() check like above?
> > 
> > I think it should, otherwise we end up with these bits in the pte even
> > when POE is not supported.
> 
> I think it can't get here due to the flow of the code, but I will add it to be
> defensive (since it's just an alternative that gets patched).

You are probably right, the mprotect_pkey() will reject the call if we
don't support POE. So you could add a comment instead (but a
system_supports_poe() check seems safer).

> I still need the defined(CONFIG_ARCH_HAS_PKEYS) check, since the VM_PKEY_BIT*
> are only defined then.

Yes, the ifdef will stay.

-- 
Catalin

