Return-Path: <linux-fsdevel+bounces-4158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E787FD100
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 09:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60BEB20C3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D437125A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqvYBIeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E6F101D4
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 07:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED8C433C8;
	Wed, 29 Nov 2023 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701242087;
	bh=f9ETX25AMbC6jvALznLuu4/866H/e696H8qXES/vHHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SqvYBIeM2sfG7mIIz3jQTkLd+huMJYBsOPBCOT+s6YM64wSD0Pkb6g8ycaaAr94Q/
	 M1DFLyV+WvLPRvLHns0SbmIKMtH7rY3T08AmV/6+7FhLqqf+GYyf+vB8J8SI+m1lJ1
	 Ch4aPblRRVqC2vmbkMArKB2EmLiwPO3uIt9duiWIwLrcCxu7gEAySyLHTLxTz8GB87
	 O1z2ZEJN08uj454naVxFXHI85BqbFOowGMUEWaF7dkALUVXnqNKCoh/iagG5K854vW
	 +ybLP3WqMr42sRMiZnm8iiqqCQyz8oE4kRhTbqVZnKuDDwNeQ/uxN0PPfbmDy0maGT
	 BR7wMt3TZpvAA==
Date: Wed, 29 Nov 2023 02:14:40 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZWbk4PwmCoSipECI@gmail.com>
References: <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com>
 <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <CAHk-=wg6D_d-zaRfXZ=sUX1fbTJykQ4KxXCmEk3aq73wVk_ORA@mail.gmail.com>
 <CAHk-=wj2ky85K5HYYLeLCP23qyTJpirnpiVSu5gWyT_GRXbJaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2ky85K5HYYLeLCP23qyTJpirnpiVSu5gWyT_GRXbJaQ@mail.gmail.com>

On Wed, Nov 22, 2023 at 11:11:38AM -0800, Linus Torvalds wrote:
> On Wed, 22 Nov 2023 at 09:52, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Still not actually tested, but the code generation on x86 looks
> > reasonable, so it migth be worth looking at whether it helps the
> > RISC-V case.
> 
> Doing some more munging, and actually looking at RISC-V code
> generation too (I obviously had to enable ARCH_USE_CMPXCHG_LOCKREF for
> RISC-V).
> 
> I get this:
> 
>   lockref_get:
>         addi    sp,sp,-32
>         sd      s0,16(sp)
>         sd      s1,8(sp)
>         sd      ra,24(sp)
>         addi    s0,sp,32
>         li      a1,65536
>         ld      a5,0(a0)
>         mv      s1,a0
>         addi    a1,a1,-1
>         li      a0,100
>   .L43:
>         sext.w  a3,a5
>         li      a4,1
>         srliw   a2,a5,16
>         and     a3,a3,a1
>         slli    a4,a4,32
>         bne     a2,a3,.L49
>         add     a4,a5,a4
>   0:
>         lr.d a3, 0(s1)
>         bne a3, a5, 1f
>         sc.d.rl a2, a4, 0(s1)
>         bnez a2, 0b
>         fence rw, rw
>   1:
>         bne     a5,a3,.L52
>         ld      ra,24(sp)
>         ld      s0,16(sp)
>         ld      s1,8(sp)
>         addi    sp,sp,32
>         jr      ra
>   ...
> 
> so now that single update is indeed just one single instruction:
> 
>         add     a4,a5,a4
> 
> is that "increment count in the high 32 bits".
> 
> The ticket lock being unlocked checks are those
> 
>         li      a1,65536
>         sext.w  a3,a5
>         srliw   a2,a5,16
>         and     a3,a3,a1
>         bne     a2,a3,.L49
> 
> instructions if I read it right.
> 
> That actually looks fairly close to optimal, although the frame setup
> is kind of sad.
> 
> (The above does not include the "loop if the cmpxchg failed" part of
> the code generation)
> 
> Anyway, apart from enabling LOCKREF, the patch to get this for RISC-V
> is attached.
> 
> I'm not going to play with this any more, but you might want to check
> whether this actually does work on RISC-V.
> 
> Becaue I only looked at the code generation, I didn't actually look at
> whether it *worked*.
> 
>                 Linus

> From 168f35850c15468941e597907e33daacd179d54a Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Wed, 22 Nov 2023 09:33:29 -0800
> Subject: [PATCH] lockref: improve code generation for ref updates
> 
> Our lockref data structure is two 32-bit words laid out next to each
> other, combining the spinlock and the count into one entity that can be
> accessed atomically together.
> 
> In particular, the structure is laid out so that the count is the upper
> 32 bit word (on little-endian), so that you can do basic arithmetic on
> the count in 64 bits: instead of adding one to the 32-bit word, you can
> just add a value shifted by 32 to the full 64-bit word.
> 
> Sadly, neither gcc nor clang are quite clever enough to work that out on
> their own, so this does that "manually".
> 
> Also, try to do any compares against zero values, which generally
> improves the code generation.  So rather than check that the value was
> at least 1 before a decrement, check that it's positive or zero after
> the decrement.  We don't worry about the overflow point in lockrefs.
Tested-by: Guo Ren <guoren@kernel.org>

This patch could help riscv optimize 3 ALU instructions.

