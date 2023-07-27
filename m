Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF3765AA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjG0RnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjG0Rmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:42:53 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A730E3;
        Thu, 27 Jul 2023 10:42:52 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RBdQK2JCDz9tB8;
        Thu, 27 Jul 2023 19:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1690479769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irvaKwjIRBfIMs3OM027g5G4TY2gjSeGrvplRFueXaU=;
        b=UZDWQCSlVrWdtqreCk6pJhl6N2mvEBs8l+J0GZXLAJ/i0AyNILAKr29Y2HzpDc9MHho6C5
        xVlOhswIJJkR5SSR4ws+giR/x20PVxaPyIM6O/iNQxvH7uAImdu2F/Zw48FGbEcZ6risS0
        REEAuKwEzxnqm3M6cQCiZqnNt+7AoEXIgN0iyVEXl/IgRzie92zZ+gVSh1Z8MCS6kWkRql
        HlKWkqhpMYcbmdMzT3dNoNMTNXKs91TI0m/a0jVKcoSIVgCZEWz4fVmF9rn+0qt15Qn/26
        OISfzUoTd6FBgoUSvJSBOFNpfsyBzgTQSL6tDQROyhhl2eKXxJMNtKy6plit+w==
Date:   Fri, 28 Jul 2023 03:42:22 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Palmer Dabbelt <palmer@sifive.com>,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, fweimer@redhat.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH v4 3/5] arch: Register fchmodat2, usually as syscall 452
Message-ID: <20230727.174206-real.town.kosher.menu-lN1F8uSeAtB@cyphar.com>
References: <cover.1689074739.git.legion@kernel.org>
 <cover.1689092120.git.legion@kernel.org>
 <a677d521f048e4ca439e7080a5328f21eb8e960e.1689092120.git.legion@kernel.org>
 <nbtxxotfsotuiepm7r4tegc4hy5qxe4dfjuqq7rm6qkkevooxh@4hacgjwit4or>
 <20230727-fangen-olympiade-85fcbdaf03d7@brauner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y33k3lm4leglkjmq"
Content-Disposition: inline
In-Reply-To: <20230727-fangen-olympiade-85fcbdaf03d7@brauner>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--y33k3lm4leglkjmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-07-27, Christian Brauner <brauner@kernel.org> wrote:
> On Wed, Jul 26, 2023 at 02:43:41AM +1000, Aleksa Sarai wrote:
> > On 2023-07-11, Alexey Gladkov <legion@kernel.org> wrote:
> > > From: Palmer Dabbelt <palmer@sifive.com>
> > >=20
> > > This registers the new fchmodat2 syscall in most places as nuber 452,
> > > with alpha being the exception where it's 562.  I found all these sit=
es
> > > by grepping for fspick, which I assume has found me everything.
> >=20
> > Shouldn't this patch be squashed with the patch that adds the syscall?
> > At least, that's how I've usually seen it done...
>=20
> Depends. Iirc, someone said they'd prefer for doing it in one patch
> in some circumstances on some system call we added years ago. But otoh,
> having the syscall wiring done separately makes it easy for arch
> maintainers to ack only the wiring up part. Both ways are valid imho.
> (cachestat() did it for x86 and then all the others separately. So
> really it seems a bit all over the place depending on the scenario.)

Fair enough!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--y33k3lm4leglkjmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZMKsfgAKCRAol/rSt+lE
b/FwAQChKTWhN1YMxOU/bLQz1S3i+RhA8DQHZpoCbh1FlOSYwAEAmOKfPG+e4zNA
VW75+QkpKlGw0rY3TfjxW8YkGfonXgo=
=/4Tp
-----END PGP SIGNATURE-----

--y33k3lm4leglkjmq--
