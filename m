Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF4C67E90
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGNKba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 06:31:30 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:28908 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbfGNKba (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 06:31:30 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 9FD654DF84;
        Sun, 14 Jul 2019 12:31:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id JHLEpiHFM8dg; Sun, 14 Jul 2019 12:31:19 +0200 (CEST)
Date:   Sun, 14 Jul 2019 20:31:04 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190714100825.umyql5op6cxhmpqa@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
 <20190712132553.GN17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kaevdj3q3yxfna5u"
Content-Disposition: inline
In-Reply-To: <20190712132553.GN17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--kaevdj3q3yxfna5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jul 12, 2019 at 01:55:52PM +0100, Al Viro wrote:
> > On Fri, Jul 12, 2019 at 01:39:24PM +0100, Al Viro wrote:
> > > On Fri, Jul 12, 2019 at 08:57:45PM +1000, Aleksa Sarai wrote:
> > >=20
> > > > > > @@ -2350,9 +2400,11 @@ static const char *path_init(struct name=
idata *nd, unsigned flags)
> > > > > >  			s =3D ERR_PTR(error);
> > > > > >  		return s;
> > > > > >  	}
> > > > > > -	error =3D dirfd_path_init(nd);
> > > > > > -	if (unlikely(error))
> > > > > > -		return ERR_PTR(error);
> > > > > > +	if (likely(!nd->path.mnt)) {
> > > > >=20
> > > > > Is that a weird way of saying "if we hadn't already called dirfd_=
path_init()"?
> > > >=20
> > > > Yes. I did it to be more consistent with the other "have we got the
> > > > root" checks elsewhere. Is there another way you'd prefer I do it?
> > >=20
> > > "Have we got the root" checks are inevitable evil; here you are makin=
g the
> > > control flow in a single function hard to follow.
> > >=20
> > > I *think* what you are doing is
> > > 	absolute pathname, no LOOKUP_BENEATH:
> > > 		set_root
> > > 		error =3D nd_jump_root(nd)
> > > 	else
> > > 		error =3D dirfd_path_init(nd)
> > > 	return unlikely(error) ? ERR_PTR(error) : s;
> > > which should be a lot easier to follow (not to mention shorter), but =
I might
> > > be missing something in all of that.
> >=20
> > PS: if that's what's going on, I would be tempted to turn the entire
> > path_init() part into this:
> > 	if (flags & LOOKUP_BENEATH)
> > 		while (*s =3D=3D '/')
> > 			s++;
> > in the very beginning (plus the handling of nd_jump_root() prototype
> > change, but that belongs with nd_jump_root() change itself, obviously).
> > Again, I might be missing something here...
>=20
> Argh... I am, at that - you have setting path->root (and grabbing it)
> in LOOKUP_BENEATH cases and you do it after dirfd_path_init().  So
> how about
> 	if (flags & LOOKUP_BENEATH)
> 		while (*s =3D=3D '/')
> 			s++;

I can do this for LOOKUP_IN_ROOT, but currently the semantics for
LOOKUP_BENEATH is that absolute paths will return -EXDEV
indiscriminately (nd_jump_root() errors out with LOOKUP_BENEATH). To be
honest, the check could actually just be:

  if (flags & LOOKUP_BENEATH)
    if (*s =3D=3D '/')
	  return ERR_PTR(-EXDEV);

(Though we'd still need -EXDEV in nd_jump_root() for obvious reasons.)

The logic being that an absolute path means that the resolution starts
out without being "beneath" the starting point -- thus violating the
contract of LOOKUP_BENEATH. And since the "handle absolute paths like
they're scoped to the root" is only implemented for LOOKUP_IN_ROOT, I'd
think it's a bit odd to have LOOKUP_BENEATH do it too for absolute
paths.

I'll be honest, this patchset is more confusing to both of us because of
LOOKUP_BENEATH -- I've only kept it since it was part of the original
patchset (O_BENEATH). Personally I think more people will be far more
interested in LOOKUP_IN_ROOT. Does anyone mind if I drop the
LOOKUP_BENEATH parts of this series, and only keep LOOKUP_NO_* and
LOOKUP_IN_ROOT?

I make a change as you outlined for LOOKUP_IN_ROOT, though.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--kaevdj3q3yxfna5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXSsEZQAKCRCdlLljIbnQ
EnUcAP0UIrWhoFUdmcGKVnbHflUGk+2uDxtG83hk6KmhY14aGgD/bIuyNZSByUo2
62tn/pqpuWfU42XocRvuCvKllOoWpgc=
=3x3j
-----END PGP SIGNATURE-----

--kaevdj3q3yxfna5u--
