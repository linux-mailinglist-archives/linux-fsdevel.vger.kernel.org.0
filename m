Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6330D17589F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 11:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCBKr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 05:47:56 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:62776 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgCBKrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:47:55 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48WH0n5XKGzQlFf;
        Mon,  2 Mar 2020 11:47:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id CJiqeDl4dVnk; Mon,  2 Mar 2020 11:47:47 +0100 (CET)
Date:   Mon, 2 Mar 2020 21:47:41 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     lampahome <pahome.chen@mirlab.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: why do we need utf8 normalization when compare name?
Message-ID: <20200302104741.b5lypijqlbpq5lgz@yavin>
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302103754.nsvtne2vvduug77e@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ofzwvqyr4zfj5kgu"
Content-Disposition: inline
In-Reply-To: <20200302103754.nsvtne2vvduug77e@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ofzwvqyr4zfj5kgu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-02, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2020-03-02, lampahome <pahome.chen@mirlab.org> wrote:
> > According to case insensitive since kernel 5.2, d_compare will
> > transform string into normalized form and then compare.
> >
> > But why do we need this normalization function? Could we just compare
> > by utf8 string?
>=20
> The problem is that there are multiple ways to represent the same glyph
> in Unicode -- for instance, you can represent =C3=85 (the symbol for
> angstrom) as both U+212B and U+0041 U+030A (the latin letter "A"
> followed by the ring-above symbol "=C2=B0"). Different software may choos=
e to
> represent the same glyphs in different Unicode forms, hence the need for
> normalisation.

Sorry, a better example would've been "=C3=B1" (U+00F1). You can also
represent it as "n" (U+006E) followed by "=E2=97=8C=CC=83" (U+0303 -- "comb=
ining
tilde"). Both forms are defined by Unicode to be canonically equivalent
so it would be incorrect to treat the two Unicode strings differently
(that isn't quite the case for "=C3=85").

> [1] is the Wikipedia article that describes this problem and what the
> different kinds of Unicode normalisation are.
>=20
> [1]: https://en.wikipedia.org/wiki/Unicode_equivalence

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ofzwvqyr4zfj5kgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXlzkSwAKCRCdlLljIbnQ
ElDCAP9EJDnDkIaOwFuLSTBfU69vEr37WcdbjHX7dM37DzM8ewD/Wf5wba4nNgXl
6hFISESd7nDPkngNJbvth4eos5W9MQE=
=rwv8
-----END PGP SIGNATURE-----

--ofzwvqyr4zfj5kgu--
