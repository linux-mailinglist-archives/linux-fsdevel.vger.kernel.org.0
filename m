Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D91AC6D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 15:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfELNgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 09:36:31 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:30156 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfELNgb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 09:36:31 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 189004D9D8;
        Sun, 12 May 2019 15:36:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id Ju6mq5hMCESO; Sun, 12 May 2019 15:36:07 +0200 (CEST)
Date:   Sun, 12 May 2019 23:35:49 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
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
Message-ID: <20190512133549.ymx5yg5rdqvavzyq@yavin>
References: <20190506191735.nmzf7kwfh7b6e2tf@yavin>
 <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com>
 <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com>
 <CAHk-=wg3+3GfHsHdB4o78jNiPh_5ShrzxBuTN-Y8EZfiFMhCvw@mail.gmail.com>
 <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
 <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ljvorpid7rujdy3"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7ljvorpid7rujdy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sat, May 11, 2019 at 7:37 PM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > I bet this will break something that already exists. An execveat()
> > flag to turn off /proc/self/exe would do the trick, though.
>=20
> Thinking more about it, I suspect it is (once again) wrong to let the
> thing that does the execve() control that bit.
>=20
> Generally, the less we allow people to affect the lifetime and
> environment of a suid executable, the better off we are.
>=20
> But maybe we could limit /proc/*/exe to at least not honor suid'ness
> of the target? Or does chrome/runc depend on that too?

Speaking on the runc side, we don't depend on this. It's possible
someone depends on this for fexecve(3) -- but as mentioned before in
newer kernels glibc uses execve(AT_EMPTY_PATH).

I would like to point out though that I'm a little bit cautious about
/proc/self/exe-specific restrictions -- because a trivial way to get
around them would be to just open it with O_PATH (and you end up with a
/proc/self/fd/ which is equivalent). Unfortunately blocking setuid exec
on all O_PATH descriptors would break even execve(AT_EMPTY_PATH) of
setuid descriptors.

The patches I mentioned (which Andy and I discussed off-list) would
effectively make the magiclink modes in /proc/ affect how you can
operate on the path (no write bit in the mode, cannot re-open it write).
One aspect of this is how to handle O_PATH and in particular how do we
handle an O_PATH re-open of an already-restricted magiclink.

Maybe we could make it so that setuid is disallowed if you are dealing
with an O_PATH fd which was a magiclink. Effectively, on O_PATH open you
get an fmode_t saying FMODE_SETUID_EXEC_ALLOWED *but* if the path is a
magiclink this fmode gets dropped and when the fd is given to
execveat(AT_EMPTY_PATH) the fmode is checked and setuid-exec is not
allowed.

[I assume in this discussion "setuid" means "setuid + setcap", right?]

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--7ljvorpid7rujdy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzYITIACgkQSnvnv3De
m5+OKBAAiDKQq70XmSTMnQLoBSf5SB1ZyMZ3vJXt6n0euUe+wavft0DZtPTb0hY3
uKd7u/g38zUZ7baljhnkEJQAyZy27SG+2/3EAKSAE9jtMS6pdksQWYwjOwXdMu50
1lnSKVxGnLLWWFw223hgh9DFnoK4VcWVIclLW2h+Hvx0ZdOgGxJGN90e+E8bHjKi
9M1A4asRFL84bm3wFqTwnYSulEKLlt2N6RsEg9jgtc4LSqkqniv3GqyFdtdfhJ4x
+6O80qPV9ZuPPhh9KH6lepHvlmJTUvHjrNbUbdfqqRmL1FaxvhOmLTezUWrpxOVB
3Y5PlLCKAeIpILMMDhwKFwRKFv3rVaPV7hrF/7W3dhtaafsEiiOVPvR5EOibckW8
Sjxjfk/9GMpojh4fQW8kMA6oUoK6t0C3whZ/lkIG5tHP5NfTmy0mAkM8792lMTCP
fXoEREetPz7fTgqLSWIviE1B8R2639WE9U33+7szv091/9k5sF6IWIihgu76eCnK
fYEULllNXG6rVrUFRi3TPQayufLiwtHBkS2EYmTI4LnMl8FF3epFieIxkuIT/CZl
khWT2EXGmkflqCTR6pS3ctBPAZ+tHpzjSo9j0/U0r3moNUP7OBLhFPWWvZ1Qvo8i
dZKy9IVwy3ycjoDurTWk3/UOfa4XFBgBb07HxAp8W5yE39Bk89s=
=2vc5
-----END PGP SIGNATURE-----

--7ljvorpid7rujdy3--
