Return-Path: <linux-fsdevel+bounces-36405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF759E376D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D01689B7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC561AE850;
	Wed,  4 Dec 2024 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AxXL38uL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EYPw0ERa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AxXL38uL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EYPw0ERa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E618595B;
	Wed,  4 Dec 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308008; cv=none; b=uxy2RuAvcbDmkkbNjMVfaFozkIA5H4p6n17CUspycKq0ekcLgxifXYwtSFC2F4AaHWcG13eZZLZWBSKpHrSixgNf4NqSrKnUkgENY5VcPov/iSLRyigFi7UOHfnU5eTX/xLogT9+nCNJtdDC75JJF+weKdroejh1yTNJ8L8R03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308008; c=relaxed/simple;
	bh=Qd0F3egUN7kHXwDsL4fJtJDP0OqWwrdfzqUz7Xemqlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7g3fe2IoZZFt6SjGrsHji9xokdAf3OczxHQ0dWefFJTOhVJhM93WGXbPcxli6WCFYUySIPWvm8OUO5zTetzzsRFXPKBOwsYWWytTsYKnUNmDsSKI4G87an3u7NraD/dZKrmg9P3VAEnKY3U7ZDkRmYzDQCpvbk/WwkZ89GZKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AxXL38uL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EYPw0ERa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AxXL38uL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EYPw0ERa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D53F621108;
	Wed,  4 Dec 2024 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733308004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uId7JQaXkF6OJdFvV3glatDGWkcnpYN3hdmZFBRAexw=;
	b=AxXL38uLNw5H5K/7TFpCS/LhozBV6m/pBY5/hRJywkB3ufDMZduCSmPiJoyErg8BhLtZ7v
	NwZXtb7Y8m+fHjXZd4IaI16Eb+shuItPJy70I1+bEx5MlHq6k4ixF8a9pk6kfCqZ/JjN+T
	kQn116DcCmbMFUtT0aOgKmTZ4+JLLzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733308004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uId7JQaXkF6OJdFvV3glatDGWkcnpYN3hdmZFBRAexw=;
	b=EYPw0ERacqZ0eu4hhE9+W4eHzmZo+IFE3O8ThPn88+2t380q6yyAiI94TkXPUs6AlrnTgQ
	WT3geLYhA8gcg5Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733308004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uId7JQaXkF6OJdFvV3glatDGWkcnpYN3hdmZFBRAexw=;
	b=AxXL38uLNw5H5K/7TFpCS/LhozBV6m/pBY5/hRJywkB3ufDMZduCSmPiJoyErg8BhLtZ7v
	NwZXtb7Y8m+fHjXZd4IaI16Eb+shuItPJy70I1+bEx5MlHq6k4ixF8a9pk6kfCqZ/JjN+T
	kQn116DcCmbMFUtT0aOgKmTZ4+JLLzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733308004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uId7JQaXkF6OJdFvV3glatDGWkcnpYN3hdmZFBRAexw=;
	b=EYPw0ERacqZ0eu4hhE9+W4eHzmZo+IFE3O8ThPn88+2t380q6yyAiI94TkXPUs6AlrnTgQ
	WT3geLYhA8gcg5Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAE4D1396E;
	Wed,  4 Dec 2024 10:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F2mCMWQuUGe7fgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 10:26:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86099A0918; Wed,  4 Dec 2024 11:26:44 +0100 (CET)
Date: Wed, 4 Dec 2024 11:26:44 +0100
From: Jan Kara <jack@suse.cz>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] file: Wrap locking mechanism for f_pos_lock
Message-ID: <20241204102644.hvutdftkueiiyss7@quack3>
References: <20241204092325.170349-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204092325.170349-1-richard120310@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 04-12-24 17:23:25, I Hsin Cheng wrote:
> As the implementation of "f->f_pos_lock" may change in the future,
> wrapping the actual implementation of locking and unlocking of it can
> provide better decoupling semantics.
> 
> "__f_unlock_pos()" already exist and does that, adding "__f_lock_pos()"
> can provide full decoupling.
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

I guess this would make sense for consistence. But Al, what was the
motivation of introducing __f_unlock_pos() in the first place? It has one
caller and was silently introduced in 63b6df14134d ("give
readdir(2)/getdents(2)/etc. uniform exclusion with lseek()") about 8 years
ago.

								Honza


> ---
>  fs/file.c            | 7 ++++++-
>  include/linux/file.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index fb1011cf6b4a..b93ac67d276d 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1181,6 +1181,11 @@ static inline bool file_needs_f_pos_lock(struct file *file)
>  		(file_count(file) > 1 || file->f_op->iterate_shared);
>  }
>  
> +void __f_lock_pos(struct file *f)
> +{
> +	mutex_lock(&f->f_pos_lock);
> +}
> +
>  struct fd fdget_pos(unsigned int fd)
>  {
>  	struct fd f = fdget(fd);
> @@ -1188,7 +1193,7 @@ struct fd fdget_pos(unsigned int fd)
>  
>  	if (file && file_needs_f_pos_lock(file)) {
>  		f.word |= FDPUT_POS_UNLOCK;
> -		mutex_lock(&file->f_pos_lock);
> +		__f_lock_pos(file);
>  	}
>  	return f;
>  }
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 302f11355b10..16292bd95499 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -67,6 +67,7 @@ extern struct file *fget(unsigned int fd);
>  extern struct file *fget_raw(unsigned int fd);
>  extern struct file *fget_task(struct task_struct *task, unsigned int fd);
>  extern struct file *fget_task_next(struct task_struct *task, unsigned int *fd);
> +extern void __f_lock_pos(struct file *file);
>  extern void __f_unlock_pos(struct file *);
>  
>  struct fd fdget(unsigned int fd);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