Before the patch:
000000000000020c <lockref_get>:
        CMPXCHG_LOOP(
 20c:   611c                    ld      a5,0(a0)

000000000000020e <.LBB492>:
 20e:   03079713                sll     a4,a5,0x30
 212:   0107d69b                srlw    a3,a5,0x10
 216:   9341                    srl     a4,a4,0x30
 218:   02e69663                bne     a3,a4,244 <.L40>

000000000000021c <.LBB494>:
 21c:   4207d693                sra     a3,a5,0x20    -------+
 220:   02079713                sll     a4,a5,0x20	     |
 224:   2685                    addw    a3,a3,1		     |
 226:   1682                    sll     a3,a3,0x20	     |
 228:   9301                    srl     a4,a4,0x20	     |
 22a:   8f55                    or      a4,a4,a3      -------+

000000000000022c <.L0^B4>:
 22c:   100536af                lr.d    a3,(a0)
 230:   00f69763                bne     a3,a5,23e <.L1^B5>
 234:   1ae5362f                sc.d.rl a2,a4,(a0)
 238:   fa75                    bnez    a2,22c <.L0^B4>
 23a:   0330000f                fence   rw,rw

After the patch:
000000000000020c <lockref_get>:
        CMPXCHG_LOOP(
 20c:   611c                    ld      a5,0(a0)

000000000000020e <.LBB526>:
 20e:   03079713                sll     a4,a5,0x30
 212:   0107d69b                srlw    a3,a5,0x10
 216:   9341                    srl     a4,a4,0x30
 218:   02e69163                bne     a3,a4,23a <.L40>

000000000000021c <.LBB528>:
 21c:   4705                    li      a4,1		------+
 21e:   1702                    sll     a4,a4,0x20	      |
 220:   973e                    add     a4,a4,a5	------+

0000000000000222 <.L0^B4>:
 222:   100536af                lr.d    a3,(a0)
 226:   00f69763                bne     a3,a5,234 <.L1^B5>
 22a:   1ae5362f                sc.d.rl a2,a4,(a0)
 22e:   fa75                    bnez    a2,222 <.L0^B4>
 230:   0330000f                fence   rw,rw

> 
> Cc: Guo Ren <guoren@kernel.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  lib/lockref.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/lockref.c b/lib/lockref.c
> index 2afe4c5d8919..f3c30c538af1 100644
> --- a/lib/lockref.c
> +++ b/lib/lockref.c
> @@ -26,6 +26,17 @@
>  	}									\
>  } while (0)
>  
> +/*
> + * The compiler isn't smart enough to the the count
> + * increment in the high 32 bits of the 64-bit value,
> + * so do this optimization by hand.
> + */
> +#if defined(__LITTLE_ENDIAN) && BITS_PER_LONG == 64
> + #define LOCKREF_ADD(n,x) ((n).lock_count += (unsigned long)(x)<<32)
> +#else
> + #define LOCKREF_ADD(n,x) ((n).count += (unsigned long)(x)<<32)
> +#endif
> +
>  #else
>  
>  #define CMPXCHG_LOOP(CODE, SUCCESS) do { } while (0)
> @@ -42,7 +53,7 @@
>  void lockref_get(struct lockref *lockref)
>  {
>  	CMPXCHG_LOOP(
> -		new.count++;
> +		LOCKREF_ADD(new,1);
>  	,
>  		return;
>  	);
> @@ -63,9 +74,9 @@ int lockref_get_not_zero(struct lockref *lockref)
>  	int retval;
>  
>  	CMPXCHG_LOOP(
> -		new.count++;
>  		if (old.count <= 0)
>  			return 0;
> +		LOCKREF_ADD(new,1);
>  	,
>  		return 1;
>  	);
> @@ -91,8 +102,8 @@ int lockref_put_not_zero(struct lockref *lockref)
>  	int retval;
>  
>  	CMPXCHG_LOOP(
> -		new.count--;
> -		if (old.count <= 1)
> +		LOCKREF_ADD(new,-1);
> +		if (new.count <= 0)
>  			return 0;
>  	,
>  		return 1;
> @@ -119,8 +130,8 @@ EXPORT_SYMBOL(lockref_put_not_zero);
>  int lockref_put_return(struct lockref *lockref)
>  {
>  	CMPXCHG_LOOP(
> -		new.count--;
> -		if (old.count <= 0)
> +		LOCKREF_ADD(new,-1);
> +		if (new.count < 0)
>  			return -1;
>  	,
>  		return new.count;
> @@ -137,8 +148,8 @@ EXPORT_SYMBOL(lockref_put_return);
>  int lockref_put_or_lock(struct lockref *lockref)
>  {
>  	CMPXCHG_LOOP(
> -		new.count--;
> -		if (old.count <= 1)
> +		LOCKREF_ADD(new,-1);
> +		if (new.count <= 0)
>  			break;
>  	,
>  		return 1;
> @@ -174,9 +185,9 @@ int lockref_get_not_dead(struct lockref *lockref)
>  	int retval;
>  
>  	CMPXCHG_LOOP(
> -		new.count++;
>  		if (old.count < 0)
>  			return 0;
> +		LOCKREF_ADD(new,1);
>  	,
>  		return 1;
>  	);
> -- 
> 2.43.0.5.g38fb137bdb
> 


