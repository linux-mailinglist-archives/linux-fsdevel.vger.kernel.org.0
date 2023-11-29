Return-Path: <linux-fsdevel+bounces-4173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE27FD481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1061A2812CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B81B279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftlLCOUw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52A10A3E
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 09:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC86C433C8;
	Wed, 29 Nov 2023 09:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701251571;
	bh=+UCMXcoX5L2kpotVQ/8Fc83WOtLF15JmRbgpO9bVFAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftlLCOUw6c6uAjAWLH4wglDDHewIpTUUWAYwK61eUKMjNuGkOoE6QX1C8ISPS1FtS
	 2pGPsehp2BrYhhU/QMhQJLC93R/fnVAJiANbK3fD7PCzSOrF3dQgrbvh3/mXedKXfN
	 YrZeb8Y3Ir1ygZp/J2x9XwWB9W+rvyLFGzGTzgY9L4DPok2KbLI+XxztWU/zmzeZzW
	 qXtlOCK5LJbDz0SVidaHqTWLxCzsgPy+DE2pM3VOJbSRQqhLVHTcuc1oJKgx/gYWmI
	 dM582vbHE+ZazAVe+q1HZtwMAGgJEzL9ZACOggYICMe65gQJPeqDJzjKx+q16SlIu3
	 o7SDKgtRYL0bA==
Date: Wed, 29 Nov 2023 04:52:45 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZWcJ7QgPHP6EmLTy@gmail.com>
References: <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com>
 <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com>
 <CAHk-=wjErxMmQaPqS8tVr=4ZqYcvs5Xw3yyBdAG1oO6KcwV0Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjErxMmQaPqS8tVr=4ZqYcvs5Xw3yyBdAG1oO6KcwV0Vg@mail.gmail.com>

On Sun, Nov 26, 2023 at 09:06:03AM -0800, Linus Torvalds wrote:
> On Sun, 26 Nov 2023 at 08:39, Guo Ren <guoren@kernel.org> wrote:
> >
> > Here, what I want to improve is to prevent stack frame setup in the fast
> > path, and that's the most benefit my patch could give out.
> 
> Side note: what patch do you have that avoids the stack frame setup?
> Because I still saw the stack frame even with the
> arch_spin_value_unlocked() fix and the improved code generation. The
> compiler still does
> 
>         addi    sp,sp,-32
>         sd      s0,16(sp)
>         sd      s1,8(sp)
>         sd      ra,24(sp)
>         addi    s0,sp,32
I found below affect you:

 #define CMPXCHG_LOOP(CODE, SUCCESS) do {                                       \
-       int retry = 100;                                                        \
        struct lockref old;                                                     \
        BUILD_BUG_ON(sizeof(old) != 8);                                         \
        old.lock_count = READ_ONCE(lockref->lock_count);                        \
@@ -21,11 +20,21 @@
                                                 new.lock_count))) {            \
                        SUCCESS;                                                \
                }                                                               \
-               if (!--retry)                                                   \
-                       break;                                                  \

Yes, The 'retry' count patch [1] hurts us.

[1]: https://lore.kernel.org/lkml/20190607072652.GA5522@hc/T/#m091df9dca68c27c28f8f69a72cae0e1361dba4fa

> 
> at the top of the function for me - not because of the (now fixed)
> lock value spilling, but just because it wants to save registers.
> 
> The reason seems to be that gcc isn't smart enough to delay the frame
> setup to the slow path where it then has to do the actual spinlock, so
> it has to generate a stack frame just for the return address and then
> it does the whole frame setup thing.
> 
> I was using just the risc-v defconfig (with the cmpxchg lockrefs
> enabled, and spinlock debugging disabled so that lockrefs actually do
> something), so there might be some other config thing like "force
> frame pointers" that then causes problems.
> 
> But while the current tree avoids the silly lock value spill and
> reload, and my patch improved the integer instruction selection, I
> really couldn't get rid of the stack frame entirely. The x86 code also
> ends up looking quite nice, although part of that is that the
> qspinlock test is a simple compare against zero:
> 
>   lockref_get:
>         pushq   %rbx
>         movq    %rdi, %rbx
>         movq    (%rdi), %rax
>         movl    $-100, %ecx
>         movabsq $4294967296, %rdx
>   .LBB0_1:
>         testl   %eax, %eax
>         jne     .LBB0_4
>         leaq    (%rax,%rdx), %rsi
>         lock
>         cmpxchgq        %rsi, (%rbx)
>         je      .LBB0_5
>         incl    %ecx
>         jne     .LBB0_1
>   .LBB0_4:
>         movq    %rbx, %rdi
>         callq   _raw_spin_lock
>         incl    4(%rbx)
>         movb    $0, (%rbx)
>   .LBB0_5:
>         popq    %rbx
>         retq
> 
> (That 'movabsq' thing is what generates the big constant that adds '1'
> in the upper word - that add is then done as a 'leaq').
> 
> In this case, the 'retry' count is actually a noticeable part of the
> code generation, and is probably also why it has to save/restore
> '%rbx'. Oh well. We limited the cmpxchg loop because of horrible
> issues with starvation on bad arm64 cores.  It turns out that SMP
> cacheline bouncing is hard, and if you haven't been doing it for a
> couple of decades, you'll do it wrong.
> 
> You'll find out the hard way that the same is probably true on any
> early RISC-V SMP setups. You wanting to use prefetchw is a pretty
> clear indication of the same kind of thing.

