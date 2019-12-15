Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02211F7BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2019 13:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfLOMfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Dec 2019 07:35:05 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:41034 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfLOMfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Dec 2019 07:35:04 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 47bP4P1TWdzQk8j;
        Sun, 15 Dec 2019 13:35:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id uAfNvh4N5EDU; Sun, 15 Dec 2019 13:34:56 +0100 (CET)
Date:   Sun, 15 Dec 2019 23:34:43 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] openat2: switch to __attribute__((packed)) for open_how
Message-ID: <20191215123443.jmfnrtgbscdwfohc@yavin.dot.cyphar.com>
References: <20191213222351.14071-1-cyphar@cyphar.com>
 <a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uvrtjxp4z3rdqsxa"
Content-Disposition: inline
In-Reply-To: <a328b91d-fd8f-4f27-b3c2-91a9c45f18c0@rasmusvillemoes.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--uvrtjxp4z3rdqsxa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-14, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> On 13/12/2019 23.23, Aleksa Sarai wrote:
> > The design of the original open_how struct layout was such that it
> > ensured that there would be no un-labelled (and thus potentially
> > non-zero) padding to avoid issues with struct expansion, as well as
> > providing a uniform representation on all architectures (to avoid
> > complications with OPEN_HOW_SIZE versioning).
> >=20
> > However, there were a few other desirable features which were not
> > fulfilled by the previous struct layout:
> >=20
> >  * Adding new features (other than new flags) should always result in
> >    the struct getting larger. However, by including a padding field, it
> >    was possible for new fields to be added without expanding the
> >    structure. This would somewhat complicate version-number based
> >    checking of feature support.
> >=20
> >  * A non-zero bit in __padding yielded -EINVAL when it should arguably
> >    have been -E2BIG (because the padding bits are effectively
> >    yet-to-be-used fields). However, the semantics are not entirely clear
> >    because userspace may expect -E2BIG to only signify that the
> >    structure is too big. It's much simpler to just provide the guarantee
> >    that new fields will always result in a struct size increase, and
> >    -E2BIG indicates you're using a field that's too recent for an older
> >    kernel.
>=20
> And when the first extension adds another u64 field, that padding has to
> be added back in and checked for being 0, at which point the padding is
> again yet-to-be-used fields.

Maybe I'm missing something, but what is the issue with

  struct open_how {
    u64 flags;
    u64 resolve;
    u16 mode;
	u64 next_extension;
  } __attribute__((packed));

It was my understanding that __aligned_u64 was used to ensure consistent
layouts, not that it was needed for safety against unaligned accesses.

> So what exactly is the problem with returning EINVAL now?

I would argue that -EINVAL was the wrong choice of return code from the
outset (and if we do keep the padding, I will send a patch to switch it
to -E2BIG -- see below). The purpose of -E2BIG for the newer
"extensible" syscalls is to differentiate between using an unsupported
extension field and an unsupported (or invalid) flag.

This will be useful for a few other extension ideas for these types of
syscalls (related to allowing userspace to more efficiently figure out
what flags are supported by the kernel without having to try each one
separately).

> >  * The padding wasted space needlessly, and would very likely not be
> >    used up entirely by future extensions for a long time (because it
> >    couldn't fit a u64).
>=20
> Who knows, it does fit a u32. And if the struct is to be 8-byte aligned
> (see below), it doesn't actually waste space.

Yeah, though giving it some more thought I think this might be a better
layout to avoid this problem:

  struct open_how {
    __aligned_u64 flags;
    __aligned_u64 resolve;
    __u16 mode;
	__u16 __padding[3]; /* must be zero */
  };

That way, we won't end up with a u16 which we never use (and we won't
have multiple __padding fields in the future).

> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index d886bdb585e4..0e070c7f568a 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -109,17 +109,16 @@
> >   * O_TMPFILE} are set.
> >   *
> >   * @flags: O_* flags.
> > - * @mode: O_CREAT/O_TMPFILE file mode.
> >   * @resolve: RESOLVE_* flags.
> > + * @mode: O_CREAT/O_TMPFILE file mode.
> >   */
> >  struct open_how {
> > -	__aligned_u64 flags;
> > +	__u64 flags;
> > +	__u64 resolve;
> >  	__u16 mode;
> > -	__u16 __padding[3]; /* must be zeroed */
> > -	__aligned_u64 resolve;
> > -};
> > +} __attribute__((packed));
>=20
> IIRC, gcc assumes such a struct has alignment 1, which means that it
> will generate horrible code to access it. So if you do this (and I don't
> think it's a good idea), I think you'd also want to include a
> __attribute__((__aligned__(8))) - or perhaps that can be accomplished by
> just keeping flags as an explicitly aligned member. But that will of
> course bump its sizeof() back to 24, at which point it seems better to
> just make the padding explicit.

Yeah, you're quite right -- I was aware that GCC generated "less than
great" code for aligned(1) structures, but wasn't sure whether it would
be seen as being a serious enough issue to NACK the change.

There is an additional problem -- unfortunately, having the struct be
__attribute__((aligned(8))) doesn't solve the Rust representation
problem because Rust can't represent a struct as both being
#[repr(packed)] and #[repr(align(n))]. Obviously the kernel doesn't
really care about Rust language restrictions, but given one of the main
users of how->resolve will be libpathrs, I'd prefer to not make my own
life any harder if possible. ;)

So, given all of the above, I suggest that instead I send something like
this instead:

diff --git a/fs/open.c b/fs/open.c
index 50a46501bcc9..6c97f52453fe 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -994,7 +994,7 @@ static inline int build_open_flags(const struct open_ho=
w *how,
        if (how->resolve & ~VALID_RESOLVE_FLAGS)
                return -EINVAL;
        if (memchr_inv(how->__padding, 0, sizeof(how->__padding)))
-               return -EINVAL;
+               return -E2BIG;
=20
        /* Deal with the mode. */
        if (WILL_CREATE(flags)) {
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index d886bdb585e4..c307640071c8 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -114,9 +114,9 @@
  */
 struct open_how {
        __aligned_u64 flags;
+       __aligned_u64 resolve;
        __u16 mode;
        __u16 __padding[3]; /* must be zeroed */
-       __aligned_u64 resolve;
 };
=20
 #define OPEN_HOW_SIZE_VER0     24 /* sizeof first published struct */
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing=
/selftests/openat2/openat2_test.c
index 0b64fedc008b..88e3614cbb3a 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -61,15 +61,15 @@ void test_openat2_struct(void)
                { .name =3D "normal struct (non-zero padding[0])",
                  .arg.inner.flags =3D O_RDONLY,
                  .arg.inner.__padding =3D {0xa0, 0x00, 0x00},
-                 .size =3D sizeof(struct open_how_ext), .err =3D -EINVAL },
+                 .size =3D sizeof(struct open_how_ext), .err =3D -E2BIG },
                { .name =3D "normal struct (non-zero padding[1])",
                  .arg.inner.flags =3D O_RDONLY,
                  .arg.inner.__padding =3D {0x00, 0x1a, 0x00},
-                 .size =3D sizeof(struct open_how_ext), .err =3D -EINVAL },
+                 .size =3D sizeof(struct open_how_ext), .err =3D -E2BIG },
                { .name =3D "normal struct (non-zero padding[2])",
                  .arg.inner.flags =3D O_RDONLY,
                  .arg.inner.__padding =3D {0x00, 0x00, 0xef},
-                 .size =3D sizeof(struct open_how_ext), .err =3D -EINVAL },
+                 .size =3D sizeof(struct open_how_ext), .err =3D -E2BIG },
=20
                /* TODO: Once expanded, check zero-padding. */

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--uvrtjxp4z3rdqsxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXfYoVwAKCRCdlLljIbnQ
EvN7AQDwo4/O9nZFcp0yersckNBPVj7BMZ9v79JCcI1aurRDfAEAwe9HeP+jGXMh
oYq9nIRg+RvL03iTvyD9Q/4gIXDqoA8=
=PES2
-----END PGP SIGNATURE-----

--uvrtjxp4z3rdqsxa--
