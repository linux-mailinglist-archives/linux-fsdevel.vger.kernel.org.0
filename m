Return-Path: <linux-fsdevel+bounces-24802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE6944FD4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AA3B229EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1713BAC8;
	Thu,  1 Aug 2024 16:01:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDC01EB4A2
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528077; cv=none; b=UI+4SHMeM8TcYA9pcSB4y9OgBaVAFEZ29TjQ68laoDxIfAcPGx6OoMgfsrkU0Jdyic0psZWhBQYUitj7GkfmyGZd7kvORu/09ZXcmMdEr4hy6DPyTlwG6Q/k8i2Y/KUmyk0rD6GYmABKJrRUKboqq3LEj+vBk0FXt61DdIOjRk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528077; c=relaxed/simple;
	bh=xEHWsY1NBTnNSvLAVL4aK1mmjceYn1BGScwbPZYmhYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGkQlVXwCSG37URj/lYz0LDGdaXkxvT327ecspzHlcb5tuC6rD739PmBO3aKrikVPRAuS9Z4j84SlR+GN310YjmelvvmUzO/bkp6RarfnOPg2GjUh5EGGxv+eUO0bYk2lo7etmSUbRrbHvhqQKMywFIpbrJSdwIe43qb9TuqPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC5A81007;
	Thu,  1 Aug 2024 09:01:40 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312AE3F5A1;
	Thu,  1 Aug 2024 09:01:12 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:01:10 +0100
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
Message-ID: <20240801160110.GC841837@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-16-joey.gouly@arm.com>
 <ZqJ11TqIJq9oB+pt@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqJ11TqIJq9oB+pt@e133380.arm.com>

On Thu, Jul 25, 2024 at 04:57:09PM +0100, Dave Martin wrote:
> On Fri, May 03, 2024 at 02:01:33PM +0100, Joey Gouly wrote:
> > If a memory fault occurs that is due to an overlay/pkey fault, report that to
> > userspace with a SEGV_PKUERR.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/traps.h |  1 +
> >  arch/arm64/kernel/traps.c      | 12 ++++++--
> >  arch/arm64/mm/fault.c          | 56 ++++++++++++++++++++++++++++++++--
> >  3 files changed, 64 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
> > index eefe766d6161..f6f6f2cb7f10 100644
> > --- a/arch/arm64/include/asm/traps.h
> > +++ b/arch/arm64/include/asm/traps.h
> > @@ -25,6 +25,7 @@ try_emulate_armv8_deprecated(struct pt_regs *regs, u32 insn)
> >  void force_signal_inject(int signal, int code, unsigned long address, unsigned long err);
> >  void arm64_notify_segfault(unsigned long addr);
> >  void arm64_force_sig_fault(int signo, int code, unsigned long far, const char *str);
> > +void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far, const char *str, int pkey);
> >  void arm64_force_sig_mceerr(int code, unsigned long far, short lsb, const char *str);
> >  void arm64_force_sig_ptrace_errno_trap(int errno, unsigned long far, const char *str);
> >  
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 215e6d7f2df8..1bac6c84d3f5 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -263,16 +263,24 @@ static void arm64_show_signal(int signo, const char *str)
> >  	__show_regs(regs);
> >  }
> >  
> > -void arm64_force_sig_fault(int signo, int code, unsigned long far,
> > -			   const char *str)
> > +void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
> > +			   const char *str, int pkey)
> >  {
> >  	arm64_show_signal(signo, str);
> >  	if (signo == SIGKILL)
> >  		force_sig(SIGKILL);
> > +	else if (code == SEGV_PKUERR)
> > +		force_sig_pkuerr((void __user *)far, pkey);
> 
> Is signo definitely SIGSEGV here?  It looks to me like we can get in
> here for SIGBUS, SIGTRAP etc.
> 
> si_codes are not unique between different signo here, so I'm wondering
> whether this should this be:
> 
> 	else if (signo == SIGSEGV && code == SEGV_PKUERR)
> 
> ...?
> 
> 
> >  	else
> >  		force_sig_fault(signo, code, (void __user *)far);
> >  }
> >  
> > +void arm64_force_sig_fault(int signo, int code, unsigned long far,
> > +			   const char *str)
> > +{
> > +	arm64_force_sig_fault_pkey(signo, code, far, str, 0);
> 
> Is there a reason not to follow the same convention as elsewhere, where
> -1 is passed for "no pkey"?
> 
> If we think this should never be called with signo == SIGSEGV &&
> code == SEGV_PKUERR and no valid pkey but if it's messy to prove, then
> maybe a WARN_ON_ONCE() would be worth it here?
> 

Anshuman suggested to separate them out, which I did like below, I think that
addresses your comments too?

diff --git arch/arm64/kernel/traps.c arch/arm64/kernel/traps.c
index 215e6d7f2df8..49bac9ae04c0 100644
--- arch/arm64/kernel/traps.c
+++ arch/arm64/kernel/traps.c
@@ -273,6 +273,13 @@ void arm64_force_sig_fault(int signo, int code, unsigned long far,
                force_sig_fault(signo, code, (void __user *)far);
 }
 
+void arm64_force_sig_fault_pkey(int signo, int code, unsigned long far,
+                          const char *str, int pkey)
+{
+       arm64_show_signal(signo, str);
+       force_sig_pkuerr((void __user *)far, pkey);
+}
+
 void arm64_force_sig_mceerr(int code, unsigned long far, short lsb,
                            const char *str)
 {

diff --git arch/arm64/mm/fault.c arch/arm64/mm/fault.c
index 451ba7cbd5ad..1ddd46b97f88 100644
--- arch/arm64/mm/fault.c
+++ arch/arm64/mm/fault.c

-               arm64_force_sig_fault(SIGSEGV, si_code, far, inf->name);
+               if (si_code == SEGV_PKUERR)
+                       arm64_force_sig_fault_pkey(SIGSEGV, si_code, far, inf->name, pkey);
+               else
+                       arm64_force_sig_fault(SIGSEGV, si_code, far, inf->name);


Thanks,
Joey

