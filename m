Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 630FCAA15D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfIEL14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 07:27:56 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61762 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfIEL1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:27:55 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 80455A162A;
        Thu,  5 Sep 2019 13:27:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id bvZM-eYrS-l9; Thu,  5 Sep 2019 13:27:44 +0200 (CEST)
Date:   Thu, 5 Sep 2019 21:27:18 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Message-ID: <20190905112718.ojg3znly6x3m4mjq@yavin.dot.cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905110915.4vvhicg4ldmpi5u6@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nkbo7v76ghbobp4m"
Content-Disposition: inline
In-Reply-To: <20190905110915.4vvhicg4ldmpi5u6@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nkbo7v76ghbobp4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-05, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
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
>=20
> I would probably split this out into a separate patchset. It can very
> well go in before openat2(). Thoughts?

Yeah, I'll split this and the related patches out -- though I will admit
I'm not sure how you're supposed to deal with multiple independent
patchsets that depend on each other. How will folks reviewing openat2(2)
know to include the lib/struct_user.c changes?

Also, whose tree should it go through?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nkbo7v76ghbobp4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXDxEwAKCRCdlLljIbnQ
EqovAQD8WBncNVUTEL0Y3xtDhqYMDFHga+X5xWtEwl2PAh4uVQEAhuzdaAU+gBqt
VqtP9IF4PFfoqMmGbekI1BKCWI4gmgo=
=UsGw
-----END PGP SIGNATURE-----

--nkbo7v76ghbobp4m--
