Return-Path: <linux-fsdevel+bounces-52733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F4AE60DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A3A3A61D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C0E17A31C;
	Tue, 24 Jun 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eEL2tysy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sBDCvL9u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UVxMrFOh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2GorbhPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4219224AFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757493; cv=none; b=rcHqm3wK9cMPF6nUs2uZQ8B2vfnm/BuQB45mZsKADX0XiXvZn7/BsjeXroRTP1guF9017Y1Gx2CmvC2Y7XQNw0AaEzihW/1CsrWW4+PKqWy6IXKgPnGHiNeH1a3cOoIBeuroe4yZ0vh/dNmlaUlmX+Yt5ZBU6cIyk3v/S5gB3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757493; c=relaxed/simple;
	bh=flnsw/ypwQWurLGp1LPeVIMY3XZrb4SHvGfM/AfP2+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK63wsuZnCeC1n5QRxcH8hmGiGFKOb/83NZL7hHBZTqxuY6kp7joI1Lvgo7AxwVtkoYRFK9XIhaR3bjXTfM817mlmSiOjaQ15R2IsSvIdpCCBx23/5IJf7aJAmcTP1rpQuzdXZe54GFYSeEPTJG4ZURJRACXkXCneosxCP/Cwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eEL2tysy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sBDCvL9u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UVxMrFOh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2GorbhPr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E153F1F391;
	Tue, 24 Jun 2025 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7V+o2sAARpTVPOcmsHkpWwQnEOXPkpBKi6EGQsy5W5g=;
	b=eEL2tysyKyIJs8VhKEhqS02ROcT6CVzv4w2Vx8sSU/nkmmEm540gwnPkqtF47qo3/SCZkZ
	1yebv4UBWrxAM3T9eTyv6b3IfQLhYffa7QaihPdZNbSTVOBhW287zEdNJXOXZ0ahGFZVru
	pL13VRProZ10MECevtC/ux8Wb7Lk604=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7V+o2sAARpTVPOcmsHkpWwQnEOXPkpBKi6EGQsy5W5g=;
	b=sBDCvL9u3u4+JThmy7Z/gzjSRCNXPhEPZGKVbjHLdFileNCP2SfVrbLU9gtENuyiJvsyXc
	C9XxPzEghX9PL7Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UVxMrFOh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2GorbhPr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7V+o2sAARpTVPOcmsHkpWwQnEOXPkpBKi6EGQsy5W5g=;
	b=UVxMrFOhQxpohWt5e4bRXuOg3SsDlKURzcI+dOO3W/QsQblXmJ2b6pi7QOo6bB0YJKDvN3
	FK0f0o0G4QtYg2tFtWOWFWjLMPCpNv0YFT/CGCGUWSGqklxOIXuJWc0M9ey3jFGQTwHfUf
	pFVpTddUDSOa+g0APgoWfv6DjtmfULA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7V+o2sAARpTVPOcmsHkpWwQnEOXPkpBKi6EGQsy5W5g=;
	b=2GorbhPrMQYMEYUjN4vBWbFgx+yzcUsZllVZEEUHk3vPWjeWLAsbF5pbF/BNBCJZMxfzya
	i3idt9jxVnkDHWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D615D13751;
	Tue, 24 Jun 2025 09:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sUNCNHFwWmgJHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:31:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A974A0A03; Tue, 24 Jun 2025 11:31:29 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:31:29 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 02/11] fhandle: hoist copy_from_user() above
 get_path_from_fd()
Message-ID: <4pt2oa4h7ep4c3mzxkl2kt7eu4qphc364zietwmbibhw7zoqm2@gi6kboqyo327>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-2-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-2-d02a04858fe3@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E153F1F391
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 24-06-25 10:29:05, Christian Brauner wrote:
> In follow-up patches we need access to @file_handle->handle_type
> before we start caring about get_path_from_fd().
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Still looks good. Feel free to add:

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

