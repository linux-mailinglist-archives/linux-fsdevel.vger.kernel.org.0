Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB71998C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgCaOj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 10:39:27 -0400
Received: from mout-p-201.mailbox.org ([80.241.56.171]:19264 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCaOj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:39:26 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 48sBmX0b2jzQlF1;
        Tue, 31 Mar 2020 16:39:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id FoOKAboSO1mL; Tue, 31 Mar 2020 16:39:20 +0200 (CEST)
Date:   Wed, 1 Apr 2020 01:39:11 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH man-pages v2 2/2] openat2.2: document new openat2(2)
 syscall
Message-ID: <20200331143911.lokfoq3lqfri2mgy@yavin.dot.cyphar.com>
References: <20200202151907.23587-1-cyphar@cyphar.com>
 <20200202151907.23587-3-cyphar@cyphar.com>
 <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l2lpn76pgjx5xchv"
Content-Disposition: inline
In-Reply-To: <1567baea-5476-6d21-4f03-142def0f62e3@gmail.com>
X-Rspamd-Queue-Id: CF12A1743
X-Rspamd-Score: -2.96 / 15.00 / 200.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--l2lpn76pgjx5xchv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-30, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> Hello Aleksa,
>=20
> On 2/2/20 4:19 PM, Aleksa Sarai wrote:
> > Rather than trying to merge the new syscall documentation into open.2
> > (which would probably result in the man-page being incomprehensible),
> > instead the new syscall gets its own dedicated page with links between
> > open(2) and openat2(2) to avoid duplicating information such as the list
> > of O_* flags or common errors.
> >=20
> > In addition to describing all of the key flags, information about the
> > extensibility design is provided so that users can better understand why
> > they need to pass sizeof(struct open_how) and how their programs will
> > work across kernels. After some discussions with David Laight, I also
> > included explicit instructions to zero the structure to avoid issues
> > when recompiling with new headers.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Thanks. I've applied this patch, but also done quite a lot of
> editing of the page. The current draft is below (and also pushed=20
> to Git). Could I ask you to review the page, to see if I injected
> any error during my edits.

Looks good to me.

> In addition, I've added a number of FIXMEs in comments
> in the page source. Can you please check these, and let me
> know your thoughts.

Will do, see below.

> .\" FIXME I find the "previously-functional systems" in the previous
> .\" sentence a little odd (since openat2() ia new sysycall), so I would
> .\" like to clarify a little...
> .\" Are you referring to the scenario where someone might take an
> .\" existing application that uses openat() and replaces the uses
> .\" of openat() with openat2()? In which case, is it correct to
> .\" understand that you mean that one should not just indiscriminately
> .\" add the RESOLVE_NO_XDEV flag to all of the openat2() calls?
> .\" If I'm not on the right track, could you point me in the right
> .\" direction please.

This is mostly meant as a warning to hopefully avoid applications
because the developer didn't realise that system paths may contain
symlinks or bind-mounts. For an application which has switched to
openat2() and then uses RESOLVE_NO_SYMLINKS for a non-security reason,
it's possible that on some distributions (or future versions of a
distribution) that their application will stop working because a system
path suddenly contains a symlink or is a bind-mount.

This was a concern which was brought up on LWN some time ago. If you can
think of a phrasing that makes this more clear, I'd appreciate it.

> .\" FIXME: what specific details in symlink(7) are being referred
> .\" by the following sentence? It's not clear.

The section on magic-links, but you're right that the sentence ordering
is a bit odd. It should probably go after the first sentence.

> .\" FIXME I found the following hard to understand (in particular, the
> .\" meaning of "scoped" is unclear) , and reworded as below. Is it okay?
> .\"     Absolute symbolic links and ".." path components will be scoped to
> .\"     .IR dirfd .

Scoped does broadly mean "interpreted relative to", though the
difference is mainly that when I said scoped it's meant to be more of an
assertive claim ("the kernel promises to always treat this path inside
dirfd"). But "interpreted relative to" is a clearer way of phrasing the
semantics, so I'm okay with this change.

> .\" FIXME The next piece is unclear (to me). What kind of ".." escape
> .\" attempts does chroot() not detect that RESOLVE_IN_ROOT does?

If the root is moved, you can escape from a chroot(2). But this sentence
might not really belong in a man-page since it's describing (important)
aspects of the implementation and not the semantics.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--l2lpn76pgjx5xchv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXoNWDAAKCRCdlLljIbnQ
EuhhAQDrGJcSC2tvaVHSZirH1uENpWOgqxV1HHQaNXnurRE1MwD/eS7jz/feBrZa
HAM6s15BEz8f1DvF4UAf0nb8LHajngw=
=O1HR
-----END PGP SIGNATURE-----

--l2lpn76pgjx5xchv--
