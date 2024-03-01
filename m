Return-Path: <linux-fsdevel+bounces-13268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1486E16D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36901C22369
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BA24F1F8;
	Fri,  1 Mar 2024 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mGf4sBOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC076CDD6;
	Fri,  1 Mar 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297977; cv=none; b=JATVMI5HKmnYrEN+qWS4xzjtCLHn4AkjBTBad+aafepuCAZ+7e+BTq42P5xY5SmhY9qpc28s2JFrrXtgHfa72xjDFt+xgPcHr3F48D0Fq1+X013yTm2j2LUAe+o/LswvePHT9I0HH10RZX7CZKcT9wKX6B8Mudsp7f8Eobm68XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297977; c=relaxed/simple;
	bh=u5Nsg+3ZViQplYLt+TmSxITWUOBDXEth1pk1yS33PLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOkJUf7iInMtfFvObJRCZztvitlgRq7zV0buUPNNrTzE2h2KqIku62AgkPN7agCI6YoI0rJPzpfJnfeFCcU5DVOk7ZLxZpuJD8zcOsc7hfN2Er/C9RnFiYOCm4fQDoYRwGDYyypykMv6xdfnFVZfIvKnF9DICyuWZ7fajs5VIpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mGf4sBOe; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TmSpg2lRmz13bh;
	Fri,  1 Mar 2024 13:59:23 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TmSpf1YGyzN2Y;
	Fri,  1 Mar 2024 13:59:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709297963;
	bh=u5Nsg+3ZViQplYLt+TmSxITWUOBDXEth1pk1yS33PLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGf4sBOe5fFLByVSeQ8s3HRIQ1sqN/nYOrszOrJvElz6rLh1s0hykrnPn6PjZEd0K
	 +yhV7XeQT/OQx7EbNnJ+ES0zQeZt1uMN2haldpMYOi+lBnRh3AqUR9cUaGXTTVHRfO
	 QzSMZxM3MiUOhudzF3ZoKhbQlYuEpURKX4UFeQmk=
Date: Fri, 1 Mar 2024 13:59:12 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240301.eiGhingai1gi@digikod.net>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
 <20240219.chu4Yeegh3oo@digikod.net>
 <Zd8txvjeeXjRdeP-@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd8txvjeeXjRdeP-@google.com>
X-Infomaniak-Routing: alpha

On Wed, Feb 28, 2024 at 01:57:42PM +0100, Günther Noack wrote:
> Hello Mickaël!
> 
> On Mon, Feb 19, 2024 at 07:34:42PM +0100, Mickaël Salaün wrote:
> > Arn, Christian, please take a look at the following RFC patch and the
> > rationale explained here.
> > 
> > On Fri, Feb 09, 2024 at 06:06:05PM +0100, Günther Noack wrote:
> > > Introduces the LANDLOCK_ACCESS_FS_IOCTL access right
> > > and increments the Landlock ABI version to 5.
> > > 
> > > Like the truncate right, these rights are associated with a file
> > > descriptor at the time of open(2), and get respected even when the
> > > file descriptor is used outside of the thread which it was originally
> > > opened in.
> > > 
> > > A newly enabled Landlock policy therefore does not apply to file
> > > descriptors which are already open.
> > > 
> > > If the LANDLOCK_ACCESS_FS_IOCTL right is handled, only a small number
> > > of safe IOCTL commands will be permitted on newly opened files.  The
> > > permitted IOCTLs can be configured through the ruleset in limited ways
> > > now.  (See documentation for details.)
> > > 
> > > Specifically, when LANDLOCK_ACCESS_FS_IOCTL is handled, granting this
> > > right on a file or directory will *not* permit to do all IOCTL
> > > commands, but only influence the IOCTL commands which are not already
> > > handled through other access rights.  The intent is to keep the groups
> > > of IOCTL commands more fine-grained.
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
> > > Some legitimate file system features, like setting up fscrypt, are
> > > exposed as IOCTL commands on regular files and directories -- users of
> > > Landlock are advised to double check that the sandboxed process does
> > > not need to invoke these IOCTLs.
> > 
> > I think we really need to allow fscrypt and fs-verity IOCTLs.
> > 
> > > 
> > > Known limitations:
> > > 
> > > The LANDLOCK_ACCESS_FS_IOCTL access right is a coarse-grained control
> > > over IOCTL commands.  Future work will enable a more fine-grained
> > > access control for IOCTLs.
> > > 
> > > In the meantime, Landlock users may use path-based restrictions in
> > > combination with their knowledge about the file system layout to
> > > control what IOCTLs can be done.  Mounting file systems with the nodev
> > > option can help to distinguish regular files and devices, and give
> > > guarantees about the affected files, which Landlock alone can not give
> > > yet.
> > 
> > I had a second though about our current approach, and it looks like we
> > can do simpler, more generic, and with less IOCTL commands specific
> > handling.
> > 
> > What we didn't take into account is that an IOCTL needs an opened file,
> > which means that the caller must already have been allowed to open this
> > file in read or write mode.
> > 
> > I think most FS-specific IOCTL commands check access rights (i.e. access
> > mode or required capability), other than implicit ones (at least read or
> > write), when appropriate.  We don't get such guarantee with device
> > drivers.
> > 
> > The main threat is IOCTLs on character or block devices because their
> > impact may be unknown (if we only look at the IOCTL command, not the
> > backing file), but we should allow IOCTLs on filesystems (e.g. fscrypt,
> > fs-verity, clone extents).  I think we should only implement a
> > LANDLOCK_ACCESS_FS_IOCTL_DEV right, which would be more explicit.  This
> > change would impact the IOCTLs grouping (not required anymore), but
> > we'll still need the list of VFS IOCTLs.
> 
> 
> I am fine with dropping the IOCTL grouping and going for this simpler approach.
> 
> This must have been a misunderstanding - I thought you wanted to align the
> access checks in Landlock with the ones done by the kernel already, so that we
> can reason about it more locally.  But I'm fine with doing it just for device
> files as well, if that is what it takes.  It's definitely simpler.

