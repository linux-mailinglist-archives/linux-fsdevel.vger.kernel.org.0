Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F36BB1A8B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfEKR0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 13:26:40 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:50972 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfEKR0k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 13:26:40 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 33060A113D;
        Sat, 11 May 2019 19:26:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id QBgIpz9hq11J; Sat, 11 May 2019 19:26:20 +0200 (CEST)
Date:   Sun, 12 May 2019 03:26:04 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
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
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190511172604.znr7wa3iarlgzor4@yavin>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin>
 <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com>
 <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n7szhd3upx5nplbw"
Content-Disposition: inline
In-Reply-To: <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--n7szhd3upx5nplbw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-11, Andy Lutomirski <luto@amacapital.net> wrote:
> >> I've lost track of the context here, but it seems to me that
> >> mitigating attacks involving accidental following of /proc links
> >> shouldn't depend on dumpability.  What's the actual problem this is
> >> trying to solve again?
> >=20
> > The one actual security problem that I've seen related to this is
> > CVE-2019-5736. There is a write-up of it at
> > <https://blog.dragonsector.pl/2019/02/cve-2019-5736-escape-from-docker-=
and.html>
> > under "Successful approach", but it goes more or less as follows:
> >=20
> > A container is running that doesn't use user namespaces (because for
> > some reason I don't understand, apparently some people still do that).
> > An evil process is running inside the container with UID 0 (as in,
> > GLOBAL_ROOT_UID); so if the evil process inside the container was able
> > to reach root-owned files on the host filesystem, it could write into
> > them.
> >=20
> > The container engine wants to spawn a new process inside the container.
> > It forks off a child that joins the container's namespaces (including
> > PID and mount namespaces), and then the child calls execve() on some
> > path in the container.
>=20
> I think that, at this point, the task should be considered owned by
> the container.  Maybe we should have a better API than execve() to
> execute a program in a safer way, but fiddling with dumpability seems
> like a band-aid.  In fact, the process is arguably pwned even *before*
> execve.

Yeah, execve is just the vector (though in this case it's done in order
to clear mm->dumpable). An earlier CVE (CVE-2016-9962) was very similar
but was attacking a dirfd that runc had open into the container (LXC had
a very similar bug too) -- setting !mm->dumpable was one of the
workarounds we had for this.

> A better =E2=80=9Cspawn=E2=80=9D API should fix this.  In the mean time, =
I think it
> should be assumed that, if you join a container=E2=80=99s namespaces, you=
 are
> at its mercy.

This is generally how we treat containers as runtime authors, but it's
not a trivial thing to get right. In many cases the kernel APIs are
working against you -- Christian and myself have written a fair few
patches to fix holes in the kernel APIs so we can avoid these kinds of
assumptions.

But yes, one of the most risky parts of a container runtime is when
you're attaching to a running container because all of the helpful
introspection APIs in /proc/ suddenly become a security nightmare. A
better "spawn a process in these namespaces" API might help improve the
situation (or at least, I hope it would).

> > - You can use /proc/*/exe to get a writable fd.
>=20
> This is IMO the real bug.

I will try to send an RFC of the patchset I have for this next week or
so. Funnily enough, currently /proc/*/exe has the write bit set in its
"mode" (my series fixes this).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--n7szhd3upx5nplbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzXBawACgkQSnvnv3De
m5+9uhAAxlNj8wFvyGxd9lOFHlJk3BsEWF8O35j0dfu/SXGgCNJZ97fZ8lUWTVG+
Znkw+uL8P+d3IItZeF5IlpWaeE+rISaTqwF6Q55riVaKXY+oarEuDdvWSgPkO9S8
QHlnu5MyIQcccSI9Mxk+BZCXrlKbqZJJnFeHP/zI95hnsbOanK2dO6rYfEaAMYIZ
XwkL4HvI0mqdFUcrmO4hpkQEJjj/b6xSpo6oJBsm/PvOaUeChJROam4lgES3oAV8
ngomtPJWzbTz4ZYzYBXUiNwWvNCCl2E9XfnH9jVgD9z1NFQ0V1LLu3SXxdSqcdpW
OOzGdmdRNuRvFeRKGISZYs3kr/vVgD8hm0g79KVsbCl24FU9eHSK7EQLUZ+/fc7K
GGIok1MHPjDfVRJ6ZoFil47MWrLdvqJlgovEdYmjZC5Tt7NOfP+JkXkvh+jZ49pi
7YTk6h/2ZAW+l5Hq0UxPv9bKUSLtErZmsueCT/U0AAqhQaBAU3HWQVyhGoLNNMfu
cJXnRHZcw4QaAZEzSb6FENQq4Qv+Or+Fv+cOis759T1Cgx02jybyo0ZIKHzfelxP
Mgqd0qkTv9+mG3w1p6ox9gDQvGoZJRZT+d6E7VSVqZRc4DAFCcTAF/EzJArg0OhU
DA0oCKIiZwgpEHyyzIcaD/6fSSFnz2hQJ3EXIp46nX2IZjldnjo=
=Ut88
-----END PGP SIGNATURE-----

--n7szhd3upx5nplbw--
