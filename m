Return-Path: <linux-fsdevel+bounces-18498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A18B98EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6AB2B21A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8EE5C5F3;
	Thu,  2 May 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ua0N0Uko";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZZhWYkK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ua0N0Uko";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZZhWYkK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A756B8C;
	Thu,  2 May 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646244; cv=none; b=oqE/YdkZNvqOo7/16mafmezQXfmQEnTVFVJa7KMBRjj9edn9ZNujW3lt7USvNnbJt26q4rhRlW3wo1J5uQgxh2DmcRWaFu4DP6oag23K7kHVVJV3ltdDpn8ncIw6Uj5+EmR0rAx90uAOvTMvZ1rhj61SI072L0Q77Zl4t8+jEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646244; c=relaxed/simple;
	bh=YyyerMcf1qMfk8IKhzJEFzuENB1XyujcBUHWMuwexqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE1nd8CsSEyMymh3DhlJo00rANTWB42nCaz7qCK9Kp7LBLCY+LACmgz5keycEPl1j7rzITEA46EJK2AW816sOk2JCb4tLkCL76Do7KdAB163igKufw/L6XAZBIpESnvTa8V69yaORCRns6dm/J2B1ZRY4v0QZSjt2hFwKTwmbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ua0N0Uko; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZZhWYkK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ua0N0Uko; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZZhWYkK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2951C1FB6E;
	Thu,  2 May 2024 10:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714646241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly5XSPwQBZ042VbZ8AChYCV7O/jpqWR59R/1+ciw/4I=;
	b=Ua0N0Uko/amxWAVq13w6/GX0drvC2Giz1jQYNeawzj1llyoTJLPs5by/M6jwxGn9l01QsS
	Hirzgp00j5kQ9V2m60yi0lxLLS6GdaBbqIdLHa2EKqi8NbArYOoJ4AchklyJHPExr2LcFi
	FY8+v+bN5vwn/XInWfw6ZJk0olXfkJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714646241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly5XSPwQBZ042VbZ8AChYCV7O/jpqWR59R/1+ciw/4I=;
	b=bZZhWYkKty9QSXrXwkvQ7+tNIdjmYRGdWpVCijT2HRstP5DzvkbhgESsrYDHINEOs3j08c
	oL2+i/29SWF3PaAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714646241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly5XSPwQBZ042VbZ8AChYCV7O/jpqWR59R/1+ciw/4I=;
	b=Ua0N0Uko/amxWAVq13w6/GX0drvC2Giz1jQYNeawzj1llyoTJLPs5by/M6jwxGn9l01QsS
	Hirzgp00j5kQ9V2m60yi0lxLLS6GdaBbqIdLHa2EKqi8NbArYOoJ4AchklyJHPExr2LcFi
	FY8+v+bN5vwn/XInWfw6ZJk0olXfkJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714646241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly5XSPwQBZ042VbZ8AChYCV7O/jpqWR59R/1+ciw/4I=;
	b=bZZhWYkKty9QSXrXwkvQ7+tNIdjmYRGdWpVCijT2HRstP5DzvkbhgESsrYDHINEOs3j08c
	oL2+i/29SWF3PaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 085451386E;
	Thu,  2 May 2024 10:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HlIEAuFsM2YaEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 May 2024 10:37:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ABE3BA06D4; Thu,  2 May 2024 12:37:16 +0200 (CEST)
Date: Thu, 2 May 2024 12:37:16 +0200
From: Jan Kara <jack@suse.cz>
To: cgzones@googlemail.com
Cc: brauner@kernel.org, Jan Kara <jack@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Kees Cook <keescook@chromium.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: unify *at syscalls
Message-ID: <20240502103716.avdfm6r3ma2wfxjj@quack3>
References: <20240430151917.30036-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430151917.30036-1-cgoettsche@seltendoof.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[googlemail.com];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 30-04-24 17:19:14, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> Use the same parameter ordering for all four newly added *xattrat
> syscalls:
> 
>     dirfd, pathname, at_flags, ...
> 
> Also consistently use unsigned int as the type for at_flags.
> 
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Thanks! The change looks good to me. Christian, do you plan to fold this
into the series you've taken to your tree?

								Honza

