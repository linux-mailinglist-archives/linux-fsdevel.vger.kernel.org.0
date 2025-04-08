Return-Path: <linux-fsdevel+bounces-45944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93F7A7FB9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF9616FCBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D585268FEC;
	Tue,  8 Apr 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0KTK1Nw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oSo2RYgx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0KTK1Nw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oSo2RYgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F409268C62
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107307; cv=none; b=gQBHY76zG1/BmAzFIOWDtevbgnCoEz7J/ri5y7/vPXHKPmh0FtXXYcyMGqKxPuFBQR0Pg3KdCwj5JU4Xl6zSTAn0vVJwVGdO4QN5gF4bYZ8jaGfT/zAb0hwOp1uKzsYWDP6Vv2UuwjEl4CYUpZGDe+txKnRO9lgNivzIizm6/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107307; c=relaxed/simple;
	bh=QB0z5td5zvr1Ql8rWIyqcWr4IwUK45RMAn/ZqrEjJGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVbciUNCPSsZCLVMRwXtTZSWN0qTiAaiKAtwWRGMWkvTxwiw+0ETORj5T2LHAg5u6wUL8tqFqvMDoCxKj03x+c+SQmtnRguD8ReC+pnOZQj01DQ1V+y/f7kKRGBWp7Kado9t1AG8vRqj1TJkMvHTE5lQ9Ja2APPtsVll/UYOsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0KTK1Nw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oSo2RYgx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0KTK1Nw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oSo2RYgx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F55D1F388;
	Tue,  8 Apr 2025 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744107303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbunx9ApKi2JAlo+EGwosvl0LD6UwimRnxexc1YS+z4=;
	b=B0KTK1NwhMjw8Z2Sm5LbeYKXA66zuPCwJ4wcaeqJ1UxnAcyCEmhMowHzxfU7ot5rmqRxQ9
	5ujULyKRuQ0Evf0bHccq656iKSv0hQ9C9d9rSqC6kJViMjTpekEGzwenvgG6mw3lTOnfJ6
	dl+L4IMxVs2Vgjb4k7iOJFYqyjprZBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744107303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbunx9ApKi2JAlo+EGwosvl0LD6UwimRnxexc1YS+z4=;
	b=oSo2RYgxDLCaD7F1gPxMmTHUNVEFg54v1gZRhmj2rnF0yvlQPpJKWZ5K6yhn13EN0Xo4Oo
	HOqb7yhuM/RPlMCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744107303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbunx9ApKi2JAlo+EGwosvl0LD6UwimRnxexc1YS+z4=;
	b=B0KTK1NwhMjw8Z2Sm5LbeYKXA66zuPCwJ4wcaeqJ1UxnAcyCEmhMowHzxfU7ot5rmqRxQ9
	5ujULyKRuQ0Evf0bHccq656iKSv0hQ9C9d9rSqC6kJViMjTpekEGzwenvgG6mw3lTOnfJ6
	dl+L4IMxVs2Vgjb4k7iOJFYqyjprZBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744107303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbunx9ApKi2JAlo+EGwosvl0LD6UwimRnxexc1YS+z4=;
	b=oSo2RYgxDLCaD7F1gPxMmTHUNVEFg54v1gZRhmj2rnF0yvlQPpJKWZ5K6yhn13EN0Xo4Oo
	HOqb7yhuM/RPlMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9487513A1E;
	Tue,  8 Apr 2025 10:15:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hS06JCf39GfTcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Apr 2025 10:15:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59284A098A; Tue,  8 Apr 2025 12:14:59 +0200 (CEST)
Date: Tue, 8 Apr 2025 12:14:59 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: sort out cosmetic differences between stat funcs
 and add predicts
Message-ID: <xzwjp6bbwcvix3bzpjccya6p3rqc3nfed2pe6zvjits35xztci@q3qr27nitdsl>
References: <20250406235806.1637000-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406235806.1637000-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 07-04-25 01:58:04, Mateusz Guzik wrote:
> This is a nop, but I did verify asm improves.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/stat.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index f13308bfdc98..b79ddb83914b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -241,7 +241,7 @@ int vfs_getattr(const struct path *path, struct kstat *stat,
>  	int retval;
>  
>  	retval = security_inode_getattr(path);
> -	if (retval)
> +	if (unlikely(retval))
>  		return retval;
>  	return vfs_getattr_nosec(path, stat, request_mask, query_flags);
>  }
> @@ -421,7 +421,7 @@ SYSCALL_DEFINE2(stat, const char __user *, filename,
>  	int error;
>  
>  	error = vfs_stat(filename, &stat);
> -	if (error)
> +	if (unlikely(error))
>  		return error;
>  
>  	return cp_old_stat(&stat, statbuf);
> @@ -434,7 +434,7 @@ SYSCALL_DEFINE2(lstat, const char __user *, filename,
>  	int error;
>  
>  	error = vfs_lstat(filename, &stat);
> -	if (error)
> +	if (unlikely(error))
>  		return error;
>  
>  	return cp_old_stat(&stat, statbuf);
> @@ -443,12 +443,13 @@ SYSCALL_DEFINE2(lstat, const char __user *, filename,
>  SYSCALL_DEFINE2(fstat, unsigned int, fd, struct __old_kernel_stat __user *, statbuf)
>  {
>  	struct kstat stat;
> -	int error = vfs_fstat(fd, &stat);
> +	int error;
>  
> -	if (!error)
> -		error = cp_old_stat(&stat, statbuf);
> +	error = vfs_fstat(fd, &stat);
> +	if (unlikely(error))
> +		return error;
>  
> -	return error;
> +	return cp_old_stat(&stat, statbuf);
>  }
>  
>  #endif /* __ARCH_WANT_OLD_STAT */
> @@ -502,10 +503,12 @@ SYSCALL_DEFINE2(newstat, const char __user *, filename,
>  		struct stat __user *, statbuf)
>  {
>  	struct kstat stat;
> -	int error = vfs_stat(filename, &stat);
> +	int error;
>  
> -	if (error)
> +	error = vfs_stat(filename, &stat);
> +	if (unlikely(error))
>  		return error;
> +
>  	return cp_new_stat(&stat, statbuf);
>  }
>  
> @@ -516,7 +519,7 @@ SYSCALL_DEFINE2(newlstat, const char __user *, filename,
>  	int error;
>  
>  	error = vfs_lstat(filename, &stat);
> -	if (error)
> +	if (unlikely(error))
>  		return error;
>  
>  	return cp_new_stat(&stat, statbuf);
> @@ -530,8 +533,9 @@ SYSCALL_DEFINE4(newfstatat, int, dfd, const char __user *, filename,
>  	int error;
>  
>  	error = vfs_fstatat(dfd, filename, &stat, flag);
> -	if (error)
> +	if (unlikely(error))
>  		return error;
> +
>  	return cp_new_stat(&stat, statbuf);
>  }
>  #endif
> @@ -539,12 +543,13 @@ SYSCALL_DEFINE4(newfstatat, int, dfd, const char __user *, filename,
>  SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
>  {
>  	struct kstat stat;
> -	int error = vfs_fstat(fd, &stat);
> +	int error;
>  
> -	if (!error)
> -		error = cp_new_stat(&stat, statbuf);
> +	error = vfs_fstat(fd, &stat);
> +	if (unlikely(error))
> +		return error;
>  
> -	return error;
> +	return cp_new_stat(&stat, statbuf);
>  }
>  #endif
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

