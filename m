Return-Path: <linux-fsdevel+bounces-59184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F7B35A89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 12:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3F27C024A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECDC2FDC44;
	Tue, 26 Aug 2025 10:58:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F4929D29B;
	Tue, 26 Aug 2025 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205911; cv=none; b=r532T94xeWjM8jmqeLEVdz8EP9iWiYTZHv3chozBXNb/EvZsHzgsPPZQb9WXmLvSdsiXBSCn0hNOF5+d7w58zKa8v43eUwH3XouUIT0xa0dliynuy2ZAxEb08OnpkvOmWXm5/KXbqxA5GZbhLuNXVsoHCwdW5kk9JHHRNKe1D7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205911; c=relaxed/simple;
	bh=Fb39EwM+YcEFX9FefkBqx+tAJ/PcDLAXRTmuleGUd6I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Lo2f4kinpcaBoyDrtH2YYibRNblnFxIY4uZ6V9njhxMhH0arwQFErYtLB7kp4Xvz3UcYbnihu/wuvtkir72Ci3CZ63LXuPlHwekHyC5FiFKyWo3X2+zHmdn8gfb2yFQ9QY/BG3YFD1Nt2vd9sjIg0NlwbhAgljmPZWMxw27nGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uqrNT-007F6b-D5;
	Tue, 26 Aug 2025 10:58:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Ian Kent" <raven@themaw.net>
Cc: "Askar Safin" <safinaskar@zohomail.com>,
 "autofs mailing list" <autofs@vger.kernel.org>,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "cyphar" <cyphar@cyphar.com>,
 "viro" <viro@zeniv.linux.org.uk>
Subject: Re: Serious error in autofs docs, which has design implications
In-reply-to: <56423903-7978-404e-af32-a683c9efac72@themaw.net>
References: <>, <56423903-7978-404e-af32-a683c9efac72@themaw.net>
Date: Tue, 26 Aug 2025 20:58:12 +1000
Message-id: <175620589277.2234665.6559839127267068134@noble.neil.brown.name>

On Tue, 26 Aug 2025, Ian Kent wrote:
> On 25/8/25 22:38, Askar Safin wrote:
> >   ---- On Fri, 22 Aug 2025 16:31:46 +0400  Ian Kent <raven@themaw.net> wr=
ote ---
> >   > On 21/8/25 15:53, Askar Safin wrote:
> >   > > autofs.rst says:
> >   > >> mounting onto a directory is considered to be "beyond a `stat`"
> >   > > in https://elixir.bootlin.com/linux/v6.17-rc2/source/Documentation/=
filesystems/autofs.rst#L109
> >   > >
> >   > > This is not true. Mounting does not trigger automounts.
> >   >
> >   > I don't understand that statement either, it's been many years
> >
> > Let me explain.
>=20
> I do understand what your saying but without more information about
>=20
> the meaning and intent of the text your concerned about I don't think
>=20
> anything can be done about this right now.

Yes, there is definitely something wrong there.  I'll try to work out
what I really meant to say and propose some alternate wording -
hopefully within a week or so.

Thanks for raising this Askar,

NeilBrown


>=20
>=20
> I guess that I should also apologise to you as I'm pretty sure I
>=20
> reviewed this at the time it was posted and didn't question this
>=20
> at the time. But I most likely didn't see this as a problem because,
>=20
> to my thinking, what follows explains what it's needed for rather
>=20
> than the earlier statement justifying it.
>=20
>=20
> To be clear, in my previous reply I said two things, first I also
>=20
> find the statement you are concerned about unclear, perhaps even
>=20
> misleading (but I would need to understand the statement original
>=20
> intent to interpret that, which I don't) and second, the ->d_namage()
>=20
> callback is most definitely needed for the function of the user space
>=20
> daemon, automount(8) (via the autofs file system).
>=20
>=20
> Ian
>=20
> >
> > Some syscalls follow (and trigger) automounts in last
> > component of path, and some - not.
> >
> > stat(2) is one of syscalls, which don't follow
> > automounts in last component of supplied path.
> >
> > Many other syscalls do follow automounts.
> >
> > autofs.rst calls syscalls, which follow automounts,
> > as "beyond a stat".
> >
> > Notably mount(2) doesn't follow automounts in second argument
> > (i. e. mountpoint). I know this, because I closely did read the code.
> > Also I did experiment (see source in the end of this letter).
> > Experiment was on 6.17-rc1.
> >
> > But "autofs.rst" says:
> >> mounting onto a directory is considered to be "beyond a `stat`"
> > I. e. "autofs.rst" says that mount(2) does follow automounts.
> >
> > This is wrong, as I explained above. (Again: I did experiment,
> > so I'm totally sure that this "autofs.rst" sentence is wrong.)
> >
> > Moreover, then "autofs.rst" proceeds to explain why
> > DCACHE_MANAGE_TRANSIT was introduced, based on this wrong fact.
> >
> > So it is possible that DCACHE_MANAGE_TRANSIT is in fact, not needed.
> >
> > I'm not asking for removal of DCACHE_MANAGE_TRANSIT.
> >
> > I merely point error in autofs.rst file and ask for fix.
> >
> > And if in process of fixing autofs.rst you will notice that
> > DCACHE_MANAGE_TRANSIT is indeed not needed, then,
> > of course, it should be removed.
> >
> > --
> > Askar Safin
> > https://types.pl/@safinaskar
> >
> > =3D=3D=3D=3D
> >
> > // This code is public domain
> > // You should be root in initial user namespace
> >
> > #define _GNU_SOURCE
> >
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <stdbool.h>
> > #include <string.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <sched.h>
> > #include <errno.h>
> > #include <sys/stat.h>
> > #include <sys/mount.h>
> > #include <sys/syscall.h>
> > #include <sys/vfs.h>
> > #include <sys/sysmacros.h>
> > #include <sys/statvfs.h>
> > #include <sys/wait.h>
> > #include <linux/openat2.h>
> > #include <linux/nsfs.h>
> >
> > #define MY_ASSERT(cond) do { \
> >      if (!(cond)) { \
> >          fprintf (stderr, "%d: %s: assertion failed\n", __LINE__, #cond);=
 \
> >          exit (1); \
> >      } \
> > } while (0)
> >
> > #define MY_ASSERT_ERRNO(cond) do { \
> >      if (!(cond)) { \
> >          fprintf (stderr, "%d: %s: %m\n", __LINE__, #cond); \
> >          exit (1); \
> >      } \
> > } while (0)
> >
> > static void
> > mount_debugfs (void)
> > {
> >      if (mount (NULL, "/tmp/debugfs", "debugfs", 0, NULL) !=3D 0)
> >          {
> >              perror ("mount debugfs");
> >              exit (1);
> >          }
> > }
> >
> > int
> > main (void)
> > {
> >      MY_ASSERT_ERRNO (chdir ("/") =3D=3D 0);
> >      MY_ASSERT_ERRNO (unshare (CLONE_NEWNS) =3D=3D 0);
> >      MY_ASSERT_ERRNO (mount (NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) =
=3D=3D 0);
> >      MY_ASSERT_ERRNO (mount (NULL, "/tmp", "tmpfs", 0, NULL) =3D=3D 0);
> >      MY_ASSERT_ERRNO (mkdir ("/tmp/debugfs", 0777) =3D=3D 0);
> >      mount_debugfs ();
> >      MY_ASSERT_ERRNO (mount (NULL, "/tmp/debugfs/tracing", "tmpfs", 0, NU=
LL) =3D=3D 0);
> >      execlp ("/bin/busybox", "sh", NULL);
> >      MY_ASSERT (false);
> > }
> >
>=20


