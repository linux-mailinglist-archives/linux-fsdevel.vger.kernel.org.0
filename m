Return-Path: <linux-fsdevel+bounces-36007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5009DA9D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6EF2818E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E31FF617;
	Wed, 27 Nov 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/CxOYee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6A1FCF63;
	Wed, 27 Nov 2024 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717545; cv=none; b=VIK+2uf+X+HWSGkB+iRU3GZIOvnx626frXKgf6QZxh1VfrA/cgmBMMHWcOCtqL91nxZf2/HTCSM6DfnhvQGw2Ga30pOAKJThXkHX6U9tPUjtamTeHTPdxP1Tjq//ih8/s7qv406c93fT5x3YlsWBUPvxSw3kP/V5hSG1WE7rXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717545; c=relaxed/simple;
	bh=3uPc2P+OMkq0tXJoXSIRKXPVE6RqrMCTk1ytqMl3lAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0Ge3p7GKlgBky7bmUihc+5EHi7Oa9TyyqjZamZosn7/ioN0pTMQRl/aVpSKYTuF4E/CHEiWni6gAv2x2BI3ESh7WTW1nWZCVZnH4dV3OJD5k1hXO0p81hX5HOg+VIJJ83c+PVn3yr6S9E3sWDem53OO/b8cJntQde76zki2y7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/CxOYee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3E3C4CECC;
	Wed, 27 Nov 2024 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732717544;
	bh=3uPc2P+OMkq0tXJoXSIRKXPVE6RqrMCTk1ytqMl3lAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/CxOYee/L/uMwKD0fpEyp0kPE4JBauzNby4cW6ObYNdPktSTMFgrtJTjoO13bG30
	 1tUV1u66y1qT/rWLyR/mO4Q4C0EdZqow3DdvwbiSr+Ck1nAzQaHxqwdRJAQ545bHKF
	 p8plZD905aI4oC3ZSXSLB8ePmQP4lRhhnp7NAtMlKcxkLCRnc3DETLhIRXMZic12/e
	 Kv+EOWuWmk9lXGoWkejzwulU2dzM0QVHhDLXTQ1l0RbWI/3JErz4TX6ECY7oRVaCes
	 NT0ZUPL87lxM8khD1ePECi5Q5tGEjqQhzlZbCeA/z9hFdwuGiQSWgRDo8IfIKl/LI/
	 i7tXZ0V9I2zFw==
Date: Wed, 27 Nov 2024 14:25:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH 2/2] selftests/exec: add a test for execveat()'s comm
Message-ID: <6c68dddb-84f3-4b73-987c-8334b2301d9b@sirena.org.uk>
References: <20241030203732.248767-1-tycho@tycho.pizza>
 <20241030203732.248767-2-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cxLCvAJhB4t1mXeM"
Content-Disposition: inline
In-Reply-To: <20241030203732.248767-2-tycho@tycho.pizza>
X-Cookie: With your bare hands?!?


--cxLCvAJhB4t1mXeM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 02:37:32PM -0600, Tycho Andersen wrote:
> From: Tycho Andersen <tandersen@netflix.com>
>=20
> In the previous patch we've defined a couple behaviors:
>=20
> 1. execveat(fd, AT_EMPTY_PATH, {"foo"}, ...) should render argv[0] as
>    /proc/pid/comm
> 2. execveat(fd, AT_EMPTY_PATH, {NULL}, ...) should keep the old behavior =
of
>    rendering the fd as /proc/pid/comm
>=20
> and just to be sure keeps working with symlinks, which was a concern in
> [1], I've added a test for that as well.
>=20
> The test itself is a bit ugly, because the existing check_execveat_fail()
> helpers use a hardcoded envp and argv, and we want to "pass" things via t=
he
> environment to test various argument values, but it seemed cleaner than
> passing one in everywhere in all the existing tests.

This test doesn't pass in my CI, running on an i.MX8MP Verdin board.
This is an arm64 system and I'm running the tests on NFS.

> Output looks like:

>     ok 51 Check success of execveat(6, 'home/tycho/packages/...yyyyyyyyyy=
yyyyyyyyyy', 0)...
>     # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
>     ok 52 Check success of execveat(9, '', 4096)...
>     # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
>     ok 53 Check success of execveat(11, '', 4096)...
>     # Check execveat(AT_EMPTY_PATH)'s comm is 9
>     [   25.579272] process 'execveat' launched '/dev/fd/9' with NULL argv=
: empty string added
>     ok 54 Check success of execveat(9, '', 4096)...

The output when things fail is:

# # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
# # bad comm, got: 11 expected: sentinel# child 8257 exited with 1 neither =
0 nor 0
# not ok 52 Check success of execveat(11, '', 4096)...=20
# # Check execveat(AT_EMPTY_PATH)'s comm is sentinel
# # bad comm, got: 13 expected: sentinel# child 8258 exited with 1 neither =
0 nor 0
# not ok 53 Check success of execveat(13, '', 4096)...=20

Full log from a failing job at:

   https://lava.sirena.org.uk/scheduler/job/993508

I didn't do any investigation beyond this.

--cxLCvAJhB4t1mXeM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHK9kACgkQJNaLcl1U
h9C2gwf+N5c+vZrIomxF6ng0FWDkSyPW8c5Ey2j5IGpsPBg4/Vv0mxv6z0vlH+mf
EtchjFZfuht9PgmGwB38eWQanuc9NTKyi/K6xpGe1meJ+5iv/CHZ2kzisyL20koA
N4U7MRNQAcbEGrpHDd96w9x7NZNaellM7UmVrG32wT7H+I8v24LKphJYlJnYs/sm
ygkkLVuRo1Ez4YhvSUmT1lraYuPQzkKEzRVKHbku/qLsTIk6VUGhSaUsjaZETvg+
YtzILqFza8bD5lvogKfBHrsGsnDN1wtFVwDAvlGkbj3qu0rXDFRGKq/e92n6MnvG
Xm1CkvsFtR/wvTTZY0OAPGL0xRKEZg==
=s3fS
-----END PGP SIGNATURE-----

--cxLCvAJhB4t1mXeM--

