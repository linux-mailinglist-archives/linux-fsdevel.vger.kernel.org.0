Return-Path: <linux-fsdevel+bounces-14082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F63877815
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 19:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E5E2813D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B5239FC5;
	Sun, 10 Mar 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWW9dl7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7239846;
	Sun, 10 Mar 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096791; cv=none; b=PUXapImSvuy4gAUcTfUAAI02wAjSzbfEZFy/ZZv6orW+5NlZrOMJS14Fy8W/6xCvQTTRMf+S7PMOOzwYpQnTg9TK8GCW14c01aTFU+yz/vrQkYVYXxe1OCSbKb1riE2JrVlpP8cO6tTLnE9tZgOaKL0889srsG3rMqx2lSVuHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096791; c=relaxed/simple;
	bh=dJi0hqvL077FzYhAZHu2BQ7B4h/rFhXXT9umWSrAdQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5CTfy3HKoTgGUkPsh+5t9I/4dpL13l+5Uio3ZHwC5mFNIzqdLJXURkt6MXDjJUcZgrdJ6Ck5Vlp3CoXXsG0nuCMR9JbTydjsB/zKFj9WwJ9IDaruIAKus3Qk5MhP4On5hZiqgaBH1/fEwiTXqmDjxhPSFmgnwQpJYKmlwMMaeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWW9dl7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCB5C433F1;
	Sun, 10 Mar 2024 18:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710096791;
	bh=dJi0hqvL077FzYhAZHu2BQ7B4h/rFhXXT9umWSrAdQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWW9dl7PAkaVFCRjyse6Q/BAq4MgGC+/M+QS7VDW1+eus+u4FrqRBDaCwLNq9n4Gn
	 dWSBpwhtBbjvQlclE/+iP2ZhDVZ3dfiJc5GjmtexT4SrF6zPOSTY1RB6rfNnUxKKH0
	 iZTy3H+2+Y9Io42UOdPhD0zaUTWZzOfEFoz8LxRtuPaJZ8zyW1lvmgQ1G/pbjPIPhz
	 HED7JlF+cISfbevs1PvwFv1LPMabsV2cDJaThVKdZphp72jeZIRy0Lr3JTnCAgTfUQ
	 4xL4FW485+y6y2uSOYHWolkaihs9H8YggGA5ANhADs9QQH9rJyTpVxT2f1y5MQrffh
	 D9S5D75D4cQ2w==
Date: Sun, 10 Mar 2024 19:53:07 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: sendfile(2) erroneously yields EINVAL on too large counts
Message-ID: <Ze4Bk6UJHVgraFct@debian>
References: <38nr2286-1o9q-0004-2323-799587773o15@vanv.qr>
 <ZeXSNSxs68FrkLXu@debian>
 <q17r66qo-87p4-n210-35n8-142rqn3s04r7@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lPqOrE5JVX6RNPzZ"
Content-Disposition: inline
In-Reply-To: <q17r66qo-87p4-n210-35n8-142rqn3s04r7@vanv.qr>


--lPqOrE5JVX6RNPzZ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Mar 2024 19:53:07 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: sendfile(2) erroneously yields EINVAL on too large counts

On Sun, Mar 10, 2024 at 07:35:09PM +0100, Jan Engelhardt wrote:
> >The kernel detects that offset+count would overflow, and aborts early.
> >That's actually a good thing.  Otherwise, we wouldn't have noticed that
> >the program is missing an lseek(2) call until much later.
> >addition of count+offset would cause overflow, that is, undefined
> >behavior, it's better to not even start.  Otherwise, it gets tricky to
> >write code that doesn't invoke UB.
>=20
> While offset+count would overflow arithmetically, if the file is not larg=
er
> than SSIZE_MAX, that should be just fine, because sendfile() stops at EOF
> like read() and does not read beyond EOF or produce extraneous NULs
> to the point that a huge file position would come about.

But you need a loop limit somewhere, as in

	for (i =3D 0; i < offset+count && i < actual_size; i++)

And that could be problematic in some cases.  It can make sense to be
paranoic and abort early.  And it's easy to fix at call site, just by
subtracting offset to SSIZE_MAX.

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--lPqOrE5JVX6RNPzZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXuAZMACgkQnowa+77/
2zIi3w//V7SrEYu9Qf83unCkS+kDC0aLbDSTGhZs9tyrRhA9A4/GfvNIl1FJq9a2
ck2KOvxvi7MwLCbBmHGNX8j4/ii9xfHYEkWkKtOD0w5Yrvrh9C2KLAqfpSFqeuwE
62FgEl9sT/G2gVqogI3QpkkCtxiIudqEz7/knQp8zjej898MH+Bv/EFJUccMyCVf
r6s8sl6XwIhK2nIzcYCaiPrHQ4tGg7pHCh9oVy1aQZ7CB9jN1Kz0YpuzSWUgzdE8
ozyP+atJlhmh495bmQvqR0ACb6cfFO0EpCvxMj2zAqqKzGBXEqH3nmvms5nwlcKE
vBM241r+WGHQJYUizPH5TFo9aJNyOcKMu3XS5OZkePpn57hae8ThaQyjQlwaFr9f
1AT9yaztnJLAzhFPzUpa1R4KVzHNlCD2zIqSqTNydgDeTe2j7vH/xKchsFLNAgaV
3vQRYeEWM8JSZJrYXUYYv6fEbj0/fscckfoC4dYEUsRLmkXE2f5PkbxhtRc2v/eI
+LnJEZFNm77YB9tBB7z0I+7eHJwJngw4DH0z4OU6w70q1km0eOUe2GsNRT22LyND
vVQeCNKwZCHHLxVmWcyMp4srNiKBoLv2CujpD+OEL9OFPOpOgqGzdEkYZECw4XA2
IKhJgHjmn/1ZnL59rQnOgWdruvc8+SVMRHBJtNp296BZjvy7ou8=
=5y3p
-----END PGP SIGNATURE-----

--lPqOrE5JVX6RNPzZ--

