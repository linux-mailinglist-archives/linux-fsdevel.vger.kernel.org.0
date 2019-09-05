Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3EAAED0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 01:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfIEXAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 19:00:46 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:63818 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfIEXAq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:00:46 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B3C5CA0128;
        Fri,  6 Sep 2019 01:00:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id wlUb_R4_fkS3; Fri,  6 Sep 2019 01:00:32 +0200 (CEST)
Date:   Fri, 6 Sep 2019 09:00:03 +1000
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
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Message-ID: <20190905230003.bek7vqdvruzi4ybx@yavin.dot.cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905180750.GQ1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p5c7e3ucgw67wkfa"
Content-Disposition: inline
In-Reply-To: <20190905180750.GQ1131@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--p5c7e3ucgw67wkfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-05, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
> > +/*
> > + * "memset(p, 0, size)" but for user space buffers. Caller must have a=
lready
> > + * checked access_ok(p, size).
> > + */
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
>=20
> That's called clear_user().

Already switched, I didn't know about clear_user() -- I assumed it
would've been called bzero_user() or memzero_user() and didn't find it
when looking.

> > +int copy_struct_to_user(void __user *dst, size_t usize,
> > +			const void *src, size_t ksize)
> > +{
> > +	size_t size =3D min(ksize, usize);
> > +	size_t rest =3D abs(ksize - usize);
> > +
> > +	if (unlikely(usize > PAGE_SIZE))
> > +		return -EFAULT;
>=20
> Why?
>=20
> > +	} else if (usize > ksize) {
> > +		if (__memzero_user(dst + size, rest))
> > +			return -EFAULT;
> > +	}
> > +	/* Copy the interoperable parts of the struct. */
> > +	if (__copy_to_user(dst, src, size))
> > +		return -EFAULT;
>=20
> Why not simply clear_user() and copy_to_user()?

I'm not sure I understand what you mean -- are you asking why we need to
do memchr_inv(src + size, 0, rest) earlier?

>=20
> > +int copy_struct_from_user(void *dst, size_t ksize,
> > +			  const void __user *src, size_t usize)
> > +{
> > +	size_t size =3D min(ksize, usize);
> > +	size_t rest =3D abs(ksize - usize);
>=20
> Cute, but... you would be just as well without that 'rest' thing.

I would argue it's harder to mess up using "rest" compared to getting
"ksize - usize" and "usize - ksize" mixed up (and it's a bit more
readable).

> > +
> > +	if (unlikely(usize > PAGE_SIZE))
> > +		return -EFAULT;
>=20
> Again, why?

As discussed in a sister thread, I will leave this in the callers
(though I would argue callers should always do some kind of sanity check
like this).

>=20
> > +	if (unlikely(!access_ok(src, usize)))
> > +		return -EFAULT;
>=20
> Why not simply copy_from_user() here?
>=20
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
>=20
> Frankly, that looks like a candidate for is_all_zeroes_user().
> With the loop like above serving as a dumb default.  And on
> badly alighed address it _will_ be dumb.  Probably too much
> so - something like
> 	if ((unsigned long)addr & 1) {
> 		u8 v;
> 		if (get_user(v, (__u8 __user *)addr))
> 			return -EFAULT;
> 		if (v)
> 			return -E2BIG;
> 		addr++;
> 	}
> 	if ((unsigned long)addr & 2) {
> 		u16 v;
> 		if (get_user(v, (__u16 __user *)addr))
> 			return -EFAULT;
> 		if (v)
> 			return -E2BIG;
> 		addr +=3D2;
> 	}
> 	if ((unsigned long)addr & 4) {
> 		u32 v;
> 		if (get_user(v, (__u32 __user *)addr))
> 			return -EFAULT;
> 		if (v)
> 			return -E2BIG;
> 	}
> 	<read the rest like you currently do>
> would be saner, and things like x86 could trivially add an
> asm variant - it's not hard.  Incidentally, memchr_inv() is
> an overkill in this case...

Why is memchr_inv() overkill?

But yes, breaking this out to an asm-generic is_all_zeroes_user()
wouldn't hurt -- and I'll put a cleaned-up version of the alignment
handling there too. Should I drop it in asm-generic/uaccess.h, or
somewhere else?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--p5c7e3ucgw67wkfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXGTcAAKCRCdlLljIbnQ
ErrcAP4jP69XXagvV6A6fZ62FZE+PxzGL1xMstNZGHLRdqnO0wD9FZDD6+QiCq2T
ReQjcKXuuyo3tBJtN7kYSwVg0ZE4dw8=
=qRhr
-----END PGP SIGNATURE-----

--p5c7e3ucgw67wkfa--
