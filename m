Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E366B32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGLK6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 06:58:13 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:42972 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfGLK6N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:58:13 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 648AF5427E;
        Fri, 12 Jul 2019 12:58:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id la_RnxBryad0; Fri, 12 Jul 2019 12:57:56 +0200 (CEST)
Date:   Fri, 12 Jul 2019 20:57:45 +1000
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
Message-ID: <20190712105745.nruaftgeat6irhzr@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3oogwkmh2sysq6o"
Content-Disposition: inline
In-Reply-To: <20190712043341.GI17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--f3oogwkmh2sysq6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Jul 07, 2019 at 12:57:32AM +1000, Aleksa Sarai wrote:
> > @@ -1442,8 +1464,11 @@ static int follow_dotdot_rcu(struct nameidata *n=
d)
> >  	struct inode *inode =3D nd->inode;
> > =20
> >  	while (1) {
> > -		if (path_equal(&nd->path, &nd->root))
> > +		if (path_equal(&nd->path, &nd->root)) {
> > +			if (unlikely(nd->flags & LOOKUP_BENEATH))
> > +				return -EXDEV;
>=20
> > @@ -1468,6 +1493,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
> >  				return -ECHILD;
> >  			if (&mparent->mnt =3D=3D nd->path.mnt)
> >  				break;
> > +			if (unlikely(nd->flags & LOOKUP_XDEV))
> > +				return -EXDEV;
> >  			/* we know that mountpoint was pinned */
> >  			nd->path.dentry =3D mountpoint;
> >  			nd->path.mnt =3D &mparent->mnt;
> > @@ -1482,6 +1509,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
> >  			return -ECHILD;
> >  		if (!mounted)
> >  			break;
> > +		if (unlikely(nd->flags & LOOKUP_XDEV))
> > +			return -EXDEV;
>=20
> Are you sure these failure exits in follow_dotdot_rcu() won't give
> suprious hard errors?

I could switch to -ECHILD for the *_rcu() checks if you'd prefer that.
Though, I'd have (probably naively) thought that you'd have already
gotten -ECHILD from the seqlock checks if there was a race during ".."
handling.

> > +	if (unlikely(nd->flags & LOOKUP_BENEATH)) {
> > +		error =3D dirfd_path_init(nd);
> > +		if (unlikely(error))
> > +			return ERR_PTR(error);
> > +		nd->root =3D nd->path;
> > +		if (!(nd->flags & LOOKUP_RCU))
> > +			path_get(&nd->root);
> > +	}
> >  	if (*s =3D=3D '/') {
> >  		if (likely(!nd->root.mnt))
> >  			set_root(nd);
> > @@ -2350,9 +2400,11 @@ static const char *path_init(struct nameidata *n=
d, unsigned flags)
> >  			s =3D ERR_PTR(error);
> >  		return s;
> >  	}
> > -	error =3D dirfd_path_init(nd);
> > -	if (unlikely(error))
> > -		return ERR_PTR(error);
> > +	if (likely(!nd->path.mnt)) {
>=20
> Is that a weird way of saying "if we hadn't already called dirfd_path_ini=
t()"?

Yes. I did it to be more consistent with the other "have we got the
root" checks elsewhere. Is there another way you'd prefer I do it?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--f3oogwkmh2sysq6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXShnpgAKCRCdlLljIbnQ
EgLTAP4nuVmi0292tyCAkB4Di0UUtazb2EsZPgKq9s2vRoyuFAD/UKONDBSK3VN9
06Id1xrmV0JIYJSqOIdF2oJIncJ8ZwI=
=5hbR
-----END PGP SIGNATURE-----

--f3oogwkmh2sysq6o--
