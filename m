Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2FE19A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbfJWMMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:12:23 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:51820 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389256AbfJWMMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:12:23 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 46yq4j3b1PzKmh6;
        Wed, 23 Oct 2019 14:12:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 27R5KcEhLdMO; Wed, 23 Oct 2019 14:12:12 +0200 (CEST)
Date:   Wed, 23 Oct 2019 23:12:03 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH man-pages] Document encoded I/O
Message-ID: <20191023121203.pozm2xzrbxmcqpbr@yavin.dot.cyphar.com>
References: <cover.1571164762.git.osandov@fb.com>
 <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com>
 <20191021185356.GB81648@vader>
 <CAOQ4uxgm6MWwCDO5stUwOKKSq7Ot4-Sc96F1Evc6ra5qBE+-wA@mail.gmail.com>
 <20191023044430.alow65tnodgnu5um@yavin.dot.cyphar.com>
 <CAOQ4uxjyNZhyU9yEYkuMnD0o=sU1vJMOYJAzjV7FDjG45gaevg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6z55exvfk3ufvwzn"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjyNZhyU9yEYkuMnD0o=sU1vJMOYJAzjV7FDjG45gaevg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6z55exvfk3ufvwzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-23, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > No, I see why you choose to add the flag to open(2).
> > > I have no objection.
> > >
> > > I once had a crazy thought how to add new open flags
> > > in a non racy manner without adding a new syscall,
> > > but as you wrote, this is not relevant for O_ALLOW_ENCODED.
> > >
> > > Something like:
> > >
> > > /*
> > >  * Old kernels silently ignore unsupported open flags.
> > >  * New kernels that gets __O_CHECK_NEWFLAGS do
> > >  * the proper checking for unsupported flags AND set the
> > >  * flag __O_HAVE_NEWFLAGS.
> > >  */
> > > #define O_FLAG1 __O_CHECK_NEWFLAGS|__O_FLAG1
> > > #define O_HAVE_FLAG1 __O_HAVE_NEWFLAGS|__O_FLAG1
> > >
> > > fd =3D open(path, O_FLAG1);
> > > if (fd < 0)
> > >     return -errno;
> > > flags =3D fcntl(fd, F_GETFL, 0);
> > > if (flags < 0)
> > >     return flags;
> > > if ((flags & O_HAVE_FLAG1) !=3D O_HAVE_FLAG1) {
> > >     close(fd);
> > >     return -EINVAL;
> > > }
> >
> > You don't need to add __O_HAVE_NEWFLAGS to do this -- this already works
> > today for userspace to check whether a flag works properly
> > (specifically, __O_FLAG1 will only be set if __O_FLAG1 is supported --
> > otherwise it gets cleared during build_open_flags).
>=20
> That's a behavior of quite recent kernels since
> 629e014bb834 fs: completely ignore unknown open flags
> and maybe some stable kernels. Real old kernels don't have that luxury.

Ah okay -- so the key feature is that __O_CHECK_NEWFLAGS gets
transformed into __O_HAVE_NEWFLAGS (making it so that both the older and
current behaviours are detected). Apologies, I missed that on my first
read-through.

While it is a little bit ugly, it probably wouldn't be a bad idea to
have something like that.

> > The problem with adding new flags is that an *old* program running on a
> > *new* kernel could pass a garbage flag (__O_CHECK_NEWFLAGS for instance)
> > that causes an error only on the new kernel.
>=20
> That's a theoretic problem. Same as O_PATH|O_TMPFILE.
> Show me a real life program that passes garbage files to open.

Has "that's a theoretical problem" helped when we faced this issue in
the past? I don't disagree that this is mostly theoretical, but I have a
feeling that this is an argument that won't hold water.

As for an example of semi-garbage flag passing -- systemd passes
O_PATH|O_NOCTTY in several places. Yes, they're known flags (so not
entirely applicable to this discussion) but it's also not a meaningful
combination of flags and yet is permitted.

> > The only real solution to this (and several other problems) is
> > openat2().
>=20
> No argue about that. Come on, let's get it merged ;-)

Believe me, I'm trying. ;)

> > As for O_ALLOW_ENCODED -- the current semantics (-EPERM if it
> > is set without CAP_SYS_ADMIN) *will* cause backwards compatibility
> > issues for programs that have garbage flags set...
> >
>=20
> Again, that's theoretical. In practice, O_ALLOW_ENCODED can work with
> open()/openat(). In fact, even if O_ALLOW_ENCODED gets merged after
> openat2(), I don't think it should be forbidden by open()/openat(),
> right? Do in that sense, O_ALLOW_ENCODED does not depend on openat2().

If it's a valid open() flag it'll also be a valid openat2(2) flag. The
only question is whether the garbage-flag problem justifies making it a
no-op for open(2).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6z55exvfk3ufvwzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXbBDjwAKCRCdlLljIbnQ
EsXcAQCUXtfLFGHYmFVDIsS1FDoek+7OX+ytcdVrVIIHQyQpEwD+Mj11GrPWmFG5
U2nl3cjJcUv1fh1DLdfKraJlfb+P6Qc=
=CkBD
-----END PGP SIGNATURE-----

--6z55exvfk3ufvwzn--
