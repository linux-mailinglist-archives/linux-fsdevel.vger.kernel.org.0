Return-Path: <linux-fsdevel+bounces-16810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7028A3230
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F2E1C2313C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0481487CC;
	Fri, 12 Apr 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="joUN0210"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240F481B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935037; cv=none; b=MQbVt8ob7U3CdLZj4ZbpniQBYitEr7G31Dd5IfU5glGYahmZ7pzx0zUFAhwiUxp94YF3rX7RoBIJF46Mhe5k3f9hf/SfpK/ncJWDNnAW8Rd3s+UQVDX44hGgR1zD/b+OHS+tRL1vev4oUrIGVZS0+p0jJ6Cg+0LED06liY5ltf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935037; c=relaxed/simple;
	bh=+0KStpb7b5a8X8lEEZqVzAXPx047W+cfVXYsAnt1oSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDdx7A/AmeOReuSKzV+laZ72y5Vf5tRtxy2nbFfQ3yAgcQxLpCUfaQJ5n95x5hRnSsjE1D9IuAQU7nogCUBaJNIOzVObYRA1uFw17/giGLPauXEuL/RYdwcC9abxuZSwwQfrmpQN3CynPGs8Flt9Jaa5FVDjwWLv9O7Qm/0Pr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=joUN0210; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VGKt65DstzB00;
	Fri, 12 Apr 2024 17:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1712935022;
	bh=+0KStpb7b5a8X8lEEZqVzAXPx047W+cfVXYsAnt1oSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joUN0210VKBZ6myOBUpY+lc7TkAWOTz+tCIkO0bePS64Um1xmA00qjhPdv63RdXY5
	 YaP93LS15IX8hrmAfa7xulAx0CJX2l9e2f+DifsVATNHiCeYsBNnMekebDPIlh+IHX
	 pbvzh7RCfoJoTZMNH5XfsJ4dqMtPxjDxBXiZa5Ms=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VGKt40rWPz5Ff;
	Fri, 12 Apr 2024 17:17:00 +0200 (CEST)
Date: Fri, 12 Apr 2024 17:16:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v14 02/12] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <20240412.autaiv1NiRiX@digikod.net>
References: <20240405214040.101396-1-gnoack@google.com>
 <20240405214040.101396-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405214040.101396-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

I like this patch very much! This patch series is in linux-next and I
don't expect it to change much. Just a few comments below and for test
patches.

The only remaining question is: should we allow non-device files to
receive the LANDLOCK_ACCESS_FS_IOCTL_DEV right?

On Fri, Apr 05, 2024 at 09:40:30PM +0000, Günther Noack wrote:
> Introduces the LANDLOCK_ACCESS_FS_IOCTL_DEV right
> and increments the Landlock ABI version to 5.
> 
> This access right applies to device-custom IOCTL commands
> when they are invoked on block or character device files.
> 
> Like the truncate right, this right is associated with a file
> descriptor at the time of open(2), and gets respected even when the
> file descriptor is used outside of the thread which it was originally
> opened in.
> 
> Therefore, a newly enabled Landlock policy does not apply to file
> descriptors which are already open.
> 
> If the LANDLOCK_ACCESS_FS_IOCTL_DEV right is handled, only a small
> number of safe IOCTL commands will be permitted on newly opened device
> files.  These include FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC, as well
> as other IOCTL commands for regular files which are implemented in
> fs/ioctl.c.
> 
> Noteworthy scenarios which require special attention:
> 
> TTY devices are often passed into a process from the parent process,
> and so a newly enabled Landlock policy does not retroactively apply to
> them automatically.  In the past, TTY devices have often supported
> IOCTL commands like TIOCSTI and some TIOCLINUX subcommands, which were
> letting callers control the TTY input buffer (and simulate
> keypresses).  This should be restricted to CAP_SYS_ADMIN programs on
> modern kernels though.
> 
> Known limitations:
> 
> The LANDLOCK_ACCESS_FS_IOCTL_DEV access right is a coarse-grained
> control over IOCTL commands.
> 
> Landlock users may use path-based restrictions in combination with
> their knowledge about the file system layout to control what IOCTLs
> can be done.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h                |  38 +++-
>  security/landlock/fs.c                       | 221 ++++++++++++++++++-

You contributed a lot and you may want to add a copyright in this file.

