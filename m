Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3764FACFB7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2019 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfIHQYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 12:24:49 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:20600 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbfIHQYs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:24:48 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id F270BA10CE;
        Sun,  8 Sep 2019 18:24:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id RaAVojXx0viX; Sun,  8 Sep 2019 18:24:32 +0200 (CEST)
Date:   Mon, 9 Sep 2019 02:24:19 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
Message-ID: <20190908162419.yrzm2s7rflqgdxig@yavin>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-12-cyphar@cyphar.com>
 <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gzznbyzuni6ynbc5"
Content-Disposition: inline
In-Reply-To: <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gzznbyzuni6ynbc5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-07, Jeff Layton <jlayton@kernel.org> wrote:
> On Thu, 2019-09-05 at 06:19 +1000, Aleksa Sarai wrote:
> > + * @flags: O_* flags.
> > + * @mode: O_CREAT/O_TMPFILE file mode.
> > + * @upgrade_mask: UPGRADE_* flags (to restrict O_PATH re-opening).
> > + * @resolve: RESOLVE_* flags.
> > + */
> > +struct open_how {
> > +	__u32 flags;
> > +	union {
> > +		__u16 mode;
> > +		__u16 upgrade_mask;
> > +	};
> > +	__u16 resolve;
> > +};
> > +
> > +#define OPEN_HOW_SIZE_VER0	8 /* sizeof first published struct */
> > +
>=20
> Hmm, there is no version field. When you want to expand this in the
> future, what is the plan? Add a new flag to indicate that it's some
> length?

The "version number" is the size of the struct. Any extensions we make
are appended to the struct (openat2 now takes a size_t argument), and
the new copy_struct_{to,from}_user() helpers handle all of the
permutations of {old,new} kernel and {old,new} user space.

This is how clone3(), sched_[gs]etattr() and perf_event_open() all
operate (all of the sigset syscalls operate similarly but don't
gracefully handle different kernel vintages -- you just get -EINVAL).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--gzznbyzuni6ynbc5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXUrMAAKCRCdlLljIbnQ
EgC+AQCVKXVqUiPLaSjLjt+ByWrSsopM/OM3NwCHHZ5oD+CB1gD/cSuQohVmXskg
v8dQLpd9K1QW//8GG3Aa/FRHhqPAfAU=
=G4Hw
-----END PGP SIGNATURE-----

--gzznbyzuni6ynbc5--
