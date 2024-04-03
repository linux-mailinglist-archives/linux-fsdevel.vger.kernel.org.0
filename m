Return-Path: <linux-fsdevel+bounces-16017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91795896E1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C872918FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114AC1420B8;
	Wed,  3 Apr 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lcOI4B6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031B135A5F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143401; cv=none; b=Z0xC2Fvz+p72N/lPlL5QSr2/Trqq0tToUw+/KFf55iTPfHOC/r+zR224nA7HTnx+isifXS9i+C7RQ0aBZwCqm8e9ecR+tkIw7a/78UiOFla8ya0g2AJ5G7bQq/WhYVDbvtE7Tug9lyGxTpJJGeAVstbMMJeNd5HgdFOeMciECLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143401; c=relaxed/simple;
	bh=WvaRbMJbuLMehhdufBRf3kmhhT3+qRtPHvNllw+X93c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+9f6LsOBLaeYGcfNvJmOsEkJ2ytt9sYqzeY6NYKIg8eXEsB5TQfrDQsrMeb4YK5bxpIfYMpxy+VpXMaIJ1MLepOSz87JlvGclo0PYhe4LNSqkkqfBsHyLFymprWEEo9aklWhj7/LJEsCRICj0FoGQKCLw4CJNNvIZGkHrPOrII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lcOI4B6I; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V8hxt5tS4zbkL;
	Wed,  3 Apr 2024 13:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712142946;
	bh=WvaRbMJbuLMehhdufBRf3kmhhT3+qRtPHvNllw+X93c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcOI4B6Iy806e5mktM1wQ2oUIHtoAeDvUSMtWtEd7Vl5BWEAkUPO3MYn2yNwjoR/T
	 g8h8sAFhlN+MmbugpIXh/P4f0P0rAqes1OOcSzEeVU0NSzJxFJ/GAtHhUyvE5+71aZ
	 sQNBcXOHHoLK8WQCDV3vCfjk7/5Cd2Lvt4sjnfBw=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V8hxs4SMpzLKD;
	Wed,  3 Apr 2024 13:15:45 +0200 (CEST)
Date: Wed, 3 Apr 2024 13:15:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v13 01/10] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <20240403.In2aiweBeir2@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-2-gnoack@google.com>
 <20240327.eibaiNgu6lou@digikod.net>
 <ZgxOYauBXowTIgx-@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgxOYauBXowTIgx-@google.com>
X-Infomaniak-Routing: alpha

