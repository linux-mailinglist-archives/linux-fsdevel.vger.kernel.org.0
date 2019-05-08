Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A580016E7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 02:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfEHAza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 20:55:30 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:15292 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfEHAza (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 20:55:30 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 43F7D4DE51;
        Wed,  8 May 2019 02:55:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id aH1WSlgN_x_O; Wed,  8 May 2019 02:55:13 +0200 (CEST)
Date:   Wed, 8 May 2019 10:54:56 +1000
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
Message-ID: <20190508005456.th5pkxljz536cq6w@yavin>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m3sipayj4evvlhxl"
Content-Disposition: inline
In-Reply-To: <20190506191735.nmzf7kwfh7b6e2tf@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--m3sipayj4evvlhxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-07, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2019-05-06, Jann Horn <jannh@google.com> wrote:
> > On Mon, May 6, 2019 at 6:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > The need to be able to scope path resolution of interpreters became
> > > clear with one of the possible vectors used in CVE-2019-5736 (which
> > > most major container runtimes were vulnerable to).
> > >
> > > Naively, it might seem that openat(2) -- which supports path scoping =
--
> > > can be combined with execveat(AT_EMPTY_PATH) to trivially scope the
> > > binary being executed. Unfortunately, a "bad binary" (usually a symli=
nk)
> > > could be written as a #!-style script with the symlink target as the
> > > interpreter -- which would be completely missed by just scoping the
> > > openat(2). An example of this being exploitable is CVE-2019-5736.
> > >
> > > In order to get around this, we need to pass down to each binfmt_*
> > > implementation the scoping flags requested in execveat(2). In order to
> > > maintain backwards-compatibility we only pass the scoping AT_* flags.
> > >
> > > To avoid breaking userspace (in the exceptionally rare cases where you
> > > have #!-scripts with a relative path being execveat(2)-ed with dfd !=
=3D
> > > AT_FDCWD), we only pass dfd down to binfmt_* if any of our new flags =
are
> > > set in execveat(2).
> >=20
> > This seems extremely dangerous. I like the overall series, but not this=
 patch.
> >=20
> > > @@ -1762,6 +1774,12 @@ static int __do_execve_file(int fd, struct fil=
ename *filename,
> > >
> > >         sched_exec();
> > >
> > > +       bprm->flags =3D flags & (AT_XDEV | AT_NO_MAGICLINKS | AT_NO_S=
YMLINKS |
> > > +                              AT_THIS_ROOT);
> > [...]
> > > +#define AT_THIS_ROOT           0x100000 /* - Scope ".." resolution t=
o dirfd (like chroot(2)). */
> >=20
> > So now what happens if there is a setuid root ELF binary with program
> > interpreter "/lib64/ld-linux-x86-64.so.2" (like /bin/su), and an
> > unprivileged user runs it with execveat(..., AT_THIS_ROOT)? Is that
> > going to let the unprivileged user decide which interpreter the
> > setuid-root process should use? From a high-level perspective, opening
> > the interpreter should be controlled by the program that is being
> > loaded, not by the program that invoked it.
>=20
> I went a bit nuts with openat_exec(), and I did end up adding it to the
> ELF interpreter lookup (and you're completely right that this is a bad
> idea -- I will drop it from this patch if it's included in the next
> series).
>=20
> The proposed solutions you give below are much nicer than this patch so
> I can drop it and work on fixing those issues separately.

Another possible solution would be to only allow (for instance)
AT_NO_MAGICLINKS for execveat(2). That way you cannot scope the
resolution but you can block the most concerning cases -- those
involving /proc-related access.

I've posted a v7 with this patch dropped (because we can always add AT_*
flags later in time), but I think having at least NO_MAGICLINKS would be
useful.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--m3sipayj4evvlhxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzSKOAACgkQSnvnv3De
m5+sVw//bA9Tf90p30BmnpG1nXFGi3o1Bvcw4bBtju6je0jL0EhCa6/D3MOOfYS3
6Hy2pArRB/bP7Q2EWPS9xcoB65JMLigAMxa2kMiNjbHW12fShWBidjFqMEVBM6cS
mitc+utlJWYL0HYPOvyGz6POpDofulAvfiYBVgFeqlJA+/C3EvdEOAGTBCv705aM
7cNPTRJj+bcJ0Yvu6oXERxC+txG0AaM7CHeONhkZMxlkziZvwGyZYpui8pQgGm9D
6aMp++KpubhSiRZVq3XHEJtg1323ujlQBDW8Y2i5LtjizwXWCf1x+gj5yKbM7Yzt
gVDcVDOrTfunC3DP9eiJtjVm4y722CBR+XSyGi/iGY9cs5GOWwkhtI7LV98/d6B+
N6P9V2HhAeRFWId1exLYlD03qwesXUSiMymObj0zsKhRotJ8dcUx66wJtOvrumZf
lUf9FKXZF5b8cbUOAnSCcVZ/YdZcwwItWAD0ZT2sGD5ZttnC0sKnrFtEkbeMGGpN
NG9v1lNYhqpmVE9jsSBXFSKVaDB1ipqqtxB0mSaK0/6aTOg8YMwKqxonuBra9sz3
SqXwP25Qk5++syB2vZVdJNFAl9gjlapYrtTAqdYdrTQCSkIHeyiEIl9IT4lMupWR
JgdYo6OEjpob11GKYnNjixo0REwy2cDXSqWvauZEBbriQ2b0jbI=
=YctX
-----END PGP SIGNATURE-----

--m3sipayj4evvlhxl--
