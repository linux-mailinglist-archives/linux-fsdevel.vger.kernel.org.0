Return-Path: <linux-fsdevel+bounces-3050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8077EF8D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 21:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0BB280F51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 20:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEBD43AA7;
	Fri, 17 Nov 2023 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="V6ebJHkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC3D50
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 12:46:05 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SX87c2bHlzMrn57;
	Fri, 17 Nov 2023 20:46:04 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4SX87b64k8z3f;
	Fri, 17 Nov 2023 21:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1700253964;
	bh=eju+/susoVCIX4KsZp5W5gLYU12vRhvZjbvYcCJMP70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6ebJHkDrSP9779Fi1X1AIWSgzCEGDmjHA0RRn1zw/cdHldu7JUA031NYEYsm6a0O
	 oeuB2Ejm3cL3+14XJS7djvj2a64zx9OG2pb4S2xVGmKGNah8nWhXn9X8F7Fd3bpTLI
	 nV2+v2YrFdu4SPaagAOjx7jwmamJ/TR/8v7Kcfcw=
Date: Fri, 17 Nov 2023 21:45:47 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] landlock: Add IOCTL access right
Message-ID: <20231117.aeZ3koh4bu2a@digikod.net>
References: <20231117154920.1706371-1-gnoack@google.com>
 <20231117154920.1706371-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117154920.1706371-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Nov 17, 2023 at 04:49:15PM +0100, Günther Noack wrote:
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
> Noteworthy scenarios which require special attention:
> 
> TTY devices support IOCTLs like TIOCSTI and TIOCLINUX, which can be
> used to control shell processes on the same terminal which run at
> different privilege levels, which may make it possible to escape a
> sandbox.  Because stdin, stdout and stderr are normally inherited
> rather than newly opened, IOCTLs are usually permitted on them even
> after the Landlock policy is enforced.
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
>  include/uapi/linux/landlock.h                |  58 ++++++-
>  security/landlock/fs.c                       | 150 ++++++++++++++++++-
>  security/landlock/fs.h                       |  11 ++
>  security/landlock/limits.h                   |  15 +-
>  security/landlock/ruleset.h                  |   2 +-
>  security/landlock/syscalls.c                 |  10 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  8 files changed, 233 insertions(+), 20 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 25c8d7677539..578f268b084b 100644
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
> @@ -198,13 +199,53 @@ struct landlock_net_port_attr {
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
> + *   * %LANDLOCK_ACCESS_FS_READ_FILE unlocks access to ``FIOQSIZE``,
> + *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``, ``FIONREAD``,
> + *     ``FIDEDUPRANGE``.
> + *
> + *   * %LANDLOCK_ACCESS_FS_WRITE_FILE unlocks access to ``FIOQSIZE``,
> + *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``, ``FICLONE``,
> + *     ``FICLONERANGE``, ``FS_IOC_RESVSP``, ``FS_IOC_RESVSP64``,
> + *     ``FS_IOC_UNRESVSP``, ``FS_IOC_UNRESVSP64``, ``FS_IOC_ZERO_RANGE``.
> + *
> + *   * %LANDLOCK_ACCESS_FS_READ_DIR unlocks access to ``FIOQSIZE``,
> + *     ``FS_IOC_FIEMAP``, ``FIBMAP``, ``FIGETBSZ``.
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
> @@ -223,6 +264,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_IOCTL			(1ULL << 15)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index bc7c126deea2..4d305ddcbc57 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -7,12 +7,14 @@
>   * Copyright © 2021-2022 Microsoft Corporation
>   */
>  
> +#include <asm/ioctls.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/bits.h>
>  #include <linux/compiler_types.h>
>  #include <linux/dcache.h>
>  #include <linux/err.h>
> +#include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -28,6 +30,7 @@
>  #include <linux/types.h>
>  #include <linux/wait_bit.h>
>  #include <linux/workqueue.h>
> +#include <uapi/linux/fiemap.h>
>  #include <uapi/linux/landlock.h>
>  
>  #include "common.h"
> @@ -83,6 +86,68 @@ static const struct landlock_object_underops landlock_fs_underops = {
>  	.release = release_inode
>  };
>  
> +/* IOCTL helpers */
> +
> +/**
> + * expand_ioctl() - Return the dst flags from either the src flag or the
> + * %LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
> + * %LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
> + *
> + * @handled: Handled access rights
> + * @access: The access mask to copy values from
> + * @src: A single access right to copy from in @access.
> + * @dst: One or more access rights to copy to
> + *
> + * Returns: @dst, or 0
> + */
> +static inline access_mask_t expand_ioctl(const access_mask_t handled,

Please remove all explicit inlines in the .c files, the compiler should
be able to inline them if necessary, or it my not inline them at all
anyway.  It would be nice to check the -O2 code to see what GCC or clang
do though, and I guess they will inline this kind of pattern.

> +					 const access_mask_t access,
> +					 const access_mask_t src,
> +					 const access_mask_t dst)
> +{
> +	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> +		return 0;
> +
> +	access_mask_t copy_from = (handled & src) ? src :

Please declare variables at the beginning of blocks.

> +						    LANDLOCK_ACCESS_FS_IOCTL;
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
> +static inline access_mask_t
> +landlock_expand_access_fs(const access_mask_t handled,
> +			  const access_mask_t access)
> +{
> +	return access |
> +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FILE,
> +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP4) |
> +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE,
> +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1 |
> +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> +				    LANDLOCK_ACCESS_FS_IOCTL_GROUP3) |
> +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
> +			    LANDLOCK_ACCESS_FS_IOCTL_GROUP1);
> +}

