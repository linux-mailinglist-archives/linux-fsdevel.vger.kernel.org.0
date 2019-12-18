Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8E124F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 18:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfLRRcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 12:32:09 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:33640 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRRcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:32:09 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 47dMWp47D3zQl8w;
        Wed, 18 Dec 2019 18:32:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id lKAwrDRV6l4X; Wed, 18 Dec 2019 18:31:58 +0100 (CET)
Date:   Thu, 19 Dec 2019 04:31:45 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Aleksa Sarai' <asarai@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        "dev@opencontainers.org" <dev@opencontainers.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] openat2: switch to __attribute__((packed)) for open_how
Message-ID: <20191218173145.zodaxjctesjolinp@yavin.dot.cyphar.com>
References: <20191213222351.14071-1-cyphar@cyphar.com>
 <a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk>
 <20191215123443.jmfnrtgbscdwfohc@yavin.dot.cyphar.com>
 <b26ef210ec5b42009cf09b1015065768@AcuMS.aculab.com>
 <20191217064650.cd4bfb5d2koe6j7h@yavin.dot.cyphar.com>
 <6630d0573b5b40da8efc58fc20ac445e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmokspy2icgpi2pg"
Content-Disposition: inline
In-Reply-To: <6630d0573b5b40da8efc58fc20ac445e@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nmokspy2icgpi2pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-17, David Laight <David.Laight@ACULAB.COM> wrote:
> From Aleksa Sarai
> > Sent: 17 December 2019 06:47
> ...
> > > Just use u64 for all the fields.
> >=20
> > That is an option (and is the one that clone3 went with), but it's a bit
> > awkward because umode_t is a u16 -- and it would be a waste of 6 bytes
> > to store it as a u64. Arguably it could be extended but I personally
> > find that to be very unlikely (and lots of other syscalls would need be
> > updated).
>=20
> 6 bytes on interface structure will make almost no difference.
> There is no reason to save more than 16 bits anywhere else.

You have a point, and clone3's way of dealing with it does make life
easier. It also removes the need to care about explicit padding and
padding holes entirely.

> You could error values with high bits set.

Of course we'll give -EINVAL with invalid values, that's one of the
reasons openat2(2) exists after all. :P

> > I'm just going to move the padding to the end and change the error for
> > non-zero padding to -E2BIG.
>=20
> The padding had to be after the u16 field.

Right, I was suggesting to move the u16 field later in the struct too.
But after thinking about it some more, it doesn't help with
extensibility at all (a subsequent non-u16 extension will leave holes).
So I'm probably just going to go with either the -E2BIG patch or switch
to u64s.

> > > Use 'flags' bits to indicate whether the additional fields should be =
looked at.
> > > Error if a 'flags' bit requires a value that isn't passed in the stru=
cture.
> > >
> > > Then you can add an extra field and old source code recompiled with t=
he
> > > new headers will still work - because the 'junk' value isn't looked a=
t.
> >=20
> > This problem is already handled entirely by copy_struct_from_user().
> >=20
> > It is true that for some new fields it will be necessary to add a new
> > flag (such as passing fds -- where 0 is a valid value) but for most new
> > fields (especially pointer or flag fields) it will not be necessary
> > because the 0 value is equivalent to the old behaviour. It also allows
> > us to entirely avoid accepting junk from userspace.
>=20
> Only if userspace is guaranteed to memset the entire structure before
> making the call - rather than just fill in all the fields it knows
> about. If it doesn't use memset() then recompiling old code with new
> headers will pass garbage to the kernel. copy_struct_from_user()
> cannot solve that problem.

You don't need to /explicitly/ memset(), since

	struct open_how how =3D { .flags =3D O_RDWR, .resolve =3D RESOLVE_IN_ROOT =
};

or even

	struct open_how how =3D {}; /* or { 0 } if you prefer. */

will clear all of the unused fields.

But, I can add a NOTE to the man-page to clarify that this is how users
should fill their structs (or rather, that they should zero-fill them
somehow to avoid this problem).

While this might be a little annoying, I would argue that given the
openat2(2) man page explains how extensions work (in great detail) and
mentions several times that the structure may have new fields added to
it in the future -- programs which don't zero-fill the struct should be
simply seen as buggy. Note that those buggy programs *will still work*
on new kernels -- until you recompile them with new headers (because
they made an incorrect assumption about the structures they were using).

As an aside, the other downside from the uapi side is that we would
probably have to spend flag bits *that are shared with openat(2)* for
such extensions, so I'd like to avoid that as much as necessary.

> You'll never be able to guarantee that all code actually clears the
> entire structure - so at some point extending it will break recompilations
> of old code - annoying.

Only if they're explicitly doing something like

	struct open_how how;
	how.flags =3D O_RDWR;
	how.resolve =3D RESOLVE_IN_ROOT;
	memset(how.__padding, 0, sizeof(how.__padding));

As above, given the description of extensions in the man-page, I would
consider that style of struct initialisation to be eyebrow-raising at
best.

I'm sorry, but I'm simply against the idea of silently ignoring garbage
that userspace passes to the kernel -- even if it's tied to a flag. That
has proven to be an awful idea and in fact openat2(2) was written
precisely to fix this problem. To be honest, this reminds me of
(hypothetical) code like:

   int flags;
   flags |=3D O_PATH | O_CLOEXEC;
   open("foo", flags); /* yay, mystery fds! */

IMHO that shouldn't have ever worked, and the only way to stop userspace
=66rom passing garbage is to always reject it.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nmokspy2icgpi2pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXfpifgAKCRCdlLljIbnQ
Est0AP47j3JQq9ySzEvvRuIka0X8+XXJ3dLYcrDTnDjxITFEpAEA8fVcg4Srx8wz
g3pOu+chAYboEw16UO88cozjNw4Sqw8=
=VMrr
-----END PGP SIGNATURE-----

--nmokspy2icgpi2pg--
