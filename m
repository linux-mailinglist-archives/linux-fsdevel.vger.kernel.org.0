Return-Path: <linux-fsdevel+bounces-24801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FEA944FB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 17:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59471C2350F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87EB1B142A;
	Thu,  1 Aug 2024 15:54:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2E619E7E3
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527690; cv=none; b=Dpcm1TlnXTBWGVOdLRaNeWmmang33bvVBvxe2jytskCXi9Fdq95+BjkZcx8W/ywplHVB1pt9lf8pkjn+0rHBFkWLeKlSoaQJBCxFAnXDO6P+yrWec64T/96xC8ESlWLDnLNlDmvif2rjjidXohu6qjcXNmf+dWs/aK4VWhiDIvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527690; c=relaxed/simple;
	bh=3K7h6kqYrpVVi3yJIDa/MfHmTk3MeT2DYdT5sel9lyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1NJSAg+JoimEAPxmP8ihq19iYKX8q2Sb10PYkYP3ChKwcpyT3vPDLI1PzCzc6K09Gg3GNU2aljbVErP6MV7ljqauv54zJ+/wtMCjFLbV+CD4dVq9HZQRNkQtRj/B7eZcvh8MQWWmYcMwDWcjMLDz4yqP7EWoznPdcm6hgDAJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB88115A1;
	Thu,  1 Aug 2024 08:55:11 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33D933F5A1;
	Thu,  1 Aug 2024 08:54:43 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:54:41 +0100
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
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <20240801155441.GB841837@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqJ2knGETfS4nfEA@e133380.arm.com>

On Thu, Jul 25, 2024 at 05:00:18PM +0100, Dave Martin wrote:
> Hi,
> 
> On Fri, May 03, 2024 at 02:01:36PM +0100, Joey Gouly wrote:
> > Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > ---
> >  arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
> >  arch/arm64/kernel/signal.c               | 52 ++++++++++++++++++++++++
> >  2 files changed, 59 insertions(+)
> > 
> > diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> > index 8a45b7a411e0..e4cba8a6c9a2 100644
> > --- a/arch/arm64/include/uapi/asm/sigcontext.h
> > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> 
> [...]
> 
> > @@ -980,6 +1013,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
> >  			return err;
> >  	}
> >  
> > +	if (system_supports_poe()) {
> > +		err = sigframe_alloc(user, &user->poe_offset,
> > +				     sizeof(struct poe_context));
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	return sigframe_alloc_end(user);
> >  }
> >  
> > @@ -1020,6 +1060,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
> >  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
> >  	}
> >  
> > +	if (system_supports_poe() && err == 0 && user->poe_offset) {
> > +		struct poe_context __user *poe_ctx =
> > +			apply_user_offset(user, user->poe_offset);
> > +
> > +		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
> > +		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
> > +		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
> > +	}
> > +
> 
> Does the AArch64 procedure call standard say anything about whether
> POR_EL0 is caller-saved?

I asked about this, and it doesn't say anything and they don't plan on it,
since it's very application specific.

> 
> <bikeshed>
> 
> In theory we could skip saving this register if it is already
> POR_EL0_INIT (which it often will be), and if the signal handler is not
> supposed to modify and leave the modified value in the register when
> returning.
> 
> The complexity of the additional check my be a bit pointless though,
> and the the handler might theoretically want to change the interrupted
> code's POR_EL0 explicitly, which would be complicated if POE_MAGIC is
> sometimes there and sometimes not.
> 
> </bikeshed>
> 
I think trying to skip/optimise something here would be more effort than any
possible benefits!

Thanks,
Joey

