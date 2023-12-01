Return-Path: <linux-fsdevel+bounces-4539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F9800292
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 05:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D3DB20BFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 04:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAB7BE4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 04:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huzU+PLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706217CF
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 03:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A581C433C7;
	Fri,  1 Dec 2023 03:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701401813;
	bh=ACS9FO5IQkDDlE4McWV0/ZkmDMDQVO5KpOjNAEj9bHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huzU+PLcW/2rWEkD2bwcyR+c+9ncOBQvm8F3jyyb8GfgAhq7TsUBAPjkC50fRjYf0
	 N0+ne50r3EavxY4FAKSIWX6e0r5JHki/8zRfwia/Ze2eLzjTxLJpLEds+J7YyCBp9E
	 fCClYxLcIRU6JgUsRYkMD2q1p7HzW/ZqKR9T6DaLoui403uaknsSzs7YhrTn5mwYVf
	 3Xqez11cLbHXNg60s320oNpyCxwCIO6zectmN9aamLQlH2TVL3OTqbO/cMF3sg8OCZ
	 HHqbfTrTL6D0zJyEWqb/mM5+lja8CHN7Tm0KZPbR7ip+sT7jcCcEtJugE/BKhaAFAH
	 zQsCW9BDWtOJw==
Date: Thu, 30 Nov 2023 22:36:43 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZWlUy1wElujRfDLA@gmail.com>
References: <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV>
 <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com>
 <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com>
 <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>
 <ZWhdVpij9iCeMnog@gmail.com>
 <CAHk-=wgSsUKn0piCv_=7XZh6L07BNQHLH3CX1YUQ0G=MEpRSJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgSsUKn0piCv_=7XZh6L07BNQHLH3CX1YUQ0G=MEpRSJA@mail.gmail.com>

On Fri, Dec 01, 2023 at 10:09:01AM +0900, Linus Torvalds wrote:
> On Thu, 30 Nov 2023 at 19:01, Guo Ren <guoren@kernel.org> wrote:
> >
> > That needs the expensive mechanism DynAMO [1], but some power-efficient
> > core lacks the capability. Yes, powerful OoO hardware could virtually
> > satisfy you by a minimum number of retries, but why couldn't we
> > explicitly tell hardware for "prefetchw"?
> 
> Because every single time we've had a prefetch in the kernel, it has
> caused problems. A bit like cpu_relax() - these things get added for
> random hardware where it helps, and then a few years later it turns
> out that it hurts almost everywhere else.
> 
> We've had particular problems with 'prefetch' because it turns out
> that (a) nobody sane uses them so (b) hardware is often buggy. And
> here "buggy" may be just performance (ie "prefetch actually stalls on
> TLB lookup" etc broken behavior that means that prefetch is not even
> remotely like a no-op that just hints to the cache subsystem), but
> sometimes even in actual semantics (ie "prefetch causes spurious
> faulting behavior")
Thanks for sharing your experience, I now know the problem with generic
prefetchw.

But what to do with these codes?
➜  linux git:(master) ✗ grep prefetchw mm/ fs/ kernel/ -r
mm/slub.c:      prefetchw(object + s->offset);
mm/slab.c:      prefetchw(objp);
mm/page_alloc.c:        prefetchw(p);
mm/page_alloc.c:                prefetchw(p + 1);
mm/vmscan.c:#define prefetchw_prev_lru_folio(_folio, _base, _field)
mm/vmscan.c:                    prefetchw(&prev->_field);
mm/vmscan.c:#define prefetchw_prev_lru_folio(_folio, _base, _field) do
mm/vmscan.c:            prefetchw_prev_lru_folio(folio, src, flags);
fs/mpage.c:             prefetchw(&folio->flags);
fs/f2fs/data.c:                 prefetchw(&page->flags);
fs/ext4/readpage.c:             prefetchw(&folio->flags);
kernel/bpf/cpumap.c:                    prefetchw(page);
kernel/locking/qspinlock.c:                     prefetchw(next);
➜  linux git:(master) ✗ grep prefetchw drivers/ -r | wc -l
80
...

> 
> > Advanced hardware would treat cmpxchg as interconnect transactions when
> > cache miss(far atomic), which means L3 cache wouldn't return a unique
> > cacheline even when cmpxchg fails. The cmpxchg loop would continue to
> > read data bypassing the L1/L2 cache, which means every failure cmpxchg
> > is a cache-miss read.
> 
> Honestly, I wouldn't call that "advanced hardware". I would call that
> ridiculous.
Ridiculous Hardware:
When CAS fails, the hardware still keeps "far atomic" mode.

Correct Hardware:
When CAS fails, the hardware should change to "near-atomic," which means
acquiring an exclusive cache line and making progress.

> 
> If the cmpxchg isn't guaranteed to make progress, then the cmpxchg is
> broken. It's really that simple.
I totally agree, and it's a correct guide, Thx.

> 
> It does sound like on your hardware, maybe you just want to make the
> RISC-V cmpxchg function always do a "prefetchw" if the 'sc.d' fails,
> something like
> 
>                         "0:     lr.w %0, %2\n"                          \
>                         "       bne  %0, %z3, 1f\n"                     \
>                         "       sc.w %1, %z4, %2\n"                     \
> -                       "       bnez %1, 0b\n"                          \
> +                       "       beqz %1, 1f\n"                          \
> +                       "       prefetchw %2\n"                         \
> +                       "       j 0b\n"                                 \
>                         "1:\n"                                          \

I modify your code to guarantee the progress of the comparison failure
situation:
Final version (for easy read):
                         "0:     lr.w %0, %2\n"                          \
                         "       bne  %0, %z3, 2f\n"                     \
                         "       sc.w %1, %z4, %2\n"                     \
                         "       beqz %1, 1f\n"                          \
                         "       prefetchw %2\n"                         \
                         "       j 0b\n"                         	 \
                         "2:\n"                                          \
                         "       prefetchw %2\n"                         \
                         "1:\n"                                          \

Diff version:
                         "0:     lr.w %0, %2\n"                          \
 -                       "       bne  %0, %z3, 1f\n"                     \
 +                       "       bne  %0, %z3, 2f\n"                     \
                         "       sc.w %1, %z4, %2\n"                     \
 -                       "       bnez %1, 0b\n"                          \
 +                       "       beqz %1, 1f\n"                          \
 +                       "       prefetchw %2\n"                         \
 +                       "       j 0b\n"                         	 \
 +                       "2:\n"                                          \
 +                       "       prefetchw %2\n"                         \
                         "1:\n"                                          \

> 
> (quick entirely untested hack, you get the idea). A better
> implementation might use "asm goto" and expose the different error
> cases to the compiler so that it can move things around, but I'm not
> convinced it's worth the effort.
> 
> But no, we're *not* adding a prefetchw to generic code just because
> apparently some RISC-V code is doing bad things. You need to keep
> workarounds for RISC-V behavior to RISC-V.
> 
> And yes, the current "retry count" in our lockref implementation comes
> from another "some hardware does bad things for cmpxchg". But that
> workaround at most causes a few extra (regular) ALU instructions, and
> while not optimal, it's at least not going to cause any bigger
> problems.
> 
>            Linus
> 

