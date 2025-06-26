Return-Path: <linux-fsdevel+bounces-53118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4962AEA96A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 00:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814966440BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 22:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5E2620C4;
	Thu, 26 Jun 2025 22:13:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8225E80D;
	Thu, 26 Jun 2025 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976023; cv=none; b=KFeJ8IVn58pN4fuKsMHw5w4OFaqsT4aq4hDtGKRY7oeIR1fcos+tSSAbA5aA0rRo+ObviqBhHP8i+zrdZbrj2Hb7+4gNrRMJ7hnkC/u09ij7JaADMfAoI3+rf7jiDsmHIBgcRG48tLnOmSaOyyIIQw/U01PtVR3TFFcwZAfzxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976023; c=relaxed/simple;
	bh=IlbMR8aRBq51sXoTkfu78Ok6R8uIUmrqgiEEYZ/S+uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0+c/Rbdv1gx+43DTkXzmXwyVk+RH0aos0XbRH8S40awLfxcko6jJqDWtX23tA6hUUS28PydjGpAouWm4XJjmKwVriTeynYvMnuEo4J9JiZlv8DFa7C4/B7oYasNxrtkAERwrgFlufROYXphyxDcw9VbYmmFXO6Tt3Ucr399kOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 55QM1oLX019828;
	Thu, 26 Jun 2025 17:01:50 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 55QM1mJt019826;
	Thu, 26 Jun 2025 17:01:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 26 Jun 2025 17:01:48 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: David Laight <david.laight.linux@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
Message-ID: <20250626220148.GR17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu> <20250622172043.3fb0e54c@pumpkin> <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu> <20250624131714.GG17294@gate.crashing.org> <20250624175001.148a768f@pumpkin> <20250624182505.GH17294@gate.crashing.org> <20250624220816.078f960d@pumpkin> <83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
User-Agent: Mutt/1.4.2.3i

On Thu, Jun 26, 2025 at 07:56:10AM +0200, Christophe Leroy wrote:
> Le 24/06/2025 à 23:08, David Laight a écrit :
> >On Tue, 24 Jun 2025 13:25:05 -0500
> >Segher Boessenkool <segher@kernel.crashing.org> wrote:
> >>>>isel (which is base PowerPC, not something "e500" only) is a
> >>>>computational instruction, it copies one of two registers to a third,
> >>>>which of the two is decided by any bit in the condition register.
> >>>
> >>>Does that mean it could be used for all the ppc cpu variants?
> >>
> >>No, only things that implement architecture version of 2.03 or later.
> >>That is from 2006, so essentially everything that is still made
> >>implements it :-)
> >>
> >>But ancient things do not.  Both 970 (Apple G5) and Cell BE do not yet
> >>have it (they are ISA 2.01 and 2.02 respectively).  And the older p5's
> >>do not have it yet either, but the newer ones do.
> 
> For book3s64, GCC only use isel with -mcpu=power9 or -mcpu=power10

I have no idea what "book3s64" means.

Some ancient Power architecture versions had something called
"Book III-S", which was juxtaposed to "Book III-E", which essentially
corresponds to the old aborted BookE stuff.

I guess you mean almost all non-FSL implementations?  Most of those
support the isel insns.  Like, Power5+ (GS).  And everything after that.

I have no idea why you think power9 has it while older CPUS do not.  In
the GCC source code we have this comment:
  /* For ISA 2.06, don't add ISEL, since in general it isn't a win, but
     altivec is a win so enable it.  */
and in fact we do not enable it for ISA 2.06 (p8) either, probably for
a similar reason.

> >>And all classic PowerPC is ISA 1.xx of course.  Medieval CPUs :-)
> >
> >That make more sense than the list in patch 5/5.
> 
> Sorry for the ambiguity. In patch 5/5 I was addressing only powerpc/32, 
> and as far as I know the only powerpc/32 supported by Linux that has 
> isel is the 85xx which has an e500 core.

What is "powerpc/32"?  It does not help if you use different names from
what everyone else does.

The name "powerpc32" is sometimes used colloquially to mean PowerPC code
running in SF=0 mode (MSR[SF]=0), but perhaps more often it is used for
32-bit only implementations (so, those that do not even have that bit:
it's bit 0 in the 64-bit MSR, so all implementations that have an only
32-bit MSR, for example).

> For powerpc/64 we have less constraint than on powerpc32:
> - Kernel memory starts at 0xc000000000000000
> - User memory stops at 0x0010000000000000

That isn't true, not even if you mean some existing name.  Usually
userspace code is mapped at 256MB (0x10000000).  On powerpc64-linux
anyway, different default on different ABIs of course :-)

> >And for access_ok() avoiding the conditional is a good enough reason
> >to use a 'conditional move' instruction.
> >Avoiding speculation is actually free.
> 
> And on CPUs that are not affected by Spectre and Meltdown like powerpc 
> 8xx or powerpc 603,

Erm.


Segher

