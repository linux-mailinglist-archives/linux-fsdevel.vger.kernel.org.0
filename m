Return-Path: <linux-fsdevel+bounces-3859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8A27F942D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF246281171
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D782DDC2;
	Sun, 26 Nov 2023 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0hRxteW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D879E3
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 16:51:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BF2C433C7;
	Sun, 26 Nov 2023 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701017511;
	bh=FDyXkUn1ms2kzfHY+saeQwFUVAaiGmYfQvFClYXidck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0hRxteWAQLQ/0YtJXWGK4f5IDfgMW3wk47NmQL/7JrZmflvCrXsBxtvKEAh4qsLN
	 6e4npMjydlnS+hKCqoDq2cluJiukekAFJQ1OeOL5T46x+QzQJWEEdPlL1xlelh2zDJ
	 rDmJvLptrqzhj/IMbAO8y6YNZqWI28sXIotClYy+5hh1ClfQ7sqa/rmP/QQpYEzecf
	 sqlwY5z+DI3BPGzGcHVs/F5lHRawxmpP+t9GHM2vgVAf4gCdx9mWNFTwkfeYWAW9Ef
	 eHTiA4pEnp2BwqV9qb+Gvx6kqIRfegpHT2pznLsTX79nXlD8AqqJrHCvqLxu0K3l8a
	 JbxWkcRmwGnwg==
Date: Sun, 26 Nov 2023 11:51:44 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZWN3oI47fHITANXj@gmail.com>
References: <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com>
 <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWN0ycxvzNzVXyNQ@gmail.com>

