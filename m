Return-Path: <linux-fsdevel+bounces-14135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9988781F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 15:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692211F23454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B8405EC;
	Mon, 11 Mar 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CCXtWsAT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35B4206C
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168422; cv=none; b=qJjBMmYsgGUIYZS51UTMtvD6ZPkn6ecMPjGBkPIN3XH5mnt/QuFLuOLilEnVL0MOq5/hS3TZFeKiArca0G40GZrAGgvimQOC1x4yVy2q5BYdAsbG8f87Hjll1nzz/IRRb3gs5GX6l3Yv66MTuu/D5CvT+fTNvhvInJ545BlI36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168422; c=relaxed/simple;
	bh=BLrHvxfbt9fUtA65skAta7I5uBq7a6xwCnd8KgeE6Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpeUuhpswrv5wEgL8O/yS1kWphk4XRs8PIMX06RaNlubnR9GHPqDYok7KhrBnbA+VEZx7Y92PVK8+RG0emzhjGflgjyvwbKG38k2VLe4hcvxYPV1SRy0xYPzzlZKV/7JBAc7Yf0r/aeYOwhDoIDU/pij6rauAq2cBT2v8BaQz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CCXtWsAT; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ttfk056YJzCqj;
	Mon, 11 Mar 2024 15:46:48 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Ttfjz2ymMzMpphL;
	Mon, 11 Mar 2024 15:46:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1710168408;
	bh=BLrHvxfbt9fUtA65skAta7I5uBq7a6xwCnd8KgeE6Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCXtWsATNBGJH2bZ0xBu79LmzRBOUK3SuwNrUwhQzE//y8A6DGjvkhtXoPFihu3Xt
	 2lxm2rm1AS0NPBwx05Hkl2yVWmSsx2z5lBTqcPQ9S7zLt3GP32phyvYYuw5gG03enE
	 U4evBUYGuJxpp6m5Fa/C36uRksxR+0SMDEmaepLU=
Date: Mon, 11 Mar 2024 15:46:36 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Alejandro Colomar <alx@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v10 2/9] landlock: Add IOCTL access right for character
 and block devices
Message-ID: <20240311.If7ieshaegu2@digikod.net>
References: <20240309075320.160128-1-gnoack@google.com>
 <20240309075320.160128-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240309075320.160128-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

Adding Alex, Jon and the API ML for interface-related question: file
type check or not?


On Sat, Mar 09, 2024 at 07:53:13AM +0000, Günther Noack wrote:
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

A few minor (or not) nitpicks, but overall I really like this series.

> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h                | 35 +++++++++++++-----
>  security/landlock/fs.c                       | 38 ++++++++++++++++++--
>  security/landlock/limits.h                   |  2 +-
>  security/landlock/syscalls.c                 |  8 +++--
>  tools/testing/selftests/landlock/base_test.c |  2 +-
>  tools/testing/selftests/landlock/fs_test.c   |  5 +--
>  6 files changed, 73 insertions(+), 17 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 25c8d7677539..193733d833b1 100644
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
> @@ -198,13 +199,30 @@ struct landlock_net_port_attr {
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
> + *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC``, ``FIOQSIZE``,
> + *   ``FIFREEZE``, ``FITHAW``, ``FS_IOC_FIEMAP``, ``FIGETBSZ``, ``FICLONE``,
> + *   ``FICLONERANGE``, ``FIDEDUPERANGE``, ``FS_IOC_GETFLAGS``,
> + *   ``FS_IOC_SETFLAGS``, ``FS_IOC_FSGETXATTR``, ``FS_IOC_FSSETXATTR``
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
> @@ -223,6 +241,7 @@ struct landlock_net_port_attr {
>  #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> +#define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
>  /* clang-format on */
>  
>  /**
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6f0bf1434a2c..bfa69ea94cf8 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -148,7 +148,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV)

We may want to check the file type to make sure we set the
LANDLOCK_ACCESS_FS_IOCTL_DEV right on char/block devices only, the same
way we already check with d_is_dir() [1].  From user space point of
view, it should not change much because a call to statfs(2) may already
be in place.  From kernel space point of view it would only be a matter
of checking the related inode in landlock_append_fs_rule().

Checking for the file type is not strictly necessarily, but I
implemented the d_is_dir() call and get_path_from_fd() checks to
encourage/force user space to check the file/directory on which it wants
to give access to (e.g. and not erroneously grant access to a whole file
hierarchy rather than a file thanks to statfs(2) information, not the
Landlock syscall itself).  Applications sandboxing themselves should not
be surprise that a file descriptor refers to a directory or a file, and
they should not require additional call to statfs(2).  Another
motivation was that I think this kind of conservative check would have
been difficult to implement later (with an option) because of the
potential user space architectural changes.  Finally, this kind of type
checking can be silently ignored with help from user space libraries
when needed.

About the char/block device check, it might also be a good idea for user
space to check the major/minor numbers to make sure they match
expectations (i.e. related IOCTL commands).

I'm convinced the get_path_from_fd() checks are good because special
files are not restricted (and can then be silently ignored without
impact), whereas a non-special file could still get a valid (super)set
of access rights (and maybe better follow the principle of least
astonishment?).  I'm wondering if checking dir/file was the best
decision, if this is enough, or if we should extend that to char/block
devices.  Any opinion an that?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/landlock/fs.c?h=v6.8#n166

>  /* clang-format on */
>  
>  /*
> @@ -1332,8 +1333,10 @@ static int hook_file_alloc_security(struct file *const file)
>  static int hook_file_open(struct file *const file)
>  {
>  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> -	access_mask_t open_access_request, full_access_request, allowed_access;
> -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	access_mask_t open_access_request, full_access_request, allowed_access,
> +		optional_access;
> +	const struct inode *inode = file_inode(file);
> +	const bool is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
>  	const struct landlock_ruleset *const dom = get_current_fs_domain();
>  
>  	if (!dom)
> @@ -1350,6 +1353,10 @@ static int hook_file_open(struct file *const file)
>  	 * We look up more access than what we immediately need for open(), so
>  	 * that we can later authorize operations on opened files.
>  	 */
> +	optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> +	if (is_device)
> +		optional_access |= LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +
>  	full_access_request = open_access_request | optional_access;
>  
>  	if (is_access_to_paths_allowed(
> @@ -1406,6 +1413,30 @@ static int hook_file_truncate(struct file *const file)
>  	return -EACCES;
>  }
>  
> +static int hook_file_vfs_ioctl(struct file *file, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	const struct inode *inode = file_inode(file);
> +	const bool is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> +	access_mask_t required_access, allowed_access;
> +
> +	if (!is_device)
> +		return 0;

We should first check landlock_file(file)->allowed_access as in
hook_file_truncate() to return as soon as possible for non-sandboxed
tasks.  Any other computation should be done after that (e.g. with an
is_device() helper).

> +
> +	/*
> +	 * It is the access rights at the time of opening the file which
> +	 * determine whether IOCTL can be used on the opened file later.
> +	 *
> +	 * The access right is attached to the opened file in hook_file_open().
> +	 */
> +	required_access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +	allowed_access = landlock_file(file)->allowed_access;
> +	if ((allowed_access & required_access) == required_access)
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
>  
> @@ -1428,6 +1459,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
>  	LSM_HOOK_INIT(file_open, hook_file_open),
>  	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> +	LSM_HOOK_INIT(file_vfs_ioctl, hook_file_vfs_ioctl),
>  };
>  
>  __init void landlock_add_fs_hooks(void)
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 93c9c6f91556..20fdb5ff3514 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -18,7 +18,7 @@
>  #define LANDLOCK_MAX_NUM_LAYERS		16
>  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>  
> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  #define LANDLOCK_SHIFT_ACCESS_FS	0
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 6788e73b6681..9ae3dfa47443 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -149,7 +149,7 @@ static const struct file_operations ruleset_fops = {
>  	.write = fop_dummy_write,
>  };
>  
> -#define LANDLOCK_ABI_VERSION 4
> +#define LANDLOCK_ABI_VERSION 5
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -321,7 +321,11 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
>  	if (!path_beneath_attr.allowed_access)
>  		return -ENOMSG;
>  
> -	/* Checks that allowed_access matches the @ruleset constraints. */
> +	/*
> +	 * Checks that allowed_access matches the @ruleset constraints and only
> +	 * consists of publicly visible access rights (as opposed to synthetic
> +	 * ones).
> +	 */

This change is not needed anymore.

>  	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
>  	if ((path_beneath_attr.allowed_access | mask) != mask)
>  		return -EINVAL;
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
> index 2d6d9b43d958..0bcbbf594fd7 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -527,9 +527,10 @@ TEST_F_FORK(layout1, inval)
>  	LANDLOCK_ACCESS_FS_EXECUTE | \
>  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>  	LANDLOCK_ACCESS_FS_READ_FILE | \
> -	LANDLOCK_ACCESS_FS_TRUNCATE)
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV)
>  
> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
>  
>  #define ACCESS_ALL ( \
>  	ACCESS_FILE | \
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

