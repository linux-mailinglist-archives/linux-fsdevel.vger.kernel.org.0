Return-Path: <linux-fsdevel+bounces-25111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA54794934F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED771F24F44
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA91D6DA5;
	Tue,  6 Aug 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Erg3SWpL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R0V/0m6x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANKnNH50";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OxCcmFXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE3C1BE23E;
	Tue,  6 Aug 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955121; cv=none; b=AV0rpogY3tV8APRjdhIvKFUFp7J2DoFPhEnUYTZE40BzlfRw8nrnVYfNEqBoQWLaA5ytLSf9xFETFKdILgJwN7XHY9/WT0dW/egiEDXTzogAnEsT4omnIcyWzm1deOjQysR2E5LhyWS4Amu5NxR8yF8KeNKzqC5ZsKQ5Woi1DCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955121; c=relaxed/simple;
	bh=A5hqyvauKYqSLVUQLGDJ9VNR8PmLzUK5Rcbea4OqRu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/su7uJwjfYO26heCMks5mW/IjCUJ5ikvVyp7yuwVIJ9vszVSJVLJjwoF5qMv/wRHvY/SNWqE3/Wvh57wWYzkprSOpR2mS8hUJpqNicolL+YFlIPQN/3zk9JsyggpO6IWZDXvolsFCgxcEy5WFoLg3vtUc2WScJUWIphS02dBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Erg3SWpL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R0V/0m6x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANKnNH50; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OxCcmFXg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA87421C53;
	Tue,  6 Aug 2024 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722955117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEj4M1x9bajPijPc7k9tnKgE/KX2GZhaQtGgWFtrUkY=;
	b=Erg3SWpLApTCxl7/OWmCGWTXz+AdlAACkyXmgb7OCQrlZuA2gFjQKQHGTwcNsBt+p1OyUS
	i78wLko1QOeeIS2xkfXrdXZK5a3ppO07OIKzshafM0QSj1e7tQGz8w2ONScFhPMCn2JPkW
	CG4YKyfZTkGF64N3HBMmes7o+SDdA2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722955117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEj4M1x9bajPijPc7k9tnKgE/KX2GZhaQtGgWFtrUkY=;
	b=R0V/0m6xlqMmN7Dwkq+joc9piWzhrYjuu86+m428QxMQsM01TqSqW5+cgjJILZZC5S9CVs
	Pxb/N4vHeNEZLmAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ANKnNH50;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OxCcmFXg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722955116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEj4M1x9bajPijPc7k9tnKgE/KX2GZhaQtGgWFtrUkY=;
	b=ANKnNH50fpGCXgqrdZkfwU3/N4yTfcuyNkjNjYL6fW3fqn9Ngp4htprQS+cFRHlWpKG7kD
	7Ooq8JZbeq9ER8eXQPcuVd0tuuy+kpW/VR1Chzhu9QZlww6x5xF2y0UEWXAFX+IeYqKhpv
	ODbuzkEP0HH4Oo//b4UdXkjdzli89aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722955116;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xEj4M1x9bajPijPc7k9tnKgE/KX2GZhaQtGgWFtrUkY=;
	b=OxCcmFXgpHfgCe0PxNVro0DlzhS5Y88tWsIctvtlR5qLUmqwAttynscCPzNrotHQcrwrSc
	xyHox8OcWQDCMKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDBD113770;
	Tue,  6 Aug 2024 14:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xig2Mmw1smbYXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Aug 2024 14:38:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A6D1A0762; Tue,  6 Aug 2024 16:38:36 +0200 (CEST)
Date: Tue, 6 Aug 2024 16:38:36 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 01/10] ext4: factor out ext4_map_create_blocks() to
 allocate new blocks
Message-ID: <20240806143836.a5cwdbvyehsjqwp3@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802115120.362902-2-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,huawei.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: DA87421C53

