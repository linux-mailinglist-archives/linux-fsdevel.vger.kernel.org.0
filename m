Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB3FAB3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 08:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfKMHsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 02:48:35 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:42266 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfKMHsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:48:35 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 47CcDY3vdYzQlBb;
        Wed, 13 Nov 2019 08:48:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 3hMGDl1msr0T; Wed, 13 Nov 2019 08:48:23 +0100 (CET)
Date:   Wed, 13 Nov 2019 18:47:57 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 4/9] namei: LOOKUP_BENEATH: O_BENEATH-like scoped
 resolution
Message-ID: <20191113074757.5b4u5vlyx2u6pbn6@yavin.dot.cyphar.com>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-5-cyphar@cyphar.com>
 <20191113015534.GA26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="odomi6wtik4yoblv"
Content-Disposition: inline
In-Reply-To: <20191113015534.GA26530@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--odomi6wtik4yoblv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> Minor nit here - I'd split "move the conditional call of set_root()
> into nd_jump_root()" into a separate patch before that one.  Makes
> for fewer distractions in this one.  I'd probably fold "and be
> ready for errors other than -ECHILD" into the same preliminary
> patch.

Will do.

> > +			/* Not currently safe for scoped-lookups. */
> > +			if (unlikely(nd->flags & LOOKUP_IS_SCOPED))
> > +				return ERR_PTR(-EXDEV);
>=20
> Also a candidate for doing in nd_jump_link()...
>=20
> > @@ -1373,8 +1403,11 @@ static int follow_dotdot_rcu(struct nameidata *n=
d)
> >  	struct inode *inode =3D nd->inode;
> > =20
> >  	while (1) {
> > -		if (path_equal(&nd->path, &nd->root))
> > +		if (path_equal(&nd->path, &nd->root)) {
> > +			if (unlikely(nd->flags & LOOKUP_BENEATH))
> > +				return -EXDEV;
>=20
> Umm...  Are you sure it's not -ECHILD?

It wouldn't hurt to be -ECHILD -- though it's not clear to me how likely
a success would be in REF-walk if the parent components didn't already
trigger an unlazy_walk() in RCU-walk.

I guess that also means LOOKUP_NO_XDEV should trigger -ECHILD in
follow_dotdot_rcu()?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--odomi6wtik4yoblv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXcu1KgAKCRCdlLljIbnQ
EpYSAQDaNIB4LkhLlbFgkuRPiavU6vZ03HuSIHKseqaD6uMARwD+OcGzTDahyjJ6
YeuKal+s33ETzSjupl7K2mKfYQpA2Q0=
=nyQ8
-----END PGP SIGNATURE-----

--odomi6wtik4yoblv--
