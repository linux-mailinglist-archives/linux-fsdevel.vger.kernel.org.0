Return-Path: <linux-fsdevel+bounces-16167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D77899AA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9444E1C21501
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5D31649D3;
	Fri,  5 Apr 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zj/bIVK3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9vMrf8BW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zj/bIVK3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9vMrf8BW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F376161B4E;
	Fri,  5 Apr 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312523; cv=none; b=l98J+La8jFt8oOZf0VaEe95z/YPXa79CdKvA1Gix27nYw1Zn+DKTzsBacmq1XRmm4LPM4al0h8P8vIxkwWKxQtR3Iw3yrj3NvFgQf3oftHm77yPgyoyHo0Su4pOyKqx/MfmULGrEAQ3i1JS/OJ5+9Ult/4F8R9kmk00sCsxHftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312523; c=relaxed/simple;
	bh=gp6lawSvavTZZXlwdEk/RyHYzVANfbImjOT2PQBI3RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAN1KGR0nvpaPiR+kOtjYqiWwqfd+eR7ZeZZAdf1nYbqCQxTzWkzjpytPS0cS/iRodAr+WeEtPnF+2AXYUJ0E6wtrNqh0Hg2+7i/zXQXItJY6vcE0ofAvtfeIrg45zIfVhGwvSfxXqn+E0ne57jePQeKluKSxUOfTVIvK42ffvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zj/bIVK3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9vMrf8BW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zj/bIVK3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9vMrf8BW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F1EE1F789;
	Fri,  5 Apr 2024 10:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712312518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EETuShd9DBL++bLZx8natSBLuwv4gMpMvywzc3iX/as=;
	b=Zj/bIVK3Zh1WAmVOuH1ssEJ/nItehEBIX5D+ccWFcY6+LeKxkj+Jwir6LeR4v0sp/4CyJa
	ZUYLetkdfULNWVWIw4hafZyn3lBpl2xQ8WmK5a/9gBXXrC3RCFon0DUPGivB408fyPBeZF
	XB9oydAhYFBNSmIsaCVGohIHGgO9iwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712312518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EETuShd9DBL++bLZx8natSBLuwv4gMpMvywzc3iX/as=;
	b=9vMrf8BWkGyJ9WLohMxzWX3nwphZVKY2Mkq1/XSKrN343PenqXuxrcri3GeyPjGvxrJCQ7
	JYAMy4DQxVvzR3Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712312518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EETuShd9DBL++bLZx8natSBLuwv4gMpMvywzc3iX/as=;
	b=Zj/bIVK3Zh1WAmVOuH1ssEJ/nItehEBIX5D+ccWFcY6+LeKxkj+Jwir6LeR4v0sp/4CyJa
	ZUYLetkdfULNWVWIw4hafZyn3lBpl2xQ8WmK5a/9gBXXrC3RCFon0DUPGivB408fyPBeZF
	XB9oydAhYFBNSmIsaCVGohIHGgO9iwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712312518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EETuShd9DBL++bLZx8natSBLuwv4gMpMvywzc3iX/as=;
	b=9vMrf8BWkGyJ9WLohMxzWX3nwphZVKY2Mkq1/XSKrN343PenqXuxrcri3GeyPjGvxrJCQ7
	JYAMy4DQxVvzR3Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F5F6139E8;
	Fri,  5 Apr 2024 10:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 381DF8bQD2aTawAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 05 Apr 2024 10:21:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 055F5A0814; Fri,  5 Apr 2024 12:21:57 +0200 (CEST)
Date: Fri, 5 Apr 2024 12:21:57 +0200
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Set file_handle::handle_bytes before referencing
 file_handle::f_handle
Message-ID: <20240405102157.mmrralt5iohc2pz6@quack3>
References: <20240404211212.it.297-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404211212.it.297-kees@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,oracle.com,kernel.org,zeniv.linux.org.uk,gmail.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.cz:email]

On Thu 04-04-24 14:12:15, Kees Cook wrote:
> Since __counted_by(handle_bytes) was added to struct file_handle, we need
> to explicitly set it in the one place it wasn't yet happening prior to
> accessing the flex array "f_handle". For robustness also check for a
> negative value for handle_bytes, which is possible for an "int", but
> nothing appears to set.
> 
> Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Jan Kara <jack@suse.cz>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
>  v2: more bounds checking, add comments, dropped reviews since logic changed
>  v1: https://lore.kernel.org/all/20240403215358.work.365-kees@kernel.org/
> ---
>  fs/fhandle.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 8a7f86c2139a..854f866eaad2 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -40,6 +40,11 @@ static long do_sys_name_to_handle(const struct path *path,
>  			 GFP_KERNEL);
>  	if (!handle)
>  		return -ENOMEM;
> +	/*
> +	 * Since handle->f_handle is about to be written, make sure the
> +	 * associated __counted_by(handle_bytes) variable is correct.
> +	 */
> +	handle->handle_bytes = f_handle.handle_bytes;
>  
>  	/* convert handle size to multiple of sizeof(u32) */
>  	handle_dwords = f_handle.handle_bytes >> 2;
> @@ -51,8 +56,8 @@ static long do_sys_name_to_handle(const struct path *path,
>  	handle->handle_type = retval;
>  	/* convert handle size to bytes */
>  	handle_bytes = handle_dwords * sizeof(u32);
> -	handle->handle_bytes = handle_bytes;
> -	if ((handle->handle_bytes > f_handle.handle_bytes) ||
> +	/* check if handle_bytes would have exceeded the allocation */
> +	if ((handle_bytes < 0) || (handle_bytes > f_handle.handle_bytes) ||

This is broken. Let me explain: Userspace passes in struct file_handle
(ufh) and says how many bytes it has reserved for the variable length
contents in ufh->handle_bytes. We call exportfs_encode_fh() to create
the file handle. If it fits into the provided space, the function returns
in handle_dwords how many uints it has actually stored. If the handle
didn't fit, handle_dword contains number of uints we'd need in the variable
length part to be able to fit the handle in.

Now your patch destroys this behavior by storing 0 to handle_bytes in case
the handle didn't fit *before* the returned value is actually stored to a
struct copied to userspace.

Also the handle_bytes < 0 check is IMHO pointless and confusing. If some
filesystem is returning bogus size of the file handle, we have a big
problem anyway so I don't think checking like this brings much. If you want
to add some paranoia what would make some sense is: Make handle_bytes uint
and do:

	if (WARN_ON_ONCE(handle_bytes > MAX_HANDLE_SZ)) {
		handle_bytes = 0;
		retval = -EINVAL;
	}

But as a separate patch please, because it is unrelated to this __counted_by
fixup.

								Honza

>  	    (retval == FILEID_INVALID) || (retval < 0)) {
>  		/* As per old exportfs_encode_fh documentation
>  		 * we could return ENOSPC to indicate overflow
> @@ -68,6 +73,8 @@ static long do_sys_name_to_handle(const struct path *path,
>  		handle_bytes = 0;
>  	} else
>  		retval = 0;
> +	/* the "valid" number of bytes may fewer than originally allocated */
> +	handle->handle_bytes = handle_bytes;
>  	/* copy the mount id */
>  	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
>  	    copy_to_user(ufh, handle,
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