I still think we should align existing Landlock access rights with the VFS IOCTL
semantic (i.e. mostly defined in do_vfs_ioctl(), but also in the compat
ioctl syscall).  However, according to our investigations and
discussions, it looks like the groups we defined should already be
enforced by the VFS code, which means we should not need such groups
after all.  My last proposal is to still delegate access for VFS IOCTLs
to the current Landlock access rights, but it doesn't seem required to
add specific access check if we are able to identify these VFS IOCTLs.

> 
> Before I jump into the implementation, let me paraphrase your proposal to make
> sure I understood it correctly:
> 
>  * We *only* introduce the LANDLOCK_ACCESS_FS_IOCTL_DEV right.

Yes

> 
>  * This access right governs the use of nontrivial IOCTL commands on
>    character and block device files.
> 
>    * On open()ed files which are not character or block devices,
>      all IOCTL commands keep working.

Yes

> 
>      This includes pipes and sockets, but also a variety of "anonymous" file
>      types which are possibly openable through /proc/self/*/fd/*?

Indeed, and we should document that. It should be noted that these
"anonymous" file types only comes from dedicated syscalls (which are not
currently controlled by Landlock) or from this synthetic proc interface.
One thing to keep in mind is that /proc/*/fd/* can only be opened on
tasks under the same sandbox (or a child one), so we should consider
that they are explicitly allowed by the policy the same way
pre-sandboxed inherited file descriptors are.

It might be interesting to list a few of such anonymous file types.  Are
there any that can act on global resources (like block/char devices
can)?

I also think that most anonymous file types should check for FD's read
and write mode when it makes sense (which is not the case for most
block/char IOCTLs), but I might be wrong.

I think this LANDLOCK_ACCESS_FS_IOCTL_DEV design would be good for now,
and probably enough for most use cases.  This would fill a major gap in
an easy-to-understand-and-document way.

> 
>  * The trivial IOCTL commands are identified using the proposed function
>    vfs_masked_device_ioctl().
> 
>    * For these commands, the implementations are in fs/ioctl.c, except for
>      FIONREAD, in some cases.  We trust these implementations to check the
>      file's type (dir/regular) and access rights (r/w) correctly.

FIONREAD is explicitly not part of vfs_masked_device_ioctl() because it
is only defined for regular files (and forwarded to the underlying
implementation otherwise), hence the "masked_device" name. If the
underlying filesystem handles this IOCTL command for directory that's
fine, and we don't need explicit exception.

> 
> 
> Open questions I have:
> 
> * What about files which are neither devices nor regular files or directories?
> 
>   The obvious ones which can be open()ed are pipes, where only FIONREAND and two
>   harmless-looking watch queue IOCTLs are implemented.
> 
>   But then I think that /proc/*/fd/* is a way through which other non-device
>   files can become accessible?  What do we do for these?  (I am getting EACCES
>   when trying to open some anon_inodes that way... is this something we can
>   count on?)

As explained above, /proc/*/fd/* is already restricted per sandbox
scopes, which seem enough.

> 
> * How did you come up with the list in vfs_masked_device_ioctl()?  I notice that
>   some of these are from the switch() statement we had before, but not all of
>   them are included.
> 
>   I can kind of see that for the fallocate()-like ones and for FIBMAP, because
>   these **only** make sense for regular files, and IOCTLs on regular files are
>   permitted anyway.

I took inspiration from get_required_ioctl_access(), and built this list
looking at which of the VFS IOCTLs go through the VFS implementation
(mostly do_vfs_ioctl() but also the compat syscall) for IOCTL requests
on *block and character devices*.

The initial assumption is that file systems cannot implement block nor
character device IOCTLs, which is why this approach seems safe and
consistent.

> 
> * What do we do for FIONREAD?  Your patch says that it should be forwarded to
>   device implementations.  But technically, devices can implement all kinds of
>   surprising behaviour for that.

FIONREAD should always be allowed for non-device files (which means on
allowed-to-be-opened and non-device files), and controlled with
LANDLOCK_ACCESS_FS_IOCTL_DEV for character and block devices.

> 
>   If you look at the ioctl implementations of different drivers, you can very
>   quickly find a surprising amount of things that happen completely independent
>   of the IOCTL command.  (Some implementations are acquiring locks and other
>   resources before they even check what the cmd value is. - and we would be
>   exposing that if we let devices handle FIONREAD).

Correct, which is why FIONREAD on devices should be controlled by
LANDLOCK_ACCESS_FS_IOCTL_DEV.  See my previous email (below) with the
"is_device" checks.

> 
> 
> Please let me know whether I understood you correctly there.

I think so, but I guess you missed the "is_device" part.

> 
> Regarding the implementation notes you left below, I think they mostly derive
> from the *_IOCTL_DEV approach in a direct way.

Yes

> 
> 
> > > +static __attribute_const__ access_mask_t
> > > +get_required_ioctl_access(const unsigned int cmd)
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
> > > +	case FIONREAD:
> > > +	case FIOQSIZE:
> > > +	case FIGETBSZ:
> > > +		/*
> > > +		 * FIONREAD returns the number of bytes available for reading.
> > > +		 * FIONREAD returns the number of immediately readable bytes for
> > > +		 * a file.
> > > +		 *
> > > +		 * FIOQSIZE queries the size of a file or directory.
> > > +		 *
> > > +		 * FIGETBSZ queries the file system's block size for a file or
> > > +		 * directory.
> > > +		 *
> > > +		 * These IOCTL commands are permitted for files which are opened
> > > +		 * with LANDLOCK_ACCESS_FS_READ_DIR,
> > > +		 * LANDLOCK_ACCESS_FS_READ_FILE, or
> > > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > > +		 */
> > 
> > Because files or directories can only be opened with
> > LANDLOCK_ACCESS_FS_{READ,WRITE}_{FILE,DIR}, and because IOCTLs can only
> > be sent on a file descriptor, this means that we can always allow these
> > 3 commands (for opened files).
> > 
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_RW;
> > > +	case FS_IOC_FIEMAP:
> > > +	case FIBMAP:
> > > +		/*
> > > +		 * FS_IOC_FIEMAP and FIBMAP query information about the
> > > +		 * allocation of blocks within a file.  They are permitted for
> > > +		 * files which are opened with LANDLOCK_ACCESS_FS_READ_FILE or
> > > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > > +		 */
> > > +		fallthrough;
> > > +	case FIDEDUPERANGE:
> > > +	case FICLONE:
> > > +	case FICLONERANGE:
> > > +		/*
> > > +		 * FIDEDUPERANGE, FICLONE and FICLONERANGE make files share
> > > +		 * their underlying storage ("reflink") between source and
> > > +		 * destination FDs, on file systems which support that.
> > > +		 *
> > > +		 * The underlying implementations are already checking whether
> > > +		 * the involved files are opened with the appropriate read/write
> > > +		 * modes.  We rely on this being implemented correctly.
> > > +		 *
> > > +		 * These IOCTLs are permitted for files which are opened with
> > > +		 * LANDLOCK_ACCESS_FS_READ_FILE or
> > > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > > +		 */
> > > +		fallthrough;
> > > +	case FS_IOC_RESVSP:
> > > +	case FS_IOC_RESVSP64:
> > > +	case FS_IOC_UNRESVSP:
> > > +	case FS_IOC_UNRESVSP64:
> > > +	case FS_IOC_ZERO_RANGE:
> > > +		/*
> > > +		 * These IOCTLs reserve space, or create holes like
> > > +		 * fallocate(2).  We rely on the implementations checking the
> > > +		 * files' read/write modes.
> > > +		 *
> > > +		 * These IOCTLs are permitted for files which are opened with
> > > +		 * LANDLOCK_ACCESS_FS_READ_FILE or
> > > +		 * LANDLOCK_ACCESS_FS_WRITE_FILE.
> > > +		 */
> > 
> > These 10 commands only make sense on directories, so we could also
> > always allow them on file descriptors.
> 
> I imagine that's a typo?  The commands above do make sense on regular files.

