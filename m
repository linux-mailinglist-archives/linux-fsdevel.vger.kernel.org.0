Return-Path: <linux-fsdevel+bounces-15913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F7E895BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762191C22646
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B72215ADAB;
	Tue,  2 Apr 2024 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsUjwmrA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225415AD92
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082535; cv=none; b=LTIgYNnY9Sz6hd78fC2kAkgf5Hk6WhKsRjP9ZFJaBpBY2h1GrTE4boaQOoT+JooV3P/I8bBJKEIJ+laiUHLwqKdMhpz4pBI83eTmrDaQNlsX0uWHlHsvMwz+u8IFsgPywlVTcvLsVVJmnyvXNgNJT/82AC8jZ7qj95vWqSfUGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082535; c=relaxed/simple;
	bh=lstATpfOcCa5a+fTV6CKJmFj2VeD23CZW6PVljel9GI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hGDslkd9LziyQoGPLsfrW7b0ajkgl7+kw9corhFb0TvSiFurmNe5KA/yob7GgFpIKGz1V3hmSBnQq4Vq5JavIGocbC2JtdOLASVtON4c34NgYIxUreUGfBrVsR4h1XybOmVUF/UyMrHaqieanD8uhKO+GOWf8hKAL0QAJgDsHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsUjwmrA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so1062964276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712082531; x=1712687331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbplBbU+8cVHkBtvHGW7Ov7YaZs+Irra1EJLS0j44IQ=;
        b=BsUjwmrAMfmiuAXsKssVJGTasEtuXfljCLHRWv0qhe2uLavW5DC1Wm5om8fq2WP9Pw
         04VxYtu2ajgfNN0g4D9tezYVxvneexPZ3+hXcV/dwxnYlBILIf/Ln0IKwiKUB7SsWm27
         vHQwv3mcd7lKeEdwsbUaGkUv0EOm2iJJpRPSCfCS/91EZx8+77CU3ZpHcuHYXQ2OVmDF
         cfdEELVEV+aknw2+WBxSvkTrFJslvjyUk+EVWKkiJu9uOBzTqxC6oplbmKLZfKhVd5aZ
         Wj/T1K+UeWyGNiVvMsOdbEPxo1nOenAMwZc6m2tbA61KbPItU53pu+QjTq3B5FtWuAtx
         Daww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712082531; x=1712687331;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UbplBbU+8cVHkBtvHGW7Ov7YaZs+Irra1EJLS0j44IQ=;
        b=ShgQZYdbMp7zVbKqIHb1uqK1n5n2uXavpHuy/KsuEGbnivXbSgkitxMBHtrdWNpNkB
         tAQfzFWQahdpB8SvCdZtJvzx1qAneAlJYDJg0sGe+y4GDpkoyqkDB8wPNxvWdq2+rCZC
         YqvYgqOkExqLNYoijJ0WKcT7zQl7B/2q5epuAis7lULXB37HIv72mUi3l8eUs7VKsGXe
         u+mWJHPTctUMP6m5yoD2ZK6B0PZzk3hYT7X96TJxdNte9wOb0TBap+3xIJXmgvE1JPNw
         R1+gan1R7d3GS9GlyxTrpVpzU13vF3xN99mt0KX/YWJdtq25eWN79h9HI1lCZUKhGSxU
         N9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8N3XIbs5wjQ1AO3sVXPnPOmjk8wM2/MnqFVa/Zrp209thjjmGfB65DrSGzyNot79oXAT9z+kTLOb/dT/7xme4KlAElSsQQSzeTLsDfw==
X-Gm-Message-State: AOJu0YwGYXyl1Wt+eMkfvXIHsF95mcPtGo7bejMwv/Qg0kEDY84Prk8s
	v864sHmGqdi0hYH9ym5wzkx6VwULw9Ur634gUnTP6XQzUNrFIh3ERiUQgdswAbIbkf/A1yNcCqy
	ojw==
X-Google-Smtp-Source: AGHT+IFDy3aT8fsa7Yz9Qa4if7nCZjeQNs9xuiiQfUWdm2XwuAIpLRt8segsDzrLlnSX6Q7/pP4wgojjGyY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:102f:b0:dc2:2ace:860 with SMTP id
 x15-20020a056902102f00b00dc22ace0860mr1106152ybt.2.1712082531565; Tue, 02 Apr
 2024 11:28:51 -0700 (PDT)
