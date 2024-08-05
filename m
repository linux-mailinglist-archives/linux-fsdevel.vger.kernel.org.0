Return-Path: <linux-fsdevel+bounces-25025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554A947E33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587171C21E42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85C15A4AF;
	Mon,  5 Aug 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b="DU1vCdcd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a1-bg02.venev.name (a1-bg02.venev.name [213.240.239.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D620524D7;
	Mon,  5 Aug 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.240.239.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872084; cv=none; b=aP/+/GbXCctKNk3kTo8rKSD5zg8eB3uWnz3g6kPaV0/ybUsIDDmEIp0zTzrK/TYu3NFvEF78hQRFsqbZMZQltNKAJebVZdvCek5dWk+50uRwJmcVMezAEEIvxNpkcgMGxVgBAiH8+Z0FK5M7HpqF1nAulYvmZdvQ+5/UNkt4NRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872084; c=relaxed/simple;
	bh=az9IZNBf572XOHxYtYloLtOpMtowQ2MhfSY+bSjR3u0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXyP5K77W7JpuiZr+pdCUm1Pqa8jDRVrl40T94ROkxmbtXDkJXJW2eEHN5sDJYr45C0yk/M3iuULt81x+gB716sQdMTUrRiTpOfvt+MSq4ZLnHWQe3mmWoCfG1fSHzU8Y6eBhSGItiueodl3Y/18eNgOLh8NETeqBZzs4O0AN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name; spf=pass smtp.mailfrom=venev.name; dkim=pass (4096-bit key) header.d=venev.name header.i=@venev.name header.b=DU1vCdcd; arc=none smtp.client-ip=213.240.239.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=venev.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venev.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Type:Date:To:From:Subject:Message-ID:
	Content-Transfer-Encoding:Reply-To:Sender;
	bh=+75xdacdFsxgXARR9Bk36Kwb9foV0OHSOEia2xj7zNY=; b=DU1vCdcd8zw9fBuCWcoIUbwd1N
	2iT4Z2yvNfgooj+qsR6kbQdFMB9mEb7MPKt+VAoy6pAe7pdqbgGMWBQrTjm5IV6JpccyuRHsKWCg8
	Rm17xbh2I4uvc8TnSgoWclni/8uEnZX1ZZNQZxYYW6vOydyZyCxT1dwypsgxPJWMzLLdQpNi9XOzZ
	jBdxIDopSyhf0zizQWlafTUXsK7M8QxIKO6z3QFsgepxGo7bCk96cgSQoj9gHujAgmI29thBGKnyZ
	JIHQo5ifmjbTVVxxKdXiAmT2JnJtfvBzgOSDGRnJiqWkna5Bz5E1b1neZS7ktgEtT2RHJNLn+ij+8
	c0twlongBZLwZmjIhvx4IMPrzemy8q5T1L97b0sO72NJvGvnJWzyX0TlX2+R8Jw9DwsIohvt63eqW
	MoEUb5Ss/pbmwKjWA50Ci8vF+YZggJfErFSVHV4vuZ648gk776yysPSbzOrwMy6FxkMY+MrEwAVF6
	z5CW82XGZNsIuwlYe4uhvqrl67Yygm4I/UHkyfVvGCHb8guYqtSndoAm83uWZbVrjk+/oC6rDYviQ
	RLzXAlFqmhITeb21xqpoxDmHR7V5nOxYNlXwzj1jjvUHlxOYl3meT+TU7c9TDxbWQmoUuqBsiXZNU
	4nlHURCPdc4d2xHyDHQQ6UAtQuaw/qfcCTwy00QFM=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1sazj7-00000000p6D-1noa
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Mon, 05 Aug 2024 15:34:25 +0000
Received: from plank.m.venev.name ([213.240.239.48])
	by pmx1.venev.name with ESMTPSA
	id CTunOf/wsGZK/wIAT9YxdQ
	(envelope-from <hristo@venev.name>); Mon, 05 Aug 2024 15:34:25 +0000
Message-ID: <c39524ab0e2b2045f21bc64f3742ac2b96abd2b9.camel@venev.name>
Subject: Re: [PATCH] netfs: Set NETFS_RREQ_WRITE_TO_CACHE when caching is
 possible
From: Hristo Venev <hristo@venev.name>
To: Trond Myklebust <trondmy@hammerspace.com>, "max.kellermann@ionos.com"
	 <max.kellermann@ionos.com>, "dhowells@redhat.com" <dhowells@redhat.com>
Cc: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>, "xiubli@redhat.com"
 <xiubli@redhat.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "ceph-devel@vger.kernel.org"
 <ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netfs@lists.linux.dev"
 <netfs@lists.linux.dev>,  "jlayton@kernel.org" <jlayton@kernel.org>,
 "idryomov@gmail.com" <idryomov@gmail.com>,  "willy@infradead.org"
 <willy@infradead.org>, "blokos@free.fr" <blokos@free.fr>, 
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date: Mon, 05 Aug 2024 18:34:23 +0300
In-Reply-To: <ba17aecba9615f85b7901ea96609abdad3c29db1.camel@hammerspace.com>
References: <20240729091532.855688-1-max.kellermann@ionos.com>
	 <3575457.1722355300@warthog.procyon.org.uk>
	 <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
	 <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com>
	 <3717298.1722422465@warthog.procyon.org.uk>
	 <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com>
	 <845520c7e608c31751506f8162f994b48d235776.camel@venev.name>
	 <ba17aecba9615f85b7901ea96609abdad3c29db1.camel@hammerspace.com>
