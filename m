Return-Path: <linux-fsdevel+bounces-27111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EC595EA8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E022B21CEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F213A256;
	Mon, 26 Aug 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DBRZ6XWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC401129A74;
	Mon, 26 Aug 2024 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657627; cv=none; b=SZ1cSw7Z0JSwIWNMFyfsEVx84jzbMTOBbwpL2agYboKCh0ZXkhmEf22lXK8l52zvGRtDmnCRsPMjcE5rcwUTauG5FmFP+FTQuRDor4McD0+mf9JusVGlS4ZwBAjYO6ejlZmYvLuMMZhbrTjmVekY0/lEhB0OxCVTfm96Y03v68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657627; c=relaxed/simple;
	bh=BZ+Ga7Yx1m5+I1PY9IeYzJ0V0bDr7hy73Wh0TQSBMsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlf0iPqlUVJoq9mZ65ZTeRT4sPRmy1YRF70R70k0PiukOQQt2W3cbfOnAwAKKP+jCueGv73D0OS1JVSAonvD1VJj9zBd9TT4ND75e3BOJKwlw+J9SOazQlydTXShVvn93PlVOVEHmgaYs3EWRDZ3XUkHVzIqz8QK/9yJtVNljZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DBRZ6XWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C2BC8CDC1;
	Mon, 26 Aug 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DBRZ6XWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724657623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7352A08UdB7RMlKrf9ghuchmIx/aoSaJhuAqBuZsFcc=;
	b=DBRZ6XWDvXjnYuYhxFXXFEdwYvgjA29BBUQVXRAglzQXZPgBoyT+pscRKjlI8wD1B6oehQ
	eDbbUGzgcthjGXmofT3JoCTTGtGTgN59VX/jWtlqknExCrO9TPUYQcV1VqXc7cECI/ckoW
	WbweiaFinCYbI/Owc4VJr6Cbd4DY0XY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 35c98243 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:33:43 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:33:34 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 15/17] selftests: vdso: Fix build of test_vdso_chacha
Message-ID: <Zswvzq11-0LARaR2@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <50cc36936b310d8dd6d7539c552cc8dd84052020.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50cc36936b310d8dd6d7539c552cc8dd84052020.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:23AM +0200, Christophe Leroy wrote:
> Replace -isystem by -idirafter
> 
> But this implies that now tools/include/linux/linkage.h is
> included instead of include/linux/linkage.h, so define a stub
> for SYM_FUNC_START() and SYM_FUNC_END().

Thanks! I got step 1, but didn't figure out step 2, and tried to do
things the lazy way instead:

-#include <sodium/crypto_stream_chacha20.h>
 #include <sys/random.h>
 #include <string.h>
 #include <stdint.h>
 #include "../kselftest.h"

 extern void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint8_t *key, uint32_t *counter, size_t nblocks);
+extern int crypto_stream_chacha20(uint8_t *dst_bytes, uint64_t dst_len, const uint8_t *nonce, const uint8_t *key);


Yours is obviously much better, so I'll queue that up instead.

