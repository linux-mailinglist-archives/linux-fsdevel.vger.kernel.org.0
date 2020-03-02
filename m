Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF1B175DEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 16:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgCBPKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 10:10:36 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:30624 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgCBPKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:10:36 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 48WNqs5Tn3zKmgv;
        Mon,  2 Mar 2020 16:10:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id BoVpdSSri02n; Mon,  2 Mar 2020 16:10:30 +0100 (CET)
Date:   Tue, 3 Mar 2020 02:10:21 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302151021.x5mm54jtoukg4tdk@yavin>
References: <20200302143546.srzk3rnh4o6s76a7@wittgenstein>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <848282.1583159228@warthog.procyon.org.uk>
 <888183.1583160603@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="42vyj6s72ngbbu3r"
Content-Disposition: inline
In-Reply-To: <888183.1583160603@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--42vyj6s72ngbbu3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-02, David Howells <dhowells@redhat.com> wrote:
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
>=20
> > I think we settled this and can agree on RESOLVE_NO_SYMLINKS being the
> > right thing to do, i.e. not resolving symlinks will stay opt-in.
> > Or is your worry even with the current semantics of openat2()? I don't
> > see the issue since O_NOFOLLOW still works with openat2().
>=20
> Say, for example, my home dir is on a network volume somewhere and /home =
has a
> symlink pointing to it.  RESOLVE_NO_SYMLINKS cannot be used to access a f=
ile
> inside my homedir if the pathwalk would go through /home/dhowells - this =
would
> affect fsinfo()

Yes, though this only happens if you're opening "/home/dhowells/foobar".
If you are doing "./foobar" from within "/home/dhowells" it will work
(or if you open a dirfd to "/home/dhowells") -- because no symlink
resolution is done as part of that openat2() call.

> So RESOLVE_NO_SYMLINKS is not a substitute for AT_SYMLINK_NOFOLLOW
> (O_NOFOLLOW would not come into it).

This is what I was saying up-thread -- the semantics are not the same
*on purpose*. If you want "don't follow symlinks *only for the final
component*" then you need to have an AT_SYMLINK_NOFOLLOW equivalent.

My counter-argument is that most people actually want
RESOLVE_NO_SYMLINKS (as evidenced by the countless symlink-related
security bugs -- many of which used O_NOFOLLOW incorrectly), it just
wasn't available before Linux 5.6.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--42vyj6s72ngbbu3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXl0h2gAKCRCdlLljIbnQ
EpMTAP95ffUjqS37ZYriNgIdtHux4Y3D4HV/fCw6z5s7POmk9wD/XALcyw1lQ95P
oClztyDXpLWzGUBlyXyIjwfr8nXAPw4=
=PmLG
-----END PGP SIGNATURE-----

--42vyj6s72ngbbu3r--
