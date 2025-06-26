Return-Path: <linux-fsdevel+bounces-53117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC273AEA90C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 23:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12196643429
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D0A2609ED;
	Thu, 26 Jun 2025 21:52:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCD25E47E;
	Thu, 26 Jun 2025 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974722; cv=none; b=SZzrg4vDCyzHKwJUIiRfb5P0Yh0q9V1KVEdFg2WModMWc3z9EATBmMgizWdvaB8pnlDYhXJoThIAsC3mSllOEMQWiwTYoSy9+DWm6RqSJ6+4VkRugZahKq60NAN2XZnyKFl0QlIEq3D95BHJeV0mGLawnZyzY5BfLxJgLo0chUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974722; c=relaxed/simple;
	bh=bnz1Bb7o+gzldkFLngzW6l31QB4WnvlWMZjBoOExqS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as77i60IFZq8hsURfUsV2mRTGZuMxxlz+Ic8E95f1skGZqMwny4ako6kLBc227CooTkkYiOYRt1Ta+OeQIC4/NGs7avyN4W45x/giSGawC4t9HsJPUInYsn1JI/FM9Ewi1xo+9BxxStgT5BJ3gBxgGAVJQW47XwGu9LhYpskPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 55QLdUFG018871;
	Thu, 26 Jun 2025 16:39:31 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 55QLdRb4018869;
	Thu, 26 Jun 2025 16:39:27 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 26 Jun 2025 16:39:27 -0500
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
Message-ID: <20250626213927.GQ17294@gate.crashing.org>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu> <20250622172043.3fb0e54c@pumpkin> <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu> <20250624131714.GG17294@gate.crashing.org> <20250624175001.148a768f@pumpkin> <20250624182505.GH17294@gate.crashing.org> <20250624220816.078f960d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624220816.078f960d@pumpkin>
User-Agent: Mutt/1.4.2.3i

Hi!

On Tue, Jun 24, 2025 at 10:08:16PM +0100, David Laight wrote:
> On Tue, 24 Jun 2025 13:25:05 -0500
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > On Tue, Jun 24, 2025 at 05:50:01PM +0100, David Laight wrote:
> > > On Tue, 24 Jun 2025 08:17:14 -0500
> > > Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > >   
> > > > On Tue, Jun 24, 2025 at 07:27:47AM +0200, Christophe Leroy wrote:  
> > > > > Ah ok, I overlooked that, I didn't know the cmove instruction, seem 
> > > > > similar to the isel instruction on powerpc e500.    
> > > > 
> > > > cmove does a move (register or memory) when some condition is true.  
> > > 
> > > The destination of x86 'cmov' is always a register (only the source can be
> > > memory - and is probably always read).  
> > 
> > Both source operands can be mem, right?  But probably not both at the
> > same time.
> 
> It only has one 'real' source, but the implementation could easily
> read the destination register and then decide which value to write
> back - rather than doing a conditional write to the register file.

Yeah, in x86 many (most insns?) can read any reg that they write.  Not
a great design, but heh.

> A conditional write would be a right PITA for the alu result
> forwarding logic

Depends.  An implementation can always do the register forwarding etc.,
just annul the actual store where appropriate (and not put it in the
various store queues either, heh -- annul all the effects of the store).

> > x86 is not a RISC architecture, or more generally, a load/store
> > architecture.
> 
> It sort of is these days.

Not at all.  Most *implementations* are, the uarchs, but the
architecture (which determines the required visible semantics) is not.
That impedance difference is quite painful, yes, for code generation
more than for the processor implementation even -- as usual the
compilers have to save the day!

> The memory transfers are separate u-ops, so a 'reg += mem' instruction
> is split into two be the decoder.

Yup.  Very expensive.  Both for the implementation, and for the
performance of eventual code running on it.

> Although some u-ops get merged together and executed in one clock,
> obvious example is some 'compare+branch' pairs.

On many other architectures such things run in 0 cycles anyway :-)

> > A computational instruction is one that doesn't touch memory or does a
> > branch, or some system function, some supervisor or hypervisor
> > instruction maybe.
> > 
> > x86 does not have many computational insns, most insns can touch
> > memory :-)
> 
> Except that the memory 'bit' is executed separately from any alu 'stuff'.

On many uarchs, yes.  But not in the arch.  No uarch can decide to just
not implement these difficult and expensive insns :-)

> > > There is a planned new instruction that would do a conditional write
> > > to memory - but not on any cpu yet.  
> > 
> > Interesting!  Instructions like the atomic store insns we got for p9,
> > maybe?  They can do minimum/maximum and various kinds of more generic
> > reductions and similar.
> 
> I think they are only conditional stores.
> But they do save a conditional branch.

Yeah, but those are not ever executed *anyway*, there is branch
prediction and we require that to be pretty good to get reasonable
performance anyway.

A branch around the store insns is just fine if it can be predicted
correctly.  If it cannot be predicted correctly, you can do the store
always, just have the address that is stored to depend on the condition
(such the data is stored to some dummy memory if it "should not be
done").  Source code gets such a transform done manually in the
performance critical paths not infrequently, already.

GCC does not currently do such a transformation AFAIK, but it is a
pretty basic thing to do.  Conditional stores are not often written in
source code programs, or there would probably be an implementation for
this already :-)

> A late disable of a memory write is far less problematic than a disabled
> register file write. No one minds (too much) about slight delays between
> writes and reads of the same location (reduced by a store to load forwarder)
> but you don't want to lose clocks between adjacent simple alu instructions.

Writes to memory take tens of cycles *anyway*, but all of that is hidden
by the various memory load and store queues (which let you do forwarding
in just a few cycles).

> For my sins I re-implemented a soft cpu last year...

Ouch :-)  But it was fun to do I hope?

> Which doesn't have a 'cmov' :-(

The x86 flag register bits are so limited and complicated in the first
place, cmov is the easier part there ;-) 

> > But ancient things do not.  Both 970 (Apple G5) and Cell BE do not yet
> > have it (they are ISA 2.01 and 2.02 respectively).  And the older p5's
> > do not have it yet either, but the newer ones do.
> > 
> > And all classic PowerPC is ISA 1.xx of course.  Medieval CPUs :-)
> 
> That make more sense than the list in patch 5/5.

Not sure what list that is.  I'll find it :-)

> > > > But sure, seen from very far off both isel and cmove can be used to
> > > > implement the ternary operator ("?:"), are similar in that way :-)  
> > > 
> > > Which is exactly what you want to avoid speculation.  
> > 
> > There are cheaper / simpler / more effective / better ways to get that,
> > but sure, everything is better than a conditional branch, always :-)
> 
> Everything except a TLB miss :-)

Heh.  TLBa are just a tiny part of translation on Power.  We mostly care
about the ERATs.  Look it up, if you want to be introduced to another
level of pain :-)

> And for access_ok() avoiding the conditional is a good enough reason
> to use a 'conditional move' instruction.
> Avoiding speculation is actually free.

*Assuming* that avoiding speculation is actually free, you mean?


Segher

