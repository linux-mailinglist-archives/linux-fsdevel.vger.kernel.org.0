Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05811BEDEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 03:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD3By6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 21:54:58 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:64626 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD3By6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:54:58 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 49CJNb3n0DzKmWf;
        Thu, 30 Apr 2020 03:54:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id QqYb_XfmfTzI; Thu, 30 Apr 2020 03:54:50 +0200 (CEST)
Date:   Thu, 30 Apr 2020 11:54:29 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
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
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
Message-ID: <20200430015429.wuob7m5ofdewubui@yavin.dot.cyphar.com>
References: <20200428175129.634352-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="udruashf3djnhxyp"
Content-Disposition: inline
In-Reply-To: <20200428175129.634352-1-mic@digikod.net>
X-Rspamd-Queue-Id: 185431774
X-Rspamd-Score: -5.53 / 15.00 / 15.00
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--udruashf3djnhxyp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-28, Micka=EBl Sala=FCn <mic@digikod.net> wrote:
> The goal of this patch series is to enable to control script execution
> with interpreters help.  A new RESOLVE_MAYEXEC flag, usable through
> openat2(2), is added to enable userspace script interpreter to delegate
> to the kernel (and thus the system security policy) the permission to
> interpret/execute scripts or other files containing what can be seen as
> commands.
>=20
> This third patch series mainly differ from the previous one by relying
> on the new openat2(2) system call to get rid of the undefined behavior
> of the open(2) flags.  Thus, the previous O_MAYEXEC flag is now replaced
> with the new RESOLVE_MAYEXEC flag and benefits from the openat2(2)
> strict check of this kind of flags.

My only strong upfront objection is with this being a RESOLVE_ flag.

RESOLVE_ flags have a specific meaning (they generally apply to all
components, and affect the rules of path resolution). RESOLVE_MAYEXEC
does neither of these things and so seems out of place among the other
RESOLVE_ flags.

I would argue this should be an O_ flag, but not supported for the
old-style open(2). This is what the O_SPECIFIC_FD patchset does[1] and I
think it's a reasonable way of solving such problems.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--udruashf3djnhxyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXqov0QAKCRCdlLljIbnQ
Es1XAP4pdpkX/auZ9BMKqDz4Q71lNx9hZ2pPWO2GKtz3HxWg3QD/d346yEY1nSmz
4QrB06Se4f0JFMG5Fy1QoGIpSoBx+Qk=
=DOB3
-----END PGP SIGNATURE-----

--udruashf3djnhxyp--
