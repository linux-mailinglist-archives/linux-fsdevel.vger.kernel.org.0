Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876F3AAC87
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391559AbfIET4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:56:54 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:58904 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733174AbfIET4y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:56:54 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id DCACBA0D19;
        Thu,  5 Sep 2019 21:56:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id MUcBvZslYqK5; Thu,  5 Sep 2019 21:56:42 +0200 (CEST)
Date:   Fri, 6 Sep 2019 05:56:18 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
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
Message-ID: <20190905195618.pwzgvuzadkfpznfz@yavin.dot.cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905180750.GQ1131@ZenIV.linux.org.uk>
 <20190905182303.7f6bxpa2enbgcegv@wittgenstein>
 <20190905182801.GR1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lkob4nx2s4nikwgg"
Content-Disposition: inline
In-Reply-To: <20190905182801.GR1131@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lkob4nx2s4nikwgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-05, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Sep 05, 2019 at 08:23:03PM +0200, Christian Brauner wrote:
>=20
> > Because every caller of that function right now has that limit set
> > anyway iirc. So we can either remove it from here and place it back for
> > the individual callers or leave it in the helper.
> > Also, I'm really asking, why not? Is it unreasonable to have an upper
> > bound on the size (for a long time probably) or are you disagreeing with
> > PAGE_SIZE being used? PAGE_SIZE limit is currently used by sched, perf,
> > bpf, and clone3 and in a few other places.
>=20
> For a primitive that can be safely used with any size (OK, any within
> the usual 2Gb limit)?  Why push the random policy into the place where
> it doesn't belong?
>=20
> Seriously, what's the point?  If they want to have a large chunk of
> userland memory zeroed or checked for non-zeroes - why would that
> be a problem?

Thinking about it some more, there isn't really any r/w amplification --
so there isn't much to gain by passing giant structs. Though, if we are
going to permit 2GB buffers, isn't that also an argument to use
memchr_inv()? :P

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--lkob4nx2s4nikwgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXFoXwAKCRCdlLljIbnQ
EkH6AP4mTXfGXldo6DW9pN3b8QgoKfRKIsKKRirvrHzSGLXpkgEAgJQFw7jvGxM5
R7P96Ylo52dN3tmTa+41vZfPhMozHwA=
=OHll
-----END PGP SIGNATURE-----

--lkob4nx2s4nikwgg--
