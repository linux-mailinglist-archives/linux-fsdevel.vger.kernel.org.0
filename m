Return-Path: <linux-fsdevel+bounces-73500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 273D4D1AFB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34FE830BC4B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4553590A3;
	Tue, 13 Jan 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS6gWU8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931A35CB80;
	Tue, 13 Jan 2026 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331436; cv=none; b=ORcNCLWQwm8vK/e2rk45ds38/zKaqDWtc0D7txX9kyZO2YmLrQY/tY/Rl00RC6QZeJAvFU/V5USKgVJYkV03zS7lCZvJcWxKrKkxN/yP6vATSCto5aT4MgrYMWKGnfLtT3BVDQXgTqEEQkVDlrIYrJNKTKoaz9plGriCrwy1z2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331436; c=relaxed/simple;
	bh=vm94DYUQ1nI39SPw68X0FmUruHGWhmKYLkUMubSnMAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUSTInZYETVD5WKlc/+yRHB8k1K0uFJIZHyqe5ABUxCvYbXtqTHgtMNFH84Kt0jdvnJj7LGNWxtorrEaSzlCkyXdUUqfrjAXI9ZpOJgehlSbko4yJKJiYa6ASW1IPmGtSx/gaFqtJuOZKknRUt85VNqT9PPl/fw0ZLcf5A6NUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS6gWU8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F337DC116C6;
	Tue, 13 Jan 2026 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768331436;
	bh=vm94DYUQ1nI39SPw68X0FmUruHGWhmKYLkUMubSnMAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SS6gWU8x+tekz9NkfZbMGwbM5eid/TUswOoeyExVZZV4viqTgcauuXPwpJihcdho3
	 4LjGQ0acp+JEsLaHflm3DKi741H9bhcPdkGtP3raiePxDX3weLYMh19Bm89wML4ZkF
	 FrQbA1AAN6VvUoGQgIf3x4IEQDfv4qjdWgQ6Gjh+sGyHEXe1glQ2YK9GQ4F9xKCTeA
	 VzjQpLrgZaTdhwnPjU6Fmxm4LAWMYC9YEogS2UT+wuwRpLs0+V6oprbvFcBoo22B3P
	 Vci04XvsPP0u5kNIBnLfc51WHEEkHAYIGy67fRFAQEOzq3BJws4EsgvxQWmDHDM5nT
	 btyO2dkXMwEqw==
Date: Tue, 13 Jan 2026 19:10:31 +0000
From: Mark Brown <broonie@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <79702729-b89d-44ea-833f-505bfb8b1309@sirena.org.uk>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-31-david.laight.linux@gmail.com>
 <62097ec5-510e-4343-b111-3afee2c7b01e@sirena.org.uk>
 <20260113183346.18ef7c74@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nw+uksaxhjXkAeBE"
Content-Disposition: inline
In-Reply-To: <20260113183346.18ef7c74@pumpkin>
X-Cookie: All models over 18 years of age.


--Nw+uksaxhjXkAeBE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 06:33:46PM +0000, David Laight wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wrote:

> > This breaks an arm imx_v6_v7_defconfig build:

> I hadn't tested 32bit when I sent the patch.
> It was noticed ages ago and I thought there was a patch (to fuse/file.c) that
> changed the code to avoid the 64bit signed maths on 32bit.

It's possible there's a patch out there somewhere but it's not present
in what's in -next.

--Nw+uksaxhjXkAeBE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlmmKYACgkQJNaLcl1U
h9CYwgf/VXAy1tb1XQ8DVlunnz3EQbeEFm55uY1CVPI/q3SIT+p7pKT+PrR93reA
k5aXe8Ssjdb4njdECEoxxNFiWFZdgtZrwS4e1cn6YejPs0Y4kPdcPhGaVvw3Rvcg
2xul2iz1N0aw4W2I5/nPu/3NhZIDpgDaHsVxC91pkzqEV0AmSpkeo0qu3/T4r0Yz
06wuJvuq4l+w2QfdUa/zc3eJlqCKuEK3ixV36jIj1qbEiAocwnqKFbhXBQAWv06A
6P6wRQqOcpI9866bMDZMS5LaR71AZBP6cS6C/dXDbXIBP+yo689c5bNgbcwCbE6K
UqJwEbQpJFtO9n7QiTNoxSacGK7enw==
=h9JH
-----END PGP SIGNATURE-----

--Nw+uksaxhjXkAeBE--

