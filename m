Return-Path: <linux-fsdevel+bounces-52532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BF0AE3DFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49851189467E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934323D2A3;
	Mon, 23 Jun 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tCGNCJiA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="utcf3w1P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tCGNCJiA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="utcf3w1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBA21C178
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678416; cv=none; b=pLuKQuFGphLhi6g6Xj7AbwPu24PbM9sPM0iOoW/6YT2ukJtgivvCyJVUZUaY5DPifVPxKkysjRtD+96A0Blbh3RJ+yDatBpBi7TYMpYNme3IytKAw9eyJMvr4lB129T3xwDBZua2gK1As5GKX3GHN5P4/WX1CpEfJoeU2bfWpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678416; c=relaxed/simple;
	bh=p2QKOiZWXtyzulzuPrCBuhoN5HEZhxukKH3n/kn2AUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RArxZ4/kbhbYSJ3epdyU4jbAsaTKL7piM9Lvyk6s0mbGkl+WutJwMlkHZYl3XP79h9zexBKyUDI5/pARlvt4Ttlh7qBXOe2qG6s73PM2lwrvAQSQhfh1xsOxX3/X2W2NiU+KFg/6hJVAXT1pHF9z9Wvh75BrQfg4sXirMGuprfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tCGNCJiA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=utcf3w1P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tCGNCJiA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=utcf3w1P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 453B121134;
	Mon, 23 Jun 2025 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBE6uWNGveZGiexA2wPquKWlzJ4SqVk3/7S/pbp/+wc=;
	b=tCGNCJiAnzWOE8EkV/mGR2N2iJMekiSj8qeMZPuuE3luNAsfj37+9IuGib+oFm6GPt9ysD
	x7xzbGiaSB2GsAVXyol8JBeishIwrw4GE7OPcmDm8P1zmzJJo5q2iTZ1TOa0csp4347Zss
	rr4CGYNQIFq9W8CmHmOB+A06OstXJSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBE6uWNGveZGiexA2wPquKWlzJ4SqVk3/7S/pbp/+wc=;
	b=utcf3w1P01Avq4IROV5gDFzVUSWSctTItUnps24obBN1I8kB8lD6JOIjeJo9oynKPQw3b0
	UMuJFSdx1uJ2G6Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tCGNCJiA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=utcf3w1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750678413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBE6uWNGveZGiexA2wPquKWlzJ4SqVk3/7S/pbp/+wc=;
	b=tCGNCJiAnzWOE8EkV/mGR2N2iJMekiSj8qeMZPuuE3luNAsfj37+9IuGib+oFm6GPt9ysD
	x7xzbGiaSB2GsAVXyol8JBeishIwrw4GE7OPcmDm8P1zmzJJo5q2iTZ1TOa0csp4347Zss
	rr4CGYNQIFq9W8CmHmOB+A06OstXJSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750678413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBE6uWNGveZGiexA2wPquKWlzJ4SqVk3/7S/pbp/+wc=;
	b=utcf3w1P01Avq4IROV5gDFzVUSWSctTItUnps24obBN1I8kB8lD6JOIjeJo9oynKPQw3b0
	UMuJFSdx1uJ2G6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31C7E13A27;
	Mon, 23 Jun 2025 11:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lg0gDI07WWhzMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 11:33:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF5F7A2A00; Mon, 23 Jun 2025 13:33:32 +0200 (CEST)
Date: Mon, 23 Jun 2025 13:33:32 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/9] fhandle: hoist copy_from_user() above
 get_path_from_fd()
Message-ID: <yupqtt7l7j5esnllwmpsqe6ptfi3hmharachzqcf3jjykusryt@bqqsqr2stqad>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-2-75899d67555f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-work-pidfs-fhandle-v1-2-75899d67555f@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 453B121134
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 23-06-25 11:01:24, Christian Brauner wrote:
> In follow-up patches we need access to @file_handle->handle_type
> before we start caring about get_path_from_fd().
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 66ff60591d17..73f56f8e7d5d 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -323,13 +323,24 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  {
>  	int retval = 0;
>  	struct file_handle f_handle;
> -	struct file_handle *handle = NULL;
> +	struct file_handle *handle __free(kfree) = NULL;
>  	struct handle_to_path_ctx ctx = {};
>  	const struct export_operations *eops;
>  
> +	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
> +		return -EFAULT;
> +
> +	if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
> +	    (f_handle.handle_bytes == 0))
> +		return -EINVAL;
> +
> +	if (f_handle.handle_type < 0 ||
> +	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS)
> +		return -EINVAL;
> +
>  	retval = get_path_from_fd(mountdirfd, &ctx.root);
>  	if (retval)
> -		goto out_err;
> +		return retval;
>  
>  	eops = ctx.root.mnt->mnt_sb->s_export_op;
>  	if (eops && eops->permission)
> @@ -339,21 +350,6 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	if (retval)
>  		goto out_path;
>  
> -	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
> -		retval = -EFAULT;
> -		goto out_path;
> -	}
> -	if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
> -	    (f_handle.handle_bytes == 0)) {
> -		retval = -EINVAL;
> -		goto out_path;
> -	}
> -	if (f_handle.handle_type < 0 ||
> -	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS) {
> -		retval = -EINVAL;
> -		goto out_path;
> -	}
> -
>  	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
>  			 GFP_KERNEL);
>  	if (!handle) {
> @@ -366,7 +362,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  			   &ufh->f_handle,
>  			   f_handle.handle_bytes)) {
>  		retval = -EFAULT;
> -		goto out_handle;
> +		goto out_path;
>  	}
>  
>  	/*
> @@ -384,11 +380,8 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	handle->handle_type &= ~FILEID_USER_FLAGS_MASK;
>  	retval = do_handle_to_path(handle, path, &ctx);
>  
> -out_handle:
> -	kfree(handle);
>  out_path:
>  	path_put(&ctx.root);
> -out_err:
>  	return retval;
>  }
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

