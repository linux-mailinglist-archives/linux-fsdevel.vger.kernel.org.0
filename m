Return-Path: <linux-fsdevel+bounces-21111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F618FF0D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC621F22D97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C0196DAB;
	Thu,  6 Jun 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYzpHyea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E7195F10
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688276; cv=none; b=VNwTretRsGW8qTkV7Akh6qgc1z5czomyjc/zYhwbCy42CsC6+mhEUz59pwfaied9fk7oBImjgmGFvJvw5YgXUKU3Bl5rYwxwPnqbhjHjyavrvnyU28u5vclNkD1z4vzIJFee/xE8+4eXvzihi/t0BTL+Vd0JhLCzmnctxBnqL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688276; c=relaxed/simple;
	bh=z13B81cFWdxBKx97ERWCBixsHHCSUDq9hfvTfUAVRh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIrOEFjcUMreS6cqdibtROA6KoOG17EUSDYG32AQhfFTrpBaXaNdLF3C6Kudq00OEUqnoB5GTbULW86AsDsGAkPkhLlAdjr3qmBdRmDcAU23D7/+yvbb5kx2ClnUDLs/WaCMEzGZD/OGfE/p1OOkKTRiahHx+GngATWHjtXRO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYzpHyea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACD1C2BD10;
	Thu,  6 Jun 2024 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717688275;
	bh=z13B81cFWdxBKx97ERWCBixsHHCSUDq9hfvTfUAVRh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mYzpHyea1gUcWgGwACxI52x/ZbaUHUK4FC7lpL8NDXdlIFi5lMtPvmsOiPB23Aqg0
	 8hF43PfYEn4KHfOun087xn8mQpuV6ixkLXipio2BgV8RbegzHL3Q9faKZz0SPQJBWJ
	 cqMHoy2CjGJVVqrI4VO7HWkym5w+K1LAqbqyx2FiKlwyUfWdloQ5E+Rc3nyRpALmoy
	 FXS2ZHIgS2UUAsLcVeUD+gHVZAuPJMFOR5SSYla5ZN8XVZvaXNalFmyL39pBa+pUVe
	 CRudp16QjH5lQbVNu2YBBb9FS2w7V5r0eggeeKgp375jMNbx7em1VfeGFXHU/4j4em
	 P5bpFAz49jPfQ==
Date: Thu, 6 Jun 2024 16:37:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com,
	hch@lst.de, Josef Bacik <josef@toxicpanda.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, amir73il@gmail.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] fs: don't block i_writecount during exec
Message-ID: <9bfb5ebb-80f4-4f43-80af-e0d7d28234fc@sirena.org.uk>
References: <20240531-beheben-panzerglas-5ba2472a3330@brauner>
 <20240531-vfs-i_writecount-v1-1-a17bea7ee36b@kernel.org>
 <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IUFPRN7JNyDGPs+9"
Content-Disposition: inline
In-Reply-To: <f8586f0c-f62c-4d92-8747-0ba20a03f681@arm.com>
X-Cookie: Simulated picture.


--IUFPRN7JNyDGPs+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 01:45:05PM +0100, Aishwarya TCV wrote:
> On 31/05/2024 14:01, Christian Brauner wrote:

> > Back in 2021 we already discussed removing deny_write_access() for
> >=20
> > executables. Back then I was hesistant because I thought that this might
> >=20
> > cause issues in userspace. But even back then I had started taking some
> >=20
> > notes on what could potentially depend on this and I didn't come up with
> >=20
> > a lot so I've changed my mind and I would like to try this.

> LTP test "execve04" is failing when run against
> next-master(next-20240606) kernel with Arm64 on JUNO in our CI.

It's also causing the LTP creat07 test to fail with basically the same
bisection (I started from next/pending-fixes rather than the -rc so the
initial phases were different):

tst_test.c:1690: TINFO: LTP version: 20230929
tst_test.c:1574: TINFO: Timeout per run is 0h 01m 30s
creat07.c:37: TFAIL: creat() succeeded unexpectedly
Test timeouted, sending SIGKILL!
tst_test.c:1622: TINFO: Killed the leftover descendant processes
tst_test.c:1628: TINFO: If you are running on slow machine, try exporting L=
TP_TIMEOUT_MUL > 1
tst_test.c:1630: TBROK: Test killed! (timeout?)

The code in the testcase is below:

static void verify_creat(void)
{
        pid_t pid;

        pid =3D SAFE_FORK();
        if (pid =3D=3D 0) {
                SAFE_EXECL(TEST_APP, TEST_APP, NULL);
                exit(1);
        }

        TST_CHECKPOINT_WAIT(0);

        TEST(creat(TEST_APP, O_WRONLY));

        if (TST_RET !=3D -1) {
                tst_res(TFAIL, "creat() succeeded unexpectedly");
                return;
        }

        if (TST_ERR =3D=3D ETXTBSY)
                tst_res(TPASS, "creat() received EXTBSY");
        else
                tst_res(TFAIL | TTERRNO, "creat() failed unexpectedly");


--IUFPRN7JNyDGPs+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZh180ACgkQJNaLcl1U
h9DwRwf5AZp1Xm8vUGGHiktpdZ9hdO3pH9GeEQDoXN0NnCTYlk5ap079icNu2mLx
t5EAbQvT1LnBap5x1fGX5k+bz6hw3wFs9g9WohtqyqIVPp9XvdlT8zcqms4N4J6U
YAZmmQkQMDqfh+5hoYjGxALDJX8uMnlULuTQ5jT7JRSyb1o/uDc0beJDd98+KFux
Y4t1RzCNUlEVB47gOgPqdYGGiOJudTiH9N95kBKdbZDDJQM81HCqTxqPKR8763Ik
6p55xuW+Vt9iXVrCG9Tt48VhxyJukF+RDh7+U7gO4ZYUl3GLJy05uno7hYTen0Gz
cekJRZsJHhyjRdQtAu+OSIGYPIjjmQ==
=rh98
-----END PGP SIGNATURE-----

--IUFPRN7JNyDGPs+9--

