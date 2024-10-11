Return-Path: <linux-fsdevel+bounces-31683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58999A128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94841C228B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53542212640;
	Fri, 11 Oct 2024 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjoopDs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9862719B5B2;
	Fri, 11 Oct 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641901; cv=none; b=jG+RIeiBIAImGyFG3KSq0pF8odphxZz/lmB2nJT/Uc2wcVvc0FB2dkCKttWLt9ixwPwK5y/gRbzfUdUzFBJrdfHNajoFGIEkh48HbSw4G4k9Y6RBYs3Pf3m5wQFsuH7B+FXkwtc6x671ExuNLCN8ydx1DAgnWaUBeKg4AsqqRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641901; c=relaxed/simple;
	bh=lyKMdlipHmMYKqMilFlbZUHsLyqahWCluuNLI0NJiGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpXvlosEOc5xunGafY5A8FcDOF7npdipjxOKqzL4iwhzJANXPBc1svqHGzEFuO5+a+Qyrby0pgO8AX8axWe6v7K4k4aJwafWF5vRTk1HqQm/52C+ptoNQNjFyl/epAFm/HND2bBAJrEkYu40k/K8RMe8gEKJ4CCbwg+CfoYGBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjoopDs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954F2C4CEC3;
	Fri, 11 Oct 2024 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728641901;
	bh=lyKMdlipHmMYKqMilFlbZUHsLyqahWCluuNLI0NJiGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjoopDs5/omBheGfRb9ZQ450SmBtY6HZjHLk4F2wc6F5woXclnTMZFIsICX42AkUS
	 ZyIsYdj91w3FXWFEdw6JaShqxjF+G18Q5Ff6R2GjLaO0qDAxP9R6VpiUU3pmwhN7QW
	 xiyBUuSLUibdBek6wdxoqqZj+MagtJde/r8jEaXDCqt1YsFuQO96bMYBrC3XPuIsM1
	 uWTW6FwjVT6eVldfcoe3NSxxoOTaDSTUD/Su513PPSelESY+nugqM/+rQ9p4p2cB3h
	 zDNAcVH0E7YJsJu7hJk0J4XD95ImgZuz9BE7bsUTnYJ5PgSSQ3LpOvFvhvi7bSk30S
	 C/FSjlpgfro+g==
Date: Fri, 11 Oct 2024 11:18:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Zong Li <zong.li@sifive.com>
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
Subject: Re: [PATCH v6 33/33] kselftest/riscv: kselftest for user mode cfi
Message-ID: <Zwj7aZj36TBGzpZa@finisterre.sirena.org.uk>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-33-60d9fe073f37@rivosinc.com>
 <CANXhq0pXVS2s-hZNusPLoQ4qPkyi1S2BTQ-FyAvcz=cDctKQng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PJjNqwWWqyWbjeHL"
Content-Disposition: inline
In-Reply-To: <CANXhq0pXVS2s-hZNusPLoQ4qPkyi1S2BTQ-FyAvcz=cDctKQng@mail.gmail.com>
X-Cookie: Editing is a rewording activity.


--PJjNqwWWqyWbjeHL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 01:44:55PM +0800, Zong Li wrote:
> On Wed, Oct 9, 2024 at 7:46=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:

> > +       if (si->si_code =3D=3D SEGV_CPERR) {

> Hi Deepak,
> I got some errors when building this test, I suppose they should be
> fixed in the next version.

> riscv_cfi_test.c: In function 'sigsegv_handler':
> riscv_cfi_test.c:17:28: error: 'SEGV_CPERR' undeclared (first use in
> this function); did you mean 'SEGV_ACCERR'?
>    17 |         if (si->si_code =3D=3D SEGV_CPERR) {
>       |                            ^~~~~~~~~~
>       |                            SEGV_ACCERR
>=20

Did you run "make headers_install" prior to building kselftest to get
the current kernel's headers available for userspace builds?

--PJjNqwWWqyWbjeHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcI+2gACgkQJNaLcl1U
h9D6tQf8Cbjh+ZCxTHzNMvyIkuab9pqHuHnVUB/sDN7eeBJp3Yem3v9BmF2lUAdA
E2WU54VgKuAaJJ+3nvouHfzMeZ9bT+OaDgwDVtgDkF8agaj9mRM2tKmsMWpAb4aF
eORi9++qQz7h7OvKTPSZCVB8o6jVRhOFEFcyv/gXXg5WvNb8UIf0cPkwhS8hh61e
GIAT7UE2o+e0/BzYHIAVrMB8F8YHSkEYi/fAFy4rcIHrru8aL3dATtRMKpxGDX20
VlJ9IYA/nNuODeLJSt10auIsA2z3GF73b4fWqhQ7h0/ga7SACr050BxNq3SBkfJ2
NaDmcT4DAf+mI549FZMM61qSvllFEg==
=La7c
-----END PGP SIGNATURE-----

--PJjNqwWWqyWbjeHL--

