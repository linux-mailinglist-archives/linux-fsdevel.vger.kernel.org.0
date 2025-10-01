Return-Path: <linux-fsdevel+bounces-63160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF0BBAFFEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C123C3B916E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A42BE05E;
	Wed,  1 Oct 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEi0leiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED8023507C;
	Wed,  1 Oct 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314211; cv=none; b=fBtWmAa0wYh+85aXN6cOiEfm8TefKQEdrQMkDBWPWxWHpgv/QCYD4w+nfB4K29wUmvYDP3N0+JZpUTDSGm+15zBG7HC+qjDKgrqIjbwBjkQ3JkK0WwmHA6ICk2/fqM3qxSz8jhDjb6g4pAf8LkQuhxa7B6qYnS5nk/9w7lwGFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314211; c=relaxed/simple;
	bh=AALh+QgcdxTgVsm2Rm8hI3nipsDKnmlWFJxhPOr+liI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXnoWX54cfRAjxtj7+xdiMhiJ5b5Ov71kOY3925xGl/e2OhYmjpY4kpqHZBgkXni15jfYH0J2jyBzVvYsMKOEFpJANv7tej+Zdaff2klbEkIoNmuJ6zSVxk7nyZYO2orRU6Hk8pyHZlU7sa5rgKjURGwahD+AveuU4+c0zo4uKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEi0leiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD4C4CEF4;
	Wed,  1 Oct 2025 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759314210;
	bh=AALh+QgcdxTgVsm2Rm8hI3nipsDKnmlWFJxhPOr+liI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEi0leivXfyS1pd8i+p/LooJS581IdRk5OJvdTAXrn4Fpg1Nmwb3H2AWg39+CV+ZA
	 AUcfAWJf19mMvPxjtL4iIl7KzvkQu4eiXu+/mLr//i1bx4WF3bhrs/E4JbJcaZzMxl
	 b76OCiKNnWVWS9XXpp6sl7QE/NRGadnJNiPee9eXHp1udXYHOhDclqheHydPwEHgnH
	 86WusEtL4z6txIqRAxGvABsgz9ayBD86d3M2lB7MldiNxwfcp1I0PTtRHQKMpH2wcz
	 jt+/3+0/4oIoNGl9VqHbxmpUxDZUUZVhswEyk6d8ChvxoGnZEjneaVAu6K4adsORTA
	 P4WQ+/bo9ixPA==
Date: Wed, 1 Oct 2025 11:23:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, achill@achill.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
	linux-block <linux-block@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
Message-ID: <aN0BH9j_TJkFg2pM@finisterre.sirena.org.uk>
References: <20250930143822.939301999@linuxfoundation.org>
 <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Csa2GXldnUFay7IA"
Content-Disposition: inline
In-Reply-To: <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
X-Cookie: If in doubt, mumble.


--Csa2GXldnUFay7IA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 12:57:27AM +0530, Naresh Kamboju wrote:
> On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman

> The following LTP syscalls failed on stable-rc 5.10.
> Noticed on both 5.10.243-rc1 and 5.10.245-rc1
>=20
> First seen on 5.10.243-rc1.
>=20
>  ltp-syscalls
>   - fanotify13
>   - fanotify14
>   - fanotify15
>   - fanotify16
>   - fanotify21
>   - landlock04
>   - ioctl_ficlone02

> Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
> failed with exit code 1

I'm also seeing some issues with fcntl34, but that's a timeout so I'm
not convinced it's real.  The bisect looked like noise.

--Csa2GXldnUFay7IA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjdAR4ACgkQJNaLcl1U
h9Dv4Qf/Whchx7Nr2OJDScQUh+gNKZqjJR0pdJ/Fa+srX8GaUMVNqceDTnhu3UWd
JmT04jEJYcKw4g5Gs5yy2uS6kkzXrYGLzVmGSVbRmll9w9fKLiSXYM0s0vUbzyhj
0pqX3f5PtWyc8F5o/bM82n0OjFa50FF2DLpt288ZkRiR0PBoiVdEPTdOFsmpCMZt
/fxmfxcs/h+Gf78+Vig+ek27lM0Zfst2Cuw8pp91o2Vf2aWxZ3zsLdF6zGNkWeBV
WstLE2hM7BCc7vYGO86AmqcOuOeW08YwCq+n4YcI0R0H+MxctP7rY7TOv87sThEg
A4YUm2S5/slLao4oF58XgQP1bYm0yA==
=KUL6
-----END PGP SIGNATURE-----

--Csa2GXldnUFay7IA--

