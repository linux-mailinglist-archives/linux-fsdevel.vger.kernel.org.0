Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BBB1224FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 07:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLQGrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 01:47:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:53408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLQGrI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:47:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 39B42AC53;
        Tue, 17 Dec 2019 06:47:05 +0000 (UTC)
Date:   Tue, 17 Dec 2019 17:46:50 +1100
From:   Aleksa Sarai <asarai@suse.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Aleksa Sarai' <cyphar@cyphar.com>,
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
Message-ID: <20191217064650.cd4bfb5d2koe6j7h@yavin.dot.cyphar.com>
References: <20191213222351.14071-1-cyphar@cyphar.com>
 <a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk>
 <20191215123443.jmfnrtgbscdwfohc@yavin.dot.cyphar.com>
 <b26ef210ec5b42009cf09b1015065768@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pxbkdztdbvo4kssd"
Content-Disposition: inline
In-Reply-To: <b26ef210ec5b42009cf09b1015065768@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--pxbkdztdbvo4kssd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-16, David Laight <David.Laight@ACULAB.COM> wrote:
> From:  Aleksa Sarai
> > Sent: 15 December 2019 12:35
> > On 2019-12-14, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > > On 13/12/2019 23.23, Aleksa Sarai wrote:
> > > > The design of the original open_how struct layout was such that it
> > > > ensured that there would be no un-labelled (and thus potentially
> > > > non-zero) padding to avoid issues with struct expansion, as well as
> > > > providing a uniform representation on all architectures (to avoid
> > > > complications with OPEN_HOW_SIZE versioning).
> > > >
> > > > However, there were a few other desirable features which were not
> > > > fulfilled by the previous struct layout:
> > > >
> > > >  * Adding new features (other than new flags) should always result =
in
> > > >    the struct getting larger. However, by including a padding field=
, it
> > > >    was possible for new fields to be added without expanding the
> > > >    structure. This would somewhat complicate version-number based
> > > >    checking of feature support.
> > > >
> > > >  * A non-zero bit in __padding yielded -EINVAL when it should argua=
bly
> > > >    have been -E2BIG (because the padding bits are effectively
> > > >    yet-to-be-used fields). However, the semantics are not entirely =
clear
> > > >    because userspace may expect -E2BIG to only signify that the
> > > >    structure is too big. It's much simpler to just provide the guar=
antee
> > > >    that new fields will always result in a struct size increase, and
> > > >    -E2BIG indicates you're using a field that's too recent for an o=
lder
> > > >    kernel.
> > >
> > > And when the first extension adds another u64 field, that padding has=
 to
> > > be added back in and checked for being 0, at which point the padding =
is
> > > again yet-to-be-used fields.
> >=20
> > Maybe I'm missing something, but what is the issue with
> >=20
> >   struct open_how {
> >     u64 flags;
> >     u64 resolve;
> >     u16 mode;
> > 	u64 next_extension;
> >   } __attribute__((packed));
>=20
> Compile anything that accesses it for (say) sparc and look at the object =
code.
> You really, really, REALLY, don't want to EVER use 'packed'.

Right, so it's related to the "garbage code" problem. As mentioned
above, I wasn't aware it was as bad as folks in this thread have
mentioned.

> Just use u64 for all the fields.

That is an option (and is the one that clone3 went with), but it's a bit
awkward because umode_t is a u16 -- and it would be a waste of 6 bytes
to store it as a u64. Arguably it could be extended but I personally
find that to be very unlikely (and lots of other syscalls would need be
updated).

I'm just going to move the padding to the end and change the error for
non-zero padding to -E2BIG.

> Use 'flags' bits to indicate whether the additional fields should be look=
ed at.
> Error if a 'flags' bit requires a value that isn't passed in the structur=
e.
>=20
> Then you can add an extra field and old source code recompiled with the
> new headers will still work - because the 'junk' value isn't looked at.

This problem is already handled entirely by copy_struct_from_user().

It is true that for some new fields it will be necessary to add a new
flag (such as passing fds -- where 0 is a valid value) but for most new
fields (especially pointer or flag fields) it will not be necessary
because the 0 value is equivalent to the old behaviour. It also allows
us to entirely avoid accepting junk from userspace.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--pxbkdztdbvo4kssd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl34edcACgkQnhiqJn3b
jbTUrQ/9EWPnCZlGMHHPgxyUQUwaE4kajhGnTsBLapKhdtsAfzkyJNqUPdSnipqB
oAAFeriC/RGN9ktSBHM60IBnwk3nv70W3SNm8/GUVaXGmWHrkBFkuhujOSn22awm
3jSxRKt+89I6NKoFBJPkxe9WQv6DecF8B9GWCn2sru2e/r105OHTe28EnPFqzBpQ
XZ/f7D7729GVAIITr5H6NQfvM8P/Sf/ne1gzDxf6cFTrF734aGNF+AhpTgSA2uxz
DVw1oQ6+HAcMdL6AixtdZgsN9Bm2nV9C4ndOEenV3rN6mG1Kn5ecz2RInuqKmmj9
/9ETSRo9ZZpl6WGpbfDMRB+/6vsSXAwHv06LO2YXEIeoHnPN7Y8/0deB4KNBoQ3S
jDzVHOKU2MToxsAkBPvyZ6UsKXJWLOT4QeiyOQeoExwzzu6K61pxtcHaXnKebheF
2hCF6h0NaAtBCcO3/MrN5PEkZliY+KcpM5BCsefzfM3cAEuqSEx1LqShw0G+3dV2
sGKHM0cfunvVas/8yawfs4qfEALCJR5Tnb2Kfveo/xd1qfT4+K54gPjkQqFvrkph
pV7c6P2lyJrNFraB5uDb5UYFWXrxTXgZ3ZUpDoI7MfLSEGCTT2nL9n7IXuoEfX4W
jj7ipubi5ZdNDgXiSACHJHYzwIVJBPHiNq4mzoQjNKNb8kj1VTQ=
=sK1O
-----END PGP SIGNATURE-----

--pxbkdztdbvo4kssd--
