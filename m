Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61B15452
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 21:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfEFTSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 15:18:10 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:26234 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEFTSK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 15:18:10 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 8683DA1093;
        Mon,  6 May 2019 21:18:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id EKEQeCr6Tfp8; Mon,  6 May 2019 21:17:52 +0200 (CEST)
Date:   Tue, 7 May 2019 05:17:35 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190506191735.nmzf7kwfh7b6e2tf@yavin>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yezcske27bisu2pl"
Content-Disposition: inline
In-Reply-To: <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yezcske27bisu2pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-06, Jann Horn <jannh@google.com> wrote:
> On Mon, May 6, 2019 at 6:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > The need to be able to scope path resolution of interpreters became
> > clear with one of the possible vectors used in CVE-2019-5736 (which
> > most major container runtimes were vulnerable to).
> >
> > Naively, it might seem that openat(2) -- which supports path scoping --
> > can be combined with execveat(AT_EMPTY_PATH) to trivially scope the
> > binary being executed. Unfortunately, a "bad binary" (usually a symlink)
> > could be written as a #!-style script with the symlink target as the
> > interpreter -- which would be completely missed by just scoping the
> > openat(2). An example of this being exploitable is CVE-2019-5736.
> >
> > In order to get around this, we need to pass down to each binfmt_*
> > implementation the scoping flags requested in execveat(2). In order to
> > maintain backwards-compatibility we only pass the scoping AT_* flags.
> >
> > To avoid breaking userspace (in the exceptionally rare cases where you
> > have #!-scripts with a relative path being execveat(2)-ed with dfd !=3D
> > AT_FDCWD), we only pass dfd down to binfmt_* if any of our new flags are
> > set in execveat(2).
>=20
> This seems extremely dangerous. I like the overall series, but not this p=
atch.
>=20
> > @@ -1762,6 +1774,12 @@ static int __do_execve_file(int fd, struct filen=
ame *filename,
> >
> >         sched_exec();
> >
> > +       bprm->flags =3D flags & (AT_XDEV | AT_NO_MAGICLINKS | AT_NO_SYM=
LINKS |
> > +                              AT_THIS_ROOT);
> [...]
> > +#define AT_THIS_ROOT           0x100000 /* - Scope ".." resolution to =
dirfd (like chroot(2)). */
>=20
> So now what happens if there is a setuid root ELF binary with program
> interpreter "/lib64/ld-linux-x86-64.so.2" (like /bin/su), and an
> unprivileged user runs it with execveat(..., AT_THIS_ROOT)? Is that
> going to let the unprivileged user decide which interpreter the
> setuid-root process should use? From a high-level perspective, opening
> the interpreter should be controlled by the program that is being
> loaded, not by the program that invoked it.

I went a bit nuts with openat_exec(), and I did end up adding it to the
ELF interpreter lookup (and you're completely right that this is a bad
idea -- I will drop it from this patch if it's included in the next
series).

The proposed solutions you give below are much nicer than this patch so
I can drop it and work on fixing those issues separately.

> In my opinion, CVE-2019-5736 points out two different problems:
>
> The big problem: The __ptrace_may_access() logic has a special-case
> short-circuit for "introspection" that you can't opt out of; this
> makes it possible to open things in procfs that are related to the
> current process even if the credentials of the process wouldn't permit
> accessing another process like it. I think the proper fix to deal with
> this would be to add a prctl() flag for "set whether introspection is
> allowed for this process", and if userspace has manually un-set that
> flag, any introspection special-case logic would be skipped.

We could do PR_SET_DUMPABLE=3D3 for this, I guess?

> An additional problem: /proc/*/exe can be used to open a file for
> writing; I think it may have been Andy Lutomirski who pointed out some
> time ago that it would be nice if you couldn't use /proc/*/fd/* to
> re-open files with more privileges, which is sort of the same thing.

This is something I'm currently working on a series for, which would
boil down to some restrictions on how re-opening of file descriptors
works through procfs.

However, execveat() of a procfs magiclink is a bit hard to block --
there is no way for userspace to to represent a file being "open for
execute" so they are all "open for execute" by default and blocking it
outright seems a bit extreme (though I actually hope to eventually add
the ability to mark an O_PATH as "open for X" to resolveat(2) -- hence
why I've reserved some bits).

(Thinking more about it, there is an argument that I should include the
above patch into this series so that we can block re-opening of fds
opened through resolveat(2) without explicit flags from the outset.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--yezcske27bisu2pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzQiEwACgkQSnvnv3De
m59OaBAAz2IFmbji63Cay/WhNNJQnxuHC886Ekc041hMJQn7ciW0w6zqI4hbIEHr
/bI4P+8riONORm5RBnyRyLHLS8iaC1VZJmWbFnZM5h8j8++jA5f8qVaBpcGrXWrn
d1d7ypyVWtxAQJmttIfxGy2d5xzqDpS99ZPnsthF1LQAW1HpKR8maW+Q/cqoTGK5
X33vxwVJaFAatwFDRwsuztAt23m3sJouDvJMuAUOC7/SmQJX2ZI5NRJVUNQOX2Ch
bvKadGzJ8wm31laLSTCDmH3mzKDGshuGCzsqoBgbjRG4s0jPQwAQcbGnj2gcf3gK
1l1jTibk7oOecrUs/GV0++QEkt+mcSJjPsD2oqo9GczTWyPXxQowXJHyPnwhSB1R
MRPZKsSDdTo6gX5hdTzSD/vqyFGtBZArR0h+KhtLs88ypfyd7Bn8cgRQ99bPK3Nb
afiAPQoCyS+4LMLGvRhxuGwjzWvBNKaR463yygtqSfZDzqWLr7eTorj+0KuJhmvo
zDJcj8wnUlWkRXS7Unpj6xy0vKX2mJrkxlOCi39DYYWNTQkj52qLZ+efH44ex0i9
wqAXHmt07+ys/LvIDXHnFzyZSafLhKp7OTWXUiEhVDHCwxFbfQQmsP12pRuoJT9H
OeQgWaVC58G2O4hlrjZBfowV1g9fLjVm/oj+CMVGdhrYyVYSuP4=
=LRko
-----END PGP SIGNATURE-----

--yezcske27bisu2pl--