>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   8 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  6 files changed, 259 insertions(+), 17 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 25c8d7677539..68625e728f43 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -128,7 +128,7 @@ struct landlock_net_port_attr {
>   * files and directories.  Files or directories opened before the sandboxing
>   * are not subject to these restrictions.
>   *
> - * A file can only receive these access rights:
> + * The following access rights apply only to files:
>   *
>   * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
>   * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
> @@ -138,12 +138,13 @@ struct landlock_net_port_attr {
>   * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
>   * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
>   *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
> - *   ``O_TRUNC``. Whether an opened file can be truncated with
> - *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in the
> - *   same way as read and write permissions are checked during
> - *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
> - *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since the
> - *   third version of the Landlock ABI.
> + *   ``O_TRUNC``.  This access right is available since the third version of the
> + *   Landlock ABI.
> + *
> + * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
> + * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> + * read and write permissions are checked during :manpage:`open(2)` using
> + * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
>   *
>   * A directory can receive access rights related to files or directories.  The
>   * following access right is applied to the directory itself, and the
> @@ -198,13 +199,33 @@ struct landlock_net_port_attr {
>   *   If multiple requirements are not met, the ``EACCES`` error code takes
>   *   precedence over ``EXDEV``.
>   *
> + * The following access right applies both to files and directories:
> + *
> + * - %LANDLOCK_ACCESS_FS_IOCTL_DEV: Invoke :manpage:`ioctl(2)` commands on an opened
> + *   character or block device.
> + *
> + *   This access right applies to all `ioctl(2)` commands implemented by device
> + *   drivers.  However, the following common IOCTL commands continue to be
> + *   invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL_DEV right:
> + *
> + *   * IOCTL commands targeting file descriptors (``FIOCLEX``, ``FIONCLEX``),
> + *   * IOCTL commands targeting file descriptions (``FIONBIO``, ``FIOASYNC``),
> + *   * IOCTL commands targeting file systems (``FIFREEZE``, ``FITHAW``,
> + *     ``FIGETBSZ``, ``FS_IOC_GETFSUUID``, ``FS_IOC_GETFSSYSFSPATH``)
> + *   * Some IOCTL commands which do not make sense when used with devices, but
> + *     whose implementations are safe and return the right error codes
> + *     (``FS_IOC_FIEMAP``, ``FICLONE``, ``FICLONERANGE``, ``FIDEDUPERANGE``)
> + *
> + *   This access right is available since the fifth version of the Landlock
> + *   ABI.
> + *
>   * .. warning::
>   *
>   *   It is currently not possible to restrict some file-related actions
>   *   accessible through these syscall families: :manpage:`chdir(2)`,
>   *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
>   *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> - *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
> + *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
>   *   Future Landlock evolutions will enable to restrict them.
>   */
>  /* clang-format off */
> @@ -223,6 +244,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index c15559432d3d..b0857541d5e0 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -7,6 +7,7 @@
>   * Copyright © 2021-2022 Microsoft Corporation
>   */
>  
> +#include <asm/ioctls.h>
>  #include <kunit/test.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
> @@ -14,6 +15,7 @@
>  #include <linux/compiler_types.h>
>  #include <linux/dcache.h>
>  #include <linux/err.h>
> +#include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -29,6 +31,7 @@
>  #include <linux/types.h>
>  #include <linux/wait_bit.h>
>  #include <linux/workqueue.h>
> +#include <uapi/linux/fiemap.h>
>  #include <uapi/linux/landlock.h>
>  
>  #include "common.h"
> @@ -84,6 +87,158 @@ static const struct landlock_object_underops landlock_fs_underops = {
>  	.release = release_inode
>  };
>  
> +/* IOCTL helpers */
> +
> +/**
> + * is_masked_device_ioctl(): Determine whether an IOCTL command is always
> + * permitted with Landlock for device files.  These commands can not be
> + * restricted on device files by enforcing a Landlock policy.
> + *
> + * @cmd: The IOCTL command that is supposed to be run.
> + *
> + * By default, any IOCTL on a device file requires the
> + * LANDLOCK_ACCESS_FS_IOCTL_DEV right.  However, we blanket-permit some
> + * commands, if:
> + *
> + * 1. The command is implemented in fs/ioctl.c's do_vfs_ioctl(),
> + *    not in f_ops->unlocked_ioctl() or f_ops->compat_ioctl().
> + *
> + * 2. The command is harmless when invoked on devices.
> + *
> + * We also permit commands that do not make sense for devices, but where the
> + * do_vfs_ioctl() implementation returns a more conventional error code.
> + *
> + * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_ioctl()
> + * should be considered for inclusion here.
> + *
> + * Returns: true if the IOCTL @cmd can not be restricted with Landlock for
> + * device files.
> + */

Great documentation!

> +static __attribute_const__ bool is_masked_device_ioctl(const unsigned int cmd)
> +{
> +	switch (cmd) {
> +	/*
> +	 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> +	 * close-on-exec and the file's buffered-IO and async flags.  These
> +	 * operations are also available through fcntl(2), and are
> +	 * unconditionally permitted in Landlock.
> +	 */
> +	case FIOCLEX:
> +	case FIONCLEX:
> +	case FIONBIO:
> +	case FIOASYNC:
> +	/*
> +	 * FIOQSIZE queries the size of a regular file, directory, or link.
> +	 *
> +	 * We still permit it, because it always returns -ENOTTY for
> +	 * other file types.
> +	 */
> +	case FIOQSIZE:
> +	/*
> +	 * FIFREEZE and FITHAW freeze and thaw the file system which the
> +	 * given file belongs to.  Requires CAP_SYS_ADMIN.
> +	 *
> +	 * These commands operate on the file system's superblock rather
> +	 * than on the file itself.  The same operations can also be
> +	 * done through any other file or directory on the same file
> +	 * system, so it is safe to permit these.
> +	 */
> +	case FIFREEZE:
> +	case FITHAW:
> +	/*
> +	 * FS_IOC_FIEMAP queries information about the allocation of
> +	 * blocks within a file.
> +	 *
> +	 * This IOCTL command only makes sense for regular files and is
> +	 * not implemented by devices. It is harmless to permit.
> +	 */
> +	case FS_IOC_FIEMAP:
> +	/*
> +	 * FIGETBSZ queries the file system's block size for a file or
> +	 * directory.
> +	 *
> +	 * This command operates on the file system's superblock rather
> +	 * than on the file itself.  The same operation can also be done
> +	 * through any other file or directory on the same file system,
> +	 * so it is safe to permit it.
> +	 */
> +	case FIGETBSZ:
> +	/*
> +	 * FICLONE, FICLONERANGE and FIDEDUPERANGE make files share
> +	 * their underlying storage ("reflink") between source and
> +	 * destination FDs, on file systems which support that.
> +	 *
> +	 * These IOCTL commands only apply to regular files
> +	 * and are harmless to permit for device files.
> +	 */
> +	case FICLONE:
> +	case FICLONERANGE:
> +	case FIDEDUPERANGE:

> +	/*
> +	 * FIONREAD, FS_IOC_GETFLAGS, FS_IOC_SETFLAGS, FS_IOC_FSGETXATTR and
> +	 * FS_IOC_FSSETXATTR are forwarded to device implementations.
> +	 */

The above comment should be better near the file_ioctl() one.

> +
> +	/*
> +	 * FS_IOC_GETFSUUID and FS_IOC_GETFSSYSFSPATH both operate on
> +	 * the file system superblock, not on the specific file, so
> +	 * these operations are available through any other file on the
> +	 * same file system as well.
> +	 */
> +	case FS_IOC_GETFSUUID:
> +	case FS_IOC_GETFSSYSFSPATH:
> +		return true;
> +
> +	/*
> +	 * file_ioctl() commands (FIBMAP, FS_IOC_RESVSP, FS_IOC_RESVSP64,
> +	 * FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64 and FS_IOC_ZERO_RANGE) are
> +	 * forwarded to device implementations, so not permitted.
> +	 */
> +
> +	/* Other commands are guarded by the access right. */
> +	default:
> +		return false;
> +	}
> +}
> +
> +/*
> + * is_masked_device_ioctl_compat - same as the helper above, but checking the
> + * "compat" IOCTL commands.
> + *
> + * The IOCTL commands with special handling in compat-mode should behave the
> + * same as their non-compat counterparts.
> + */
> +static __attribute_const__ bool
> +is_masked_device_ioctl_compat(const unsigned int cmd)
> +{
> +	switch (cmd) {
> +	/* FICLONE is permitted, same as in the non-compat variant. */
> +	case FICLONE:
> +		return true;

A new line before and after if/endif would be good.

> +#if defined(CONFIG_X86_64)
> +	/*
> +	 * FS_IOC_RESVSP_32, FS_IOC_RESVSP64_32, FS_IOC_UNRESVSP_32,
> +	 * FS_IOC_UNRESVSP64_32, FS_IOC_ZERO_RANGE_32: not blanket-permitted,
> +	 * for consistency with their non-compat variants.
> +	 */
> +	case FS_IOC_RESVSP_32:
> +	case FS_IOC_RESVSP64_32:
> +	case FS_IOC_UNRESVSP_32:
> +	case FS_IOC_UNRESVSP64_32:
> +	case FS_IOC_ZERO_RANGE_32:
> +#endif
> +	/*
> +	 * FS_IOC32_GETFLAGS, FS_IOC32_SETFLAGS are forwarded to their device
> +	 * implementations.
> +	 */
> +	case FS_IOC32_GETFLAGS:
> +	case FS_IOC32_SETFLAGS:
> +		return false;
> +	default:
> +		return is_masked_device_ioctl(cmd);
> +	}
> +}
> +
>  /* Ruleset management */
>  
>  static struct landlock_object *get_inode_object(struct inode *const inode)

