Return-Path: <linux-fsdevel+bounces-27232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EED95FAA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78051C21F9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121B419AD7E;
	Mon, 26 Aug 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jmJlRpsq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PxwtNCbz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jmJlRpsq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PxwtNCbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7619AD6C;
	Mon, 26 Aug 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704074; cv=none; b=hRjYLJo6KDZqD53HHWzb6N59Kyct/GEwBdWV/e2iA77b2jN9+v3iyum6BFwoqhtK/+Ln4yNsZmwbE/ff7k4xhdNXy9y5n9FsreiEo0MPWYGluPuVX0wNWMUpSV83IBAJBjj3hWdSHyfgwH5Lam/0ccFFT9+0JrVinhGS/p6wHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704074; c=relaxed/simple;
	bh=0wcXTV/rFVMkp/cDt/kf4UlES21XY1MVv5gfdtAo1Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxT3kevs9T7qIIXqrBxbXSAN5Qf+QZh24Ppslia6AsszI1+F/V/dxv4NgO7Zza5b/4XIK42KgV+WpzImn0OZmR52j8Glfa240ekke6ZO3jLNOD911v6wOxeqxHpG0gvC4Uo4pkBCMTjEckLH5VZXUlNyTAcvgJEukLy3xC12c9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jmJlRpsq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PxwtNCbz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jmJlRpsq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PxwtNCbz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 007E821983;
	Mon, 26 Aug 2024 20:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724704071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDfujjrqBau35mEB6CAXbc5x49uJ7qFsUYMgdTp555g=;
	b=jmJlRpsq+LNMq0McnonRjlIW3Du4G2BK6GwitozgTE7iayGUbOqkNIe4eXlFNjZSLR0REE
	uHMuEw8Qj+Ea1VE6POSvg51EN3XP1Xr0l5L/PnLlT6QT4Qv9p1J0ElHvU1ieJjNlEKGywg
	BdbyyQYaDNTBLy3NabQ7J8VSFbSHKjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724704071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDfujjrqBau35mEB6CAXbc5x49uJ7qFsUYMgdTp555g=;
	b=PxwtNCbzIyLm9egcWYR+d6Y0RoUGc8Pze3MeRje+I9Am0X/CFINY8V7Zt4vDRPxehaAJjS
	En3ubBQGixgHTyDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jmJlRpsq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PxwtNCbz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724704071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDfujjrqBau35mEB6CAXbc5x49uJ7qFsUYMgdTp555g=;
	b=jmJlRpsq+LNMq0McnonRjlIW3Du4G2BK6GwitozgTE7iayGUbOqkNIe4eXlFNjZSLR0REE
	uHMuEw8Qj+Ea1VE6POSvg51EN3XP1Xr0l5L/PnLlT6QT4Qv9p1J0ElHvU1ieJjNlEKGywg
	BdbyyQYaDNTBLy3NabQ7J8VSFbSHKjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724704071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fDfujjrqBau35mEB6CAXbc5x49uJ7qFsUYMgdTp555g=;
	b=PxwtNCbzIyLm9egcWYR+d6Y0RoUGc8Pze3MeRje+I9Am0X/CFINY8V7Zt4vDRPxehaAJjS
	En3ubBQGixgHTyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA7A713724;
	Mon, 26 Aug 2024 20:27:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SbM8OUblzGaJRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Aug 2024 20:27:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D1E7A0965; Mon, 26 Aug 2024 22:27:46 +0200 (CEST)
Date: Mon, 26 Aug 2024 22:27:46 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jlayton@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: drop one lock trip in evict()
Message-ID: <20240826202746.ipovnb5hfom7jkmb@quack3>
References: <20240813143626.1573445-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813143626.1573445-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 007E821983
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 13-08-24 16:36:26, Mateusz Guzik wrote:
> Most commonly neither I_LRU_ISOLATING nor I_SYNC are set, but the stock
> kernel takes a back-to-back relock trip to check for them.
> 
> It probably can be avoided altogether, but for now massage things back
> to just one lock acquire.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Back from vacation so not sure if this is still actual but the patch looks
good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> there are smp_mb's in the area I'm going to look at removing at some
> point(tm), in the meantime I think this is an easy cleanup
> 
> has a side effect of whacking a inode_wait_for_writeback which was only
> there to deal with not holding the lock
> 
>  fs/fs-writeback.c | 17 +++--------------
>  fs/inode.c        |  5 +++--
>  2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 4451ecff37c4..1a5006329f6f 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1510,13 +1510,12 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
>   * Wait for writeback on an inode to complete. Called with i_lock held.
>   * Caller must make sure inode cannot go away when we drop i_lock.
>   */
> -static void __inode_wait_for_writeback(struct inode *inode)
> -	__releases(inode->i_lock)
> -	__acquires(inode->i_lock)
> +void inode_wait_for_writeback(struct inode *inode)
>  {
>  	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
>  	wait_queue_head_t *wqh;
>  
> +	lockdep_assert_held(&inode->i_lock);
>  	wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
>  	while (inode->i_state & I_SYNC) {
>  		spin_unlock(&inode->i_lock);
> @@ -1526,16 +1525,6 @@ static void __inode_wait_for_writeback(struct inode *inode)
>  	}
>  }
>  
> -/*
> - * Wait for writeback on an inode to complete. Caller must have inode pinned.
> - */
> -void inode_wait_for_writeback(struct inode *inode)
> -{
> -	spin_lock(&inode->i_lock);
> -	__inode_wait_for_writeback(inode);
> -	spin_unlock(&inode->i_lock);
> -}
> -
>  /*
>   * Sleep until I_SYNC is cleared. This function must be called with i_lock
>   * held and drops it. It is aimed for callers not holding any inode reference
> @@ -1757,7 +1746,7 @@ static int writeback_single_inode(struct inode *inode,
>  		 */
>  		if (wbc->sync_mode != WB_SYNC_ALL)
>  			goto out;
> -		__inode_wait_for_writeback(inode);
> +		inode_wait_for_writeback(inode);
>  	}
>  	WARN_ON(inode->i_state & I_SYNC);
>  	/*
> diff --git a/fs/inode.c b/fs/inode.c
> index 73183a499b1c..d48d29d39cd2 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -582,7 +582,7 @@ static void inode_unpin_lru_isolating(struct inode *inode)
>  
>  static void inode_wait_for_lru_isolating(struct inode *inode)
>  {
> -	spin_lock(&inode->i_lock);
> +	lockdep_assert_held(&inode->i_lock);
>  	if (inode->i_state & I_LRU_ISOLATING) {
>  		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
>  		wait_queue_head_t *wqh;
> @@ -593,7 +593,6 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
>  		spin_lock(&inode->i_lock);
>  		WARN_ON(inode->i_state & I_LRU_ISOLATING);
>  	}
> -	spin_unlock(&inode->i_lock);
>  }
>  
>  /**
> @@ -765,6 +764,7 @@ static void evict(struct inode *inode)
>  
>  	inode_sb_list_del(inode);
>  
> +	spin_lock(&inode->i_lock);
>  	inode_wait_for_lru_isolating(inode);
>  
>  	/*
> @@ -774,6 +774,7 @@ static void evict(struct inode *inode)
>  	 * the inode.  We just have to wait for running writeback to finish.
>  	 */
>  	inode_wait_for_writeback(inode);
> +	spin_unlock(&inode->i_lock);
>  
>  	if (op->evict_inode) {
>  		op->evict_inode(inode);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

