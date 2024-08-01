Return-Path: <linux-fsdevel+bounces-24804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5531B94506D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1496F2860BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE31B3742;
	Thu,  1 Aug 2024 16:22:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B32613C3D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529373; cv=none; b=PxsBvQheMYlV2TBZlC8iTJI/U/vTL9r7+l+TeWZcYEVOZK+yslSpefjwBXyHcSrd98jDGhyUGbjTJZSUOm4j84KwXc0vRLnB5O0zaSOEh/ZoX0Jn+VPyR3iVd6t5nfQy+LiSNiLFQYT/ztwNqtYrsM7BmPyy3B+3iPTQDohZIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529373; c=relaxed/simple;
	bh=qUFontRAFv7rJI4/rybC2yfIa9nubQqXUCVePZgFwVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf7hDlrbEUtVjD7jRJ3otTctJsNyfd38DFgp85UVbnzTUmTOaYJeNnw3OvKUqhVrJ/f66lNAz91yvZ2NmFQ1Gi0o2rx8vLJsLHj0L784S2YZiRJHZFhKkUko86WBw4wDPhx7IwU/X+L4Cr2Fp2mhAErPPszbZIVv+XpLjKv151w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AC9115A1;
	Thu,  1 Aug 2024 09:23:16 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE1323F5A1;
	Thu,  1 Aug 2024 09:22:47 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:22:45 +0100
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
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <Zqu2VYELikM5LFY/@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801155441.GB841837@e124191.cambridge.arm.com>

On Thu, Aug 01, 2024 at 04:54:41PM +0100, Joey Gouly wrote:
> On Thu, Jul 25, 2024 at 05:00:18PM +0100, Dave Martin wrote:
> > Hi,
> > 
> > On Fri, May 03, 2024 at 02:01:36PM +0100, Joey Gouly wrote:
> > > Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> > > 
> > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > ---
> > >  arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
> > >  arch/arm64/kernel/signal.c               | 52 ++++++++++++++++++++++++
> > >  2 files changed, 59 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> > > index 8a45b7a411e0..e4cba8a6c9a2 100644
> > > --- a/arch/arm64/include/uapi/asm/sigcontext.h
> > > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> > 
> > [...]
> > 
> > > @@ -980,6 +1013,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
> > >  			return err;
> > >  	}
> > >  
> > > +	if (system_supports_poe()) {
> > > +		err = sigframe_alloc(user, &user->poe_offset,
> > > +				     sizeof(struct poe_context));
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > >  	return sigframe_alloc_end(user);
> > >  }
> > >  
> > > @@ -1020,6 +1060,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
> > >  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
> > >  	}
> > >  
> > > +	if (system_supports_poe() && err == 0 && user->poe_offset) {
> > > +		struct poe_context __user *poe_ctx =
> > > +			apply_user_offset(user, user->poe_offset);
> > > +
> > > +		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
> > > +		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
> > > +		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
> > > +	}
> > > +
> > 
> > Does the AArch64 procedure call standard say anything about whether
> > POR_EL0 is caller-saved?
> 
> I asked about this, and it doesn't say anything and they don't plan on it,
> since it's very application specific.

Right.  I think that confirms that we don't absolutely need to preserve
POR_EL0, because if compiler-generated code was allowed to fiddle with
this and not clean up after itself, the PCS would have to document this.

> > 
> > <bikeshed>
> > 
> > In theory we could skip saving this register if it is already
> > POR_EL0_INIT (which it often will be), and if the signal handler is not
> > supposed to modify and leave the modified value in the register when
> > returning.
> > 
> > The complexity of the additional check my be a bit pointless though,
> > and the the handler might theoretically want to change the interrupted
> > code's POR_EL0 explicitly, which would be complicated if POE_MAGIC is
> > sometimes there and sometimes not.
> > 
> > </bikeshed>
> > 
> I think trying to skip/optimise something here would be more effort than any
> possible benefits!

Actually, having thought about this some more I think that only dumping
this register if != POR_EL0_INIT may be right right thing to do.

This would mean that old binary would stacks never see poe_context in
the signal frame, and so will never experience unexpected stack
overruns (at least, not due solely to the presence of this feature).

POE-aware signal handlers have to do something fiddly and nonportable
to obtain the original value of POR_EL0 regardless, so requiring them
do handle both cases (present in sigframe and absent) doesn't seem too
onerous to me.


Do you think this approach would break any known use cases?

Cheers
---Dave

