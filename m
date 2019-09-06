Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1353AAC2A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 00:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405140AbfIFWoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 18:44:39 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:34998 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405124AbfIFWoi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:44:38 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2F49CA018F;
        Sat,  7 Sep 2019 00:44:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id ah2HSFJ0Uz9J; Sat,  7 Sep 2019 00:44:31 +0200 (CEST)
Date:   Sat, 7 Sep 2019 08:44:10 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Steve Grubb <sgrubb@redhat.com>,
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
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Thibaut S autereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add support for O_MAYEXEC
Message-ID: <20190906224410.lffd6l5lnm4z3hht@yavin.dot.cyphar.com>
References: <20190906152455.22757-1-mic@digikod.net>
 <2989749.1YmIBkDdQn@x2>
 <87mufhckxv.fsf@oldenburg2.str.redhat.com>
 <1802966.yheqmZt8Si@x2>
 <C95B704C-F84F-4341-BDE7-CD70C5DDBEEF@amacapital.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wklcrvy7q5jmmd7k"
Content-Disposition: inline
In-Reply-To: <C95B704C-F84F-4341-BDE7-CD70C5DDBEEF@amacapital.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wklcrvy7q5jmmd7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-06, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Sep 6, 2019, at 12:07 PM, Steve Grubb <sgrubb@redhat.com> wrote:
> >=20
> >> On Friday, September 6, 2019 2:57:00 PM EDT Florian Weimer wrote:
> >> * Steve Grubb:
> >>> Now with LD_AUDIT
> >>> $ LD_AUDIT=3D/home/sgrubb/test/openflags/strip-flags.so.0 strace ./te=
st
> >>> 2>&1 | grep passwd openat(3, "passwd", O_RDONLY)           =3D 4
> >>>=20
> >>> No O_CLOEXEC flag.
> >>=20
> >> I think you need to explain in detail why you consider this a problem.
> >=20
> > Because you can strip the O_MAYEXEC flag from being passed into the ker=
nel.=20
> > Once you do that, you defeat the security mechanism because it never ge=
ts=20
> > invoked. The issue is that the only thing that knows _why_ something is=
 being=20
> > opened is user space. With this mechanism, you can attempt to pass this=
=20
> > reason to the kernel so that it may see if policy permits this. But you=
 can=20
> > just remove the flag.
>=20
> I=E2=80=99m with Florian here. Once you are executing code in a process, =
you
> could just emulate some other unapproved code. This series is not
> intended to provide the kind of absolute protection you=E2=80=99re imagin=
ing.

I also agree, though I think that there is a separate argument to be
made that there are two possible problems with O_MAYEXEC (which might
not be really big concerns):

  * It's very footgun-prone if you didn't call O_MAYEXEC yourself and
    you pass the descriptor elsewhere. You need to check f_flags to see
    if it contains O_MAYEXEC. Maybe there is an argument to be made that
    passing O_MAYEXECs around isn't a valid use-case, but in that case
    there should be some warnings about that.

  * There's effectively a TOCTOU flaw (even if you are sure O_MAYEXEC is
    in f_flags) -- if the filesystem becomes re-mounted noexec (or the
    file has a-x permissions) after you've done the check you won't get
    hit with an error when you go to use the file descriptor later.

To fix both you'd need to do what you mention later:

> What the kernel *could* do is prevent mmapping a non-FMODE_EXEC file
> with PROT_EXEC, which would indeed have a real effect (in an iOS-like
> world, for example) but would break many, many things.

And I think this would be useful (with the two possible ways of
executing .text split into FMODE_EXEC and FMODE_MAP_EXEC, as mentioned
in a sister subthread), but would have to be opt-in for the obvious
reason you outlined. However, we could make it the default for
openat2(2) -- assuming we can agree on what the semantics of a
theoretical FMODE_EXEC should be.

And of course we'd need to do FMODE_UPGRADE_EXEC (which would need to
also permit fexecve(2) though probably not PROT_EXEC -- I don't think
you can mmap() an O_PATH descriptor).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--wklcrvy7q5jmmd7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXXLhNwAKCRCdlLljIbnQ
EqESAP4hGdjnhIiY8PqSsSWOneHYlpSs5PmQeVFEMID7L1q5eQD/VYLQV7Re28+C
Vwi3t+FOW7oGNIMCuKekC3BbxXyYGA0=
=kolV
-----END PGP SIGNATURE-----

--wklcrvy7q5jmmd7k--
