Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86CA172E4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 02:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgB1BZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 20:25:05 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:42284 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgB1BZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:25:05 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 48TBfk2HHczKmV0;
        Fri, 28 Feb 2020 02:25:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id E9DZjsHHjp6i; Fri, 28 Feb 2020 02:24:58 +0100 (CET)
Date:   Fri, 28 Feb 2020 12:24:51 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v2)
Message-ID: <20200228012451.upnq5r7fdctrk7pv@yavin>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200225012457.GA138294@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cla7i2c4hyd6w2ul"
Content-Disposition: inline
In-Reply-To: <20200225012457.GA138294@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cla7i2c4hyd6w2ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-25, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Feb 23, 2020 at 01:12:21AM +0000, Al Viro wrote:
> > 	This is a slightly extended repost of the patchset posted on
> > Jan 19.  Current branch is in vfs.git#work.do_last, the main
> > difference from the last time around being a bit of do_last()
> > untangling added in the end of series.  #work.openat2 is already
> > in mainline, which simplifies the series - now it's a straight
> > branch with no merges.
>=20
> Whee...  While trying to massage ".." handling towards the use of
> regular mount crossing semantics, I've found something interesting.
> Namely, if you start in a directory with overmounted parent,
> LOOKUP_NO_XDEV resolution of ../something will bloody well cross
> into the overmount.

Oh boy...

> Reason: follow_dotdot() (and its RCU counterpart) check for LOOKUP_NO_XDEV
> when crossing into underlying fs, but not when crossing into overmount
> of the parent.
>=20
> Interpretation of .. is basically
>=20
> loop:	if we are in root					// uncommon
> 		next =3D current position
> 	else if we are in root of a mounted filesystem		// more rare
> 		move to underlying mountpoint
> 		goto loop
> 	else
> 		next =3D parent directory of current position	// most common
>=20
> 	while next is overmounted				// _VERY_ uncommon
> 		next =3D whatever's mounted on next
>=20
> 	move to next
>=20
> The second loop should've been sharing code with the normal mountpoint
> crossing.  It doesn't, which has already lead to interesting inconsistenc=
ies
> (e.g. autofs generally expects ->d_manage() to be called before crossing
> into it; here it's not done).  LOOKUP_NO_XDEV has just added one more...

You're quite right -- LOOKUP_NO_XDEV should block that and I missed it.

> Incidentally, another inconsistency is LOOKUP_BENEATH treatment in case
> when we have walked out of the subtree by way of e.g. procfs symlink and
> then ran into .. in the absolute root (that's
>                 if (!follow_up(&nd->path))
>                         break;
> in follow_dotdot()).  Shouldn't that give the same reaction as ..
> in root (EXDEV on LOOKUP_BENEATH, that is)?  It doesn't...

You can't go through procfs symlinks with LOOKUP_BENEATH, but if it's
possible to do that kind of jump then it should also be blocked (but I
would say that I'd prefer "block any kind of weird jump").

> Another one is about LOOKUP_NO_XDEV again: suppose you have process'
> root directly overmounted and cwd in the root of whatever's overmounting
> it.  Resolution of .. will stay in cwd - we have no parent within the
> chroot jail we are in, so we move to whatever's overmounting that root.
> Which is the original location.  Should we fail on LOOKUP_NO_XDEV here?
> Plain .. in the root of chroot jail (not overmounted by anything) does
> *not*...

I think LOOKUP_NO_XDEV should block that since you end up crossing a
mountpoint.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cla7i2c4hyd6w2ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXlhr4QAKCRCdlLljIbnQ
EvPAAQCgcdH9xDc0JcNFSyizyIS0NFAVUIhgMKxeMa9A2TNSFgEA0NpX8uhWXCsy
7vgtGIc1h9SnuYOzjrSIvz0yBm7nww4=
=JbtI
-----END PGP SIGNATURE-----

--cla7i2c4hyd6w2ul--
