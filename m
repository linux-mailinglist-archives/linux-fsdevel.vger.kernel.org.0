Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7166C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfGLMNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 08:13:00 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:49784 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfGLMNA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:13:00 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id F1641A117C;
        Fri, 12 Jul 2019 14:12:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id P6ek3O6D-xUo; Fri, 12 Jul 2019 14:12:48 +0200 (CEST)
Date:   Fri, 12 Jul 2019 22:12:01 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 04/10] namei: split out nd->dfd handling to
 dirfd_path_init
Message-ID: <20190712121201.ouhwqgeszfq44t33@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-5-cyphar@cyphar.com>
 <20190712042050.GH17978@ZenIV.linux.org.uk>
 <20190712120743.mka3vl5t4zndc5wj@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="37fzaqczvbcmjfqh"
Content-Disposition: inline
In-Reply-To: <20190712120743.mka3vl5t4zndc5wj@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--37fzaqczvbcmjfqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-12, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Sun, Jul 07, 2019 at 12:57:31AM +1000, Aleksa Sarai wrote:
> > > Previously, path_init's handling of *at(dfd, ...) was only done once,
> > > but with LOOKUP_BENEATH (and LOOKUP_IN_ROOT) we have to parse the
> > > initial nd->path at different times (before or after absolute path
> > > handling) depending on whether we have been asked to scope resolution
> > > within a root.
> >=20
> > >  	if (*s =3D=3D '/') {
> > > -		set_root(nd);
> > > -		if (likely(!nd_jump_root(nd)))
> > > -			return s;
> > > -		return ERR_PTR(-ECHILD);
> >=20
> > > +		if (likely(!nd->root.mnt))
> > > +			set_root(nd);
> >=20
> > How can we get there with non-NULL nd->root.mnt, when LOOKUP_ROOT case
> > has been already handled by that point?
>=20
> Yup, you're completely right. I will remove the
>   if (!nd->root.mnt)
> in the next version.

Ah sorry, there is a reason for it -- later in the series the
LOOKUP_BENEATH case means that you might end up with a non-NULL
nd->root.mnt. If you want, I can move the addition of the conditional to
later in the series (it was easier to split the patch by-hunk back when
you originally asked me to split out dirfd_path_init()).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--37fzaqczvbcmjfqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXSh5DgAKCRCdlLljIbnQ
EktsAQC+xy1gwgzkK07JhvJgn8Q1pT79AOQ14p3p2Zp9thYafQD9FEgBMo7bE+TU
IjLN9tnpuJF+ybsPFaA/VNK4FHH0igw=
=ZC2p
-----END PGP SIGNATURE-----

--37fzaqczvbcmjfqh--
