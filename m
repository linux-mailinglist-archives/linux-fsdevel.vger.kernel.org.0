Return-Path: <linux-fsdevel+bounces-46548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8765A8B573
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 11:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EB94412DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D523536B;
	Wed, 16 Apr 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rB5pm/DY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EG+WKcD7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rB5pm/DY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EG+WKcD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0B140E5F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795999; cv=none; b=qJwJPMUXypm6zuNrsVLvG1QVq7Z98OvpdDvWONnVWKx0fUUJqJKc0kxBs/24zHke4P60IpWFkSrarrWZE1YnkDkYMtCPp6kmnvY9/tp880kpe+KmcLxavQQe6NBaNFQCTPDm4RAMnwUbMpe0Ff06P6tM4RZVGj18cG1DhqQiYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795999; c=relaxed/simple;
	bh=cDJjAQATk93szn78j9ta8BEBxPGCeReb1VK6nZ3ZA+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaDH3GKu/6AOefqHcg9Z8kyAb42xLWR+jKTuMkPD6Adi6Zbz5us3D/05bh/0+V8rvxKnESLSNxggK+mRLRiMiFVcqeu+Fl7v6e2pWSfLlIOPz6Kw0+SABVkV1e5E90uc9G7JMjB1ozEJ8YqXeidoC+oJibJZTcAl/AWVDO8Q/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rB5pm/DY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EG+WKcD7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rB5pm/DY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EG+WKcD7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CB491F445;
	Wed, 16 Apr 2025 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744795996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjVmMLTjRVd3l7vFMOIetPD6FjLCrRAfbfGXOkQHEC0=;
	b=rB5pm/DYSVkr4Vt/nI/piRfriGwhJeRVlHYev3x12C/geZetmLCY8XjH9GwhXjB2ma0wmh
	eOjBKP18bZhQl6WEOQhLwPYR3zMERwNV2SoHmkE7yn9QAlm0cGnyRg8qtbFOwFgn1JNKcG
	r3c4KBl8JzTWBF7LCU3YApZusu1TDZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744795996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjVmMLTjRVd3l7vFMOIetPD6FjLCrRAfbfGXOkQHEC0=;
	b=EG+WKcD7fI2kwvvCmMqLzYrM4JdFio9WzSrcwXOME+3lcZ/hb8wFYhjUtsEnpZkcTM6o6H
	n/sgYtwakF+7MUDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744795996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjVmMLTjRVd3l7vFMOIetPD6FjLCrRAfbfGXOkQHEC0=;
	b=rB5pm/DYSVkr4Vt/nI/piRfriGwhJeRVlHYev3x12C/geZetmLCY8XjH9GwhXjB2ma0wmh
	eOjBKP18bZhQl6WEOQhLwPYR3zMERwNV2SoHmkE7yn9QAlm0cGnyRg8qtbFOwFgn1JNKcG
	r3c4KBl8JzTWBF7LCU3YApZusu1TDZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744795996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjVmMLTjRVd3l7vFMOIetPD6FjLCrRAfbfGXOkQHEC0=;
	b=EG+WKcD7fI2kwvvCmMqLzYrM4JdFio9WzSrcwXOME+3lcZ/hb8wFYhjUtsEnpZkcTM6o6H
	n/sgYtwakF+7MUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1313D13976;
	Wed, 16 Apr 2025 09:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t3akBFx5/2ewcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Apr 2025 09:33:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D081EA0947; Wed, 16 Apr 2025 11:33:11 +0200 (CEST)
Date: Wed, 16 Apr 2025 11:33:11 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, mcgrof@kernel.org, willy@infradead.org, hare@suse.de, 
	djwong@kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 2/7] fs/buffer: introduce sleeping flavors for pagecache
 lookups
Message-ID: <ns6d42ddh5m3tl3sxessebn6fjpydif6kjnjte6yrmogeahzux@5ssovrkhpnrz>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <20250415231635.83960-3-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231635.83960-3-dave@stgolabs.net>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 15-04-25 16:16:30, Davidlohr Bueso wrote:
> Add __find_get_block_nonatomic() and sb_find_get_block_nonatomic()
> calls for which users will be converted where safe. These versions
> will take the folio lock instead of the mapping's private_lock.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 9 +++++++++
>  include/linux/buffer_head.h | 8 ++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index c72ebff1b3f0..64034638ee2c 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1414,6 +1414,15 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
>  }
>  EXPORT_SYMBOL(__find_get_block);
>  
> +/* same as __find_get_block() but allows sleeping contexts */
> +struct buffer_head *
> +__find_get_block_nonatomic(struct block_device *bdev, sector_t block,
> +			   unsigned size)
> +{
> +	return find_get_block_common(bdev, block, size, false);
> +}
> +EXPORT_SYMBOL(__find_get_block_nonatomic);
> +
>  /**
>   * bdev_getblk - Get a buffer_head in a block device's buffer cache.
>   * @bdev: The block device.
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index f0a4ad7839b6..c791aa9a08da 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -222,6 +222,8 @@ void __wait_on_buffer(struct buffer_head *);
>  wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
>  struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
>  			unsigned size);
> +struct buffer_head *__find_get_block_nonatomic(struct block_device *bdev,
> +			sector_t block, unsigned size);
>  struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
>  		unsigned size, gfp_t gfp);
>  void __brelse(struct buffer_head *);
> @@ -397,6 +399,12 @@ sb_find_get_block(struct super_block *sb, sector_t block)
>  	return __find_get_block(sb->s_bdev, block, sb->s_blocksize);
>  }
>  
> +static inline struct buffer_head *
> +sb_find_get_block_nonatomic(struct super_block *sb, sector_t block)
> +{
> +	return __find_get_block_nonatomic(sb->s_bdev, block, sb->s_blocksize);
> +}
> +
>  static inline void
>  map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
>  {
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

