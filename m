Return-Path: <linux-fsdevel+bounces-31436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B5C9968D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 13:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA91C20D66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37931922E4;
	Wed,  9 Oct 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESNF0aTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687A18A6C6;
	Wed,  9 Oct 2024 11:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473287; cv=none; b=UcRoWnXvwhWacGW4QhvnUXjp0fp7frfd0vIox16jJFWf9MumRKKFj4ZMWqqsxWXXoruv1e0/N9fEckhhW8ucUFriDqdArDKkl7qjTvDcGsixjg0TZaMq3WA+yQXzFsKutEqNx74MYwoAWfdbacw2VbsE6THBjp1XY5JALVtOZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473287; c=relaxed/simple;
	bh=dWTLORjqnX0opGzmksVLTfrOi3GuFaEPiMCBg13ML94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ2GgqJmAGq8j5G8E3VBTNLAu1TsqPWpPb9ok4iCbfPTYBdS9OQMDpsKRhrM0JZUs7KXZ+m+mdLtVyloHB6g+DDTC+/k8oMAtEeK9y2eZRegfg85LWS9SxG+OYNAWUQFcmyG5RCf6xw7LEbsEa6gjziUjpUATiahzbhvQl2N7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESNF0aTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B6FC4CECE;
	Wed,  9 Oct 2024 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728473286;
	bh=dWTLORjqnX0opGzmksVLTfrOi3GuFaEPiMCBg13ML94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESNF0aTxqPGkFJ5uOkrMRuhf0nlBFaTeES0hVQIDeqopdDRPJVAzKH0+3aSdmILae
	 vtwodVcPPDS7pgfpH1bBd3bVJLwIgc+/7SdrGpDphN7VxRcaGiAok6K0I7+QlU8n6J
	 +sNtUViL66G8sWAvpOYUcNcMVlS1wPbgmFu4exaCJwNH4If+V8t55jrp7xC5O7KEGU
	 puQWxirrHiL8pa8xl5cqNc09b0XVmRU882HBh9wZOTRb1Ity4/rNiN2fH27v5lE7xc
	 BMLj2LN1Zcyy1BgDa51Cq6vQsXvhkpiTCMyuTqkxbgmKXqmG5/aAhu8Mk4DYFedsfF
	 vJ19Vz3FHtsXQ==
Date: Wed, 9 Oct 2024 12:28:03 +0100
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
Subject: Re: [PATCH v6 06/33] riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
Message-ID: <ZwZow-L3d_ZeONvq@finisterre.sirena.org.uk>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-6-60d9fe073f37@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9TOr5Y7hc2IlgPC"
Content-Disposition: inline
In-Reply-To: <20241008-v5_user_cfi_series-v6-6-60d9fe073f37@rivosinc.com>
X-Cookie: Editing is a rewording activity.


--/9TOr5Y7hc2IlgPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 03:36:48PM -0700, Deepak Gupta wrote:

> riscv will need an implementation for exit_thread to clean up shadow stack
> when thread exits. If current thread had shadow stack enabled, shadow
> stack is allocated by default for any new thread.

FWIW both arm64 and x86 do this via deactivate_mm().  ISTR there's some
case where exit_thread() doesn't quite do the right thing but I can't
remember the specifics right now, possibly the vfork() case but ICBW?
In any case like Rick said factoring out the common patterns would be
good, keeping things aligned would support that.

--/9TOr5Y7hc2IlgPC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGaMIACgkQJNaLcl1U
h9Bs/gf9HkwcB6ukqOUKkOcYZY6n2S7Ff9T2G7eFz/ljV9gwDrw11zKI1p4fKARy
gsDFv12wYltPNps64PSegFC4tGyb/8zKIBD59rx/dGB3YWqWj1pf8NRcuaz/e9d1
9CEu2M/MTcoJi7Qvy6QV8rnWvyzcjsSIsDVfLUnKuFlsXdDQsEO4wqpVGTl7rQbY
2SKHvMozADQAumDuaffjOMn+fZhriCKhVgUBRXgknSBRdCVDm4uhx1QVWWQ9hqS/
tCieIUs0gB3WbL3znar2cMjWT1QQJODw58V0/j7+VJVZFMhxBItdY9UVvgjyDOe9
q+3j1W1soyWnVa895qI78ooiYZcR0A==
=7QkF
-----END PGP SIGNATURE-----

--/9TOr5Y7hc2IlgPC--