Yes, I meant they "only make sense on regular files".

> 
> 
> > > +		return LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> > > +	default:
> > > +		/*
> > > +		 * Other commands are guarded by the catch-all access right.
> > > +		 */
> > > +		return LANDLOCK_ACCESS_FS_IOCTL;
> > > +	}
> > > +}
> > > +
> > > +/**
> > > + * expand_ioctl() - Return the dst flags from either the src flag or the
> > > + * %LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
> > > + * %LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
> > > + *
> > > + * @handled: Handled access rights.
> > > + * @access: The access mask to copy values from.
> > > + * @src: A single access right to copy from in @access.
> > > + * @dst: One or more access rights to copy to.
> > > + *
> > > + * Returns: @dst, or 0.
> > > + */
> > > +static __attribute_const__ access_mask_t
> > > +expand_ioctl(const access_mask_t handled, const access_mask_t access,
> > > +	     const access_mask_t src, const access_mask_t dst)
> > > +{
> > > +	access_mask_t copy_from;
> > > +
> > > +	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> > > +		return 0;
> > > +
> > > +	copy_from = (handled & src) ? src : LANDLOCK_ACCESS_FS_IOCTL;
> > > +	if (access & copy_from)
> > > +		return dst;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * landlock_expand_access_fs() - Returns @access with the synthetic IOCTL group
> > > + * flags enabled if necessary.
> > > + *
> > > + * @handled: Handled FS access rights.
> > > + * @access: FS access rights to expand.
> > > + *
> > > + * Returns: @access expanded by the necessary flags for the synthetic IOCTL
> > > + * access rights.
> > > + */
> > > +static __attribute_const__ access_mask_t landlock_expand_access_fs(
> > > +	const access_mask_t handled, const access_mask_t access)
> > > +{
> > > +	return access |
> > > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_WRITE_FILE,
> > > +			    LANDLOCK_ACCESS_FS_IOCTL_RW |
> > > +				    LANDLOCK_ACCESS_FS_IOCTL_RW_FILE) |
> > > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_FILE,
> > > +			    LANDLOCK_ACCESS_FS_IOCTL_RW |
> > > +				    LANDLOCK_ACCESS_FS_IOCTL_RW_FILE) |
> > > +	       expand_ioctl(handled, access, LANDLOCK_ACCESS_FS_READ_DIR,
> > > +			    LANDLOCK_ACCESS_FS_IOCTL_RW);
> > > +}
> > > +
> > > +/**
> > > + * landlock_expand_handled_access_fs() - add synthetic IOCTL access rights to an
> > > + * access mask of handled accesses.
> > > + *
> > > + * @handled: The handled accesses of a ruleset that is being created.
> > > + *
> > > + * Returns: @handled, with the bits for the synthetic IOCTL access rights set,
> > > + * if %LANDLOCK_ACCESS_FS_IOCTL is handled.
> > > + */
> > > +__attribute_const__ access_mask_t
> > > +landlock_expand_handled_access_fs(const access_mask_t handled)
> > > +{
> > > +	return landlock_expand_access_fs(handled, handled);
> > > +}
> > > +
> > >  /* Ruleset management */
> > >  
> > >  static struct landlock_object *get_inode_object(struct inode *const inode)
> > > @@ -148,7 +331,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> > >  	LANDLOCK_ACCESS_FS_EXECUTE | \
> > >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > > +	LANDLOCK_ACCESS_FS_IOCTL)
> > >  /* clang-format on */
> > >  
> > >  /*
> > > @@ -158,6 +342,7 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> > >  			    const struct path *const path,
> > >  			    access_mask_t access_rights)
> > >  {
> > > +	access_mask_t handled;
> > >  	int err;
> > >  	struct landlock_id id = {
> > >  		.type = LANDLOCK_KEY_INODE,
> > > @@ -170,9 +355,11 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
> > >  	if (WARN_ON_ONCE(ruleset->num_layers != 1))
> > >  		return -EINVAL;
> > >  
> > > +	handled = landlock_get_fs_access_mask(ruleset, 0);
> > > +	/* Expands the synthetic IOCTL groups. */
> > > +	access_rights |= landlock_expand_access_fs(handled, access_rights);
> > >  	/* Transforms relative access rights to absolute ones. */
> > > -	access_rights |= LANDLOCK_MASK_ACCESS_FS &
> > > -			 ~landlock_get_fs_access_mask(ruleset, 0);
> > > +	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~handled;
> > >  	id.key.object = get_inode_object(d_backing_inode(path->dentry));
> > >  	if (IS_ERR(id.key.object))
> > >  		return PTR_ERR(id.key.object);
> > > @@ -1333,7 +1520,9 @@ static int hook_file_open(struct file *const file)
> > >  {
> > >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> > >  	access_mask_t open_access_request, full_access_request, allowed_access;
> > > -	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> > > +	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE |
> > > +					      LANDLOCK_ACCESS_FS_IOCTL |
> > > +					      IOCTL_GROUPS;
> > >  	const struct landlock_ruleset *const dom = get_current_fs_domain();
> > >  
> > >  	if (!dom)
> > 
> > We should set optional_access according to the file type before
> > `full_access_request = open_access_request | optional_access;`
> > 
> > const bool is_device = S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode);
> > 
> > optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
> > if (is_device)
> >     optional_access |= LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > 
> > 
> > Because LANDLOCK_ACCESS_FS_IOCTL_DEV is dedicated to character or block
> > devices, we may want landlock_add_rule() to only allow this access right
> > to be tied to directories, or character devices, or block devices.  Even
> > if it would be more consistent with constraints on directory-only access
> > rights, I'm not sure about that.
> > 
> > 
> > > @@ -1375,6 +1564,16 @@ static int hook_file_open(struct file *const file)
> > >  		}
> > >  	}
> > >  
> > > +	/*
> > > +	 * Named pipes should be treated just like anonymous pipes.
> > > +	 * Therefore, we permit all IOCTLs on them.
> > > +	 */
> > > +	if (S_ISFIFO(file_inode(file)->i_mode)) {
> > > +		allowed_access |= LANDLOCK_ACCESS_FS_IOCTL |
> > > +				  LANDLOCK_ACCESS_FS_IOCTL_RW |
> > > +				  LANDLOCK_ACCESS_FS_IOCTL_RW_FILE;
> > > +	}
> > 
> > Instead of this S_ISFIFO check:
> > 
> > if (!is_device)
> >     allowed_access |= LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > 
> > > +
> > >  	/*
> > >  	 * For operations on already opened files (i.e. ftruncate()), it is the
> > >  	 * access rights at the time of open() which decide whether the
> > > @@ -1406,6 +1605,25 @@ static int hook_file_truncate(struct file *const file)
> > >  	return -EACCES;
> > >  }
> > >  
> > > +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> > > +			   unsigned long arg)
> > > +{
> > > +	const access_mask_t required_access = get_required_ioctl_access(cmd);
> > 
> > const access_mask_t required_access = LANDLOCK_ACCESS_FS_IOCTL_DEV;
> > 
> > 
> > > +	const access_mask_t allowed_access =
> > > +		landlock_file(file)->allowed_access;
> > > +
> > > +	/*
> > > +	 * It is the access rights at the time of opening the file which
> > > +	 * determine whether IOCTL can be used on the opened file later.
> > > +	 *
> > > +	 * The access right is attached to the opened file in hook_file_open().
> > > +	 */
> > > +	if ((allowed_access & required_access) == required_access)
> > > +		return 0;
> > 
> > We could then check against the do_vfs_ioctl()'s commands, excluding
> > FIONREAD and file_ioctl()'s commands, to always allow VFS-related
> > commands:
> > 
> > if (vfs_masked_device_ioctl(cmd))
> >     return 0;
> > 
> > As a safeguard, we could define vfs_masked_device_ioctl(cmd) in
> > fs/ioctl.c and make it called by do_vfs_ioctl() as a safeguard to make
> > sure we keep an accurate list of VFS IOCTL commands (see next RFC patch).
> 
> 
> > The compat IOCTL hook must also be implemented.
> 
> Thanks!  I can't believe I missed that one.
> 
> 
> > What do you think? Any better idea?
> 
> It seems like a reasonable approach.  I'd like to double check with you that we
> are on the same page about it before doing the next implementation step.  (These
> iterations seems cheaper when we do them in English than when we do them in C.)

We only reached this design because of the previous iterations, reviews
and discussions.  Implementations details matter in this case and it's
good to take time to convince ourselves of the best approach (and to
understand how underlying implementations work).  Finding a "simple"
interface that makes sense to control IOCTLs in an efficient way wasn't
obvious but I'm convinced we got it now.

Thanks for your perseverance!

> 
> Thanks for the review!
> —Günther
> 

