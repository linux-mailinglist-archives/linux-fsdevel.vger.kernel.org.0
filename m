Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B003C2A341
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 May 2019 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfEYHDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 May 2019 03:03:55 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:22600 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEYHDy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 May 2019 03:03:54 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A0EB7A0141;
        Sat, 25 May 2019 09:03:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id gj9lETxU9zxQ; Sat, 25 May 2019 09:03:24 +0200 (CEST)
Date:   Sat, 25 May 2019 17:03:07 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
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
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] namei: resolveat(2) syscall
Message-ID: <20190525070307.bxbvjh2254sx2z6g@yavin>
References: <20190507164317.13562-1-cyphar@cyphar.com>
 <20190507164317.13562-6-cyphar@cyphar.com>
 <CAHk-=whbFMg4+HuWOBuHpvDNiAyowX2HUowv3+pt8vPWk5W-YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zfccyjj5qo4ral52"
Content-Disposition: inline
In-Reply-To: <CAHk-=whbFMg4+HuWOBuHpvDNiAyowX2HUowv3+pt8vPWk5W-YQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zfccyjj5qo4ral52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-24, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, May 7, 2019 at 9:44 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > The most obvious syscall to add support for the new LOOKUP_* scoping
> > flags would be openat(2) (along with the required execveat(2) change
> > included in this series). However, there are a few reasons to not do
> > this:
>=20
> So honestly, this last patch is what turns me off the whole thing.
>=20
> It goes from a nice new feature ("you can use O_NOSYMLINKS to disallow
> symlink traversal") to a special-case joke that isn't worth it any
> more. You get a useless path descrptor back from s special hacky
> system call, you don't actually get the useful data that you probably
> *want* the open to get you.
>=20
> Sure, you could eventually then use a *second* system call (openat
> with O_EMPTYPATH) to actually get something you can *use*, but at this
> point you've just wasted everybodys time and effort with a pointless
> second system call.
>=20
> So I really don't see the point of this whole thing. Why even bother.
> Nobody sane will ever use that odd two-systemcall model, and even if
> they did, it would be slower and inconvenient.
>=20
> The whole and only point of this seems to be the two lines that say
>=20
>        if (flags & ~VALID_RESOLVE_FLAGS)
>               return -EINVAL;
>=20
> but that adds absolutely zero value to anything.  The argument is that
> "we can't add it to existing flags, because old kernels won't honor
> it", but that's a completely BS argument, since the user has to have a
> fallback anyway for the old kernel case - so we literally could much
> more conveniently just expose it as a prctl() or something to _ask_
> the kernel what flags it honors.
>=20
> So to me, this whole argument means that "Oh, we'll make it really
> inconvenient to actually use this".
>=20
> If we want to introduce a new system call that allows cool new
> features, it should have *more* powerful semantics than the existing
> ones, not be clearly weaker and less useful.

You might not have seen the v8 of this set I sent a few days ago[1]. The
new set includes an example of a feature that is possible with
resolveat(2) but not with the current openat(O_PATH) interface. The
feature is that you can set RESOLVE_UPGRADE_NO{READ,WRITE} which then
blocks the re-opening of the file descriptor with those MAY_* modes.
(Though of course you might be against the entire idea of this feature
which allows for restricting the opening of magic-links.)

This can't be done with openat(2) without adding even more flags such as
O_PATH_UPGRADE_NOWRITE -- because O_RDONLY =3D 0, which means you can't
distinguish the "don't allow read or write" case (we could define 0x3
for that, but that feels a tad ugly). Not to mention that broken
userspace programs might already be setting O_PATH|O_RDWR.

So, while making it easier for userspace to be sure these flags are
working is one benefit, it's not the only reason. And outside arguments
for future features, several folks (some on-list, some on LWN) argued
that adding more "open" flags which aren't clearly related to the mode
the file is opened with makes not-much-more sense than a separate
syscall for it. Another (weaker) argument is that O_PATH should've been
separate from the beginning because of how unlike an ordinary fd it is.

Funnily enough, v8 does contain O_EMPTYPATH. However, this is just an
example of another /proc-less interface and we need it for O_PATH
descriptors even if you can do an full open in one shot with restricted
path resolution. Having an O_PATH can be useful on its own (LXC takes an
O_PATH of /dev/pts/ptmx inside the container and then re-opens it each
time a new console is required to avoid touching paths inside the
container).

But it would be neat to have a way for userspace to easily check what
flags the kernel honours, regardless of this patchset.

> So how about making the new system call be something that is a
> *superset* of "openat()" so that people can use that, and then if it
> fails, just fall back to openat(). But if it succeeds, it just
> succeeds, and you don't need to then do other system calls to actually
> make it useful.
>=20
> Make the new system call something people *want* to use because it's
> useful, not a crippled useless thing that has some special case use
> for some limited thing and just wastes system call space.

At the moment, I'm working on implementing userspace library wrappers
which use resolveat(2) for safe handling of an untrusted rootfs. I would
expect that most users of resolveat(2) would be using a library to
handle it -- because to do an "mkdir -p" you need to do a fair bit of
work for it to be safe unless we add LOOKUP_* flags to mkdirat(2) and
every other syscall. This is true whether or not openat(2) provides this
feature or if it's a separate syscall.

> Example *useful* system call attributes:
>=20
>  - make it like openat(), but have another argument with the "limit flags"

Sure, this would also work. I didn't know if anyone was open to the idea
of openat2(2). There is a follow-up question of how RESOLVE_UPGRADE_NO*
flags would be handled (they aren't obviously "lookup" flags so we'd
need to add more openat(2) flags to accommodate them) but I'm sure that
can be ironed out once you've taken a look at that patchset.

>  - maybe return more status of the resulting file. People very
> commonly do "open->fstat" just to get the size for mmap or to check
> some other detail of the file before use.

So something like

  resolveat(rootfd, "path/to/file", RESOLVE_IN_ROOT, &statbuf);

or

  openat2(rootfd, "path/to/file", O_PATH, RESOLVE_IN_ROOT, &statbuf);

? Is there a large amount of overhead or downside to the current
open->fstat way of doing things, or is this more of a "if we're going to
add more ways of opening we might as well add more useful things"?

> In other words, make the new system call *useful*. Not some castrated
> "not useful on its own" thing.
>
> So I still support the whole "let's make it easy to limit path lookup
> in sane ways", but this model of then limiting using the result sanely
> just makes me a sad panda.

I am glad that you agree with the general thrust, and it's just the
interface that is the hang-up.

[1]: https://marc.info/?l=3Dlinux-fsdevel&m=3D155835923516235&w=3D2

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--zfccyjj5qo4ral52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzo6KsACgkQSnvnv3De
m59dYQ/+IV3T5Z0NfRInVUcqfcaXAM4i55A3E9tRksohV9d2P8zMM1cdWoixttdJ
sk+5f+/mt+rSpD0ffdBS+wzILPWbZJWf6qm1PfJMvMQYcZeXERMIv/r6HvE+FgpX
vqZlDNRRgi6grg47edz7DAUOtIk9L/I22MVoosswSYI6YGB0Se2TlFNJy0E5IUSg
768Aed86aYdiWuFl9S1umGde9U/PZMKpM3vA0FJGVeOBvUD5PaUDz+I7YYcWCx8V
rwLJHbV2zJA287dfHAwcCYs8w1FL5zWvrCtzziCfsGWss3C5lWueszxeheGYKbAN
cSb9798OMst73fTJ0R3vI0RQZyycbg3j6Ykc9hSPgGOk3JC4MaWoiD209J2FFJPR
qw5vjra2m6scHQSC77eYIbKjLoIFGm6zGHLizJ1Fiwv34jN2EcJbVhhC7nntt3/h
2wp/SOrSpnilExmq54/3u6PDeyQMXS4dMXAjDI0CG4m8kJYzpPL3I05V6xxcUlue
vbtygj1qTGz4UpIrYQ0VueGmu3gpV4eRLyT/5g6KLxyy+Gug15xeiJEdRzv3hspp
7XcrbscqX7caKQVDVlqKM1rWi0x3jVAfw6GmhLn6D2wMWQe9+QMRUZT8qS1VgVPg
/tOO7pHT6bQElO6ib8JPsqZIwfR2eZyEJWT0lsvxfhE3WdC930Q=
=pGWn
-----END PGP SIGNATURE-----

--zfccyjj5qo4ral52--
