Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD61263D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 14:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfLSNpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 08:45:47 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:34272 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:45:47 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 47dtS81SC9zQlCH;
        Thu, 19 Dec 2019 14:45:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id e7q2fm3sHcgL; Thu, 19 Dec 2019 14:45:38 +0100 (CET)
Date:   Fri, 20 Dec 2019 00:45:25 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] uapi: split openat2(2) definitions from fcntl.h
Message-ID: <20191219134525.mgzmjbsp4wo5b2bw@yavin.dot.cyphar.com>
References: <20191219105533.12508-1-cyphar@cyphar.com>
 <20191219105533.12508-2-cyphar@cyphar.com>
 <87a77oy3oe.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qjttenzbgeo3oe2h"
Content-Disposition: inline
In-Reply-To: <87a77oy3oe.fsf@oldenburg2.str.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qjttenzbgeo3oe2h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-19, Florian Weimer <fweimer@redhat.com> wrote:
> * Aleksa Sarai:
>=20
> > diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> > new file mode 100644
> > index 000000000000..19ef775e8e5e
> > --- /dev/null
> > +++ b/include/uapi/linux/openat2.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_OPENAT2_H
> > +#define _UAPI_LINUX_OPENAT2_H
>=20
> I think you should include the relevant header for __align_u64
> etc. here.

Right -- no idea why I forgot to include them.

> [=E2=80=A6]
> > + * Arguments for how openat2(2) should open the target path. If @resol=
ve is
> > + * zero, then openat2(2) operates very similarly to openat(2).
> > + *
> > + * However, unlike openat(2), unknown bits in @flags result in -EINVAL=
 rather
> > + * than being silently ignored. @mode must be zero unless one of {O_CR=
EAT,
> > + * O_TMPFILE} are set.
> > + *
> > + * @flags: O_* flags.
> > + * @mode: O_CREAT/O_TMPFILE file mode.
> > + * @resolve: RESOLVE_* flags.
> > + */
> > +struct open_how {
> > +	__aligned_u64 flags;
> > +	__u16 mode;
> > +	__u16 __padding[3]; /* must be zeroed */
> > +	__aligned_u64 resolve;
> > +};
> > +
> > +#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> > +#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
>=20
> Are these really useful for the UAPI header?  Is there a situation where
> OPEN_HOW_SIZE_LATEST would be different from sizeof (struct open_how)?
>=20
> The header is not compatible with the assembler anyway, so the numeric
> constant does not seem useful.

OPEN_HOW_SIZE_VER0 could conceivably be useful (in the future we may do
size-based checks) but maybe we can just expose it if someone actually
ends up needing it.

I will move them to the in-kernel header (we use them for BUILD_BUG_ONs
to make sure that the sizes are correct).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qjttenzbgeo3oe2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXft+8gAKCRCdlLljIbnQ
Ekc2AQClb2qbHajijnt60Pk4O2cvxed5KckYXs6dwwg58HB1oQEAjQvmRi/60gTm
4X83tviudRi/oFgl8Az74op013vZHAY=
=5/Pu
-----END PGP SIGNATURE-----

--qjttenzbgeo3oe2h--
