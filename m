Return-Path: <linux-fsdevel+bounces-9556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9823F842B82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 19:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA3E28D1EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6D1552EC;
	Tue, 30 Jan 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hG3RSzdF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA81552E0
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638419; cv=none; b=hXwX2iulGFEPSULnRSfcSBD2Pnxj5z+0nC03IN8CXo7wHiL9JCj3qcellya+Iq05VPOOZogt2MuZ/EA+Ce5Kx50fLxp2P3IATW9L/2v2fBKl49FzNZdOZbxQ12PJbMLIxEsHyOscM4uUH1NohLZ2uE3EMeBLeQnAxN8RBpedMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638419; c=relaxed/simple;
	bh=/z7BR8Rzl5DZQHPUUUDyx3C6bEae+HgMrVYhtyI0DgY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=IFkmOisJRB6xvVpTTUZNRO9M91hz3F/1xAieVgGpaxZagtnEZo5R/GRmyXsRL5UTfewhxeAzozhrHrKOd0wG9O7tShZgu6h9SwMBvDTdoOV6Nd5QYvGFelS0auO8ajLHt2Qy5jTgCdNpEXO9gwS4bdGwd2LdvFJVOi4pxgvwcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hG3RSzdF; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a2bffe437b5so269443366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 10:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706638415; x=1707243215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0ZLPXDHZdvlcgoUgP3zTmdcvq6qvkA0S2upwL/CUtg=;
        b=hG3RSzdFk4r02o8406vAI806fTEVD2puXgz+9C8vQnOp788GsCW2+hkJzaLe04ZPVO
         QtP6Rxv0tIDrUlNSI+dNdtv4u/mQ92aN5TcO/GZwO4W5UWWlvtSPaQ5CJUQEEB515FnT
         hImr2lffKanO+LF/5WXWvf85JCsrv3LfBcghWyQ4a+VC8EV5p1+OCbhZrFOQ7gxyBys3
         QGGfHw+WO7f2qNtKrzTFlyJiCE6dx2ac5UfHZjcOD85EG/yNAjgVUzsvLS70q2O6shpS
         yr0iFQnUeZv8e3lUMCPg4KBDep7juEqHRiJhYP+yytQ2L8ZTSRIvO1BV70KmZM9S2/fM
         ifkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638415; x=1707243215;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z0ZLPXDHZdvlcgoUgP3zTmdcvq6qvkA0S2upwL/CUtg=;
        b=cMk8GPdPiJtXS5yASu7fPBIGE+JrN6Fo8MLTVrVsHzaBDsqBKoNIAeaFZuiwxdWXr+
         g3c5lFwlWA/iDuQ4ztLry1s2KZlMkXdV1F2O3TIkzmXLWNCccvD0cVQkBXmf/dQ5SO5T
         5PoOBrOBMGh7j0GwmTIWbuzjPcNMCKS9lyBYaqk7Fk/kYap/TOSdOq1F8aUqiZFhRWTR
         NCOw2mvAz+ySOWb9bujQ7pdJDGU2P9YDE55CoC8Xy4QXmaWoWcIVcV4+qm90oLHL90YR
         11Ss4U1OUuDIqi4UOsJBu1FKAI9MEgsPBNdoiA+7AbFu1kgcm+9LzJMG5tC4VnbZU3gv
         vRJw==
X-Gm-Message-State: AOJu0YwWAF25NY8MrJr2WzNIPvr1/WcttDXZ+lUzS4dnjmG4RFkU8/Ff
	uNjqGwHVjrq+uUhVl8FEfL9XbIwqYYNQFBA51yb4eN2z3DQTKwulhA7oejwjBzSOlOhqSN3Ghzo
	WXw==
