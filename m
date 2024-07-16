Return-Path: <linux-fsdevel+bounces-23750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5691D9324A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 13:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798801C21ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E41990AA;
	Tue, 16 Jul 2024 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/ERb0z7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="08YWWQ95";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s/ERb0z7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="08YWWQ95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A7450F2;
	Tue, 16 Jul 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128321; cv=none; b=kcpSY9eWpPS0axi51mWzRfwX5JLWiJw+j5CPHS0RdwIjom8Ev+lAgJV4OwnPDrFfKA/nmraekIKMW9AWuTtzESD1coDW1d0WWe5u1xVFb3FEXmhf3Cr1TTcCTunF8Y3nSivlXfsp9pYQ0AQ78yO3dyYGo/oMtH1pmdYV5K0SoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128321; c=relaxed/simple;
	bh=0vY9oB0wJG33ZForSuVbyomL10P6lGH1BYfodotrqMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUGurfejAPMhXHdQPmyWS3DS+9zZgsOqn5KTUqlQsC7FHOLiamLQrbhabq/ckQ3Pjwa6P5EhDv+QP7TxLUpI0Urj59fWsnbG5VpEICx3T39l8gLI57wwIJ53IsyJ6FUj8jFykgTq8KS6yr3aRCkkVgwTmmRsQjdeJ7hhGXBGjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/ERb0z7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=08YWWQ95; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s/ERb0z7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=08YWWQ95; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C279D1F8AE;
	Tue, 16 Jul 2024 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721128317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ic0DUfS6E4Agr0btoOv+0XKFKvt3C6xqRimAilWQ0M=;
	b=s/ERb0z7tltpnt6y1uMPgW/oiRhYaBLn2ci+W8Ayw+4nasJ7eV0L3pS0epTe6odHfQyluP
	8N2a1YeNE4qnKbFoPf1sl6VNCaAVu0VKZqtuI43w41Rauo5YQ1yGKfD8alZc/vyBFLVAUD
	MPwr6AmdmLgagm/2l9SKXZhNA/Ma4HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721128317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ic0DUfS6E4Agr0btoOv+0XKFKvt3C6xqRimAilWQ0M=;
	b=08YWWQ95I/gk5v8snQSKVrDx7MYYYxJ1tfbzo3RPYR+JuSixaQHs4X8fCpsadm0W/ugYtZ
	zqOLYEy5Y56f7GBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="s/ERb0z7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=08YWWQ95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721128317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ic0DUfS6E4Agr0btoOv+0XKFKvt3C6xqRimAilWQ0M=;
	b=s/ERb0z7tltpnt6y1uMPgW/oiRhYaBLn2ci+W8Ayw+4nasJ7eV0L3pS0epTe6odHfQyluP
	8N2a1YeNE4qnKbFoPf1sl6VNCaAVu0VKZqtuI43w41Rauo5YQ1yGKfD8alZc/vyBFLVAUD
	MPwr6AmdmLgagm/2l9SKXZhNA/Ma4HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721128317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ic0DUfS6E4Agr0btoOv+0XKFKvt3C6xqRimAilWQ0M=;
	b=08YWWQ95I/gk5v8snQSKVrDx7MYYYxJ1tfbzo3RPYR+JuSixaQHs4X8fCpsadm0W/ugYtZ
	zqOLYEy5Y56f7GBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2CD613795;
	Tue, 16 Jul 2024 11:11:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BUCkK31Vlma5PQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jul 2024 11:11:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C6E3A0987; Tue, 16 Jul 2024 13:11:53 +0200 (CEST)
Date: Tue, 16 Jul 2024 13:11:53 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v4 1/3] fs/file.c: remove sanity_check and add
 likely/unlikely in alloc_fd()
Message-ID: <20240716111153.lrwr2rdg6roka2x6@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240713023917.3967269-1-yu.ma@intel.com>
 <20240713023917.3967269-2-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713023917.3967269-2-yu.ma@intel.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C279D1F8AE

On Fri 12-07-24 22:39:15, Yu Ma wrote:
> alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> allocated fd is NULL. Remove this sanity check since it can be assured by
> exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
> likely/unlikely and expand_file() call avoidance to reduce the work under
> file_lock.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index a3b72aa64f11..e1b9d6df7941 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -515,7 +515,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	if (fd < files->next_fd)
>  		fd = files->next_fd;
>  
> -	if (fd < fdt->max_fds)
> +	if (likely(fd < fdt->max_fds))
>  		fd = find_next_fd(fdt, fd);
>  
>  	/*
> @@ -523,19 +523,21 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	 * will limit the total number of files that can be opened.
>  	 */
>  	error = -EMFILE;
> -	if (fd >= end)
> +	if (unlikely(fd >= end))
>  		goto out;
>  
> -	error = expand_files(files, fd);
> -	if (error < 0)
> -		goto out;
> +	if (unlikely(fd >= fdt->max_fds)) {
> +		error = expand_files(files, fd);
> +		if (error < 0)
> +			goto out;
>  
> -	/*
> -	 * If we needed to expand the fs array we
> -	 * might have blocked - try again.
> -	 */
> -	if (error)
> -		goto repeat;
> +		/*
> +		 * If we needed to expand the fs array we
> +		 * might have blocked - try again.
> +		 */
> +		if (error)
> +			goto repeat;
> +	}
>  
>  	if (start <= files->next_fd)
>  		files->next_fd = fd + 1;
> @@ -546,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	else
>  		__clear_close_on_exec(fd, fdt);
>  	error = fd;
> -#if 1
> -	/* Sanity check */
> -	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
> -		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> -		rcu_assign_pointer(fdt->fd[fd], NULL);
> -	}
> -#endif
>  
>  out:
>  	spin_unlock(&files->file_lock);
> @@ -618,7 +613,7 @@ void fd_install(unsigned int fd, struct file *file)
>  		rcu_read_unlock_sched();
>  		spin_lock(&files->file_lock);
>  		fdt = files_fdtable(files);
> -		BUG_ON(fdt->fd[fd] != NULL);
> +		WARN_ON(fdt->fd[fd] != NULL);
>  		rcu_assign_pointer(fdt->fd[fd], file);
>  		spin_unlock(&files->file_lock);
>  		return;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

