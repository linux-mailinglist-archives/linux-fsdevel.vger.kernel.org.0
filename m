Return-Path: <linux-fsdevel+bounces-28823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C341C96E82F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 05:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36AC9B23D64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 03:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F2481B7;
	Fri,  6 Sep 2024 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lWXUkZvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E764594D;
	Fri,  6 Sep 2024 03:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593073; cv=none; b=o7ygxrRh8NuIZ6aHsKTI3w7C5p69xe0VBK4T25uLYb9biMKEGQZv7DBd3wG+JEoGMHAPOhv3SsC+fv77K+ZvObjH5qRuu7Zync5X765F/0sEA4/ZOlmaMdPduyjgpDBABY48ijxZXIoxan6ne8vFqh/aJNRI5+AB90YLl+2vVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593073; c=relaxed/simple;
	bh=wfQzaJMpMaVFDS+iwo6CFaUv6FyRkEZbifJAijJc6BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnONqEZafn4kSlXlbAx6vD9fz2xR81nWi9vymdfpFuVAK7lyWOzoDNxZyz3+QuXdlDBC2RzyMS9Wg7ecm1sWuHog7Iz4IKM4XNVdXZjxJmwC8USwsmWlxwk5jmHlisoJmkaLjws+ZMFWNRfcTEpRJ2HPnW6gT624joZ5rdGRqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lWXUkZvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC162C4CEC3;
	Fri,  6 Sep 2024 03:24:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lWXUkZvb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725593069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2dxDPKKa2YK6AR5mLMyQ8i6dADRrELxYn6efyeudEY=;
	b=lWXUkZvbvlbUyOMCWA1zuc7ad4c+I0UJcawqwTucUHLSLfjSoDcXGiWc2V7qkYM6p9qDOE
	xqMX7fe/Xfh9D0076bwd4NPqJu9BUto8QUy3Vo/4JDK4c4+j1HrSQbP9/ilbY+G0btPrj7
	0Zg0qZDITzK9zGSnoBQ0QQgntbqq/qk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 182a6eb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 03:24:28 +0000 (UTC)
Date: Fri, 6 Sep 2024 05:24:24 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v5 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on VDSO32
Message-ID: <Ztp16FkqG0ALlXnh@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
 <ZtnYqZI-nrsNslwy@zx2c4.com>
 <ZtoXhGYflBNR74g0@zx2c4.com>
 <ZtptfOicjZU3k3ZV@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtptfOicjZU3k3ZV@zx2c4.com>

On Fri, Sep 06, 2024 at 04:48:28AM +0200, Jason A. Donenfeld wrote:
> On Thu, Sep 05, 2024 at 10:41:40PM +0200, Jason A. Donenfeld wrote:
> > On Thu, Sep 05, 2024 at 06:13:29PM +0200, Jason A. Donenfeld wrote:
> > > > +/*
> > > > + * The macro sets two stack frames, one for the caller and one for the callee
> > > > + * because there are no requirement for the caller to set a stack frame when
> > > > + * calling VDSO so it may have omitted to set one, especially on PPC64
> > > > + */
> > > > +
> > > > +.macro cvdso_call funct
> > > > +  .cfi_startproc
> > > > +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > > > +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > > > +	mflr		r0
> > > > +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > > > +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > > > +	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > > > +  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
> > > > +	get_datapage	r8
> > > > +	addi		r8, r8, VDSO_RNG_DATA_OFFSET
> > > > +	bl		CFUNC(DOTSYM(\funct))
> > > > +	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > > > +	cmpwi		r3, 0
> > > > +	mtlr		r0
> > > > +	addi		r1, r1, 2 * PPC_MIN_STKFRM
> > > > +  .cfi_restore lr
> > > > +  .cfi_def_cfa_offset 0
> > > > +	crclr		so
> > > > +	bgelr+
> > > > +	crset		so
> > > > +	neg		r3, r3
> > > > +	blr
> > > > +  .cfi_endproc
> > > > +.endm
> > > 
> > > Can you figure out what's going on and send a fix, which I'll squash
> > > into this commit?
> > 
> > This doesn't work, but I wonder if something like it is what we want. I
> > need to head out for the day, but here's what I've got. It's all wrong
> > but might be of interest.
> 
> Oh, I just got one small detail wrong before. The below actually works,
> and uses the same strategy as on arm64.
> 
> Let me know if you'd like me to fix up this commit with the below patch,
> or if you have another way you'd like to go about it.

And here's the much shorter version in assembly, which maybe you prefer.
Also works, and is a bit less invasive than the other thing.

diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
index a957cd2b2b03..070daba2d547 100644
--- a/arch/powerpc/kernel/vdso/getrandom.S
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -32,6 +32,14 @@
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
 	get_datapage	r8
+#ifdef CONFIG_TIME_NS
+	lis		r10, 0x7fff
+	ori		r10, r10, 0xffff
+	lwz		r9, VDSO_DATA_OFFSET + 4(r8)
+	cmpw		r9, r10
+	bne		+8
+	addi		r8, r8, (1 << CONFIG_PAGE_SHIFT)
+#endif
 	addi		r8, r8, VDSO_RNG_DATA_OFFSET
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)


