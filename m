Return-Path: <linux-fsdevel+bounces-12969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E32869B96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E27B2E10E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA0146007;
	Tue, 27 Feb 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLv0SXmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC881EEE6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049368; cv=none; b=s6q3lL2sGyFeK3AVP6PG8BW5fnCGGNezQD9Z40o1jUA8kTDJkGRRG59N2usX8HQL2wDi2UFjp7auGSNfIJmU9OceoCUZ7vuw15pjULMEg7HRung8f2U0KeidqWpiZJ5+XGgwidS07cV5oMYBV/Ya943gHFQhJCsgmHF3JL+MYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049368; c=relaxed/simple;
	bh=s3wlEquGysXZAaufy+BZCB9S+atZVvdmjHpRk6wPMeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdT/3EeAz/uQcfMGhLr2VtChigKrA+hw6+QKb3qNxH02RAZ/fcfPTTbWkN5r76BINmFQXJYoJq18RhM7HTcyNrkztte41SXljzzJSixCyaEmr09i8A5XyV6yE3EOCS0Hk5fvUl193pMlAL3xCVQjEpUxsJkx/ysTILPhsGiGYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QLv0SXmU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709049365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3wlEquGysXZAaufy+BZCB9S+atZVvdmjHpRk6wPMeo=;
	b=QLv0SXmUxh31XP+9xLnc/PNjzM2TGNgWsAjv5J9N39+tWXFN7oh3fKlB773G8/Zsr1vTVc
	tb6BtTNqt0p5OiBaCp1CTGE2cQj5Eo0FpaKgr7wpempDrHd0cIlh8VjIix5APmdMCZ+t6f
	/D75bB6Pi+7O8QVTV+4lyCs8eK7Dl94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-Z9UyeypHOFWe3T3UrO0UeQ-1; Tue, 27 Feb 2024 10:55:57 -0500
X-MC-Unique: Z9UyeypHOFWe3T3UrO0UeQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1082185A782;
	Tue, 27 Feb 2024 15:55:56 +0000 (UTC)
Received: from localhost (unknown [10.39.192.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE0F3492BE2;
	Tue, 27 Feb 2024 15:55:55 +0000 (UTC)
Date: Tue, 27 Feb 2024 10:55:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: linux-next: Tree for Feb 26 (fs/fuse/virtio_fs.c)
Message-ID: <20240227155554.GD386283@fedora>
References: <20240226175509.37fa57da@canb.auug.org.au>
 <81c5b68d-90ca-4599-9cc8-a1d737750aaa@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P7SwKHF8daUBXYQU"
Content-Disposition: inline
In-Reply-To: <81c5b68d-90ca-4599-9cc8-a1d737750aaa@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


--P7SwKHF8daUBXYQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 05:01:33PM -0800, Randy Dunlap wrote:
>=20
>=20
> On 2/25/24 22:55, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Changes since 20240223:
> >=20
>=20
> on 20 randconfig builds (arm64, loongarch, riscv32, riscv64, i386, and x8=
6_64):
>=20
> WARNING: modpost: fs/fuse/virtiofs: section mismatch in reference: virtio=
_fs_init+0xf9 (section: .init.text) -> virtio_fs_sysfs_exit (section: .exit=
=2Etext)
>=20
> For
> static void __exit virtio_fs_sysfs_exit(void)
>=20
> probably just s/__exit// since it is called from both
> __init and __ext code.

Thanks, Randy. I am sending a fix.

Stefan

>=20
>=20
> --=20
> #Randy
>=20

--P7SwKHF8daUBXYQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmXeBgoACgkQnKSrs4Gr
c8ixNggAug/rstk7tDL114D+Pvuc4VMmv9y4avToZ/AnAUhGuHymMB76nvVGpmnw
fvxQiTO7esRLuVXEdJ9MZHStvl6TP/dAP6ZgwHwew4WjAVG7lg369lgFn/QluZ1R
B4Fh6bkUVSETnvZRYL+7RwctDS0fcVQTg781QuMx2JP7GsBXUd7P9FFDTFTs1nYy
4EXJVXS/H0t5l9l6lQS1RZ70Qx+ozB3wlaU4pa5tQGxNH59fvJEu2UjtckQConqQ
nDFkn0O/9aqtImsKCXEKoqYKbk5WdxQyLPOhblTWxEqu7eUzWLQFLqMb3FfPxMgQ
GhSfVKjxQ8iIATRWfLl7qcSdnjJ3CQ==
=mGX0
-----END PGP SIGNATURE-----

--P7SwKHF8daUBXYQU--