Autocrypt: addr=hristo@venev.name; prefer-encrypt=mutual;
 keydata=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
 AjQ6o01lu
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-m+Z7TPUh5Rd+PvHZw/pU"
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-m+Z7TPUh5Rd+PvHZw/pU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2024-08-04 at 23:22 +0000, Trond Myklebust wrote:
> On Sun, 2024-08-04 at 16:57 +0300, Hristo Venev wrote:
> > In addition to Ceph, in NFS there are also some crashes related to
> > the
> > use of 0x356 as a pointer.
> >=20
> > `netfs_is_cache_enabled()` only returns true when the fscache
> > cookie
> > is
> > fully initialized. This may happen after the request has been
> > created,
> > so check for the cookie's existence instead.
> >=20
> > Link:
> > https://lore.kernel.org/linux-nfs/b78c88db-8b3a-4008-94cb-82ae08f0e37b@=
free.fr/T/
> > Fixes: 2ff1e97587f4 ("netfs: Replace PG_fscache by setting folio-
> > > private and marking dirty")
> > Cc: linux-nfs@vger.kernel.org=C2=A0<linux-nfs@vger.kernel.org>
> > Cc: blokos <blokos@free.fr>
> > Cc: Trond Myklebust <trondmy@hammerspace.com>
> > Cc: dan.aloni@vastdata.com=C2=A0<dan.aloni@vastdata.com>
> > Signed-off-by: Hristo Venev <hristo@venev.name>
> > ---
> > =C2=A0fs/netfs/objects.c | 6 +++---
> > =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> > index f4a6427274792..a74ca90c86c9b 100644
> > --- a/fs/netfs/objects.c
> > +++ b/fs/netfs/objects.c
> > @@ -27,7 +27,6 @@ struct netfs_io_request
> > *netfs_alloc_request(struct
> > address_space *mapping,
> > =C2=A0	bool is_unbuffered =3D (origin =3D=3D NETFS_UNBUFFERED_WRITE ||
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 origin =3D=3D NETFS_DIO_READ ||
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 origin =3D=3D NETFS_DIO_WRITE);
> > -	bool cached =3D !is_unbuffered &&
> > netfs_is_cache_enabled(ctx);
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	for (;;) {
> > @@ -56,8 +55,9 @@ struct netfs_io_request
> > *netfs_alloc_request(struct
> > address_space *mapping,
> > =C2=A0	refcount_set(&rreq->ref, 1);
> > =C2=A0
> > =C2=A0	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> > -	if (cached) {
> > -		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq-
> > >flags);
> > +	if (!is_unbuffered &&
> > fscache_cookie_valid(netfs_i_cookie(ctx))) {
> > +		if(netfs_is_cache_enabled(ctx))
> > +			__set_bit(NETFS_RREQ_WRITE_TO_CACHE,
> > &rreq-
> > > flags);
> > =C2=A0		if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags))
> > =C2=A0			/* Filesystem uses deprecated PG_private_2
> > marking. */
> > =C2=A0			__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq-
> > > flags);
>=20
> Does this mean that netfs could still end up setting a value for
> folio-
> > private in NFS given some other set of circumstances?

Hopefully not? For NFS the cookie should be allocated in
`nfs_fscache_init_inode`, and for Ceph I think `ceph_fill_inode` (which
calls `ceph_fscache_register_inode_cookie`) should also be called early
enough as well.

> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>=20
>=20


--=-m+Z7TPUh5Rd+PvHZw/pU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb/2s7vGPWBH9BOGpSkmD6rj9B8sFAmaw8P8ACgkQSkmD6rj9
B8uUow/+N0iSbLU5Dj4n4YCskaXe0oYauxtSCavu/FgTNgiGxMSAZAftYPNXznPt
pD955SG00oNSAv3pJ899be31Pngurud6Ab7mhBJ+0JRNBsxJnD1NYAcDTAlKhLT/
u6PDNmB82e0fnDSOx9PYQXuepfTwG3xuUJblbLU62O/D3XEEe9BgTfevf+4LHqZF
z7ezu6qdGxeKyeVjWysFWdwjDybOYvdpiBgUML+0gnQq8A+RrB7dnVjfEJmxqksL
0ciUxXg+uvQHNVtCoR+zuKRztS7dpgeYgggUGgHVXFdC3WzCxExJZemZmXJBmB+L
8rWM4TGFCet6lNE1H5RUsBpvGQcYKqGpPDpeLQuI+dhmmTg3q29IM9ERTsD91FqA
b+xzw0B84IPa2j6RWHjvh4C8kHRRKaDroCuzB8/9tl5XwqFYFjoF/9aO+Js6Cwf6
5gukhuhgWFfxlqr8XJ7jQsS+KRMVGbvGxFezuquPGcINEfK+g5yPQDUBv334H/Jh
W4yKbXZ4pHeXiZLSXqBuDZYK2oGRRJaTYJ+9875HCDEZC377I7DGT7EcpUj1afVb
KsA9k5xMB/RRbP9n6VVBZ5e1osIwZfkCPG9+ZiqBbi658gHoTPsOJ0X4Z2R0p1I6
2owPKsdeN2oUerNNVQ/5MBKqWzgwsjvMO0KreUMgl7b97fIDbSI=
=67v8
-----END PGP SIGNATURE-----

--=-m+Z7TPUh5Rd+PvHZw/pU--