On Fri 02-08-24 19:51:11, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Factor out a common helper ext4_map_create_blocks() from
> ext4_map_blocks() to do a real blocks allocation, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks OK. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 157 +++++++++++++++++++++++++-----------------------
>  1 file changed, 81 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..112aec171ee9 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -482,6 +482,86 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  	return retval;
>  }
>  
> +static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> +				  struct ext4_map_blocks *map, int flags)
> +{
> +	struct extent_status es;
> +	unsigned int status;
> +	int err, retval = 0;
> +
> +	/*
> +	 * Here we clear m_flags because after allocating an new extent,
> +	 * it will be set again.
> +	 */
> +	map->m_flags &= ~EXT4_MAP_FLAGS;
> +
> +	/*
> +	 * We need to check for EXT4 here because migrate could have
> +	 * changed the inode type in between.
> +	 */
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> +		retval = ext4_ext_map_blocks(handle, inode, map, flags);
> +	} else {
> +		retval = ext4_ind_map_blocks(handle, inode, map, flags);
> +
> +		/*
> +		 * We allocated new blocks which will result in i_data's
> +		 * format changing. Force the migrate to fail by clearing
> +		 * migrate flags.
> +		 */
> +		if (retval > 0 && map->m_flags & EXT4_MAP_NEW)
> +			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
> +	}
> +	if (retval <= 0)
> +		return retval;
> +
> +	if (unlikely(retval != map->m_len)) {
> +		ext4_warning(inode->i_sb,
> +			     "ES len assertion failed for inode %lu: "
> +			     "retval %d != map->m_len %d",
> +			     inode->i_ino, retval, map->m_len);
> +		WARN_ON(1);
> +	}
> +
> +	/*
> +	 * We have to zeroout blocks before inserting them into extent
> +	 * status tree. Otherwise someone could look them up there and
> +	 * use them before they are really zeroed. We also have to
> +	 * unmap metadata before zeroing as otherwise writeback can
> +	 * overwrite zeros with stale data from block device.
> +	 */
> +	if (flags & EXT4_GET_BLOCKS_ZERO &&
> +	    map->m_flags & EXT4_MAP_MAPPED && map->m_flags & EXT4_MAP_NEW) {
> +		err = ext4_issue_zeroout(inode, map->m_lblk, map->m_pblk,
> +					 map->m_len);
> +		if (err)
> +			return err;
> +	}
> +
> +	/*
> +	 * If the extent has been zeroed out, we don't need to update
> +	 * extent status tree.
> +	 */
> +	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
> +	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +		if (ext4_es_is_written(&es))
> +			return retval;
> +	}
> +
> +	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> +			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> +	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
> +	    !(status & EXTENT_STATUS_WRITTEN) &&
> +	    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
> +			       map->m_lblk + map->m_len - 1))
> +		status |= EXTENT_STATUS_DELAYED;
> +
> +	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +			      map->m_pblk, status);
> +
> +	return retval;
> +}
> +
>  /*
>   * The ext4_map_blocks() function tries to look up the requested blocks,
>   * and returns if the blocks are already mapped.
> @@ -630,12 +710,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
>  			return retval;
>  
> -	/*
> -	 * Here we clear m_flags because after allocating an new extent,
> -	 * it will be set again.
> -	 */
> -	map->m_flags &= ~EXT4_MAP_FLAGS;
> -
>  	/*
>  	 * New blocks allocate and/or writing to unwritten extent
>  	 * will possibly result in updating i_data, so we take
> @@ -643,76 +717,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	 * with create == 1 flag.
>  	 */
>  	down_write(&EXT4_I(inode)->i_data_sem);
> -
> -	/*
> -	 * We need to check for EXT4 here because migrate
> -	 * could have changed the inode type in between
> -	 */
> -	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		retval = ext4_ext_map_blocks(handle, inode, map, flags);
> -	} else {
> -		retval = ext4_ind_map_blocks(handle, inode, map, flags);
> -
> -		if (retval > 0 && map->m_flags & EXT4_MAP_NEW) {
> -			/*
> -			 * We allocated new blocks which will result in
> -			 * i_data's format changing.  Force the migrate
> -			 * to fail by clearing migrate flags
> -			 */
> -			ext4_clear_inode_state(inode, EXT4_STATE_EXT_MIGRATE);
> -		}
> -	}
> -
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
> -		/*
> -		 * We have to zeroout blocks before inserting them into extent
> -		 * status tree. Otherwise someone could look them up there and
> -		 * use them before they are really zeroed. We also have to
> -		 * unmap metadata before zeroing as otherwise writeback can
> -		 * overwrite zeros with stale data from block device.
> -		 */
> -		if (flags & EXT4_GET_BLOCKS_ZERO &&
> -		    map->m_flags & EXT4_MAP_MAPPED &&
> -		    map->m_flags & EXT4_MAP_NEW) {
> -			ret = ext4_issue_zeroout(inode, map->m_lblk,
> -						 map->m_pblk, map->m_len);
> -			if (ret) {
> -				retval = ret;
> -				goto out_sem;
> -			}
> -		}
> -
> -		/*
> -		 * If the extent has been zeroed out, we don't need to update
> -		 * extent status tree.
> -		 */
> -		if ((flags & EXT4_GET_BLOCKS_PRE_IO) &&
> -		    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> -			if (ext4_es_is_written(&es))
> -				goto out_sem;
> -		}
> -		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> -				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
> -		    !(status & EXTENT_STATUS_WRITTEN) &&
> -		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
> -				       map->m_lblk + map->m_len - 1))
> -			status |= EXTENT_STATUS_DELAYED;
> -		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -				      map->m_pblk, status);
> -	}
> -
> -out_sem:
> +	retval = ext4_map_create_blocks(handle, inode, map, flags);
>  	up_write((&EXT4_I(inode)->i_data_sem));
>  	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
>  		ret = check_block_validity(inode, map);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

