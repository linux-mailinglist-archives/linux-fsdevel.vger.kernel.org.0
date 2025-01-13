Return-Path: <linux-fsdevel+bounces-39033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A994A0B555
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 12:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE177A0562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7167522F17A;
	Mon, 13 Jan 2025 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbvzz2FT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I5CE8/zy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbvzz2FT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I5CE8/zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070B22F158;
	Mon, 13 Jan 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767185; cv=none; b=dzPNmPRKO5UJ6TcHgYD229iax17TwazJytOPOTPnp66GPfMKaEhstQi3LrMRRM2PHBehmXoCsIXwgnO6rQMbiaLHCePQL1lOZyV53GufXWQP0ktp0tsLrGWtPzfJ957NjvpNb3WHdTCqj3xsLxoupkM52kK3PejlAxVR8ypcQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767185; c=relaxed/simple;
	bh=mLZrY9jaadQOj6v1sLTVW5BUTvxh6DhZBdhO7Fv+MdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI3UJsYndRW5u8WT5g+BCnM3IbOeWyiJ/V+WQag3wgZDLtB1rgqFTlZdbCAXBgw4ybDQw7PMjOrn3nlVA+i0as3mmw2fsq5DWbrsByXpE2ZZdZA7SB2xW4nbehMOR/kzkqNXtuaQ0O6jAoVaD0R2OtKyHSCQF2HRo6cOUiII8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbvzz2FT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I5CE8/zy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sbvzz2FT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I5CE8/zy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E0921F37C;
	Mon, 13 Jan 2025 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736767181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMT0laOUJ9M1D5IjkCfV/ptVZnIKmdTg97voNpSS9nc=;
	b=sbvzz2FTVbbUucp+7/XWFQYGw/ubL6oc54Y0aCoBgLwAMxHZH9mZhIeJfvTiKWc4VcC2JO
	l+UMj7p5mfLWHg9krKVR39faX+FPBAMRkMx/Ow55N06zImCiaNspp4+jOWfIccNDP4Fs4q
	8bzTsiBD0EcouzCTYfDLnpqr5pi1yPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736767181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMT0laOUJ9M1D5IjkCfV/ptVZnIKmdTg97voNpSS9nc=;
	b=I5CE8/zyZTUYGcz4iD65P68ucesjsl655fmMQDmJCAELfC2H42QzzaWLknR2tQCevbMAOh
	yyKGu24FeQTdSrDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736767181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMT0laOUJ9M1D5IjkCfV/ptVZnIKmdTg97voNpSS9nc=;
	b=sbvzz2FTVbbUucp+7/XWFQYGw/ubL6oc54Y0aCoBgLwAMxHZH9mZhIeJfvTiKWc4VcC2JO
	l+UMj7p5mfLWHg9krKVR39faX+FPBAMRkMx/Ow55N06zImCiaNspp4+jOWfIccNDP4Fs4q
	8bzTsiBD0EcouzCTYfDLnpqr5pi1yPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736767181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UMT0laOUJ9M1D5IjkCfV/ptVZnIKmdTg97voNpSS9nc=;
	b=I5CE8/zyZTUYGcz4iD65P68ucesjsl655fmMQDmJCAELfC2H42QzzaWLknR2tQCevbMAOh
	yyKGu24FeQTdSrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8E1613876;
	Mon, 13 Jan 2025 11:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AoDXOMz2hGd8egAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Jan 2025 11:19:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1B81A08E2; Mon, 13 Jan 2025 12:19:36 +0100 (CET)
Date: Mon, 13 Jan 2025 12:19:36 +0100
From: Jan Kara <jack@suse.cz>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	monstr@monstr.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, arnd@arndb.de, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <doha6zamxgmqapwx4r6ehzbatzar4dcep33zehunonqforjzf5@lxpidn37tdjh>
References: <20250109174540.893098-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109174540.893098-1-aalbersh@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,monstr.eu,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,zankel.net,zeniv.linux.org.uk,suse.cz,arndb.de,lists.linux-m68k.org,lists.ozlabs.org];
	R_RATELIMIT(0.00)[to_ip_from(RLyerg7kx5bdf6cnfzf33td54o)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 09-01-25 18:45:40, Andrey Albershteyn wrote:
> From: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> extended attributes/flags. The syscalls take parent directory FD and
> path to the child together with struct fsxattr.
> 
> This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> that file don't need to be open. By having this we can manipulated
> inode extended attributes not only on normal files but also on
> special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
> opening special files returns VFS special inode instead of
> underlying filesystem one.
> 
> This patch adds two new syscalls which allows userspace to set
> extended inode attributes on special files by using parent directory
> to open FS inode.
> 
> Also, as vfs_fileattr_set() is now will be called on special files
> too, let's forbid any other attributes except projid and nextents
> (symlink can have an extent).
> 
> CC: linux-api@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Couple of comments below:

> @@ -2953,3 +2956,105 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
>  	return mode & ~S_ISGID;
>  }
>  EXPORT_SYMBOL(mode_strip_sgid);
> +
> +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr *, fsx, int, at_flags)
				       ^^^ at_flags should be probably
unsigned - at least they seem to be for other syscalls.

> +{
> +	struct fd dir;
> +	struct fileattr fa;
> +	struct path filepath;
> +	struct inode *inode;
> +	int error;
> +
> +	if (at_flags)
> +		return -EINVAL;

Shouldn't we support basic path resolve flags like AT_SYMLINK_NOFOLLOW or
AT_EMPTY_PATH? I didn't put too much thought to this but intuitively I'd say
we should follow what path_setxattrat() does.

> +
> +	if (!capable(CAP_FOWNER))
> +		return -EPERM;

Why? Firstly this does not handle user namespaces at all, secondly it
doesn't match the check done during ioctl, and thirdly vfs_fileattr_get()
should do all the needed checks?

> +
> +	dir = fdget(dfd);
> +	if (!fd_file(dir))
> +		return -EBADF;
> +
> +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> +		error = -EBADF;
> +		goto out;
> +	}
> +
> +	error = user_path_at(dfd, filename, at_flags, &filepath);
> +	if (error)
> +		goto out;

I guess this is OK for now but allowing full flexibility of the "_at"
syscall (e.g. like setxattrat() does) would be preferred. Mostly so that
userspace programmer doesn't have to read manpage in detail and think
whether the particular combination of path arguments is supported by a
particular syscall. Admittedly VFS could make this a bit simpler. Currently
the boilerplate code that's needed in path_setxattrat() &
filename_setxattr() / file_setxattr() is offputting.

> +
> +	inode = filepath.dentry->d_inode;
> +	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
> +		error = -EBADF;
> +		goto out_path;
> +	}

What's the motivation for this check?

> +
> +	error = vfs_fileattr_get(filepath.dentry, &fa);
> +	if (error)
> +		goto out_path;
> +
> +	if (copy_fsxattr_to_user(&fa, fsx))
> +		error = -EFAULT;
> +
> +out_path:
> +	path_put(&filepath);
> +out:
> +	fdput(dir);
> +	return error;
> +}
> +
> +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> +		struct fsxattr *, fsx, int, at_flags)
> +{

Same comments as for getfsxattrat() apply here as well.

> -static int copy_fsxattr_from_user(struct fileattr *fa,
> -				  struct fsxattr __user *ufa)
> +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
>  {
>  	struct fsxattr xfa;
>  
> @@ -574,6 +573,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(copy_fsxattr_from_user);

I guess no need to export this function? The code you call it from cannot
be compiled as a module.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

