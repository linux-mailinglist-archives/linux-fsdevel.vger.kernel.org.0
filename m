Return-Path: <linux-fsdevel+bounces-17670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5B8B1416
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 22:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC63EB290C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A3143C60;
	Wed, 24 Apr 2024 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CPEOH5RD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3899cT1M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CPEOH5RD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3899cT1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D11BF37;
	Wed, 24 Apr 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989155; cv=none; b=KgEYtTO9l2hmDtdi1sgHvAGn6eZ8NFTcIJFHsgTWhUMsIqnlY5bg3IojXwXvOzK7i1CcjTN2AVfYsrpVPECZ+88wzzvki2HNPxpCVgiQjLc2AAg0F4NW5oNQ3ZwEpjF4a6t0Cy4IAY7B4ZOUjvAIuBFuLd34AhqUP43kvcvnKK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989155; c=relaxed/simple;
	bh=5rF9RlXB7+KkpqpKW4JSymiF96fM7MCeEwU+aTpnkNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kddo7vIDSRk/5yG00g+5aA0OQ/7hCDXEPYBTlH2DnaO9r2fpspeNqJ1YaQ6/BafWNGh6aoKbfAAprHtI0vT+LF9taygfj5qQiMEyyfNU7xWRUtM+82IVL9Us54/OORTpBK5vOqXMfapq7OuOVPSurwoqfUfnwhbkmi0hMnSLgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CPEOH5RD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3899cT1M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CPEOH5RD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3899cT1M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9030B1FCDB;
	Wed, 24 Apr 2024 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713989148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzGehy/paReXul/fV4mWdadBQEyh7gAyY0i3Qs9cVtQ=;
	b=CPEOH5RDLOyneutqTlOFznCr6gRhJPOOldBLbmW5L1w0J/iN6fNkVOK3iucm23jPEpQGyh
	aS8HyNnEeQhuYXfJ/Q9YIlQL6ZgFBLmAJ9xrqwOx4pCapIv8GINu5ysv3Yo5JLrNhcro5f
	V3vIu5zhxe740aIWHIE1P1HTNMlwQJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713989148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzGehy/paReXul/fV4mWdadBQEyh7gAyY0i3Qs9cVtQ=;
	b=3899cT1MarzNZIHdI4DZ0d49TF7brOC4kFH5aT3nU0t3otEmMdvAeAPnaNKvn5rrmjeTOq
	BFKF4v6FfJOYLUCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713989148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzGehy/paReXul/fV4mWdadBQEyh7gAyY0i3Qs9cVtQ=;
	b=CPEOH5RDLOyneutqTlOFznCr6gRhJPOOldBLbmW5L1w0J/iN6fNkVOK3iucm23jPEpQGyh
	aS8HyNnEeQhuYXfJ/Q9YIlQL6ZgFBLmAJ9xrqwOx4pCapIv8GINu5ysv3Yo5JLrNhcro5f
	V3vIu5zhxe740aIWHIE1P1HTNMlwQJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713989148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzGehy/paReXul/fV4mWdadBQEyh7gAyY0i3Qs9cVtQ=;
	b=3899cT1MarzNZIHdI4DZ0d49TF7brOC4kFH5aT3nU0t3otEmMdvAeAPnaNKvn5rrmjeTOq
	BFKF4v6FfJOYLUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8708C13690;
	Wed, 24 Apr 2024 20:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oqn0IBxmKWakcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Apr 2024 20:05:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55055A0861; Wed, 24 Apr 2024 22:05:44 +0200 (CEST)
Date: Wed, 24 Apr 2024 22:05:44 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/9] ext4: factor out a common helper to query extent
 map
Message-ID: <20240424200544.gegdyfidy4xvjlsz@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-2-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 10-04-24 11:41:55, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Factor out a new common helper ext4_map_query_blocks() from the
> ext4_da_map_blocks(), it query and return the extent map status on the
> inode's extent path, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 57 +++++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 537803250ca9..6a41172c06e1 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -453,6 +453,35 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
>  }
>  #endif /* ES_AGGRESSIVE_TEST */
>  
> +static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> +				 struct ext4_map_blocks *map)
> +{
> +	unsigned int status;
> +	int retval;
> +
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		retval = ext4_ext_map_blocks(handle, inode, map, 0);
> +	else
> +		retval = ext4_ind_map_blocks(handle, inode, map, 0);
> +
> +	if (retval <= 0)
> +		return retval;
> +
> +	if (unlikely(retval != map->m_len)) {
> +		ext4_warning(inode->i_sb,
> +			     "ES len assertion failed for inode "
> +			     "%lu: retval %d != map->m_len %d",
> +			     inode->i_ino, retval, map->m_len);
> +		WARN_ON(1);
> +	}
> +
> +	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> +			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> +	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +			      map->m_pblk, status);
> +	return retval;
> +}
> +
>  /*
>   * The ext4_map_blocks() function tries to look up the requested blocks,
>   * and returns if the blocks are already mapped.
> @@ -1744,33 +1773,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  	down_read(&EXT4_I(inode)->i_data_sem);
>  	if (ext4_has_inline_data(inode))
>  		retval = 0;
> -	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
>  	else
> -		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
> -	if (retval < 0) {
> -		up_read(&EXT4_I(inode)->i_data_sem);
> -		return retval;
> -	}
> -	if (retval > 0) {
> -		unsigned int status;
> -
> -		if (unlikely(retval != map->m_len)) {
> -			ext4_warning(inode->i_sb,
> -				     "ES len assertion failed for inode "
> -				     "%lu: retval %d != map->m_len %d",
> -				     inode->i_ino, retval, map->m_len);
> -			WARN_ON(1);
> -		}
> -
> -		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> -				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -				      map->m_pblk, status);
> -		up_read(&EXT4_I(inode)->i_data_sem);
> -		return retval;
> -	}
> +		retval = ext4_map_query_blocks(NULL, inode, map);
>  	up_read(&EXT4_I(inode)->i_data_sem);
> +	if (retval)
> +		return retval;
>  
>  add_delayed:
>  	down_write(&EXT4_I(inode)->i_data_sem);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