I'd prefer to keep the semantic definition of these groups (i.e.
required_ioctl_access) close the definition of access right expantions,
and also close to the ioctl_groups veriable. Actually, ioctl_groups
might make more sense close to the group definition, and then probably
another define... What do you think?

> +
> +access_mask_t landlock_expand_handled_access_fs(const access_mask_t handled)
> +{
> +	return landlock_expand_access_fs(handled, handled);
> +}
> +
>  /* Ruleset management */
>  
>  static struct landlock_object *get_inode_object(struct inode *const inode)
> @@ -147,7 +212,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL)
>  /* clang-format on */
>  
>  /*
> @@ -157,6 +223,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  			    const struct path *const path,
>  			    access_mask_t access_rights)
>  {
> +	access_mask_t handled;
>  	int err;
>  	struct landlock_id id = {
>  		.type = LANDLOCK_KEY_INODE,
> @@ -169,9 +236,11 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
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
> @@ -1119,11 +1188,17 @@ static int hook_file_alloc_security(struct file *const file)
>  	return 0;
>  }
>  
> +static const access_mask_t ioctl_groups =
> +	LANDLOCK_ACCESS_FS_IOCTL_GROUP1 | LANDLOCK_ACCESS_FS_IOCTL_GROUP2 |
> +	LANDLOCK_ACCESS_FS_IOCTL_GROUP3 | LANDLOCK_ACCESS_FS_IOCTL_GROUP4;
> +
>  static int hook_file_open(struct file *const file)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>  	access_mask_t open_access_request, full_access_request, allowed_access;
> -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE |
> +					      LANDLOCK_ACCESS_FS_IOCTL |
> +					      ioctl_groups;
>  	const struct landlock_ruleset *const dom = get_current_fs_domain();
>  
>  	if (!dom)
> @@ -1196,6 +1271,72 @@ static int hook_file_truncate(struct file *const file)
>  	return -EACCES;
>  }
>  
> +/**
> + * required_ioctl_access(): Determine required IOCTL access rights.
> + *
> + * @cmd: The IOCTL command that is supposed to be run.
> + *
> + * Returns: The access rights that must be granted on an opened file in order to
> + * use the given @cmd.
> + */
> +static access_mask_t required_ioctl_access(unsigned int cmd)
> +{
> +	switch (cmd) {
> +	case FIOCLEX:
> +	case FIONCLEX:
> +	case FIONBIO:
> +	case FIOASYNC:
> +		/*
> +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> +		 * close-on-exec and the file's buffered-IO and async flags.
> +		 * These operations are also available through fcntl(2),
> +		 * and are unconditionally permitted in Landlock.
> +		 */
> +		return 0;
> +	case FIOQSIZE:
> +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP1;
> +	case FS_IOC_FIEMAP:
> +	case FIBMAP:
> +	case FIGETBSZ:
> +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP2;
> +	case FIONREAD:
> +	case FIDEDUPERANGE:
> +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP3;
> +	case FICLONE:
> +	case FICLONERANGE:
> +	case FS_IOC_RESVSP:
> +	case FS_IOC_RESVSP64:
> +	case FS_IOC_UNRESVSP:
> +	case FS_IOC_UNRESVSP64:
> +	case FS_IOC_ZERO_RANGE:
> +		return LANDLOCK_ACCESS_FS_IOCTL_GROUP4;
> +	default:
> +		/*
> +		 * Other commands are guarded by the catch-all access right.
> +		 */
> +		return LANDLOCK_ACCESS_FS_IOCTL;
> +	}
> +}
> +
> +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	const access_mask_t required_access = required_ioctl_access(cmd);
> +	const access_mask_t allowed_access =
> +		landlock_file(file)->allowed_access;
> +
> +	/*
> +	 * It is the access rights at the time of opening the file which
> +	 * determine whether ioctl can be used on the opened file later.

s/ioctl/IOCTL/g

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
> @@ -1218,6 +1359,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>  	LSM_HOOK_INIT(file_open, hook_file_open),
>  	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
>  };
>  
>  __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/fs.h b/security/landlock/fs.h
> index 488e4813680a..b3ef11968160 100644
> --- a/security/landlock/fs.h
> +++ b/security/landlock/fs.h
> @@ -92,4 +92,15 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  			    const struct path *const path,
>  			    access_mask_t access_hierarchy);
>  
> +/**
> + * landlock_expand_handled_access_fs() - add synthetic IOCTL access rights to an
> + * access mask of handled accesses.
> + *
> + * @handled: The handled accesses of a ruleset that is being created
> + *
> + * Returns: @handled, with the bits for the synthetic IOCTL access rights set,
> + * if %LANDLOCK_ACCESS_FS_IOCTL is handled
> + */

This doc should be in fs.c

> +access_mask_t landlock_expand_handled_access_fs(const access_mask_t handled);
> +
>  #endif /* _SECURITY_LANDLOCK_FS_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 93c9c6f91556..75e822f878e0 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,20 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>  
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS	LANDLOCK_ACCESS_FS_IOCTL
> +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS	((LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1) - 1)
> +
> +/*
> + * These are synthetic access rights, which are only used within the kernel, but
> + * not exposed to callers in userspace.  The mapping between these access rights
> + * and IOCTL commands is defined in the required_ioctl_access() helper function.
> + */
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 3)
> +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4	(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 4)
> +
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_GROUP4
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  #define LANDLOCK_SHIFT_ACCESS_FS	0


