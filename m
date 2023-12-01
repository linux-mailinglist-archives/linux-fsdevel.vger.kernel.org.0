Return-Path: <linux-fsdevel+bounces-4544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B058B8005D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 09:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7353728157A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B21C2AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXhp/aqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2A11CB6
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 07:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57377C433C8;
	Fri,  1 Dec 2023 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415904;
	bh=Vpjp3tyInf1gfNJ5tg6p81ZsMODgm9iyHnZS36fFy4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXhp/aqmi7IjQ3fyE65NyL1sOhL/oZdGjLA/uClNBQP5OtVikBRmNdGvd/gymC59W
	 AlnjRC2RwgrfnbUNle2SNsMfCLAJ88Rr6zwN6ltkEP4THh77XrTPU0fnp479HRp8Wx
	 c2w9y/Z7ecidFDbheI3AtHbCIpvujWz4nIbBNt+5eO+xeh0C4JrmHKY7GqwBvtCPYD
	 91xluD/nZ3BsTYu/h5UeIh1LQek5TOdARpMHOtjj/6tMV6FQqnCXBn5HoWS+QsuBN+
	 Hlp8jupUThxVSlec2EtjyvqtlW3R6f8k3GNi2sY1ittQI4xS/O7KdacSjGl15RVfa7
	 zHRhZFATLVDxw==
Date: Fri, 1 Dec 2023 02:31:33 -0500
From: Guo Ren <guoren@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
Message-ID: <ZWmL1aNE20Gb/tUn@gmail.com>
References: <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com>
 <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com>
 <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>
 <ZWhdVpij9iCeMnog@gmail.com>
 <CAHk-=wgSsUKn0piCv_=7XZh6L07BNQHLH3CX1YUQ0G=MEpRSJA@mail.gmail.com>
 <ZWlUy1wElujRfDLA@gmail.com>
 <CAHk-=wgfcR+XQXhivpgFCzkOEvcgnMKOrOAeqGGD7hfksmM3ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfcR+XQXhivpgFCzkOEvcgnMKOrOAeqGGD7hfksmM3ow@mail.gmail.com>

On Fri, Dec 01, 2023 at 02:15:15PM +0900, Linus Torvalds wrote:
> On Fri, 1 Dec 2023 at 12:36, Guo Ren <guoren@kernel.org> wrote:
> >
> > I modify your code to guarantee the progress of the comparison failure
> > situation:
> 
> Are you sure you want to prefetch when the value doesn't even match
> the existing value? Aren't you better off just looping doing just
> reads until you at least have a valid value to exchange?
Oops, you are right, I'm wrong here. Here is what I want to say:
+          "       prefetch %2\n"                          \
           "0:     lr.w %0, %2\n"                          \
           "       bne  %0, %z3, 1f\n"                     \
           "       sc.w %1, %z4, %2\n"                     \
           "       beqz %1, 1f\n"                          \
           "       prefetchw %2\n"                         \
           "       j 0b\n"                                 \
           "1:\n"                                          \

Just add a prefetch shared cache line before, which could stick the
shared cache line several cycles to ensure the outer cmpxchg loop could
make progress.

All we wrote here is not for actual code, and it's just a reference for
hardware guys.
 - lr could imply a sticky shared cache line.
 - sc could imply a sticky unique cache line when sc fails.

> 
> Otherwise you might easily find that your cmpxchg loops cause
> horrendous cacheline ping-pong patterns.
> 
> Of course, if your hardware is bad at releasing the written state,
> that may actually be what you want, to see changes in a timely manner.
> 
> At least some of our cmpxchg uses are the "try_cmpxchg()" pattern,
> which wouldn't even loop - and won't write at all - on a value
> mismatch.
> 
> And some of those try_cmpxchg cases are a lot more important than the
> lockref code. Things like spin_trylock() etc. Of course, for best
> results you might want to have an actual architecture-specific helper
> for the try_cmpxchg case, and use the compiler for "outputs in
> condition codes" (but then you need to have fallback cases for older
> compilers that don't support it).
> 
> See the code code for example of the kinds of nasty support code you need with
> 
>   /*
>    * Macros to generate condition code outputs from inline assembly,
>    * The output operand must be type "bool".
>    */
>   #ifdef __GCC_ASM_FLAG_OUTPUTS__
>   # define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
>   # define CC_OUT(c) "=@cc" #c
>   #else
>   # define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
>   # define CC_OUT(c) [_cc_ ## c] "=qm"
>   #endif
> 
> and then a lot of "CC_SET()/CC_OUT()" use in the inline asms in
> <asm/cmpxchg.h>...
Thanks for the tip. It's helpful to try_cmpxchg optimization.

> 
> IOW, you really should time this and then add the timing information
> to whatever commit message.
> 
>              Linus
> 

