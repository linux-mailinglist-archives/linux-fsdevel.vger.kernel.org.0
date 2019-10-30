Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4252EA7A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 00:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfJ3XRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 19:17:47 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:59910 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfJ3XRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 19:17:46 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 473PWC4klPzQk03;
        Thu, 31 Oct 2019 00:17:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id U5HMwcD1nAfE; Thu, 31 Oct 2019 00:17:39 +0100 (CET)
Date:   Thu, 31 Oct 2019 10:17:31 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 1/5] fs: add O_ENCODED open flag
Message-ID: <20191030231731.n35rl3d6gss5ura6@yavin.dot.cyphar.com>
References: <cover.1571164762.git.osandov@fb.com>
 <c4d2e911b7b04df9aa8418c8b11bc4c194e3808c.1571164762.git.osandov@fb.com>
 <20191019045057.2fcrzuwc27eg5naf@yavin.dot.cyphar.com>
 <20191030225540.GG326591@vader>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jizyjt34uq6bhptu"
Content-Disposition: inline
In-Reply-To: <20191030225540.GG326591@vader>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--jizyjt34uq6bhptu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-30, Omar Sandoval <osandov@osandov.com> wrote:
> On Sat, Oct 19, 2019 at 03:50:57PM +1100, Aleksa Sarai wrote:
> > On 2019-10-15, Omar Sandoval <osandov@osandov.com> wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > >=20
> > > The upcoming RWF_ENCODED operation introduces some security concerns:
> > >=20
> > > 1. Compressed writes will pass arbitrary data to decompression
> > >    algorithms in the kernel.
> > > 2. Compressed reads can leak truncated/hole punched data.
> > >=20
> > > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > > possible to do the permissions checks at the time of the read or write
> > > because, e.g., io_uring submits IO from a worker thread. So, add an o=
pen
> > > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > > fcntl(). The flag is not cleared in any way on fork or exec; it should
> > > probably be used with O_CLOEXEC in most cases.
> > >=20
> > > Note that the usual issue that unknown open flags are ignored doesn't
> > > really matter for O_ENCODED; if the kernel doesn't support O_ENCODED,
> > > then it doesn't support RWF_ENCODED, either.
> > >=20
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  fs/fcntl.c                       | 10 ++++++++--
> > >  fs/namei.c                       |  4 ++++
> > >  include/linux/fcntl.h            |  2 +-
> > >  include/uapi/asm-generic/fcntl.h |  4 ++++
> > >  4 files changed, 17 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > index 3d40771e8e7c..45ebc6df078e 100644
> > > --- a/fs/fcntl.c
> > > +++ b/fs/fcntl.c
> > > @@ -30,7 +30,8 @@
> > >  #include <asm/siginfo.h>
> > >  #include <linux/uaccess.h>
> > > =20
> > > -#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_=
NOATIME)
> > > +#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_=
NOATIME | \
> > > +		    O_ENCODED)
> > > =20
> > >  static int setfl(int fd, struct file * filp, unsigned long arg)
> > >  {
> > > @@ -49,6 +50,11 @@ static int setfl(int fd, struct file * filp, unsig=
ned long arg)
> > >  		if (!inode_owner_or_capable(inode))
> > >  			return -EPERM;
> > > =20
> > > +	/* O_ENCODED can only be set by superuser */
> > > +	if ((arg & O_ENCODED) && !(filp->f_flags & O_ENCODED) &&
> > > +	    !capable(CAP_SYS_ADMIN))
> > > +		return -EPERM;
> >=20
> > I have a feeling the error should probably be an EACCES and not EPERM.
>=20
> Shrug, I wanted to make this consistent with O_NOATIME, which uses
> EPERM. EACCES seems more appropriate for lacking permissions for a
> particular path rather than for an operation, but the lines are blurry.

Fair enough, though I would also argue that O_NOATIME should've also
been EACCES (and there are plenty of examples throughout the kernel
where EPERM was used where EACCES makes more sense). ;)

> > > +
> > >  	/* required for strict SunOS emulation */
> > >  	if (O_NONBLOCK !=3D O_NDELAY)
> > >  	       if (arg & O_NDELAY)
> > > @@ -1031,7 +1037,7 @@ static int __init fcntl_init(void)
> > >  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
> > >  	 * is defined as O_NONBLOCK on some platforms and not on others.
> > >  	 */
> > > -	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> > > +	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=3D
> > >  		HWEIGHT32(
> > >  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> > >  			__FMODE_EXEC | __FMODE_NONOTIFY));
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 671c3c1a3425..ae86b125888a 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -2978,6 +2978,10 @@ static int may_open(const struct path *path, i=
nt acc_mode, int flag)
> > >  	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
> > >  		return -EPERM;
> > > =20
> > > +	/* O_ENCODED can only be set by superuser */
> > > +	if ((flag & O_ENCODED) && !capable(CAP_SYS_ADMIN))
> > > +		return -EPERM;
> >=20
> > I would suggest that this check be put into build_open_flags() rather
> > than putting it this late in open(). Also, same nit about the error
> > return as above.
>=20
> This is where we check permissions for O_NOATIME, shouldn't we keep all
> of those permission checks in the same place? build_open_flags() only
> checks for flag validity.

Right, but O_NOATIME can't be checked earlier -- you need to have
resolved the inode in order to do the permission check. O_ENCODED only
depends on the capability set, and IMHO checking it earlier seems
cleaner to me.

> > > +
> > >  	return 0;
> > >  }
> > > =20
> > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > index d019df946cb2..5fac02479639 100644
> > > --- a/include/linux/fcntl.h
> > > +++ b/include/linux/fcntl.h
> > > @@ -9,7 +9,7 @@
> > >  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRU=
NC | \
> > >  	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC |=
 \
> > >  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > > -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_ENCODED)
> > > =20
> > >  #ifndef force_o_largefile
> > >  #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> > > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-gene=
ric/fcntl.h
> > > index 9dc0bf0c5a6e..8c5cbd5942e3 100644
> > > --- a/include/uapi/asm-generic/fcntl.h
> > > +++ b/include/uapi/asm-generic/fcntl.h
> > > @@ -97,6 +97,10 @@
> > >  #define O_NDELAY	O_NONBLOCK
> > >  #endif
> > > =20
> > > +#ifndef O_ENCODED
> > > +#define O_ENCODED	040000000
> > > +#endif
> >=20
> > You should also define this for all of the architectures which don't use
> > the generic O_* flag values. On alpha, O_PATH is equal to the value you
> > picked (just be careful on sparc -- 0x4000000 is the next free bit, but
> > it's used by FMODE_NONOTIFY.)
>=20
> Good catch, I'll fix that. Thanks!

Oh, and please add a one-line comment in the sparc header to ensure
nobody accidentally breaks open() on sparc in the future.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--jizyjt34uq6bhptu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXboaBwAKCRCdlLljIbnQ
EvunAQDhTSB4TCQGN6okxxByez30rziSUb/RTyBpIZ9R/yCe5wD/VT/sRb4CLnmt
/WSJeuvkF/qTBffr2BFE4fv7KTTizgc=
=YDj3
-----END PGP SIGNATURE-----

--jizyjt34uq6bhptu--
