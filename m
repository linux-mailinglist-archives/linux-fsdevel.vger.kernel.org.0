Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0852C6A385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 10:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfGPIEG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 04:04:06 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:35732 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfGPIEF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:04:05 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 65FB4506CB;
        Tue, 16 Jul 2019 10:03:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id FP9J3tccLygu; Tue, 16 Jul 2019 10:03:51 +0200 (CEST)
Date:   Tue, 16 Jul 2019 18:03:38 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org,
        rgb@redhat.com, paul@paul-moore.com, raven@themaw.net,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v9 05/10] namei: O_BENEATH-style path resolution flags
Message-ID: <20190716080338.al4cnwdfvdbpzh3r@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-6-cyphar@cyphar.com>
 <20190712043341.GI17978@ZenIV.linux.org.uk>
 <20190712105745.nruaftgeat6irhzr@yavin>
 <20190712123924.GK17978@ZenIV.linux.org.uk>
 <20190712125552.GL17978@ZenIV.linux.org.uk>
 <20190712132553.GN17978@ZenIV.linux.org.uk>
 <20190712150026.GO17978@ZenIV.linux.org.uk>
 <20190713024153.GA3817@ZenIV.linux.org.uk>
 <20190714035826.GQ17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lshvdcpckvdb4crm"
Content-Disposition: inline
In-Reply-To: <20190714035826.GQ17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lshvdcpckvdb4crm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-14, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Jul 13, 2019 at 03:41:53AM +0100, Al Viro wrote:
> > On Fri, Jul 12, 2019 at 04:00:26PM +0100, Al Viro wrote:
> > > On Fri, Jul 12, 2019 at 02:25:53PM +0100, Al Viro wrote:
> > >=20
> > > > 	if (flags & LOOKUP_BENEATH) {
> > > > 		nd->root =3D nd->path;
> > > > 		if (!(flags & LOOKUP_RCU))
> > > > 			path_get(&nd->root);
> > > > 		else
> > > > 			nd->root_seq =3D nd->seq;
> > >=20
> > > BTW, this assignment is needed for LOOKUP_RCU case.  Without it
> > > you are pretty much guaranteed that lazy pathwalk will fail,
> > > when it comes to complete_walk().
> > >=20
> > > Speaking of which, what would happen if LOOKUP_ROOT/LOOKUP_BENEATH
> > > combination would someday get passed?
> >=20
> > I don't understand what's going on with ->r_seq in there - your
> > call of path_is_under() is after having (re-)sampled rename_lock,
> > but if that was the only .. in there, who's going to recheck
> > the value?  For that matter, what's to guarantee that the thing
> > won't get moved just as you are returning from handle_dots()?
> >=20
> > IOW, what does LOOKUP_IN_ROOT guarantee for caller (openat2())?
>=20
> Sigh...  Usual effects of trying to document things:
>=20
> 1) LOOKUP_NO_EVAL looks bogus.  It had been introduced by commit 57d46577=
16ac
> (audit: ignore fcaps on umount) and AFAICS it's crap.  It is set in
> ksys_umount() and nowhere else.  It's ignored by everything except
> filename_mountpoint().  The thing is, call graph for filename_mountpoint()
> is
> 	filename_mountpoint()
> 		<- user_path_mountpoint_at()
> 			<- ksys_umount()
> 		<- kern_path_mountpoint()
> 			<- autofs_dev_ioctl_ismountpoint()
> 			<- find_autofs_mount()
> 				<- autofs_dev_ioctl_open_mountpoint()
> 				<- autofs_dev_ioctl_requester()
> 				<- autofs_dev_ioctl_ismountpoint()
> In other words, that flag is basically "was filename_mountpoint()
> been called by umount(2) or has it come from an autofs ioctl?".
> And looking at the rationale in that commit, autofs ioctls need
> it just as much as umount(2) does.  Why is it not set for those
> as well?  And why is it conditional at all?

In addition, LOOKUP_NO_EVAL =3D=3D LOOKUP_OPEN (0x100). Is that meant to be
the case? Also I just saw you have a patch in work.namei that fixes this
up -- do you want me to rebase on top of that?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--lshvdcpckvdb4crm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXS2E1wAKCRCdlLljIbnQ
EvUWAP4hDKNKmCaghR/nSF7B9A3mjchQtut9n7vItMKjRPJjLAD9GRABOJCnZ47q
TqUSuZfxKfq260PQMTx91hQd/K+//QE=
=XoHc
-----END PGP SIGNATURE-----

--lshvdcpckvdb4crm--
