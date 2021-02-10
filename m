Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7A31699A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 16:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBJO7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 09:59:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231362AbhBJO7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612969105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXWQ3QsL02YUQqB+nIIe08owddr9BAKCHOsheK1b9hM=;
        b=IdtrUlXTHHYjWEMFwS4+rdgmt3byBJ3JIvaq96TTf5MRIBeQu6HBbIJwDFrSP89CbTlY9w
        IAyPhv7EeARZ0fQJnh1VXJ9g3TxsVsuwJjFANhSk8Jq1ut2ZryZ60zdK27R9xux7B2xy2x
        koid4TXIlSpMF1Xw0p2UUkHgASX7GWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-B1zn18xsMXiDzWEEnMcDrw-1; Wed, 10 Feb 2021 09:58:20 -0500
X-MC-Unique: B1zn18xsMXiDzWEEnMcDrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3613D189DF4F;
        Wed, 10 Feb 2021 14:58:19 +0000 (UTC)
Received: from localhost (ovpn-115-120.ams2.redhat.com [10.36.115.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD2A60936;
        Wed, 10 Feb 2021 14:58:15 +0000 (UTC)
Date:   Wed, 10 Feb 2021 14:58:14 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofs: Fail dax mount if device does not support it
Message-ID: <20210210145814.GA231286@stefanha-x1.localdomain>
References: <20210209224754.GG3171@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20210209224754.GG3171@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 09, 2021 at 05:47:54PM -0500, Vivek Goyal wrote:
> Right now "mount -t virtiofs -o dax myfs /mnt/virtiofs" succeeds even
> if filesystem deivce does not have a cache window and hence DAX can't
> be supported.
>=20
> This gives a false sense to user that they are using DAX with virtiofs
> but fact of the matter is that they are not.
>=20
> Fix this by returning error if dax can't be supported and user has asked
> for it.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> Index: redhat-linux/fs/fuse/virtio_fs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- redhat-linux.orig/fs/fuse/virtio_fs.c	2021-02-04 10:40:21.704370721 -=
0500
> +++ redhat-linux/fs/fuse/virtio_fs.c	2021-02-09 15:56:45.693653979 -0500
> @@ -1324,8 +1324,15 @@ static int virtio_fs_fill_super(struct s
> =20
>  	/* virtiofs allocates and installs its own fuse devices */
>  	ctx->fudptr =3D NULL;
> -	if (ctx->dax)
> +	if (ctx->dax) {
> +		if (!fs->dax_dev) {
> +			err =3D -EINVAL;
> +			pr_err("virtio-fs: dax can't be enabled as filesystem"
> +			       " device does not support it.\n");
> +			goto err_free_fuse_devs;
> +		}
>  		ctx->dax_dev =3D fs->dax_dev;
> +	}
>  	err =3D fuse_fill_super_common(sb, ctx);
>  	if (err < 0)
>  		goto err_free_fuse_devs;

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmAj9IYACgkQnKSrs4Gr
c8hKswgAx8cnf0HAP8eDaXN2en5yHDUSGwKbvCKrRN5KNUKPcwK372PNnX+H2Kp2
/ngf5Umzb1oxvofxNWuZUuHRYl/LFVIcYlICW6IvccaR4DFHEKj9tHOA9SiEbg8j
o9F3P7wgB2V6Hq5fH4556VUJJjWYTKQQO9WRWoQKJL1zeRUHcuhJIIFsJOpWQgTP
k98uM6spvg21o0BFH+QVh3shizFkzYzYz6CtGhiKfPuEN0mMvr3zcwJpgETgNpOf
DuMdsxNLf/DZc1Y5K3Kzhc5tf3EszcunGrFbbxhU3dAXX2CUQbB1fVEBRWwNPrlf
8Kd8n7XyHtehZIGHabdIQNWGW0yyoA==
=X28C
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

