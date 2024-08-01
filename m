Return-Path: <linux-fsdevel+bounces-24809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3319450A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC48280EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A021B9B49;
	Thu,  1 Aug 2024 16:32:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332CF1B3758
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529920; cv=none; b=ileM5sbf2SP7pL0EvyEDGHnI1DcH13n/C2MlarSVds1/FSbX9/gacpN280mfiYrXaQ0kNmxDYm4Y6iwXcRwAtWXwXNbU9EIjoMvVpnJtQNalkSk/+xqMdpeqeVnE/QJ/VJjHQgcCwr2VWS1SzM7gPafVkTWAG7gsj+EHmNlDAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529920; c=relaxed/simple;
	bh=60uHbDPBhI2LmprMWp2mu64aASmVdqAKWgj57NlpH48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUyJUa+ErFDa2HGYdJ+GJUg7v07K+V6MSG+f1qAg1zywzJWQttWymd/yp9SNN//xrjkG9uov2NC9eepLuJYIetSoft1aKC32ZGPsFkq7hYfBLpazAscV5qm1Zo3MGUX6zb/h/WGq3O3Bz0xjG7QzTEyeMuMTW0arjV4Di6/v4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6FC1007;
	Thu,  1 Aug 2024 09:32:21 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97D4A3F5A1;
	Thu,  1 Aug 2024 09:31:52 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:31:50 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
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
Subject: Re: [PATCH v4 10/29] arm64: enable the Permission Overlay Extension
 for EL0
Message-ID: <Zqu4dgB4RSW9MNs1@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-11-joey.gouly@arm.com>
 <ZqJz9EoqJE95Oe7g@e133380.arm.com>
 <20240801160403.GD841837@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801160403.GD841837@e124191.cambridge.arm.com>

On Thu, Aug 01, 2024 at 05:04:03PM +0100, Joey Gouly wrote:
> On Thu, Jul 25, 2024 at 04:49:08PM +0100, Dave Martin wrote:
> > On Fri, May 03, 2024 at 02:01:28PM +0100, Joey Gouly wrote:
> > > Expose a HWCAP and ID_AA64MMFR3_EL1_S1POE to userspace, so they can be used to
> > > check if the CPU supports the feature.
> > > 
> > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > ---
> > > 
> > > This takes the last bit of HWCAP2, is this fine? What can we do about more features in the future?
> > > 
> > > 
> > >  Documentation/arch/arm64/elf_hwcaps.rst |  2 ++
> > >  arch/arm64/include/asm/hwcap.h          |  1 +
> > >  arch/arm64/include/uapi/asm/hwcap.h     |  1 +
> > >  arch/arm64/kernel/cpufeature.c          | 14 ++++++++++++++
> > >  arch/arm64/kernel/cpuinfo.c             |  1 +
> > >  5 files changed, 19 insertions(+)
> > > 
> > > diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
> > > index 448c1664879b..694f67fa07d1 100644
> > > --- a/Documentation/arch/arm64/elf_hwcaps.rst
> > > +++ b/Documentation/arch/arm64/elf_hwcaps.rst
> > > @@ -365,6 +365,8 @@ HWCAP2_SME_SF8DP2
> > >  HWCAP2_SME_SF8DP4
> > >      Functionality implied by ID_AA64SMFR0_EL1.SF8DP4 == 0b1.
> > >  
> > > +HWCAP2_POE
> > > +    Functionality implied by ID_AA64MMFR3_EL1.S1POE == 0b0001.
> > 
> > Nit: unintentionally dropped blank line before the section heading?
> 
> Now there's only one blank line, I think
> c1932cac7902a8b0f7355515917dedc5412eb15d unintentionally added 2 blank lines,
> before that it was always 1!

Hmmm, true.  Not a big deal, I guess.

Cheers
---Dave

