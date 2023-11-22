Return-Path: <linux-fsdevel+bounces-3351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A067F3E22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 07:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472111C20E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 06:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E4915AF9;
	Wed, 22 Nov 2023 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc931jgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB715ACF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 06:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D973BC433C8;
	Wed, 22 Nov 2023 06:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700634564;
	bh=tIxdyAIC0XaT+VZLb93zeM9lVUs2lNcnhN8f9cAJjus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lc931jgIHOupF81xQ+x4ICeKwDX+uAzbiD57144vCpB62MNFhNTZa7dlxbk9Rb4GR
	 oR1nngFrhXVGAVQuANred1qea1hWsnR3FI5guU9PQF3vdp9ZmvxwYEvpX8nSkoM0dC
	 I+IAAgurXF2lZpRuzfi7voOB7vCmwegDm2qcocGp8wmqNOxDye2f4br6R5TQJS7/uE
	 W4vCRfxzCdt1LUB9gwVbVS0wKudRLoYzr8I1IksmAEJeSwUgRAcDFcBAMSTh1Lu0W1
	 MRvoZPjP9uM3xsxcZswIRJsTXA4o9zclHdTBplO0cTA/K1bFJd5K1QI6MTeqXxxrmy
	 ejkVbnqtEUP6w==
Date: Wed, 22 Nov 2023 01:29:19 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, linux-fsdevel@vger.kernel.org,
	will@kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZV2fv36B5fabo0II@gmail.com>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <CAHk-=whNRv0v6kQiV5QO6DJhjH4KEL36vWQ6Re8Csrnh4zbRkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNRv0v6kQiV5QO6DJhjH4KEL36vWQ6Re8Csrnh4zbRkQ@mail.gmail.com>

On Thu, Nov 09, 2023 at 10:22:13PM -0800, Linus Torvalds wrote:
> On Thu, 9 Nov 2023 at 21:57, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So something like this should fix lockref. ENTIRELY UNTESTED, except
> > now the code generation of lockref_put_return() looks much better,
> > without a pointless flush to the stack, and now it has no pointless
> > stack frame as a result.
> 
> Heh. And because I was looking at Al's tree, I didn't notice that
> commit c6f4a9002252 ("asm-generic: ticket-lock: Optimize
> arch_spin_value_unlocked()") had solved the ticket spinlock part of
> this in this merge window in the meantime.
> 
> The qspinlock implementation - which is what x86 uses - is still
> broken in mainline, though.
> 
> So that part of my patch still stands. Now attached just the small
> one-liner part. Adding Ingo and Guo Ren, who did the ticket lock part
> (and looks to have done it very similarly to my suggested patch.
Not only generic ticket lock, I think Will Deacon recognized the lockref
problem of the arm32 ticket-lock in 2013.

After my patch merged, I think riscv could also select
ARCH_USE_CMPXCHG_LOCKREF in its Kconfig.

Ref:
commit 0cbad9c9dfe0c38e8ec7385b39087c005a6dee3e
Author: Will Deacon <will@kernel.org>
Date:   Wed Oct 9 17:19:22 2013 +0100

    ARM: 7854/1: lockref: add support for lockless lockrefs using
cmpxchg64

    Our spinlocks are only 32-bit (2x16-bit tickets) and, on processors
    with 64-bit atomic instructions, cmpxchg64 makes use of the
double-word
    exclusive accessors.

    This patch wires up the cmpxchg-based lockless lockref
implementation
    for ARM.

    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6c094d..fc184bcd7848 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
        select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
        select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
        select ARCH_HAVE_CUSTOM_GPIO_H
+       select ARCH_USE_CMPXCHG_LOCKREF
        select ARCH_WANT_IPC_PARSE_VERSION
        select BUILDTIME_EXTABLE_SORT if MMU
        select CLONE_BACKWARDS
diff --git a/arch/arm/include/asm/spinlock.h
b/arch/arm/include/asm/spinlock.h
index 4f2c28060c9a..ed6c22919e47 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -127,10 +127,14 @@ static inline void
arch_spin_unlock(arch_spinlock_t *lock)
        dsb_sev();
 }

+static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
+{
+       return lock.tickets.owner == lock.tickets.next;
+}
+
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-       struct __raw_tickets tickets = ACCESS_ONCE(lock->tickets);
-       return tickets.owner != tickets.next;
+       return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
 }

 static inline int arch_spin_is_contended(arch_spinlock_t *lock)

> 
> Ingo?
> 
>                      Linus

>  include/asm-generic/qspinlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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


