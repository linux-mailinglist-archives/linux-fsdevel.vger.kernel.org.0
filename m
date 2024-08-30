Return-Path: <linux-fsdevel+bounces-28012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429269660E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C6D1F22D1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCD192D69;
	Fri, 30 Aug 2024 11:36:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287BD17BB0C;
	Fri, 30 Aug 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017771; cv=none; b=fceOhRRG7BEhXI8vTyoYADP/QRwZxidpSFJ49ukR8muDCV64LC0xsyp7wyBB5Ku6iSw11ZwiWTqXFmj+36Ei1Mx/ScCurtjC5VUOXgH33iUjF1pV7PzxKmDZ3/YEqIt07cbp76WKuk5QfgzKUZGWzPo3iziSFdZ0dcJkLSYup0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017771; c=relaxed/simple;
	bh=mwzrP0kN4wHkTx/N+Jzro+qORkdsAX0H5dqF0IiPWIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy0lbJ+g7r58P9NTgoGwqs3oHNosUN/+11G74Ed49dJEkIX16CWW0zDRQH+A8RTBpDXDE6CGFW0m1CEMD7Rjjyx7Ze00C9y9G/zrQM4bnydEt1H+QPmm8TAlw+dy17H0U93+ERNrXBtowOH/JkHb8rBoeXPGfo2xOORJi1g+HMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B27D0339;
	Fri, 30 Aug 2024 04:36:34 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AE603F66E;
	Fri, 30 Aug 2024 04:36:05 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:35:56 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 08/30] KVM: arm64: make kvm_at() take an OP_AT_*
Message-ID: <20240830113556.GA2952347@e124191.cambridge.arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-9-joey.gouly@arm.com>
 <20240830092527.GB7678@willie-the-truck>
 <86bk1aw8y2.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bk1aw8y2.wl-maz@kernel.org>

On Fri, Aug 30, 2024 at 12:23:33PM +0100, Marc Zyngier wrote:
> On Fri, 30 Aug 2024 10:25:27 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Thu, Aug 22, 2024 at 04:10:51PM +0100, Joey Gouly wrote:
> > > To allow using newer instructions that current assemblers don't know about,
> > > replace the `at` instruction with the underlying SYS instruction.
> > > 
> > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Oliver Upton <oliver.upton@linux.dev>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/kvm_asm.h       | 3 ++-
> > >  arch/arm64/kvm/hyp/include/hyp/fault.h | 2 +-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > > diff --git arch/arm64/include/asm/kvm_asm.h arch/arm64/include/asm/kvm_asm.h
> > > index 2181a11b9d92..38d7bfa3966a 100644
> > > --- arch/arm64/include/asm/kvm_asm.h
> > > +++ arch/arm64/include/asm/kvm_asm.h
> > 
> > FWIW (mainly for Marc): you seem to be missing the 'a/' and 'b/'
> > prefixes here, so my git would't accept the change when I tried to
> > apply locally for testing.
> 
> Seems like a spurious '--no-prefix' was added at patch formatting
> time, That clashes with git-apply's default '-p1', which strips the
> first component of the path.

I had --no-prefix in my .git/config for diffs, but I didn't realise that also
applied to git format-patch, sorry for that. I have removed it now.

If you want me to resend v5, or something else, let me know.

> 
> There's probably a way to pass '-p0' to 'git am', but I don't feel
> like trawling the git documentation by such a temperature...
> 
> 	M.

related to uaccess: Catalin is away, sure when he's back, so I'm hoping we can
resolve that when he's around.

Thanks,
Joey

