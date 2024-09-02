Return-Path: <linux-fsdevel+bounces-28245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5909687B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C13B255BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC56F19C551;
	Mon,  2 Sep 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M4l7tvQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46590DF71;
	Mon,  2 Sep 2024 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280907; cv=none; b=nvFULX7Gt4yAjdDNGZnibkqTNFkMu9hnDJZ8xK5fkjXiX1TZVQiwQGpNmOV0S7ZgIZyjSyG/boYNihiflEKUMYFg153YV3IVJeKQKFBeYUibf96VNCnkb5Emxn1loqeSBhs28F79V3LHDqZGfrgMY76A8SqtTWJ1LoHrL54BeZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280907; c=relaxed/simple;
	bh=IgwKEHs7S8iTZYd/hP3CvwexKCli3HVlsnSvaqJwjn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0maGkJylOxvA6FSCgvqYnpLUSjohAkI+c1I0pCoHkagcK1qbRSofgccWecIqV5xoaftfUBmFZM2kP+mblUO/+bLyVPuYY7uQ8FMM+uD8FLvyHPSXhvRSlg4/ZizY9NM36qXsCkgE9aiQz9+459RyeMgVwdIqfYx0z55u5jyO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=M4l7tvQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743FAC4CEC2;
	Mon,  2 Sep 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M4l7tvQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725280902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbTBvowwyqT3oktU3TVamYzwl3zcSe2e1nUrzf5xWhI=;
	b=M4l7tvQZwQqTIhDhEWMzWRgk170y1R8WZOVuU9ydtbdFJffbSwgyBcPmyblIcx3RaFuuft
	0P1p7MEgxZ3b5Ms3Cv7Fo3H/sfGe8NhzU87uuO6Yo/cbI9eyDQYOhSvjsK5nWiAA+exnbi
	zSdAwQMYfNPZ9fMXx3kRAE0vEnV4nRQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db49d980 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 12:41:42 +0000 (UTC)
Date: Mon, 2 Sep 2024 14:41:30 +0200
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
Subject: Re: [PATCH v4 5/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC64
Message-ID: <ZtWyeuCfzZ66fVsg@zx2c4.com>
References: <cover.1725278148.git.christophe.leroy@csgroup.eu>
 <27de70dcc356e56754a03a2887a97597f5e840a4.1725278148.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27de70dcc356e56754a03a2887a97597f5e840a4.1725278148.git.christophe.leroy@csgroup.eu>

On Mon, Sep 02, 2024 at 02:04:42PM +0200, Christophe Leroy wrote:
>  SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>  #ifdef __powerpc64__
> -	blr
> +	std	r5, -216(r1)
> +
> +	std	r14, -144(r1)
> +	std	r15, -136(r1)
> +	std	r16, -128(r1)
> +	std	r17, -120(r1)
> +	std	r18, -112(r1)
> +	std	r19, -104(r1)
> +	std	r20, -96(r1)
> +	std	r21, -88(r1)
> +	std	r22, -80(r1)
> +	std	r23, -72(r1)
> +	std	r24, -64(r1)
> +	std	r25, -56(r1)
> +	std	r26, -48(r1)
> +	std	r27, -40(r1)
> +	std	r28, -32(r1)
> +	std	r29, -24(r1)
> +	std	r30, -16(r1)
> +	std	r31, -8(r1)
>  #else
>  	stwu	r1, -96(r1)
>  	stw	r5, 20(r1)
> +#ifdef __BIG_ENDIAN__
>  	stmw	r14, 24(r1)
> +#else
> +	stw	r14, 24(r1)
> +	stw	r15, 28(r1)
> +	stw	r16, 32(r1)
> +	stw	r17, 36(r1)
> +	stw	r18, 40(r1)
> +	stw	r19, 44(r1)
> +	stw	r20, 48(r1)
> +	stw	r21, 52(r1)
> +	stw	r22, 56(r1)
> +	stw	r23, 60(r1)
> +	stw	r24, 64(r1)
> +	stw	r25, 68(r1)
> +	stw	r26, 72(r1)
> +	stw	r27, 76(r1)
> +	stw	r28, 80(r1)
> +	stw	r29, 84(r1)
> +	stw	r30, 88(r1)
> +	stw	r31, 92(r1)
> +#endif
> +#endif

This confuses me. Why are you adding code to the !__powerpc64__ branch
in this commit? (Also, why does stmw not work on LE?)

