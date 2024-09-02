Return-Path: <linux-fsdevel+bounces-28254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D1696894E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D406B20F2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547B20FABF;
	Mon,  2 Sep 2024 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X99r7ucy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C519E98B;
	Mon,  2 Sep 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285633; cv=none; b=L0VGBsuX55KjXbBfHTT5NgXESAHzeTbrdf5LP8j1wWOv99hWbJGvutxc16s728RvidQBGTGQqbC0x2N/v2hKu0ULpV8+zGRW9fRTZYs0dklGSsljH47xQ54aUHKAD6nuq9XhBQ3EUTV9y2zqwHwlaXIBeHjOlNs0n3RrqmYHQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285633; c=relaxed/simple;
	bh=OQBMCh4vthF1sv7FzHbCcRcPNYlzj1fNfENXE1VjT1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXFTeW4+i8MJgN4KkgElK2D4cxUchPAVxGWFhPmanY60ihRcRuKxoxU1oOdGRkIIxf0XV5e8RhheHmSWpoeMsKi0zFohSPyOvzx8Q7jwltMfo9mr/lh5elvHrZWkSXI6mUdKaRDT9lBgwqXSSdFSK9Or5aoHYVFmlaiGDZVuoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=X99r7ucy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4E3C4CEC2;
	Mon,  2 Sep 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X99r7ucy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725285629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dH1tTlDFz02LirzapNYJOjvf27rZrsn4qQhBH9PXJJI=;
	b=X99r7ucyzGQYz7BV9t3L42iNhMq4Gphnca5YBUq9T8Om5gEZzj1YIOYWEfXnn1VQwl8yQU
	8dh8jff+3pIFuuuweAdnIGuZm/DTbFo6qJfXoT4ZY0IHBzAX9pRhxb8I6Wcc6Mk6KtYGP0
	9nZRx5Gug0R98ELGgORIOU8/WjjAKP0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 26b40413 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 14:00:28 +0000 (UTC)
Date: Mon, 2 Sep 2024 16:00:24 +0200
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
Message-ID: <ZtXE-AISB4w9U9Yc@zx2c4.com>
References: <cover.1725278148.git.christophe.leroy@csgroup.eu>
 <27de70dcc356e56754a03a2887a97597f5e840a4.1725278148.git.christophe.leroy@csgroup.eu>
 <ZtWyeuCfzZ66fVsg@zx2c4.com>
 <bdf1a515-b3d0-471d-89ee-989ae0d63202@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdf1a515-b3d0-471d-89ee-989ae0d63202@csgroup.eu>

On Mon, Sep 02, 2024 at 03:12:47PM +0200, Christophe Leroy wrote:
> 
> 
> Le 02/09/2024 à 14:41, Jason A. Donenfeld a écrit :
> > On Mon, Sep 02, 2024 at 02:04:42PM +0200, Christophe Leroy wrote:
> >>   SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> >>   #ifdef __powerpc64__
> >> -	blr
> >> +	std	r5, -216(r1)
> >> +
> >> +	std	r14, -144(r1)
> >> +	std	r15, -136(r1)
> >> +	std	r16, -128(r1)
> >> +	std	r17, -120(r1)
> >> +	std	r18, -112(r1)
> >> +	std	r19, -104(r1)
> >> +	std	r20, -96(r1)
> >> +	std	r21, -88(r1)
> >> +	std	r22, -80(r1)
> >> +	std	r23, -72(r1)
> >> +	std	r24, -64(r1)
> >> +	std	r25, -56(r1)
> >> +	std	r26, -48(r1)
> >> +	std	r27, -40(r1)
> >> +	std	r28, -32(r1)
> >> +	std	r29, -24(r1)
> >> +	std	r30, -16(r1)
> >> +	std	r31, -8(r1)
> >>   #else
> >>   	stwu	r1, -96(r1)
> >>   	stw	r5, 20(r1)
> >> +#ifdef __BIG_ENDIAN__
> >>   	stmw	r14, 24(r1)
> >> +#else
> >> +	stw	r14, 24(r1)
> >> +	stw	r15, 28(r1)
> >> +	stw	r16, 32(r1)
> >> +	stw	r17, 36(r1)
> >> +	stw	r18, 40(r1)
> >> +	stw	r19, 44(r1)
> >> +	stw	r20, 48(r1)
> >> +	stw	r21, 52(r1)
> >> +	stw	r22, 56(r1)
> >> +	stw	r23, 60(r1)
> >> +	stw	r24, 64(r1)
> >> +	stw	r25, 68(r1)
> >> +	stw	r26, 72(r1)
> >> +	stw	r27, 76(r1)
> >> +	stw	r28, 80(r1)
> >> +	stw	r29, 84(r1)
> >> +	stw	r30, 88(r1)
> >> +	stw	r31, 92(r1)
> >> +#endif
> >> +#endif
> > 
> > This confuses me. Why are you adding code to the !__powerpc64__ branch
> > in this commit? (Also, why does stmw not work on LE?)
> 
> That's for the VDSO32 ie running 32 bits binaries on a 64 bits kernel.
> 
> "Programming Environments Manual for 32-Bit Implementations of the 
> PowerPC™ Architecture" say: In some implementations operating with 
> little-endian byte order, execution of an lmw or stmw instruction
> causes the system alignment error handler to be invoked
> 
> And GCC doesn't like it either:
> 
> tools/arch/powerpc/vdso/vgetrandom-chacha.S:84: Error: `stmw' invalid 
> when little-endian

Does it make sense to do all the 32-bit stuff in the PPC32 commit (and
then you can introduce the selftests there without the error you
mentioned), and then add the 64-bit stuff in this commit?