On Sun, Nov 26, 2023 at 11:39:37AM -0500, Guo Ren wrote:
> On Wed, Nov 22, 2023 at 09:20:53AM -0800, Linus Torvalds wrote:
> > On Tue, 21 Nov 2023 at 23:19, Guo Ren <guoren@kernel.org> wrote:
> > >
> > > We discussed x86 qspinlock code generation. It looked not too bad as I
> > > thought because qspinlock_spin_value_unlocked is much cheaper than the
> > > ticket-lock. But the riscv ticket-lock code generation is terrible
> > > because of the shift left & right 16-bit.
> > > https://lore.kernel.org/all/ZNG2tHFOABSXGCVi@gmail.com
> > 
> > No, it's not the 16-bit shifts in the spin_value_unlocked() check,
> > that just generates simple and straightforward code:
> > 
> >   a0:   0107569b                srlw    a3,a4,0x10
> >   a4:   00c77733                and     a4,a4,a2
> >   a8:   04e69063                bne     a3,a4,e8 <.L12>
> > 
> > (plus two stupid instructions for generating the immediate in a2 for
> > 0xffff, but hey, that's the usual insane RISC-V encoding thing - you
> > can load a 20-bit U-immediate only shifted up by 12, if it's in the
> > lower bits you're kind of screwed and limited to 12-bit immediates).
> > 
> > The *bad* code generation is from the much simpler
> > 
> >         new.count++;
> > 
> > which sadly neither gcc not clang is quite smart enough to understand
> > that "hey, I can do that in 64 bits".
> > 
> > It's incrementing the higher 32-bit word in a 64-bit union, and with a
> > smarter compiler it *should* basically become
> > 
> >         lock_count += 1 << 32;
> > 
> > but the compiler isn't that clever, so it splits the 64-bit word into
> > two 32-bit words, increments one of them, and then merges the two
> > words back into 64 bits:
> > 
> >   98:   4207d693                sra     a3,a5,0x20
> >   9c:   02079713                sll     a4,a5,0x20
> >   a0:   0016869b                addw    a3,a3,1
> >   a4:   02069693                sll     a3,a3,0x20
> >   a8:   02075713                srl     a4,a4,0x20
> >   ac:   00d76733                or      a4,a4,a3
> > 
> > which is pretty sad.
> 9c & a8 is for word-zero-extend; riscv would have zext.w in the future.
> Your patch may improve above with:
> 	li      a4,1
> 	slli    a4,a4,32
> 	add     a4,a5,a4
> 
> v.s.
> 	sra     a3,a5,0x20
> 	zext.w	a4,a5
> 	addw    a3,a3,1
> 	or      a4,a4,a3
> You win one instruction "or a4,a4,a3", which is less than one cycle.
Sorry, I forgot "sll     a3,a3,0x20", so it's 1.5 cycles, but it didn't
affect my opinion here; local core operations are the lower optimization
priority than memory transations.

> 
> The zext.w is important, and it could replace sll+srl a lot, so I think
> it's a current ISA design short.
> 
> Here, what I want to improve is to prevent stack frame setup in the fast
> path, and that's the most benefit my patch could give out. Unnecessary
> memory access is the most important performance killer in SMP.
> 
> My patch removes the stack frame setup from the fast path.
> void lockref_get(struct lockref *lockref)
> {
>   78:   00053783                ld      a5,0(a0)
> 000000000000007c <.LBB212>:
>   7c:   00010637                lui     a2,0x10
> 
> 0000000000000080 <.LBE212>:
>   80:   06400593                li      a1,100
> 
> 0000000000000084 <.LBB216>:
>   84:   fff60613                add     a2,a2,-1 # ffff <.LLST8+0xf4aa>
> 
> 0000000000000088 <.L8>:
>   88:   0007871b                sext.w  a4,a5
> 
> 000000000000008c <.LBB217>:
>   8c:   0107d69b                srlw    a3,a5,0x10
>   90:   00c77733                and     a4,a4,a2
>   94:   04e69063                bne     a3,a4,d4 <.L12> --------+
> 						      		|
> 0000000000000098 <.LBB218>:					|
>   98:   4207d693                sra     a3,a5,0x20		|
>   9c:   02079713                sll     a4,a5,0x20		|
>   a0:   0016869b                addw    a3,a3,1			|
>   a4:   02069693                sll     a3,a3,0x20		|
>   a8:   02075713                srl     a4,a4,0x20		|
>   ac:   00d76733                or      a4,a4,a3		|
> 								|
> 00000000000000b0 <.L0^B1>:					|
>   b0:   100536af                lr.d    a3,(a0)			|
>   b4:   00f69863                bne     a3,a5,c4 <.L1^B1>	|
>   b8:   1ae5382f                sc.d.rl a6,a4,(a0)		|
>   bc:   fe081ae3                bnez    a6,b0 <.L0^B1>		|
>   c0:   0330000f                fence   rw,rw			|
> 								|
> 00000000000000c4 <.L1^B1>:					|
>   c4:   04d78a63                beq     a5,a3,118 <.L18>	|
> 								|
> 00000000000000c8 <.LBE228>:					|
>   c8:   fff5859b                addw    a1,a1,-1		|	
> 								|
> 00000000000000cc <.LBB229>:					|
>   cc:   00068793                mv      a5,a3			|
> 								|
> 00000000000000d0 <.LBE229>:					|
>   d0:   fa059ce3                bnez    a1,88 <.L8>		|
> 						     		|
> 00000000000000d4 <.L12>: <--------------------------------------+
> {						      slow_path
>   d4:   fe010113                add     sp,sp,-32
>   d8:   00113c23                sd      ra,24(sp)
>   dc:   00813823                sd      s0,16(sp)
>   e0:   02010413                add     s0,sp,32
> 
> 
> > 
> > If you want to do the optimization that the compiler misses by hand,
> > it would be something like the attached patch.
> > 
> > NOTE! Very untested. But that *should* cause the compiler to just
> > generate a single "add" instruction (in addition to generating the
> > constant 0x100000000, of course).
> > 
> > Of course, on a LL/SC architecture like RISC-V, in an *optimal* world,
> > the whole sequence would actually be done with one single LL/SC,
> > rather than the "load,add,cmpxchg" thing.
> > 
> > But then you'd have to do absolutely everything by hand in assembly.
> No, it's not worth to do that.
>  - There are only atomic primitives in Linux, but no ll/sc primitive in
>    the real world. The world belongs to AMO and the only usage of ll/sc
>    is to implement AMO and CAS.
>  - Using single ll/sc primitive instead of cmpxchg is similar to your
>    patch, and you may win 1 cycle or not.
>  - The critical work here are reducing bus transactions, preventing
>    cache dance, and forward progress guarantee.
> 
> Here is my optimization advice:
> 
> #define CMPXCHG_LOOP(CODE, SUCCESS) do {                                        \
>         int retry = 100;                                                        \
>         struct lockref old;                                                     \
>         BUILD_BUG_ON(sizeof(old) != 8);                                         \
> +       prefetchw(lockref);                                                     \
>         old.lock_count = READ_ONCE(lockref->lock_count);                        \
>         while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {     \
>                 struct lockref new = old;                                       \
>                 CODE                                                            \
>                 if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,          \
>                                                  &old.lock_count,               \
>                                                  new.lock_count))) {            \
>                         SUCCESS;                                                \
>                 }                                                               \
> 
> Micro-arch could give prefetchw more guarantee:
>  - Prefetch.w must guarantee cache line exclusiveness even when a
>    shareable state cache line hits.
>  - Hold the exclusive cache line for several cycles until the next
>    store or timeout
>  - Mask interrupt during the holding cycles (Optional)
> 
> The lockref slow path is killed in this micro-architecture, which
> means there is no chance to execute the spinlock.
> 
> I've written down more details in my ppt:
> https://docs.google.com/presentation/d/1UudBcj4cL_cjJexMpZNF9ppRzYxeYqsdBotIvU7sO2Q/edit?usp=sharing
> 
> This type of prefetchw could help large-size atomic operations within
> one cache line. Compared to the transaction memory model, prefetchw
> could give a forward progress guarantee and easier landing in Linux
> without any new primitive.
> 
> > 
> >                   Linus
> 
> >  lib/lockref.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/lockref.c b/lib/lockref.c
> > index 2afe4c5d8919..481b102a6476 100644
> > --- a/lib/lockref.c
> > +++ b/lib/lockref.c
> > @@ -26,6 +26,17 @@
> >  	}									\
> >  } while (0)
> >  
> > +/*
> > + * The compiler isn't smart enough to the the count
> > + * increment in the high 32 bits of the 64-bit value,
> > + * so do this optimization by hand.
> > + */
> > +#if defined(__LITTLE_ENDIAN) && BITS_PER_LONG == 64
> > + #define LOCKREF_INC(n) ((n).lock_count += 1ul<<32)
> > +#else
> > + #define LOCKREF_INC(n) ((n).count++)
> > +#endif
> > +
> >  #else
> >  
> >  #define CMPXCHG_LOOP(CODE, SUCCESS) do { } while (0)
> > @@ -42,7 +53,7 @@
> >  void lockref_get(struct lockref *lockref)
> >  {
> >  	CMPXCHG_LOOP(
> > -		new.count++;
> > +		LOCKREF_INC(new);
> >  	,
> >  		return;
> >  	);
> > @@ -63,7 +74,7 @@ int lockref_get_not_zero(struct lockref *lockref)
> >  	int retval;
> >  
> >  	CMPXCHG_LOOP(
> > -		new.count++;
> > +		LOCKREF_INC(new);
> >  		if (old.count <= 0)
> >  			return 0;
> >  	,
> > @@ -174,7 +185,7 @@ int lockref_get_not_dead(struct lockref *lockref)
> >  	int retval;
> >  
> >  	CMPXCHG_LOOP(
> > -		new.count++;
> > +		LOCKREF_INC(new);
> >  		if (old.count < 0)
> >  			return 0;
> >  	,
> 
> 

