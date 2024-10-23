Return-Path: <linux-fsdevel+bounces-32686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC99AD755
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 00:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03211F213DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 22:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A5B1FF5E8;
	Wed, 23 Oct 2024 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CfolJoT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9C1E00A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721178; cv=none; b=abSsM2c2QOdPtW0hUaDGZ1QJcbg/gmXeGVAw3Yfh9N3izv+FRofZt0XuUntE4vK51wTZDd0IGKWzpSkeqI8uAV/e+uAn+ucn7+mO220AsMC7+WQXHh9tQubBC9UOi4dvWh96hDAH/C2a2iuFVyLSW55wDeMvVjiO56UPy1XWQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721178; c=relaxed/simple;
	bh=984GCKVsYEArTj3PUCgwkFaD949QlJM45EbYy2MZ0NE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCPdVgi1EGev7LE4hFKq0o/YAZCMDEjTFf9JgB/LV0eiaDOkCxPxjUTgHpnpLv3CNdIi608kytEGQAGESitw5zFe3W/JGEjPZJ1EJwkXVijo6f71JhFahnU8iWNHsOoBBvQGDhOX4/fzoBuU3Udy5aBKUNxHrqL+SMY2KQVe70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=CfolJoT7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729721171;
	bh=J36rfoeTlZh3Nkp+SSjUhA4ZxZSawyhuFKBwkzLttAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CfolJoT7PkGz5agQKGrg8gSHa6CoGx4tJ7LMCZiPlytQF+9Bpgr9N7QYvaA+ydXm7
	 Q5iR9tcYlaEfBi6UBA1m/CdUnuJbEZMKx7ekUW5nBr7m5pWKfPrvythyY0ViKcRs3j
	 oKnjQ2Pq2eQKF2kAqvgA3OT52gBtsrv2S37OssF9nt6FK0gUs4nlKSPEM523ywoMmS
	 RPkk7r2DeOeYqijrJnXaLfSzVx6EXAkjj0elqiH50p5aWXhgiGC9o2kdYeze/vCr0S
	 uwaIEZ/Fk9THX0ZFX12OcMXicNKdG+qUjFNBAEcJfEu5NCf4UpxxsWhKVptfEVJDzz
	 f/Cvg/K8mdzSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYjmg3QZWz4w2L;
	Thu, 24 Oct 2024 09:06:11 +1100 (AEDT)
Date: Thu, 24 Oct 2024 09:06:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, sunjunchao2870@gmail.com, Linux Filesystem Development
 List <linux-fsdevel@vger.kernel.org>, Christian Brauner
 <christian@brauner.io>
Subject: Re: [REGRESSION] generic/564 is failing in fs-next
Message-ID: <20241024090611.0cff2423@canb.auug.org.au>
In-Reply-To: <20241023194253.GH3204734@mit.edu>
References: <20241018162837.GA3307207@mit.edu>
	<20241019161601.GJ21836@frogsfrogsfrogs>
	<20241021-anstecken-fortfahren-4dd7b79a5f45@brauner>
	<20241023194253.GH3204734@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aUo4yl/z7S6rEBmX8VZUQ+V";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/aUo4yl/z7S6rEBmX8VZUQ+V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ted,

On Wed, 23 Oct 2024 15:42:53 -0400 "Theodore Ts'o" <tytso@mit.edu> wrote:
>
> On Mon, Oct 21, 2024 at 02:49:54PM +0200, Christian Brauner wrote:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/fs/read_write.c?h=3Dfs-next&id=3D0f0f217df68fd72d91d2de6e85a6dd80fa1f=
5c95
> > >=20
> > > To Mr. Sun: did you see these regressions when you tested this patch?=
 =20
> >=20
> > So we should drop this patch for now. =20
>=20
> My most recent fs-next testing is still showing this failure, and
> looking at the most recent fs-next branch,=20
>=20
>     vfs: Fix implicit conversion problem when testing overflow case
>=20
> still appears to be in the tree.  Can we please get this dropped?
> Thanks!!

I have reverted that commit from the fs-next and linux-next trees for
today.

--=20
Cheers,
Stephen Rothwell

--Sig_/aUo4yl/z7S6rEBmX8VZUQ+V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcZc1MACgkQAVBC80lX
0Gy3dwf/SmYXSo0ctMdPXPjG4VSM4dHBM7OAWXQ1pUj0AZLEldV+UqAB9rDbgMSh
mM/40JzVID3JiMm847HH0ePHiH99OB+k7iaSFN3mb+tWIxaFC8mokSXhza+nkun8
xCRsKyeqRciUYkjVRUqPbqAji7T89jb52jLEjDU09w6YlL6ermRc+YffSIwZ8d5F
JUOy1+lirr6zieJbAlbr1W0fmadIT7Quitefs4Z2l1yAu7qOp0SJ91VOUCqq07sq
cndbOMCLk5I6vrayzx2lSizorWx/w9pQESfsQT4oL4VVUjVkOfaGkjVJOfJz8iqr
hjyOQwnZfMswlOd/GspxxXrM3D6D6w==
=R8Nc
-----END PGP SIGNATURE-----

--Sig_/aUo4yl/z7S6rEBmX8VZUQ+V--