X-Google-Smtp-Source: AGHT+IFqsnA3SXha1LOM31JOU8ZqINRjmQ1DIolMTjmqlhAFRjJF7BdLccA/oIIIVNpIYsZkOkZIWMx5CpQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:5ab6:8043:f210:7397])
 (user=gnoack job=sendgmr) by 2002:a05:6402:3590:b0:55d:2f62:a07b with SMTP id
 y16-20020a056402359000b0055d2f62a07bmr47866edc.1.1706638415164; Tue, 30 Jan
 2024 10:13:35 -0800 (PST)
Date: Tue, 30 Jan 2024 19:13:25 +0100
In-Reply-To: <20231214.aeC5Wax8phe1@digikod.net>
Message-Id: <Zbk8RZCQ4M2i7BQn@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com> <20231208155121.1943775-5-gnoack@google.com>
 <20231214.feeZ6Hahwaem@digikod.net> <20231214.Iev8oopu8iel@digikod.net> <20231214.aeC5Wax8phe1@digikod.net>
Subject: Re: [PATCH v8 4/9] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Thu, Dec 14, 2023 at 03:28:10PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Christian, what do you think about the following IOCTL groups?
>=20
> On Thu, Dec 14, 2023 at 11:14:10AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Thu, Dec 14, 2023 at 10:26:49AM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > On Fri, Dec 08, 2023 at 04:51:16PM +0100, G=C3=BCnther Noack wrote:
> > > > Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> > > > and increments the Landlock ABI version to 5.
> > > >=20
> > > > Like the truncate right, these rights are associated with a file
> > > > descriptor at the time of open(2), and get respected even when the
> > > > file descriptor is used outside of the thread which it was original=
ly
> > > > opened in.
> > > >=20
> > > > A newly enabled Landlock policy therefore does not apply to file
> > > > descriptors which are already open.
> > > >=20
> > > > If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small numb=
er
> > > > of safe IOCTL commands will be permitted on newly opened files.  Th=
e
> > > > permitted IOCTLs can be configured through the ruleset in limited w=
ays
> > > > now.  (See documentation for details.)
> > > >=20
> > > > Specifically, when LANDLOCK_ACCESS_FS_IOCTL is handled, granting th=
is
> > > > right on a file or directory will *not* permit to do all IOCTL
> > > > commands, but only influence the IOCTL commands which are not alrea=
dy
> > > > handled through other access rights.  The intent is to keep the gro=
ups
> > > > of IOCTL commands more fine-grained.
> > > >=20
> > > > Noteworthy scenarios which require special attention:
> > > >=20
> > > > TTY devices support IOCTLs like TIOCSTI and TIOCLINUX, which can be
> > > > used to control shell processes on the same terminal which run at
> > > > different privilege levels, which may make it possible to escape a
> > > > sandbox.  Because stdin, stdout and stderr are normally inherited
> > > > rather than newly opened, IOCTLs are usually permitted on them even
> > > > after the Landlock policy is enforced.
> > > >=20
> > > > Some legitimate file system features, like setting up fscrypt, are
> > > > exposed as IOCTL commands on regular files and directories -- users=
 of
