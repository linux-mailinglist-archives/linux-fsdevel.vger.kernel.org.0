Return-Path: <linux-fsdevel+bounces-46547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF09A8B56D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A407A8196
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9323644D;
	Wed, 16 Apr 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUXWjlXL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNe31UL4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUXWjlXL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNe31UL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91648230BED
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795942; cv=none; b=Hotw2b71GzKoaieqrI5v9GFF/UhBP+r3c6uS6EMJhVl6BDOUCS0//zWGRbiE9cNuXZHtUVaX6EU6RCNyf9m214n8JJh3nlh92VKHarGSODoRKF5Owltlm2IKl8N4vd5US1socXKsrhYLJ1ZUo6zJI3caz1HBD2iiiywfV+u7C+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795942; c=relaxed/simple;
	bh=yETNqmKjFzMxJvuRY2XI0jslaKz61bEi5fH8E+GuiUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBk7XFYPVCY8Ivd1WASJJop54V5HNNjggiwiYK1wpdkaKdj9/iTiGj3bBrCHPGcXPD5p2gf4yPKYp/v7Yh1voow2xPH0UmI5v8FaLLRqGvpaW+yP0XCBemZm8Rsfe+IRxae72aq0X+sEiV9CTFPNioujcaq1YUCOdhv1qVw5qlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUXWjlXL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNe31UL4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUXWjlXL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNe31UL4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93CD81F445;
	Wed, 16 Apr 2025 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744795938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvkHSS10XyBBZCdUukT1q/ieEy5kYIGILjTVfduyCTk=;
	b=oUXWjlXLYVGZSFMsqHZ9wlMH4Kn9ydpyqcPpriJ38vdHjmOVeNQgLovGs6RG74pRz/H+4L
	zO7JDhEASgkJGsJJatflFU2T/W9D3QJRAPQyiapwXefBIasOR184jwbhBqT2D0Vf9wXzmi
	U8kTT0AuN8XZFLJrzmO695/ziqEz1ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744795938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvkHSS10XyBBZCdUukT1q/ieEy5kYIGILjTVfduyCTk=;
	b=jNe31UL45R4T7Jgejf3AIQXlqtTHrnU9FhpJdRhsNcAySb9v+mK6Wgcrlezs5ttZJnUGjP
	DUfOwWa8DqmCnFDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oUXWjlXL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jNe31UL4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744795938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvkHSS10XyBBZCdUukT1q/ieEy5kYIGILjTVfduyCTk=;
	b=oUXWjlXLYVGZSFMsqHZ9wlMH4Kn9ydpyqcPpriJ38vdHjmOVeNQgLovGs6RG74pRz/H+4L
	zO7JDhEASgkJGsJJatflFU2T/W9D3QJRAPQyiapwXefBIasOR184jwbhBqT2D0Vf9wXzmi
	U8kTT0AuN8XZFLJrzmO695/ziqEz1ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744795938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JvkHSS10XyBBZCdUukT1q/ieEy5kYIGILjTVfduyCTk=;
	b=jNe31UL45R4T7Jgejf3AIQXlqtTHrnU9FhpJdRhsNcAySb9v+mK6Wgcrlezs5ttZJnUGjP
	DUfOwWa8DqmCnFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 885EA13976;
	Wed, 16 Apr 2025 09:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H9hGISJ5/2djcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:32:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B87EA0947; Wed, 16 Apr 2025 11:32:18 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:32:18 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, mcgrof@kernel.org, willy@infradead.org, hare@suse.de, 
	djwong@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 1/7] fs/buffer: split locking for pagecache lookups
Message-ID: <bu3ppl5dpe4kf5ykx4mkkg3vccsqkie335oa7wywv6eyvbp2fk@f4yyphvoczty>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <20250415231635.83960-2-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-2-dave@stgolabs.net>
X-Rspamd-Queue-Id: 93CD81F445
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 15-04-25 16:16:29, Davidlohr Bueso wrote:
> Callers of __find_get_block() may or may not allow for blocking
> semantics, and is currently assumed that it will not. Layout
> two paths based on this. The the private_lock scheme will
> continued to be used for atomic contexts. Otherwise take the
> folio lock instead, which protects the buffers, such as
> vs migration and try_to_free_buffers().
> 
> Per the "hack idea", the latter can alleviate contention on
> the private_lock for bdev mappings. For reasons of determinism
> and avoid making bugs hard to reproduce, the trylocking is not
> attempted.
> 
> No change in semantics. All lookup users still take the spinlock.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b99dc69dba37..c72ebff1b3f0 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -176,18 +176,8 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  }
>  EXPORT_SYMBOL(end_buffer_write_sync);
>  
> -/*
> - * Various filesystems appear to want __find_get_block to be non-blocking.
> - * But it's the page lock which protects the buffers.  To get around this,
> - * we get exclusion from try_to_free_buffers with the blockdev mapping's
> - * i_private_lock.
> - *
> - * Hack idea: for the blockdev mapping, i_private_lock contention
> - * may be quite high.  This code could TryLock the page, and if that
> - * succeeds, there is no need to take i_private_lock.
> - */
>  static struct buffer_head *
> -__find_get_block_slow(struct block_device *bdev, sector_t block)
> +__find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
>  {
>  	struct address_space *bd_mapping = bdev->bd_mapping;
>  	const int blkbits = bd_mapping->host->i_blkbits;
> @@ -204,7 +194,16 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  	if (IS_ERR(folio))
>  		goto out;
>  
> -	spin_lock(&bd_mapping->i_private_lock);
> +	/*
> +	 * Folio lock protects the buffers. Callers that cannot block
> +	 * will fallback to serializing vs try_to_free_buffers() via
> +	 * the i_private_lock.
> +	 */
> +	if (atomic)
> +		spin_lock(&bd_mapping->i_private_lock);
> +	else
> +		folio_lock(folio);
> +
>  	head = folio_buffers(folio);
>  	if (!head)
>  		goto out_unlock;
> @@ -236,7 +235,10 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
>  		       1 << blkbits);
>  	}
>  out_unlock:
> -	spin_unlock(&bd_mapping->i_private_lock);
> +	if (atomic)
> +		spin_unlock(&bd_mapping->i_private_lock);
> +	else
> +		folio_unlock(folio);
>  	folio_put(folio);
>  out:
>  	return ret;
> @@ -1388,14 +1390,15 @@ lookup_bh_lru(struct block_device *bdev, sector_t block, unsigned size)
>   * it in the LRU and mark it as accessed.  If it is not present then return
>   * NULL
>   */
> -struct buffer_head *
> -__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
> +static struct buffer_head *
> +find_get_block_common(struct block_device *bdev, sector_t block,
> +			unsigned size, bool atomic)
>  {
>  	struct buffer_head *bh = lookup_bh_lru(bdev, block, size);
>  
>  	if (bh == NULL) {
>  		/* __find_get_block_slow will mark the page accessed */
> -		bh = __find_get_block_slow(bdev, block);
> +		bh = __find_get_block_slow(bdev, block, atomic);
>  		if (bh)
>  			bh_lru_install(bh);
>  	} else
> @@ -1403,6 +1406,12 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
>  
>  	return bh;
>  }
> +
> +struct buffer_head *
> +__find_get_block(struct block_device *bdev, sector_t block, unsigned size)
> +{
> +	return find_get_block_common(bdev, block, size, true);
> +}
>  EXPORT_SYMBOL(__find_get_block);
>  
>  /**
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

