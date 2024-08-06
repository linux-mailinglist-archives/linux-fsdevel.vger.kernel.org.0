Return-Path: <linux-fsdevel+bounces-25108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A494931B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C649286D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977971D47C8;
	Tue,  6 Aug 2024 14:31:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B5E17AE16
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954672; cv=none; b=THnECg1eCNpMuriuC2lf+UIklXiA1BbYInDFFQ3b/m0hYKMhf908Qo8IPBT9jLWuZhTjRnAr39/+od0JsaFXVz4+fo0xP8EiBHgVCePZkBrKYBcTTwBFwApuw1TYKBFAl2Gv1AL2szIY9XR1Ro74hoA0k7T+tKjPoRJnFVJJkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954672; c=relaxed/simple;
	bh=UbGntWwak7debnKS0YGwFMxuMJ0yzkcZRC6KPYpDBw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuyHheqskrWvjfranvdvOIkScEGqNTiYP3ExJ7O9arV25EoZIQ3Vle6vM1rxBPIQ7Kun73RfKSeLRAqotAJwwY50RQuDh/CzLKt3aVYcQdh/3Wbb2JHSvTN8/WKSJENWAQFk3mPeCF+58PrqbFSmAg/3xydWlFoKAj9qfYgs5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C5DEFEC;
	Tue,  6 Aug 2024 07:31:35 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82AC3F6A8;
	Tue,  6 Aug 2024 07:31:05 -0700 (PDT)
Date: Tue, 6 Aug 2024 15:31:03 +0100
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
Message-ID: <20240806143103.GB2017741@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
 <20240806103532.GA1986436@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806103532.GA1986436@e124191.cambridge.arm.com>

On Tue, Aug 06, 2024 at 11:35:32AM +0100, Joey Gouly wrote:
> On Thu, Aug 01, 2024 at 05:22:45PM +0100, Dave Martin wrote:
> > On Thu, Aug 01, 2024 at 04:54:41PM +0100, Joey Gouly wrote:
> > > On Thu, Jul 25, 2024 at 05:00:18PM +0100, Dave Martin wrote:
> > > > Hi,
> > > > 
> > > > On Fri, May 03, 2024 at 02:01:36PM +0100, Joey Gouly wrote:
> > > > > Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.
> > > > > 
> > > > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > > > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > > > ---
> > > > >  arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
> > > > >  arch/arm64/kernel/signal.c               | 52 ++++++++++++++++++++++++
> > > > >  2 files changed, 59 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
> > > > > index 8a45b7a411e0..e4cba8a6c9a2 100644
> > > > > --- a/arch/arm64/include/uapi/asm/sigcontext.h
> > > > > +++ b/arch/arm64/include/uapi/asm/sigcontext.h
> > > > 
> > > > [...]
> > > > 
> > > > > @@ -980,6 +1013,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
> > > > >  			return err;
> > > > >  	}
> > > > >  
> > > > > +	if (system_supports_poe()) {
> > > > > +		err = sigframe_alloc(user, &user->poe_offset,
> > > > > +				     sizeof(struct poe_context));
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +	}
> > > > > +
> > > > >  	return sigframe_alloc_end(user);
> > > > >  }
> > > > >  
> > > > > @@ -1020,6 +1060,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
> > > > >  		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
> > > > >  	}
> > > > >  
> > > > > +	if (system_supports_poe() && err == 0 && user->poe_offset) {
> > > > > +		struct poe_context __user *poe_ctx =
> > > > > +			apply_user_offset(user, user->poe_offset);
> > > > > +
> > > > > +		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
> > > > > +		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
> > > > > +		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
> > > > > +	}
> > > > > +
> > > > 
> > > > Does the AArch64 procedure call standard say anything about whether
> > > > POR_EL0 is caller-saved?
> > > 
> > > I asked about this, and it doesn't say anything and they don't plan on it,
> > > since it's very application specific.
> > 
> > Right.  I think that confirms that we don't absolutely need to preserve
> > POR_EL0, because if compiler-generated code was allowed to fiddle with
> > this and not clean up after itself, the PCS would have to document this.
> > 
> > > > 
> > > > <bikeshed>
> > > > 
> > > > In theory we could skip saving this register if it is already
> > > > POR_EL0_INIT (which it often will be), and if the signal handler is not
> > > > supposed to modify and leave the modified value in the register when
> > > > returning.
> > > > 
> > > > The complexity of the additional check my be a bit pointless though,
> > > > and the the handler might theoretically want to change the interrupted
> > > > code's POR_EL0 explicitly, which would be complicated if POE_MAGIC is
> > > > sometimes there and sometimes not.
> > > > 
> > > > </bikeshed>
> > > > 
> > > I think trying to skip/optimise something here would be more effort than any
> > > possible benefits!
> > 
> > Actually, having thought about this some more I think that only dumping
> > this register if != POR_EL0_INIT may be right right thing to do.
> > 
> > This would mean that old binary would stacks never see poe_context in
> > the signal frame, and so will never experience unexpected stack
> > overruns (at least, not due solely to the presence of this feature).
> 
> They can already see things they don't expect, like FPMR that was added
> recently.
> 
> > 
> > POE-aware signal handlers have to do something fiddly and nonportable
> > to obtain the original value of POR_EL0 regardless, so requiring them
> > do handle both cases (present in sigframe and absent) doesn't seem too
> > onerous to me.
> 
> If the signal handler wanted to modify the value, from the default, wouldn't it
> need to mess around with the sig context stuff, to allocate some space for
> POR_EL0, such that the kernel would restore it properly? (If that's even
> possible).
> 
> > 
> > 
> > Do you think this approach would break any known use cases?
> 
> Not sure.
> 

We talked about this offline, helped me understand it more, and I think
something like this makes sense:

diff --git arch/arm64/kernel/signal.c arch/arm64/kernel/signal.c
index 561986947530..ca7d4e0be275 100644
--- arch/arm64/kernel/signal.c
+++ arch/arm64/kernel/signal.c
@@ -1024,7 +1025,10 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
                        return err;
        }
 
-       if (system_supports_poe()) {
+       if (system_supports_poe() &&
+                       (add_all ||
+                        mm_pkey_allocation_map(current->mm) != 0x1 ||
+                        read_sysreg_s(SYS_POR_EL0) != POR_EL0_INIT)) {
                err = sigframe_alloc(user, &user->poe_offset,
                                     sizeof(struct poe_context));
                if (err)


That is, we only save the POR_EL0 value if any pkeys have been allocated (other
than pkey 0) *or* if POR_EL0 is a non-default value.

The latter case is a corner case, where a userspace would have changed POR_EL0
before allocating any extra pkeys.
That could be:
	- pkey 0, if it restricts pkey 0 without allocating other pkeys, it's
	  unlikely the program can do anything useful anyway
	- Another pkey, which userspace probably shouldn't do anyway.
	  The man pages say:
		The kernel guarantees that the contents of the hardware rights
		register (PKRU) will be preserved only for allocated protection keys. Any time
		a key is unallocated (either before the first call returning that key from
		pkey_alloc() or after it is freed via pkey_free()), the kernel may make
		arbitrary changes to the parts of the rights register affecting access to that
		key.
	  So userspace shouldn't be changing POR_EL0 before allocating pkeys anyway..

Thanks,
Joey

