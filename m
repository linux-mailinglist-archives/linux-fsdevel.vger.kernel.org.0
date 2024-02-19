Return-Path: <linux-fsdevel+bounces-12042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C685AB0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35251F22C69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837B17C80;
	Mon, 19 Feb 2024 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="SOzbKVjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C219171D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367705; cv=none; b=LfDwuNoJK+Xzwewg1rpxiDfX2E1iReOT4i7doQ3+PRFVfWLxLIp+3tQvyutVzdaM3YvKHzvzh8Em7ksF+6z/ubKs7vrWJ8ybepPAVh1DIlidtFcDujr/RO1ZMJr9O1a5GZgs3q3xjQYfduUozxE7WdbSyel1H2IWKFvVgJO3iqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367705; c=relaxed/simple;
	bh=PjOXyLps/ZNp6sE2Wo3gMIHnCuqRhZJuUfSX5JaRNMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSE6utIh8AbyaVPQBreO/n1GZ7kStNczApWylpgSGf8JI7tOMm2KGIkNWmfBNqdbt7TNCdMAQDR4DEdNiLlLIJB9piF6L4ac7z+lNr+BT4tbeL1cnKxas5naJ2t6JXlRXHkVZ4hhV0uYQseZnpPKMi1G5xjlGAFnkIV7DZK5qsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=SOzbKVjA; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tdrmp4C2wzbYp;
	Mon, 19 Feb 2024 19:34:50 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tdrmn4rXhzMpnPd;
	Mon, 19 Feb 2024 19:34:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708367690;
	bh=PjOXyLps/ZNp6sE2Wo3gMIHnCuqRhZJuUfSX5JaRNMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOzbKVjAkOuxFTX1b2ms/Ygz5Fo2CQiAPSTfo30UZU/sguuBOgpZTkr/q7pwi/eVJ
	 80do/76B5ELcG9ZJRaa8+4/5IX08P2nn9bSlVI669hOEHXckNGilPaWu+4HApqJjyM
	 98H4idzXBjLlQbH9Wk7cF9+IWrzK7hTARBO0oa5k=
Date: Mon, 19 Feb 2024 19:34:42 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240219.chu4Yeegh3oo@digikod.net>
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

Arn, Christian, please take a look at the following RFC patch and the
rationale explained here.

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

I think we really need to allow fscrypt and fs-verity IOCTLs.

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

I had a second though about our current approach, and it looks like we
can do simpler, more generic, and with less IOCTL commands specific
handling.

What we didn't take into account is that an IOCTL needs an opened file,
which means that the caller must already have been allowed to open this
file in read or write mode.

I think most FS-specific IOCTL commands check access rights (i.e. access
mode or required capability), other than implicit ones (at least read or
write), when appropriate.  We don't get such guarantee with device
drivers.

The main threat is IOCTLs on character or block devices because their
impact may be unknown (if we only look at the IOCTL command, not the
backing file), but we should allow IOCTLs on filesystems (e.g. fscrypt,
fs-verity, clone extents).  I think we should only implement a
LANDLOCK_ACCESS_FS_IOCTL_DEV right, which would be more explicit.  This
change would impact the IOCTLs grouping (not required anymore), but
we'll still need the list of VFS IOCTLs.


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

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 73997e63734f..84efea3f7c0f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c

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

Because files or directories can only be opened with
LANDLOCK_ACCESS_FS_{READ,WRITE}_{FILE,DIR}, and because IOCTLs can only
be sent on a file descriptor, this means that we can always allow these
3 commands (for opened files).

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

These 10 commands only make sense on directories, so we could also
always allow them on file descriptors.

> +		return LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> +	default:
> +		/*
> +		 * Other commands are guarded by the catch-all access right.
> +		 */
> +		return LANDLOCK_ACCESS_FS_IOCTL;
> +	}
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

We should set optional_access according to the file type before
`full_access_request = open_access_request | optional_access;`

const bool is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);

optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
if (is_device)
    optional_access |= LANDLOCK_ACCESS_FS_IOCTL_DEV;


Because LANDLOCK_ACCESS_FS_IOCTL_DEV is dedicated to character or block
devices, we may want landlock_add_rule() to only allow this access right
to be tied to directories, or character devices, or block devices.  Even
if it would be more consistent with constraints on directory-only access
rights, I'm not sure about that.


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

Instead of this S_ISFIFO check:

if (!is_device)
    allowed_access |= LANDLOCK_ACCESS_FS_IOCTL_DEV;

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

const access_mask_t required_access = LANDLOCK_ACCESS_FS_IOCTL_DEV;


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

We could then check against the do_vfs_ioctl()'s commands, excluding
FIONREAD and file_ioctl()'s commands, to always allow VFS-related
commands:

if (vfs_masked_device_ioctl(cmd))
    return 0;

As a safeguard, we could define vfs_masked_device_ioctl(cmd) in
fs/ioctl.c and make it called by do_vfs_ioctl() as a safeguard to make
sure we keep an accurate list of VFS IOCTL commands (see next RFC patch).

The compat IOCTL hook must also be implemented.

What do you think? Any better idea?


> +
> +	return -EACCES;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>  
> @@ -1428,6 +1646,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {

