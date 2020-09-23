Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E3275304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWIOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 04:14:30 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41656 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWIOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:14:30 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4B82D1C0BB9; Wed, 23 Sep 2020 10:14:27 +0200 (CEST)
Date:   Wed, 23 Sep 2020 10:14:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     madvenka@linux.microsoft.com
Cc:     kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        fweimer@redhat.com, mark.rutland@arm.com, mic@digikod.net
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
Message-ID: <20200923081426.GA30279@amd>
References: <210d7cd762d5307c2aa1676705b392bd445f1baa>
 <20200922215326.4603-1-madvenka@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20200922215326.4603-1-madvenka@linux.microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Dynamic code is used in many different user applications. Dynamic code is
> often generated at runtime. Dynamic code can also just be a pre-defined
> sequence of machine instructions in a data buffer. Examples of dynamic
> code are trampolines, JIT code, DBT code, etc.
>=20
> Dynamic code is placed either in a data page or in a stack page. In order
> to execute dynamic code, the page it resides in needs to be mapped with
> execute permissions. Writable pages with execute permissions provide an
> attack surface for hackers. Attackers can use this to inject malicious
> code, modify existing code or do other harm.
>=20
> To mitigate this, LSMs such as SELinux implement W^X. That is, they may n=
ot
> allow pages to have both write and execute permissions. This prevents
> dynamic code from executing and blocks applications that use it. To allow
> genuine applications to run, exceptions have to be made for them (by sett=
ing
> execmem, etc) which opens the door to security issues.
>=20
> The W^X implementation today is not complete. There exist many user level
> tricks that can be used to load and execute dynamic code. E.g.,
>=20
> - Load the code into a file and map the file with R-X.
>=20
> - Load the code in an RW- page. Change the permissions to R--. Then,
>   change the permissions to R-X.
>=20
> - Load the code in an RW- page. Remap the page with R-X to get a separate
>   mapping to the same underlying physical page.
>=20
> IMO, these are all security holes as an attacker can exploit them to inje=
ct
> his own code.

IMO, you are smoking crack^H^H very seriously misunderstanding what
W^X is supposed to protect from.

W^X is not supposed to protect you from attackers that can already do
system calls. So loading code into a file then mapping the file as R-X
is in no way security hole in W^X.

If you want to provide protection from attackers that _can_ do system
calls, fine, but please don't talk about W^X and please specify what
types of attacks you want to prevent and why that's good thing.

Hint: attacker that can "Load the code into a file and map the file
with R-X." can probably also load the code into /foo and
os.system("/usr/bin/python /foo").

This is not first crazy patch from your company. Perhaps you should
have a person with strong Unix/Linux experience performing "straight
face test" on outgoing patches?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9rA+IACgkQMOfwapXb+vLeswCgxLsVovoEu7Zr4CWuzSbUatKX
B5wAnRA2x52GHgeeAkFmdWf8Tz3etxRA
=lIi4
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
