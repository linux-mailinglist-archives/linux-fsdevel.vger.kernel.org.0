Return-Path: <linux-fsdevel+bounces-28792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD4396E447
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 22:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1392D1C23CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 20:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63021A76B0;
	Thu,  5 Sep 2024 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vmhr4xm1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024A1A3BB9;
	Thu,  5 Sep 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568909; cv=none; b=qCaQkczc8dLk7XAiLFbV90s8/8Xx2M3kKWQc+AFrtnBLDdlumIvQ0YWLllGAul258iuiVQCd5t68Ap4y7FJpCT3/KATXmdTiAEw+9j2S5aaZOwu2uc7rpZLm363shHjbaE8LgeCqCT5vDKp/PSwIyjbEalA8oyS6+X6RvfuALQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568909; c=relaxed/simple;
	bh=1pTKkK+g3LwaTtJ584c38j5d6WNE2g/owBxKg20Z/ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZSKdCkfOWoYR+LV2AP2Al3M++Ij2ln0XHwZ0TTJt7QspiFhWN/1b47S8r06OgXO1X2stTG+oxD8iLDQ2QMdo86EYPupFyrzoY5D4IW9z1qx9v3B95OcD0InISzZLYCtNw+B9HHO/rbRcXqxMhjr4+MHb5DdepuKin62dDbnktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Vmhr4xm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398A0C4CEC3;
	Thu,  5 Sep 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Vmhr4xm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725568904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeN0hion7E5T8bnC9bEQSPstkGSkSwCA9M/4YZOxoLs=;
	b=Vmhr4xm1Wp03ugcdrYba3ciO2c/OQp0oQM3tMCUeyv/y6IZN4vNwmCaOuwFQTFlZjTxzGh
	vyDmKYOWlgz6gVR/SY11McK85Ld05NIERlGr0h62hGj7fSc/8dsPEgJIDmwgO9QkzhtMl2
	G9lC+jvPOPB9VCi02VaBflNkREEbT7Y=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 48b42c3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 20:41:44 +0000 (UTC)
Date: Thu, 5 Sep 2024 22:41:40 +0200
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
Message-ID: <ZtoXhGYflBNR74g0@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
 <ZtnYqZI-nrsNslwy@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtnYqZI-nrsNslwy@zx2c4.com>

On Thu, Sep 05, 2024 at 06:13:29PM +0200, Jason A. Donenfeld wrote:
> > +/*
> > + * The macro sets two stack frames, one for the caller and one for the callee
> > + * because there are no requirement for the caller to set a stack frame when
> > + * calling VDSO so it may have omitted to set one, especially on PPC64
> > + */
> > +
> > +.macro cvdso_call funct
> > +  .cfi_startproc
> > +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > +	mflr		r0
> > +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> > +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> > +	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > +  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
> > +	get_datapage	r8
> > +	addi		r8, r8, VDSO_RNG_DATA_OFFSET
> > +	bl		CFUNC(DOTSYM(\funct))
> > +	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> > +	cmpwi		r3, 0
> > +	mtlr		r0
> > +	addi		r1, r1, 2 * PPC_MIN_STKFRM
> > +  .cfi_restore lr
> > +  .cfi_def_cfa_offset 0
> > +	crclr		so
> > +	bgelr+
> > +	crset		so
> > +	neg		r3, r3
> > +	blr
> > +  .cfi_endproc
> > +.endm
> 
> Can you figure out what's going on and send a fix, which I'll squash
> into this commit?

This doesn't work, but I wonder if something like it is what we want. I
need to head out for the day, but here's what I've got. It's all wrong
but might be of interest.

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
index a957cd2b2b03..bc49eb87cfd1 100644
--- a/arch/powerpc/kernel/vdso/getrandom.S
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -32,7 +32,7 @@
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
 	get_datapage	r8
-	addi		r8, r8, VDSO_RNG_DATA_OFFSET
+	addi		r9, r8, VDSO_RNG_DATA_OFFSET
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