On Tue, Apr 02, 2024 at 08:28:49PM +0200, Günther Noack wrote:
> Hello!
> 
> Thanks for the review!
> 
> On Wed, Mar 27, 2024 at 05:57:31PM +0100, Mickaël Salaün wrote:
> > On Wed, Mar 27, 2024 at 01:10:31PM +0000, Günther Noack wrote:
> > > Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
> > > and increments the Landlock ABI version to 5.
> > > 
> > > This access right applies to device-custom IOCTL commands
> > > when they are invoked on block or character device files.
> > > 
> > > Like the truncate right, this right is associated with a file
> > > descriptor at the time of open(2), and gets respected even when the
> > > file descriptor is used outside of the thread which it was originally
> > > opened in.
> > > 
> > > Therefore, a newly enabled Landlock policy does not apply to file
> > > descriptors which are already open.
> > > 
> > > If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
> > > number of safe IOCTL commands will be permitted on newly opened device
> > > files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
> > > as other IOCTL commands for regular files which are implemented in
> > > fs/ioctl.c.
> > > 
> > > Noteworthy scenarios which require special attention:
> > > 
> > > TTY devices are often passed into a process from the parent process,
> > > and so a newly enabled Landlock policy does not retroactively apply to
> > > them automatically.  In the past, TTY devices have often supported
> > > IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
> > > letting callers control the TTY input buffer (and simulate
> > > keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
> > > modern kernels though.
> > > 
> > > Known limitations:
> > > 
> > > The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
> > > control over IOCTL commands.
> > > 
> > > Landlock users may use path-based restrictions in combination with
> > > their knowledge about the file system layout to control what IOCTLs
> > > can be done.
> > > 
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Günther Noack <gnoack@google.com>
> > > ---
> > >  include/uapi/linux/landlock.h                |  33 +++-
> > >  security/landlock/fs.c                       | 183 ++++++++++++++++++-
> > >  security/landlock/limits.h                   |   2 +-
> > >  security/landlock/syscalls.c                 |   8 +-
> > >  tools/testing/selftests/landlock/base_test.c |   2 +-
> > >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> > >  6 files changed, 216 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > > index 25c8d7677539..5d90e9799eb5 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -128,7 +128,7 @@ struct landlock_net_port_attr {
> > >   * files and directories.  Files or directories opened before the sandboxing
> > >   * are not subject to these restrictions.
> > >   *
> > > - * A file can only receive these access rights:
> > > + * The following access rights apply only to files:
> > >   *
> > >   * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
> > >   * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> > > @@ -138,12 +138,13 @@ struct landlock_net_port_attr {
> > >   * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
> > >   * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
> > >   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> > > - *   ``O_TRUNC``. Whether an opened file can be truncated with
> > > - *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in the
> > > - *   same way as read and write permissions are checked during
> > > - *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
> > > - *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since the
> > > - *   third version of the Landlock ABI.
> > > + *   ``O_TRUNC``.  This access right is available since the third version of the
> > > + *   Landlock ABI.
> > > + *
> > > + * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
> > > + * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> > > + * read and write permissions are checked during :manpage:`open(2)` using
> > > + * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
> > >   *
> > >   * A directory can receive access rights related to files or directories.  The
> > >   * following access right is applied to the directory itself, and the
> > > @@ -198,13 +199,28 @@ struct landlock_net_port_attr {
> > >   *   If multiple requirements are not met, the ``EACCES`` error code takes
> > >   *   precedence over ``EXDEV``.
> > >   *
> > > + * The following access right applies both to files and directories:
> > > + *
> > > + * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
> > > + *   character or block device.
> > > + *
> > > + *   This access right applies to all `ioctl(2)` commands implemented by device
> > 
> > :manpage:`ioctl(2)`
> > 
> > > + *   drivers.  However, the following common IOCTL commands continue to be
> > > + *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
> > 
> > This is good but explaining the rationale could help, something like
> > this (taking care of not packing lines listing commands to ease review
> > when a new command will be added):
> > 
> > IOCTL commands targetting file descriptors (``FIOCLEX``, ``FIONCLEX``),
> > file descriptions (``FIONBIO``, ``FIOASYNC``),
> > file systems (``FIOQSIZE``, ``FS_IOC_FIEMAP``, ``FICLONE``,
> > ``FICLONERAN``, ``FIDEDUPERANGE``, ``FS_IOC_GETFLAGS``,
> > ``FS_IOC_SETFLAGS``, ``FS_IOC_FSGETXATTR``, ``FS_IOC_FSSETXATTR``),
> > or superblocks (``FIFREEZE``, ``FITHAW``, ``FIGETBSZ``,
> > ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
> > are never denied.  However, such IOCTL commands still require an opened
> > file and may not be available on any file type.  Read or write
> > permission may be checked by the underlying implementation, as well as
> > capabilities.
> 
> OK, I'll add some more explanation in the next version.
> 
> 
> > > + *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC``, ``FIFREEZE``,
> > > + *   ``FITHAW``, ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``
> > > + *
> > > + *   This access right is available since the fifth version of the Landlock
> > > + *   ABI.
> > > + *
> > >   * .. warning::
> > >   *
> > >   *   It is currently not possible to restrict some file-related actions
> > >   *   accessible through these syscall families: :manpage:`chdir(2)`,
> > >   *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
> > >   *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> > > - *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> > > + *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
> > >   *   Future Landlock evolutions will enable to restrict them.
> > >   */
> > >  /* clang-format off */
> > > @@ -223,6 +239,7 @@ struct landlock_net_port_attr {
> > >  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
> > >  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> > >  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> > > +#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
> > >  /* clang-format on */
> > >  
> > >  /**
> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > index c15559432d3d..2ef6c57fa20b 100644
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -7,6 +7,7 @@
> > >   * Copyright © 2021-2022 Microsoft Corporation
> > >   */
> > >  
> > > +#include <asm/ioctls.h>
> > >  #include <kunit/test.h>
> > >  #include <linux/atomic.h>
> > >  #include <linux/bitops.h>
> > > @@ -14,6 +15,7 @@
> > >  #include <linux/compiler_types.h>
> > >  #include <linux/dcache.h>
> > >  #include <linux/err.h>
> > > +#include <linux/falloc.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/init.h>
> > >  #include <linux/kernel.h>
> > > @@ -29,6 +31,7 @@
> > >  #include <linux/types.h>
> > >  #include <linux/wait_bit.h>
> > >  #include <linux/workqueue.h>
> > > +#include <uapi/linux/fiemap.h>
> > >  #include <uapi/linux/landlock.h>
> > >  
> > >  #include "common.h"
> > > @@ -84,6 +87,141 @@ static const struct landlock_object_underops landlock_fs_underops = {
> > >  	.release = release_inode
> > >  };
> > >  
> > > +/* IOCTL helpers */
> > > +
> > > +/**
> > > + * get_required_ioctl_dev_access(): Determine required access rights for IOCTLs
> > > + * on device files.
> > > + *
> > > + * @cmd: The IOCTL command that is supposed to be run.
> > > + *
> > > + * By default, any IOCTL on a device file requires the
> > > + * LANDLOCK_ACCESS_FS_IOCTL_DEV right.  We make exceptions for commands, if:
> > > + *
> > > + * 1. The command is implemented in fs/ioctl.c's do_vfs_ioctl(),
> > > + *    not in f_ops->unlocked_ioctl() or f_ops->compat_ioctl().
> > > + *
> > > + * 2. The command can be reasonably used on a device file at all.
> > > + *
> > > + * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_ioctl()
> > > + * should be considered for inclusion here.
> > > + *
> > > + * Returns: The access rights that must be granted on an opened file in order to
> > > + * use the given @cmd.
> > > + */
> > > +static __attribute_const__ access_mask_t
> > > +get_required_ioctl_dev_access(const unsigned int cmd)
> > > +{
> > > +	switch (cmd) {
> > > +	case FIOCLEX:
> > > +	case FIONCLEX:
> > > +	case FIONBIO:
> > > +	case FIOASYNC:
> > > +		/*
> > > +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> > > +		 * close-on-exec and the file's buffered-IO and async flags.
> > > +		 * These operations are also available through fcntl(2), and are
> > > +		 * unconditionally permitted in Landlock.
> > > +		 */
> > > +		return 0;
> > > +	case FIOQSIZE:
> > > +		/*
> > > +		 * FIOQSIZE queries the size of a regular file or directory.
> > > +		 *
> > > +		 * This IOCTL command only applies to regular files and
> > > +		 * directories.
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > 
> > This should always be allowed because do_vfs_ioctl() never returns
> > -ENOIOCTLCMD for this command.  That's why I wrote
> > vfs_masked_device_ioctl() this way [1].  I think it would be easier to
> > read and maintain this code with a is_masked_device_ioctl() logic.  Listing
> > commands that are not masked makes it difficult to review because
> > allowed and denied return codes are interleaved.
> 
> Oh, I misunderstood you on [2], I think -- I was under the impression that you
> wanted to keep the switch case in the same order (and with the same entries?) as
> the original in do_vfs_ioctl.  So you'd prefer to only list the always-allowed
> IOCTL commands here, as you have done in vfs_masked_device_ioctl() [3]?
> 
> [2] https://lore.kernel.org/all/20240326.ooCheem1biV2@digikod.net/
> [3] https://lore.kernel.org/all/20240219183539.2926165-1-mic@digikod.net/

That was indeed unclear.  About IOCTL commands, the same order ease
reviewing and maintenance but we don't need to list all commands,
which will limit updates of this list.  However, for the current
unused/unmasked one, we can still add them very briefly in comments as I
did with FIONREAD and file_ioctl()'s ones in vfs_masked_device_ioctl().
Only listing the "masked" ones (for device case) shorten the list, and
having a list with the same semantic ("mask device-specific IOCTLs")
ease review and maintenance as well.

> 
> Can you please clarify how you make up your mind about what should be permitted
> and what should not?  I have trouble understanding the rationale for the changes
> that you asked for below, apart from the points that they are harmless and that
> the return codes should be consistent.

The rationale is the same: all IOCTL commands that are not
passed/specific to character or block devices (i.e. IOCTLs defined in
fs/ioctl.c) are allowed.  vfs_masked_device_ioctl() returns true if the
IOCTL command is not passed to the related device driver but handled by
fs/ioctl.c instead (i.e. handled by the VFS layer).

> 
> The criteria that I have used in this patch set are that (a) it is implemented
> in do_vfs_ioctl() rather than further below, and (b) it makes sense to use that
> command on a device file.  (If we permit FIOQSIZE, FS_IOC_FIEMAP and others
> here, we will get slightly more correct error codes in these cases, but the
> IOCTLs will still not work, because they are not useful and not implemented for
> devices. -- On the other hand, we are also increasing the exposed code surface a
> bit.  For example, FS_IOC_FIEMAP is calling into inode->i_op->fiemap().  That is
> probably harmless for device files, but requires us to reason at a deeper level
> to convince ourselves of that.)

FIOQSIZE is fully handled by do_vfs_ioctl(), and FS_IOC_FIEMAP is
implemented as the inode level, so it should not be passed at the struct
file/device level unless ENOIOCTLCMD is returned (but it should not,
right?).  Because it depends on the inode implementation, it looks like
this IOCTL may work (in theory) on character or block devices too.  If
this is correct, we should not deny it because the semantic of
LANDLOCK_ACCESS_FS_IOCTL_DEV is to control IOCTLs passed to device
drivers.  Furthermore, as you pointed out, error codes would be
unaltered.

It would be good to test (as you suggested IIRC) the masked commands on
a simple device (e.g. /dev/null) to check that it returns ENOTTY,
EOPNOTSUPP, or EACCES according to our expectations.

I agree that this would increase a bit the exposed code surface but I'm
pretty sure that if a sandboxed process is allowed to access a device
file, it is also allowed to access directory or other file types as well
and then would still be able to reach the FS_IOC_FIEMAP implementation.

I'd like to avoid exceptions as in the current implementation of
get_required_ioctl_dev_access() with a switch/case either returning 0 or
LANDLOCK_ACCESS_FS_IOCTL_DEV (excluding the default case of course).  An
alternative approach would be to group IOCTL command cases according to
their returned value, but I find it a bit more complex for no meaningful
gain.  What do you think?

> 
> In your implementation at [3], you were permitting FICLONE* and FIDEDUPERANGE,
> but not FS_IOC_ZERO_RANGE, which is like fallocate().  How are these cases
> different to each other?  Is that on purpose?

FICLONE* and FIDEDUPERANGE match device files and the
vfs_clone_file_range()/generic_file_rw_checks() check returns EINVAL for
device files.  So there is no need to add exceptions for these commands.

FS_IOC_ZERO_RANGE is only implemented for regular files (see
file_ioctl() call), so it is passed to device files.

> 
> 
> > [1] https://lore.kernel.org/r/20240219183539.2926165-1-mic@digikod.net
> > 
> > Your IOCTL command explanation comments are nice and they should be kept
> > in is_masked_device_ioctl() (if they mask device IOCTL commands).
> 
> OK
> 
> > 
> > > +	case FIFREEZE:
> > > +	case FITHAW:
> > > +		/*
> > > +		 * FIFREEZE and FITHAW freeze and thaw the file system which the
> > > +		 * given file belongs to.  Requires CAP_SYS_ADMIN.
> > > +		 *
> > > +		 * These commands operate on the file system's superblock rather
> > > +		 * than on the file itself.  The same operations can also be
> > > +		 * done through any other file or directory on the same file
> > > +		 * system, so it is safe to permit these.
> > > +		 */
> > > +		return 0;
> > > +	case FS_IOC_FIEMAP:
> > > +		/*
> > > +		 * FS_IOC_FIEMAP queries information about the allocation of
> > > +		 * blocks within a file.
> > > +		 *
> > > +		 * This IOCTL command only applies to regular files.
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > 
> > Same here.
> > 
> > > +	case FIGETBSZ:
> > > +		/*
> > > +		 * FIGETBSZ queries the file system's block size for a file or
> > > +		 * directory.
> > > +		 *
> > > +		 * This command operates on the file system's superblock rather
> > > +		 * than on the file itself.  The same operation can also be done
> > > +		 * through any other file or directory on the same file system,
> > > +		 * so it is safe to permit it.
> > > +		 */
> > > +		return 0;
> > > +	case FICLONE:
> > > +	case FICLONERANGE:
> > > +	case FIDEDUPERANGE:
> > > +		/*
> > > +		 * FICLONE, FICLONERANGE and FIDEDUPERANGE make files share
> > > +		 * their underlying storage ("reflink") between source and
> > > +		 * destination FDs, on file systems which support that.
> > > +		 *
> > > +		 * These IOCTL commands only apply to regular files.
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > 
> > ditto
> > 
> > > +	case FIONREAD:
> > > +		/*
> > > +		 * FIONREAD returns the number of bytes available for reading.
> > > +		 *
> > > +		 * We require LANDLOCK_ACCESS_FS_IOCTL_DEV for FIONREAD, because
> > > +		 * devices implement it in f_ops->unlocked_ioctl().  The
> > > +		 * implementations of this operation have varying quality and
> > > +		 * complexity, so it is hard to reason about what they do.
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > > +	case FS_IOC_GETFLAGS:
> > > +	case FS_IOC_SETFLAGS:
> > > +	case FS_IOC_FSGETXATTR:
> > > +	case FS_IOC_FSSETXATTR:
> > > +		/*
> > > +		 * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
> > > +		 * FS_IOC_FSSETXATTR do not apply for devices.
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > > +	case FS_IOC_GETFSUUID:
> > > +	case FS_IOC_GETFSSYSFSPATH:
> > > +		/*
> > > +		 * FS_IOC_GETFSUUID and FS_IOC_GETFSSYSFSPATH both operate on
> > > +		 * the file system superblock, not on the specific file, so
> > > +		 * these operations are available through any other file on the
> > > +		 * same file system as well.
> > > +		 */
> > > +		return 0;
> > > +	case FIBMAP:
> > > +	case FS_IOC_RESVSP:
> > > +	case FS_IOC_RESVSP64:
> > > +	case FS_IOC_UNRESVSP:
> > > +	case FS_IOC_UNRESVSP64:
> > > +	case FS_IOC_ZERO_RANGE:
> > > +		/*
> > > +		 * FIBMAP, FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP,
> > > +		 * FS_IOC_UNRESVSP64 and FS_IOC_ZERO_RANGE only apply to regular
> > > +		 * files (as implemented in file_ioctl()).
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > > +	default:
> > > +		/*
> > > +		 * Other commands are guarded by the catch-all access right.
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > > +	}
> > > +}
> > > +
> > >  /* Ruleset management */
> > >  
> > >  static struct landlock_object *get_inode_object(struct inode *const inode)
> > > @@ -148,7 +286,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> > >  	LANDLOCK_ACCESS_FS_EXECUTE | \
> > >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > > +	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > >  /* clang-format on */
> > >  
> > >  /*
> > > @@ -1335,8 +1474,10 @@ static int hook_file_alloc_security(struct file *const file)
> > >  static int hook_file_open(struct file *const file)
> > >  {
> > >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > > -	access_mask_t open_access_request, full_access_request, allowed_access;
> > > -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> > > +	access_mask_t open_access_request, full_access_request, allowed_access,
> > > +		optional_access;
> > > +	const struct inode *inode = file_inode(file);
> > > +	const bool is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> > >  	const struct landlock_ruleset *const dom =
> > >  		get_fs_domain(landlock_cred(file->f_cred)->domain);
> > >  
> > > @@ -1354,6 +1495,10 @@ static int hook_file_open(struct file *const file)
> > >  	 * We look up more access than what we immediately need for open(), so
> > >  	 * that we can later authorize operations on opened files.
> > >  	 */
> > > +	optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> > > +	if (is_device)
> > > +		optional_access |= LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > > +
> > >  	full_access_request = open_access_request | optional_access;
> > >  
> > >  	if (is_access_to_paths_allowed(
> > > @@ -1410,6 +1555,36 @@ static int hook_file_truncate(struct file *const file)
> > >  	return -EACCES;
> > >  }
> > >  
> > > +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> > > +			   unsigned long arg)
> > > +{
> > > +	const struct inode *inode = file_inode(file);
> > > +	const bool is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> > > +	access_mask_t required_access, allowed_access;
> > 
> > As explained in [2], I'd like not-sandboxed tasks to not have visible
> > performance impact because of Landlock:
> > 
> >   We should first check landlock_file(file)->allowed_access as in
> >   hook_file_truncate() to return as soon as possible for non-sandboxed
> >   tasks.  Any other computation should be done after that (e.g. with an
> >   is_device() helper).
> > 
> > [2] https://lore.kernel.org/r/20240311.If7ieshaegu2@digikod.net
> > 
> > This is_device(file) helper should also replace other is_device variables.
> 
> Done.
> 
> FWIW, I have doubts that it makes a performance difference - the is_device()
> check is almost for free as well.  But we can pull the same check earlier for
> consistency with the truncate hook, if it helps people to understand that their
> own program performance should be unaffected.

Agree

> 
> > 
> > 
> > > +
> > > +	if (!is_device)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * It is the access rights at the time of opening the file which
> > > +	 * determine whether IOCTL can be used on the opened file later.
> > > +	 *
> > > +	 * The access right is attached to the opened file in hook_file_open().
> > > +	 */
> > > +	required_access = get_required_ioctl_dev_access(cmd);
> > > +	allowed_access = landlock_file(file)->allowed_access;
> > > +	if ((allowed_access & required_access) == required_access)
> > > +		return 0;
> > > +
> > > +	return -EACCES;
> > > +}
> > > +
> > > +static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
> > > +				  unsigned long arg)
> > > +{
> > > +	return hook_file_ioctl(file, cmd, arg);
> > 
> > The compat-specific IOCTL commands are missing (e.g. FS_IOC_RESVSP_32).
> > Relying on is_masked_device_ioctl() should make this call OK though.
> 
> OK, I'll try to replicate the logic from your vfs_masked_device_ioctl() approach
> then?

Yes please, unless you catch an issue with this approach.

> 
> —Günther
> 

