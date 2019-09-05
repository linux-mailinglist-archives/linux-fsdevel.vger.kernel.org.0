Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602E7A9ED0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 11:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfIEJvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 05:51:01 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:14964 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbfIEJvA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:51:00 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B12A0A1D27;
        Thu,  5 Sep 2019 11:50:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id H6fKP-o1gXOv; Thu,  5 Sep 2019 11:50:49 +0200 (CEST)
Date:   Thu, 5 Sep 2019 19:50:26 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
Message-ID: <20190905095026.gjemg2gqua2vufxb@yavin.dot.cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <57ba3752-c4a6-d2a4-1a4d-a0e13bccd473@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="npvprxbrvxn3jdkc"
Content-Disposition: inline
In-Reply-To: <57ba3752-c4a6-d2a4-1a4d-a0e13bccd473@rasmusvillemoes.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--npvprxbrvxn3jdkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-05, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> On 04/09/2019 22.19, Aleksa Sarai wrote:
> > A common pattern for syscall extensions is increasing the size of a
> > struct passed from userspace, such that the zero-value of the new fields
> > result in the old kernel behaviour (allowing for a mix of userspace and
> > kernel vintages to operate on one another in most cases). This is done
> > in both directions -- hence two helpers -- though it's more common to
> > have to copy user space structs into kernel space.
> >=20
> > Previously there was no common lib/ function that implemented
> > the necessary extension-checking semantics (and different syscalls
> > implemented them slightly differently or incompletely[1]). A future
> > patch replaces all of the common uses of this pattern to use the new
> > copy_struct_{to,from}_user() helpers.
> >=20
> > [1]: For instance {sched_setattr,perf_event_open,clone3}(2) all do do
> >      similar checks to copy_struct_from_user() while rt_sigprocmask(2)
> >      always rejects differently-sized struct arguments.
> >=20
> > Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> > diff --git a/lib/struct_user.c b/lib/struct_user.c
> > new file mode 100644
> > index 000000000000..7301ab1bbe98
> > --- /dev/null
> > +++ b/lib/struct_user.c
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2019 SUSE LLC
> > + * Copyright (C) 2019 Aleksa Sarai <cyphar@cyphar.com>
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/export.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/kernel.h>
> > +#include <linux/string.h>
> > +
> > +#define BUFFER_SIZE 64
> > +
> > +/*
> > + * "memset(p, 0, size)" but for user space buffers. Caller must have a=
lready
> > + * checked access_ok(p, size).
> > + */
>=20
> Isn't this __clear_user() exactly (perhaps except for the return value)?
> Perhaps not every arch has that?

I didn't know about clear_user() -- I will switch to it.

