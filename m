Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB96F175E20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 16:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCBPZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 10:25:12 -0500
Received: from mout-p-103.mailbox.org ([80.241.56.161]:31314 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgCBPZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:25:12 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48WP8j4TPrzKmjb;
        Mon,  2 Mar 2020 16:25:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id fAzdbPLBLvfp; Mon,  2 Mar 2020 16:25:06 +0100 (CET)
Date:   Tue, 3 Mar 2020 02:24:58 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Florian Weimer <fweimer@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302152458.hznqqssixhlpykgr@yavin>
References: <20200302143546.srzk3rnh4o6s76a7@wittgenstein>
 <20200302115239.pcxvej3szmricxzu@wittgenstein>
 <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <848282.1583159228@warthog.procyon.org.uk>
 <888183.1583160603@warthog.procyon.org.uk>
 <20200302150528.okjdx2mkluicje4w@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xn7vzrzjedzuxf6n"
Content-Disposition: inline
In-Reply-To: <20200302150528.okjdx2mkluicje4w@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--xn7vzrzjedzuxf6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-02, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Mon, Mar 02, 2020 at 02:50:03PM +0000, David Howells wrote:
> > Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >=20
> > > I think we settled this and can agree on RESOLVE_NO_SYMLINKS being the
> > > right thing to do, i.e. not resolving symlinks will stay opt-in.
> > > Or is your worry even with the current semantics of openat2()? I don't
> > > see the issue since O_NOFOLLOW still works with openat2().
> >=20
> > Say, for example, my home dir is on a network volume somewhere and /hom=
e has a
> > symlink pointing to it.  RESOLVE_NO_SYMLINKS cannot be used to access a=
 file
> > inside my homedir if the pathwalk would go through /home/dhowells - thi=
s would
> > affect fsinfo() - so RESOLVE_NO_SYMLINKS is not a substitute for
> > AT_SYMLINK_NOFOLLOW (O_NOFOLLOW would not come into it).
>=20
> I think we didn't really have this issue/face that question because
> openat() never supported AT_SYMLINK_{NO}FOLLOW. Whereas e.g. fsinfo()
> does. So in such cases we are back to: either allow both AT_* and
> RESOLVE_* flags (imho not the best option) or add (a) new RESOLVE_*
> variant(s). It seems we leaned toward the latter so far...

So, RESOLVE_NO_TRAILING_SYMLINKS?

=2E.. *sigh*. Yeah, okay I'm fine (though not super happy) with that. We'd
also presumably need RESOLVE_NO_TRAILING_AUTOMOUNTS for David's
AT_NO_AUTOMOUNT usecases -- as well as RESOLVE_NO_AUTOMOUNTS eventually.

Now let's just hope no new syscalls need both AT_RECURSIVE and
RESOLVE_NO_SYMLINKS -- that will put us in a very interesting situation
where you have two ways of specifying "don't follow trailing
symlinks"...

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xn7vzrzjedzuxf6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXl0lRwAKCRCdlLljIbnQ
EmMSAQDIO3yZ0xSckeOPL7fzRMy0Am5PpfhMf2341+52eCfxBAD/bHvDr3LqRDWv
GcWsOSOh/7tqzSIZKtlz0QQlD4pzkwg=
=KDk8
-----END PGP SIGNATURE-----

--xn7vzrzjedzuxf6n--
