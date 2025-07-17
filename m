Return-Path: <linux-fsdevel+bounces-55261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3BBB08E80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F84E3A57D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0642F5C5D;
	Thu, 17 Jul 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMjZ+mdG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540D291C1A;
	Thu, 17 Jul 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760151; cv=none; b=Q3Y1D+6Y8na5jYNOcyfJHZq6HPPEZmvRUSRTHjFkQgjO3KLFUXUxe1U6o7bIbvsETebYoyWAq1M24t3l/tgg5h6KzRMBgukSfq7HhsoWrxS/QVFkLTNDok5pqisdRTdGCCxX/mitB35f4vnwdv4IaHsNzjZff6jtkQmL5WyKQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760151; c=relaxed/simple;
	bh=nHp+NjjyXCVy5oSDMxTXYAES3M36KwyjgL5lVBfYtOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR/3bMFnawS/m8qvXJOqP1xm6XimYPVa0io8fhctArexwLeURNMj2LZ1dNXe0XFCGtdyAKs2HL52FGnh4z2L3GB8lITG2XgcUzX+BHyBeQrgnX8VjpGeUd2XzKYHGKGRRocCEaFBpg9ZOGW41wDmrrdLCsF5R93sj2g/lqG86Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMjZ+mdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15904C4CEE3;
	Thu, 17 Jul 2025 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752760150;
	bh=nHp+NjjyXCVy5oSDMxTXYAES3M36KwyjgL5lVBfYtOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMjZ+mdG32BefaMZSw2A5Nl3cP0yrGeQPpIJ5UPA6H0f5cHiQNAHHNA9Vwe4pl1BG
	 wsZIyoFUWVhchl3yyMjyBkxCuXDJa3Bvw8H20ppUqSY365MLNRwUIQGm2pBp1PngG8
	 3TsqVRNESm1SQGA0jGdGeAWQoQmu++Wcbg5XaOM/3ymoagoEbpAsNTkUGAA4NKxnH1
	 LLW9nXl2wr+ylna8xCbL/2Sjjh1XnWnmy0CdxwH5jiASlw3pCNcFdo+sNjLB9jWTiZ
	 IKBF3EfmFX/gwhHdJ0pIJZUbsHKDTXKMTnK04MhVmgV8VWtxnk1b/FNsDI+w85WkmY
	 pilwzSi69xZ/w==
Date: Thu, 17 Jul 2025 14:49:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/15] kunit: Introduce UAPI testing framework
Message-ID: <aed80898-a805-447e-85dd-473df306a4ed@sirena.org.uk>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
 <20250717132259.GA25835@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKFrlx/B5i2FyXcs"
Content-Disposition: inline
In-Reply-To: <20250717132259.GA25835@lst.de>
X-Cookie: May I ask a question?


--bKFrlx/B5i2FyXcs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 03:23:00PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 17, 2025 at 10:48:02AM +0200, Thomas Wei=DFschuh wrote:

> > If the kernel toolchain is not fit to
> > produce userspace because of a missing libc, the kernel's own nolibc can
> > be used instead.

> Is nolibc enough to run all the selftests?  If so we should just do
> it unconditionally, but linking to different libraries by availability
> seems a bit problematic.

There's some that rely on standard userspace libraries for accessing the
functionality they're testing or for things like crypto which would
require a bunch more work.

--bKFrlx/B5i2FyXcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh4/00ACgkQJNaLcl1U
h9Ch8gf/cpaAY8IBIFlBrmWIiQkiJ0FFikWlfW+MYZ7O15f9qA8GKRgtK4Nyeyrf
buC78gz9f/UdKKBdArLYyoEf73opCWjXWwP1Fh0nTK3KWwiFPfbYsjpf0w0jx58V
9ZjqqXzhTMvg8vgJHhEVV57dFkjzE9iOATxG7nwq/mHjZT5ct65LkW0qYFcjaXt9
P90/dGgYC5BYct1wwET6oTBQ/wzO4iBpBMfg2a/kF1y8hfe08Yp/1VWlxXu4YFTH
enY7XYkHBTJBoXqbCF9oquWhxKPymOn4gp8ojzBqZZEGHAILJyZOLbJpzeQ865bi
j1Gh2DNVxeHaX8nSKTWuvmR2g0uPwA==
=9rbF
-----END PGP SIGNATURE-----

--bKFrlx/B5i2FyXcs--

