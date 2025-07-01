Return-Path: <linux-fsdevel+bounces-53522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2FEAEFA6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B677AEEF6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A523274FC1;
	Tue,  1 Jul 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0KfyUxeE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DSHFGY1d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k2g4a9TZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pC2n33Vt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EE2798FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376252; cv=none; b=m1lje8taNLiZFdEYu6jRCoDNzZYJOGdINHvCdV+1HoBubYYtwTcJmE9CJ4F5alEv+uPO8AoAt8VLt+QjUFNUh1yVODQYlYwyE0t2tXsfOViWX8wsY+Nen05gQ+C6VMnoFqf5N/kpINJlPlBAuXYEJ44sKI7ZqbGiZGYNDcV+s00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376252; c=relaxed/simple;
	bh=xXqDj1wJ7/Ymtp0P5loQ2F/FbTjzYl1Bd3O0meHUjcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrxsVac1/fDTW0X5xQbCOXLL7N28kcvQlRKb2bTg/uhPiHW0JLo6pY/rR7t4V7ZwX4ifmpwbEKrf76UHtQevsirRGLZP9Wc16DF/6x4l/FEPc3q+4wzuGhHwhlIA8olDas6ymDZtM00A4GD9jNqcQ3RXeS/6VTi7myx60M420Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0KfyUxeE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DSHFGY1d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k2g4a9TZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pC2n33Vt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1C8A1F399;
	Tue,  1 Jul 2025 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751376249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7LAvBX+B7AFcpf2gN6CbdwlzROH86VQ90+DxHz4P4=;
	b=0KfyUxeE9gLBsCJl6eFvUMl/NUkTwajv4ObGZdRbU9BJPnT17eN3+orNTrZUNlyam1yXXq
	XV7r9x/2czpeZ1D6E0r647nrpwd2MW6ulGGcQUxubUEUp8nA99+WEFC2+b5m4v05aCKuAo
	iOtfao8NFhGvgGSnoTDUMtn4Oha+Dic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751376249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7LAvBX+B7AFcpf2gN6CbdwlzROH86VQ90+DxHz4P4=;
	b=DSHFGY1dGBz2SIn1yXZcWDXIe31d+V1yj+mcqKsiyfB1TxLqz/tVQ2ym6WB65EYrbFsSGf
	aasJqY5mJ2tdZhAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751376248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7LAvBX+B7AFcpf2gN6CbdwlzROH86VQ90+DxHz4P4=;
	b=k2g4a9TZ+mEeo+99ew/RtFpR81VTJ4o9bmhNLlBQQaYKRWFzS1pHslK6NUtRFJra+R8IIj
	CC4TsxvTjOukEnrjsOqEeL+eR9VOj9qcz9ABPhhHGSSX/8zvUGRaVMYoTvY28lGBLAOWP5
	oYFsG2rilj42FLn9xM83FVkqK1Bfq0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751376248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj7LAvBX+B7AFcpf2gN6CbdwlzROH86VQ90+DxHz4P4=;
	b=pC2n33VtzF+BIZOKEpB/xiCUBZENOCZvw1fRQrsMUNXxwdVQsmFLtK+R29KPL8KuthqJcQ
	I5Nt7F47EfbQFACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E08B413890;
	Tue,  1 Jul 2025 13:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m5fbNnjhY2jBegAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 13:24:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B30ECA0A23; Tue,  1 Jul 2025 15:24:07 +0200 (CEST)
Date: Tue, 1 Jul 2025 15:24:07 +0200
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 6/6] fs: introduce file_getattr and file_setattr
 syscalls
Message-ID: <uvxftp37cpvn7emugit7zsmyjmkaivuzxerwfw36ukzrycxtfp@krnv7y7akpjl>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-6-c4e3bc35227b@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 30-06-25 18:20:16, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Introduce file_getattr() and file_setattr() syscalls to manipulate inode
> extended attributes. The syscalls takes pair of file descriptor and
> pathname. Then it operates on inode opened accroding to openat()
						^^^ according

> semantics. The struct fsx_fileattr is passed to obtain/change extended
> attributes.
> 
> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> that file don't need to be open as we can reference it with a path
            ^^^ doesn't