The 'retry' count is bad solution, which hides the problem. ThunderX2's
problem is mainly about unnecessary cpu_relax & cacheline sticky less.
In the AMBA 5 CHI spec "Home behavior" section says: [2]
"When a Home(CIU/LLcache) determines that an Exclusive Store transaction
has failed, the following rules must be followed: If the Requester has
lost the cache line, then the Home is expected to send SnpPreferUniqueFwd
or SnpPreferUnique to get a copy of the cache line."
The SnpPreferUnique is not SnpUnique, which means it would return a shared
cacheline in case of serious contention. No guarantee for the next cmpxchg.

But, we want a unique cache line right? You said: [1]
"... And once one CPU gets ownership of the line, it doesn't lose it
immediately, so the next cmpxchg will *succeed*.
So at most, the *first* cmpxchg will fail (because that's the one that
was fed not by a previous cmpxchg, but by a regular load (which we'd
*like* to do as a "load-for-ownership" load, but we don't have the
interfaces to do that). But the second cmpxchg should basically always
succeed, ..."
(Sorry, I quoted you like this.)

My argue is:
Why do we need to wait for cmpxchg failure? You have the
"load-for-ownership" interface: "prefetchw"!

   lockref_get:
         pushq   %rbx
  +------prefetchw (%rdi)    --------> doesn't lose it immediately,
st|				so the next cmpxchg will *succeed*
ic|						- Linus
ky|      movq    %rdi, %rbx
 t|      movq    (%rdi), %rax  ------> local acquire, comfortable!
im|      movl    $-100, %ecx
e |      movabsq $4294967296, %rdx
  |.LBB0_1:
  |      testl   %eax, %eax
  |      jne     .LBB0_4
  |      leaq    (%rax,%rdx), %rsi
  |      lock
  |      cmpxchgq        %rsi, (%rbx) --> local cas, success!
  +----- je      .LBB0_5          ------> Farewell to the slowpath!

If x86 is not a crap machine, "movq+movq+movl+movabsq+testl+jne+leak+
cmpxchg" should be fast enough to satisfy the sticky time.

The prefetchw primitive has been defined in include/linux/prefetch.h
for many years.

The prefetchw has been used for generic code: 
➜  linux git:(master) ✗ grep prefetchw mm/ fs/ kernel/ -r
mm/slub.c:      prefetchw(object + s->offset);
mm/slab.c:      prefetchw(objp);
mm/page_alloc.c:        prefetchw(p);
mm/page_alloc.c:                prefetchw(p + 1);
mm/vmscan.c:#define prefetchw_prev_lru_folio(_folio, _base, _field)                     \
mm/vmscan.c:                    prefetchw(&prev->_field);                       \
mm/vmscan.c:#define prefetchw_prev_lru_folio(_folio, _base, _field) do { } while (0)
mm/vmscan.c:            prefetchw_prev_lru_folio(folio, src, flags);
fs/mpage.c:             prefetchw(&folio->flags);
fs/f2fs/data.c:                 prefetchw(&page->flags);
fs/ext4/readpage.c:             prefetchw(&folio->flags);
kernel/bpf/cpumap.c:                    prefetchw(page);
kernel/locking/qspinlock.c:                     prefetchw(next);
➜  linux git:(master) ✗ grep prefetchw drivers/ -r | wc -l
80

The prefetchw is okay for all good hardware. Not like the 'retry' one.

[1]: https://lore.kernel.org/lkml/CAHk-=wiEahkwDXpoy=-SzJHNMRXKVSjPa870+eKKenufhO_Hgw@mail.gmail.com/raw
[2]: https://kolegite.com/EE_library/datasheets_and_manuals/FPGA/AMBA/IHI0050E_a_amba_5_chi_architecture_spec.pdf

> 
>              Linus
> 

