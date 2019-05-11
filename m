Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8201A8C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfEKRbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 13:31:55 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:62220 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfEKRbz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 13:31:55 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 345DCA1102;
        Sat, 11 May 2019 19:31:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id U96iYXqkAw6V; Sat, 11 May 2019 19:31:28 +0200 (CEST)
Date:   Sun, 12 May 2019 03:31:13 +1000
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
Message-ID: <20190511173113.qhqmv5q5f74povix@yavin>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin>
 <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com>
 <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i44ldloocwzu2rot"
Content-Disposition: inline
In-Reply-To: <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--i44ldloocwzu2rot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-11, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sat, May 11, 2019 at 1:21 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Notice? None of the real problems are about execve or would be solved
> > by any spawn API. You just think that because you've apparently been
> > talking to too many MS people that think fork (and thus indirectly
> > execve()) is bad process management.
>=20
> Side note: a good policy has been (and remains) to make suid binaries
> not be dynamically linked. And in the absence of that, the dynamic
> linker at least resets the library path when it notices itself being
> dynamic, and it certainly doesn't inherit any open flags from the
> non-trusted environment.
>=20
> And by the same logic, a suid interpreter must *definitely* should not
> inherit any execve() flags from the non-trusted environment. So I
> think Aleksa's patch to use the passed-in open flags is *exactly* the
> wrong thing to do for security reasons. It doesn't close holes, it
> opens them.

Yup, I've dropped the patch for the next version. (To be honest, I'm not
sure why I included any of the other flags -- the only one that would've
been necessary to deal with CVE-2019-5736 was AT_NO_MAGICLINKS.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--i44ldloocwzu2rot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzXBuEACgkQSnvnv3De
m597fQ//WXBoDgwSchtS2eCgORVEt/GpkQAgePJYwEpQBr0+c1V9sqX1MgF8PyV+
RfEKv1o0pv1ObTZHVoGJtIayxPKpDF+fC7O5c5uEqMA+9q0rVd+wlZGCS981L19J
g2/7Wr7k/keX1kuSxcSUtuiDqwfNtQNlX0wHsV7LBoAsnCRzZAOfooyN9kylZ5wl
LrWn6dVN9xB9ZLskG9Ygsu0ea8scE/IPhrj4C0qjVtNrHcblANdXUfXtcMWd4N3v
6NbA8FQoK0+mqnVg/fe390z80RHMtjcGQNWjrPTDRiozevLmwLVY5N2GL6VdQqUn
pXxdZNnw8YgRBDk1jZzMtfQE1cIMiLrvLHHgw5HHIoHXWS0O3Io471A/lciG5oOw
j7XI7PHZ5AOScO0OokJwjdTLWJDM4RbNMa7pbccJfcpZVAbkkei/Ok5wc4Fmaz/V
3t7BPXmG3hH5QJRWijBWk/UVhbEw9wr/ZrKfs92RJyMV1ssVm05ie3QUI2J7PeE+
nMAzIhmjsnB6hE1hMdh9KYiF4jNE5+pEHAqwftby57wAZFLfGp4DoLqZ6NlNAHz2
FlBp+5f+bj/hyRqi3ZnhWnTgrMzOhwPWW44hoYYp81sQXC6JachI1Hg1uMlRlDVw
HaUI9KXoYI8KKUxYhX/AA9kDkkaJlJ7I6V73lh5SlDU6SFLPACk=
=wYoq
-----END PGP SIGNATURE-----

--i44ldloocwzu2rot--
