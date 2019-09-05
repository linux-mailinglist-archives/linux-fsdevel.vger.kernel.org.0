Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 631C6AA98C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390906AbfIERBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 13:01:40 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61604 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733299AbfIERBk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:01:40 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A0FCBA01CE;
        Thu,  5 Sep 2019 19:01:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id l96lis2EinZ8; Thu,  5 Sep 2019 19:01:30 +0200 (CEST)
Date:   Fri, 6 Sep 2019 03:01:06 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20190905170106.7j4nmgwnvkcwn6md@yavin.dot.cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905073205.GY2332@hirez.programming.kicks-ass.net>
 <20190905092622.tlb6nn3uisssdfbu@yavin.dot.cyphar.com>
 <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kmvm5dxbzyhfjvqj"
Content-Disposition: inline
In-Reply-To: <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--kmvm5dxbzyhfjvqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-05, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Sep 05, 2019 at 07:26:22PM +1000, Aleksa Sarai wrote:
> > On 2019-09-05, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
> > > > +
> > > > +		while (rest > 0) {
> > > > +			size_t bufsize =3D min(rest, sizeof(buffer));
> > > > +
> > > > +			if (__copy_from_user(buffer, addr, bufsize))
> > > > +				return -EFAULT;
> > > > +			if (memchr_inv(buffer, 0, bufsize))
> > > > +				return -E2BIG;
> > > > +
> > > > +			addr +=3D bufsize;
> > > > +			rest -=3D bufsize;
> > > > +		}
> > >=20
> > > The perf implementation uses get_user(); but if that is too slow, sur=
ely
> > > we can do something with uaccess_try() here?
> >=20
> > Is there a non-x86-specific way to do that (unless I'm mistaken only x86
> > has uaccess_try() or the other *_try() wrappers)? The main "performance
> > improvement" (if you can even call it that) is that we use memchr_inv()
> > which finds non-matching characters more efficiently than just doing a
> > loop.
>=20
> Oh, you're right, that's x86 only :/

Though, I just had an idea -- am I wrong to think that the following
would work just as well (without the need for an intermediate buffer)?

   if (memchr_inv((const char __force *) src + size, 0, rest))
     return -E2BIG;

Or is this type of thing very much frowned upon? What if it was a
separate memchr_inv_user() instead -- I feel as though there's not a
strong argument for needing to use a buffer when we're single-passing
the __user buffer and doing a basic boolean check.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--kmvm5dxbzyhfjvqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXE/TgAKCRCdlLljIbnQ
Eo4lAP4vz7qxi6aZbZTeed0ZbnEtPkuMnCkFo0v18rHfgnM6xgD/bV/SICkzrufH
DwNHgRAu5z8daivqeybakfQqvQMhpA4=
=SteT
-----END PGP SIGNATURE-----

--kmvm5dxbzyhfjvqj--
