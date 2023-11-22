Return-Path: <linux-fsdevel+bounces-3354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C007F3EC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 08:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D03B216E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C9918634;
	Wed, 22 Nov 2023 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsr583z7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD118623
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 07:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF2FC433C8;
	Wed, 22 Nov 2023 07:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700637561;
	bh=sQ/cYGcQ8MGeEoV5DqbpawbzD8WPO+gjeOGv9wMvw4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lsr583z7Lf/zGS5YoAfpjf83WX5evQE1dspHuuKpRnggY/Lirc4JANdT3DC8iyZxA
	 4V6bejqQfwHsLaRQrrplm9RhXwhkJ48nCYZFPAaS1/cfDnOYOwIxcHCOVLCEihsLt/
	 8iWca581cgTR12DZfv4+qmY7O+MouN4FIz07dntyx62/WzAyPbtpWraH59QbFMkYe/
	 Aj6wXd7nKd7mFMrXs3I5kX9KB9Bj4ygC1ivKlV+slwvXS8ybNDFoQjfX3RyWM6XO7X
	 vr/ySUayGAiPjpX8Pq5Cv8tG72DKw4cNFQ/OcjBuH4JbuS9OovKouZKWZiPEnPD95K
	 RXSb6uotrvGNQ==
Date: Wed, 22 Nov 2023 02:19:16 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZV2rdE1XQWwJ7s75@gmail.com>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>

On Thu, Nov 09, 2023 at 09:57:39PM -0800, Linus Torvalds wrote:
> On Thu, 9 Nov 2023 at 20:20, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         FWIW, on top of current #work.dcache2 the following delta might be worth
> > looking into.  Not sure if it's less confusing that way, though - I'd been staring
> > at that place for too long.  Code generation is slightly suboptimal with recent
> > gcc, but only marginally so.
> 
> I doubt the pure ALU ops and a couple of extra conditional branches
> (that _probably_ predict well) matter at all.
> 
> Especially since this is all after lockref_put_return() has done that
> locked cmpxchg, which *is* expensive.
> 
> My main reaction is that we use hlist_bl_unhashed() for d_unhashed(),
> and we *intentionally* make it separate from the actual unhasing:
> 
>  - ___d_drop() does the __hlist_bl_del()
> 
>  - but d_unhashed() does hlist_bl_unhashed(), which checks
> d_hash.pprev == NULL, and that's done by __d_drop
> 
> We even have a comment about this:
> 
>  * ___d_drop doesn't mark dentry as "unhashed"
>  * (dentry->d_hash.pprev will be LIST_POISON2, not NULL).
> 
> and we depend on this in __d_move(), which will unhash things
> temporarily, but not mark things unhashed, because they get re-hashed
> again. Same goes for __d_add().
> 
> Anyway, what I'm actually getting at in a roundabout way is that maybe
> we should make D_UNHASHED be another flag in d_flags, and *not* use
> that d_hash.pprev field, and that would allow us to combine even more
> of these tests in dput(), because now pretty much *all* of those
> "retain_dentry()" checks would be about d_flags bits.
> 
> Hmm? As it is, it has that odd combination of d_flags and that
> d_unhashed() test, so it's testing two different fields.
> 
> Anyway, I really don't think it matters much, but since you brought up
> the whole suboptimal code generation..
> 
> I tried to look at dput() code generation, and it doesn't look
> horrendous as-is in your dcache2 branch.
> 
> If anything, the thing that hirs is the lockref_put_return() being
> out-of-line even though this is basically the only caller, plus people
> have pessimized the arch_spin_value_unlocked() implementation *again*,
> so that it uses a volatile read, when the *WHOLE*POINT* of that
> "VALUE" part of "value_unlocked()" is that we've already read the
> value, and we should *not* re-read it.
> 
> Damn.
> 
> The bug seems to affect both the generic qspinlock code, and the
> ticket-based one.
> 
> For the ticket based ones, it's PeterZ and commit 1bce11126d57
> ("asm-generic: ticket-lock: New generic ticket-based spinlock"), which
> does
> 
>   static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>   {
>         return !arch_spin_is_locked(&lock);
>   }
> 
> where we've got that "lock" value, but then it takes the address of
> it, and uses arch_spin_is_locked() on it, so now it will force a flush
> to memory, and then an READ_ONCE() on it.
> 
> And for the qspinlock code, we had a similar

We discussed x86 qspinlock code generation. It looked not too bad as I
thought because qspinlock_spin_value_unlocked is much cheaper than the
ticket-lock. But the riscv ticket-lock code generation is terrible
because of the shift left & right 16-bit.
https://lore.kernel.org/all/ZNG2tHFOABSXGCVi@gmail.com

> 
>   static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
>   {
>         return !atomic_read(&lock.val);
>   }
> 
> thing, where it does 'atomic_read()' on the value it was passed as an argument.
> 
> Stupid, stupid. It's literally forcing a re-read of a value that is
> guaranteed to be on stack.
> 
> I know this worked at some point, but that may have been many years
> ago, since I haven't looked at this part of lockref code generation in
> ages.
> 
> Anway, as a result now all the lockref functions will do silly "store
> the old lockref value to memory, in order to read it again" dances in
> that CMPXCHG_LOOP() loop.
> 
> It literally makes that whole "is this an unlocked value" function
> completely pointless. The *whole* and only point was "look, I already
> loaded the value from memory, is this *VALUE* unlocked.
> 
> Compared to that complete braindamage in the fast-path loop, the small
> extra ALU ops in fast_dput() are nothing.
> 
> Peter - those functions are done exactly the wrong way around.
> arch_spin_is_locked() should be implemented using
> arch_spin_value_unlocked(), not this way around.
> 
> And the queued spinlocks should not do an atomic_read()of the argument
> they get, they should just do "!lock.val.counter"
> 
> So something like this should fix lockref. ENTIRELY UNTESTED, except
> now the code generation of lockref_put_return() looks much better,
> without a pointless flush to the stack, and now it has no pointless
> stack frame as a result.
> 
> Of course, it should probably be inlined, since it has only one user
> (ok, two, since fast_dput() gets used twice), and that should make the
> return value testing much better.
> 
>                Linus

>  include/asm-generic/qspinlock.h |  2 +-
>  include/asm-generic/spinlock.h  | 17 +++++++++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
> index 995513fa2690..0655aa5b57b2 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
> @@ -70,7 +70,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
>   */
>  static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
>  {
> -	return !atomic_read(&lock.val);
> +	return !lock.val.counter;
>  }
>  
>  /**
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index fdfebcb050f4..a35eda0ec2a2 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -68,11 +68,17 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>  	smp_store_release(ptr, (u16)val + 1);
>  }
>  
> +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	u32 val = lock.counter;
> +	return ((val >> 16) == (val & 0xffff));
> +}
> +
>  static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -	u32 val = atomic_read(lock);
> -
> -	return ((val >> 16) != (val & 0xffff));
> +	arch_spinlock_t val;
> +	val.counter = atomic_read(lock);
> +	return !arch_spin_value_unlocked(val);
>  }
>  
>  static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> @@ -82,11 +88,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  	return (s16)((val >> 16) - (val & 0xffff)) > 1;
>  }
>  
> -static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> -{
> -	return !arch_spin_is_locked(&lock);
> -}
> -
>  #include <asm/qrwlock.h>
>  
>  #endif /* __ASM_GENERIC_SPINLOCK_H */


