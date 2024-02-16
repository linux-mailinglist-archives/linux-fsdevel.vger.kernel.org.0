Return-Path: <linux-fsdevel+bounces-11876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DE8583FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA18281CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376C132499;
	Fri, 16 Feb 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="n4G6x4/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D513172C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104012; cv=none; b=ZtQWf2dB3KQpFBae/wkyR1Bn9Zo5cHLyZc0udOz0oqdP8vShBJa7RNmAR5NuTuLJYP7jF8ioO8zZpGFFdO25/A1QTy7sFWNN5c2IWKuPKerviJEV0aMC9YohF1KMGCA8+5DXqNwtcJ/JgoX9bFXaMoG2e5PLBymGEaP92T14qeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104012; c=relaxed/simple;
	bh=oG4jrFgfJ+RVs1w/j6bbHcojc5I1FtXs7c9qsVk2CgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvpO0bOpf7toHGOTjU/kNx/zws8w4fRVzgAdCiL0LeSJWPXFtmv6lcJsIc3kPoMWUWJ7r/2j3ktUIGjgXZaRcXOmxTBll73aApPjxLWiKkVX8Jr5MNNMx2d2GKTDpryGGeFevE7w49e3M+q2xHKj0MOq3B30cRaKDmpaHTtiqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=n4G6x4/J; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TbzFm74JWzMq5kS;
	Fri, 16 Feb 2024 18:19:56 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TbzFm0zhhz9Ql;
	Fri, 16 Feb 2024 18:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708103996;
	bh=oG4jrFgfJ+RVs1w/j6bbHcojc5I1FtXs7c9qsVk2CgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4G6x4/JS2x+3l7qOl/TmIsYM0g8VzLVwXEwUfcTWvs2zGiUTFvjPVuBGhN5KHH6x
	 OS4pzacooWq/ko7Dpvkc99L19xOSyM9QSl8PWIN0NnVd5jiwJNcshmMFeTmNF615+E
	 J+gET+Qxdy1jPHXBhoG7Cr3CsGByNwK9Q0MMwIL4=
