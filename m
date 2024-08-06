Return-Path: <linux-fsdevel+bounces-25088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFD1948C8E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1081C22770
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B381BDAA8;
	Tue,  6 Aug 2024 10:04:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E19616D4F1
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938661; cv=none; b=qw8aUqOC5NjeJ719VK/iUI+F/z9f+ajYUXVpccqNk2lAOdT7ui31ze0Ei6luDBqKkA8bNCK5t5901IYSLj8BIfbqqV6rTDxdyWdw0h/YNd8U4LVGzdKu/ZhiuUu8EFA2t84xo/22oILufNzTtgHlmstXyLEFiRFp+rAEIBG7cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938661; c=relaxed/simple;
	bh=Nz3cNR+Mt159G5KgVqt0YOrnk0UCpdEEE+jR7HnV+vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD03v6tH1YpSt3B9HZG0Lo6eUBju0af8oOVPtOVAz2bzywezMnAYXmc6XzrWfIssH4j+gQI4NOkg4bPqmmIFDIhjhhrPUOHA3SqzUjlKdUiOeXjCXNxeXxmes236D5hg6rTYXyNc/JBAJaHtasOKQHpoKJftq/q1spWQKnSpPk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82D53DA7;
	Tue,  6 Aug 2024 03:04:44 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C837F3F6A8;
	Tue,  6 Aug 2024 03:04:15 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:04:13 +0100
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
Subject: Re: [PATCH v4 04/29] arm64: disable trapping of POR_EL0 to EL2
Message-ID: <20240806100413.GE841837@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-5-joey.gouly@arm.com>
 <ZqJyzZB8Y8GLzYIA@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqJyzZB8Y8GLzYIA@e133380.arm.com>

On Thu, Jul 25, 2024 at 04:44:13PM +0100, Dave Martin wrote:
> Hi,
> 
> On Fri, May 03, 2024 at 02:01:22PM +0100, Joey Gouly wrote:
> > Allow EL0 or EL1 to access POR_EL0 without being trapped to EL2.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/include/asm/el2_setup.h | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> > index b7afaa026842..df5614be4b70 100644
> > --- a/arch/arm64/include/asm/el2_setup.h
> > +++ b/arch/arm64/include/asm/el2_setup.h
> > @@ -184,12 +184,20 @@
> >  .Lset_pie_fgt_\@:
> >  	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> >  	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1PIE_SHIFT, #4
> > -	cbz	x1, .Lset_fgt_\@
> > +	cbz	x1, .Lset_poe_fgt_\@
> >  
> >  	/* Disable trapping of PIR_EL1 / PIRE0_EL1 */
> >  	orr	x0, x0, #HFGxTR_EL2_nPIR_EL1
> >  	orr	x0, x0, #HFGxTR_EL2_nPIRE0_EL1
> >  
> > +.Lset_poe_fgt_\@:
> > +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> > +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1POE_SHIFT, #4
> > +	cbz	x1, .Lset_fgt_\@
> > +
> > +	/* Disable trapping of POR_EL0 */
> > +	orr	x0, x0, #HFGxTR_EL2_nPOR_EL0
> 
> Do I understand correctly that this is just to allow the host to access
> its own POR_EL0, before (or unless) KVM starts up?

Yup.

> 
> KVM always overrides all the EL2 trap controls while running a guest,
> right?  We don't want this bit still set when running in a guest just
> because KVM doesn't know about POE yet.

KVM currently unconditionally traps POE regs currently, this series makes that
conditional.

> 
> (Hopefully this follows naturally from the way the KVM code works, but
> my KVM-fu is a bit rusty.)
> 
> Also, what about POR_EL1?  Do we have to reset that to something sane
> (and so untrap it here), or it is sufficient if we never turn on POE
> support in the host, via TCR2_EL1.POE?

Since the host isn't using it, we don't need to reset it. It will be reset to an unknown value for guests.

In patch 7:

+	{ SYS_DESC(SYS_POR_EL1), NULL, reset_unknown, POR_EL1 },

> 
> [...]
> 
> Cheers
> ---Dave

Thanks,
Joey

