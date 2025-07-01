Return-Path: <linux-fsdevel+bounces-53495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23E3AEF8CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74881C0080F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0307B273D81;
	Tue,  1 Jul 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUmRrzse";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nRdckrHW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cFUsBPG8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdzvgwh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B71DA60D
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373506; cv=none; b=h4Y8nA+cs5eb+SkYAiw7DqMbB98yzlfrPyfG4xRl/JkImuViOGnKi5cytznif9mb0zsEzn3mpYTXiMezq4l8spcIsYEZT+QQHA0UbLSlISH+V0HGQQo4mGkG1JrWZ9FBMatHyecJed9RJXO9SpjHLLwRo3Nc8GsfQbnr7jTuT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373506; c=relaxed/simple;
	bh=r9XUkDK6k5covBpTmy67KcB7tv3xPLVX3EqCwVGptqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsNIzk5zKpup1k96nSitXQCQ3Rs9Gs2WoEdid63i+aFxmyy9W7ACisyyVmoalhUYbRvbRE8AnDrhWrnF73jJzVffh4m7sHVLBVc3qr4l1F6fzGSKE6wDvYsZvsjHQ3kf03pA409jIzdffvWuQxrAUYBMzsVLF1dT4wb6bhKvz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TUmRrzse; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nRdckrHW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cFUsBPG8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdzvgwh4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C2131F444;
	Tue,  1 Jul 2025 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751373501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7snTiFyHzeMiMewhy1BseBdTwMoEPOMwHTiq0jL+jM=;
	b=TUmRrzsenALWMelaCW0Urzdwmc7zrislOuvwuNT4f1W+NyxZayagy9yaRJoZZBsXAJVIEf
	NzSwmxH2BPnUd+O/Qn78k2iJHH9AXstUBQw/W2oQGSl9IhHMcn13bN6fYPv5cnc9UMFXyj
	XCHXtGEZrup1Y8RQZACbkVdrTGaWTEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751373501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7snTiFyHzeMiMewhy1BseBdTwMoEPOMwHTiq0jL+jM=;
	b=nRdckrHWm7yUD/PRUhLtclhQoxM8h9/JcceB24Ikn1Hr3bshKvyBmTeH1xo9dhZwvfS7kT
	B3D1cyXOYL/0//Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751373500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7snTiFyHzeMiMewhy1BseBdTwMoEPOMwHTiq0jL+jM=;
	b=cFUsBPG87xL1YCTkGMT/urlrKu/jl4Ado5moJMYpRIPnIdU82MLXLaouDGN92eOXcr8Yq5
	rW9qqNHywnVt0In9PjZyuIjyoggbxIWk1J1JPRZyZNEcaTBRBYSaSSVdViBRIL0uhaoid7
	751j4VMJxTlawel+NCdQqKG/tXySbAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751373500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7snTiFyHzeMiMewhy1BseBdTwMoEPOMwHTiq0jL+jM=;
	b=fdzvgwh4TuDG1he30wF6HokjJbmx51iI9e0xgrlNsfaarydd5Wk9ZxuOSRSVaMSg6m9dFq
	asWZCSAvy6CIlrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BA1D1364B;
	Tue,  1 Jul 2025 12:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xYBXFrzWY2jTawAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 12:38:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E779EA0953; Tue,  1 Jul 2025 14:38:19 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:38:19 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 1/6] fs: split fileattr related helpers into separate
 file
