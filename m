Return-Path: <linux-fsdevel+bounces-18090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4C18B554F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2EF7B22BAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F5B39AD5;
	Mon, 29 Apr 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="meSHWerC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U2a9KrXT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="meSHWerC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U2a9KrXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2836B00;
	Mon, 29 Apr 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386461; cv=none; b=D6YQcdUQSy/HFHHEUMZGsh3UoEM0CpejjJlG1JtC10WqvgPQJxPecPUf936rdF8kEK7Iuxb76Bc/hpREY4rY4tCOc6khAfD8uFIzf9aRbOp8nWIcl0ZOoBwwNrDFY/gI3MORdL1C2RpSKGn1S2vzo4Tiw4R9CNUXAWz1LqxPB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386461; c=relaxed/simple;
	bh=VJXaTzjFACw3j9cOg7tUTjeMUSzEWUwSixIosG3lcJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyKmZNe8lUwYE0YzhE5rPvdDe43RtSybcbsUdD5ykas5W8YGkG0UR7BB148hXk2jHWTuwEBDTRRDKPBH7Wn7iu0gM8fG4MVG1yBuobSU7ybVDG6VVYg5x1f+elqA9R7Kcuq8mwNgBnPhOMb0+3D4UJc2pVo2De/i42im+9YTMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=meSHWerC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U2a9KrXT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=meSHWerC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U2a9KrXT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E3FF204B9;
	Mon, 29 Apr 2024 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714386458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SogyoD/olrEqthtSZ+O5YCmNYQn4ztMxTIILx5zWVDY=;
	b=meSHWerC6tZftGGYtWC06ZlsQkTytMe8SV728bxSHhX0+/d/+lRk8b7/PbfZ7+zUNq+oDi
	TUDOIu8wLAue80ZciBz4SiCMAfMTeWPri92Rf0bw7k/FkaQCQKRFTKFpZgwLl7RQkEFNs9
	af+5B2awsysnHmJBYMSfnb9ooXufm1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714386458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SogyoD/olrEqthtSZ+O5YCmNYQn4ztMxTIILx5zWVDY=;
	b=U2a9KrXTKVPXkI13Hh42+hnAyLFGkAjpVlAJoRNmhdr6ti4Cq/JAP8ZqhVCMPaw7L61wWp
	lq9bp88wlCqcjsCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=meSHWerC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U2a9KrXT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714386458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SogyoD/olrEqthtSZ+O5YCmNYQn4ztMxTIILx5zWVDY=;
	b=meSHWerC6tZftGGYtWC06ZlsQkTytMe8SV728bxSHhX0+/d/+lRk8b7/PbfZ7+zUNq+oDi
	TUDOIu8wLAue80ZciBz4SiCMAfMTeWPri92Rf0bw7k/FkaQCQKRFTKFpZgwLl7RQkEFNs9
	af+5B2awsysnHmJBYMSfnb9ooXufm1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714386458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SogyoD/olrEqthtSZ+O5YCmNYQn4ztMxTIILx5zWVDY=;
	b=U2a9KrXTKVPXkI13Hh42+hnAyLFGkAjpVlAJoRNmhdr6ti4Cq/JAP8ZqhVCMPaw7L61wWp
	lq9bp88wlCqcjsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 325D5139DE;
	Mon, 29 Apr 2024 10:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h9dHDBp2L2ZvMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 10:27:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ECE51A082F; Mon, 29 Apr 2024 12:27:29 +0200 (CEST)
Date: Mon, 29 Apr 2024 12:27:29 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 9/9] ext4: make ext4_da_map_blocks() buffer_head
 unaware
Message-ID: <20240429102729.vnk4yfifuwfopwep@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-10-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3E3FF204B9
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed 10-04-24 11:42:03, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After calling ext4_da_map_blocks(), a delalloc extent state could be
> distinguished through EXT4_MAP_DELAYED flag in map. So factor out
> buffer_head related handles in ext4_da_map_blocks(), make it
> buffer_head unaware, make it become a common helper, it could be used
> for iomap in the future.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> -		retval = es.es_len - (map->m_lblk - es.es_lblk);
> -		if (retval > map->m_len)
> -			retval = map->m_len;
> -		map->m_len = retval;
> +		map->m_len = min_t(unsigned int, map->m_len,
> +				   es.es_len - (map->m_lblk - es.es_lblk));
>  
>  		if (ext4_es_is_hole(&es))
>  			goto add_delayed;
> @@ -1785,10 +1778,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
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
> @@ -1803,7 +1794,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  #ifdef ES_AGGRESSIVE_TEST
>  		ext4_map_blocks_es_recheck(NULL, inode, map, &orig_map, 0);
>  #endif
> -		return retval;
> +		return 0;
>  	}
>  
>  	/*
> @@ -1817,7 +1808,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  		retval = ext4_map_query_blocks(NULL, inode, map);
>  	up_read(&EXT4_I(inode)->i_data_sem);
>  	if (retval)
> -		return retval;
> +		return retval < 0 ? retval : 0;
>  
>  add_delayed:
>  	down_write(&EXT4_I(inode)->i_data_sem);
> @@ -1827,10 +1818,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  	 * whitout holding i_rwsem and folio lock.
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
> @@ -1840,18 +1829,14 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
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
> @@ -1871,11 +1856,15 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
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
> @@ -1884,10 +1873,17 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
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