Date: Tue, 2 Apr 2024 20:28:49 +0200
In-Reply-To: <20240327.eibaiNgu6lou@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com> <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net>
Message-ID: <ZgxOYauBXowTIgx-@google.com>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Thanks for the review!

On Wed, Mar 27, 2024 at 05:57:31PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, Mar 27, 2024 at 01:10:31PM +0000, G=C3=BCnther Noack wrote:
> > Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
> > and increments the Landlock ABI version to 5.
> >=20
> > This access right applies to device-custom IOCTL commands
> > when they are invoked on block or character device files.
> >=20
> > Like the truncate right, this right is associated with a file
> > descriptor at the time of open(2), and gets respected even when the
> > file descriptor is used outside of the thread which it was originally
> > opened in.
> >=20
> > Therefore, a newly enabled Landlock policy does not apply to file
> > descriptors which are already open.
> >=20
> > If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
> > number of safe IOCTL commands will be permitted on newly opened device
> > files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
> > as other IOCTL commands for regular files which are implemented in
> > fs/ioctl.c.
> >=20
> > Noteworthy scenarios which require special attention:
> >=20
> > TTY devices are often passed into a process from the parent process,
> > and so a newly enabled Landlock policy does not retroactively apply to
> > them automatically.  In the past, TTY devices have often supported
> > IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
> > letting callers control the TTY input buffer (and simulate
> > keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
> > modern kernels though.
> >=20
> > Known limitations:
> >=20
> > The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
> > control over IOCTL commands.
> >=20
> > Landlock users may use path-based restrictions in combination with
> > their knowledge about the file system layout to control what IOCTLs
> > can be done.
> >=20
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  include/uapi/linux/landlock.h                |  33 +++-
> >  security/landlock/fs.c                       | 183 ++++++++++++++++++-
> >  security/landlock/limits.h                   |   2 +-
> >  security/landlock/syscalls.c                 |   8 +-
> >  tools/testing/selftests/landlock/base_test.c |   2 +-
> >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> >  6 files changed, 216 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landloc=
k.h
> > index 25c8d7677539..5d90e9799eb5 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -128,7 +128,7 @@ struct landlock_net_port_attr {
> >   * files and directories.  Files or directories opened before the sand=
boxing
> >   * are not subject to these restrictions.
> >   *
> > - * A file can only receive these access rights:
> > + * The following access rights apply only to files:
> >   *
> >   * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> >   * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. No=
te that
> > @@ -138,12 +138,13 @@ struct landlock_net_port_attr {
> >   * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> >   * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`trun=
cate(2)`,
> >   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2=
)` with
> > - *   ``O_TRUNC``. Whether an opened file can be truncated with
> > - *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, =
in the
> > - *   same way as read and write permissions are checked during
> > - *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
> > - *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available si=
nce the
> > - *   third version of the Landlock ABI.
> > + *   ``O_TRUNC``.  This access right is available since the third vers=
ion of the
> > + *   Landlock ABI.
> > + *
> > + * Whether an opened file can be truncated with :manpage:`ftruncate(2)=
` or used
> > + * with `ioctl(2)` is determined during :manpage:`open(2)`, in the sam=
e way as
> > + * read and write permissions are checked during :manpage:`open(2)` us=
ing
> > + * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
> >   *
> >   * A directory can receive access rights related to files or directori=
es.  The
> >   * following access right is applied to the directory itself, and the
> > @@ -198,13 +199,28 @@ struct landlock_net_port_attr {
> >   *   If multiple requirements are not met, the ``EACCES`` error code t=
akes
> >   *   precedence over ``EXDEV``.
> >   *
> > + * The following access right applies both to files and directories:
> > + *
> > + * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` command=
s on an opened
> > + *   character or block device.
> > + *
> > + *   This access right applies to all `ioctl(2)` commands implemented =
by device
>=20
> :manpage:`ioctl(2)`
>=20
> > + *   drivers.  However, the following common IOCTL commands continue t=
o be
> > + *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
>=20
> This is good but explaining the rationale could help, something like
> this (taking care of not packing lines listing commands to ease review
> when a new command will be added):
>=20
> IOCTL commands targetting file descriptors (``FIOCLEX``, ``FIONCLEX``),
> file descriptions (``FIONBIO``, ``FIOASYNC``),
> file systems (``FIOQSIZE``, ``FS_IOC_FIEMAP``, ``FICLONE``,
> ``FICLONERAN``, ``FIDEDUPERANGE``, ``FS_IOC_GETFLAGS``,
> ``FS_IOC_SETFLAGS``, ``FS_IOC_FSGETXATTR``, ``FS_IOC_FSSETXATTR``),
> or superblocks (``FIFREEZE``, ``FITHAW``, ``FIGETBSZ``,
> ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
> are never denied.  However, such IOCTL commands still require an opened
> file and may not be available on any file type.  Read or write
> permission may be checked by the underlying implementation, as well as
> capabilities.

OK, I'll add some more explanation in the next version.


> > + *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC``, ``FIFREEZE`=
`,
> > + *   ``FITHAW``, ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYS=
FSPATH``
> > + *
> > + *   This access right is available since the fifth version of the Lan=
dlock
> > + *   ABI.
> > + *
> >   * .. warning::
> >   *
> >   *   It is currently not possible to restrict some file-related action=
s
> >   *   accessible through these syscall families: :manpage:`chdir(2)`,
> >   *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> >   *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> > - *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> > + *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
> >   *   Future Landlock evolutions will enable to restrict them.
> >   */
> >  /* clang-format off */
> > @@ -223,6 +239,7 @@ struct landlock_net_port_attr {
> >  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
> >  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> >  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
> >  /* clang-format on */
> > =20
> >  /**
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index c15559432d3d..2ef6c57fa20b 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -7,6 +7,7 @@
> >   * Copyright =C2=A9 2021-2022 Microsoft Corporation
> >   */
> > =20
> > +#include <asm/ioctls.h>
> >  #include <kunit/test.h>
> >  #include <linux/atomic.h>
> >  #include <linux/bitops.h>
> > @@ -14,6 +15,7 @@
> >  #include <linux/compiler_types.h>
> >  #include <linux/dcache.h>
> >  #include <linux/err.h>
> > +#include <linux/falloc.h>
> >  #include <linux/fs.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > @@ -29,6 +31,7 @@
> >  #include <linux/types.h>
> >  #include <linux/wait_bit.h>
> >  #include <linux/workqueue.h>
> > +#include <uapi/linux/fiemap.h>
> >  #include <uapi/linux/landlock.h>
> > =20
> >  #include "common.h"
> > @@ -84,6 +87,141 @@ static const struct landlock_object_underops landlo=
ck_fs_underops =3D {
> >  	.release =3D release_inode
> >  };
> > =20
> > +/* IOCTL helpers */
> > +
> > +/**
> > + * get_required_ioctl_dev_access(): Determine required access rights f=
or IOCTLs
> > + * on device files.
> > + *
> > + * @cmd: The IOCTL command that is supposed to be run.
> > + *
> > + * By default, any IOCTL on a device file requires the
> > + * LANDLOCK_ACCESS_FS_IOCTL_DEV right.  We make exceptions for command=
s, if:
> > + *
> > + * 1. The command is implemented in fs/ioctl.c's do_vfs_ioctl(),
> > + *    not in f_ops->unlocked_ioctl() or f_ops->compat_ioctl().
> > + *
> > + * 2. The command can be reasonably used on a device file at all.
> > + *
> > + * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_=
ioctl()
> > + * should be considered for inclusion here.
> > + *
> > + * Returns: The access rights that must be granted on an opened file i=
n order to
> > + * use the given @cmd.
> > + */
> > +static __attribute_const__ access_mask_t
> > +get_required_ioctl_dev_access(const unsigned int cmd)
> > +{
> > +	switch (cmd) {
> > +	case FIOCLEX:
> > +	case FIONCLEX:
> > +	case FIONBIO:
> > +	case FIOASYNC:
> > +		/*
> > +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> > +		 * close-on-exec and the file's buffered-IO and async flags.
> > +		 * These operations are also available through fcntl(2), and are
> > +		 * unconditionally permitted in Landlock.
> > +		 */
> > +		return 0;
> > +	case FIOQSIZE:
> > +		/*
> > +		 * FIOQSIZE queries the size of a regular file or directory.
> > +		 *
> > +		 * This IOCTL command only applies to regular files and
> > +		 * directories.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
>=20
> This should always be allowed because do_vfs_ioctl() never returns
> -ENOIOCTLCMD for this command.  That's why I wrote
> vfs_masked_device_ioctl() this way [1].  I think it would be easier to
> read and maintain this code with a is_masked_device_ioctl() logic.  Listi=
ng
> commands that are not masked makes it difficult to review because
> allowed and denied return codes are interleaved.

Oh, I misunderstood you on [2], I think -- I was under the impression that =
you
wanted to keep the switch case in the same order (and with the same entries=
?) as
the original in do_vfs_ioctl.  So you'd prefer to only list the always-allo=
wed
IOCTL commands here, as you have done in vfs_masked_device_ioctl() [3]?

[2] https://lore.kernel.org/all/20240326.ooCheem1biV2@digikod.net/
[3] https://lore.kernel.org/all/20240219183539.2926165-1-mic@digikod.net/


Can you please clarify how you make up your mind about what should be permi=
tted
and what should not?  I have trouble understanding the rationale for the ch=
anges
that you asked for below, apart from the points that they are harmless and =
that
the return codes should be consistent.

The criteria that I have used in this patch set are that (a) it is implemen=
ted
in do_vfs_ioctl() rather than further below, and (b) it makes sense to use =
that
command on a device file.  (If we permit FIOQSIZE, FS_IOC_FIEMAP and others
here, we will get slightly more correct error codes in these cases, but the
IOCTLs will still not work, because they are not useful and not implemented=
 for
devices. -- On the other hand, we are also increasing the exposed code surf=
ace a
bit.  For example, FS_IOC_FIEMAP is calling into inode->i_op->fiemap().  Th=
at is
probably harmless for device files, but requires us to reason at a deeper l=
evel
to convince ourselves of that.)

In your implementation at [3], you were permitting FICLONE* and FIDEDUPERAN=
GE,
but not FS_IOC_ZERO_RANGE, which is like fallocate().  How are these cases
different to each other?  Is that on purpose?


> [1] https://lore.kernel.org/r/20240219183539.2926165-1-mic@digikod.net
>=20
> Your IOCTL command explanation comments are nice and they should be kept
> in is_masked_device_ioctl() (if they mask device IOCTL commands).

OK

>=20
> > +	case FIFREEZE:
> > +	case FITHAW:
> > +		/*
> > +		 * FIFREEZE and FITHAW freeze and thaw the file system which the
> > +		 * given file belongs to.  Requires CAP_SYS_ADMIN.
> > +		 *
> > +		 * These commands operate on the file system's superblock rather
> > +		 * than on the file itself.  The same operations can also be
> > +		 * done through any other file or directory on the same file
> > +		 * system, so it is safe to permit these.
> > +		 */
> > +		return 0;
> > +	case FS_IOC_FIEMAP:
> > +		/*
> > +		 * FS_IOC_FIEMAP queries information about the allocation of
> > +		 * blocks within a file.
> > +		 *
> > +		 * This IOCTL command only applies to regular files.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
>=20
> Same here.
>=20
> > +	case FIGETBSZ:
> > +		/*
> > +		 * FIGETBSZ queries the file system's block size for a file or
> > +		 * directory.
> > +		 *
> > +		 * This command operates on the file system's superblock rather
> > +		 * than on the file itself.  The same operation can also be done
> > +		 * through any other file or directory on the same file system,
> > +		 * so it is safe to permit it.
> > +		 */
> > +		return 0;
> > +	case FICLONE:
> > +	case FICLONERANGE:
> > +	case FIDEDUPERANGE:
> > +		/*
> > +		 * FICLONE, FICLONERANGE and FIDEDUPERANGE make files share
> > +		 * their underlying storage ("reflink") between source and
> > +		 * destination FDs, on file systems which support that.
> > +		 *
> > +		 * These IOCTL commands only apply to regular files.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
>=20
> ditto
>=20
> > +	case FIONREAD:
> > +		/*
> > +		 * FIONREAD returns the number of bytes available for reading.
> > +		 *
> > +		 * We require LANDLOCK_ACCESS_FS_IOCTL_DEV for FIONREAD, because
> > +		 * devices implement it in f_ops->unlocked_ioctl().  The
> > +		 * implementations of this operation have varying quality and
> > +		 * complexity, so it is hard to reason about what they do.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > +	case FS_IOC_GETFLAGS:
> > +	case FS_IOC_SETFLAGS:
> > +	case FS_IOC_FSGETXATTR:
> > +	case FS_IOC_FSSETXATTR:
> > +		/*
> > +		 * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
> > +		 * FS_IOC_FSSETXATTR do not apply for devices.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > +	case FS_IOC_GETFSUUID:
> > +	case FS_IOC_GETFSSYSFSPATH:
> > +		/*
> > +		 * FS_IOC_GETFSUUID and FS_IOC_GETFSSYSFSPATH both operate on
> > +		 * the file system superblock, not on the specific file, so
> > +		 * these operations are available through any other file on the
> > +		 * same file system as well.
> > +		 */
> > +		return 0;
> > +	case FIBMAP:
> > +	case FS_IOC_RESVSP:
> > +	case FS_IOC_RESVSP64:
> > +	case FS_IOC_UNRESVSP:
> > +	case FS_IOC_UNRESVSP64:
> > +	case FS_IOC_ZERO_RANGE:
> > +		/*
> > +		 * FIBMAP, FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP,
> > +		 * FS_IOC_UNRESVSP64 and FS_IOC_ZERO_RANGE only apply to regular
> > +		 * files (as implemented in file_ioctl()).
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > +	default:
> > +		/*
> > +		 * Other commands are guarded by the catch-all access right.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > +	}
> > +}
> > +
> >  /* Ruleset management */
> > =20
> >  static struct landlock_object *get_inode_object(struct inode *const in=
ode)
> > @@ -148,7 +286,8 @@ static struct landlock_object *get_inode_object(str=
uct inode *const inode)
> >  	LANDLOCK_ACCESS_FS_EXECUTE | \
> >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > +	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> >  /* clang-format on */
> > =20
> >  /*
> > @@ -1335,8 +1474,10 @@ static int hook_file_alloc_security(struct file =
*const file)
> >  static int hook_file_open(struct file *const file)
> >  {
> >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> > -	access_mask_t open_access_request, full_access_request, allowed_acces=
s;
> > -	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	access_mask_t open_access_request, full_access_request, allowed_acces=
s,
> > +		optional_access;
> > +	const struct inode *inode =3D file_inode(file);
> > +	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_m=
ode);
> >  	const struct landlock_ruleset *const dom =3D
> >  		get_fs_domain(landlock_cred(file->f_cred)->domain);
> > =20
> > @@ -1354,6 +1495,10 @@ static int hook_file_open(struct file *const fil=
e)
> >  	 * We look up more access than what we immediately need for open(), s=
o
> >  	 * that we can later authorize operations on opened files.
> >  	 */
> > +	optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	if (is_device)
> > +		optional_access |=3D LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > +
> >  	full_access_request =3D open_access_request | optional_access;
> > =20
> >  	if (is_access_to_paths_allowed(
> > @@ -1410,6 +1555,36 @@ static int hook_file_truncate(struct file *const=
 file)
> >  	return -EACCES;
> >  }
> > =20
> > +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> > +			   unsigned long arg)
> > +{
> > +	const struct inode *inode =3D file_inode(file);
> > +	const bool is_device =3D S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_m=
ode);
> > +	access_mask_t required_access, allowed_access;
>=20
> As explained in [2], I'd like not-sandboxed tasks to not have visible
> performance impact because of Landlock:
>=20
>   We should first check landlock_file(file)->allowed_access as in
>   hook_file_truncate() to return as soon as possible for non-sandboxed
>   tasks.  Any other computation should be done after that (e.g. with an
>   is_device() helper).
>=20
> [2] https://lore.kernel.org/r/20240311.If7ieshaegu2@digikod.net
>=20
> This is_device(file) helper should also replace other is_device variables=
.

Done.

FWIW, I have doubts that it makes a performance difference - the is_device(=
)
check is almost for free as well.  But we can pull the same check earlier f=
or
consistency with the truncate hook, if it helps people to understand that t=
heir
own program performance should be unaffected.

>=20
>=20
> > +
> > +	if (!is_device)
> > +		return 0;
> > +
> > +	/*
> > +	 * It is the access rights at the time of opening the file which
> > +	 * determine whether IOCTL can be used on the opened file later.
> > +	 *
> > +	 * The access right is attached to the opened file in hook_file_open(=
).
> > +	 */
> > +	required_access =3D get_required_ioctl_dev_access(cmd);
> > +	allowed_access =3D landlock_file(file)->allowed_access;
> > +	if ((allowed_access & required_access) =3D=3D required_access)
> > +		return 0;
> > +
> > +	return -EACCES;
> > +}
> > +
> > +static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
> > +				  unsigned long arg)
> > +{
> > +	return hook_file_ioctl(file, cmd, arg);
>=20
> The compat-specific IOCTL commands are missing (e.g. FS_IOC_RESVSP_32).
> Relying on is_masked_device_ioctl() should make this call OK though.

OK, I'll try to replicate the logic from your vfs_masked_device_ioctl() app=
roach
then?

=E2=80=94G=C3=BCnther

