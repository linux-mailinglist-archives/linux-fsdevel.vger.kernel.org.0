Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785B7ABE66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 19:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391472AbfIFROC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 13:14:02 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:62144 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731344AbfIFROB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:14:01 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2C196A1701;
        Fri,  6 Sep 2019 19:13:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id KTJPQqxl-qfv; Fri,  6 Sep 2019 19:13:54 +0200 (CEST)
Date:   Sat, 7 Sep 2019 03:13:35 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Florian Weimer <fweimer@redhat.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
Message-ID: <20190906171335.d7mc3no5tdrcn6r5@yavin.dot.cyphar.com>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ksyy7c2s2dmez4ls"
Content-Disposition: inline
In-Reply-To: <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ksyy7c2s2dmez4ls
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-06, Jeff Layton <jlayton@kernel.org> wrote:
> On Fri, 2019-09-06 at 18:06 +0200, Micka=EBl Sala=FCn wrote:
> > On 06/09/2019 17:56, Florian Weimer wrote:
> > > Let's assume I want to add support for this to the glibc dynamic load=
er,
> > > while still being able to run on older kernels.
> > >=20
> > > Is it safe to try the open call first, with O_MAYEXEC, and if that fa=
ils
> > > with EINVAL, try again without O_MAYEXEC?
> >=20
> > The kernel ignore unknown open(2) flags, so yes, it is safe even for
> > older kernel to use O_MAYEXEC.
> >=20
>=20
> Well...maybe. What about existing programs that are sending down bogus
> open flags? Once you turn this on, they may break...or provide a way to
> circumvent the protections this gives.

It should be noted that this has been a valid concern for every new O_*
flag introduced (and yet we still introduced new flags, despite the
concern) -- though to be fair, O_TMPFILE actually does have a
work-around with the O_DIRECTORY mask setup.

The openat2() set adds O_EMPTYPATH -- though in fairness it's also
backwards compatible because empty path strings have always given ENOENT
(or EINVAL?) while O_EMPTYPATH is a no-op non-empty strings.

> Maybe this should be a new flag that is only usable in the new openat2()
> syscall that's still under discussion? That syscall will enforce that
> all flags are recognized. You presumably wouldn't need the sysctl if you
> went that route too.

I'm also interested in whether we could add an UPGRADE_NOEXEC flag to
how->upgrade_mask for the openat2(2) patchset (I reserved a flag bit for
it, since I'd heard about this work through the grape-vine).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ksyy7c2s2dmez4ls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXKTvAAKCRCdlLljIbnQ
Ep42AQDi8f6e24vrdyEbKC1Hri+QQFzpcnoeEUiuXcTSgZHNWgD/eHmpIaIcPrjX
g5Pz4p5iuc67RR3OCv44VfaA+oZMjAo=
=7221
-----END PGP SIGNATURE-----

--ksyy7c2s2dmez4ls--
