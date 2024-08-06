Return-Path: <linux-fsdevel+bounces-25103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAB9491E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A4A28394F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738881EA0CA;
	Tue,  6 Aug 2024 13:44:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687801EA0B3
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951848; cv=none; b=ufUc0UZPbOuyvLdo6/Anm/6JJrdTMi4b7giCBvqfmUyV8iWVFDpojdMaZvqgXSSBkOKfpojjQAF5FJ2JRZwO054DZazOBaxKIndQko4rwwdCv1T2cNbNqefvvYUrJ7vtnzS5Fzoubf5tUPqnVKmM1MyAiD4vEO0Kj0GYdqtuJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951848; c=relaxed/simple;
	bh=edGDsYoXs6sZr/MpxfOHcFQkpIlPGxqnoOuvCH4izW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0K2C0xxglvkAGrsjg1XGNBWgoXYeW/apY8MUnBsQwje+Oh8zI4DOobYCjHexq+d/O6wu/UZ77czJnI1+TmB/m5BhzHZvLXR7iXiwjvZgodXqLU6Qx+R4t8lHwl2CktXlWJn4my1Hu15KLKTprILM/Ya9dVc1wGfDWt5B/TgPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97A33FEC;
	Tue,  6 Aug 2024 06:44:31 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72173F766;
	Tue,  6 Aug 2024 06:44:02 -0700 (PDT)
Date: Tue, 6 Aug 2024 14:43:57 +0100
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
Subject: Re: [PATCH v4 15/29] arm64: handle PKEY/POE faults
Message-ID: <20240806134357.GA2017741@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-16-joey.gouly@arm.com>
 <ZqJ11TqIJq9oB+pt@e133380.arm.com>
 <20240801160110.GC841837@e124191.cambridge.arm.com>
 <ZrImMQ44dlrqCf6v@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrImMQ44dlrqCf6v@e133380.arm.com>