Date: Fri, 16 Feb 2024 18:19:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240216.JaChu1su9shu@digikod.net>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209170612.1638517-2-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Feb 09, 2024 at 06:06:05PM +0100, Günther Noack wrote:
> Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> and increments the Landlock ABI version to 5.
> 
> Like the truncate right, these rights are associated with a file
> descriptor at the time of open(2), and get respected even when the
> file descriptor is used outside of the thread which it was originally
> opened in.
> 
> A newly enabled Landlock policy therefore does not apply to file
> descriptors which are already open.
> 
> If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
> of safe IOCTL commands will be permitted on newly opened files.  The
> permitted IOCTLs can be configured through the ruleset in limited ways
> now.  (See documentation for details.)
> 
> Specifically, when LANDLOCK_ACCESS_FS_IOCTL is handled, granting this
> right on a file or directory will *not* permit to do all IOCTL
> commands, but only influence the IOCTL commands which are not already
> handled through other access rights.  The intent is to keep the groups
> of IOCTL commands more fine-grained.
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
> Some legitimate file system features, like setting up fscrypt, are
> exposed as IOCTL commands on regular files and directories -- users of
> Landlock are advised to double check that the sandboxed process does
> not need to invoke these IOCTLs.
> 
> Known limitations:
> 
> The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
> over IOCTL commands.  Future work will enable a more fine-grained
> access control for IOCTLs.
> 
> In the meantime, Landlock users may use path-based restrictions in
> combination with their knowledge about the file system layout to
> control what IOCTLs can be done.  Mounting file systems with the nodev
> option can help to distinguish regular files and devices, and give
> guarantees about the affected files, which Landlock alone can not give
> yet.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h                |  55 ++++-
>  security/landlock/fs.c                       | 227 ++++++++++++++++++-
>  security/landlock/fs.h                       |   3 +
>  security/landlock/limits.h                   |  11 +-
>  security/landlock/ruleset.h                  |   2 +-
>  security/landlock/syscalls.c                 |  19 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  8 files changed, 302 insertions(+), 22 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 25c8d7677539..16d7d72804f8 100644
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
> @@ -198,13 +199,50 @@ struct landlock_net_port_attr {
>   *   If multiple requirements are not met, the ``EACCES`` error code takes
>   *   precedence over ``EXDEV``.
>   *
> + * The following access right applies both to files and directories:
> + *
> + * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` commands on an opened
> + *   file or directory.
> + *
> + *   This access right applies to all :manpage:`ioctl(2)` commands, except of
> + *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO`` and ``FIOASYNC``.  These commands
> + *   continue to be invokable independent of the %LANDLOCK_ACCESS_FS_IOCTL
> + *   access right.
> + *
> + *   When certain other access rights are handled in the ruleset, in addition to
> + *   %LANDLOCK_ACCESS_FS_IOCTL, granting these access rights will unlock access
> + *   to additional groups of IOCTL commands, on the affected files:
> + *
> + *   * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE unlock
> + *     access to ``FIOQSIZE``, ``FIONREAD``, ``FIGETBSZ``, ``FS_IOC_FIEMAP``,
> + *     ``FIBMAP``, ``FIDEDUPERANGE``, ``FICLONE``, ``FICLONERANGE``,
> + *     ``FS_IOC_RESVSP``, ``FS_IOC_RESVSP64``, ``FS_IOC_UNRESVSP``,
> + *     ``FS_IOC_UNRESVSP64``, ``FS_IOC_ZERO_RANGE``.
> + *
> + *   * %LANDLOCK_ACCESS_FS_READ_DIR unlocks access to ``FIOQSIZE``,
> + *     ``FIONREAD``, ``FIGETBSZ``.
> + *
> + *   When these access rights are handled in the ruleset, the availability of
> + *   the affected IOCTL commands is not governed by %LANDLOCK_ACCESS_FS_IOCTL
> + *   any more, but by the respective access right.
> + *
> + *   All other IOCTL commands are not handled specially, and are governed by
> + *   %LANDLOCK_ACCESS_FS_IOCTL.  This includes %FS_IOC_GETFLAGS and
> + *   %FS_IOC_SETFLAGS for manipulating inode flags (:manpage:`ioctl_iflags(2)`),
> + *   %FS_IOC_FSFETXATTR and %FS_IOC_FSSETXATTR for manipulating extended
> + *   attributes, as well as %FIFREEZE and %FITHAW for freezing and thawing file
> + *   systems.
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
> @@ -223,6 +261,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_IOCTL			(1ULL << 15)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 73997e63734f..84efea3f7c0f 100644
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
> @@ -84,6 +87,186 @@ static const struct landlock_object_underops landlock_fs_underops = {
>  	.release = release_inode
>  };
>  
> +/* IOCTL helpers */
> +
> +/*
> + * These are synthetic access rights, which are only used within the kernel, but
> + * not exposed to callers in userspace.  The mapping between these access rights
> + * and IOCTL commands is defined in the get_required_ioctl_access() helper function.
> + */
> +#define LANDLOCK_ACCESS_FS_IOCTL_RW (LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1)
> +#define LANDLOCK_ACCESS_FS_IOCTL_RW_FILE (LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
> +
> +/* ioctl_groups - all synthetic access rights for IOCTL command groups */
> +/* clang-format off */
> +#define IOCTL_GROUPS (				\
> +	LANDLOCK_ACCESS_FS_IOCTL_RW |		\
> +	LANDLOCK_ACCESS_FS_IOCTL_RW_FILE)
> +/* clang-format on */
> +
> +static_assert((IOCTL_GROUPS & LANDLOCK_MASK_ACCESS_FS) == IOCTL_GROUPS);
> +
> +/**
> + * get_required_ioctl_access(): Determine required IOCTL access rights.
> + *
> + * @cmd: The IOCTL command that is supposed to be run.
> + *
> + * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_ioctl()
> + * should be considered for inclusion here.

It might be a good idea to add a similar comment in
fs/ioctl.c:do_vfs_ioctl(), just before the "default" case, to make sure
nobody forget to Cc us if a new command is added.

> + *
> + * Returns: The access rights that must be granted on an opened file in order to
> + * use the given @cmd.
> + */
> +static __attribute_const__ access_mask_t
> +get_required_ioctl_access(const unsigned int cmd)
> +{
> +	switch (cmd) {
> +	case FIOCLEX:
> +	case FIONCLEX:
> +	case FIONBIO:
> +	case FIOASYNC:
> +		/*
> +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> +		 * close-on-exec and the file's buffered-IO and async flags.
> +		 * These operations are also available through fcntl(2), and are
> +		 * unconditionally permitted in Landlock.
> +		 */
> +		return 0;
> +	case FIONREAD:
> +	case FIOQSIZE:
> +	case FIGETBSZ:
> +		/*
> +		 * FIONREAD returns the number of bytes available for reading.
> +		 * FIONREAD returns the number of immediately readable bytes for
> +		 * a file.
> +		 *
> +		 * FIOQSIZE queries the size of a file or directory.
> +		 *
> +		 * FIGETBSZ queries the file system's block size for a file or
> +		 * directory.
> +		 *
> +		 * These IOCTL commands are permitted for files which are opened
> +		 * with LANDLOCK_ACCESS_FS_READ_DIR,
> +		 * LANDLOCK_ACCESS_FS_READ_FILE, or
> +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> +		 */
> +		return LANDLOCK_ACCESS_FS_IOCTL_RW;
> +	case FS_IOC_FIEMAP:
> +	case FIBMAP:
> +		/*
> +		 * FS_IOC_FIEMAP and FIBMAP query information about the
> +		 * allocation of blocks within a file.  They are permitted for
> +		 * files which are opened with LANDLOCK_ACCESS_FS_READ_FILE or
> +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> +		 */
> +		fallthrough;
> +	case FIDEDUPERANGE:
> +	case FICLONE:
> +	case FICLONERANGE:
> +		/*
> +		 * FIDEDUPERANGE, FICLONE and FICLONERANGE make files share
> +		 * their underlying storage ("reflink") between source and
> +		 * destination FDs, on file systems which support that.
> +		 *
> +		 * The underlying implementations are already checking whether
> +		 * the involved files are opened with the appropriate read/write
> +		 * modes.  We rely on this being implemented correctly.
> +		 *
> +		 * These IOCTLs are permitted for files which are opened with
> +		 * LANDLOCK_ACCESS_FS_READ_FILE or
> +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> +		 */
> +		fallthrough;
> +	case FS_IOC_RESVSP:
> +	case FS_IOC_RESVSP64:
> +	case FS_IOC_UNRESVSP:
> +	case FS_IOC_UNRESVSP64:
> +	case FS_IOC_ZERO_RANGE:
> +		/*
> +		 * These IOCTLs reserve space, or create holes like
> +		 * fallocate(2).  We rely on the implementations checking the
> +		 * files' read/write modes.
> +		 *
> +		 * These IOCTLs are permitted for files which are opened with
> +		 * LANDLOCK_ACCESS_FS_READ_FILE or
> +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> +		 */
> +		return LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> +	default:
> +		/*
> +		 * Other commands are guarded by the catch-all access right.
> +		 */
> +		return LANDLOCK_ACCESS_FS_IOCTL;
> +	}

Good documentation and better grouping!

> +}
> +
> +/**
> + * expand_ioctl() - Return the dst flags from either the src flag or the
> + * %LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
> + * %LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
> + *
> + * @handled: Handled access rights.
> + * @access: The access mask to copy values from.
> + * @src: A single access right to copy from in @access.
> + * @dst: One or more access rights to copy to.
> + *
> + * Returns: @dst, or 0.
> + */
> +static __attribute_const__ access_mask_t
> +expand_ioctl(const access_mask_t handled, const access_mask_t access,
> +	     const access_mask_t src, const access_mask_t dst)
> +{
> +	access_mask_t copy_from;
> +
> +	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> +		return 0;
> +
> +	copy_from = (handled & src) ? src : LANDLOCK_ACCESS_FS_IOCTL;
> +	if (access & copy_from)
> +		return dst;
> +
> +	return 0;
> +}
> +
> +/**
> + * landlock_expand_access_fs() - Returns @access with the synthetic IOCTL group
> + * flags enabled if necessary.
> + *
> + * @handled: Handled FS access rights.
> + * @access: FS access rights to expand.
> + *
> + * Returns: @access expanded by the necessary flags for the synthetic IOCTL
> + * access rights.
> + */
> +static __attribute_const__ access_mask_t landlock_expand_access_fs(
> +	const access_mask_t handled, const access_mask_t access)
> +{
> +	return access |
> +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FILE,
> +			    LANDLOCK_ACCESS_FS_IOCTL_RW |
> +				    LANDLOCK_ACCESS_FS_IOCTL_RW_FILE) |
> +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE,
> +			    LANDLOCK_ACCESS_FS_IOCTL_RW |
> +				    LANDLOCK_ACCESS_FS_IOCTL_RW_FILE) |
> +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
> +			    LANDLOCK_ACCESS_FS_IOCTL_RW);
> +}
> +
> +/**
> + * landlock_expand_handled_access_fs() - add synthetic IOCTL access rights to an
> + * access mask of handled accesses.
> + *
> + * @handled: The handled accesses of a ruleset that is being created.
> + *
> + * Returns: @handled, with the bits for the synthetic IOCTL access rights set,
> + * if %LANDLOCK_ACCESS_FS_IOCTL is handled.
> + */
> +__attribute_const__ access_mask_t
> +landlock_expand_handled_access_fs(const access_mask_t handled)
> +{
> +	return landlock_expand_access_fs(handled, handled);
> +}
> +
>  /* Ruleset management */
>  
>  static struct landlock_object *get_inode_object(struct inode *const inode)
> @@ -148,7 +331,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL)
>  /* clang-format on */
>  
>  /*
> @@ -158,6 +342,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  			    const struct path *const path,
>  			    access_mask_t access_rights)
>  {
> +	access_mask_t handled;
>  	int err;
>  	struct landlock_id id = {
>  		.type = LANDLOCK_KEY_INODE,
> @@ -170,9 +355,11 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  	if (WARN_ON_ONCE(ruleset->num_layers != 1))
>  		return -EINVAL;
>  
> +	handled = landlock_get_fs_access_mask(ruleset, 0);
> +	/* Expands the synthetic IOCTL groups. */
> +	access_rights |= landlock_expand_access_fs(handled, access_rights);
>  	/* Transforms relative access rights to absolute ones. */
> -	access_rights |= LANDLOCK_MASK_ACCESS_FS &
> -			 ~landlock_get_fs_access_mask(ruleset, 0);
> +	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~handled;
>  	id.key.object = get_inode_object(d_backing_inode(path->dentry));
>  	if (IS_ERR(id.key.object))
>  		return PTR_ERR(id.key.object);
> @@ -1333,7 +1520,9 @@ static int hook_file_open(struct file *const file)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>  	access_mask_t open_access_request, full_access_request, allowed_access;
> -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE |
> +					      LANDLOCK_ACCESS_FS_IOCTL |
> +					      IOCTL_GROUPS;
>  	const struct landlock_ruleset *const dom = get_current_fs_domain();
>  
>  	if (!dom)
> @@ -1375,6 +1564,16 @@ static int hook_file_open(struct file *const file)
>  		}
>  	}
>  
> +	/*
> +	 * Named pipes should be treated just like anonymous pipes.
> +	 * Therefore, we permit all IOCTLs on them.
> +	 */
> +	if (S_ISFIFO(file_inode(file)->i_mode)) {
> +		allowed_access |= LANDLOCK_ACCESS_FS_IOCTL |
> +				  LANDLOCK_ACCESS_FS_IOCTL_RW |
> +				  LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> +	}

This should not be required, cf. other thread.

> +
>  	/*
>  	 * For operations on already opened files (i.e. ftruncate()), it is the
>  	 * access rights at the time of open() which decide whether the
> @@ -1406,6 +1605,25 @@ static int hook_file_truncate(struct file *const file)
>  	return -EACCES;
>  }
>  
> +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	const access_mask_t required_access = get_required_ioctl_access(cmd);
> +	const access_mask_t allowed_access =
> +		landlock_file(file)->allowed_access;
> +
> +	/*
> +	 * It is the access rights at the time of opening the file which
> +	 * determine whether IOCTL can be used on the opened file later.
> +	 *
> +	 * The access right is attached to the opened file in hook_file_open().
> +	 */
> +	if ((allowed_access & required_access) == required_access)
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>  
> @@ -1428,6 +1646,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>  	LSM_HOOK_INIT(file_open, hook_file_open),
>  	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
>  };
>  
>  __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 488e4813680a..086576b8386b 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -92,4 +92,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  			    const struct path *const path,
>  			    access_mask_t access_hierarchy);
>  
> +__attribute_const__ access_mask_t
> +landlock_expand_handled_access_fs(const access_mask_t handled);
> +
>  #endif /* _SECURITY_LANDLOCK_FS_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 93c9c6f91556..ecbdc8bbf906 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,16 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>  
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> +/*
> + * For file system access rights, Landlock distinguishes between the publicly
> + * visible access rights (1 to LANDLOCK_LAST_PUBLIC_ACCESS_FS) and the private
> + * ones which are not exposed to userspace (LANDLOCK_LAST_PUBLIC_ACCESS_FS + 1
> + * to LANDLOCK_LAST_ACCESS_FS).  The private access rights are defined in fs.c.
> + */
> +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS	LANDLOCK_ACCESS_FS_IOCTL
> +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS	((LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1) - 1)
> +
> +#define LANDLOCK_LAST_ACCESS_FS		(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  #define LANDLOCK_SHIFT_ACCESS_FS	0
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index c7f1526784fd..5a28ea8e1c3d 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -30,7 +30,7 @@
>  	LANDLOCK_ACCESS_FS_REFER)
>  /* clang-format on */
>  
> -typedef u16 access_mask_t;
> +typedef u32 access_mask_t;
>  /* Makes sure all filesystem access rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>  /* Makes sure all network access rights can be stored. */
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 898358f57fa0..f0bc50003b46 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -137,7 +137,7 @@ static const struct file_operations ruleset_fops = {
>  	.write = fop_dummy_write,
>  };
>  
> -#define LANDLOCK_ABI_VERSION 4
> +#define LANDLOCK_ABI_VERSION 5
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -192,8 +192,8 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  		return err;
>  
>  	/* Checks content (and 32-bits cast). */
> -	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=
> -	    LANDLOCK_MASK_ACCESS_FS)
> +	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_PUBLIC_ACCESS_FS) !=
> +	    LANDLOCK_MASK_PUBLIC_ACCESS_FS)
>  		return -EINVAL;
>  
>  	/* Checks network content (and 32-bits cast). */
> @@ -201,6 +201,10 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	    LANDLOCK_MASK_ACCESS_NET)
>  		return -EINVAL;
>  
> +	/* Expands synthetic IOCTL groups. */
> +	ruleset_attr.handled_access_fs = landlock_expand_handled_access_fs(
> +		ruleset_attr.handled_access_fs);
> +
>  	/* Checks arguments and transforms to kernel struct. */
>  	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
>  					  ruleset_attr.handled_access_net);
> @@ -309,8 +313,13 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>  	if (!path_beneath_attr.allowed_access)
>  		return -ENOMSG;
>  
> -	/* Checks that allowed_access matches the @ruleset constraints. */
> -	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
> +	/*
> +	 * Checks that allowed_access matches the @ruleset constraints and only
> +	 * consists of publicly visible access rights (as opposed to synthetic
> +	 * ones).
> +	 */
> +	mask = landlock_get_raw_fs_access_mask(ruleset, 0) &
> +	       LANDLOCK_MASK_PUBLIC_ACCESS_FS;
>  	if ((path_beneath_attr.allowed_access | mask) != mask)
>  		return -EINVAL;
>  
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 646f778dfb1e..d292b419ccba 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -75,7 +75,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(5, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 2d6d9b43d958..3203f4a5bc85 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -527,9 +527,10 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL)
>  
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL
>  
>  #define ACCESS_ALL ( \
>  	ACCESS_FILE | \
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 
> 

