Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9717428724B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 12:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgJHKN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 06:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729132AbgJHKN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602152007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0DI6cdznG5nm+heSXwkKOYcVMdwxr+rsH5+ws7BCShc=;
        b=D0mTLsDnReO0Fah3+YeatxHlw7PWMOLrRMTJ6a45+XSnuSsUWxL8AkCJQykYtT7/Nt7XHW
        ED6hCVWvzaxpgMaL53mcD7XnyTFHJGzNGvIQdsgMFvgJeT15LiOORuQlUNfgPm999Lyo6q
        +qAtZgSNY3islbEl+ONPxlETfzMAn5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-Sr6KnH4nMzGSKSK-TExI6g-1; Thu, 08 Oct 2020 06:13:22 -0400
X-MC-Unique: Sr6KnH4nMzGSKSK-TExI6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ED6956BF8;
        Thu,  8 Oct 2020 10:13:20 +0000 (UTC)
Received: from localhost (ovpn-115-14.ams2.redhat.com [10.36.115.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5067F6EF4A;
        Thu,  8 Oct 2020 10:13:13 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:13:12 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtio-fs-list <virtio-fs@redhat.com>,
        CAI Qian <caiqian@redhat.com>
Subject: Re: [PATCH] virtiofs: Fix false positive warning
Message-ID: <20201008101312.GA17253@stefanha-x1.localdomain>
References: <20201005174531.GB4302@redhat.com>
 <20201006153933.GA87345@stefanha-x1.localdomain>
 <20201006190949.GH5306@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006190949.GH5306@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2020 at 03:09:49PM -0400, Vivek Goyal wrote:
> On Tue, Oct 06, 2020 at 04:39:33PM +0100, Stefan Hajnoczi wrote:
> > On Mon, Oct 05, 2020 at 01:45:31PM -0400, Vivek Goyal wrote:
> > > virtiofs currently maps various buffers in scatter gather list and it=
 looks
> > > at number of pages (ap->pages) and assumes that same number of pages =
will
> > > be used both for input and output (sg_count_fuse_req()), and calculat=
es
> > > total number of scatterlist elements accordingly.
> > >=20
> > > But looks like this assumption is not valid in all the cases. For exa=
mple,
> > > Cai Qian reported that trinity, triggers warning with virtiofs someti=
mes.
> > > A closer look revealed that if one calls ioctl(fd, 0x5a004000, buf), =
it
> > > will trigger following warning.
> > >=20
> > > WARN_ON(out_sgs + in_sgs !=3D total_sgs)
> > >=20
> > > In this case, total_sgs =3D 8, out_sgs=3D4, in_sgs=3D3. Number of pag=
es is 2
> > > (ap->pages), but out_sgs are using both the pages but in_sgs are usin=
g
> > > only one page. (fuse_do_ioctl() sets out_size to one page).
> > >=20
> > > So existing WARN_ON() seems to be wrong. Instead of total_sgs, it sho=
uld
> > > be max_sgs and make sure out_sgs and in_sgs don't cross max_sgs. This
> > > will allow input and output pages numbers to be different.
> > >=20
> > > Reported-by: Qian Cai <cai@redhat.com>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > Link: https://lore.kernel.org/linux-fsdevel/5ea77e9f6cb8c2db43b09fbd4=
158ab2d8c066a0a.camel@redhat.com/
> > > ---
> > >  fs/fuse/virtio_fs.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index da3ede268604..3f4f2fa0bb96 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -1110,17 +1110,17 @@ static int virtio_fs_enqueue_req(struct virti=
o_fs_vq *fsvq,
> > >  =09unsigned int argbuf_used =3D 0;
> > >  =09unsigned int out_sgs =3D 0;
> > >  =09unsigned int in_sgs =3D 0;
> > > -=09unsigned int total_sgs;
> > > +=09unsigned int  max_sgs;
> > >  =09unsigned int i;
> > >  =09int ret;
> > >  =09bool notify;
> > >  =09struct fuse_pqueue *fpq;
> > > =20
> > >  =09/* Does the sglist fit on the stack? */
> > > -=09total_sgs =3D sg_count_fuse_req(req);
> >=20
> > sg_count_fuse_req() should be exact. It's risky to treat it as a maximu=
m
> > unless all cases where in_sgs + out_sgs < total_sgs are understood. Eve=
n
> > then, it's still possible that new bugs introduced to the code will go
> > undetected due to the weaker WARN_ON() condition.
> >=20
> > Do you have the values of the relevant fuse_req and fuse_args_pages
> > fields so we can understand exactly what happened? I think the issue is
> > that sg_count_fuse_req() doesn't use the fuse_page_desc size field.
>=20
> Hi Stefan,
>=20
> I revised the patch. How about following. This calculates number of
> sgs accurately by going through ap->descs and size fields.
>=20
> Thanks
> Vivek
>=20
> From 24b590ebc2ffc8ed02c013b11818af89d0b135ba Mon Sep 17 00:00:00 2001
> From: Vivek Goyal <vgoyal@redhat.com>
> Date: Tue, 6 Oct 2020 14:53:06 -0400
> Subject: [PATCH 1/1] virtiofs: Calculate number of scatter-gather element=
s
>  accurately
>=20
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
> only one page. In this case, fuse_do_ioctl() sets different size values
> for input and output.
>=20
> args->in_args[args->in_numargs - 1].size =3D=3D 6656
> args->out_args[args->out_numargs - 1].size =3D=3D 4096
>=20
> So current method of calculating how many scatter-gather list elements
> will be used is not accurate. Make calculations more precise by parsing
> size and ap->descs.
>=20
> Reported-by: Qian Cai <cai@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Link: https://lore.kernel.org/linux-fsdevel/5ea77e9f6cb8c2db43b09fbd4158a=
b2d8c066a0a.camel@redhat.com/
> ---
>  fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9+5jYACgkQnKSrs4Gr
c8hoPggAgtJqc+a6Y+IJS5ZWLq4Bl2BM2uwK5omJKVMZgR1Zobelex5q/PUDAuis
yIIRkL0WEXOZafdrBgP5m45z4BEB23GgsMFsj1m0xoc1zysNQnqEi26DxOJyAsTj
q7zecSpM6wiqlPjzKl9u1FcCPRzODrqbXvAoYpGZ+A6V7OMyQXzje5XK1iXc19bB
91kr+TbROk2LdQLmWaqU1dC7ICSYWdtQ7gZ4MomuxiKiWFXX+eEl9CpEk+NlYl21
36sP1umT77PBcas4n7ntMjQp8LyG5P5ovfCm2IAT/KrlMuFqhdE7WIgj7ZYpI5+L
I4qVdVD1BKTE4TuFbBF9SiTKX+ZqFw==
=JlBb
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

