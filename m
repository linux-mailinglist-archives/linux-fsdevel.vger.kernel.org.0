Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30D61A8F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfEKSBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 14:01:20 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:29254 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfEKSBU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 14:01:20 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id A711C4EBA7;
        Sat, 11 May 2019 20:01:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id lj_58bGFozcr; Sat, 11 May 2019 20:00:58 +0200 (CEST)
Date:   Sun, 12 May 2019 04:00:43 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190511180043.mfwwcz5j2fnxe6lp@yavin>
References: <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin>
 <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com>
 <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
 <20190511173113.qhqmv5q5f74povix@yavin>
 <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x6j6zu2zk3nponfr"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--x6j6zu2zk3nponfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-11, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sat, May 11, 2019 at 1:31 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > Yup, I've dropped the patch for the next version. (To be honest, I'm not
> > sure why I included any of the other flags -- the only one that would've
> > been necessary to deal with CVE-2019-5736 was AT_NO_MAGICLINKS.)
>=20
> I do wonder if we could try to just set AT_NO_MAGICLINKS
> unconditionally for execve() (and certainly for the suid case).
>=20
> I'd rather try to do these things across the board, than have "suid
> binaries are treated specially" if at all possible.
>=20
> The main use case for having /proc/<pid>/exe thing is for finding open
> file descriptors, and for 'ps' kind of use, or to find the startup
> directory when people don't populate the execve() environment fully
> (ie "readlink(/proc/self/exe)" is afaik pretty common.
>=20
> Sadly, googling for
>=20
>     execve /proc/self/exe
>=20
> does actually find hits, including one that implies that chrome does
> exactly that.  So it might not be possible.
>=20
> Somewhat odd, but it does just confirm the whole "users will at some
> point do everything in their power to use every odd special case,
> intended or not".

*sheepishly* Actually we use this in runc very liberally.

It's done because we need to run namespace-related code but runc is
written in Go so (long story short) we re-exec ourselves in order to
run some __attribute__((constructor)) code which sets up the namespaces
and then lets the Go runtime boot.

I suspect just writing everything in C would've been orders of magnitude
simpler, but I wasn't around when that decision was made. :P

Also as Christian mentioned, fexecve(3) in glibc is implemented using
/proc/self/fd on old kernels (then again, if we change the behaviour on
new kernels it won't matter because glibc uses execveat(AT_EMPTY_PATH)
if it's available).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--x6j6zu2zk3nponfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzXDcoACgkQSnvnv3De
m5/VQg//cNbE0gWGWd67U4KsSDs6MVJJyqjF6LOvkYQ7ZDla/7TmoJD8gMLeRiEr
JEg4aoL53swukD16188CiyfgExJOaecf1WWuDM74MelW1FYIrlf2pqD214UO3sq7
K40GqdW9H/JKL+yZrH6+zzQXIYOpf0xNDFwF6yf4yb1vFCk/yEp5+LsewxwDzYVp
u/5L6KcndExqtyHhgY5iS19/rGKtEvqiYSYrpYSpFAtkN3ROb2xe6b7oO4b6Y30q
HQslOeSH11Qw5XU+nV4QkZoIw14pJLV4laPkYHfUyJLNwAjqQEp4CtCuegOH3P95
Zo1PSu1DItJwNgGAM6UcFAF9ctcN0fE4rh5+3szsOIN72vEVHHj6899Y87X+9eEH
OTjiV5I39KAaznMg65tFp4pC8N8wK1jQangilrGuvUOrQdhdr0bA6Yw3eWQ2fWVB
5MlVZzgAvBW1nPasgt9wzbFzj7h+ijXy1H9fGJ88M2t+gT0y7d1f5eu597vAF9An
ZsFiuiRA9tJAFdujgC764s8ujlkI9gELE5fvUQtoXW0WlVoGh0q+y4ffAWFf90o8
pzIv7qxZ/N20ORB1kpUUi0aLBGAjGnksOOUbK/wU1dmTNKxOqQn0HUEOg7EdjPa6
tg84KmSTwS04JizzCtv+4T2oWleq81UUhRvLnmyyF1UZiiJiEHU=
=m7LL
-----END PGP SIGNATURE-----

--x6j6zu2zk3nponfr--
