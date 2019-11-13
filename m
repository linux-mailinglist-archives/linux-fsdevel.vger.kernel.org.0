Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B72FA6CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 03:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKMCos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 21:44:48 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:12446 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKMCos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:44:48 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 47CTV33Jc9zQlBx;
        Wed, 13 Nov 2019 03:44:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id LsOzyR1eKTKd; Wed, 13 Nov 2019 03:44:38 +0100 (CET)
Date:   Wed, 13 Nov 2019 13:44:14 +1100
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
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 5/9] namei: LOOKUP_IN_ROOT: chroot-like scoped
 resolution
Message-ID: <20191113024414.wlmvtjstpnkxa36n@yavin.dot.cyphar.com>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191105090553.6350-6-cyphar@cyphar.com>
 <20191113020307.GB26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zcwix2zvi4el6ukc"
Content-Disposition: inline
In-Reply-To: <20191113020307.GB26530@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zcwix2zvi4el6ukc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Nov 05, 2019 at 08:05:49PM +1100, Aleksa Sarai wrote:
>=20
> > @@ -2277,12 +2277,20 @@ static const char *path_init(struct nameidata *=
nd, unsigned flags)
> > =20
> >  	nd->m_seq =3D read_seqbegin(&mount_lock);
> > =20
> > -	/* Figure out the starting path and root (if needed). */
> > -	if (*s =3D=3D '/') {
> > +	/* Absolute pathname -- fetch the root. */
> > +	if (flags & LOOKUP_IN_ROOT) {
> > +		/* With LOOKUP_IN_ROOT, act as a relative path. */
> > +		while (*s =3D=3D '/')
> > +			s++;
>=20
> Er...  Why bother skipping slashes?  I mean, not only link_path_walk()
> will skip them just fine, you are actually risking breakage in this:
>                 if (*s && unlikely(!d_can_lookup(dentry))) {
>                         fdput(f);
>                         return ERR_PTR(-ENOTDIR);
>                 }
> which is downstream from there with you patch, AFAICS.

I switched to stripping the slashes at your suggestion a few revisions
ago[1], and had (wrongly) assumed we needed to handle "/" somehow in
path_init(). But you're quite right about link_path_walk() -- and I'd be
more than happy to drop it.

[1]: https://lore.kernel.org/lkml/20190712125552.GL17978@ZenIV.linux.org.uk/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--zcwix2zvi4el6ukc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXctt+gAKCRCdlLljIbnQ
EtaOAP4wZ6FONr+jCigAii+B0S1x/aNqVoCXGa0s32/c+X1spQEAiLcI0bIEdqjF
tuAr6TYPTrpe63nhzokAO32LJ1rVrQM=
=G6qn
-----END PGP SIGNATURE-----

--zcwix2zvi4el6ukc--
