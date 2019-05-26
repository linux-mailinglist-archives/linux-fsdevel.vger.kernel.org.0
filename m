Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BB2A891
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 07:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfEZFrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 01:47:13 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38096 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfEZFrN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 01:47:13 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 13D18A01BD;
        Sun, 26 May 2019 07:47:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id G4iR3GBHN5nz; Sun, 26 May 2019 07:46:56 +0200 (CEST)
Date:   Sun, 26 May 2019 15:46:38 +1000
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
Message-ID: <20190526054638.jftyco7nviurn47h@yavin>
References: <20190507164317.13562-1-cyphar@cyphar.com>
 <20190507164317.13562-6-cyphar@cyphar.com>
 <CAHk-=whbFMg4+HuWOBuHpvDNiAyowX2HUowv3+pt8vPWk5W-YQ@mail.gmail.com>
 <20190525070307.bxbvjh2254sx2z6g@yavin>
 <CAHk-=wiKFi5wi33AmJ4XJmzQaCMHa21-Z-GD_OKPNz=js7R7ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pl4a3gpuunbanplp"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKFi5wi33AmJ4XJmzQaCMHa21-Z-GD_OKPNz=js7R7ig@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--pl4a3gpuunbanplp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-25, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> In fact, I think resolveat() as a model is fundamentally wrong for yet
