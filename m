Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2CA1AC71
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfELNjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 09:39:06 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:16568 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfELNjF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 09:39:05 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B4DA1A0021;
        Sun, 12 May 2019 15:39:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id CSOl9DeYISN9; Sun, 12 May 2019 15:38:42 +0200 (CEST)
Date:   Sun, 12 May 2019 23:38:26 +1000
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
Message-ID: <20190512133826.fcmfiqze7dnetews@yavin>
References: <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com>
 <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com>
 <CAHk-=wg3+3GfHsHdB4o78jNiPh_5ShrzxBuTN-Y8EZfiFMhCvw@mail.gmail.com>
 <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
 <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
 <20190512133549.ymx5yg5rdqvavzyq@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="upyx5avrpqh45pmb"
Content-Disposition: inline
In-Reply-To: <20190512133549.ymx5yg5rdqvavzyq@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--upyx5avrpqh45pmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-12, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2019-05-12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Sat, May 11, 2019 at 7:37 PM Andy Lutomirski <luto@amacapital.net> w=
rote:
> > > I bet this will break something that already exists. An execveat()
> > > flag to turn off /proc/self/exe would do the trick, though.
> >=20
> > Thinking more about it, I suspect it is (once again) wrong to let the
> > thing that does the execve() control that bit.
> >=20
> > Generally, the less we allow people to affect the lifetime and
> > environment of a suid executable, the better off we are.
> >=20
> > But maybe we could limit /proc/*/exe to at least not honor suid'ness
> > of the target? Or does chrome/runc depend on that too?
>=20
> Speaking on the runc side, we don't depend on this. It's possible
> someone depends on this for fexecve(3) -- but as mentioned before in
> newer kernels glibc uses execve(AT_EMPTY_PATH).
>=20
> I would like to point out though that I'm a little bit cautious about
> /proc/self/exe-specific restrictions -- because a trivial way to get
> around them would be to just open it with O_PATH (and you end up with a
> /proc/self/fd/ which is equivalent). Unfortunately blocking setuid exec
> on all O_PATH descriptors would break even execve(AT_EMPTY_PATH) of
> setuid descriptors.
>=20
> The patches I mentioned (which Andy and I discussed off-list) would
> effectively make the magiclink modes in /proc/ affect how you can
> operate on the path (no write bit in the mode, cannot re-open it write).
> One aspect of this is how to handle O_PATH and in particular how do we
> handle an O_PATH re-open of an already-restricted magiclink.
>=20
> Maybe we could make it so that setuid is disallowed if you are dealing
> with an O_PATH fd which was a magiclink. Effectively, on O_PATH open you
> get an fmode_t saying FMODE_SETUID_EXEC_ALLOWED *but* if the path is a
> magiclink this fmode gets dropped and when the fd is given to
> execveat(AT_EMPTY_PATH) the fmode is checked and setuid-exec is not
> allowed.

=2E.. and obviously /proc/self/exe would have an fmode
~FMODE_SETUID_EXEC_ALLOWED from the outset. The reason for this slightly
odd semantic would be to continue to allow O_PATH setuid-exec as long as
the O_PATH was opened from an actual path rather than a magiclink.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--upyx5avrpqh45pmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzYIdIACgkQSnvnv3De
m5/k3g//dQ2vldshSBgDRCYFp+NIbe3aezmy1kNqzKMMXgcsYT3mIrfWIxjG7YE5
PP9p1S71mRdCKTqsFBQgbDDyndrB4xM2i+twGDiGFS7w9zjL3XerilU1zGsasARI
pO2c7q7q/yV3eojlUsjM1t+RoCP98mvNAqTSIaA9EwsoVGYclO6sySolqhRzYtiQ
e4IxuO/6PO2iJ2q1U/dqHOIbccklkDtv3Axyr9ghs/IT8KLR6+Wz3oEUtq6nlhCT
T0fyn5W3/iTSzXr5xM7Hh98IQ+3nvLgLf6a9RknjtLFPusnrc6FrkwfpJgEPNN6D
N1nhoJZu7SFbMzAuRrkLdyCX/VSklzlfrpqXJkOg5GlKTP/sPRGYF+4RRbloYrkm
8pNnklo/iMeeDTS66ReDZJ3G7W6J0YjayC6IDFZTj2hlqSBxiBr6xdN1q/3IbH5e
DnWvpohGw9hiihQy1crSSw8/JLEw0UOLtUFCd8F9BgX73bFOEVh21yITPIQXdLDS
D1eKM4R8lk+9pVoMBWonwSc8fTIRpwt4i/i6eRG33aDjXqFbcNiYMRK8S6FiaQVH
Vb1S5CEiYY71izXMPaqXY3LLhMpSQ+5lz3FHmrQrCejTFUmWuFclS/8woBbXFgg8
3hOD5KIGYIe+hCIQXzLM3FkdykiGTdsAoPUCSeLCaKe9goTLy5s=
=2jNp
-----END PGP SIGNATURE-----

--upyx5avrpqh45pmb--
