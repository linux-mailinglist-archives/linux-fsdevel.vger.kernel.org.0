Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8230EABE4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395130AbfIFRIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 13:08:17 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:38946 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfIFRIQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:08:16 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id BE83CA10B1;
        Fri,  6 Sep 2019 19:08:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id LZRQmSkyiH7U; Fri,  6 Sep 2019 19:08:06 +0200 (CEST)
Date:   Sat, 7 Sep 2019 03:07:39 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>
Cc:     Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <20190906170739.kk3opr2phidb7ilb@yavin.dot.cyphar.com>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6rtmfi5hsevxvupm"
Content-Disposition: inline
In-Reply-To: <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6rtmfi5hsevxvupm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-06, Micka=EBl Sala=FCn <mickael.salaun@ssi.gouv.fr> wrote:
>=20
> On 06/09/2019 17:56, Florian Weimer wrote:
> > Let's assume I want to add support for this to the glibc dynamic loader,
> > while still being able to run on older kernels.
> >
> > Is it safe to try the open call first, with O_MAYEXEC, and if that fails
> > with EINVAL, try again without O_MAYEXEC?
>=20
> The kernel ignore unknown open(2) flags, so yes, it is safe even for
> older kernel to use O_MAYEXEC.

Depends on your definition of "safe" -- a security feature that you will
silently not enable on older kernels doesn't sound super safe to me.
Unfortunately this is a limitation of open(2) that we cannot change --
which is why the openat2(2) proposal I've been posting gives -EINVAL for
unknown O_* flags.

There is a way to probe for support (though unpleasant), by creating a
test O_MAYEXEC fd and then checking if the flag is present in
/proc/self/fdinfo/$n.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6rtmfi5hsevxvupm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXKSVwAKCRCdlLljIbnQ
EqsMAQCcsnT73iJu8qsLaNqcZ8fDsRQoivoCCPz1rmApirVAJwD8Dykhs9u7hP9n
7SbkdjKA/jSU4Chb/m54X97YQPGbcAU=
=hMDq
-----END PGP SIGNATURE-----

--6rtmfi5hsevxvupm--
