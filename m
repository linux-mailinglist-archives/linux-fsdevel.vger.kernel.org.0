Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865A2E1131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 06:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbfJWEuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 00:50:35 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:50898 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbfJWEuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 00:50:35 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2019 00:50:33 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 46yd8F2NnvzQlB5;
        Wed, 23 Oct 2019 06:44:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id A21LRg84gyiz; Wed, 23 Oct 2019 06:44:41 +0200 (CEST)
Date:   Wed, 23 Oct 2019 15:44:30 +1100
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
Message-ID: <20191023044430.alow65tnodgnu5um@yavin.dot.cyphar.com>
References: <cover.1571164762.git.osandov@fb.com>
 <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com>
 <20191021185356.GB81648@vader>
 <CAOQ4uxgm6MWwCDO5stUwOKKSq7Ot4-Sc96F1Evc6ra5qBE+-wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ktwjm7xv3mmbdwgt"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgm6MWwCDO5stUwOKKSq7Ot4-Sc96F1Evc6ra5qBE+-wA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ktwjm7xv3mmbdwgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-22, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, Oct 21, 2019 at 9:54 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > On Mon, Oct 21, 2019 at 09:18:13AM +0300, Amir Goldstein wrote:
> > > CC: Ted
> > >
> > > What ever happened to read/write ext4 encrypted data API?
> > > https://marc.info/?l=3Dlinux-ext4&m=3D145030599010416&w=3D2
> > >
> > > Can we learn anything from the ext4 experience to improve
> > > the new proposed API?
> >
> > I wasn't aware of these patches, thanks for pointing them out. Ted, do
> > you have any thoughts about making this API work for fscrypt?
> >
> > > On Wed, Oct 16, 2019 at 12:29 AM Omar Sandoval <osandov@osandov.com> =
wrote:
> > > >
> > > > From: Omar Sandoval <osandov@fb.com>
> > > >
> > > > This adds a new page, rwf_encoded(7), providing an overview of enco=
ded
> > > > I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
> > > > reference it.
> > > >
> > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > ---
> > > >  man2/fcntl.2       |  10 +-
> > > >  man2/open.2        |  13 ++
> > > >  man2/readv.2       |  46 +++++++
> > > >  man7/rwf_encoded.7 | 297 +++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  4 files changed, 365 insertions(+), 1 deletion(-)
> > > >  create mode 100644 man7/rwf_encoded.7
> > > >
> > > > diff --git a/man2/fcntl.2 b/man2/fcntl.2
> > > > index fce4f4c2b..76fe9cc6f 100644
> > > > --- a/man2/fcntl.2
> > > > +++ b/man2/fcntl.2
> > > > @@ -222,8 +222,9 @@ On Linux, this command can change only the
> > > >  .BR O_ASYNC ,
> > > >  .BR O_DIRECT ,
> > > >  .BR O_NOATIME ,
> > > > +.BR O_NONBLOCK ,
> > > >  and
> > > > -.B O_NONBLOCK
> > > > +.B O_ENCODED
> > > >  flags.
> > > >  It is not possible to change the
> > > >  .BR O_DSYNC
> > > > @@ -1803,6 +1804,13 @@ Attempted to clear the
> > > >  flag on a file that has the append-only attribute set.
> > > >  .TP
> > > >  .B EPERM
> > > > +Attempted to set the
> > > > +.B O_ENCODED
> > > > +flag and the calling process did not have the
> > > > +.B CAP_SYS_ADMIN
> > > > +capability.
> > > > +.TP
> > > > +.B EPERM
> > > >  .I cmd
> > > >  was
> > > >  .BR F_ADD_SEALS ,
> > > > diff --git a/man2/open.2 b/man2/open.2
> > > > index b0f485b41..cdd3c549c 100644
> > > > --- a/man2/open.2
> > > > +++ b/man2/open.2
> > > > @@ -421,6 +421,14 @@ was followed by a call to
> > > >  .BR fdatasync (2)).
> > > >  .IR "See NOTES below" .
> > > >  .TP
> > > > +.B O_ENCODED
> > > > +Open the file with encoded I/O permissions;
> > >
> > > 1. I find the name of the flag confusing.
> > > Yes, most people don't read documentation so carefully (or at all)
> > > so they will assume O_ENCODED will affect read/write or that it
> > > relates to RWF_ENCODED in a similar way that O_SYNC relates
> > > to RWF_SYNC (i.e. logical OR and not logical AND).
> > >
> > > I am not good at naming and to prove it I will propose:
> > > O_PROMISCUOUS, O_MAINTENANCE, O_ALLOW_ENCODED
> >
> > Agreed, the name is misleading. I can't think of anything better than
> > O_ALLOW_ENCODED, so I'll go with that unless someone comes up with
> > something better :)
> >
> > > 2. While I see no harm in adding O_ flag to open(2) for this
> > > use case, I also don't see a major benefit in adding it.
> > > What if we only allowed setting the flag via fcntl(2) which returns
> > > an error on old kernels?
> > > Since unlike most O_ flags, O_ENCODED does NOT affect file
> > > i/o without additional opt-in flags, it is not standard anyway and
> > > therefore I find that setting it only via fcntl(2) is less error pron=
e.
> >
> > If I make this fcntl-only, then it probably shouldn't be through
> > F_GETFL/F_SETFL (it'd be pretty awkward for an O_ flag to not be valid
> > for open(), and also awkward to mix some non-O_ flag with O_ flags for
> > F_GETFL/F_SETFL). So that leaves a couple of options:
> >
> > 1. Get/set it with F_GETFD/F_SETFD, which is currently only used for
> >    FD_CLOEXEC. That also silently ignores unknown flags, but as with the
> >    O_ flag option, I don't think that's a big deal for FD_ALLOW_ENCODED.
> > 2. Add a new fcntl command (F_GETFD2/F_SETFD2?). This seems like
> >    overkill to me.
> >
> > However, both of these options are annoying to implement. Ideally, we
> > wouldn't have to add another flags field to struct file. But, to reuse
> > f_flags, we'd need to make sure that FD_ALLOW_ENCODED doesn't collide
> > with other O_ flags, and we'd probably want to hide it from F_GETFL. At
> > that point, it might as well be an O_ flag.
> >
> > It seems to me that it's more trouble than it's worth to make this not
> > an O_ flag, but please let me know if you see a nice way to do so.
> >
>=20
> No, I see why you choose to add the flag to open(2).
> I have no objection.
>=20
> I once had a crazy thought how to add new open flags
> in a non racy manner without adding a new syscall,
> but as you wrote, this is not relevant for O_ALLOW_ENCODED.
>=20
> Something like:
>=20
> /*
>  * Old kernels silently ignore unsupported open flags.
>  * New kernels that gets __O_CHECK_NEWFLAGS do
>  * the proper checking for unsupported flags AND set the
>  * flag __O_HAVE_NEWFLAGS.
>  */
> #define O_FLAG1 __O_CHECK_NEWFLAGS|__O_FLAG1
> #define O_HAVE_FLAG1 __O_HAVE_NEWFLAGS|__O_FLAG1
>=20
> fd =3D open(path, O_FLAG1);
> if (fd < 0)
>     return -errno;
> flags =3D fcntl(fd, F_GETFL, 0);
> if (flags < 0)
>     return flags;
> if ((flags & O_HAVE_FLAG1) !=3D O_HAVE_FLAG1) {
>     close(fd);
>     return -EINVAL;
> }

You don't need to add __O_HAVE_NEWFLAGS to do this -- this already works
today for userspace to check whether a flag works properly
(specifically, __O_FLAG1 will only be set if __O_FLAG1 is supported --
otherwise it gets cleared during build_open_flags).

The problem with adding new flags is that an *old* program running on a
*new* kernel could pass a garbage flag (__O_CHECK_NEWFLAGS for instance)
that causes an error only on the new kernel.

The only real solution to this (and several other problems) is
openat2(). As for O_ALLOW_ENCODED -- the current semantics (-EPERM if it
is set without CAP_SYS_ADMIN) *will* cause backwards compatibility
issues for programs that have garbage flags set...

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ktwjm7xv3mmbdwgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXa/apwAKCRCdlLljIbnQ
EoJwAQCxY/gATRGu+FVsMqOklJHeXTKykKOx+9YlH295asKanQEA1XGg4wMmdw3y
jmvQkXGHwWE5Au/2nfi7i2iQAUzRhQk=
=P4IZ
-----END PGP SIGNATURE-----

--ktwjm7xv3mmbdwgt--
