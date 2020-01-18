Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E6141A57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 00:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgARXDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 18:03:33 -0500
Received: from mout-p-201.mailbox.org ([80.241.56.171]:9604 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgARXDc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 18:03:32 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 480YPs1J52zQl9T;
        Sun, 19 Jan 2020 00:03:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id SD3IzuuiLenX; Sun, 19 Jan 2020 00:03:24 +0100 (CET)
Date:   Sun, 19 Jan 2020 10:03:13 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        quae@daurnimator.com, dev@opencontainers.org,
        containers@lists.linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] openat2: minor uapi cleanups
Message-ID: <20200118230313.y4a3s7elierw4wzw@yavin>
References: <20200115144831.GJ8904@ZenIV.linux.org.uk>
 <20200118120800.16358-1-cyphar@cyphar.com>
 <20200118152833.GS8904@ZenIV.linux.org.uk>
 <20200118180941.GT8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5riwsuz4dgr3e2jm"
Content-Disposition: inline
In-Reply-To: <20200118180941.GT8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--5riwsuz4dgr3e2jm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-18, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Jan 18, 2020 at 03:28:33PM +0000, Al Viro wrote:
>=20
> > #work.openat2 updated, #for-next rebuilt and force-pushed.  There's
> > a massive update of #work.namei as well, also pushed out; not in
> > #for-next yet, will post the patch series for review later today.
>=20
> BTW, looking through that code again, how could this
> static bool legitimize_root(struct nameidata *nd)
> {
>         /*
>          * For scoped-lookups (where nd->root has been zeroed), we need to
>          * restart the whole lookup from scratch -- because set_root() is=
 wrong
>          * for these lookups (nd->dfd is the root, not the filesystem roo=
t).
>          */
>         if (!nd->root.mnt && (nd->flags & LOOKUP_IS_SCOPED))
>                 return false;
>=20
> possibly trigger?  The only things that ever clean ->root.mnt are

You're quite right -- the codepath I was worried about was pick_link()
failing (which *does* clear nd->path.mnt, and I must've misread it at
the time as nd->root.mnt).

We can drop this check, though now complete_walk()'s main defence
against a NULL nd->root.mnt is that path_is_under() will fail and
trigger -EXDEV (or set_root() will fail at some point in the future).
However, as you pointed out, a NULL nd->root.mnt won't happen with
things as they stand today -- I might be a little too paranoid. :P

> 	This is really, really fundamental for understanding the whole
> thing - a failure of unlazy_walk/unlazy_child means that we are through
> with that attempt.

Yup -- see above, the worry was about pick_link() not about how the
RCU-walk and REF-walk dances operate.

> The same, BTW, goes for the check you've added in the beginning of
> set_root() - set_root() is called only with NULL nd->root.mnt (trivial to
> prove) and that is incompatible with LOOKUP_IS_SCOPED.  I'm kinda-sorta
> OK with having WARN_ON() there for a while, but IMO the check in the
> beginning of legitimize_root() should go away -

You're quite right about dropping the legitimize_root() check, but I'd
like to keep the WARN_ON() in set_root(). The main reason being that it
makes us very damn sure that a future change won't accidentally break
the nd->root contract which all of the LOOKUP_IS_SCOPED changes rely on.
Then again, this might be my paranoia popping up again.

> this kind of defensive programming only makes harder to reason about
> the behaviour of the entire thing.  And fs/namei.c is too convoluted
> as it is...

If you feel that dropping some of these more defensive checks is better
for the codebase as a whole, then I defer to your judgement. I
completely agree that namei is a pretty complicated chunk of code.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--5riwsuz4dgr3e2jm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXiOOrAAKCRCdlLljIbnQ
El4EAQC1WR0K38GbwA/LlO6nw8sVI9MtczS357o6yXejishSYQD9H/zbEGqHpnbO
bKqcDRhHuTYEVzPTGWr9RjeaAa07Jw8=
=LNP0
-----END PGP SIGNATURE-----

--5riwsuz4dgr3e2jm--