Message-ID: <m43lttz4jxaiaiuxcxmzxust5et5odzeig2mnn5ea6wf5bdzef@sp3zmcu6jqd4>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-1-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-1-c4e3bc35227b@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arndb.de,schaufler-ca.com,kernel.org,suse.cz,paul-moore.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 30-06-25 18:20:11, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@kernel.org>
> 
> This patch moves function related to file extended attributes
> manipulations to separate file. Refactoring only.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/Makefile              |   3 +-
>  fs/file_attr.c           | 318 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ioctl.c               | 309 ---------------------------------------------
>  include/linux/fileattr.h |   4 +
>  4 files changed, 324 insertions(+), 310 deletions(-)
> 
> diff --git a/fs/Makefile b/fs/Makefile
> index 79c08b914c47..334654f9584b 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -15,7 +15,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
>  		pnode.o splice.o sync.o utimes.o d_path.o \
>  		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
>  		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
> -		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o
> +		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
> +		file_attr.o
>  
>  obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
>  obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> new file mode 100644
> index 000000000000..2910b7047721
> --- /dev/null
> +++ b/fs/file_attr.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/fs.h>
> +#include <linux/security.h>
> +#include <linux/fscrypt.h>
> +#include <linux/fileattr.h>
> +
> +/**
> + * fileattr_fill_xflags - initialize fileattr with xflags
> + * @fa:		fileattr pointer
> + * @xflags:	FS_XFLAG_* flags
> + *
> + * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> + * other fields are zeroed.
> + */
> +void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
> +{
> +	memset(fa, 0, sizeof(*fa));
> +	fa->fsx_valid = true;
> +	fa->fsx_xflags = xflags;
> +	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> +		fa->flags |= FS_IMMUTABLE_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_APPEND)
> +		fa->flags |= FS_APPEND_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_SYNC)
> +		fa->flags |= FS_SYNC_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
> +		fa->flags |= FS_NOATIME_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
> +		fa->flags |= FS_NODUMP_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_DAX)
> +		fa->flags |= FS_DAX_FL;
> +	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
> +		fa->flags |= FS_PROJINHERIT_FL;
> +}
> +EXPORT_SYMBOL(fileattr_fill_xflags);
> +
> +/**
> + * fileattr_fill_flags - initialize fileattr with flags
> + * @fa:		fileattr pointer
> + * @flags:	FS_*_FL flags
> + *
> + * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> + * All other fields are zeroed.
> + */
> +void fileattr_fill_flags(struct fileattr *fa, u32 flags)
> +{
> +	memset(fa, 0, sizeof(*fa));
> +	fa->flags_valid = true;
> +	fa->flags = flags;
> +	if (fa->flags & FS_SYNC_FL)
> +		fa->fsx_xflags |= FS_XFLAG_SYNC;
> +	if (fa->flags & FS_IMMUTABLE_FL)
> +		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
> +	if (fa->flags & FS_APPEND_FL)
> +		fa->fsx_xflags |= FS_XFLAG_APPEND;
> +	if (fa->flags & FS_NODUMP_FL)
> +		fa->fsx_xflags |= FS_XFLAG_NODUMP;
> +	if (fa->flags & FS_NOATIME_FL)
> +		fa->fsx_xflags |= FS_XFLAG_NOATIME;
> +	if (fa->flags & FS_DAX_FL)
> +		fa->fsx_xflags |= FS_XFLAG_DAX;
> +	if (fa->flags & FS_PROJINHERIT_FL)
> +		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
> +}
> +EXPORT_SYMBOL(fileattr_fill_flags);
> +
> +/**
> + * vfs_fileattr_get - retrieve miscellaneous file attributes
> + * @dentry:	the object to retrieve from
> + * @fa:		fileattr pointer
> + *
> + * Call i_op->fileattr_get() callback, if exists.
> + *
> + * Return: 0 on success, or a negative error on failure.
> + */
> +int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> +{
> +	struct inode *inode = d_inode(dentry);
> +
> +	if (!inode->i_op->fileattr_get)
> +		return -ENOIOCTLCMD;
> +
> +	return inode->i_op->fileattr_get(dentry, fa);
> +}
> +EXPORT_SYMBOL(vfs_fileattr_get);
> +
> +/**
> + * copy_fsxattr_to_user - copy fsxattr to userspace.
> + * @fa:		fileattr pointer
> + * @ufa:	fsxattr user pointer
> + *
> + * Return: 0 on success, or -EFAULT on failure.
> + */
> +int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
> +{
> +	struct fsxattr xfa;
> +
> +	memset(&xfa, 0, sizeof(xfa));
> +	xfa.fsx_xflags = fa->fsx_xflags;
> +	xfa.fsx_extsize = fa->fsx_extsize;
> +	xfa.fsx_nextents = fa->fsx_nextents;
> +	xfa.fsx_projid = fa->fsx_projid;
> +	xfa.fsx_cowextsize = fa->fsx_cowextsize;
> +
> +	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(copy_fsxattr_to_user);
> +
> +static int copy_fsxattr_from_user(struct fileattr *fa,
> +				  struct fsxattr __user *ufa)
> +{
> +	struct fsxattr xfa;
> +
> +	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> +		return -EFAULT;
> +
> +	fileattr_fill_xflags(fa, xfa.fsx_xflags);
> +	fa->fsx_extsize = xfa.fsx_extsize;
> +	fa->fsx_nextents = xfa.fsx_nextents;
> +	fa->fsx_projid = xfa.fsx_projid;
> +	fa->fsx_cowextsize = xfa.fsx_cowextsize;
> +
> +	return 0;
> +}
> +
> +/*
> + * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
> + * any invalid configurations.
> + *
> + * Note: must be called with inode lock held.
> + */
> +static int fileattr_set_prepare(struct inode *inode,
> +			      const struct fileattr *old_ma,
> +			      struct fileattr *fa)
> +{
> +	int err;
> +
> +	/*
> +	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> +	 * the relevant capability.
> +	 */
> +	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> +	    !capable(CAP_LINUX_IMMUTABLE))
> +		return -EPERM;
> +
> +	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Project Quota ID state is only allowed to change from within the init
> +	 * namespace. Enforce that restriction only if we are trying to change
> +	 * the quota ID state. Everything else is allowed in user namespaces.
> +	 */
> +	if (current_user_ns() != &init_user_ns) {
> +		if (old_ma->fsx_projid != fa->fsx_projid)
> +			return -EINVAL;
> +		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
> +				FS_XFLAG_PROJINHERIT)
> +			return -EINVAL;
> +	} else {
> +		/*
> +		 * Caller is allowed to change the project ID. If it is being
> +		 * changed, make sure that the new value is valid.
> +		 */
> +		if (old_ma->fsx_projid != fa->fsx_projid &&
> +		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
> +			return -EINVAL;
> +	}
> +
> +	/* Check extent size hints. */
> +	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> +			!S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> +	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +		return -EINVAL;
> +
> +	/*
> +	 * It is only valid to set the DAX flag on regular files and
> +	 * directories on filesystems.
> +	 */
> +	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> +		return -EINVAL;
> +
> +	/* Extent size hints of zero turn off the flags. */
> +	if (fa->fsx_extsize == 0)
> +		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
> +	if (fa->fsx_cowextsize == 0)
> +		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> +
> +	return 0;
> +}
> +
> +/**
> + * vfs_fileattr_set - change miscellaneous file attributes
> + * @idmap:	idmap of the mount
> + * @dentry:	the object to change
> + * @fa:		fileattr pointer
> + *
> + * After verifying permissions, call i_op->fileattr_set() callback, if
> + * exists.
> + *
> + * Verifying attributes involves retrieving current attributes with
> + * i_op->fileattr_get(), this also allows initializing attributes that have
> + * not been set by the caller to current values.  Inode lock is held
> + * thoughout to prevent racing with another instance.
> + *
> + * Return: 0 on success, or a negative error on failure.
> + */
> +int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
> +		     struct fileattr *fa)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct fileattr old_ma = {};
> +	int err;
> +
> +	if (!inode->i_op->fileattr_set)
> +		return -ENOIOCTLCMD;
> +
> +	if (!inode_owner_or_capable(idmap, inode))
> +		return -EPERM;
> +
> +	inode_lock(inode);
> +	err = vfs_fileattr_get(dentry, &old_ma);
> +	if (!err) {
> +		/* initialize missing bits from old_ma */
> +		if (fa->flags_valid) {
> +			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
> +			fa->fsx_extsize = old_ma.fsx_extsize;
> +			fa->fsx_nextents = old_ma.fsx_nextents;
> +			fa->fsx_projid = old_ma.fsx_projid;
> +			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
> +		} else {
> +			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
> +		}
> +		err = fileattr_set_prepare(inode, &old_ma, fa);
> +		if (!err)
> +			err = inode->i_op->fileattr_set(idmap, dentry, fa);
> +	}
> +	inode_unlock(inode);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(vfs_fileattr_set);
> +
> +int ioctl_getflags(struct file *file, unsigned int __user *argp)
> +{
> +	struct fileattr fa = { .flags_valid = true }; /* hint only */
> +	int err;
> +
> +	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (!err)
> +		err = put_user(fa.flags, argp);
> +	return err;
> +}
> +EXPORT_SYMBOL(ioctl_getflags);
> +
> +int ioctl_setflags(struct file *file, unsigned int __user *argp)
> +{
> +	struct mnt_idmap *idmap = file_mnt_idmap(file);
> +	struct dentry *dentry = file->f_path.dentry;
> +	struct fileattr fa;
> +	unsigned int flags;
> +	int err;
> +
> +	err = get_user(flags, argp);
> +	if (!err) {
> +		err = mnt_want_write_file(file);
> +		if (!err) {
> +			fileattr_fill_flags(&fa, flags);
> +			err = vfs_fileattr_set(idmap, dentry, &fa);
> +			mnt_drop_write_file(file);
> +		}
> +	}
> +	return err;
> +}
> +EXPORT_SYMBOL(ioctl_setflags);
> +
> +int ioctl_fsgetxattr(struct file *file, void __user *argp)
> +{
> +	struct fileattr fa = { .fsx_valid = true }; /* hint only */
> +	int err;
> +
> +	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> +	if (!err)
> +		err = copy_fsxattr_to_user(&fa, argp);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(ioctl_fsgetxattr);
> +
> +int ioctl_fssetxattr(struct file *file, void __user *argp)
> +{
> +	struct mnt_idmap *idmap = file_mnt_idmap(file);
> +	struct dentry *dentry = file->f_path.dentry;
> +	struct fileattr fa;
> +	int err;
> +
> +	err = copy_fsxattr_from_user(&fa, argp);
> +	if (!err) {
> +		err = mnt_want_write_file(file);
> +		if (!err) {
> +			err = vfs_fileattr_set(idmap, dentry, &fa);
> +			mnt_drop_write_file(file);
> +		}
> +	}
> +	return err;
> +}
> +EXPORT_SYMBOL(ioctl_fssetxattr);
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 69107a245b4c..0248cb8db2d3 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -453,315 +453,6 @@ static int ioctl_file_dedupe_range(struct file *file,
>  	return ret;
>  }
>  
> -/**
> - * fileattr_fill_xflags - initialize fileattr with xflags
> - * @fa:		fileattr pointer
> - * @xflags:	FS_XFLAG_* flags
> - *
> - * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> - * other fields are zeroed.
> - */
> -void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
> -{
> -	memset(fa, 0, sizeof(*fa));
> -	fa->fsx_valid = true;
> -	fa->fsx_xflags = xflags;
> -	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> -		fa->flags |= FS_IMMUTABLE_FL;
> -	if (fa->fsx_xflags & FS_XFLAG_APPEND)
> -		fa->flags |= FS_APPEND_FL;
> -	if (fa->fsx_xflags & FS_XFLAG_SYNC)
> -		fa->flags |= FS_SYNC_FL;
> -	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
> -		fa->flags |= FS_NOATIME_FL;
> -	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
> -		fa->flags |= FS_NODUMP_FL;
> -	if (fa->fsx_xflags & FS_XFLAG_DAX)
> -		fa->flags |= FS_DAX_FL;
> -	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
> -		fa->flags |= FS_PROJINHERIT_FL;
> -}
> -EXPORT_SYMBOL(fileattr_fill_xflags);
> -
> -/**
> - * fileattr_fill_flags - initialize fileattr with flags
> - * @fa:		fileattr pointer
> - * @flags:	FS_*_FL flags
> - *
> - * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> - * All other fields are zeroed.
> - */
> -void fileattr_fill_flags(struct fileattr *fa, u32 flags)
> -{
> -	memset(fa, 0, sizeof(*fa));
> -	fa->flags_valid = true;
> -	fa->flags = flags;
> -	if (fa->flags & FS_SYNC_FL)
> -		fa->fsx_xflags |= FS_XFLAG_SYNC;
> -	if (fa->flags & FS_IMMUTABLE_FL)
> -		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
> -	if (fa->flags & FS_APPEND_FL)
> -		fa->fsx_xflags |= FS_XFLAG_APPEND;
> -	if (fa->flags & FS_NODUMP_FL)
> -		fa->fsx_xflags |= FS_XFLAG_NODUMP;
> -	if (fa->flags & FS_NOATIME_FL)
> -		fa->fsx_xflags |= FS_XFLAG_NOATIME;
> -	if (fa->flags & FS_DAX_FL)
> -		fa->fsx_xflags |= FS_XFLAG_DAX;
> -	if (fa->flags & FS_PROJINHERIT_FL)
> -		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
> -}
> -EXPORT_SYMBOL(fileattr_fill_flags);
> -
> -/**
> - * vfs_fileattr_get - retrieve miscellaneous file attributes
> - * @dentry:	the object to retrieve from
> - * @fa:		fileattr pointer
> - *
> - * Call i_op->fileattr_get() callback, if exists.
> - *
> - * Return: 0 on success, or a negative error on failure.
> - */
> -int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> -{
> -	struct inode *inode = d_inode(dentry);
> -
> -	if (!inode->i_op->fileattr_get)
> -		return -ENOIOCTLCMD;
> -
> -	return inode->i_op->fileattr_get(dentry, fa);
> -}
> -EXPORT_SYMBOL(vfs_fileattr_get);
> -
> -/**
> - * copy_fsxattr_to_user - copy fsxattr to userspace.
> - * @fa:		fileattr pointer
> - * @ufa:	fsxattr user pointer
> - *
> - * Return: 0 on success, or -EFAULT on failure.
> - */
> -int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
> -{
> -	struct fsxattr xfa;
> -
> -	memset(&xfa, 0, sizeof(xfa));
> -	xfa.fsx_xflags = fa->fsx_xflags;
> -	xfa.fsx_extsize = fa->fsx_extsize;
> -	xfa.fsx_nextents = fa->fsx_nextents;
> -	xfa.fsx_projid = fa->fsx_projid;
> -	xfa.fsx_cowextsize = fa->fsx_cowextsize;
> -
> -	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(copy_fsxattr_to_user);
> -
> -static int copy_fsxattr_from_user(struct fileattr *fa,
> -				  struct fsxattr __user *ufa)
> -{
> -	struct fsxattr xfa;
> -
> -	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
> -		return -EFAULT;
> -
> -	fileattr_fill_xflags(fa, xfa.fsx_xflags);
> -	fa->fsx_extsize = xfa.fsx_extsize;
> -	fa->fsx_nextents = xfa.fsx_nextents;
> -	fa->fsx_projid = xfa.fsx_projid;
> -	fa->fsx_cowextsize = xfa.fsx_cowextsize;
> -
> -	return 0;
> -}
> -
> -/*
> - * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
> - * any invalid configurations.
> - *
> - * Note: must be called with inode lock held.
> - */
> -static int fileattr_set_prepare(struct inode *inode,
> -			      const struct fileattr *old_ma,
> -			      struct fileattr *fa)
> -{
> -	int err;
> -
> -	/*
> -	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
> -	 * the relevant capability.
> -	 */
> -	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
> -	    !capable(CAP_LINUX_IMMUTABLE))
> -		return -EPERM;
> -
> -	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
> -	if (err)
> -		return err;
> -
> -	/*
> -	 * Project Quota ID state is only allowed to change from within the init
> -	 * namespace. Enforce that restriction only if we are trying to change
> -	 * the quota ID state. Everything else is allowed in user namespaces.
> -	 */
> -	if (current_user_ns() != &init_user_ns) {
> -		if (old_ma->fsx_projid != fa->fsx_projid)
> -			return -EINVAL;
> -		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
> -				FS_XFLAG_PROJINHERIT)
> -			return -EINVAL;
> -	} else {
> -		/*
> -		 * Caller is allowed to change the project ID. If it is being
> -		 * changed, make sure that the new value is valid.
> -		 */
> -		if (old_ma->fsx_projid != fa->fsx_projid &&
> -		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
> -			return -EINVAL;
> -	}
> -
> -	/* Check extent size hints. */
> -	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
> -		return -EINVAL;
> -
> -	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
> -			!S_ISDIR(inode->i_mode))
> -		return -EINVAL;
> -
> -	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
> -	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> -		return -EINVAL;
> -
> -	/*
> -	 * It is only valid to set the DAX flag on regular files and
> -	 * directories on filesystems.
> -	 */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> -	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
> -		return -EINVAL;
> -
> -	/* Extent size hints of zero turn off the flags. */
> -	if (fa->fsx_extsize == 0)
> -		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
> -	if (fa->fsx_cowextsize == 0)
> -		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
> -
> -	return 0;
> -}
> -
> -/**
> - * vfs_fileattr_set - change miscellaneous file attributes
> - * @idmap:	idmap of the mount
> - * @dentry:	the object to change
> - * @fa:		fileattr pointer
> - *
> - * After verifying permissions, call i_op->fileattr_set() callback, if
> - * exists.
> - *
> - * Verifying attributes involves retrieving current attributes with
> - * i_op->fileattr_get(), this also allows initializing attributes that have
> - * not been set by the caller to current values.  Inode lock is held
> - * thoughout to prevent racing with another instance.
> - *
> - * Return: 0 on success, or a negative error on failure.
> - */
> -int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
> -		     struct fileattr *fa)
> -{
> -	struct inode *inode = d_inode(dentry);
> -	struct fileattr old_ma = {};
> -	int err;
> -
> -	if (!inode->i_op->fileattr_set)
> -		return -ENOIOCTLCMD;
> -
> -	if (!inode_owner_or_capable(idmap, inode))
> -		return -EPERM;
> -
> -	inode_lock(inode);
> -	err = vfs_fileattr_get(dentry, &old_ma);
> -	if (!err) {
> -		/* initialize missing bits from old_ma */
> -		if (fa->flags_valid) {
> -			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
> -			fa->fsx_extsize = old_ma.fsx_extsize;
> -			fa->fsx_nextents = old_ma.fsx_nextents;
> -			fa->fsx_projid = old_ma.fsx_projid;
> -			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
> -		} else {
> -			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
> -		}
> -		err = fileattr_set_prepare(inode, &old_ma, fa);
> -		if (!err)
> -			err = inode->i_op->fileattr_set(idmap, dentry, fa);
> -	}
> -	inode_unlock(inode);
> -
> -	return err;
> -}
> -EXPORT_SYMBOL(vfs_fileattr_set);
> -
> -static int ioctl_getflags(struct file *file, unsigned int __user *argp)
> -{
> -	struct fileattr fa = { .flags_valid = true }; /* hint only */
> -	int err;
> -
> -	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> -	if (!err)
> -		err = put_user(fa.flags, argp);
> -	return err;
> -}
> -
> -static int ioctl_setflags(struct file *file, unsigned int __user *argp)
> -{
> -	struct mnt_idmap *idmap = file_mnt_idmap(file);
> -	struct dentry *dentry = file->f_path.dentry;
> -	struct fileattr fa;
> -	unsigned int flags;
> -	int err;
> -
> -	err = get_user(flags, argp);
> -	if (!err) {
> -		err = mnt_want_write_file(file);
> -		if (!err) {
> -			fileattr_fill_flags(&fa, flags);
> -			err = vfs_fileattr_set(idmap, dentry, &fa);
> -			mnt_drop_write_file(file);
> -		}
> -	}
> -	return err;
> -}
> -
> -static int ioctl_fsgetxattr(struct file *file, void __user *argp)
> -{
> -	struct fileattr fa = { .fsx_valid = true }; /* hint only */
> -	int err;
> -
> -	err = vfs_fileattr_get(file->f_path.dentry, &fa);
> -	if (!err)
> -		err = copy_fsxattr_to_user(&fa, argp);
> -
> -	return err;
> -}
> -
> -static int ioctl_fssetxattr(struct file *file, void __user *argp)
> -{
> -	struct mnt_idmap *idmap = file_mnt_idmap(file);
> -	struct dentry *dentry = file->f_path.dentry;
> -	struct fileattr fa;
> -	int err;
> -
> -	err = copy_fsxattr_from_user(&fa, argp);
> -	if (!err) {
> -		err = mnt_want_write_file(file);
> -		if (!err) {
> -			err = vfs_fileattr_set(idmap, dentry, &fa);
> -			mnt_drop_write_file(file);
> -		}
> -	}
> -	return err;
> -}
> -
>  static int ioctl_getfsuuid(struct file *file, void __user *argp)
>  {
>  	struct super_block *sb = file_inode(file)->i_sb;
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 47c05a9851d0..6030d0bf7ad3 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -55,5 +55,9 @@ static inline bool fileattr_has_fsx(const struct fileattr *fa)
>  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
>  int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  		     struct fileattr *fa);
> +int ioctl_getflags(struct file *file, unsigned int __user *argp);
> +int ioctl_setflags(struct file *file, unsigned int __user *argp);
> +int ioctl_fsgetxattr(struct file *file, void __user *argp);
> +int ioctl_fssetxattr(struct file *file, void __user *argp);
>  
>  #endif /* _LINUX_FILEATTR_H */
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

