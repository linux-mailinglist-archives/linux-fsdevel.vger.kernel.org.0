Return-Path: <linux-fsdevel+bounces-69783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97965C84EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15CC3AD35F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF121D5151;
	Tue, 25 Nov 2025 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0c7B1PUB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHQOzoKe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0c7B1PUB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YHQOzoKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F51BC41
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073026; cv=none; b=bW1aGLf5kE+wIgfjxYzsJ9FcwpGFHLhdtnrwrN/l4qLmMsP+AL6S4KNTKd5RbnN1XGLQM4pQXTmQ3RyBqNPJGpzXXMQLJeW4CxFRzAuiFQpHyPFyWL9HKtjwrusfIWf/qXPr2FTAIO6rs4ohcOlmyqAwcRK4MN0sqlX0Ppm+W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073026; c=relaxed/simple;
	bh=+HJQFzvNz8jRR7iE9Bsb+Anh/AS+T9cAg5dKAoLUsao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2/l2xlud0/hmLeuCoP/4XM3nYgUAmsbOMzwoRDVhNzz9XeQTA+hWtYGCmyjj2BGVAunw6oRm7yLaGcskw1VGQra9OOuZG3XltQliJudIrvXCwwcZS+y3lttQd9ISS4WaDPLuOUAmdysK/8VhbHjWcvgl9fQPFY9hJm2EP6HWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0c7B1PUB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YHQOzoKe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0c7B1PUB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YHQOzoKe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9352822836;
	Tue, 25 Nov 2025 12:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLsmFZTLe5mnmzDjJEvqG+uTW+d6fhq64U+kWX0/WWM=;
	b=0c7B1PUB2T6w9/CBnWEVo3h8QUB3ZnigWeikm+ZzfSRvFIMWSJVq0fVgLdJdUgeDf44QFy
	5hzYcaMW80eDC9PlPvSPhpaQN6FsH1KgZnneAdD75i1DuDAxjTOAvcEgWl+8bGgPbOVahB
	+WVIVwICts8AltTlOpVUdSkFsOPIXyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLsmFZTLe5mnmzDjJEvqG+uTW+d6fhq64U+kWX0/WWM=;
	b=YHQOzoKebtou6f48YwEZmB+J4bgowt4+TZ4n7XfYOrdkuiDNGxa5qGBpwsy6GANfUD3EVs
	dBWbLL2tpvMITzDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0c7B1PUB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YHQOzoKe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLsmFZTLe5mnmzDjJEvqG+uTW+d6fhq64U+kWX0/WWM=;
	b=0c7B1PUB2T6w9/CBnWEVo3h8QUB3ZnigWeikm+ZzfSRvFIMWSJVq0fVgLdJdUgeDf44QFy
	5hzYcaMW80eDC9PlPvSPhpaQN6FsH1KgZnneAdD75i1DuDAxjTOAvcEgWl+8bGgPbOVahB
	+WVIVwICts8AltTlOpVUdSkFsOPIXyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLsmFZTLe5mnmzDjJEvqG+uTW+d6fhq64U+kWX0/WWM=;
	b=YHQOzoKebtou6f48YwEZmB+J4bgowt4+TZ4n7XfYOrdkuiDNGxa5qGBpwsy6GANfUD3EVs
	dBWbLL2tpvMITzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A5823EA63;
	Tue, 25 Nov 2025 12:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EkHDIT6eJWm/YgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:17:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49AD4A0C7D; Tue, 25 Nov 2025 13:16:58 +0100 (CET)
Date: Tue, 25 Nov 2025 13:16:58 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 02/47] anon_inodes: convert to FD_PREPARE()
Message-ID: <ccf4vfqm6og5fcvws3x6fbs6ocbxwign3r2s6kcikvshjugrzf@uqpqtuzkyyer>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-2-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-2-b6efa1706cfd@kernel.org>
X-Rspamd-Queue-Id: 9352822836
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,gmail.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sun 23-11-25 17:33:20, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good (except for the subject). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/anon_inodes.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 180a458fc4f7..b8381c7fb636 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -280,27 +280,8 @@ static int __anon_inode_getfd(const char *name,
>  			      const struct inode *context_inode,
>  			      bool make_inode)
>  {
> -	int error, fd;
> -	struct file *file;
> -
> -	error = get_unused_fd_flags(flags);
> -	if (error < 0)
> -		return error;
> -	fd = error;
> -
> -	file = __anon_inode_getfile(name, fops, priv, flags, context_inode,
> -				    make_inode);
> -	if (IS_ERR(file)) {
> -		error = PTR_ERR(file);
> -		goto err_put_unused_fd;
> -	}
> -	fd_install(fd, file);
> -
> -	return fd;
> -
> -err_put_unused_fd:
> -	put_unused_fd(fd);
> -	return error;
> +	return FD_ADD(flags, __anon_inode_getfile(name, fops, priv, flags,
> +						  context_inode, make_inode));
>  }
>  
>  /**
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

