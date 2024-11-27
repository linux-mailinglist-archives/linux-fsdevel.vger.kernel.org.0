Return-Path: <linux-fsdevel+bounces-36010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6CA9DAA51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78773166FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A961FF7AD;
	Wed, 27 Nov 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFJO2paA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67CC224EA;
	Wed, 27 Nov 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719825; cv=none; b=bX7yl/edLTThPAK+G6ywadwJWOt8duSP9MF9+xM4mV+EIHyYvEVWe+Q3wreyKoMU5Pp8sRGS3oRBktvkJ8LMRz3myk2tynuNwdPv+b8tWRsdfX472Az9oFi3z4JA67mETqJ7UBuSKuMfZMrWJSIrkJ+121PTQhRXh928UOqX4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719825; c=relaxed/simple;
	bh=1rK7OBY79LRZDZ22Pu9M6okisI2o6HZdzNlnIFfdU/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4mKFLNZ90SY63uC8Ql5jmJ0g3J7CI8jVDAH5tm+VuB6YZRVBE4LYePMWYzWUz+osFLuenCEC0T20AIfOXYW0EJ8ubgvc44+PzAflDVNnbnf+AgclmZyEeXIJ5uJLCWHFY17p99UstB7z7hj6AK2xLWI/Lo/ShkB4nhyYewb8jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFJO2paA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C020C4CED2;
	Wed, 27 Nov 2024 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732719824;
	bh=1rK7OBY79LRZDZ22Pu9M6okisI2o6HZdzNlnIFfdU/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFJO2paAaS0/3AXYchToU+3ntex6+l+F4A/LL8k+hgyFsS4+LgUHcddvgU59YYfzN
	 BgRSmlAOaKeJtNNWUacQPv1vVMptR6hdHJ4Sf67ZMQSnnrxJ6VS4H1vlZ/4Ke0dd9H
	 C2TcNvO7ZaZvQmznZXn+jhHXEaJzpRYAeDBALUHbwEvPgVeqwUupQX7+9ZOVKVWVTW
	 6AeRkkmji0XTryTTuf15yUy/az93cFwGnJIVUIE8+bLDBUidef/vm89hoSSS8wrHuA
	 9uvletBnIBYC3DjYVd+Oh8vaqjWCFh7OamSqbTEwxzEeVLfdk1ocee+D2YS4sd3Zwh
	 PfLE+L3ypkLWA==
Date: Wed, 27 Nov 2024 15:03:38 +0000
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
Message-ID: <41cc66b3-e4be-4bfb-8846-811887a475a5@sirena.org.uk>
References: <20241030203732.248767-1-tycho@tycho.pizza>
 <20241030203732.248767-2-tycho@tycho.pizza>
 <6c68dddb-84f3-4b73-987c-8334b2301d9b@sirena.org.uk>
 <Z0cz/Dhrw118WPiE@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26psQPxcYjFEUVU0"
Content-Disposition: inline
In-Reply-To: <Z0cz/Dhrw118WPiE@tycho.pizza>
X-Cookie: Every path has its puddle.


--26psQPxcYjFEUVU0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2024 at 08:00:12AM -0700, Tycho Andersen wrote:
> On Wed, Nov 27, 2024 at 02:25:29PM +0000, Mark Brown wrote:

> > This test doesn't pass in my CI, running on an i.MX8MP Verdin board.
> > This is an arm64 system and I'm running the tests on NFS.

> Strange... but this series has been rejected by Linus anyway, so
> probably not worth investigating further.

Ah, OK - it's still in -next and causing the overall suite to fail.

--26psQPxcYjFEUVU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHNMkACgkQJNaLcl1U
h9BaRQf+JG/TCcQ28dk4xr71DM74rOC5E944iDxKEDwCxwzrSo/odHcWNlSCXfeG
2eoEkWi16lIczUIRULIHFfhdT/PIr95AZvjs480Owx80GtYnB8EqIbH1QKiG+x2O
jU1e6Z6lJFJUeAFDFjpBZ7D3V7eHAUD35gwP/Tig39XFdJ3ORHpqBN0KQE1pLsJF
B9fhhDI5bEf9zxK+IEOKz+oWedQ+OAz0YnXl6+tSveXqx3Di2kpDEN7IEGkdca4n
QAMGQ5xAQwKjv6lVShOX4UrYuzfOfb8DDB2Fx1FtZHwUp0QIMyo1SCgxs9EsUfh3
LSOsm+PO8FuH+/z4O19irmGcLeo++A==
=YkBl
-----END PGP SIGNATURE-----

--26psQPxcYjFEUVU0--

