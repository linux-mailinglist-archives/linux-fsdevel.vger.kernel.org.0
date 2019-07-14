Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2004367DFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 09:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfGNHLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 03:11:48 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:26500 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbfGNHLr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 03:11:47 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id E49974EC6D;
        Sun, 14 Jul 2019 09:11:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id so9n73IONPC7; Sun, 14 Jul 2019 09:11:17 +0200 (CEST)
Date:   Sun, 14 Jul 2019 17:11:02 +1000
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
Message-ID: <20190714071102.gsc3kqpakz7chqt6@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-2-cyphar@cyphar.com>
 <20190712041454.GG17978@ZenIV.linux.org.uk>
 <20190712122017.xkowq2cjreylpotm@yavin>
 <20190712131005.GM17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gghwwblfl4frle37"
Content-Disposition: inline
In-Reply-To: <20190712131005.GM17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gghwwblfl4frle37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jul 12, 2019 at 10:20:17PM +1000, Aleksa Sarai wrote:
> > On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Sun, Jul 07, 2019 at 12:57:28AM +1000, Aleksa Sarai wrote:
> > > > @@ -514,7 +516,14 @@ static void set_nameidata(struct nameidata *p,=
 int dfd, struct filename *name)
> > > >  	p->stack =3D p->internal;
> > > >  	p->dfd =3D dfd;
> > > >  	p->name =3D name;
> > > > -	p->total_link_count =3D old ? old->total_link_count : 0;
> > > > +	p->total_link_count =3D 0;
> > > > +	p->acc_mode =3D 0;
> > > > +	p->opath_mask =3D FMODE_PATH_READ | FMODE_PATH_WRITE;
> > > > +	if (old) {
> > > > +		p->total_link_count =3D old->total_link_count;
> > > > +		p->acc_mode =3D old->acc_mode;
> > > > +		p->opath_mask =3D old->opath_mask;
> > > > +	}
> > >=20
> > > Huh?  Could somebody explain why traversals of NFS4 referrals should =
inherit
> > > ->acc_mode and ->opath_mask?
> >=20
> > I'll be honest -- I don't understand what set_nameidata() did so I just
> > did what I thought would be an obvious change (to just copy the
> > contents). I thought it was related to some aspect of the symlink stack
> > handling.
>=20
> No.  It's handling of (very rare) nested pathwalk.  The only case I can t=
hink
> of is handling of NFS4 referrals - they are triggered by ->d_automount()
> and include NFS4 mount.  Which does internal pathwalk of its own, to get
> to the root of subtree being automounted.
>=20
> NFS has its own recursion protection on that path (no deeper nesting than
> one level of referral traversals), but there some nesting is inevitable;
> we do get another nameidata instance on stack.  And for nd_jump_link() we
> need to keep track of the innermost one.
>=20
> For symlinks nothing of that sort happens - they are dealt with on the sa=
me
> struct nameidata.  ->total_link_count copying is there for one reason onl=
y -
> we want the total amount of symlinks traversed during the pathwalk (inclu=
ding
> the referral processing, etc.) to count towards MAXSYMLINKS check.  It co=
uld've
> been moved from nameidata to task_struct, but it's cheaper to handle it t=
hat
> way.
>=20
> Again, nesting is *rare*.

Thanks for the explanation, much appreciated. I will drop the old->...
copying hunk.

> > In that case, should they both be set to 0 on set_nameidata()? This will
> > mean that fd re-opening (or magic-link opening) through a
> > set_nameidata() would always fail.
>=20
> Huh?  set_nameidata() is done for *all* instances - it's pretty much the
> constructor of that object (and restore_nameidata() - a destructor).
> Everything goes through it.

Sorry, I meant to drop the copy-from-old logic -- not set it to zero
explicitly in set_nameidata().

> And again, I'm not sure we want these fields in nameidata - IMO they belo=
ng
> in open_flags.  Things like e.g. stat() don't need them at all.

Yup, I'll work up a version that does the consolidation you mentioned
in your other mail.

> Incidentally, O_PATH opening of symlinks combined with subsequent procfs
> symlink traversals is worth testing - that's where the things get subtle
> and that's where it's easy to get in trouble on modifications.

I have some self-tests of a symlink-to-a-magic-link in the last patch of
the series. Did you mean something even more chained like a symlink to a
/proc/self/fd/$n of an O_NOFOLLOW|O_PATH of a symlink?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--gghwwblfl4frle37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXSrVgAAKCRCdlLljIbnQ
EupPAQDpi9m99/xBGy4or9AS/LoRkr4tSLDlWlOsdCn0tZ52WAEAqoZwgZWyT46F
mjKoRQeNjgtDk5jRNWbrwkJAMPXy2AE=
=GnH+
-----END PGP SIGNATURE-----

--gghwwblfl4frle37--
