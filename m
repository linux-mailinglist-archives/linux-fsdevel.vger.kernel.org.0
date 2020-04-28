Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A141BB936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgD1IxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 04:53:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726402AbgD1IxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588063996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1KpMvS5JJPrAXe2Z8MVzdEx1PSCcjjRIJzkkpDN2AEI=;
        b=gwjQirmJmZIS8zWxSh8t5pW9hTzLVoRt75ZYMqpQcAQgbwGkg6Ruka5fVC87+pjHR8yXV4
        GnyiiLaY8BzOOTl2cPklaZGEalHAPzs91Xa3uc/vT1itpC0yvI3tCHs3Wqep/27lb3Q0Au
        GoYY832uvflE0rBCCQ/Uf/QNebWUe5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-AO21JiRFMGC-1yM9MfuSiA-1; Tue, 28 Apr 2020 04:53:14 -0400
X-MC-Unique: AO21JiRFMGC-1yM9MfuSiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 196AB39347;
        Tue, 28 Apr 2020 08:53:13 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFF1927CDB;
        Tue, 28 Apr 2020 08:53:09 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:53:08 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Chirantan Ekbote <chirantan@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>
Subject: Re: [PATCH 1/2] fuse: virtiofs: Fix nullptr dereference
Message-ID: <20200428085308.GA15547@stefanha-x1.localdomain>
References: <20200424062540.23679-1-chirantan@chromium.org>
 <20200427175814.GC146096@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200427175814.GC146096@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2020 at 01:58:14PM -0400, Vivek Goyal wrote:
> On Fri, Apr 24, 2020 at 03:25:39PM +0900, Chirantan Ekbote wrote:
> > virtiofs device implementations are allowed to provide more than one
> > request queue.  In this case `fsvq->fud` would not be initialized,
> > leading to a nullptr dereference later during driver initialization.
> >=20
> > Make sure that `fsvq->fud` is initialized for all request queues even i=
f
> > the driver doesn't use them.
> >=20
> > Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> > ---
> >  fs/fuse/virtio_fs.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index bade747689033..d3c38222a7e4e 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -1066,10 +1066,13 @@ static int virtio_fs_fill_super(struct super_bl=
ock *sb)
> >  =09}
> > =20
> >  =09err =3D -ENOMEM;
> > -=09/* Allocate fuse_dev for hiprio and notification queues */
> > -=09for (i =3D 0; i < VQ_REQUEST; i++) {
> > +=09/* Allocate fuse_dev for all queues except the first request queue.=
 */
> > +=09for (i =3D 0; i < fs->nvqs; i++) {
> >  =09=09struct virtio_fs_vq *fsvq =3D &fs->vqs[i];
> > =20
> > +=09=09if (i =3D=3D VQ_REQUEST)
> > +=09=09=09continue;
> > +
>=20
> These special conditions of initializing fuse device for one queue
> fusing fill_super_common() and rest of the queues outside of it, are
> bothering me. I am proposing a separate patch where all fuse device
> initialization/cleanup is done by the caller. It makes code look
> cleaner and easier to understand.

Nice!

Stefan

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6n7vIACgkQnKSrs4Gr
c8hteAf/eYI9TctYqcOxsmycO3jHxaBajTT1j+7GE3qjJo+kGEV5XkAFdqNGKc6q
O0wtnX8BrFIGvjo/oyibAtA2r712jKx0M6TllaKEOaT5ukuWA9Ele5Ahn0rn2hJV
itjPBriTX/r/R4tAtHeItWrWgmnYhsoI29orLKPAZJbjilaiIyIStSG5UH8zmMa8
VZpqfCX+MozlIJKyMb1e//FNDY9NQ7YLpyGLb30iB5pS7Nq12bKshV0r0wsqBCws
HKz3VHyJz8Bso7GQCMiTzdeKYJuIT1ZY3NKixON2/0YAOpubd3ET19h5MFe/UX5S
p7zIWZ2hShTWipUP3SM1QCpRoOWsew==
=cZw4
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

