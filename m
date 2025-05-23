Return-Path: <linux-fsdevel+bounces-49781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA2AC25FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 17:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C9A188F14D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CFB295DBA;
	Fri, 23 May 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKiG+4IW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42C19CC22;
	Fri, 23 May 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012807; cv=none; b=onEkHhWoUImnQrRhSNaDuhNPvnhROuYAVAgdnadLc7S4LZYLfonrZ7EhYFbMftZcuxG+txcBmA2yJNA2DvMM4pi6baINxjbWAVFTAYeM7yDXcZ9nr5sVj0O/s6ivqv5AcwsuRu7DPSDTnUsJIMc80l+cCFhb/lPtHjqSknKjLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012807; c=relaxed/simple;
	bh=cTgg7neabucDYcjUEjOMZEoFwiorg7njPcXPV94ubGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5XVFoFIfkgnJLc1fjLUiR8vDD4/0Oss3/XsF1HcpFz5Xnxo2c4Wd6hDTj+EcdI8df2xBSG2smRaMzWpS7qGB6eO68wvCss/BXKiwdtuX4vM+zKxb0WW52T6ny0JfN41coKJpCmYAsZiZGbS5qLzezJ0v6x39mw7J3DqMvHJUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKiG+4IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75C0C4CEE9;
	Fri, 23 May 2025 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012807;
	bh=cTgg7neabucDYcjUEjOMZEoFwiorg7njPcXPV94ubGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKiG+4IW2Z2yeLgvhvZV5x9fKc2R8Ht0x7XOxlrbB91XbqnxzdpJsXe86ZfoiOCAd
	 +DczRHIvMD8x6PvcUQKt2s2+BSIiZFbom7+k5FUJih7N8fCbTi+b8cHD2bT/w1/B5i
	 cXd4q9ox30WORf/qf19xY/7lTnUgHrsjzScg/PqrJzB5ubpjRoj/5xfwp0+l4wAVEv
	 QXM6LiLDH6GwjLN3eFZFNoQDGWwee1AlxutzFnoIK4FQe61tbb8VtTzR+qsDXmjNIa
	 GjgJReoHIKaGadLlTSh2paCbWUDD28y7ZD01D2gQEAKO4r3i9LDSfMjh3NzDvLCHXm
	 JZGjkrYnWQ8/Q==
Date: Fri, 23 May 2025 17:01:36 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH] kernel/sysctl-test: Unregister sysctl table after test
 completion
Message-ID: <yaadrvxr76up6j2cixi5hhrxrb4yd6rfus7n3pvh3fv42ahk32@vwiphrfdvj57>
References: <20250522013211.3341273-1-linux@roeck-us.net>
 <ce50a353-e501-4a22-9742-188edfa2a7b2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="coch6zutooty5uxj"
Content-Disposition: inline
In-Reply-To: <ce50a353-e501-4a22-9742-188edfa2a7b2@roeck-us.net>


--coch6zutooty5uxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 11:53:15AM -0700, Guenter Roeck wrote:
> On Wed, May 21, 2025 at 06:32:11PM -0700, Guenter Roeck wrote:
> > One of the sysctl tests registers a valid sysctl table. This operation
> > is expected to succeed. However, it does not unregister the table after
> > executing the test. If the code is built as module and the module is
> > unloaded after the test, the next operation trying to access the table
> > (such as 'sysctl -a') will trigger a crash.
> >=20
> > Unregister the registered table after test completiion to solve the
> > problem.
> >=20
>=20
> Never mind, I just learned that a very similar patch has been submitted
> last December or so but was rejected, and that the acceptable (?) fix see=
ms
> to be stalled.
>=20
> Sorry for the noise.
>=20
> Guenter

Hey Guenter

It is part of what is getting sent for 6.16 [1]
That test will move out of kunit into self-test.

Best


[1] https://sysctl-dev-rtd.readthedocs.io/en/latest/release.html#patch-0-4-=
sysctl-move-the-u8-range-check-test-to-lib-test-sysctl-c

--=20

Joel Granados

--coch6zutooty5uxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmgwjccACgkQupfNUreW
QU8YgAv+L+zQWehdMUQeh3Rr/pAATLh8YLAMC7q/tDLnjY5IyY6okQ7V7W5SBPlb
aqtQ0OoL69Mbh2gtY0ykvFnK7G+vBOW4F3bI49jjNc9ewkaUEhk0imb69ktYounm
eILkPj4mO6jJfPqrQMakMVqrKkc6fVRpKYwdEOGuLos/tnwc0BtwEM542JBodXtO
I6fALUHUzq5R9mdkuAUSJ7yM7XPsIgIm8gpGRR3zH2kPFoPBhQdq2bdi/pu0Ci7s
CjfZzUx8/EhkTaR9sZH/hUanaXAyKSQ0KxuYdJ34rgpvBWuwxGo3pdManxvpiLVS
pASo7TCA9YQ/m61h4DVicmGAoC1LzKnCCgXefdI3Fa7SAyA3oY31vjTwWVi2wksQ
QgoHFf6ruAmWvEOL0+WyLNGoKC0sJItN1CVGfZr2FvnIpwifqdH8Cu9nOE2HYATf
qyansBdZ7Pkk/bE50A20asoXQpgP0EXKtOhuMNnuZvaFP36HluV/XANkPpk6taCU
IuvZkyWq
=sdLO
-----END PGP SIGNATURE-----

--coch6zutooty5uxj--

