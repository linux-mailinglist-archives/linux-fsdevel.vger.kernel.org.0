Return-Path: <linux-fsdevel+bounces-52797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D744AE6EB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 20:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A54517C85A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 18:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195222E6D39;
	Tue, 24 Jun 2025 18:37:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873A2E6131;
	Tue, 24 Jun 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790235; cv=none; b=DLAEltRqkbXzs5URi73qC/redVCW7V6VvjiYqGjsgDQzBuhXlU3xy/MlUlB2QWKUkxtTtZjMYYQCLvrq2jNlsI82ZxQU/eIC1xyC3goi2nAr4859+25myne2vD3Evu5Fd5budE021YBkpeBpOhwJNgHj2ZlSGaLKyQviLGjobHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790235; c=relaxed/simple;
	bh=CYkEgj+D7pWmeoP70wkhTCo2Gx13yAcftmJ283rluM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLVAC0180BTiiyx6yWgVar3SG3ZBdv3rdqRZpjZoDXEzM6AIxeTkIlcIvdIeYduRLh+WZfpOwTP14HbT2kLJql2U6Ilp5csC+odDhdpu/ly49jyxdYQw+VUVPveclSY5pzmkY5Xi7U6ytMDmUxZI+qijAM54VMGhvqxLmwqOs8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 55OIP98u005379;
	Tue, 24 Jun 2025 13:25:09 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 55OIP5sr005378;
	Tue, 24 Jun 2025 13:25:05 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 24 Jun 2025 13:25:05 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
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
Message-ID: <20250624182505.GH17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu> <20250622172043.3fb0e54c@pumpkin> <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu> <20250624131714.GG17294@gate.crashing.org> <20250624175001.148a768f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624175001.148a768f@pumpkin>
User-Agent: Mutt/1.4.2.3i

Hi!

On Tue, Jun 24, 2025 at 05:50:01PM +0100, David Laight wrote:
> On Tue, 24 Jun 2025 08:17:14 -0500
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> 
> > On Tue, Jun 24, 2025 at 07:27:47AM +0200, Christophe Leroy wrote:
> > > Ah ok, I overlooked that, I didn't know the cmove instruction, seem 
> > > similar to the isel instruction on powerpc e500.  
> > 
> > cmove does a move (register or memory) when some condition is true.
> 
> The destination of x86 'cmov' is always a register (only the source can be
> memory - an is probably always read).

Both source operands can be mem, right?  But probably not both at the
same time.

> It is a also a computational instruction.

Terminology...

x86 is not a RISC architecture, or more generally, a load/store
architecture.

A computational instruction is one that doesn't touch memory or does a
branch, or some system function, some supervisor or hypervisor
instruction maybe.

x86 does not have many computational insns, most insns can touch
memory :-)

(The important thing is that most computational insns do not ever cause
exceptions, the only exceptions are if you divide by zero or
similar :-) )

> It may well always do the register write - hard to detect.
> 
> There is a planned new instruction that would do a conditional write
> to memory - but not on any cpu yet.

Interesting!  Instructions like the atomic store insns we got for p9,
maybe?  They can do minimum/maximum and various kinds of more generic
reductions and similar.

> > isel (which is base PowerPC, not something "e500" only) is a
> > computational instruction, it copies one of two registers to a third,
> > which of the two is decided by any bit in the condition register.
> 
> Does that mean it could be used for all the ppc cpu variants?

No, only things that implement architecture version of 2.03 or later.
That is from 2006, so essentially everything that is still made
implements it :-)

But ancient things do not.  Both 970 (Apple G5) and Cell BE do not yet
have it (they are ISA 2.01 and 2.02 respectively).  And the older p5's
do not have it yet either, but the newer ones do.

And all classic PowerPC is ISA 1.xx of course.  Medieval CPUs :-)

> > But sure, seen from very far off both isel and cmove can be used to
> > implement the ternary operator ("?:"), are similar in that way :-)
> 
> Which is exactly what you want to avoid speculation.

There are cheaper / simpler / more effective / better ways to get that,
but sure, everything is better than a conditional branch, always :-)


Segher