> ---
>  fs/xattr.c               | 36 +++++++++++++++++++-----------------
>  include/linux/syscalls.h |  8 +++++---
>  2 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 45603e74c632..454304046d7d 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -931,17 +931,18 @@ listxattr(struct dentry *d, char __user *list, size_t size)
>  	return error;
>  }
>  
> -static ssize_t do_listxattrat(int dfd, const char __user *pathname, char __user *list,
> -			      size_t size, int flags)
> +static ssize_t do_listxattrat(int dfd, const char __user *pathname,
> +			      unsigned int at_flags,
> +			      char __user *list, size_t size)
>  {
>  	struct path path;
>  	ssize_t error = 0;
>  	int lookup_flags;
>  
> -	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
>  		return -EINVAL;
>  
> -	if (flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
> +	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
>  		CLASS(fd, f)(dfd);
>  
>  		if (!f.file)
> @@ -965,22 +966,23 @@ static ssize_t do_listxattrat(int dfd, const char __user *pathname, char __user
>  	return error;
>  }
>  
> -SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname, char __user *, list,
> -		size_t, size, int, flags)
> +SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname,
> +		unsigned int, at_flags,
> +		char __user *, list, size_t, size)
>  {
> -	return do_listxattrat(dfd, pathname, list, size, flags);
> +	return do_listxattrat(dfd, pathname, at_flags, list, size);
>  }
>  
>  SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
>  		size_t, size)
>  {
> -	return do_listxattrat(AT_FDCWD, pathname, list, size, 0);
> +	return do_listxattrat(AT_FDCWD, pathname, 0, list, size);
>  }
>  
>  SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
>  		size_t, size)
>  {
> -	return do_listxattrat(AT_FDCWD, pathname, list, size, AT_SYMLINK_NOFOLLOW);
> +	return do_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list, size);
>  }
>  
>  SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
> @@ -1019,17 +1021,17 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
>  }
>  
>  static int do_removexattrat(int dfd, const char __user *pathname,
> -			    const char __user *name, int flags)
> +			    unsigned int at_flags, const char __user *name)
>  {
>  	struct path path;
>  	int error;
>  	int lookup_flags;
>  
> -	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
> +	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
>  		return -EINVAL;
>  
> -	lookup_flags = (flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
> -	if (flags & AT_EMPTY_PATH)
> +	lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
> +	if (at_flags & AT_EMPTY_PATH)
>  		lookup_flags |= LOOKUP_EMPTY;
>  retry:
>  	error = user_path_at(dfd, pathname, lookup_flags, &path);
> @@ -1049,21 +1051,21 @@ static int do_removexattrat(int dfd, const char __user *pathname,
>  }
>  
>  SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
> -		const char __user *, name, int, flags)
> +		unsigned int, at_flags, const char __user *, name)
>  {
> -	return do_removexattrat(dfd, pathname, name, flags);
> +	return do_removexattrat(dfd, pathname, at_flags, name);
>  }
>  
>  SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
>  		const char __user *, name)
>  {
> -	return do_removexattrat(AT_FDCWD, pathname, name, 0);
> +	return do_removexattrat(AT_FDCWD, pathname, 0, name);
>  }
>  
>  SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
>  		const char __user *, name)
>  {
> -	return do_removexattrat(AT_FDCWD, pathname, name, AT_SYMLINK_NOFOLLOW);
> +	return do_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, name);
>  }
>  
>  SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e06fffc48535..ca3cba698602 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -356,15 +356,17 @@ asmlinkage long sys_fgetxattr(int fd, const char __user *name,
>  			      void __user *value, size_t size);
>  asmlinkage long sys_listxattr(const char __user *path, char __user *list,
>  			      size_t size);
> -asmlinkage long sys_listxattrat(int dfd, const char __user *path, char __user *list,
> -			      size_t size, int flags);
> +asmlinkage long sys_listxattrat(int dfd, const char __user *path,
> +				unsigned int at_flags,
> +				char __user *list, size_t size);
>  asmlinkage long sys_llistxattr(const char __user *path, char __user *list,
>  			       size_t size);
>  asmlinkage long sys_flistxattr(int fd, char __user *list, size_t size);
>  asmlinkage long sys_removexattr(const char __user *path,
>  				const char __user *name);
>  asmlinkage long sys_removexattrat(int dfd, const char __user *path,
> -				const char __user *name, int flags);
> +				  unsigned int at_flags,
> +				  const char __user *name);
>  asmlinkage long sys_lremovexattr(const char __user *path,
>  				 const char __user *name);
>  asmlinkage long sys_fremovexattr(int fd, const char __user *name);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

