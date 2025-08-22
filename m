Return-Path: <linux-fsdevel+bounces-58825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91C3B31BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB11B26DA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B58309DCB;
	Fri, 22 Aug 2025 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1XZeje6J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3ZLqxK8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1XZeje6J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3ZLqxK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D230309DA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872411; cv=none; b=IrlBy8vvfJIM09rNAAODv2xL1TVNF2r9SZpfPBLxzGjPrRt0WD9IhqyolK+LJLpYV8i+MvHfwSDsuyLaKARo4ztaP2lo0rCZdLCQLjEX08Qa4KfdcuDLV09ah5XqTIZBBR/rjccnj4bBN6yVoxN6ujlODTS3ns2moAnD7Pxwfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872411; c=relaxed/simple;
	bh=nQE9r7G5CWavUuRBc3xAi37pI2d0WQHU+eeMs11R1B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQhjOlYQmzBVnFHKAzBC6Wg/F329saD4HmTOii1FLjcBFNT0E9IGYY5g48C+XxgWGTpg3JVfzhMUOYldj4mqKwPPJ0SR72yVVFHCqlMYy1nGGKoN+XtNwni8+cAq26fBZCZ7c5mOR0Kid1WRa/uOZ7ZYORzxhpsV7jGesa0vf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1XZeje6J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w3ZLqxK8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1XZeje6J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w3ZLqxK8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68B8221BC3;
	Fri, 22 Aug 2025 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755872408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKc5BTdPu3Rsof7yJN5Q89HpTL4t7IT0AhCdAIGjIGw=;
	b=1XZeje6JpV21b0deiZIfKyuFyWZG8zYeiWaPRpGC4aTISdq7wwCNkxUG1Gv1vgLOS1q+7C
	whwBRdZErFT5IwIAURP1XBimffXwgSqDQP5W4S817ekZunrdcDF1OnmHxalbqJt+chjVfr
	QpaHBjCwWZkIcwN9Zn9CEmRT4Ggdzdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755872408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKc5BTdPu3Rsof7yJN5Q89HpTL4t7IT0AhCdAIGjIGw=;
	b=w3ZLqxK8WTq0uRmLih3bDrgKzhG9ldjdSutiL9c8iL5gvGJmJOevxIFFa7R7ckDrp0sqF8
	azLEVZXQXK8P0gAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755872408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKc5BTdPu3Rsof7yJN5Q89HpTL4t7IT0AhCdAIGjIGw=;
	b=1XZeje6JpV21b0deiZIfKyuFyWZG8zYeiWaPRpGC4aTISdq7wwCNkxUG1Gv1vgLOS1q+7C
	whwBRdZErFT5IwIAURP1XBimffXwgSqDQP5W4S817ekZunrdcDF1OnmHxalbqJt+chjVfr
	QpaHBjCwWZkIcwN9Zn9CEmRT4Ggdzdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755872408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKc5BTdPu3Rsof7yJN5Q89HpTL4t7IT0AhCdAIGjIGw=;
	b=w3ZLqxK8WTq0uRmLih3bDrgKzhG9ldjdSutiL9c8iL5gvGJmJOevxIFFa7R7ckDrp0sqF8
	azLEVZXQXK8P0gAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C3F513931;
	Fri, 22 Aug 2025 14:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aRPECph8qGh3CAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Aug 2025 14:20:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A5F4A0999; Fri, 22 Aug 2025 16:20:07 +0200 (CEST)
Date: Fri, 22 Aug 2025 16:20:07 +0200
From: Jan Kara <jack@suse.cz>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Use try_cmpxchg() in sb_init_done_wq()
Message-ID: <kh7s7k4hipfppnthiq463svhzfqr7m2ovl3zehofmqyxps3d4s@jlklhf5mtrdx>
References: <20250811132326.620521-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811132326.620521-1-ubizjak@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Mon 11-08-25 15:23:03, Uros Bizjak wrote:
> Use !try_cmpxchg() instead of cmpxchg(*ptr, old, new) != old.
> 
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after CMPXCHG.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 7f876f32343a..e91718017701 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -2318,13 +2318,15 @@ int sb_init_dio_done_wq(struct super_block *sb)
>  						      sb->s_id);
>  	if (!wq)
>  		return -ENOMEM;
> +
> +	old = NULL;
>  	/*
>  	 * This has to be atomic as more DIOs can race to create the workqueue
>  	 */
> -	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
> -	/* Someone created workqueue before us? Free ours... */
> -	if (old)
> +	if (!try_cmpxchg(&sb->s_dio_done_wq, &old, wq)) {
> +		/* Someone created workqueue before us? Free ours... */
>  		destroy_workqueue(wq);
> +	}
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sb_init_dio_done_wq);
> -- 
> 2.50.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