> > +static int __memzero_user(void __user *p, size_t s)
> > +{
> > +	const char zeros[BUFFER_SIZE] =3D {};
> > +	while (s > 0) {
> > +		size_t n =3D min(s, sizeof(zeros));
> > +
> > +		if (__copy_to_user(p, zeros, n))
> > +			return -EFAULT;
> > +
> > +		p +=3D n;
> > +		s -=3D n;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/**
> > + * copy_struct_to_user: copy a struct to user space
> > + * @dst:   Destination address, in user space.
> > + * @usize: Size of @dst struct.
> > + * @src:   Source address, in kernel space.
> > + * @ksize: Size of @src struct.
> > + *
> > + * Returns (in all cases, some data may have been copied):
> > + *  * -EFBIG:  (@usize < @ksize) and there are non-zero trailing bytes=
 in @src.
> > + *  * -EFAULT: access to user space failed.
> > + */
> > +int copy_struct_to_user(void __user *dst, size_t usize,
> > +			const void *src, size_t ksize)
> > +{
> > +	size_t size =3D min(ksize, usize);
> > +	size_t rest =3D abs(ksize - usize);
>=20
> Eh, I'd avoid abs() here due to the funkiness of the implicit type
> conversions - ksize-usize has type size_t, then that's coerced to an int
> (or a long maybe?), the abs is applied which return an int/long (or
> unsigned versions?). Something like "rest =3D max(ksize, usize) - size;"
> is more obviously correct and doesn't fall into any
> narrowing/widening/sign extending traps.

Yeah, I originally used "max(ksize, usize) - size" for that reason but
was worried it looked too funky (and some quick tests showed that abs()
gives the right results in most cases -- though I just realised it would
probably not give the right results around SIZE_MAX). I'll switch back.

> > +	if (unlikely(usize > PAGE_SIZE))
> > +		return -EFAULT;
>=20
> Please don't. That is a restriction on all future extensions - once a
> kernel is shipped with a syscall using this helper with that arbitrary
> restriction in place, that syscall is forever prevented from extending
> its arg struct beyond PAGE_SIZE (which is arch-dependent anyway). Sure,
> it's hard to imagine, but who'd have thought 32 O_* or CLONE_* bits
> weren't enough for everybody?
>
> This is only for future compatibility, and if someone runs an app
> compiled against 7.3 headers on a 5.4 kernel, they probably don't care
> about performance, but they would like their app to run.

I'm not sure I agree that the limit is in place *forever* -- it's
generally not a break in compatibility to convert an error into a
success (though, there are counterexamples such as mknod(2) -- but that
was a very specific case).

You're right that it would mean that some very new code won't run on
very ancient kernels (assuming we ever pass around structs that
massive), but there should be a reasonable trade-off here IMHO.

If we allow very large sizes, a program could probably DoS the kernel by
allocating a moderately-large block of memory and then spawning a bunch
of threads that all cause the kernel to re-check that the same 1GB block
of memory is zeroed. I haven't tried, but it seems like it's best to
avoid the possibility altogether.

> > +	}
> > +	/* Copy the interoperable parts of the struct. */
> > +	if (__copy_to_user(dst, src, size))
> > +		return -EFAULT;
>=20
> I think I understand why you put this last instead of handling the
> buffer in the "natural" order. However,
> I'm wondering whether we should actually do this copy before checking
> that the extra kernel bytes are 0 - the user will still be told that
> there was some extra information via the -EFBIG/-E2BIG return, but maybe
> in some cases the part he understands is good enough. But I also guess
> we have to look to existing users to see whether that would prevent them
> from being converted to using this helper.
>=20
> linux-api folks, WDYT?

Regarding the order, I just copied what sched and perf already do. I
wouldn't mind doing it the other way around -- though I am a little
cautious about implicitly making guarantees like that. The syscall that
uses copy_struct_to_user() might not want to make that guarantee (it
might not make sense for them), and there are some -E2BIG returns that
won't result in data being copied (usize > PAGE_SIZE).

As for feedback, this is syscall-dependent at the moment. The sched and
perf users explicitly return the size of the kernel structure (by
overwriting uattr->size if -E2BIG is returned) for copies in either
direction. So users arguably already have some kind of feedback about
size issues. clone3() on the other hand doesn't do that (though it
doesn't copy anything to user-space so this isn't relevant to this
particular question).

Effectively, I'd like to see someone argue that this is something that
they would personally want (before we do it).

> > +	return 0;
>=20
> Maybe more useful to "return size;", some users might want to know/pass
> on how much was actually copied.

Even though it is "just" min(ksize, usize), I don't see any harm in
returning it. Will do.

> > +}
> > +EXPORT_SYMBOL(copy_struct_to_user);
>=20
> Can't we wait with this until a modular user shows up? The primary users
> are syscalls, which can't be modular AFAIK.

Yeah, I'll drop it. You could use them for ioctl()s but we can always
add EXPORT_SYMBOL() later.

