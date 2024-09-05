Return-Path: <linux-fsdevel+bounces-28763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02A096DF51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 18:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226CDB25F65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83EF19FA92;
	Thu,  5 Sep 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HegSE7me"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E819DF75;
	Thu,  5 Sep 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552820; cv=none; b=uVU+r3Qyh6dj3kR8lc8Ip/pGfJVgxR2UlcizdXWmT9SKZMZLETVycDzMFJDmx4X7v7OJP8oBVm5LblwtlyzcCIoep4For/HpFYguvFPr0jzuid+YoDPbGXguAZcYlUELvyJ8aNU+Q5hg+Ymi5ktoLaax7F6ROgDAGrd/o6EhdXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552820; c=relaxed/simple;
	bh=Ujb5yHl8obhHTgrsI+TQzp2K6D+LmQ7g6VfbyKGco00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kqs/0v/jqGQG11+Te/oZWPXK6BpFoQywl4/DVt2VxFGlVrKJSz+/h9hHjfhQ4A/yPk0Ct3nZ73tI7SaupUx1VUSTjFQi7a0LltjEwbJrK2lNIkj5G1Eq0NDtjb9GPmrYAjq0e+3UZDECCkrhPwVBsthaGE5FVLWfdMMupGM7XHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HegSE7me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C3EC4CEC3;
	Thu,  5 Sep 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HegSE7me"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725552814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55bJknDRImEIEh83mNWUbwqRYAr8coQT4CUKKDd4gNA=;
	b=HegSE7mehyaj6SAp/VnhlvGaaf85fyzlVkfWcnn7sUGLHgxLA3R706+39iH7IugfbGGag4
	p5FlY4bhYQq8YynPTQwVluyERdi6BU1onSw+v7PJ1EWAFn80DQmJzY/8vYGa8CRoj7fR1k
	Bvw94kDNyDv1iVrUc3RWVgEGHcyil8w=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ecc21b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 16:13:33 +0000 (UTC)
Date: Thu, 5 Sep 2024 18:13:29 +0200
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
Message-ID: <ZtnYqZI-nrsNslwy@zx2c4.com>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f49c2ce009f8b007ab0676fb41187b2d54f28b2.1725304404.git.christophe.leroy@csgroup.eu>

> +/*
> + * The macro sets two stack frames, one for the caller and one for the callee
> + * because there are no requirement for the caller to set a stack frame when
> + * calling VDSO so it may have omitted to set one, especially on PPC64
> + */
> +
> +.macro cvdso_call funct
> +  .cfi_startproc
> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> +	mflr		r0
> +	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
> +  .cfi_adjust_cfa_offset PPC_MIN_STKFRM
> +	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> +  .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
> +	get_datapage	r8
> +	addi		r8, r8, VDSO_RNG_DATA_OFFSET
> +	bl		CFUNC(DOTSYM(\funct))
> +	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> +	cmpwi		r3, 0
> +	mtlr		r0
> +	addi		r1, r1, 2 * PPC_MIN_STKFRM
> +  .cfi_restore lr
> +  .cfi_def_cfa_offset 0
> +	crclr		so
> +	bgelr+
> +	crset		so
> +	neg		r3, r3
> +	blr
> +  .cfi_endproc
> +.endm

You wrote in an earlier email that this worked with time namespaces, but
in my testing that doesn't seem to be the case.

From my test harness [1]:

Normal single thread
   vdso: 25000000 times in 12.494133131 seconds
   libc: 25000000 times in 69.594625188 seconds
syscall: 25000000 times in 67.349243972 seconds
Time namespace single thread
   vdso: 25000000 times in 71.673057436 seconds
   libc: 25000000 times in 71.712774121 seconds
syscall: 25000000 times in 66.902318080 seconds

I'm seeing this on ppc, ppc64, and ppc64le.

Can you figure out what's going on and send a fix, which I'll squash
into this commit?

Jason

[1] https://git.zx2c4.com/linux-rng/commit/?h=jd/vdso-test-harness