> > > > Landlock are advised to double check that the sandboxed process doe=
s
> > > > not need to invoke these IOCTLs.
> > > >=20
> > > > Known limitations:
> > > >=20
> > > > The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained contr=
ol
> > > > over IOCTL commands.  Future work will enable a more fine-grained
> > > > access control for IOCTLs.
> > > >=20
> > > > In the meantime, Landlock users may use path-based restrictions in
> > > > combination with their knowledge about the file system layout to
> > > > control what IOCTLs can be done.  Mounting file systems with the no=
dev
> > > > option can help to distinguish regular files and devices, and give
> > > > guarantees about the affected files, which Landlock alone can not g=
ive
> > > > yet.
> > > >=20
> > > > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > > > ---
> > > >  include/uapi/linux/landlock.h                |  58 +++++-
> > > >  security/landlock/fs.c                       | 176 +++++++++++++++=
+++-
> > > >  security/landlock/fs.h                       |   2 +
> > > >  security/landlock/limits.h                   |  11 +-
> > > >  security/landlock/ruleset.h                  |   2 +-
> > > >  security/landlock/syscalls.c                 |  19 +-
> > > >  tools/testing/selftests/landlock/base_test.c |   2 +-
> > > >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> > > >  8 files changed, 253 insertions(+), 22 deletions(-)
> > > >=20
> > >=20
> > > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > > index 9ba989ef46a5..81ce41e9e6db 100644
> > > > --- a/security/landlock/fs.c
> > > > +++ b/security/landlock/fs.c
> > > > @@ -7,12 +7,14 @@
> > > >   * Copyright =C2=A9 2021-2022 Microsoft Corporation
> > > >   */
> > > > =20
> > > > +#include <asm/ioctls.h>
> > > >  #include <linux/atomic.h>
> > > >  #include <linux/bitops.h>
> > > >  #include <linux/bits.h>
> > > >  #include <linux/compiler_types.h>
> > > >  #include <linux/dcache.h>
> > > >  #include <linux/err.h>
> > > > +#include <linux/falloc.h>
> > > >  #include <linux/fs.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/kernel.h>
> > > > @@ -28,6 +30,7 @@
> > > >  #include <linux/types.h>
> > > >  #include <linux/wait_bit.h>
> > > >  #include <linux/workqueue.h>
> > > > +#include <uapi/linux/fiemap.h>
> > > >  #include <uapi/linux/landlock.h>
> > > > =20
> > > >  #include "common.h"
> > > > @@ -83,6 +86,145 @@ static const struct landlock_object_underops la=
ndlock_fs_underops =3D {
> > > >  	.release =3D release_inode
> > > >  };
> > > > =20
> > > > +/* IOCTL helpers */
> > > > +
> > > > +/*
> > > > + * These are synthetic access rights, which are only used within t=
he kernel, but
> > > > + * not exposed to callers in userspace.  The mapping between these=
 access rights
> > > > + * and IOCTL commands is defined in the required_ioctl_access() he=
lper function.
> > > > + */
> > > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1 (LANDLOCK_LAST_PUBLIC_ACCE=
SS_FS << 1)
> > > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2 (LANDLOCK_LAST_PUBLIC_ACCE=
SS_FS << 2)
> > > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3 (LANDLOCK_LAST_PUBLIC_ACCE=
SS_FS << 3)
> > > > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4 (LANDLOCK_LAST_PUBLIC_ACCE=
SS_FS << 4)
> > > > +
> > > > +/* ioctl_groups - all synthetic access rights for IOCTL command gr=
oups */
> > > > +/* clang-format off */
> > > > +#define IOCTL_GROUPS (			  \
> > > > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP1 | \
> > > > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP2 | \
> > > > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP3 | \
> > > > +	LANDLOCK_ACCESS_FS_IOCTL_GROUP4)
> > > > +/* clang-format on */
> > > > +
> > > > +static_assert((IOCTL_GROUPS & LANDLOCK_MASK_ACCESS_FS) =3D=3D IOCT=
L_GROUPS);
> > > > +
> > > > +/**
> > > > + * required_ioctl_access(): Determine required IOCTL access rights=
.
> > > > + *
> > > > + * @cmd: The IOCTL command that is supposed to be run.
> > > > + *
> > > > + * Returns: The access rights that must be granted on an opened fi=
le in order to
> > > > + * use the given @cmd.
> > > > + */
> > > > +static access_mask_t required_ioctl_access(unsigned int cmd)
> >=20
> > Please use a verb for functions, something like
> > get_required_ioctl_access().
> >=20
> > >=20
> > > You can add __attribute_const__ after "static", and also constify cmd=
.
> > >=20
> > > > +{
> > > > +	switch (cmd) {
> > > > +	case FIOCLEX:
> > > > +	case FIONCLEX:
> > > > +	case FIONBIO:
> > > > +	case FIOASYNC:
> > > > +		/*
> > > > +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> > > > +		 * close-on-exec and the file's buffered-IO and async flags.
> > > > +		 * These operations are also available through fcntl(2),
> > > > +		 * and are unconditionally permitted in Landlock.
> > > > +		 */
> > > > +		return 0;
>=20
> Could you please add comments for the following IOCTL commands
> explaining why they make sense for the related file/dir read/write
> mapping? We discussed about that in the ML but it would be much easier
> to put that doc here for future changes, and for reviewers to understand
> the rationale. Some of this doc is already in the cover letter.

Done, I'm adding documentation inline here.

>=20
> To make this easier to follow, what about renaming the IOCTL groups to
> something like this:
> * LANDLOCK_ACCESS_FS_IOCTL_GROUP1:
>   LANDLOCK_ACCESS_FS_IOCTL_GET_SIZE
> * LANDLOCK_ACCESS_FS_IOCTL_GROUP2:
>   LANDLOCK_ACCESS_FS_IOCTL_GET_INNER
> * LANDLOCK_ACCESS_FS_IOCTL_GROUP3:
>   LANDLOCK_ACCESS_FS_IOCTL_READ_FILE
> * LANDLOCK_ACCESS_FS_IOCTL_GROUP4:
>   LANDLOCK_ACCESS_FS_IOCTL_WRITE_FILE

Agreed that better names are in order here.
I renamed them as you suggested.

In principle, it would have been nice to name them after the access rights =
which
enable them, but LANDLOCK_ACCESS_FS_IOCTL_READ_DIR_OR_READ_FILE_OR_WRITE_FI=
LE is
a bit too long for my taste. o_O


> > > > +	case FIOQSIZE:
> > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP1;
> > > > +	case FS_IOC_FIEMAP:
> > > > +	case FIBMAP:
> > > > +	case FIGETBSZ:
>=20
> Does it make sense to not include FIGETBSZ in
> LANDLOCK_ACCESS_FS_IOCTL_GROUP1? I think it's OK like this as previously
> explained but I'd like to get confirmation:
> https://lore.kernel.org/r/20230904.aiWae8eineo4@digikod.net

It seems that the more standardized way to get file system block sizes is t=
o use
POSIX' statvfs(3) interface, whose functionality is provided through the
statfs(2) syscall.  These functions have the usual path-based and fd-based
variants.  Landlock does not currently restrict statfs(2) at all, but there=
 is
an existing LSM security hook for it.

We should probably introduce an access right to restrict statfs(2) in the
future, because this otherwise lets callers probe for the existence of file=
s.  I
filed https://github.com/landlock-lsm/linux/issues/18 for it.

I am not sure how to group this best.  It seems like a very harmless thing =
to
allow.  (What is to be learned from the filesystem blocksize anyway?)  If w=
e are
unsure about it, we could do the following though:

 - disallow FIGETBSZ unless LANDLOCK_ACCESS_FS_IOCTL ("misc") is granted
 - allow FIGETBSZ together with a future access right which controls statfs=
(2)

In that case, the use of FIGETBSZ would be nicely separable from regular re=
ad
access for files, and it would be associated with the same right.

(We could also potentially group FS_IOC_FIEMAP and FIBMAP in the same way.
These ones give information about file extents and a file's block numbers. =
 (You
can check whether your file is stored in a continuous area on disk.))

This would simplify the story somewhat for the IOCTLs that we need to
immediately give access to.

What do you think?


> > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP2;
> > > > +	case FIONREAD:
> > > > +	case FIDEDUPERANGE:
> > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP3;
> > > > +	case FICLONE:
> > > > +	case FICLONERANGE:
>=20
> The FICLONE* commands seems to already check read/write permissions with
> generic_file_rw_checks(). Always allowing them should then be OK (and
> the current tests should still pass), but we can still keep them here to
> make the required access right explicit and test with and without
> Landlock restrictions to make sure this is consistent with the VFS
> access checks. See
> https://lore.kernel.org/r/20230904.aiWae8eineo4@digikod.net
> If this is correct, a new test should check that Landlock restrictions
> are the same as the VFS checks and then don't impact such IOCTLs.

Noted.  I'll look into it.

(My understanding of FICLONE, FIDEDUPRANGE and FICLONERANGE is that they le=
t
files share the same underlying storage, on a per-range basis ("reflink"). =
 The
IOCTL man pages for these do not explain that as explicitly, but the key po=
int
is that the two resulting files still behave like a regular copy, because t=
his
feature exists on COW file systems only.  So that reinforces the approach o=
f
using READ_FILE and WRITE_FILE access rights for these IOCTL commands (beca=
use
it behaves just as if we had called read() on one file and written the resu=
lts
to the other file with write()).)


> > > > +	case FS_IOC_RESVSP:
> > > > +	case FS_IOC_RESVSP64:
> > > > +	case FS_IOC_UNRESVSP:
> > > > +	case FS_IOC_UNRESVSP64:
> > > > +	case FS_IOC_ZERO_RANGE:
> > > > +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP4;
> > > > +	default:
> > > > +		/*
> > > > +		 * Other commands are guarded by the catch-all access right.
> > > > +		 */
> > > > +		return LANDLOCK_ACCESS_FS_IOCTL;
> > > > +	}
> > > > +}