On Tue, Aug 06, 2024 at 02:33:37PM +0100, Dave Martin wrote:
> Hi,
> 
> On Thu, Aug 01, 2024 at 05:01:10PM +0100, Joey Gouly wrote:
> > On Thu, Jul 25, 2024 at 04:57:09PM +0100, Dave Martin wrote:
> > > On Fri, May 03, 2024 at 02:01:33PM +0100, Joey Gouly wrote:
> > > > If a memory fault occurs that is due to an overlay/pkey fault, report that to
> > > > userspace with a SEGV_PKUERR.
> > > > 
> > > > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > ---
> > > >  arch/arm64/include/asm/traps.h |  1 +
> > > >  arch/arm64/kernel/traps.c      | 12 ++++++--
> > > >  arch/arm64/mm/fault.c          | 56 ++++++++++++++++++++++++++++++++--
> > > >  3 files changed, 64 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> > > > index eefe766d6161..f6f6f2cb7f10 100644
> > > > --- a/arch/arm64/include/asm/traps.h
> > > > +++ b/arch/arm64/include/asm/traps.h
> > > > @@ -25,6 +25,7 @@ try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
> > > >  void force_signal_inject(int signal, int code, unsigned long address, unsigned long err);
> > > >  void arm64_notify_segfault(unsigned long addr);
> > > >  void arm64_force_sig_fault(int signo, int code, unsigned long far, const char *str);
> > > > +void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far, const char *str, int pkey);
> > > >  void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *str);
> > > >  void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
> > > >  
> > > > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > > > index 215e6d7f2df8..1bac6c84d3f5 100644
> > > > --- a/arch/arm64/kernel/traps.c
> > > > +++ b/arch/arm64/kernel/traps.c
> > > > @@ -263,16 +263,24 @@ static void arm64_show_signal(int signo, const char *str)
> > > >  	__show_regs(regs);
> > > >  }
> > > >  
> > > > -void arm64_force_sig_fault(int signo, int code, unsigned long far,
> > > > -			   const char *str)
> > > > +void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
> > > > +			   const char *str, int pkey)
> > > >  {
> > > >  	arm64_show_signal(signo, str);
> > > >  	if (signo == SIGKILL)
> > > >  		force_sig(SIGKILL);
> > > > +	else if (code == SEGV_PKUERR)
> > > > +		force_sig_pkuerr((void __user *)far, pkey);
> > > 
> > > Is signo definitely SIGSEGV here?  It looks to me like we can get in
> > > here for SIGBUS, SIGTRAP etc.
> > > 
> > > si_codes are not unique between different signo here, so I'm wondering
> > > whether this should this be:
> > > 
> > > 	else if (signo == SIGSEGV && code == SEGV_PKUERR)
> > > 
> > > ...?
> > > 
> > > 
> > > >  	else
> > > >  		force_sig_fault(signo, code, (void __user *)far);
> > > >  }
> > > >  
> > > > +void arm64_force_sig_fault(int signo, int code, unsigned long far,
> > > > +			   const char *str)
> > > > +{
> > > > +	arm64_force_sig_fault_pkey(signo, code, far, str, 0);
> > > 
> > > Is there a reason not to follow the same convention as elsewhere, where
> > > -1 is passed for "no pkey"?
> > > 
> > > If we think this should never be called with signo == SIGSEGV &&
> > > code == SEGV_PKUERR and no valid pkey but if it's messy to prove, then
> > > maybe a WARN_ON_ONCE() would be worth it here?
> > > 
> > 
> > Anshuman suggested to separate them out, which I did like below, I think that
> > addresses your comments too?
> > 
> > diff --git arch/arm64/kernel/traps.c arch/arm64/kernel/traps.c
> > index 215e6d7f2df8..49bac9ae04c0 100644
> > --- arch/arm64/kernel/traps.c
> > +++ arch/arm64/kernel/traps.c
> > @@ -273,6 +273,13 @@ void arm64_force_sig_fault(int signo, int code, unsigned long far,
> >                 force_sig_fault(signo, code, (void __user *)far);
> >  }
> >  
> > +void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
> > +                          const char *str, int pkey)
> > +{
> > +       arm64_show_signal(signo, str);
> > +       force_sig_pkuerr((void __user *)far, pkey);
> > +}
> > +
> >  void arm64_force_sig_mceerr(int code, unsigned long far, short lsb,
> >                             const char *str)
> >  {
> > 
> > diff --git arch/arm64/mm/fault.c arch/arm64/mm/fault.c
> > index 451ba7cbd5ad..1ddd46b97f88 100644
> > --- arch/arm64/mm/fault.c
> > +++ arch/arm64/mm/fault.c
> 
> (Guessing where this is means to apply, since there is no hunk header
> or context...)

Sorry I had some other changes and just mashed the bits into a diff-looking-thing.

> 
> > 
> > -               arm64_force_sig_fault(SIGSEGV, si_code, far, inf->name);
> > +               if (si_code == SEGV_PKUERR)
> > +                       arm64_force_sig_fault_pkey(SIGSEGV, si_code, far, inf->name, pkey);
> 
> Maybe drop the the signo and si_code argument?  This would mean that
> arm64_force_sig_fault_pkey() can't be called with a signo/si_code
> combination that makes no sense.
> 
> I think pkey faults are always going to be SIGSEGV/SEGV_PKUERR, right?
> Or are there other combinations that can apply for these faults?

Ah yes, I can simplify it even more, thanks.

diff --git arch/arm64/kernel/traps.c arch/arm64/kernel/traps.c
index 49bac9ae04c0..d9abb8b390c0 100644
--- arch/arm64/kernel/traps.c
+++ arch/arm64/kernel/traps.c
@@ -273,10 +273,9 @@ void arm64_force_sig_fault(int signo, int code, unsigned long far,
                force_sig_fault(signo, code, (void __user *)far);
 }
 
-void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
-                          const char *str, int pkey)
+void arm64_force_sig_fault_pkey(unsigned long far, const char *str, int pkey)
 {
-       arm64_show_signal(signo, str);
+       arm64_show_signal(SIGSEGV, str);
        force_sig_pkuerr((void __user *)far, pkey);
 }


> 
> 
> > +               else
> > +                       arm64_force_sig_fault(SIGSEGV, si_code, far, inf->name);
> 
> Otherwise yes, I think splitting things this way makes sense.
> 
> Cheers
> ---Dave


