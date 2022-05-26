Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A65534FBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbiEZNEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 09:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347398AbiEZNEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 09:04:12 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B5CFE3E;
        Thu, 26 May 2022 06:04:10 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4L87Rm0bs8z9sZH;
        Thu, 26 May 2022 15:04:04 +0200 (CEST)
Date:   Thu, 26 May 2022 23:03:55 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: procfs: open("/proc/self/fd/...") allows bypassing O_RDONLY
Message-ID: <20220526130355.fo6gzbst455fxywy@senku>
References: <lGo7a4qQABKb-u_xsz6p-QtLIy2bzciBLTUJ7-ksv7ppK3mRrJhXqFmCFU4AtQf6EyrZUrYuSLDMBHEUMe5st_iT9VcRuyYPMU_jVpSzoWg=@emersion.fr>
 <03l0hfZIzD9KwSxSntGcmfFhvbIKiK45poGUhXtR7Qi0Av0-ZnqnSBPAP09GGpSrKGZWZNCTvme_Gpiuz0Bcg6ewDIXSH24SBx_tvfyZSWU=@emersion.fr>
 <CAJfpegs4GVirNVtf4OqunzNwbXQywZVkxpGPtpN=ZonHU2SpiA@mail.gmail.com>
 <20220513095817.622gcrgx3fffwk4h@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ls6hlrjjszajykhe"
Content-Disposition: inline
In-Reply-To: <20220513095817.622gcrgx3fffwk4h@wittgenstein>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ls6hlrjjszajykhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-05-13, Christian Brauner <brauner@kernel.org> wrote:
> On Thu, May 12, 2022 at 02:56:22PM +0200, Miklos Szeredi wrote:
> > On Thu, 12 May 2022 at 14:41, Simon Ser <contact@emersion.fr> wrote:
> > >
> > > On Thursday, May 12th, 2022 at 12:37, Simon Ser <contact@emersion.fr>=
 wrote:
> > >
> > > > what would be a good way to share a FD to another
> > > > process without allowing it to write to the underlying file?
> > >
> > > (I'm reminded that memfd + seals exist for this purpose. Still, I'd be
> > > interested to know whether that O_RDONLY/O_RDWR behavior is intended,
> > > because it's pretty surprising. The motivation for using O_RDONLY over
> > > memfd seals is that it isn't Linux-specific.)
> >=20
> > Yes, this is intended.   The /proc/$PID/fd/$FD file represents the
> > inode pointed to by $FD.   So the open flags for $FD are irrelevant
> > when operating on the proc fd file.
>=20
> Fwiw, the original openat2() patchset contained upgrade masks which we
> decided to split it out into a separate patchset.
>=20
> The idea is that struct open_how would be extended with an upgrade mask
> field which allows the opener to specify with which permissions a file
> descriptor is allowed to be re-opened. This has quite a lot of
> use-cases, especially in container runtimes. So one could open an fd and
> restrict it from being re-opened with O_WRONLY. For container runtimes
> this is a huge security win and for userspace in general it would
> provide a backwards compatible way of e.g., making O_PATH fds
> non-upgradable. The plan is to resend the extension at some point in the
> not too distant future.

I am currently working on reviving this patchset.

The main issue at the moment is that the semantics for how we should
deal with directories is a little difficult to define (we want to ignore
modes for directories because of *at(2) semantics but there's no fmode_t
bits at the moment representing that the flip is a directory), but I'm
working on it.

This is going to be included along with the O_EMPTYPATH feature (since
making this safe is IMHO a pre-requisite for O_EMPTYPATH).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ls6hlrjjszajykhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYo96uAAKCRCdlLljIbnQ
EuLaAP9AIoX3ZQoBY4Zbt7eYKU1Futeff1vE4dFwviRHUzebPAEAtrMNZ1WaqSOT
6XAkAWN2lR2wUyPESn4+ONh89CO/0gs=
=8SCK
-----END PGP SIGNATURE-----

--ls6hlrjjszajykhe--
