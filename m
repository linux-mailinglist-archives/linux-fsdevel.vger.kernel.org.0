Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2792849D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJFJ6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 05:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJFJ6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601978333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7LV4W7glSecH78sK1+Pn5RbohOXK+OKpDxoa9IzxyOE=;
        b=NKWYtG7CEqIngiPzl4CKNz7Z2ZumzpHkRA8Nk3b9cNChSKFYt0NM9zQZDWmfSDUtbS0FDG
        J8YDylWAaBJy7upka8DuDSWleY/3OKt1TXCOGj2PXKpx4LWSRiT1Kb7XiK96gAnOWqS6Tx
        tQgYGbmtCJ2yDx3ZdwmTvX6gpXSD4xE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-lLK2Aw8zM5Wouy5X8P0zEw-1; Tue, 06 Oct 2020 05:58:51 -0400
X-MC-Unique: lLK2Aw8zM5Wouy5X8P0zEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB7D1084D61;
        Tue,  6 Oct 2020 09:58:50 +0000 (UTC)
Received: from localhost (ovpn-112-180.ams2.redhat.com [10.36.112.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CE3F10013BD;
        Tue,  6 Oct 2020 09:58:44 +0000 (UTC)
Date:   Tue, 6 Oct 2020 10:04:27 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Qian Cai <cai@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Subject: Re: virtiofs: WARN_ON(out_sgs + in_sgs != total_sgs)
Message-ID: <20201006090427.GA41482@stefanha-x1.localdomain>
References: <5ea77e9f6cb8c2db43b09fbd4158ab2d8c066a0a.camel@redhat.com>
 <a2810c3a656115fab85fc173186f3e2c02a98182.camel@redhat.com>
 <20201004143119.GA58616@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201004143119.GA58616@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2020 at 10:31:19AM -0400, Vivek Goyal wrote:
> On Fri, Oct 02, 2020 at 10:44:37PM -0400, Qian Cai wrote:
> > On Fri, 2020-10-02 at 12:28 -0400, Qian Cai wrote:
> > > Running some fuzzing on virtiofs from a non-privileged user could tri=
gger a
> > > warning in virtio_fs_enqueue_req():
> > >=20
> > > WARN_ON(out_sgs + in_sgs !=3D total_sgs);
> >=20
> > Okay, I can reproduce this after running for a few hours:
> >=20
> > out_sgs =3D 3, in_sgs =3D 2, total_sgs =3D 6
>=20
> Thanks. I can also reproduce it simply by calling.
>=20
> ioctl(fd, 0x5a004000, buf);
>=20
> I think following WARN_ON() is not correct.
>=20
> WARN_ON(out_sgs + in_sgs !=3D total_sgs)
>=20
> toal_sgs should actually be max sgs. It looks at ap->num_pages and
> counts one sg for each page. And it assumes that same number of
> pages will be used both for input and output.
>=20
> But there are no such guarantees. With above ioctl() call, I noticed
> we are using 2 pages for input (out_sgs) and one page for output (in_sgs)=
.
>=20
> So out_sgs=3D4, in_sgs=3D3 and total_sgs=3D8 and warning triggers.
>=20
> I think total sgs is actually max number of sgs and warning
> should probably be.
>=20
> WARN_ON(out_sgs + in_sgs >  total_sgs)
>=20
> Stefan, WDYT?

It should be possible to calculate total_sgs precisely (not a maximum).
Treating it as a maximum could hide bugs.

Maybe sg_count_fuse_req() should count in_args/out_args[numargs -
1].size pages instead of adding ap->num_pages.

Do you have the details of struct fuse_req and struct fuse_args_pages
fields for the ioctl in question?

Thanks,
Stefan

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl98MxsACgkQnKSrs4Gr
c8gfnwf+MqC6BshRLBrYU+tLmXR6WJwbG8X0i6P2g42yuD/GJ4WOYHVPw2oEdnc/
OwEMYJ9LWwFiYmhT5DeapDx9XmVJVMlPeQ6GjkRilgo53OGu3IMi3T3JIOHKN4ZZ
nCwWqrE1CA4bVx7sX6HUKOqGwLhOIs1DrAen/sNjEtbKi2Bum1OTpo5uWDQuGEIn
BwYfQmuuSL/lBpz2Um+le97b8YskkC01oJAMONlNtQZqhYyZKl67Xbqq219Mnyzv
O0uePL5gPQr1pNOknKXmgOsZUSHn5XamPiNz2LbHFVGRswIUM0BCNFVTnfOeRi7r
Zm0jNqFLkavBPraEY08HjFnbBTwLDQ==
=Ol2A
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

