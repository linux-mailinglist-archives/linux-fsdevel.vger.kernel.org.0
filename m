Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE189326E8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 19:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhB0SCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 13:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbhB0R7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 12:59:52 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE9CC06174A
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Feb 2021 09:59:12 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4DnvQq4VqszQlKq;
        Sat, 27 Feb 2021 18:58:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id AfSWKstFy77y; Sat, 27 Feb 2021 18:58:39 +0100 (CET)
Date:   Sun, 28 Feb 2021 04:58:33 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: openat, mkdirat, and TOCTOU for directory creation
Message-ID: <20210227175833.qgj4qrzz7aqe4zah@yavin.dot.cyphar.com>
References: <C9KDTRDMTBR4.2JFWCA79LXA9X@taiga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vlu4vcdxhethdjpg"
Content-Disposition: inline
In-Reply-To: <C9KDTRDMTBR4.2JFWCA79LXA9X@taiga>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -8.61 / 15.00 / 15.00
X-Rspamd-Queue-Id: 5879617D6
X-Rspamd-UID: 7574aa
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--vlu4vcdxhethdjpg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-27, Drew DeVault <sir@cmpwn.com> wrote:
> Hiya! I'm looking into the mkdirat and openat syscalls, and I noticed
> that there's no means of implementing TOCTOU (time-of-check to
> time-of-use, a technique for preventing race conditions) on directory
> creation.
>=20
> To create a directory and obtain a dirfd for it, you have to (1)
> mkdirat, then (2) openat with O_DIRECTORY, and if the directory is
> removed in between, the latter will fail.
>=20
> One possibly straightforward solution is to support openat with the
> O_DIRECTORY and O_CREAT flags specified.

This was discussed last year[1]. I think it would be useful but it
shouldn't be done as part of openat(2) because we already have enough
multiplexing with that syscall.

Maybe a mkdirat2(2) (which takes a flags argument -- sigh) that can be
told to return a handle to the new directory would be a nicer API.

> The present behavior of this flag combination is to create a file and
> return ENOTDIR. The appropriate behavior is probably to create a
> directory as proposed, or, at a minimum, to return EINVAL and not create
> the file.

Changing the semantics of open scares me a fair bit -- you could
probably change openat2(2) since it's not as widely used yet.

[1]: https://lore.kernel.org/linux-fsdevel/20200316142057.xo24zea3k5zwswra@=
yavin/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--vlu4vcdxhethdjpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYDqIRAAKCRCdlLljIbnQ
ErFpAPiXHZVSHF+4T/Nt1I9Cr8IJe595sq7oQ8L+45Q2xMmwAQC2t2vdIHwOAshg
7TjIxJzeX2xRl0XW2HY1odi4SRM7Dw==
=NQG+
-----END PGP SIGNATURE-----

--vlu4vcdxhethdjpg--
