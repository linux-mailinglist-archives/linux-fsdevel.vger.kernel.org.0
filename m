Return-Path: <linux-fsdevel+bounces-25110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9847094934D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9F01C2304E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987891D54DC;
	Tue,  6 Aug 2024 14:38:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC51D2F50
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955115; cv=none; b=AUBoy6dI6I7EAvEh6bJf2jxqUIxFfjvf8DJ/adlkfRsFm99VVbodqMVHYR3k3qTkRMQWwjaT6GGfMaIyC/6fCK2DaXlbUlfa1s1eghxaJ5sXUFtADXZ6qTlFmlMTlGcIRtEZV4oODU62GwsqEBFix0zGd9v4+HgYMBmMoMo5ZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955115; c=relaxed/simple;
	bh=I7uuq+gz1aOnDED7ieqVh/OdYhRbOKEI+TyDsKUjMHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoW0aHao1Xn2Y52RNF60Eu/C1vVLgMFSVeKg2XEKDFsPADdRsxt0gimdWajPHYsCZ0g+SZTQzaS3f2bw+gqNoBZn+nNaxuw4nO/T7eIRk5SXJeUGZdUF0qrcO90isV+N/9sqOV/O4BGQhmnknqdoBmtYTsbVzyMsamsZXSSIjqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D3071063;
	Tue,  6 Aug 2024 07:38:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168703F6A8;
	Tue,  6 Aug 2024 07:38:28 -0700 (PDT)
Date: Tue, 6 Aug 2024 15:38:26 +0100
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
Subject: Re: [PATCH v4 15/29] arm64: handle PKEY/POE faults
Message-ID: <ZrI1Yo6UZ/grRWYu@e133380.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-16-joey.gouly@arm.com>
 <ZqJ11TqIJq9oB+pt@e133380.arm.com>
 <20240801160110.GC841837@e124191.cambridge.arm.com>
 <ZrImMQ44dlrqCf6v@e133380.arm.com>
 <20240806134357.GA2017741@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806134357.GA2017741@e124191.cambridge.arm.com>

Hi,

On Tue, Aug 06, 2024 at 02:43:57PM +0100, Joey Gouly wrote:
> On Tue, Aug 06, 2024 at 02:33:37PM +0100, Dave Martin wrote:
> > Hi,
> > 
> > On Thu, Aug 01, 2024 at 05:01:10PM +0100, Joey Gouly wrote:
> > > On Thu, Jul 25, 2024 at 04:57:09PM +0100, Dave Martin wrote:
> > > > On Fri, May 03, 2024 at 02:01:33PM +0100, Joey Gouly wrote:
> > > > > If a memory fault occurs that is due to an overlay/pkey fault, report that to
> > > > > userspace with a SEGV_PKUERR.
> > > > > 
> > > > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > ---
> > > > >  arch/arm64/include/asm/traps.h |  1 +
> > > > >  arch/arm64/kernel/traps.c      | 12 ++++++--
> > > > >  arch/arm64/mm/fault.c          | 56 ++++++++++++++++++++++++++++++++--
> > > > >  3 files changed, 64 insertions(+), 5 deletions(-)

[...]

> > > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > > > index 215e6d7f2df8..1bac6c84d3f5 100644
> > > > > --- a/arch/arm64/kernel/traps.c
> > > > > +++ b/arch/arm64/kernel/traps.c
> > > > > @@ -263,16 +263,24 @@ static void arm64_show_signal(int signo, const char *str)
> > > > >  	__show_regs(regs);
> > > > >  }
> > > > >  
> > > > > -void arm64_force_sig_fault(int signo, int code, unsigned long far,
> > > > > -			   const char *str)
> > > > > +void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
> > > > > +			   const char *str, int pkey)
> > > > >  {
> > > > >  	arm64_show_signal(signo, str);
> > > > >  	if (signo == SIGKILL)
> > > > >  		force_sig(SIGKILL);
> > > > > +	else if (code == SEGV_PKUERR)
> > > > > +		force_sig_pkuerr((void __user *)far, pkey);
> > > > 
> > > > Is signo definitely SIGSEGV here?  It looks to me like we can get in
> > > > here for SIGBUS, SIGTRAP etc.
> > > > 
> > > > si_codes are not unique between different signo here, so I'm wondering
> > > > whether this should this be:
> > > > 
> > > > 	else if (signo == SIGSEGV && code == SEGV_PKUERR)
> > > > 
> > > > ...?
> > > > 
> > > > 
> > > > >  	else
> > > > >  		force_sig_fault(signo, code, (void __user *)far);
> > > > >  }
> > > > >  
> > > > > +void arm64_force_sig_fault(int signo, int code, unsigned long far,
> > > > > +			   const char *str)
> > > > > +{
> > > > > +	arm64_force_sig_fault_pkey(signo, code, far, str, 0);
> > > > 
> > > > Is there a reason not to follow the same convention as elsewhere, where
> > > > -1 is passed for "no pkey"?
> > > > 
> > > > If we think this should never be called with signo == SIGSEGV &&
> > > > code == SEGV_PKUERR and no valid pkey but if it's messy to prove, then
> > > > maybe a WARN_ON_ONCE() would be worth it here?
> > > > 
> > > 
> > > Anshuman suggested to separate them out, which I did like below, I think that
> > > addresses your comments too?
> > > 
> > > diff --git arch/arm64/kernel/traps.c arch/arm64/kernel/traps.c
> > > index 215e6d7f2df8..49bac9ae04c0 100644
> > > --- arch/arm64/kernel/traps.c
> > > +++ arch/arm64/kernel/traps.c
> > > @@ -273,6 +273,13 @@ void arm64_force_sig_fault(int signo, int code, unsigned long far,
> > >                 force_sig_fault(signo, code, (void __user *)far);
> > >  }
> > >  
> > > +void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
> > > +                          const char *str, int pkey)
> > > +{
> > > +       arm64_show_signal(signo, str);
> > > +       force_sig_pkuerr((void __user *)far, pkey);
> > > +}
> > > +
> > >  void arm64_force_sig_mceerr(int code, unsigned long far, short lsb,
> > >                             const char *str)
> > >  {
> > > 
> > > diff --git arch/arm64/mm/fault.c arch/arm64/mm/fault.c
> > > index 451ba7cbd5ad..1ddd46b97f88 100644
> > > --- arch/arm64/mm/fault.c
> > > +++ arch/arm64/mm/fault.c
> > 
> > (Guessing where this is means to apply, since there is no hunk header
> > or context...)
> 
> Sorry I had some other changes and just mashed the bits into a diff-looking-thing.

Fair enough.  There are a few similar bits of code, so including more
lines of context would have been helpful.

The change looked reasonable though.

> > > 
> > > -               arm64_force_sig_fault(SIGSEGV, si_code, far, inf->name);
> > > +               if (si_code == SEGV_PKUERR)
> > > +                       arm64_force_sig_fault_pkey(SIGSEGV, si_code, far, inf->name, pkey);
> > 
> > Maybe drop the the signo and si_code argument?  This would mean that
> > arm64_force_sig_fault_pkey() can't be called with a signo/si_code
> > combination that makes no sense.
> > 
> > I think pkey faults are always going to be SIGSEGV/SEGV_PKUERR, right?
> > Or are there other combinations that can apply for these faults?
> 
> Ah yes, I can simplify it even more, thanks.
> 
> diff --git arch/arm64/kernel/traps.c arch/arm64/kernel/traps.c
> index 49bac9ae04c0..d9abb8b390c0 100644
> --- arch/arm64/kernel/traps.c
> +++ arch/arm64/kernel/traps.c
> @@ -273,10 +273,9 @@ void arm64_force_sig_fault(int signo, int code, unsigned long far,
>                 force_sig_fault(signo, code, (void __user *)far);
>  }
>  
> -void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
> -                          const char *str, int pkey)
> +void arm64_force_sig_fault_pkey(unsigned long far, const char *str, int pkey)
>  {
> -       arm64_show_signal(signo, str);
> +       arm64_show_signal(SIGSEGV, str);
>         force_sig_pkuerr((void __user *)far, pkey);
>  }

Looks sensible.

I see that force_sig_pkuerr() fills in the signo and si_code itself.

Cheers
---Dave

