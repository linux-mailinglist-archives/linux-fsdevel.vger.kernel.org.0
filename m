Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD5284F1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFPjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 11:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgJFPju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601998789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7j3tlaqwikKX6dXf5OjrfH7DeJ1R8898CPkDBkVnN9c=;
        b=DPCYBf0AmhHH9mhXQ6n1WSxdrlrp/tX12o504m7I1CXPVND/DJjhGVazkZGCxi9gUDYzuN
        TG6nNDRS1w+Gtg4Zmdc4WaIm01BOqSEt/8ygBqawQEQUZAAVzEzTvNzvn5ab4CpEDCtLDq
        s91Pq4ox+wZuLcUA7L4aUQmeQ7F/ADc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-Oq-wDvjeM9itdg4nlaqF8Q-1; Tue, 06 Oct 2020 11:39:43 -0400
X-MC-Unique: Oq-wDvjeM9itdg4nlaqF8Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 657AF1006704;
        Tue,  6 Oct 2020 15:39:42 +0000 (UTC)
Received: from localhost (ovpn-115-42.ams2.redhat.com [10.36.115.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D51E15C1BD;
        Tue,  6 Oct 2020 15:39:35 +0000 (UTC)
Date:   Tue, 6 Oct 2020 16:39:33 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>,
        CAI Qian <caiqian@redhat.com>
Subject: Re: [PATCH] virtiofs: Fix false positive warning
Message-ID: <20201006153933.GA87345@stefanha-x1.localdomain>
References: <20201005174531.GB4302@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201005174531.GB4302@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 01:45:31PM -0400, Vivek Goyal wrote:
> virtiofs currently maps various buffers in scatter gather list and it loo=
ks
> at number of pages (ap->pages) and assumes that same number of pages will
> be used both for input and output (sg_count_fuse_req()), and calculates
> total number of scatterlist elements accordingly.
>=20
> But looks like this assumption is not valid in all the cases. For example=
,
> Cai Qian reported that trinity, triggers warning with virtiofs sometimes.
> A closer look revealed that if one calls ioctl(fd, 0x5a004000, buf), it
> will trigger following warning.
>=20
> WARN_ON(out_sgs + in_sgs !=3D total_sgs)
>=20
> In this case, total_sgs =3D 8, out_sgs=3D4, in_sgs=3D3. Number of pages i=
s 2
> (ap->pages), but out_sgs are using both the pages but in_sgs are using
> only one page. (fuse_do_ioctl() sets out_size to one page).
>=20
> So existing WARN_ON() seems to be wrong. Instead of total_sgs, it should
> be max_sgs and make sure out_sgs and in_sgs don't cross max_sgs. This
> will allow input and output pages numbers to be different.
>=20
> Reported-by: Qian Cai <cai@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Link: https://lore.kernel.org/linux-fsdevel/5ea77e9f6cb8c2db43b09fbd4158a=
b2d8c066a0a.camel@redhat.com/
> ---
>  fs/fuse/virtio_fs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index da3ede268604..3f4f2fa0bb96 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -1110,17 +1110,17 @@ static int virtio_fs_enqueue_req(struct virtio_fs=
_vq *fsvq,
>  =09unsigned int argbuf_used =3D 0;
>  =09unsigned int out_sgs =3D 0;
>  =09unsigned int in_sgs =3D 0;
> -=09unsigned int total_sgs;
> +=09unsigned int  max_sgs;
>  =09unsigned int i;
>  =09int ret;
>  =09bool notify;
>  =09struct fuse_pqueue *fpq;
> =20
>  =09/* Does the sglist fit on the stack? */
> -=09total_sgs =3D sg_count_fuse_req(req);

sg_count_fuse_req() should be exact. It's risky to treat it as a maximum
unless all cases where in_sgs + out_sgs < total_sgs are understood. Even
then, it's still possible that new bugs introduced to the code will go
undetected due to the weaker WARN_ON() condition.

Do you have the values of the relevant fuse_req and fuse_args_pages
fields so we can understand exactly what happened? I think the issue is
that sg_count_fuse_req() doesn't use the fuse_page_desc size field.

Stefan

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl98j7UACgkQnKSrs4Gr
c8gB6gf/aZ4tHmBLaYFN2d9LhfdfFVtnA4Ey8AZGt4yF1aXTtvgX+PVs7dGnPxQK
E2SPRJuNiFpxRN0VwtOxABWO7GG5osYU4l4Tc0+PIBfcyhQUbjWiFchh3TJ3aa+P
Q55fXTSIhfVWi29hTCSofrfjGKyUoJYZ1FvBTjom38S7Bb+36pMWQ0L7Akvs3uTn
gKJdfriolsjxqMPK5Pu/uX08RTcT9ty1gs3KYi9LtVvZZzlntFCEgqicMODevDst
glPRwjRrtMRFVUpX6Xj56Y8XguFwZXgeVRKwdteF2hzbyelpxgutFwbA7gGqqt+Z
9zhzdLjfpJ6T6jl7m5foLXAjuz9fFQ==
=pEjP
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

