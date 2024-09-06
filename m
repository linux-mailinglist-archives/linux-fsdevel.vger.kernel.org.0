Return-Path: <linux-fsdevel+bounces-28821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04C996E7E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 04:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C091B23B44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 02:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A73B298;
	Fri,  6 Sep 2024 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bRX4+VzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C34171CD;
	Fri,  6 Sep 2024 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725590918; cv=none; b=NCOdaXODvfA1824Yj6X5k9F6tmbR6xWCn7bSyo1NUuxsvyUJaoUx906X88+pPSz7sL0QPxixglYH8K8Js1haItWb8kDHehpo/BfSeJza8yGEl6VuaJE+y+NjunDNe930I4MRbifUA3FDvNNMS4ZOcz3a+Zh0Y2V6IDSlWggNUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725590918; c=relaxed/simple;
	bh=pzJlw2IoPHrFAAWumd0ORTINL6ZPVNgxfaErncZQH8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtEOQwxFpf3Q4EKMehjIX4m7xd5B1Y03opwrHavNiS5cRRTyh6mykaiPfgnbCLfX9gnHI0M8oi8cx/Bx5IN101IcB9nXl5Grm32V6Cl+vKDV8+2vj3WFzOyc2bdaAC8mZRG8ZJKatAJg9aOWHXhWA2PUHHRxFBqVjHeZs9ZQba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=bRX4+VzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754BFC4CEC3;
	Fri,  6 Sep 2024 02:48:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bRX4+VzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725590913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDin/TTzmHCatsL5YEP7qml5EKwCyw3+unP9HsNBBks=;
	b=bRX4+VzElx6AhF7yIERy0JoxrcqZ8w2XnNUX4cySvATmmNIgFgKdGdfDY+DT1KfFqexJRX
	9BvfkivoCdg2WCBNWf5LjK2iwqnwDbLFu2UJPBepJhXrsh39RcDJ68oyyRJJCk1qgWS81f
	K191Ft9MxUKb0Efd83zvLBnDi2pl2n4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ee168b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 02:48:32 +0000 (UTC)
Date: Fri, 6 Sep 2024 04:48:28 +0200
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
Message-ID: <ZtptfOicjZU3k3ZV@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
 <ZtnYqZI-nrsNslwy@zx2c4.com>
 <ZtoXhGYflBNR74g0@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtoXhGYflBNR74g0@zx2c4.com>

On Thu, Sep 05, 2024 at 10:41:40PM +0200, Jason A. Donenfeld wrote:
> On Thu, Sep 05, 2024 at 06:13:29PM +0200, Jason A. Donenfeld wrote:
> > > +/*
> > > + * The macro sets two stack frames, one for the caller and one for the callee
> > > + * because there are no requirement for the caller to set a stack frame when
> > > + * calling VDSO so it may have omitted to set one, especially on PPC64
> > > + */
> > > +
> > > +.macro cvdso_call funct
> > > +  .cfi_startproc
> > > +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > > +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > > +	mflr		r0
> > > +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > > +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > > +	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > > +  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
> > > +	get_datapage	r8
> > > +	addi		r8, r8, VDSO_RNG_DATA_OFFSET
> > > +	bl		CFUNC(DOTSYM(\funct))
> > > +	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > > +	cmpwi		r3, 0
> > > +	mtlr		r0
> > > +	addi		r1, r1, 2 * PPC_MIN_STKFRM
> > > +  .cfi_restore lr
> > > +  .cfi_def_cfa_offset 0
> > > +	crclr		so
> > > +	bgelr+
> > > +	crset		so
> > > +	neg		r3, r3
> > > +	blr
> > > +  .cfi_endproc
> > > +.endm
> > 
> > Can you figure out what's going on and send a fix, which I'll squash
> > into this commit?
> 
> This doesn't work, but I wonder if something like it is what we want. I
> need to head out for the day, but here's what I've got. It's all wrong
> but might be of interest.

Oh, I just got one small detail wrong before. The below actually works,
and uses the same strategy as on arm64.

Let me know if you'd like me to fix up this commit with the below patch,
or if you have another way you'd like to go about it.

diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
index 501d6bb14e8a..acb271709d30 100644
--- a/arch/powerpc/include/asm/vdso/getrandom.h
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -47,7 +47,8 @@ static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
 }

 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
-			     size_t opaque_len, const struct vdso_rng_data *vd);
+			     size_t opaque_len, const struct vdso_data *vd,
+			     const struct vdso_rng_data *vrd);

 #endif /* !__ASSEMBLY__ */

diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
index a957cd2b2b03..64cc1fad3ccc 100644
--- a/arch/powerpc/kernel/vdso/getrandom.S
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -32,7 +32,8 @@
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
 	get_datapage	r8
-	addi		r8, r8, VDSO_RNG_DATA_OFFSET
+	addi		r9, r8, VDSO_RNG_DATA_OFFSET
+	addi		r8, r8, VDSO_DATA_OFFSET
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
 #ifdef __powerpc64__
diff --git a/arch/powerpc/kernel/vdso/vgetrandom.c b/arch/powerpc/kernel/vdso/vgetrandom.c
index 5f855d45fb7b..408c76036868 100644
--- a/arch/powerpc/kernel/vdso/vgetrandom.c
+++ b/arch/powerpc/kernel/vdso/vgetrandom.c
@@ -8,7 +8,10 @@
 #include <linux/types.h>

 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
-			     size_t opaque_len, const struct vdso_rng_data *vd)
+			     size_t opaque_len, const struct vdso_data *vd,
+			     const struct vdso_rng_data *vrd)
 {
-	return __cvdso_getrandom_data(vd, buffer, len, flags, opaque_state, opaque_len);
+	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
+		vrd = (void *)vrd + (1UL << CONFIG_PAGE_SHIFT);
+	return __cvdso_getrandom_data(vrd, buffer, len, flags, opaque_state, opaque_len);
 }


