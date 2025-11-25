Return-Path: <linux-fsdevel+bounces-69784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB2C84F0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1397634A7B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B711925F797;
	Tue, 25 Nov 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YpolDSY+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lL+YODfr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DTO7UpEz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D9Y9QVJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132A1D5151
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073142; cv=none; b=ZKU+2DMN509qzVHLOUaHOvVxFeTJmQu2QLJsxZnqiEu4Jqa4rzQJcfJ9W7dMPzU+hB57ZSsOn6zoh0LXHIrEiiSGJcsaer5yomL5ChC4BqoZlkDzeNlMIil+xByzQTFzcJXdKFPb/cvIlw6VUW0gDYbtjkX5PDlteGqOza2r/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073142; c=relaxed/simple;
	bh=SN4Hnj0be6/t8TKjfJhnytcx4ctfBiRf3F/MpGScuLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb/RhYTf8fLvEUbK0Z3FytiHjujPfzm4CO3xKtefj4oomLL63WbFqOVrsevz4isgKUOl1tcv6HN236JJHVUTl30UnIHFrvefSNRtmhLv48sLaLTLVPQ16Ft5ccVm/SVvOG6pw90yL+oSyk0RJd5Pfgnton3mqV/s3L3jzBPY3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YpolDSY+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lL+YODfr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DTO7UpEz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D9Y9QVJO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9745E5BD82;
	Tue, 25 Nov 2025 12:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzDXeVmMu5r65ZbCyUfV6a88LuFWBlKJfnyQ7NZmyn8=;
	b=YpolDSY+Ioh7mgTsDMve8BI49BTpbw0qMbJu7F+5W7Xbid0WWWo0ILi/W3gBih/ZmAY+4/
	vYN8nTSj4YWhMAvYHHmTRsbKYCRdJxmF1thQmcVdfzsyLeklkSvypIMXQdngwoZDo2qtJl
	3VEPPID1xi4tMXRPXb93zNf6wLYEft0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzDXeVmMu5r65ZbCyUfV6a88LuFWBlKJfnyQ7NZmyn8=;
	b=lL+YODfr9L4INQ4fnjq3Lw/6lC0Int1EFe7TRSh/9vkAFRd6v36tGpGS0nB3DJfxKRMT2G
	+Sp6aCm4Bm60JJAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzDXeVmMu5r65ZbCyUfV6a88LuFWBlKJfnyQ7NZmyn8=;
	b=DTO7UpEzKzNc0hFBEqedjg+gC1EqtmFcdEPOCHomG/Cyg46TNty1J15w4zhWxdTLej1P1A
	xCR9IyMbfhXwrCLVoVeslxzPI6WLM88VJmAwGEjjTlzWd0B+RKAq6LOry6Oc/YIU+DXN8A
	NJ+y0RoyVawSoKIdSS4g+yt3iocjdkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rzDXeVmMu5r65ZbCyUfV6a88LuFWBlKJfnyQ7NZmyn8=;
	b=D9Y9QVJO6ptFNXKeyHYRjfOVRmUyZvGHuga4HF1nDFaVtXmf0r1LvqkaJtBfuBotMKKmtY
	Q65sOioiSbHZJYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C9FE3EA63;
	Tue, 25 Nov 2025 12:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2vlRIrGeJWkiZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:18:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00868A0C7D; Tue, 25 Nov 2025 13:18:56 +0100 (CET)
Date: Tue, 25 Nov 2025 13:18:56 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 03/47] eventfd: convert do_eventfd() to FD_PREPARE()
Message-ID: <chnhnaiylmd2mivkzp7ydz3hdd27kl3wymfw7f4bfpdx2fdp2b@txucmqn53rmw>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-3-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-3-b6efa1706cfd@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,gmail.com,kernel.dk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sun 23-11-25 17:33:21, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/eventfd.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index af42b2c7d235..3219e0d596fe 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -378,9 +378,7 @@ EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
>  
>  static int do_eventfd(unsigned int count, int flags)
>  {
> -	struct eventfd_ctx *ctx;
> -	struct file *file;
> -	int fd;
> +	struct eventfd_ctx *ctx __free(kfree) = NULL;
>  
>  	/* Check the EFD_* constants for consistency.  */
>  	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
> @@ -398,26 +396,19 @@ static int do_eventfd(unsigned int count, int flags)
>  	init_waitqueue_head(&ctx->wqh);
>  	ctx->count = count;
>  	ctx->flags = flags;
> -	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
>  
>  	flags &= EFD_SHARED_FCNTL_FLAGS;
>  	flags |= O_RDWR;
> -	fd = get_unused_fd_flags(flags);
> -	if (fd < 0)
> -		goto err;
> -
> -	file = anon_inode_getfile_fmode("[eventfd]", &eventfd_fops,
> -					ctx, flags, FMODE_NOWAIT);
> -	if (IS_ERR(file)) {
> -		put_unused_fd(fd);
> -		fd = PTR_ERR(file);
> -		goto err;
> -	}
> -	fd_install(fd, file);
> -	return fd;
> -err:
> -	eventfd_free_ctx(ctx);
> -	return fd;
> +
> +	FD_PREPARE(fdf, flags,
> +		   anon_inode_getfile_fmode("[eventfd]", &eventfd_fops, ctx,
> +					    flags, FMODE_NOWAIT));
> +	if (fdf.err)
> +		return fdf.err;
> +
> +	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
> +	retain_and_null_ptr(ctx);
> +	return fd_publish(fdf);
>  }
>  
>  SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

