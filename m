Return-Path: <linux-fsdevel+bounces-22337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05639166F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3531F21887
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D814E2D6;
	Tue, 25 Jun 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PQNQpVje";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvibTnoa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PQNQpVje";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvibTnoa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B576033;
	Tue, 25 Jun 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317323; cv=none; b=lSCZb5ZgbHPbYadUGBnIZj5KJnAD4jOX3TRPwoUKRLuzdKdipvy+9XSXckykQU/kOgPMcRGV3spZw2pqxjHqXqKgY1jklL6nQb5qD9OJT1x+h/j7xYC0RjC11klvmRrUiGJLqFb5AS8doCS+e+rbGXmz0YIpPX3IsNjXaWZwJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317323; c=relaxed/simple;
	bh=2r0uALkFc6vvmeqL1UhWDQZ5lDOnGVHj6yrsjWC5mS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCa9aGSHc84F0BXAm3qVMPtneBZ3z10KTR9SyLSxvlbKz4YEt6WPT9BH8V5nGoyVWnQxRCGy/Im5yB6zDz69nW5a7lokPvR46zuR24YrbHJz3+Qm5uKbJhNbRIBfOn/pclXkjxu04KU5S/t+a1giiysd6VGMZX/FkdXaEBdRnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PQNQpVje; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvibTnoa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PQNQpVje; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvibTnoa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CAA121A7C;
	Tue, 25 Jun 2024 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719317319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKr3fmskTeVyLYoDvJWp4jLb4hxm+tbQefTt6txxgjM=;
	b=PQNQpVjecryUmLZiFVfqeLI+KaUvc99E9K28F9prZzPPHqug1+dYJySsm+9IcWjJSPYCR0
	mDCapgFzBt9eStzFukm2KNqKlM++FRXHeu2OwzP95nMB6sr+rOF2ELvIapm0U99G2UsJw5
	2sko7QnPkGiNlGzMQrv+bIoMkb2nP98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719317319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKr3fmskTeVyLYoDvJWp4jLb4hxm+tbQefTt6txxgjM=;
	b=fvibTnoaDt+PhRheCHPxpEZzz4aynQEXlAUWcmjhV0h+mB3LzEgUJzhOIfqPoJ7v8Q8GeA
	q0Y/h/+oU1wtrBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719317319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKr3fmskTeVyLYoDvJWp4jLb4hxm+tbQefTt6txxgjM=;
	b=PQNQpVjecryUmLZiFVfqeLI+KaUvc99E9K28F9prZzPPHqug1+dYJySsm+9IcWjJSPYCR0
	mDCapgFzBt9eStzFukm2KNqKlM++FRXHeu2OwzP95nMB6sr+rOF2ELvIapm0U99G2UsJw5
	2sko7QnPkGiNlGzMQrv+bIoMkb2nP98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719317319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKr3fmskTeVyLYoDvJWp4jLb4hxm+tbQefTt6txxgjM=;
	b=fvibTnoaDt+PhRheCHPxpEZzz4aynQEXlAUWcmjhV0h+mB3LzEgUJzhOIfqPoJ7v8Q8GeA
	q0Y/h/+oU1wtrBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DEA513A9A;
	Tue, 25 Jun 2024 12:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6b0XD0ezemZifQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 12:08:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00902A087F; Tue, 25 Jun 2024 14:08:34 +0200 (CEST)
Date: Tue, 25 Jun 2024 14:08:34 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	mjguzik@gmail.com, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 3/3] fs/file.c: remove sanity_check from alloc_fd()
Message-ID: <20240625120834.rhkm3p5by5jfc3bw@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-4-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622154904.3774273-4-yu.ma@intel.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,google.com,vger.kernel.org,intel.com,linux.intel.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,intel.com:email]

On Sat 22-06-24 11:49:04, Yu Ma wrote:
> alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> allocated fd is NULL. Remove this sanity check since it can be assured by
> exisitng zero initilization and NULL set when recycling fd.
  ^^^ existing  ^^^ initialization

Well, since this is a sanity check, it is expected it never hits. Yet
searching the web shows it has hit a few times in the past :). So would
wrapping this with unlikely() give a similar performance gain while keeping
debugability? If unlikely() does not help, I agree we can remove this since
fd_install() actually has the same check:

BUG_ON(fdt->fd[fd] != NULL);

and there we need the cacheline anyway so performance impact is minimal.
Now, this condition in alloc_fd() is nice that it does not take the kernel
down so perhaps we could change the BUG_ON to WARN() dumping similar kind
of info as alloc_fd()?

								Honza

> Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improved by
> 32%, write improved by 17% on Intel ICX 160 cores configuration with v6.10-rc4.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index b4d25f6d4c19..1153b0b7ba3d 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -555,13 +555,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
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
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