> > +/**
> > + * copy_struct_from_user: copy a struct from user space
> > + * @dst:   Destination address, in kernel space. This buffer must be @=
ksize
> > + *         bytes long.
> > + * @ksize: Size of @dst struct.
> > + * @src:   Source address, in user space.
> > + * @usize: (Alleged) size of @src struct.
> > + *
> > + * Copies a struct from user space to kernel space, in a way that guar=
antees
> > + * backwards-compatibility for struct syscall arguments (as long as fu=
ture
> > + * struct extensions are made such that all new fields are *appended* =
to the
> > + * old struct, and zeroed-out new fields have the same meaning as the =
old
> > + * struct).
> > + *
> > + * @ksize is just sizeof(*dst), and @usize should've been passed by us=
er space.
> > + * The recommended usage is something like the following:
> > + *
> > + *   SYSCALL_DEFINE2(foobar, const struct foo __user *, uarg, size_t, =
usize)
> > + *   {
> > + *      int err;
> > + *      struct foo karg =3D {};
> > + *
> > + *      err =3D copy_struct_from_user(&karg, sizeof(karg), uarg, size);
> > + *      if (err)
> > + *        return err;
> > + *
> > + *      // ...
> > + *   }
> > + *
> > + * There are three cases to consider:
> > + *  * If @usize =3D=3D @ksize, then it's copied verbatim.
> > + *  * If @usize < @ksize, then the user space has passed an old struct=
 to a
> > + *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @=
usize)
> > + *    are to be zero-filled.
> > + *  * If @usize > @ksize, then the user space has passed a new struct =
to an
> > + *    older kernel. The trailing bytes unknown to the kernel (@usize -=
 @ksize)
> > + *    are checked to ensure they are zeroed, otherwise -E2BIG is retur=
ned.
> > + *
> > + * Returns (in all cases, some data may have been copied):
> > + *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes=
 in @src.
> > + *  * -E2BIG:  @usize is "too big" (at time of writing, >PAGE_SIZE).
> > + *  * -EFAULT: access to user space failed.
> > + */
> > +int copy_struct_from_user(void *dst, size_t ksize,
> > +			  const void __user *src, size_t usize)
> > +{
> > +	size_t size =3D min(ksize, usize);
> > +	size_t rest =3D abs(ksize - usize);
>=20
> As above.
>=20
> > +	if (unlikely(usize > PAGE_SIZE))
> > +		return -EFAULT;
>=20
> As above.
>=20
> > +	if (unlikely(!access_ok(src, usize)))
> > +		return -EFAULT;
> > +
> > +	/* Deal with trailing bytes. */
> > +	if (usize < ksize)
> > +		memset(dst + size, 0, rest);
> > +	else if (usize > ksize) {
> > +		const void __user *addr =3D src + size;
> > +		char buffer[BUFFER_SIZE] =3D {};
> > +
> > +		while (rest > 0) {
> > +			size_t bufsize =3D min(rest, sizeof(buffer));
> > +
> > +			if (__copy_from_user(buffer, addr, bufsize))
> > +				return -EFAULT;
> > +			if (memchr_inv(buffer, 0, bufsize))
> > +				return -E2BIG;
> > +
> > +			addr +=3D bufsize;
> > +			rest -=3D bufsize;
> > +		}
>=20
> I'd create a __user_is_zero() helper for this - that way the two
> branches in the two helpers become nicely symmetric, each just calling a
> single helper that deals appropriately with the tail. And we can discuss
> how to implement __user_is_zero() in another bikeshed.

Will do.

>=20
> > +	}
> > +	/* Copy the interoperable parts of the struct. */
> > +	if (__copy_from_user(dst, src, size))
> > +		return -EFAULT;
>=20
> If you do move up the __copy_to_user(), please move this as well - on
> the kernel side, we certainly don't care that we copied some bytes to a
> local buffer which we then ignore because the user had a non-zero tail.
> But if __copy_to_user() is kept last in copy_struct_to_user(), this
> should stay for symmetry.

I will keep that in mind.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--npvprxbrvxn3jdkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXDaXgAKCRCdlLljIbnQ
Emf2AQDodc/azw4b6cwwZDqnqxOM8t8DCzDdAdvqvdxibvlNZQEA0FAaEvh21B5s
gAEhZHoS+52ad2ZdUjMFOGVxov8Odg8=
=BfyA
-----END PGP SIGNATURE-----

--npvprxbrvxn3jdkc--
