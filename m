Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6C1A4E71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 09:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgDKHID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 03:08:03 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:41852 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgDKHID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:08:03 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48zmDd4Bf4zKmb1;
        Sat, 11 Apr 2020 09:08:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 6ImCwYpE5mUy; Sat, 11 Apr 2020 09:07:57 +0200 (CEST)
Date:   Sat, 11 Apr 2020 17:07:50 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Askar Safin <safinaskar@mail.ru>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: What about adding AT_NO_AUTOMOUNT analogue to openat2?
Message-ID: <20200411070750.goak63tlej37wkbj@yavin.dot.cyphar.com>
References: <1586558501.806374941@f476.i.mail.ru>
 <20200411060236.swlgw6ymzikgcqxl@yavin.dot.cyphar.com>
 <20200411064530.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3j7snhab5ghmhft6"
Content-Disposition: inline
In-Reply-To: <20200411064530.GL23230@ZenIV.linux.org.uk>
X-Rspamd-Queue-Id: 3B2351693
X-Rspamd-Score: -5.64 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--3j7snhab5ghmhft6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-11, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Apr 11, 2020 at 04:02:36PM +1000, Aleksa Sarai wrote:
> > On 2020-04-11, Askar Safin <safinaskar@mail.ru> wrote:
> > > What about adding stat's AT_NO_AUTOMOUNT analogue to openat2?
> >=20
> > There isn't one. I did intend to add RESOLVE_NO_AUTOMOUNTS after openat2
> > was merged -- it's even mentioned in the commit message -- but I haven't
> > gotten around to it yet. The reason it wasn't added from the outset was
> > that I wasn't sure if adding it would be as simple as the other
> > RESOLVE_* flags.
> >=20
> > Note that like all RESOLVE_* flags, it would apply to all components so
> > it wouldn't be truly analogous with AT_NO_AUTOMOUNT (though as I've
> > discussed at length on this ML, most people do actually want the
> > RESOLVE_* semantics). But you can emulate the AT_* ones much more easily
> > with RESOLVE_* than vice-versa).
>=20
> Er...  Not triggering automount on anything but the last component means
> failing with ENOENT.  *All* automount points are empty and are bloody
> well going to remain such, as far as I'm concerned.

I wasn't suggesting that RESOLVE_NO_AUTOMOUNTS would unmask whatever is
on the underlying filesystem -- I agree that would be completely insane.

It would just give you -EXDEV (or perhaps -EREMOTE) if you walk into an
automount (the same logic as with the other RESOLVE_NO_* flags). We
could make it -ENOENT if you prefer, but that means userspace can't tell
the difference between it hitting an automount and the target actually
not existing.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3j7snhab5ghmhft6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXpFswwAKCRCdlLljIbnQ
EjFsAP919YTPnIVDduFGslb4nWHWDXkv79b4iV4Np7VgV2N3AAD/cUDqd5GL6gR2
Xf6hh+f4F8PtiPLvFKxn35GmXoiZZwA=
=V1c6
-----END PGP SIGNATURE-----

--3j7snhab5ghmhft6--