> another reason: O_CREAT. If you want to _create_ a new file, and you
> want to still have the path resolution modifiers in place, the
> resolveat() model is broken, because it only gives you path resolution
> for the lookup, and then when you do openat(O_CREAT) for the final
> component, you now don't have any way to limit that last component.
>=20
> Sure,  you can probably effectively hack around it with resolveat() on
> everything but the last component, and then
> openat(O_CREAT|O_EXCL|O_NOFOLLOW) on the last component, because the
> O_EXCL|O_NOFOLLOW should mean that it won't do any of the unsafe
> things. And then (if you didn't actually want the O_EXCL), you handle
> the race between "somebody else got there first" by re-trying etc. So
> I suspect the O_CREAT thing could be worked around with extra
> complexity, but it's an example of how the O_PATH model really screws
> you over.
>=20
> End result: I really think resolveat() is broken. It absolutely
> *needs* to be a full-fledged "openat()" system call, just with added
> path resolution flags.

That's a very good point. I was starting to work on O_CREAT via
resolveat(2) and it definitely was much harder than most people would be
happy to deal with -- I'm not even sure that I handled all the cases.

I'll go for an openat2(2) then. Thinking about it some more -- since
it's a new syscall, I could actually implement the O_PATH link-mode as
being just the regular mode argument (since openat(2) ignores the mode
for non-O_CREAT anyway). The openat(2) wrapper might be more than
one-line as a result but it should avoid polluting the resolution flags
with mode flags (since openat(O_PATH) needs to have a g+rwx mode for
backwards-compatibility).

> >   openat2(rootfd, "path/to/file", O_PATH, RESOLVE_IN_ROOT, &statbuf);
>=20
> Note that for O_CREAT, it either needs the 'mode' parameter too, or
> the statbuf would need to be an in-out thing. I think the in-out model
> might be nice (the varargs model with a conditional 'mode' parameter
> is horrid, I think), but at some point it's just bike-shedding.
>=20
> Also, I'm not absolutely married to the statbuf, but I do think it
> might be a useful extension. A *lot* of users need the size of the
> file for subsequent mmap() calls (or for buffer management for
> read/write interface) or for things like just headers (ie
> "Content-length:" in html etc).
>=20
> I'm not sure people actually want a full 'struct stat', but people
> historically also do st_ino/st_dev for indexing into existing
> user-space caches (or to check permissions like that it's on the right
> filesystem, but the resolve flags kind of make that less of an issue).
> And st_mode to verify that it's a proper regular file etc etc.
>=20
> You can always just leave it as NULL if you don't care, there's almost
> no downside to adding it, and I do think that people who want a "walk
> pathname carefully" model almost always would want to also check the
> end result anyway.

Yeah, I agree -- most folks would want to double-check what they've
opened or O_PATH'd. Though I'm still not clear what is the best way of
doing the "stat" argument is -- especially given how much fun
architecture-specific shenanigans are in fs/stat.c (should I only use
cp_new_stat64 or have a separate 64-bit syscall).

> > Is there a large amount of overhead or downside to the current
> > open->fstat way of doing things, or is this more of a "if we're going to
> > add more ways of opening we might as well add more useful things"?
>=20
> Right now, system calls are sadly very expensive on a lot of hardware.
> We used to be very proud of the fact that Linux system calls were
> fast, but with meltdown and retpoline etc, we're back to "system calls
> can be several thousand cycles each, just in overhead, on commonly
> available hardware".
>=20
> Is "several thousand cycles" fatal? Not necessarily. But I think that
> if we do add a new system call, particularly a fancy one for special
> security-conscious models, we should look at what people need and use,
> and want. And performance should always be a concern.
>=20
> I realize that people who come at this from primarily just a security
> issue background may think that security is the primary goal. But no.
> Security always needs to realize that the _primary_ goal is to have
> people _use_ it. Without users, security is entirely pointless. And
> the users part is partly performance, but mostly "it's convenient".

Yup, I agree. I was hoping to shunt most of the convenience to userspace
to avoid ruffling feathers in VFS-land, but I'm more than happy to make
the kernel ABI more convenient.

> The whole "this is Linux-specific" is a big inconvenience point

I hope that other OSes will take our lead and have a similar interface
so that the particular inconvenience can go away eventually (this was
one of the arguments for resolveat(2) -- it's a clear "this is a new
idea" interface rather than mixing it with other O_* flags).

> Talking about securely opening things - another flag that we may want
> to avoid issues is a "don't open device nodes" flag. Sure, O_NONBLOCK
> plus checking the st_mode of the result is usually sufficient, but
> it's actually fairly easy to get that wrong. Things like /dev/tty and
> /dev/zero often need to be available for various reasons, and have
> been used to screw careless "open and read" users up that missed a
> check.

Sure, this could be added -- though I'm sure folks would have
disagreements over whether it should be a resolution flag on an open
flag.

> I also do wonder that if the only actual user-facing interface for the
> resolution flags is a new system call, should we not make the
> *default* value be "don't open anything odd at all".
>
> So instead of saying RESOLVE_XDEV for "don't cross mount points",
> maybe the flags should be the other way around, and say "yes, allow
> mount point crossings", and "yes, explicitly allow device node
> opening", and "yes, allow DOTDOT" etc.

This seems like a reasonable default, except for the cases of
RESOLVE_BENEATH and RESOLVE_IN_ROOT (that would make using AT_FDCWD more
cumbersome than necessary). But other than that, I'd be happy to invert
all the other flags.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--pl4a3gpuunbanplp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzqKDoACgkQSnvnv3De
m5+xjxAAke9SQAW+9C0as3a35Uq0klL3PZQdKgg0w5vK1bwWyJQ+4MmeRz6b2CFI
337arwIuSxJcLXLCTuRi15No6PTT/ctxZc0R7/b50zCgc9+iD6ovoI3z9EcnFkrL
GsDs9zcDJ1dBn4LR/fYnb89TSgCt2yrvIoX/iVV5daWqMPb6buLwXqpKI4P7PqNS
OH2kx5XlBF2mQKVeXifkYBqZTDCf1mTDdDfz6bIH+ZYx4Niu5SW/L31YVJsYLv9/
y3k7ZmECmSsSjhHM3qcme6dvZOOmqIvIW+RqMJ0a29x4w71uwQwRpa6/pyFZ3B0d
EpAwJNwOdxRuTI0Hje9Pm4eAzfjIrlh2RCSnj2CNdkpAIgU6mDJ53TnIyXktFGio
4S/5n60YxvQfBlhL9v6ZzHDpOX9ohguIBuPQedkV6nP2EpI29Ee0lQlTmXF/fU8m
niCzBaZqPeXxpCJOkq++exIAa6Xg76rn+xNTXP0pe5omEbXoYFiUfx5gUdHGSfDq
bebpl9NmeGY6AJcvNYfUGajKvbt+miCoSlu/S4DE7/t/W2RnCroq38l202HQKEll
wOzZlnVjgxF9ikOxWqd+RqX5pKMzlFQF6wZFKsPkv6yoF3mBR4eQq4cOBBMItZuL
sBUpp1J+qxaeaRfRBWcG/dF+cI6WaESgZOvoATEQucKpFuhGz54=
=0I//
-----END PGP SIGNATURE-----

--pl4a3gpuunbanplp--
