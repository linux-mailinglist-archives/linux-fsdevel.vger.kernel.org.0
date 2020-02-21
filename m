Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADA5166EF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 06:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgBUFV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 00:21:56 -0500
Received: from mout-p-103.mailbox.org ([80.241.56.161]:63698 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUFV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:21:56 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48P0FG2FpqzKmgH;
        Fri, 21 Feb 2020 06:21:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id wq9pO3caYdHI; Fri, 21 Feb 2020 06:21:50 +0100 (CET)
Date:   Fri, 21 Feb 2020 16:21:42 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200221052142.qfvpuga7r6u6p474@yavin.dot.cyphar.com>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
 <20200212183718.GQ6870@magnolia>
 <87d0ajmxc3.fsf@mid.deneb.enyo.de>
 <20200212195118.GN23230@ZenIV.linux.org.uk>
 <87wo8rlgml.fsf@mid.deneb.enyo.de>
 <20200221040919.zmsayko3fnbdbmib@yavin.dot.cyphar.com>
 <20200221050205.GW23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brep73g5urggblmz"
Content-Disposition: inline
In-Reply-To: <20200221050205.GW23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--brep73g5urggblmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-21, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Feb 21, 2020 at 03:09:19PM +1100, Aleksa Sarai wrote:
> >  * open(/proc/self/fd/$n) failing with ELOOP might actually be a bug
> >    (the error is coming from may_open as though the lookup was done with
> >    O_NOFOLLOW) -- the nd_jump_link() jump takes the namei lookup to a
> >    the symlink but it looks like the normal link_path_walk et al
> >    handling doesn't actually try to continue resolving it. I'll look
> >    into this a bit more.
>=20
> Not a bug.  Neither mount nor symlink traversal applies to destinations
> of pure jumps (be it a symlink to "/" or a procfs symlink).  Both are
> deliberate and both for very good reasons.  We'd discussed that last
> year (and I'm going to cover that on LSF); basically, there's no
> good semantics for symlink traversal in such situation.

Fair enough, I figured there might be a deeper reason I was missing. ;)

> Again, this is absolutely deliberate.  And for sanity sake, don't bother
> with link_path_walk() et.al. state in mainline - see #work.namei or
> #work.do_last in vfs.git; I'm going to repost that series tonight or
> tomorrow.  The logics is easier to follow there.

Yeah, will do. I took a quick look when you posted it originally and I
agree it does seem more reasonable, I'll read through it in more depth
once you resend it.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--brep73g5urggblmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXk9o4wAKCRCdlLljIbnQ
EhVyAP46Uj2/Gda5JhVHHNKLauRVh0q6o31E8V2mCyh7M2jCswEA5H1yEUozSqf9
K+WtiDNdZCuunuoGTlvK0RJFv7qFNAU=
=JCj1
-----END PGP SIGNATURE-----

--brep73g5urggblmz--
