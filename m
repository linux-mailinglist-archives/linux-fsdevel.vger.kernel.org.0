Return-Path: <linux-fsdevel+bounces-30854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526B98ED8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BD91F21CF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785B153BE4;
	Thu,  3 Oct 2024 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qi1kM4A+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C314F123;
	Thu,  3 Oct 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953405; cv=none; b=cRA4VcIoaiRSdHELeib83Xqq31HN71vk/v1RWW5cV9Uk2t1pcG2ispktpPcwG/wImpNbB+rXUOa09wxXSkP73KVH9YeQkCnJG1VBjHrezEVHv/VUUjlvjAi81ZlCUapTMXlR4UPxZjqzlDFMIuIGMiOpT2OtPR9s9815TiQKFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953405; c=relaxed/simple;
	bh=df2Nbj/hqQVIrGa+4waYwuDbuQZWuWu1AE+VTeU/f70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJx7U6qEibMCwAGT8/2Saw8fTMs4oIrMQOKLeq18beVJZge/mzh9KMfV9YF3uFtIQaXZTm5pCGKqRiIiL6fwg/4AS3pj2SyxUjbP9pa+WE4MG2iMJn4vC0CPBrfnz29mOfT0wB/PSic/YXK3YanEF12bR9kuvPKc0kRLJsMba8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qi1kM4A+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EA9C4CEC5;
	Thu,  3 Oct 2024 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727953404;
	bh=df2Nbj/hqQVIrGa+4waYwuDbuQZWuWu1AE+VTeU/f70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qi1kM4A+RaAdIARpZ5o6qFW04lMQITGmFeI+Agv1TzuVt+oC5bw6dyO9QGVzZc+yA
	 vHwVYzgRyMie6OKvDhY9mlziKIX0IQdHhu5SPfMBOAU5iC0/prGGR44vzImFHiTspW
	 WygKX3YTf8TbnIRWhBnwzrHjnLX6yypHAYSaKPKODk0PVnasgSrvF0npsCFfObBbtB
	 ZnkfcD738tVwS9ipJwD4mmvpU8YYs2+E7F1Z451dZR5iCIsvTp4dJLn7sGH752lEq8
	 o5GOthWHPR7petJ9P1Kpbm1rovHNYXteZoZqcJpoKP4G2M6hKGZpmklHWwozfbuCOL
	 8bGZhf0oO4skQ==
Date: Thu, 3 Oct 2024 12:03:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH 33/33] kselftest/riscv: kselftest for user mode cfi
Message-ID: <b4347055-46f7-4e06-b484-bbf147b80fe4@sirena.org.uk>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
 <20241001-v5_user_cfi_series-v1-33-3ba65b6e550f@rivosinc.com>
 <fdf602e9-a8b1-4f62-9e26-bb62a7202d22@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kAfVHLmbYIIytvqg"
Content-Disposition: inline
In-Reply-To: <fdf602e9-a8b1-4f62-9e26-bb62a7202d22@linuxfoundation.org>
X-Cookie: I'm into SOFTWARE!


--kAfVHLmbYIIytvqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2024 at 05:18:36PM -0600, Shuah Khan wrote:
> On 10/1/24 10:06, Deepak Gupta wrote:

> > +#ifndef __NR_prctl
> > +#define __NR_prctl 167
> > +#endif

> > +#ifndef __NR_map_shadow_stack
> > +#define __NR_map_shadow_stack 453

> Why do we need to define these? Shouldn't including
> asm-generic/unistd.h sufficient?

We have this issue on arm64 as well, there's some issue with directly
pulling in the asm header interfering with libc in some situation (I
can't immediately figure out which situation or which libc to remind
myself what it is though...) so we've got local defines like we do for
the NT_ defines for ptrace.  I see x86 is doing the same.

--kAfVHLmbYIIytvqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb+ee4ACgkQJNaLcl1U
h9CFRQf/ZisHmPhxTo4GA9gvOyCclGJtTt5XbyRTnPd3KzS/hDF/0q+VpUbmWm+Y
SmcaycdcESUg9VOXQZorDB8+tK3kaP7Sg2JmpaLB8yoKfuO3t/rVL6pt/vCKLlgX
qwzZD6zQUDZlBt0SteGmZnXzHDKpjNrYf1MQdFSHYVkJSQCCnvPV0u2FXZVYj9Bb
Jz/PNuyt9uexrRqPrBsbIKJcJUHREFq6SR1NYDMReO+lyYD8xLkKmXPH0K55C870
FHSWZIUGQB5Lt80AJmT/FQrXn62k7+91Nalz/CyYtaqH/RdFHTD+mBkJtSs+c1gC
i/L5TsJAiSLGEZl9I4rSRniStmUSlg==
=2Xkh
-----END PGP SIGNATURE-----

--kAfVHLmbYIIytvqg--

