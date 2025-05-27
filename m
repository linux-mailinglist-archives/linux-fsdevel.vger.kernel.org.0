Return-Path: <linux-fsdevel+bounces-49894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C889CAC4908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 09:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A32178C8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 07:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812F1BD9D0;
	Tue, 27 May 2025 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYFeAfEC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1472614;
	Tue, 27 May 2025 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329782; cv=none; b=dMCgiR/60C/TaZ6yFtUKrDczyOvn50SZJCCkl7CTu+SGH38ntwgEta32G5cJ8Dbe3BCqCYS5XR8VovVzbwhPsBbEf7Y1H4uknkpC2Ulsi6hjve139sxcNxL/cCwokQbf9cnQmxw+G5iq1toeyW+/OFl3RP3MPdOQ/5j3ic3hWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329782; c=relaxed/simple;
	bh=2kl6mZ8cHvpAb73D3F/4DvVrjl1/RRlL4LaE/e1S4FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYpas981bgCwfiAUARiO7J9kVXgaPEf8Ck9xFuFD9EfujJLCdz8oLlnb8UNMulOIlp3hlKzOJKd8FKRA/Jz2dog8Q/IOOX2zXCwXYR3ymdpX/1+rdB3RUyi1cj5BFnfyMwSczhbkAPImzS4EREorh0PY267pkphiT1eXBBGQI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYFeAfEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F637C4CEEA;
	Tue, 27 May 2025 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748329781;
	bh=2kl6mZ8cHvpAb73D3F/4DvVrjl1/RRlL4LaE/e1S4FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYFeAfECVkICnTDcOgCfhzMZ29ALQmjrjRTTsWrpq01JDFCyZVZ6pvptYGUwV8pS7
	 9APSZljthBK39hGBNGK/FDWkMmeK8P7tMfzn9BjdOdiuBsHlilz6J9lDL4VtGiIH8W
	 COY+wkKgZOs1oEj5ws2rqPhaWPgljkvKaA8lRgBxsW6bpZ/hE8oVHTbMZU65OQUO1o
	 FgwtXV/ibURPygPZdzauMIjOoDUyBwWYv3WYPOp4l72XD8rCSpDRu5MIvrYrMGo7A6
	 LE4S6WCOVxoVlvnpTLoeeapY/KZc0kFMBZlgAxpI60RQ319+Mxi2SsGCDvBT7sXzEr
	 yMXJD0Y+U7vOQ==
Date: Tue, 27 May 2025 09:09:02 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH] kernel/sysctl-test: Unregister sysctl table after test
 completion
Message-ID: <b4jjhqsjnen4ifcccd4qu4tqq2wtqdglouslx26jbwhydgz7qn@lgeb7jltrt4d>
References: <20250522013211.3341273-1-linux@roeck-us.net>
 <ce50a353-e501-4a22-9742-188edfa2a7b2@roeck-us.net>
 <yaadrvxr76up6j2cixi5hhrxrb4yd6rfus7n3pvh3fv42ahk32@vwiphrfdvj57>
 <d2c93db4-6406-47ec-9096-479aa7d7fd23@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e3wot27uafm4acze"
Content-Disposition: inline
In-Reply-To: <d2c93db4-6406-47ec-9096-479aa7d7fd23@roeck-us.net>


--e3wot27uafm4acze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 08:54:44AM -0700, Guenter Roeck wrote:
> On 5/23/25 08:01, Joel Granados wrote:
> > On Thu, May 22, 2025 at 11:53:15AM -0700, Guenter Roeck wrote:
> > > On Wed, May 21, 2025 at 06:32:11PM -0700, Guenter Roeck wrote:
> > > > One of the sysctl tests registers a valid sysctl table. This operat=
ion
> > > > is expected to succeed. However, it does not unregister the table a=
fter
> > > > executing the test. If the code is built as module and the module is
> > > > unloaded after the test, the next operation trying to access the ta=
ble
> > > > (such as 'sysctl -a') will trigger a crash.
> > > >=20
> > > > Unregister the registered table after test completiion to solve the
> > > > problem.
> > > >=20
> > >=20
> > > Never mind, I just learned that a very similar patch has been submitt=
ed
> > > last December or so but was rejected, and that the acceptable (?) fix=
 seems
> > > to be stalled.
> > >=20
> > > Sorry for the noise.
> > >=20
> > > Guenter
> >=20
> > Hey Guenter
> >=20
> > It is part of what is getting sent for 6.16 [1]
> > That test will move out of kunit into self-test.
> >=20
>=20
> Yes, I was pointed to that. The version I have seen seems to assume that
> the test is running as module, because the created sysctl entry is removed
> in the module exit function. If built into the kernel, it would leave
> the debug entry in place after the test is complete. Also, it moves
> the affected set of tests out of the kunit infrastructure. Is that accura=
te
> or a misunderstanding on my side ?
You have understood correctly. That is what the sysctl selftest does at lea=
st.
It all runs together with tools/testing/sefltests/sysctl/*. The idea is
to use CONFIG_TEST_SYSCTL only for testing purposes.

Best

--=20

Joel Granados

--e3wot27uafm4acze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmg1ZQQACgkQupfNUreW
QU+OAQv/V1ZJFq0pVYdYgiAa0W/hjXiIh9ws1bAGjfLJAlSJ40RWutdMZmyOEQ7K
BKqU30gCRrHONClpGVDRi4CTCtz1cOHp4eiUNEih0DwIP12Zn9AF+l99prjoZT3J
P6adglM/p5LwebgVHgBXqZtv494zpAfaqJH/0hbOCi2UydOSVq6r69HXtfyvJHuA
5/i00EyPwaCuisH1EGF6Qo2B/nVtVsHMG2AMJn0xrgKsNsTFPVkk2DG1XnxVHooq
y/agzjdtFenY1VPj4cHtLfqWsLbHEaoGED1885fj1SgLQGigJXRBiUDS0Cgaw+tl
il+pfeahaKjYvDSMtlH8WDeuqcB2uYQDxmx/fi8ksCsWw/fdvC9oaGssPis7/oHp
ma3yTjV4cGK7q9JE2jHyNbH+hZwPUstYhb/1SVUIv6m/Oe1vnKpTtMnhcJdSde36
K/9I3RFQn9IijeU7UzkPzIj6KoN/p3kTPtrBMO1UOV/BMQ+fEWI9uO3PpHgRFT4O
E50WrQYa
=Wz1u
-----END PGP SIGNATURE-----

--e3wot27uafm4acze--

