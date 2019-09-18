Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C4EB6508
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 15:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfIRNvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 09:51:23 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:21992 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfIRNvV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:51:21 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 4C49450BA7;
        Wed, 18 Sep 2019 15:51:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id LF0_75sV9oFp; Wed, 18 Sep 2019 15:51:08 +0200 (CEST)
Date:   Wed, 18 Sep 2019 15:51:00 +0200
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-alpha@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v12 05/12] namei: obey trailing magic-link DAC permissions
Message-ID: <20190918135100.sdxdmdluq6wlwryv@yavin.microfocus.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-6-cyphar@cyphar.com>
 <CAG48ez1_64249RdX6Nj_32YS+jhuXZBAd_ZL9ozggbSQy+cc-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gouyu6bptahztw3s"
Content-Disposition: inline
In-Reply-To: <CAG48ez1_64249RdX6Nj_32YS+jhuXZBAd_ZL9ozggbSQy+cc-A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gouyu6bptahztw3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-17, Jann Horn <jannh@google.com> wrote:
> On Wed, Sep 4, 2019 at 10:21 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > The ability for userspace to "re-open" file descriptors through
> > /proc/self/fd has been a very useful tool for all sorts of usecases
> > (container runtimes are one common example). However, the current
> > interface for doing this has resulted in some pretty subtle security
> > holes. Userspace can re-open a file descriptor with more permissions
> > than the original, which can result in cases such as /proc/$pid/exe
> > being re-opened O_RDWR at a later date even though (by definition)
> > /proc/$pid/exe cannot be opened for writing. When combined with O_PATH
> > the results can get even more confusing.
> [...]
> > Instead we have to restrict it in such a way that it doesn't break
> > (good) users but does block potential attackers. The solution applied in
> > this patch is to restrict *re-opening* (not resolution through)
> > magic-links by requiring that mode of the link be obeyed. Normal
> > symlinks have modes of a+rwx but magic-links have other modes. These
> > magic-link modes were historically ignored during path resolution, but
> > they've now been re-purposed for more useful ends.
>=20
> Thanks for dealing with this issue!
>=20
> [...]
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 209c51a5226c..54d57dad0f91 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -872,7 +872,7 @@ void nd_jump_link(struct path *path)
> >
> >         nd->path =3D *path;
> >         nd->inode =3D nd->path.dentry->d_inode;
> > -       nd->flags |=3D LOOKUP_JUMPED;
> > +       nd->flags |=3D LOOKUP_JUMPED | LOOKUP_MAGICLINK_JUMPED;
> >  }
> [...]
> > +static int trailing_magiclink(struct nameidata *nd, int acc_mode,
> > +                             fmode_t *opath_mask)
> > +{
> > +       struct inode *inode =3D nd->link_inode;
> > +       fmode_t upgrade_mask =3D 0;
> > +
> > +       /* Was the trailing_symlink() a magic-link? */
> > +       if (!(nd->flags & LOOKUP_MAGICLINK_JUMPED))
> > +               return 0;
> > +
> > +       /*
> > +        * Figure out the upgrade-mask of the link_inode. Since these a=
ren't
> > +        * strictly POSIX semantics we don't do an acl_permission_check=
() here,
> > +        * so we only care that at least one bit is set for each upgrad=
e-mode.
> > +        */
> > +       if (inode->i_mode & S_IRUGO)
> > +               upgrade_mask |=3D FMODE_PATH_READ;
> > +       if (inode->i_mode & S_IWUGO)
> > +               upgrade_mask |=3D FMODE_PATH_WRITE;
> > +       /* Restrict the O_PATH upgrade-mask of the caller. */
> > +       if (opath_mask)
> > +               *opath_mask &=3D upgrade_mask;
> > +       return may_open_magiclink(upgrade_mask, acc_mode);
> >  }
>=20
> This looks racy because entries in the file descriptor table can be
> switched out as long as task->files->file_lock isn't held. Unless I'm
> missing something, something like the following (untested) would
> bypass this restriction:

You're absolutely right -- good catch!

> Perhaps you could change nd_jump_link() to "void nd_jump_link(struct
> path *path, umode_t link_mode)", and let proc_pid_get_link() pass the
> link_mode through from an out-argument of .proc_get_link()? Then
> proc_fd_link() could grab the proper mode in a race-free manner. And
> nd_jump_link() could stash the mode in the nameidata.

This indeed does appear to be the simplest solution -- I'm currently
testing a variation of the patch you proposed (with a few extra bits to
deal with nd_jump_link and proc_get_link being used elsewhere).

I'll include this change (assuming it fixes the flaw you found) in the
v13 series I'll send around next week. Thanks, Jann!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--gouyu6bptahztw3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXYI2QQAKCRCdlLljIbnQ
EmFyAQDaPj8ZCZBcO2zL0gyE8hzxrvDfq7RVsdmeagxmIbg+wQD+JIZBdpjvnXYQ
ZNsb7Dh/C5zkird/0LE1VGr7KfjKnQU=
=4db+
-----END PGP SIGNATURE-----

--gouyu6bptahztw3s--
