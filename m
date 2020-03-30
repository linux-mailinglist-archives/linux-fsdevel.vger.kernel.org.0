Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05341977B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgC3JVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 05:21:11 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:24390 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgC3JVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:21:11 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48rRlm5Yk9zQlFX;
        Mon, 30 Mar 2020 11:21:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id Hq1kmaX4fCTi; Mon, 30 Mar 2020 11:21:00 +0200 (CEST)
Date:   Mon, 30 Mar 2020 20:20:51 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
Message-ID: <20200330092051.umcu2mjnwqazml7a@yavin.dot.cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <4dcea613-60b8-a8af-9688-be93858ab652@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jub6wegi3tyrl3an"
Content-Disposition: inline
In-Reply-To: <4dcea613-60b8-a8af-9688-be93858ab652@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--jub6wegi3tyrl3an
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> Hello Aleksa,
>=20
> On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> > Rather than trying to merge the new syscall documentation into open.2
> > (which would probably result in the man-page being incomprehensible),
> > instead the new syscall gets its own dedicated page with links between
> > open(2) and openat2(2) to avoid duplicating information such as the list
> > of O_* flags or common errors.
> >=20
> > In addition to describing all of the key flags, information about the
> > extensibility design is provided so that users can better understand why
> > they need to pass sizeof(struct open_how) and how their programs will
> > work across kernels. After some discussions with David Laight, I also
> > included explicit instructions to zero the structure to avoid issues
> > when recompiling with new headers.>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> I'm just editing this page, and have a question on one piece.
>=20
> > +Unlike
> > +.BR openat (2),
> > +it is an error to provide
> > +.BR openat2 ()
> > +with a
> > +.I mode
> > +which contains bits other than
> > +.IR 0777 ,
>=20
> This piece appears not to be true, both from my reading of the
> source code, and from testing (i.e., I wrote a a small program that
> successfully called openat2() and created a file that had the
> set-UID, set-GID, and sticky bits set).
>=20
> Is this a bug in the implementation or a bug in the manual page text?

My bad -- it's a bug in the manual. The actual check (which does work,
there are selftests for this) is:

	if (how->mode & ~S_IALLUGO)
		return -EINVAL;

But when writing the man page I forgot that S_IALLUGO also includes
those bits. Do you want me to send an updated version or would you
prefer to clean it up?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jub6wegi3tyrl3an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXoG58AAKCRCdlLljIbnQ
EmpUAP9lwsQSs79E0RPrYRETRyse93uEihw73O5jS2uGNB0ywwD/XrFtGUgmimuA
x7DnKf0T9qk7cmUJpiCSwgMpNayU3wE=
=S6iK
-----END PGP SIGNATURE-----

--jub6wegi3tyrl3an--
