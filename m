Return-Path: <linux-fsdevel+bounces-67667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EAFC460BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1946D3B3904
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260A306499;
	Mon, 10 Nov 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbU+pPnI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7spBBA46";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbU+pPnI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7spBBA46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8C2FFFA8
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771657; cv=none; b=qZ5vI5mNPcimLZ1oBN4UIUUKOBEyiZ8Ak5/WY+Hz2WpMhBpY1i0CwwNzvI2ySAPYhXWFvR7pMDVEt/+L6lj8qMazvLgFosiFlB0k6c9raFasPGKsw2qza2xjLgb+XvZgP773E5F3yJbhPlUDnQ1B9jDm4hYmtcVWgle+0bTIiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771657; c=relaxed/simple;
	bh=Eo7RZoUL7l0/1gH/3UEyxcymuoJvJUE2YepVh/83NnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogRfHRhlEXkYpo8kMB/732nignE4x0Iyfmb49w2rWq1ly8dj6n/aH3DVX3CSEPRshxQGPNpQNHuv4PSM7Vq62xNbL+nVwWWDuEkfCMCYL+YPTDOAgTajYhJ9dOBtJshFpAcknYcO28vngW5zW/JGDZ2qxZde0QLbhabhiBNV978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbU+pPnI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7spBBA46; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbU+pPnI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7spBBA46; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 734F21F449;
	Mon, 10 Nov 2025 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762771654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyTyJYOj8Go/lJND2u8cb4af3+7OG2+cVk6eC6qUr2w=;
	b=TbU+pPnIx0sKoHeQ7Ah8U4ZgIX1Q6Ch5w1Voij1zK0TL/LB8UQZRm4xn6GEzaH3ubzNxxY
	Z835G2pDs6zGQtuy6jORTEZgIMfO+6hu4tHjFTOfLz7sOT9aofC1mS56CJY0x6VkJ+rWFp
	X0Ae7mXN0EA6+Pm9C1miOU788nzaa2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762771654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyTyJYOj8Go/lJND2u8cb4af3+7OG2+cVk6eC6qUr2w=;
	b=7spBBA46/Zn/v7PtTNXUJBon9BtmwU6k3B4BLnFhGe68ZytKp6Uq0WjEz1HF/vunFElD4d
	9TwKEhlHeDj7iiDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762771654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyTyJYOj8Go/lJND2u8cb4af3+7OG2+cVk6eC6qUr2w=;
	b=TbU+pPnIx0sKoHeQ7Ah8U4ZgIX1Q6Ch5w1Voij1zK0TL/LB8UQZRm4xn6GEzaH3ubzNxxY
	Z835G2pDs6zGQtuy6jORTEZgIMfO+6hu4tHjFTOfLz7sOT9aofC1mS56CJY0x6VkJ+rWFp
	X0Ae7mXN0EA6+Pm9C1miOU788nzaa2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762771654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OyTyJYOj8Go/lJND2u8cb4af3+7OG2+cVk6eC6qUr2w=;
	b=7spBBA46/Zn/v7PtTNXUJBon9BtmwU6k3B4BLnFhGe68ZytKp6Uq0WjEz1HF/vunFElD4d
	9TwKEhlHeDj7iiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 640A61435B;
	Mon, 10 Nov 2025 10:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e75sGMbCEWlENQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 10:47:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18D02A28B1; Mon, 10 Nov 2025 11:47:34 +0100 (CET)
Date: Mon, 10 Nov 2025 11:47:34 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch predicts in do_dentry_open()
Message-ID: <jxuw4d73w4gjnuzykcanbawpjyw5bw5jq6pq2bo3fsyykhdeob@wp2536gkor5m>
References: <20251109125254.1288882-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109125254.1288882-1-mjguzik@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sun 09-11-25 13:52:54, Mateusz Guzik wrote:
> Helps out some of the asm, the routine is still a mess.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/open.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 1d73a17192da..2a2cf9007900 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -937,7 +937,7 @@ static int do_dentry_open(struct file *f,
>  	}
>  
>  	error = security_file_open(f);
> -	if (error)
> +	if (unlikely(error))
>  		goto cleanup_all;
>  
>  	/*
> @@ -947,11 +947,11 @@ static int do_dentry_open(struct file *f,
>  	 * pseudo file, this call will not change the mode.
>  	 */
>  	error = fsnotify_open_perm_and_set_mode(f);
> -	if (error)
> +	if (unlikely(error))
>  		goto cleanup_all;
>  
>  	error = break_lease(file_inode(f), f->f_flags);
> -	if (error)
> +	if (unlikely(error))
>  		goto cleanup_all;
>  
>  	/* normally all 3 are set; ->open() can clear them if needed */
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

