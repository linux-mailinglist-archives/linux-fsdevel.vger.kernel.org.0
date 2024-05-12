Return-Path: <linux-fsdevel+bounces-19379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF948C424E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026B81F21B5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237715533D;
	Mon, 13 May 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aI0vR582";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cTov7oaU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aI0vR582";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cTov7oaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C65153BE8;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607701; cv=none; b=Sy/g6Sn0bVUG4IoxGaYLtyYW+1uHvzzqGv4o8SxAtdYjcRl1BUCLEdBgmH2I3CavVYeM8uBNpbVCCcrobmGLI+vPNLyol/2lbc7HgFt1HlIU4FQjyMshqhV8fzLFGUAahZo2em8A+NQZAThF9b5zVwBr+GgEwtVNBtlV9Q8jy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607701; c=relaxed/simple;
	bh=KR/9uJU9rmLDbLzKcSjLEZv5MtnjWTM5oESX4OTBg+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2+2c9fkqaSMVSWvlB90WouqXSEvGN78ilDvGArlQkhXHP0IBmo4MPbc21enKQpsRDKFcUs30U/wkquay1gQGugoineQvqQuZEG0SN5sWvTkcO+sCrDsRJ3KvGYF79sUR/6dBCUVW4M9Co8ZOucpDxHX+dHMRejS0GnpvW1fuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aI0vR582; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cTov7oaU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aI0vR582; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cTov7oaU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 406735C0D8;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjOuq6k+UpFL6BOoWHjHlN/QO0POrewyeMCKLvGq9mY=;
	b=aI0vR582CIcPsYV0tQz0aC//8YSPwCdK+8u8okJHJigk6LGlm0pAueX2lWe1I/dUsGqx5N
	SyFUmB2QUn4WlBMk7SFterGI2qnnaYKOsqBtu70DNMjtKuPcvmnTlnlvmev0H7wyehVY+0
	HM8py9i91J4LWGOHwzan1AIYZw/Jopg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjOuq6k+UpFL6BOoWHjHlN/QO0POrewyeMCKLvGq9mY=;
	b=cTov7oaU2nUcYWqILxvh0NkD0Nr3KxScREMNY/2vXP3q0P7Uw28JcDFpj7CGnyee3uvffG
	5SD4s27K7Hi39QCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aI0vR582;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cTov7oaU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjOuq6k+UpFL6BOoWHjHlN/QO0POrewyeMCKLvGq9mY=;
	b=aI0vR582CIcPsYV0tQz0aC//8YSPwCdK+8u8okJHJigk6LGlm0pAueX2lWe1I/dUsGqx5N
	SyFUmB2QUn4WlBMk7SFterGI2qnnaYKOsqBtu70DNMjtKuPcvmnTlnlvmev0H7wyehVY+0
	HM8py9i91J4LWGOHwzan1AIYZw/Jopg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjOuq6k+UpFL6BOoWHjHlN/QO0POrewyeMCKLvGq9mY=;
	b=cTov7oaU2nUcYWqILxvh0NkD0Nr3KxScREMNY/2vXP3q0P7Uw28JcDFpj7CGnyee3uvffG
	5SD4s27K7Hi39QCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0735513A61;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ee5AZEYQmaTDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 604EDA091B; Sun, 12 May 2024 23:51:47 +0200 (CEST)
Date: Sun, 12 May 2024 23:51:47 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 10/10] ext4: make ext4_da_map_blocks() buffer_head
 unaware
Message-ID: <20240512215147.zfrp6x75xqdinjvj@quack3>
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
 <20240508061220.967970-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508061220.967970-11-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLswiucb9kpekg6cnj18gdugi4)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 406735C0D8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Wed 08-05-24 14:12:20, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After calling the ext4_da_map_blocks(), a delalloc extent state could
