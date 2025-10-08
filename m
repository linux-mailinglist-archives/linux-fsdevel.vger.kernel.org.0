Return-Path: <linux-fsdevel+bounces-63584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35FBBC495C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5491890EC1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670502F746D;
	Wed,  8 Oct 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cDXyF6qV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LZfNIq6h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r0emNODP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FyBBMf7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A925C6F1
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923411; cv=none; b=NF5HNfB0FBlRQfhn7pTrxEIxsoj18UAB2ullO0kFdPIpQwbKzLibLEtDzASFf3RGYc3Sg473GXK9U9c+EevL/XHo3HXvVzNUfogXwmPGo4ZGL5dCjJ44cJHh1f8/YwsGd4yaqqGBg0T+9JHQKojuuBTEobT2uiFt3YsanH033UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923411; c=relaxed/simple;
	bh=dUA0kycUjCNgoLmLvWW5zC2MSB7Y6zh05/n1UZBgrPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6yzDYVkSiU3iSL9Xb7AoPqkko27bN+YLNWRyruAyflYSDV0RS03U/5jRyv2PV50MOEkCYZCzR+5VRHCtjRTHWt5KYFp0dLz62QH3IdIGKstFweW2p6YKaq7PYuohtVK4Okte2gicI8D+ReNK/6mcL0chfp52GctMq69UGenq10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cDXyF6qV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LZfNIq6h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r0emNODP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FyBBMf7g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAC7C33682;
	Wed,  8 Oct 2025 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759923408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QskK6sQlHONQvEW5OGacm6exgi6VLgrwHUdy41lqvi4=;
	b=cDXyF6qV01eynbfN74hM9iVNFNSyB1IEb4SkSPMJBhqck4AfX87luVoaJziQg7Esf2jDtJ
	Ple3AcxnxHEuaLNZLlPIbyIoQQ1HpEwJlJT8ILwYISccAvaDI9f697/Y+m/vJhRtnVQU45
	HiHfkDWHCgt1RAFT0j6v6QJxlbIAVMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759923408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QskK6sQlHONQvEW5OGacm6exgi6VLgrwHUdy41lqvi4=;
	b=LZfNIq6ht+Bxfh0B52NclgW6PVTxVHYv3y1dWaXX2brlPitEpU2R0kTd21Mtm5BDQ95kz3
	f8DsLR26tCvjAEAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r0emNODP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FyBBMf7g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759923407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QskK6sQlHONQvEW5OGacm6exgi6VLgrwHUdy41lqvi4=;
	b=r0emNODP1UBpzvDJay464gnGYQZrUqPOIVgzeLkc/SnfiDyc5dyxJGTI9atNamtzWlyj9O
	g2Rvkj4M14396sX5gaRaLd4C9Y2QnbnEttNlNa+Ieb7d5YrrXeYboShzaEd8s/K79Q1/o7
	vqp2xRMNDTbwqXJAoaQEC2O0pU3oOZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759923407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QskK6sQlHONQvEW5OGacm6exgi6VLgrwHUdy41lqvi4=;
	b=FyBBMf7gUwBwOapylXwqKBxhYJrG+jZU5Nd61iR33Th2NskRKjiG0zuFhYrKxsGYpwDc8O
	wn5sKxGAiLX7nQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDE7E13A3D;
	Wed,  8 Oct 2025 11:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R1tWLs9M5mhbKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:36:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 580EBA0ACD; Wed,  8 Oct 2025 13:36:43 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:36:43 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 05/13] ext4: pass out extent seq counter when mapping
 blocks
Message-ID: <uugyelukqaxxipbrdrldvr37eoqn5uqc4x7jhvex6vbdaswgnl@wcwjbfcglxna>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-6-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CAC7C33682
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Thu 25-09-25 17:26:01, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When creating or querying mapping blocks using the ext4_map_blocks() and
> ext4_map_{query|create}_blocks() helpers, also pass out the extent
> sequence number of the block mapping info through the ext4_map_blocks
> structure. This sequence number can later serve as a valid cookie within
> iomap infrastructure and the move extents procedure.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/inode.c | 24 ++++++++++++++++--------
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 7b37a661dd37..7f452895ec09 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -260,6 +260,7 @@ struct ext4_map_blocks {
>  	ext4_lblk_t m_lblk;
>  	unsigned int m_len;
>  	unsigned int m_flags;
> +	u64 m_seq;
>  };
>  
>  /*
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c7fac4b89c88..d005a4f3f4b3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -550,10 +550,13 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  		retval = ext4_ext_map_blocks(handle, inode, map, flags);
>  	else
>  		retval = ext4_ind_map_blocks(handle, inode, map, flags);
> -
> -	if (retval <= 0)
> +	if (retval < 0)
>  		return retval;
>  
> +	/* A hole? */
> +	if (retval == 0)
> +		goto out;
> +
>  	if (unlikely(retval != map->m_len)) {
>  		ext4_warning(inode->i_sb,
>  			     "ES len assertion failed for inode "
> @@ -573,11 +576,13 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>  				      map->m_pblk, status, false);
> -		return retval;
> +	} else {
> +		retval = ext4_map_query_blocks_next_in_leaf(handle, inode, map,
> +							    orig_mlen);
>  	}
> -
> -	return ext4_map_query_blocks_next_in_leaf(handle, inode, map,
> -						  orig_mlen);
> +out:
> +	map->m_seq = READ_ONCE(EXT4_I(inode)->i_es_seq);
> +	return retval;
>  }
>  
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> @@ -649,7 +654,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  	 * extent status tree.
>  	 */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
> +	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
>  		if (ext4_es_is_written(&es))
>  			return retval;
>  	}
> @@ -658,6 +663,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
>  			      status, flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE);
> +	map->m_seq = READ_ONCE(EXT4_I(inode)->i_es_seq);
>  
>  	return retval;
>  }
> @@ -723,7 +729,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		ext4_check_map_extents_env(inode);
>  
>  	/* Lookup extent status tree firstly */
> -	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, &map->m_seq)) {
>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>  			map->m_pblk = ext4_es_pblock(&es) +
>  					map->m_lblk - es.es_lblk;
> @@ -1979,6 +1985,8 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>  
>  	map->m_flags |= EXT4_MAP_DELAYED;
>  	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
> +	if (!retval)
> +		map->m_seq = READ_ONCE(EXT4_I(inode)->i_es_seq);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  
>  	return retval;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

