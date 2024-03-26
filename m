Return-Path: <linux-fsdevel+bounces-15290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0888BCF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD35B21A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED61B962;
	Tue, 26 Mar 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MGNb0moR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jg9rN1Go";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DxHO4eZX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j1QiegTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C418B04;
	Tue, 26 Mar 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443483; cv=none; b=bFo5bMHs4zQ3NzZo2lVcgHkEwdiDuBizbtwIUW0XdMKWlnnq/Uc80GLz2YGWu0XFuJiWT3izlb7/kki0lNiwc34h4ZuwmLHzduWPEZAUVwbv27cIZNm9q2ixBw9fkPRX/QYLBECtkgGva/lQzNeRzZ1rQUOb+ZXIWhW8E4sI+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443483; c=relaxed/simple;
	bh=XFozoUL6QcyIGXvMLCIL84POaBLp8oklHsXjyBmeZK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxL/vtJw0s4ePWUzJb2cQ1HoTEeJje65p1imx4/xojo/Gjyn6WluZ/Mbi1HQg23yND2i+E7ScKZ9w4zkFwxioMK3DdN9+DnIi39DqQe+2kGN2vwrn3qALSEBNr44uh8LAklZ1ITAjzp5WAmZJaz6qjviq7VzVOtwYICgrqNkc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MGNb0moR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jg9rN1Go; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DxHO4eZX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j1QiegTh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00A565D373;
	Tue, 26 Mar 2024 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711443479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ4vh1O7+H5UDwAkTuEQsybcFx3tg2uZhEm9JonLz3Y=;
	b=MGNb0moRA53dW6wUQ2O20+FMhlKGOX7mELBApC3UVSwNaErXcil5mNl/xl32/tj+CaRGpc
	Xvfer1Kn5C5CXVdM+Fattj5d2hDohzEeav/NyK3NbNd18z2cCMYCh7Ff805uHKj6pXJVhf
	zfilAsLDhY0t73mc6xERs+7CGCJ1hGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711443479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ4vh1O7+H5UDwAkTuEQsybcFx3tg2uZhEm9JonLz3Y=;
	b=Jg9rN1GovWLt8oQk0a6YrNgWJUPm+WBZTHAayYnosZ+EtU8vMJa6kiVtbNPXyXkPU+gzju
	AaqJ0p3nY4AwQNCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711443478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ4vh1O7+H5UDwAkTuEQsybcFx3tg2uZhEm9JonLz3Y=;
	b=DxHO4eZXm8E/qPp37cl0l0IzKSgS7IeKCI105UsLFseKxOF/b80Vs7eDMaZfvEXN6FLRC2
	0QZJsEsYCJILQi2FZC7J1ILXeWNYyenmyG12+J7MbbuYt6JPgJOAbBdU2GfDl3IILO5LG3
	xdkaXXTyujLwVkAIDH2u+Q6ABSa+xrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711443478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HJ4vh1O7+H5UDwAkTuEQsybcFx3tg2uZhEm9JonLz3Y=;
	b=j1QiegTh9G0rmPZx3qgi/w9TVuCocHvuAmMl99dKQnhVrzwQAPHTdqhdi3x8JDecAChNq8
	RYy2S4d0oBwJ/qBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EA83613215;
	Tue, 26 Mar 2024 08:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SxQ5ORWOAmZCfQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 26 Mar 2024 08:57:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94944A0812; Tue, 26 Mar 2024 09:57:53 +0100 (CET)
Date: Tue, 26 Mar 2024 09:57:53 +0100
From: Jan Kara <jack@suse.cz>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fs: Annotate struct file_handle with
 __counted_by() and use struct_size()
Message-ID: <20240326085753.dh6fj7skdzddkdva@quack3>
References: <ZgImCXTdGDTeBvSS@neat>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgImCXTdGDTeBvSS@neat>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Mon 25-03-24 19:34:01, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c       | 8 ++++----
>  include/linux/fs.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 57a12614addf..53ed54711cd2 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -36,7 +36,7 @@ static long do_sys_name_to_handle(const struct path *path,
>  	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
>  		return -EINVAL;
>  
> -	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
> +	handle = kzalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
>  			 GFP_KERNEL);
>  	if (!handle)
>  		return -ENOMEM;
> @@ -71,7 +71,7 @@ static long do_sys_name_to_handle(const struct path *path,
>  	/* copy the mount id */
>  	if (put_user(real_mount(path->mnt)->mnt_id, mnt_id) ||
>  	    copy_to_user(ufh, handle,
> -			 sizeof(struct file_handle) + handle_bytes))
> +			 struct_size(handle, f_handle, handle_bytes)))
>  		retval = -EFAULT;
>  	kfree(handle);
>  	return retval;
> @@ -192,7 +192,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  		retval = -EINVAL;
>  		goto out_err;
>  	}
> -	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
> +	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
>  			 GFP_KERNEL);
>  	if (!handle) {
>  		retval = -ENOMEM;
> @@ -202,7 +202,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	*handle = f_handle;
>  	if (copy_from_user(&handle->f_handle,
>  			   &ufh->f_handle,
> -			   f_handle.handle_bytes)) {
> +			   struct_size(ufh, f_handle, f_handle.handle_bytes))) {
>  		retval = -EFAULT;
>  		goto out_handle;
>  	}
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 034f0c918eea..1540e28d10d7 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1033,7 +1033,7 @@ struct file_handle {
>  	__u32 handle_bytes;
>  	int handle_type;
>  	/* file identifier */
> -	unsigned char f_handle[];
> +	unsigned char f_handle[] __counted_by(handle_bytes);
>  };
>  
>  static inline struct file *get_file(struct file *f)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

