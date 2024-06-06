Return-Path: <linux-fsdevel+bounces-21128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E298FF40F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 19:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AE91F24FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83215253E;
	Thu,  6 Jun 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcThCifc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE531FAA
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696203; cv=none; b=Llce38HOwNmc69EkNCvY92+LTW61GvR6ftRo7CDp63xMDoCzTg/4o4/2sjM3DngvtyPA3l+tqL1zz5BHVDyy0xkIVzkEumgvNbcDOpuYP7FCuU+BvGdzaL3PD1A6zVDg/s9VZRg/f8gYTtxCO7xzC8Co3UD8537kHuXbWhp+Eqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696203; c=relaxed/simple;
	bh=Wn6YvFhssZe0GjSYfuQXnROoqOSu/TAxVWU2FY48Msw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUGPMSPdKfkB1tZXc91y+iqqbC23n2JPkbPiW2RVcTl1XNrwwwcXDadGw1/FsbClFkmteOZcC/xko6OkeiG6qkEFOhZ64spscHiR+pV4DXLbOyptciD1R2A1VSzjyzlxQbRVq062SIahuI7FHOa+pcm8uVyfjsFlGvajYWv9yrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcThCifc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0391C2BD10;
	Thu,  6 Jun 2024 17:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717696203;
	bh=Wn6YvFhssZe0GjSYfuQXnROoqOSu/TAxVWU2FY48Msw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcThCifcGvC0LNuXoUFS0rNe0LTgWAO6yM4MeDQ453T+nyskU6S+0twWTEYEzya5f
	 fNhx0DIvVL1zzUbg63Cmf+TGhqIycSPNQkQ8chZk/YzyBHUpmnAXX3zjWBPgPdbKgu
	 RTWCTGr4mtzsW3dA6cbPJ2wFCdSlbb9GcatAhJ6D70xy5gtfkcTOCXlg8Fp4WG9Rrd
	 1TnfoF2xiE1Zwty31ujDCuCbxqxBIj2tBPmnKWwxH9y2TSvKrQ7alzV9qbOuIr3gtc
	 xjRaqPdl/mkXxN1dguf3MRsq+V0FfINDX9EwZxYNmOFvyAw2Z5IE0B9zZ0FK6/ikF9
	 3PVTk9p7dRB7Q==
Date: Thu, 6 Jun 2024 18:49:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, david@fromorbit.com, hch@lst.de,
	Linus Torvalds <torvalds@linux-foundation.org>, amir73il@gmail.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>, ltp@lists.linux.it
Subject: Re: [PATCH] fs: don't block i_writecount during exec
Message-ID: <550734af-e115-4048-8a8f-0fdaa199c956@sirena.org.uk>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
 <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
 <9bfb5ebb-80f4-4f43-80af-e0d7d28234fc@sirena.org.uk>
 <20240606165318.GB2529118@perftesting>
 <1eaedeba-805b-455e-bb2f-ed70b359bfdc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pVnIxS76zgcxJ1KF"
Content-Disposition: inline
In-Reply-To: <1eaedeba-805b-455e-bb2f-ed70b359bfdc@sirena.org.uk>
X-Cookie: Flattery will get you everywhere.


--pVnIxS76zgcxJ1KF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 06:33:34PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2024 at 12:53:18PM -0400, Josef Bacik wrote:
> > On Thu, Jun 06, 2024 at 04:37:49PM +0100, Mark Brown wrote:
> > > On Thu, Jun 06, 2024 at 01:45:05PM +0100, Aishwarya TCV wrote:
>=20
> > > > LTP test "execve04" is failing when run against
> > > > next-master(next-20240606) kernel with Arm64 on JUNO in our CI.
>=20
> > > It's also causing the LTP creat07 test to fail with basically the same
> > > bisection (I started from next/pending-fixes rather than the -rc so t=
he
> > > initial phases were different):
>=20
> > > tst_test.c:1690: TINFO: LTP version: 20230929
> > > tst_test.c:1574: TINFO: Timeout per run is 0h 01m 30s
> > > creat07.c:37: TFAIL: creat() succeeded unexpectedly
> > > Test timeouted, sending SIGKILL!
> > > tst_test.c:1622: TINFO: Killed the leftover descendant processes
> > > tst_test.c:1628: TINFO: If you are running on slow machine, try expor=
ting LTP_TIMEOUT_MUL > 1
> > > tst_test.c:1630: TBROK: Test killed! (timeout?)
>=20
> > > The code in the testcase is below:
>=20
> > These tests will have to be updated, as this patch removes that behavio=
r.
>=20
> Adding the LTP list - looking at execve04 it seems to be trying for a
> similar thing to creat07, it's looking for an ETXTBUSY.

Or not since they reject signed mail :/

--pVnIxS76zgcxJ1KF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZh9sUACgkQJNaLcl1U
h9BGzAf/aSRxzn4Kzj3hRoCEH5LANUpI0xtg1kjMcnsTLmokkfHapd+OlMzVL5qG
CbF7TAJtZ0m6F6FQGC6sbAfgdfdCuyMoPdCz0rxfNvxsaJQ00PJoKs6w8COiz2ZD
EHLD26uj8SyhLWxbJDJJ3E7z4WqUlVQnhnpVe8D+ZN9WoUMM/rSQdHy0N9pbb0RF
UMxV0zKvnSqlMryJOkcDFbKrZwFQpuT4pznNp9kE/tCxV0g+vMcD1XkdrMV2q7K9
F2zFMiLXln9nLMhi9t1hnS5SkdHzcAg1F25+zMNNAVM4+jCl3e8J66TGhnRc4/S4
FpNG3/urZI3nT6ail36X8BUUXh66Iw==
=YiNL
-----END PGP SIGNATURE-----

--pVnIxS76zgcxJ1KF--

