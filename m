Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105D567DE4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 09:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfGNHBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 03:01:34 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:35424 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfGNHBe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 03:01:34 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id DAD124EEE5;
        Sun, 14 Jul 2019 09:01:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 83Wg7f6TIzf1; Sun, 14 Jul 2019 09:01:20 +0200 (CEST)
Date:   Sun, 14 Jul 2019 17:00:29 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190714070029.m53etvm3y4etidxt@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
 <20190712132553.GN17978@ZenIV.linux.org.uk>
 <20190712150026.GO17978@ZenIV.linux.org.uk>
 <20190713024153.GA3817@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="33fhorotybcq4qkp"
Content-Disposition: inline
In-Reply-To: <20190713024153.GA3817@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--33fhorotybcq4qkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-13, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jul 12, 2019 at 04:00:26PM +0100, Al Viro wrote:
> > On Fri, Jul 12, 2019 at 02:25:53PM +0100, Al Viro wrote:
> >=20
> > > 	if (flags & LOOKUP_BENEATH) {
> > > 		nd->root =3D nd->path;
> > > 		if (!(flags & LOOKUP_RCU))
> > > 			path_get(&nd->root);
> > > 		else
> > > 			nd->root_seq =3D nd->seq;
> >=20
> > BTW, this assignment is needed for LOOKUP_RCU case.  Without it
> > you are pretty much guaranteed that lazy pathwalk will fail,
> > when it comes to complete_walk().
> >=20
> > Speaking of which, what would happen if LOOKUP_ROOT/LOOKUP_BENEATH
> > combination would someday get passed?
>=20
> I don't understand what's going on with ->r_seq in there - your
> call of path_is_under() is after having (re-)sampled rename_lock,
> but if that was the only .. in there, who's going to recheck
> the value?  For that matter, what's to guarantee that the thing
> won't get moved just as you are returning from handle_dots()?
>=20
> IOW, what does LOOKUP_IN_ROOT guarantee for caller (openat2())?

I tried to explain this in the commit message for "namei: aggressively
check for nd->root escape on ".." resolution", but I probably could've
explained it better.

The basic property being guaranteed by LOOKUP_IN_ROOT is that it will
not result in resolution of a path component which was not inside the
root of the dirfd tree at some point during resolution (and that all
absolute symlink and ".." resolution will be done relative to the
dirfd). This may smell slightly of chroot(2), because unfortunately it
is a similar concept -- the reason for this is to allow for a more
efficient way to safely resolve paths inside a rootfs than spawning a
separate process to then pass back the fd to the caller.

We don't want to do a path_is_under() check for every ".." (otherwise
lookups have a quadratic slowdown when doing many ".."s), so I instead
only do a check after a rename or a mount (which are the only operations
which could change what ".." points to). And since we do the
path_is_under() check if m_seq or r_seq need a retry, we can re-take
them[+].

The main reason why I don't re-check path_is_under() after handle_dots()
is that there is no way to be sure that a racing rename didn't happen
after your last path_is_under() check. The rename could happen after the
syscall returns, after all.

So, the main purpose of the check is to make sure that a ".."s after a
rename doesn't result in an escape. If the rename happens after we've
traversed through a ".." that means that the ".." was inside the root in
the first place (a root ".." is handled by follow_dotdot). If the rename
happens after we've gone through handle_dots() and there is no
subsequent ".." then to userspace it looks identical to the rename
occurring after the syscall has returned. If there is a subsequent ".."
after a racing rename then we may have moved into a path that wasn't
path_is_under() and so we have to check it.

The only way I could see you could solve the race completely is if you
had a way for userspace to lock things from being able to be renamed (or
MS_MOVE'd). And that feels like a really bad idea to me.

[+]: You asked why don't I re-take m_seq. The reason is that I don't
	 fully understand all the other m_seq checks being done during
	 resolution, and we aren't definitely doing them all in
	 handle_dots(). So I assumed re-taking it could result in me
	 breaking RCU-walk which obviously would be bad. Since I am the only
	 thing using nd->r_seq, I can re-take it without issue.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--33fhorotybcq4qkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXSrTCAAKCRCdlLljIbnQ
EpwpAQD9KgKhzC1YZRQyynlFOIyKp8VXEUfhiNokL0RBBx4G5AD7BovFdb8KzxSf
QrrP/0Vq6p6AFs4sMQbjc9M6I/5gzQ8=
=fUib
-----END PGP SIGNATURE-----

--33fhorotybcq4qkp--
