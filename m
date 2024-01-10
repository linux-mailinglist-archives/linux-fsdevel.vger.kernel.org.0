Return-Path: <linux-fsdevel+bounces-7698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7348297DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 11:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B771F257D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3E4776E;
	Wed, 10 Jan 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sg3J2fRk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qppIhJLg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sg3J2fRk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qppIhJLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843146BA6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3B4F221BF;
	Wed, 10 Jan 2024 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704883631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0GYYWaGr/Ktvdk5JMsJfx0eJkw360V2zsfD0p8Anjg=;
	b=sg3J2fRkYuCUc0rmMbm3E3eLQ3FPNIByxs0DbUsUtfmuIoxNc666yiGSRT353CNk2Gnuj2
	IHlOFjQ7rnwK4eH1ww//z8x8SIUe0yF5xxk4l9lURannfv82c+D3+F7IBjtfl9vDpP0j47
	cXvyN9Vh6SH4LNF4rD8zrHw7W+kzlGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704883631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0GYYWaGr/Ktvdk5JMsJfx0eJkw360V2zsfD0p8Anjg=;
	b=qppIhJLgaHe9lRf/orkVvMUuOlrGgXPdMCkvdxkWu7QypCZs0vKgyNjGvn7sjoAesKE9fO
	tISt74OJjM2BeFBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704883631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0GYYWaGr/Ktvdk5JMsJfx0eJkw360V2zsfD0p8Anjg=;
	b=sg3J2fRkYuCUc0rmMbm3E3eLQ3FPNIByxs0DbUsUtfmuIoxNc666yiGSRT353CNk2Gnuj2
	IHlOFjQ7rnwK4eH1ww//z8x8SIUe0yF5xxk4l9lURannfv82c+D3+F7IBjtfl9vDpP0j47
	cXvyN9Vh6SH4LNF4rD8zrHw7W+kzlGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704883631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0GYYWaGr/Ktvdk5JMsJfx0eJkw360V2zsfD0p8Anjg=;
	b=qppIhJLgaHe9lRf/orkVvMUuOlrGgXPdMCkvdxkWu7QypCZs0vKgyNjGvn7sjoAesKE9fO
	tISt74OJjM2BeFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A883113786;
	Wed, 10 Jan 2024 10:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I8UcKa91nmX7FAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Jan 2024 10:47:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45F67A07EB; Wed, 10 Jan 2024 11:47:11 +0100 (CET)
Date: Wed, 10 Jan 2024 11:47:11 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: compile out fsnotify permission hooks if
 !FANOTIFY_ACCESS_PERMISSIONS
Message-ID: <20240110104711.kbkkvugsp72kaigz@quack3>
References: <20240109182245.38884-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109182245.38884-1-amir73il@gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SUBJECT_HAS_EXCLAIM(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 09-01-24 20:22:45, Amir Goldstein wrote:
> The depency of FANOTIFY_ACCESS_PERMISSIONS on SECURITY made sure that
> the fsnotify permission hooks were never called when SECURITY was
> disabled.
> 
> Moving the fsnotify permission hook out of the secutiy hook broke that
> optimisation.
> 
> Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> Closes: https://lore.kernel.org/linux-fsdevel/53682ece-f0e7-48de-9a1c-879ee34b0449@kernel.dk/
> Fixes: d9e5d31084b0 ("fsnotify: optionally pass access range in file permission hooks")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Originally I didn't notice this was directed to Christian but it makes
sense since he merged the original patches. The fix looks good (modulo the
typo fixes from Jens). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fsnotify.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 11e6434b8e71..8300a5286988 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -100,6 +100,7 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
>  	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
>  }
>  
> +#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
>  /*
>   * fsnotify_file_area_perm - permission hook before access to file range
>   */
> @@ -145,6 +146,24 @@ static inline int fsnotify_open_perm(struct file *file)
>  	return fsnotify_file(file, FS_OPEN_PERM);
>  }
>  
> +#else
> +static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
> +					  const loff_t *ppos, size_t count)
> +{
> +	return 0;
> +}
> +
> +static inline int fsnotify_file_perm(struct file *file, int perm_mask)
> +{
> +	return 0;
> +}
> +
> +static inline int fsnotify_open_perm(struct file *file)
> +{
> +	return 0;
> +}
> +#endif
> +
>  /*
>   * fsnotify_link_count - inode's link count changed
>   */
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