> instead of fd. By having this we can manipulated inode extended
> attributes not only on regular files but also on special ones. This
> is not possible with FS_IOC_FSSETXATTR ioctl as with special files
> we can not call ioctl() directly on the filesystem inode using fd.
> 
> This patch adds two new syscalls which allows userspace to get/set
> extended inode attributes on special files by using parent directory
> and a path - *at() like syscall.
> 
> CC: linux-api@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

There's possible NULL ptr deref bug below (2x) that's easy to fix. Once
done feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -343,3 +377,117 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  	return err;
>  }
>  EXPORT_SYMBOL(ioctl_fssetxattr);
> +
> +SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
> +		struct fsx_fileattr __user *, ufsx, size_t, usize,
> +		unsigned int, at_flags)
> +{
> +	struct fileattr fa;
> +	struct path filepath __free(path_put) = {};
> +	int error;
> +	unsigned int lookup_flags = 0;
> +	struct filename *name __free(putname) = NULL;
> +	struct fsx_fileattr fsx;
> +
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) < FSX_FILEATTR_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) != FSX_FILEATTR_SIZE_LATEST);
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	if (usize < FSX_FILEATTR_SIZE_VER0)
> +		return -EINVAL;
> +
> +	name = getname_maybe_null(filename, at_flags);
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);
> +
> +	if (!name && dfd >= 0) {
> +		CLASS(fd, f)(dfd);
> +
> +		filepath = fd_file(f)->f_path;

If dfd is not correct fd, then this will dereference NULL AFAICT. I think
you need here:

		if (fd_empty(f))
			return -EBADF;

> +		path_get(&filepath);
> +	} else {
> +		error = filename_lookup(dfd, name, lookup_flags, &filepath,
> +					NULL);
> +		if (error)
> +			return error;
> +	}
> +
> +	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (error)
> +		return error;
> +
> +	fileattr_to_fsx_fileattr(&fa, &fsx);
> +	error = copy_struct_to_user(ufsx, usize, &fsx,
> +				    sizeof(struct fsx_fileattr), NULL);
> +
> +	return error;
> +}
> +
> +SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
> +		struct fsx_fileattr __user *, ufsx, size_t, usize,
> +		unsigned int, at_flags)
> +{
> +	struct fileattr fa;
> +	struct path filepath __free(path_put) = {};
> +	int error;
> +	unsigned int lookup_flags = 0;
> +	struct filename *name __free(putname) = NULL;
> +	struct fsx_fileattr fsx;
> +
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) < FSX_FILEATTR_SIZE_VER0);
> +	BUILD_BUG_ON(sizeof(struct fsx_fileattr) != FSX_FILEATTR_SIZE_LATEST);
> +
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +		return -EINVAL;
> +
> +	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> +		lookup_flags |= LOOKUP_FOLLOW;
> +
> +	if (usize > PAGE_SIZE)
> +		return -E2BIG;
> +
> +	if (usize < FSX_FILEATTR_SIZE_VER0)
> +		return -EINVAL;
> +
> +	error = copy_struct_from_user(&fsx, sizeof(struct fsx_fileattr), ufsx,
> +				      usize);
> +	if (error)
> +		return error;
> +
> +	error = fsx_fileattr_to_fileattr(&fsx, &fa);
> +	if (error)
> +		return error;
> +
> +	name = getname_maybe_null(filename, at_flags);
> +	if (IS_ERR(name))
> +		return PTR_ERR(name);
> +
> +	if (!name && dfd >= 0) {
> +		CLASS(fd, f)(dfd);
> +

Same comment here as above.

> +		filepath = fd_file(f)->f_path;
> +		path_get(&filepath);
> +	} else {
> +		error = filename_lookup(dfd, name, lookup_flags, &filepath,
> +					NULL);
> +		if (error)
> +			return error;
> +	}
> +
> +	error = mnt_want_write(filepath.mnt);
> +	if (!error) {
> +		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
> +					 filepath.dentry, &fa);
> +		mnt_drop_write(filepath.mnt);
> +	}
> +
> +	return error;
> +}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

