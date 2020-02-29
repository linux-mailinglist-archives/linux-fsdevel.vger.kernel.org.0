Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096A01747AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 16:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgB2P1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 10:27:12 -0500
Received: from mout-p-103.mailbox.org ([80.241.56.161]:9386 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgB2P1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 10:27:12 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48V9Hw62W7zKmhC;
        Sat, 29 Feb 2020 16:27:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 7xLatdWfY05q; Sat, 29 Feb 2020 16:27:05 +0100 (CET)
Date:   Sun, 1 Mar 2020 02:26:56 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, fweimer@redhat.com
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200229152656.gwu7wbqd32liwjye@yavin>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gi6jozpeqmazgrpn"
Content-Disposition: inline
In-Reply-To: <20200228152427.rv3crd7akwdhta2r@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gi6jozpeqmazgrpn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-28, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> [Cc Florian since that ends up on libc's table sooner or later...]
>=20
> On Fri, Feb 28, 2020 at 02:53:32PM +0000, David Howells wrote:
> > =09
> > I've been told that RESOLVE_* flags, which can be found in linux/openat=
2.h,
> > should be used instead of the equivalent AT_* flags for new system call=
s.  Is
> > this the case?
>=20
> Imho, it would make sense to use RESOLVE_* flags for new system calls
> and afair this was the original intention.

Yes, RESOLVE_ flags would ideally be usable with all new system calls
(though only where it makes sense, obviously). This would make it much
easier for userspace to safely resolve paths without having to go
through several levels of O_PATH fuckery.

The "openat2.h" name was honestly a completely arbitrary decision.

> So we either end up adding new AT_* flags mirroring the new RESOLVE_*
> flags or we end up adding new RESOLVE_* flags mirroring parts of AT_*
> flags. And if that's a possibility I vote for RESOLVE_* flags going
> forward. The have better naming too imho.

I can see the argument for merging AT_ flags into RESOLVE_ flags (fewer
flag arguments for syscalls is usually a good thing) ... but I don't
really like it. There are a couple of problems right off the bat:

 * The prefix RESOLVE_ implies that the flag is specifically about path
   resolution. While you could argue that AT_EMPTY_PATH is at least
   *related* to path resolution, flags like AT_REMOVEDIR and
   AT_RECURSIVE aren't.

 * That point touches on something I see as a more fundamental problem
   in the AT_ flags -- they were intended to be generic flags for all of
   the ...at(2) syscalls. But then AT_ grew things like AT_STATX_ and
   AT_REMOVEDIR (both of which are necessary features to have for their
   respective syscalls, but now those flag bits are dead for other
   syscalls -- not to mention the whole AT_SYMLINK_{NO,}FOLLOW thing).

 * While the above might be seen as minor quibbles, the really big
   issue is that even the flags which are "similar" (AT_SYMLINK_NOFOLLOW
   and RESOLVE_NO_SYMLINKS) have different semantics (by design -- in my
   view, AT_SYMLINK_{NO,}FOLLOW / O_NOFOLLOW / lstat(2) has always had
   the wrong semantics if the intention was to be a way to safely avoid
   resolving symlinks).

But maybe I'm just overthinking what a merge of AT_ and RESOLVE_ would
look like -- would it on.

> An argument against this could be that we might end up causing more
> confusion for userspace due to yet another set of flags. But maybe this
> isn't an issue as long as we restrict RESOLVE_* flags to new syscalls.
> When we introduce a new syscall userspace will have to add support for
> it anyway.
>=20
> >=20
> > If so, should we comment them as being deprecated in the header file?  =
And
> > should they be in linux/fcntl.h rather than linux/openat2.h?
> >=20
> > Also:
> >=20
> >  (*) It should be noted that the RESOLVE_* flags are not a superset of =
the
> >      AT_* flags (there's no equivalent of AT_NO_AUTOMOUNT for example).
>=20
> That's true but it seems we could just add e.g. RESOLVE_NO_AUTOMOUNT as
> soon as we have a new syscall showing up that needs it or we have an
> existing syscall (e.g. openat2()) that already uses RESOLVE_* flags and
> needs it?

RESOLVE_NO_AUTOMOUNT is on the roadmap for openat2() -- I mentioned it
as future work in the cover letter. :P

But see my above concerns about merging AT_ and RESOLVE_ flags. The
semantic disconnect between AT_ and RESOLVE_ (which is most obvious with
AT_SYMLINK_NOFOLLOW) also exists for AT_NO_AUTOMOUNT.

> >  (*) It has been suggested that AT_SYMLINK_NOFOLLOW should be the defau=
lt, but
> >      only RESOLVE_NO_SYMLINKS exists.
>=20
> I'd be very much in favor of not following symlinks being the default.
> That's usually a source of a lot of security issues.
> And since no kernel with openat2() has been released there's still time
> to switch it and with openat2() being a new syscall it won't hurt if it
> has new semantics; I mean it deviates from openat() - intentionally -
> already.

I agree in principle, but the problem is that if we want to add new
RESOLVE_ flags you end up with half (or fewer) of the flags being opt-in
with the rest necessarily being opt-out (since the flag not being set
needs to be the old behaviour).

There's also a slight ugliness with RESOLVE_SYMLINKS|RESOLVE_MAGICLINKS
-- should you have to specify both or should RESOLVE_MAGICLINKS imply
RESOLVE_SYMLINKS but only for magic-links. (Is allowing magic-links but
not symlinks even a sane thing to do?)

Also I have a very strong feeling people won't like RESOLVE_XDEV nor
RESOLVE_SYMLINKS being opt-in -- lots of systems use bind-mounts and
symlinks in system paths and developers might not be aware of this.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--gi6jozpeqmazgrpn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXlqCvAAKCRCdlLljIbnQ
ErrpAPwIkNOWRinI5EBkvqXe0r+BbAw2sFvTtGTQrk63ajZnQgEApZxmCMgpgmIG
Wd3LkExra2n+a0rpN3oWf8JXcgVNOgk=
=diwc
-----END PGP SIGNATURE-----

--gi6jozpeqmazgrpn--