> be identified through the EXT4_MAP_DELAYED flag in map. So factor out
> buffer_head related handles in ext4_da_map_blocks(), make this function
> buffer_head unaware and becomes a common helper, and also update the
> stale function commtents, preparing for the iomap da write path in the
> future.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 63 ++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c56386d1b10d..1dba5337382a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1745,36 +1745,32 @@ static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
>  }
>  
>  /*
> - * This function is grabs code from the very beginning of
> - * ext4_map_blocks, but assumes that the caller is from delayed write
> - * time. This function looks up the requested blocks and sets the
> - * buffer delay bit under the protection of i_data_sem.
> + * Looks up the requested blocks and sets the delalloc extent map.
> + * First try to look up for the extent entry that contains the requested
> + * blocks in the extent status tree without i_data_sem, then try to look
> + * up for the ondisk extent mapping with i_data_sem in read mode,
> + * finally hold i_data_sem in write mode, looks up again and add a
> + * delalloc extent entry if it still couldn't find any extent. Pass out
> + * the mapped extent through @map and return 0 on success.
>   */
> -static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
> -			      struct buffer_head *bh)
> +static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>  {
>  	struct extent_status es;
>  	int retval;
> -	sector_t invalid_block = ~((sector_t) 0xffff);
>  #ifdef ES_AGGRESSIVE_TEST
>  	struct ext4_map_blocks orig_map;
>  
>  	memcpy(&orig_map, map, sizeof(*map));
>  #endif
>  
> -	if (invalid_block < ext4_blocks_count(EXT4_SB(inode->i_sb)->s_es))
> -		invalid_block = ~0;
> -
>  	map->m_flags = 0;
>  	ext_debug(inode, "max_blocks %u, logical block %lu\n", map->m_len,
>  		  (unsigned long) map->m_lblk);
>  
>  	/* Lookup extent status tree firstly */
>  	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> -		retval = es.es_len - (map->m_lblk - es.es_lblk);
> -		if (retval > map->m_len)
> -			retval = map->m_len;
> -		map->m_len = retval;
> +		map->m_len = min_t(unsigned int, map->m_len,
> +				   es.es_len - (map->m_lblk - es.es_lblk));
>  
>  		if (ext4_es_is_hole(&es))
>  			goto add_delayed;
> @@ -1784,10 +1780,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  		 * Delayed extent could be allocated by fallocate.
>  		 * So we need to check it.
>  		 */
> -		if (ext4_es_is_delayed(&es) && !ext4_es_is_unwritten(&es)) {
> -			map_bh(bh, inode->i_sb, invalid_block);
> -			set_buffer_new(bh);
> -			set_buffer_delay(bh);
> +		if (ext4_es_is_delonly(&es)) {
> +			map->m_flags |= EXT4_MAP_DELAYED;
>  			return 0;
>  		}
>  
> @@ -1802,7 +1796,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  #ifdef ES_AGGRESSIVE_TEST
>  		ext4_map_blocks_es_recheck(NULL, inode, map, &orig_map, 0);
>  #endif
> -		return retval;
> +		return 0;
>  	}
>  
>  	/*
> @@ -1816,7 +1810,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  		retval = ext4_map_query_blocks(NULL, inode, map);
>  	up_read(&EXT4_I(inode)->i_data_sem);
>  	if (retval)
> -		return retval;
> +		return retval < 0 ? retval : 0;
>  
>  add_delayed:
>  	down_write(&EXT4_I(inode)->i_data_sem);
> @@ -1828,10 +1822,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  	 * the extent status tree.
>  	 */
>  	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> -		retval = es.es_len - (map->m_lblk - es.es_lblk);
> -		if (retval > map->m_len)
> -			retval = map->m_len;
> -		map->m_len = retval;
> +		map->m_len = min_t(unsigned int, map->m_len,
> +				   es.es_len - (map->m_lblk - es.es_lblk));
>  
>  		if (!ext4_es_is_hole(&es)) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
> @@ -1841,18 +1833,14 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  		retval = ext4_map_query_blocks(NULL, inode, map);
>  		if (retval) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
> -			return retval;
> +			return retval < 0 ? retval : 0;
>  		}
>  	}
>  
> +	map->m_flags |= EXT4_MAP_DELAYED;
>  	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
>  	up_write(&EXT4_I(inode)->i_data_sem);
> -	if (retval)
> -		return retval;
>  
> -	map_bh(bh, inode->i_sb, invalid_block);
> -	set_buffer_new(bh);
> -	set_buffer_delay(bh);
>  	return retval;
>  }
>  
> @@ -1872,11 +1860,15 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
>  			   struct buffer_head *bh, int create)
>  {
>  	struct ext4_map_blocks map;
> +	sector_t invalid_block = ~((sector_t) 0xffff);
>  	int ret = 0;
>  
>  	BUG_ON(create == 0);
>  	BUG_ON(bh->b_size != inode->i_sb->s_blocksize);
>  
> +	if (invalid_block < ext4_blocks_count(EXT4_SB(inode->i_sb)->s_es))
> +		invalid_block = ~0;
> +
>  	map.m_lblk = iblock;
>  	map.m_len = 1;
>  
> @@ -1885,10 +1877,17 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
>  	 * preallocated blocks are unmapped but should treated
>  	 * the same as allocated blocks.
>  	 */
> -	ret = ext4_da_map_blocks(inode, &map, bh);
> -	if (ret <= 0)
> +	ret = ext4_da_map_blocks(inode, &map);
> +	if (ret < 0)
>  		return ret;
>  
> +	if (map.m_flags & EXT4_MAP_DELAYED) {
> +		map_bh(bh, inode->i_sb, invalid_block);
> +		set_buffer_new(bh);
> +		set_buffer_delay(bh);
> +		return 0;
> +	}
> +
>  	map_bh(bh, inode->i_sb, map.m_pblk);
>  	ext4_update_bh_state(bh, map.m_flags);
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

