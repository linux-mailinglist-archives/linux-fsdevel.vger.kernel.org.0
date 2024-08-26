Return-Path: <linux-fsdevel+bounces-27106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD6E95EA4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE8C285F1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E91D12D1E9;
	Mon, 26 Aug 2024 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WRvWNHkl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75222071;
	Mon, 26 Aug 2024 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657070; cv=none; b=nxf2Q6cK8XfLrPuY/3WOUsZAtmGzzkqXRnnyArbbRsW/89Cpcxm79NmCgnDu6xynJG0I6rk4Aulwa0wfe0oJtY96dgzvSCjSKYrfmAT9bh+iURoR3Xq7Lf0tISEz6apHyXMn5enu3GpYixrR1WTBckRNSphOp5cGz812emqec+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657070; c=relaxed/simple;
	bh=GtFc7xCyj5PhXPTfXtXpN7lJ60XrHzRvFzuO/ud9I5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdoRz52FjOtdo6sO44cyjTS86HIXhLdAvJSTV0Xn3gkznJgkwRBybmQ2MQXeu+BwtHU6/yHhhFbmJl+4Bsa+48sdmKYweX7C7F4VojbxkxHNY9c39/K+KC4msAo1JIB1bUTKR+3vA8ROUNNAmZCz+djPwjV7w5fL/fV5ZJjmwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WRvWNHkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AFAC4FDFE;
	Mon, 26 Aug 2024 07:24:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WRvWNHkl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724657065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XYrcqllZpLLj+sqSt83ZS4OGpB+ny/dHDpTQVKEcw0=;
	b=WRvWNHkl3kMGmPVF84AOTFbuLtotKvO5WMOvOcjiQTO5GGt6yxvAvXfJ5NC3ABH4Au/AaH
	lXGxAvyyPehGMUl9Mc67zHgogobiWleqNKnOoQ+iYXZybbgRN4TFpXcnAnXpsJUY6u7XVU
	ZC6nTPIX+X1v5ceKtm4RmJaWa03cBCQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e51e9de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 07:24:25 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:24:16 +0200
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
Subject: Re: [PATCH v2 03/17] vdso: Add __arch_get_k_vdso_rng_data()
Message-ID: <ZswtoMbWC3se1su3@zx2c4.com>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <30560b394eaa00fded11fa5bbe5f679c7ffe1714.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30560b394eaa00fded11fa5bbe5f679c7ffe1714.1724309198.git.christophe.leroy@csgroup.eu>

On Thu, Aug 22, 2024 at 09:13:11AM +0200, Christophe Leroy wrote:
> _vdso_data is specific to x86 and __arch_get_k_vdso_data() is provided
> so that all architectures can provide the requested pointer.
> 
> Do the same with _vdso_rng_data, provide __arch_get_k_vdso_rng_data()
> and don't use x86 _vdso_rng_data directly.
> 
> Until now vdso/vsyscall.h was only included by time/vsyscall.c but now
> it will also be included in char/random.c, leading to a duplicate
> declaration of _vdso_data and _vdso_rng_data.
> 
> To fix this issue, move declaration in a C file. vma.c looks like the
> most appropriate candidate. Don't need to replace the definitions in
> vsyscall.h by declarations as declarations are already in asm/vvar.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Move x86 DEFINE_VVAR(_vdso_data) and DEFINE_VVAR(_vdso_rng_data) in vma.c

Thanks, this seems sane to me. I'll apply this now to random.git as a
fix; it should have been done this way before and is going to be a
headache to coordinate later.

Jason

