Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06744534FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243602AbiEZNKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 09:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiEZNKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 09:10:12 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 06:10:08 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E80D6825;
        Thu, 26 May 2022 06:10:07 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4L87Zc45kqz9slf;
        Thu, 26 May 2022 15:10:00 +0200 (CEST)
Date:   Thu, 26 May 2022 23:09:52 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <20220526130952.z5efngrnh7xtli32@senku>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibw7jsn6vzzlm5h2"
Content-Disposition: inline
In-Reply-To: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ibw7jsn6vzzlm5h2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-05-12, Simon Ser <contact@emersion.fr> wrote:
> Hi all,
>=20
> I'm a user-space developer working on Wayland. Recently we've been
> discussing about security considerations related to FD passing between
> processes [1].
>=20
> A Wayland compositor often needs to share read-only data with its
> clients. Examples include a keyboard keymap, or a pixel format table.
> The clients might be untrusted. The data sharing can happen by having
> the compositor send a read-only FD (ie, a FD opened with O_RDONLY) to
> clients.
>=20
> It was assumed that passing such a FD wouldn't allow Wayland clients to
> write to the file. However, it was recently discovered that procfs
> allows to bypass this restriction. A process can open(2)
> "/proc/self/fd/<fd>" with O_RDWR, and that will return a FD suitable for
> writing. This also works when running the client inside a user namespace.
> A PoC is available at [2] and can be tested inside a compositor which
> uses this O_RDONLY strategy (e.g. wlroots compositors).
>=20
> Question: is this intended behavior, or is this an oversight? If this is
> intended behavior, what would be a good way to share a FD to another
> process without allowing it to write to the underlying file?

This is currently intended behaviour, but I am working on a patchset to
fix it. This was originally meant to be included with openat2(2) along
with some other hardenings in order to add safe O_EMPTYPATH support (as
well as having the ability for you to open an O_PATH descriptor and
restrict how it can be re-opened).

The WIP patchset is in my repo[1]. The main issue at the moment is how
to deal with directories (for parity with *at(2) semantics as well as
our own sanity, using a /proc/self/fd/$n as a path component can't be
blocked so there's some more access mode fiddling necessary to make this
all cleaner). I should have an RFC version ready in a couple of weeks.

[1]: https://github.com/cyphar/linux/tree/magiclink/main

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ibw7jsn6vzzlm5h2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYo98HwAKCRCdlLljIbnQ
EnbWAP4ueeQklKJMapKtyD+RDUZp4H6guPat1Ol2vAPb0dY/MwEAlASVdaS4T1/T
SSSNPdv+rvtrmIpWk359KR9awogQNQo=
=Jh+9
-----END PGP SIGNATURE-----

--ibw7jsn6vzzlm5h2--
