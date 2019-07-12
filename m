Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E1666EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 14:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfGLMUm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 08:20:42 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:28646 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfGLMUl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:41 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2AA0EA217D;
        Fri, 12 Jul 2019 14:20:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id Fg_RUaFCSZVH; Fri, 12 Jul 2019 14:20:26 +0200 (CEST)
Date:   Fri, 12 Jul 2019 22:20:17 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
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
Subject: Re: [PATCH v9 01/10] namei: obey trailing magic-link DAC permissions
Message-ID: <20190712122017.xkowq2cjreylpotm@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-2-cyphar@cyphar.com>
 <20190712041454.GG17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhpexfjxcruxolbk"
Content-Disposition: inline
In-Reply-To: <20190712041454.GG17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zhpexfjxcruxolbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Jul 07, 2019 at 12:57:28AM +1000, Aleksa Sarai wrote:
> > @@ -514,7 +516,14 @@ static void set_nameidata(struct nameidata *p, int=
 dfd, struct filename *name)
> >  	p->stack =3D p->internal;
> >  	p->dfd =3D dfd;
> >  	p->name =3D name;
> > -	p->total_link_count =3D old ? old->total_link_count : 0;
> > +	p->total_link_count =3D 0;
> > +	p->acc_mode =3D 0;
> > +	p->opath_mask =3D FMODE_PATH_READ | FMODE_PATH_WRITE;
> > +	if (old) {
> > +		p->total_link_count =3D old->total_link_count;
> > +		p->acc_mode =3D old->acc_mode;
> > +		p->opath_mask =3D old->opath_mask;
> > +	}
>=20
> Huh?  Could somebody explain why traversals of NFS4 referrals should inhe=
rit
> ->acc_mode and ->opath_mask?

I'll be honest -- I don't understand what set_nameidata() did so I just
did what I thought would be an obvious change (to just copy the
contents). I thought it was related to some aspect of the symlink stack
handling.

In that case, should they both be set to 0 on set_nameidata()? This will
mean that fd re-opening (or magic-link opening) through a
set_nameidata() would always fail.

> >  static __always_inline
> > -const char *get_link(struct nameidata *nd)
> > +const char *get_link(struct nameidata *nd, bool trailing)
> >  {
> >  	struct saved *last =3D nd->stack + nd->depth - 1;
> >  	struct dentry *dentry =3D last->link.dentry;
> > @@ -1081,6 +1134,44 @@ const char *get_link(struct nameidata *nd)
> >  		} else {
> >  			res =3D get(dentry, inode, &last->done);
> >  		}
> > +		/* If we just jumped it was because of a magic-link. */
> > +		if (unlikely(nd->flags & LOOKUP_JUMPED)) {
> [...]
> In any case, this "bool trailing" is completely wrong; whether that
> check belongs in trailing_symlink() or (some of) its callers, putting
> it into get_link() is a mistake, forced by kludgy check for procfs-style
> symlinks.

The error path for LOOKUP_JUMPED comes from the old O_BENEATH patchset,
but all of the "bool trailing" logic is definitely my gaff (I was
quietly hoping you'd have a much better solution than the whole
get_link() thing -- it definitely felt very kludgey to write).

I will work on the suggestion in your follow-up email. Thanks!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--zhpexfjxcruxolbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXSh6/QAKCRCdlLljIbnQ
EjDMAQCLRtfrI0y8gA2T7fw18G0cU799E+TMMczEIjU79f+8jQD/UcfSgUsZT0h6
7dVpliYNzOl4Uou0Y4Kln5It6iq5aAc=
=74oH
-----END PGP SIGNATURE-----

--zhpexfjxcruxolbk--
