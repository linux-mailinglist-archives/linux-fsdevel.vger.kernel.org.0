Return-Path: <linux-fsdevel+bounces-28075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D318F9666A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895F11F22079
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52041B3B13;
	Fri, 30 Aug 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JpbhujkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE032905;
	Fri, 30 Aug 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034661; cv=none; b=ZzVPk3Uj1nt/L6PIBnqk7zKiybUUFLWpQ80gOM8n0yMinctqaheTtdg32pFlLBHEXmomk0MGWS0Q6pR1RVFxVXWs9I3PElpqS9FlXbxe+RG0NQem9rIkkZ0fp0meZniuYyHTHh96xemNC9wMIVMPaF/vNuZD9kOrAMZEc1WxeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034661; c=relaxed/simple;
	bh=PESWvca7bydI3IKq+BYrWokTPYsCRYr5lzdXuLEOB0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzj3Q+tsuF57PUbEtRU+hIEnEbwAWrZq/Yt0JC4wV2vwTfNgovfXMSM/0PWI+AsG/lb5uJSjiGhgv/SsaJDeJbzqqISTmTnsTHr0kCJfhIh73sJAdzttBCjesD6YknYe1YMDXkLX47SG69JjWI4vAygYRWDvDYhK11O4p5Qqmtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JpbhujkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB6AC4CEC2;
	Fri, 30 Aug 2024 16:17:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JpbhujkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725034657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4V9WSctwTuWuaC+9YWeMzjXHA67ruA71pLDIgbwvzQM=;
	b=JpbhujkJUXq1uk0Y0jqDBpxTfnVNfq53N2rv5YQsHeCptpCOwgh3bCbr/YIMxylwO3n5No
	TnOFlxyTKJEG2X1X/9gM2gvPyskQiCmifotrmFx2qf7yyQJjLTybZ8GLL+cn/0YbdYgx6z
	7oh7adhrtquvMjsiHA2IQwUSPYbEkrA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21e77804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 16:17:37 +0000 (UTC)
Date: Fri, 30 Aug 2024 18:17:33 +0200
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
Message-ID: <ZtHwnc4AZuRULkom@zx2c4.com>
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
> @@ -14,6 +14,10 @@ ifeq ($(uname_M),x86_64)
>  TEST_GEN_PROGS += vdso_test_getrandom
>  TEST_GEN_PROGS += vdso_test_chacha
>  endif
> +ifeq ($(ARCH),powerpc)
> +TEST_GEN_PROGS += vdso_test_getrandom
> +TEST_GEN_PROGS += vdso_test_chacha
> +endif

FYI, as of [1], you should now be able to add powerpc to the filter list
instead of having to duplicate a new stanza:

[1] https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=bbaae98172ed284fc0d5d39cc0d68f5d06164f06