> We previously talked about allowing all IOCTLs on unix sockets and named
> pipes: https://lore.kernel.org/r/ZP7lxmXklksadvz+@google.com

Thanks for the reminder, I missed that.  Putting it on the TODO list.


> I think the remaining issue with this grouping is that if the VFS
> implementation returns -ENOIOCTLCMD, then the IOCTL command can be
> forwarded to the device driver (for character or block devices).
> For instance, FIONREAD on a character device could translate to unknown
> action (on this device), which should then be considered dangerous and
> denied unless explicitly allowed with LANDLOCK_ACCESS_FS_IOCTL (but not
> any IOCTL_GROUP*).
>
> For instance, FIONREAD on /dev/null should return -ENOTTY, which should
> then also be the case if LANDLOCK_ACCESS_FS_IOCTL is allowed (even if
> LANDLOCK_ACCESS_FS_READ_FILE is denied). This is also the case for
> file_ioctl()'s commands.
>=20
> One solution to implement this logic would be to add an additional check
> in hook_file_ioctl() for specific file types (!S_ISREG or socket or pipe
> exceptions) and IOCTL commands.

In my view this seems OK, because we are primarily protecting access to
resources (files), and only secondarily reducing the exposed kernel attack
surface.

I agree there is a certain risk associated with calling ioctl(fd, FIONREAD,=
 ...)
on a buggy device driver.  But then again, that risk is comparable to the r=
isk
of calling read(fd, &buf, buflen) on the same buggy device driver.  So the
LANDLOCK_ACCESS_FS_READ_FILE right grants access to both.  Users who are
concerned about the security of specific device drivers can enforce a polic=
y
where only the necessary device files can be opened.

Does that make sense?

(Otherwise, if it makes you feel better, we can also change it so that thes=
e
IOCTL commands require LANDLOCK_ACCESS_FS_IOCTL if they are used on non-S_I=
SREG
files.  But it would complicate the IOCTL logic a bit, which we are exposin=
g to
users.)


> Christian, is it correct to say that device drivers are not "required"
> to follow the same semantic as the VFS's IOCTLs and that (for whatever
> reason) collisions may occur? I guess this is not the case for
> filesystems, which should implement similar semantic for the same
> IOCTLs.

Christian, friendly ping! :)  Do you have opinions on this?

If the Landlock LSM makes decisions based on the IOCTL command numbers, do =
we
have to assume that underlying device drivers might expose different
functionality under the same IOCTL command numbers?

Thanks,
=E2=80=94G=C3=BCnther

