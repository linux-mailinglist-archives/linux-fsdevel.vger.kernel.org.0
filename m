Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7F37048E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhEAAzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 20:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhEAAzE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 20:55:04 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152EC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 17:54:15 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4FX9jZ5tq0zQjxQ;
        Sat,  1 May 2021 02:54:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id GXrrP45BgML0; Sat,  1 May 2021 02:54:07 +0200 (CEST)
Date:   Sat, 1 May 2021 10:53:58 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 2/3] open: don't silently ignore unknown O-flags in
 openat2()
Message-ID: <20210501005358.y4qof7l7zjxwkok3@yavin>
References: <20210423111037.3590242-1-brauner@kernel.org>
 <20210423111037.3590242-2-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="25mrcrumo2rleysn"
Content-Disposition: inline
In-Reply-To: <20210423111037.3590242-2-brauner@kernel.org>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.34 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7AED317E8
X-Rspamd-UID: 7a8ffe
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--25mrcrumo2rleysn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-23, Christian Brauner <brauner@kernel.org> wrote:
> The new openat2() syscall verifies that no unknown O-flag values are
> set and returns an error to userspace if they are while the older open
> syscalls like open() and openat2() simply ignore unknown flag values:
>=20
>   #define O_FLAG_CURRENTLY_INVALID (1 << 31)
>   struct open_how how =3D {
>           .flags =3D O_RDONLY | O_FLAG_CURRENTLY_INVALID,
>           .resolve =3D 0,
>   };
>=20
>   /* fails */
>   fd =3D openat2(-EBADF, "/dev/null", &how, sizeof(how));
>=20
>   /* succeeds */
>   fd =3D openat(-EBADF, "/dev/null", O_RDONLY | O_FLAG_CURRENTLY_INVALID);
>=20
> However, openat2() silently truncates the upper 32 bits meaning:
>=20
>   #define O_FLAG_CURRENTLY_INVALID_LOWER32 (1 << 31)
>   #define O_FLAG_CURRENTLY_INVALID_UPPER32 (1 << 40)
>=20
>   struct open_how how_lowe32 =3D {
>           .flags =3D O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWE32,
>           .resolve =3D 0,
>   };
>=20
>   struct open_how how_upper32 =3D {
>           .flags =3D O_RDONLY | O_FLAG_CURRENTLY_INVALID_LOWE32,
>           .resolve =3D 0,
>   };
>=20
>   /* fails */
>   fd =3D openat2(-EBADF, "/dev/null", &how_lower32, sizeof(how_lower32));
>=20
>   /* succeeds */
>   fd =3D openat2(-EBADF, "/dev/null", &how_upper32, sizeof(how_upper32));
>=20
> That seems like a bug. Fix it by preventing the truncation in
> build_open_flags().
>=20
> There's a snafu here though stripping FMODE_* directly from flags would
> cause the upper 32 bits to be truncated as well due to integer promotion
> rules since FMODE_* is unsigned int, O_* are signed ints (yuck).
>=20
> This change shouldn't regress old open syscalls since they silently
> truncate any unknown values.

Yeah, oops on my part (I was always worried I'd missed something with
making everything -EINVAL).

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--25mrcrumo2rleysn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYIymoQAKCRCdlLljIbnQ
Ek3cAQCvmUNgc0eKFF30S/ATbGsa8MoHx/2u81cycOj+5dZ3QQD8Dsf5UYhNVLUn
AI0/8Q2j+4XYDXydIH1BaY3OPoZDjgM=
=Lb6x
-----END PGP SIGNATURE-----

--25mrcrumo2rleysn--
