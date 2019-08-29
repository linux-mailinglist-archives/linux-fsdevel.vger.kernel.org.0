Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE3A1B38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfH2NTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 09:19:41 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:52156 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfH2NTl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:19:41 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C76B2A10EE;
        Thu, 29 Aug 2019 15:19:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id YERUiiJJutp0; Thu, 29 Aug 2019 15:19:27 +0200 (CEST)
Date:   Thu, 29 Aug 2019 23:19:04 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Daniel Colascione <dancol@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
Message-ID: <20190829131904.bkbalbtqt6j3gwcp@yavin>
References: <20190820033406.29796-1-cyphar@cyphar.com>
 <20190820033406.29796-8-cyphar@cyphar.com>
 <CAKOZuesfxRBJe314rkTKXtjXdz6ki3uAUBYVbu5Q2rd3=ADphQ@mail.gmail.com>
 <20190829121527.u2uvdyeatme5cgkb@yavin>
 <899401fa-ff0a-2ce9-8826-09904efab2d2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="itirvnprc6jjrbl3"
Content-Disposition: inline
In-Reply-To: <899401fa-ff0a-2ce9-8826-09904efab2d2@rasmusvillemoes.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--itirvnprc6jjrbl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-29, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> On 29/08/2019 14.15, Aleksa Sarai wrote:
> > On 2019-08-24, Daniel Colascione <dancol@google.com> wrote:
>=20
> >> Why pad the structure when new functionality (perhaps accommodated via
> >> a larger structure) could be signaled by passing a new flag? Adding
> >> reserved fields to a structure with a size embedded in the ABI makes a
> >> lot of sense --- e.g., pthread_mutex_t can't grow. But this structure
> >> can grow, so the reservation seems needless to me.
> >=20
> > Quite a few folks have said that ->reserved is either unnecessary or
> > too big. I will be changing this, though I am not clear what the best
> > way of extending the structure is. If anyone has a strong opinion on
> > this (or an alternative to the ones listed below), please chime in. I
> > don't have any really strong attachment to this aspect of the API.
> >=20
> > There appear to be a few ways we can do it (that all have precedence
> > with other syscalls):
> >=20
> >  1. Use O_* flags to indicate extensions.
> >  2. A separate "version" field that is incremented when we change.
> >  3. Add a size_t argument to openat2(2).
> >  4. Reserve space (as in this patchset).
> >=20
> > (My personal preference would be (3), followed closely by (2).)
>=20
> 3, definitely, and instead of having to invent a new scheme for every
> new syscall, make that the default pattern by providing a helper

Sure (though hopefully I don't need to immediately go and refactor all
the existing size_t syscalls). I will be presenting about this patchset
at the containers microconference at LPC (in a few weeks), so I'll hold
of on any API-related rewrites until after that.

> int __copy_abi_struct(void *kernel, size_t ksize, const void __user
> *user, size_t usize)
> {
> 	size_t copy =3D min(ksize, usize);
>=20
> 	if (copy_from_user(kernel, user, copy))
> 		return -EFAULT;
>=20
> 	if (usize > ksize) {
> 		/* maybe a separate "return user_is_zero(user + ksize, usize -
> ksize);" helper */
> 		char c;
> 		user +=3D ksize;
> 		usize -=3D ksize;
> 		while (usize--) {
> 			if (get_user(c, user++))
> 				return -EFAULT;
> 			if (c)
> 				return -EINVAL;

This part would probably be better done with memchr_inv() and
copy_from_user() (and probably should put an upper limit on usize), but
I get what you mean.

> 		}
> 	} else if (ksize > usize) {
> 		memset(kernel + usize, 0, ksize - usize);
> 	}
> 	return 0;
> }
> #define copy_abi_struct(kernel, user, usize)	\
> 	__copy_abi_struct(kernel, sizeof(*kernel), user, usize)
>
> > Both (1) and (2) have the problem that the "struct version" is inside
> > the struct so we'd need to copy_from_user() twice. This isn't the end of
> > the world, it just feels a bit less clean than is ideal. (3) fixes that
> > problem, at the cost of making the API slightly more cumbersome to use
> > directly (though again glibc could wrap that away).
>=20
> I don't see how 3 is cumbersome to use directly. Userspace code does
> struct openat_of_the_day args =3D {.field1 =3D x, .field3 =3D y} and pass=
es
> &args, sizeof(args). What does glibc need to do beyond its usual munging
> of the userspace ABI registers to the syscall ABI registers?

I'd argue that

    ret =3D openat2(AT_FDCWD, "foo", &how, sizeof(how)); // (3)

is slightly less pretty than

    ret =3D openat2(AT_FDCWD, "foo", &how); // (1), (2), (4)

But it's not really that bad. Forget I said anything.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--itirvnprc6jjrbl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXWfQxQAKCRCdlLljIbnQ
EoMSAP9J0uy3xcD3flC3cANph5LKQ2g0JWnMb61ew5LWDORVogD/UGWciY+tdPiy
YNHs2UcBt9SEH1MNpEIgf2GN6RoyaQI=
=ne2z
-----END PGP SIGNATURE-----

--itirvnprc6jjrbl3--
