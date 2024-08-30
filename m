Return-Path: <linux-fsdevel+bounces-28074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 622639666A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3291B253F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE641B8EB3;
	Fri, 30 Aug 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X4B3Z3+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3111B86E3;
	Fri, 30 Aug 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034495; cv=none; b=mcgb+k7bpG49Fu0LiLeWSd43nv9iYlBV+bMqMnqXhLT2bQAzLU+X39Jlficc/gjUeXDd/CBKcHzz6bVK6VPFQ7kp1I/Beyw77wn/YSwQmtUwpxY7gRpaUYU8wWtJZjY+xmrZg1BJ5Cr8dgEqEOAURNSoHD1b64Ghv6UfmqIqQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034495; c=relaxed/simple;
	bh=Sq577XF9X9W/Wv4eIA97DY3A+nUrzqzWnVO86TTyQ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqWwRe0+GN33tYP+foTEO4tr2Jb5QnTKcRmIcDK1NwYQAqvl8PpMN1qx23aFiuIA1/f5fVC7qa1vtWb94KHBrA7qUU7fCEPmcAF7Qsk1j7dI4RSy4C7iV1EcpZ+pWdG8ArT6WRbsV0hHSZv12gvPI7W1XRN+NKr6jWM+D7auPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=X4B3Z3+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933EBC4CEC2;
	Fri, 30 Aug 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X4B3Z3+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725034490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hP39KjvEhHFzK05596i191mBdhVDUqtp/Tqc+PvtOIk=;
	b=X4B3Z3+RRpb6hKFMi1l1zo0Djitaj3Er0l8oTk/JJVDXNAhN1AX8yFBysIBe+ckynP2qVO
	nyIQFAJq9DymFp/Kl5+S0iFSvp3phz7shrdSoqpPTsxO0USvCUxu6X0wOHej+YBpOuYBLG
	er0UTBm+MFCED3Ceb8+SRsiPuJfgJrg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7100d0c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 16:14:50 +0000 (UTC)
Date: Fri, 30 Aug 2024 18:14:45 +0200
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
Subject: Re: [PATCH v3 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC32
Message-ID: <ZtHv9R8b7qwWKR2b@zx2c4.com>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
 <e7e4c6d36cf98229850c333f113bcea909564501.1725031952.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7e4c6d36cf98229850c333f113bcea909564501.1725031952.git.christophe.leroy@csgroup.eu>

On Fri, Aug 30, 2024 at 05:57:08PM +0200, Christophe Leroy wrote:
> + *	r5: 8-byte counter input/output (saved on stack)
> + *
> + *	r14-r15: counter
> + */
> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> +	stwu	r1, -96(r1)
> +	stw	r5, 20(r1)
> +	stmw	r14, 24(r1)
> +	li	r31, 4
> +	LWZX_LE	r14, 0, r5
> +	LWZX_LE	r15, r31, r5

Why swap endian on the counter?

