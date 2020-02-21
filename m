Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F367166E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 05:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgBUEJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 23:09:35 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:61070 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBUEJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:09:35 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48Nydm4KJVzQl8v;
        Fri, 21 Feb 2020 05:09:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id oFm3H5Xhen8G; Fri, 21 Feb 2020 05:09:28 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:09:19 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200221040919.zmsayko3fnbdbmib@yavin.dot.cyphar.com>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
 <20200212183718.GQ6870@magnolia>
 <87d0ajmxc3.fsf@mid.deneb.enyo.de>
 <20200212195118.GN23230@ZenIV.linux.org.uk>
 <87wo8rlgml.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="72jezy6cdioydlhk"
Content-Disposition: inline
In-Reply-To: <87wo8rlgml.fsf@mid.deneb.enyo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--72jezy6cdioydlhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-12, Florian Weimer <fw@deneb.enyo.de> wrote:
> * Al Viro:
>=20
> > On Wed, Feb 12, 2020 at 08:15:08PM +0100, Florian Weimer wrote:
> >
> >> | Further, I've found some inconsistent behavior with ext4: chmod on t=
he
> >> | magic symlink fails with EOPNOTSUPP as in Florian's test, but fchmod
> >> | on the O_PATH fd succeeds and changes the symlink mode. This is with
> >> | 5.4. Cany anyone else confirm this? Is it a problem?
> >>=20
> >> It looks broken to me because fchmod (as an inode-changing operation)
> >> is not supposed to work on O_PATH descriptors.
> >
> > Why?  O_PATH does have an associated inode just fine; where does
> > that "not supposed to" come from?
>=20
> It fails on most file systems right now.  I thought that was expected.
> Other system calls (fsetxattr IIRC) do not work on O_PATH descriptors,
> either.  I assumed that an O_PATH descriptor was not intending to
> confer that capability.  Even openat fails.

openat(2) failing on an O_PATH for a symlink is separate to fchmod(2)
failing:

 * fchmod(2) fails with EBADF because O_PATH file descriptors have
   f->f_ops set to empty_fops -- this is why ioctl(2)s also fail on
   O_PATH file descriptors. This is *intentional* behaviour.

   My understanding of the original idea of O_PATH file descriptors is
   that they are meant to have restricted capabilities -- it's
   effectively a "half-open" file handle. The fact that some folks (like
   myself) figured out you can do all sorts of crazy stuff with them is
   mostly an accident.

 * openat(n, ...) fails with ENOTDIR because openat(2) requires the
   argument to be a directory, and O_PATH-of-a-symlink-to-a-directory
   doesn't count (path_init doesn't do resolution of the dirfd
   argument -- nor should it IMHO).

 * open(/proc/self/fd/$n) failing with ELOOP might actually be a bug
   (the error is coming from may_open as though the lookup was done with
   O_NOFOLLOW) -- the nd_jump_link() jump takes the namei lookup to a
   the symlink but it looks like the normal link_path_walk et al
   handling doesn't actually try to continue resolving it. I'll look
   into this a bit more.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--72jezy6cdioydlhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXk9X7AAKCRCdlLljIbnQ
Ekv4AP0ZuhucM8Ne89UcoHM3SgqKcil4dSSFtqgh6larOrBizgEAuiH+02IAFSd7
wvK+gQrMQTfR+XSLyZB7mD1ZheZe5ww=
=EYsF
-----END PGP SIGNATURE-----

--72jezy6cdioydlhk--
