Return-Path: <linux-fsdevel+bounces-54021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E58AFA207
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 23:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A1297B1874
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 21:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9919020FABC;
	Sat,  5 Jul 2025 21:38:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95581C4A24;
	Sat,  5 Jul 2025 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751510; cv=none; b=ibipAEXuun7VfXBPbPNrIadGM2w4koHbHclhkDBCkfnISun8EKCTWf2LJ/TmDm4ycWZIaPuF0ORHPKAYHy28plq7nXoqdZ+B2apy9AnSbeHCnyePm+jwn8rpX+2mzMcaNyrwRrE3TlX2a8k2lozD4DAnVO1j5+yHn0ez12eNWvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751510; c=relaxed/simple;
	bh=ad8xCtPAS1mIHqnvDKnfTUoESHt7KW11CIYzpP8wTDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR+x4zB7rjwbTh23RT1vBg5JoB/ejn12oKmTuzw8yZicNvRnkpQD0/1qZIZ1AbH6fmak0r8ceMG+tXavzDkPg/f/y/X81CXtA68dpXc3NMgg55rAy3z+puxXrdrohvlytnu7KEUYI5JSYXUarMtwNTllRvenwqVO8oxCNarMcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 565LbfR5180467;
	Sat, 5 Jul 2025 16:37:42 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 565Lbbv7180466;
	Sat, 5 Jul 2025 16:37:37 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Sat, 5 Jul 2025 16:37:37 -0500
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
Message-ID: <aGmbIbifTv0Tl01k@gate>
References: <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
 <20250624131714.GG17294@gate.crashing.org>
 <20250624175001.148a768f@pumpkin>
 <20250624182505.GH17294@gate.crashing.org>
 <20250624220816.078f960d@pumpkin>
 <83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
 <20250626220148.GR17294@gate.crashing.org>
 <20250705193332.251e0b1f@pumpkin>
 <aGmH_Y4248gRRpoq@gate>
 <20250705220538.1bbe5195@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705220538.1bbe5195@pumpkin>

Hi!

On Sat, Jul 05, 2025 at 10:05:38PM +0100, David Laight wrote:
> On Sat, 5 Jul 2025 15:15:57 -0500
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> 
> ...
> > The isel machine instruction is super expensive on p8: it is marked as
> > first in an instruction group, and has latency 5 for the GPR sources,
> > and 8 for the CR field source.
> > 
> > On p7 it wasn't great either, it was actually converted to a branch
> > sequence internally!
> 
> Ugg...
> 
> You'd think they'd add instructions that can be implemented.
> It isn't as though isel is any harder than 'add with carry'.

It is though!  isel was the first instruction that takes both GPR inputs
and a CR field input.  We now have more, the ISA 3.0 (p9) setb insn,
and esp. the extremely useful ISA 3.1 (p10) set[n]bc[r] insns -- well,
those don't take any GPR inputs actually, but like isel their output is
a GPR :-)

> Not that uncommon, IIRC amd added adox/adcx (add carry using the
> overflow/carry flag and without changing any other flags) as very

We have a similar "addex" insn since p9, which allows to use the OV
bit instead of the CA bit, and prepares to allow an extra three possible
bits as carry bits, too.  Using it you can run multiple carry chains
in parallel using insns very close to the traditional stuff.

The compiler still doesn't ever generate this, it is mostly useful
for handcoded assembler routines.

The carry bits are stored in the XER register, the "fixed-point
exception register", while results from comparison instructions are
stored in the CR, which holds eight four-bit CR fields, which you can
use in conditional jumps, or in isel and the like, or in the crlogical
insns (which can do any logic function on two CR field inputs and store
in a third, just like the logical insns on GPRs that also have the full
complement of 14 two source functions).

> slow instructions. Intel invented them without making jcxz (dec %cx
> and jump non-zero) fast - so you can't (easily) put them in a loop.
> Not to mention all the AVX512 fubars. 

Sounds lovely :-)

> Conditional move is more of a problem with a mips-like cpu where
> alu ops read two registers and write a third.

Like most Power implementations as well.

> You don't want to do a conditional write because it messes up
> the decision of whether to forward the alu result to the following
> instruction.
> So I think you might need to do 'cmov odd/even' and read the LSB
> from a third copy (or third read port) of the registers indexed
> by what would normally be the 'output' register number.
> Then tweak the register numbers early in the pipeline so that the
> result goes to one of the 'input' registers rather than the normal
> 'output' one.
> Not really that hard - could add to the cpu I did in 1/2 a day :-)

On p9 and later both GPR (or constant) inputs are fed into the execution
unit as well as some CR bit, and it just writes to a GPR.  Easier for
the hardware, easier for the compiler, and easier for the programmer!
Win-win-win.  The kind of tradeoffs I like best :-)


Segher

