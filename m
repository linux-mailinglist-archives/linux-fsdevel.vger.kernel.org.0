Return-Path: <linux-fsdevel+bounces-31439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0148E996AA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8601F27987
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E719923C;
	Wed,  9 Oct 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOg7lJQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E20194C9E;
	Wed,  9 Oct 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477895; cv=none; b=nNkcYQG1dtVotYjyx09ErrTNIZBWuCz/OSXkl8VQmLv4eZyZUal3JkHtEZ8Rx9MzVCzdfjv1wxVxQrfOxRwDQVeNjcbQHQ8DHyBxpMk1XQkpPv78rBogrdTIS82aGKG+uwXpPMB0nEqFezSr4aKcvQa8xWyxYfGhQ9zmSk98aaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477895; c=relaxed/simple;
	bh=H8kdm68yh4PjNaTTQSqiK9xUlJdE5SEZL8vV5HEB7bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMOAL8HzCuB6x8ApoS6ojN3s5W0MqXhpnNJ8UBsN8Xp11XpnWQIUTfUDatu/UCxzUy3zBH8vL6ZNJM4fy3xh5DeoTp4abZUptg2nJv+SkgyDnCvU1936iHrz/2grZSL6KnzeFi+JfoY2eMcSWxLPrqlV3XjM1daTltuspgvPH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOg7lJQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9FAC4CECD;
	Wed,  9 Oct 2024 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728477894;
	bh=H8kdm68yh4PjNaTTQSqiK9xUlJdE5SEZL8vV5HEB7bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOg7lJQKEW40/bEO415zN2BipiNrVKXBJ2+6AJ0LyDe1eEgZUcOfEVv8Br6oOMYsX
	 3B/6JS62G0rWlabeOtrYgBLyQbAdzzeEOBiuK92mZAiorw66/nD+XcXkfn9qtL4FT+
	 KN0EnsQrEhwTOt9UoPhpqWnbGNLYj1QMABF3CPXuSJy4xY/xYkCx1aoW2MlmTqMaKC
	 hVufeF9v+RTk+47TEFUKqwVFGedBDVag41dYHoysZp6OUcLYY/N10Lq2B53dlDEIVI
	 nuqkKlzn+w4X44DP8K+IiEw/iYAhfJKl18vtVF42xEUqCB6nuBqh4+H2S/YV8MRfv0
	 vn0qtNlJb8Vsg==
Date: Wed, 9 Oct 2024 13:44:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH v6 19/33] riscv: Implements arch agnostic shadow stack
 prctls
Message-ID: <ZwZ6w1Fu5zt2beRZ@finisterre.sirena.org.uk>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-19-60d9fe073f37@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5KnydFV4ujRpm3UO"
Content-Disposition: inline
In-Reply-To: <20241008-v5_user_cfi_series-v6-19-60d9fe073f37@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--5KnydFV4ujRpm3UO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 03:37:01PM -0700, Deepak Gupta wrote:

> +int arch_lock_shadow_stack_status(struct task_struct *task,
> +				unsigned long arg)
> +{
> +	/* If shtstk not supported or not enabled on task, nothing to lock here */
> +	if (!cpu_supports_shadow_stack() ||
> +		!is_shstk_enabled(task))
> +		return -EINVAL;
> +
> +	set_shstk_lock(task);
> +
> +	return 0;
> +}

This will lock the shadow stack settings regardless of the value of arg.
On arm64 the argument is a mask of bits to block changes to.  While for
RISC-V you only support enables so there's only one bit that'll actually
do anything portable code could in theory try to do something like
masking writes or pushes only and get surprised that disabling shadow
stack gets blocked.  For arm64 the implementaion accepts any possible
mask value, allowing for userspace to block enabling of any future
options that get added.  In theory someone might end up calling with a
value of 0 (eg, if there's a config option for the bitmask to lock and
they don't bother optimising out the syscall if the value is 0) which
would definitely break.

--5KnydFV4ujRpm3UO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGesIACgkQJNaLcl1U
h9CoSgf/QkpoT9Wv9XJugV4VDvwAhLMHLTE4q1599RvHVraBUMB4Sk2kckdamajU
gf1rLq5KWESxQNXgMiArCIXUaWaZ95G3TfZYo+2tmZcnyNoQVOc8BqiwgRevA58E
goARRqmt+Dt97Ifxm175SDCvb+va0e6s6t1mM0dwrxEjOB2o8Mk98qp70JhLz5qG
CYOO5V9/8s0xc3D6MHLW+SIg/4x1RdRfvmxZ+xborNttlnZolTTlWkHhuYpYeHFz
GRgGDVYycuo6Nw6IjmBsA1CU68ICHNna9PgvngHCmSJ2oK3NrzZodyEtOmc0wQ0y
gCYvJSj/oECnl39N1bJTiArvCF/HAg==
=Ri8u
-----END PGP SIGNATURE-----

--5KnydFV4ujRpm3UO--

