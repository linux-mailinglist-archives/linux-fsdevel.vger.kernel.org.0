Return-Path: <linux-fsdevel+bounces-25113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CE9493A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF91C2157F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B501D47DB;
	Tue,  6 Aug 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IymEJ6kN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9fYvqTvi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1Nqs6L0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwAlTJJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030371C4632;
	Tue,  6 Aug 2024 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955703; cv=none; b=E0TIJRjgIZNdUwYQhYuLxLueUBFpolsQr29JE0X+fHZweLjv8c6h3/2SBBnXCUp0ShBtLRjIO5Jr9nkbR79Fd+tJsZmKLvm2GCTadr5gw96Toj37ywZEZLCs8FNAikxEvNRl0VsEzljHXgGw6r+I/IPS4QGkzFYZVHd4pZG80Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955703; c=relaxed/simple;
	bh=VybxuQBAM4o24NbIdlrBob9LpV4bJGlToSnIWUJm6NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSCLRKhPtyaejW8cuCHEnzrKB19ihDqAYCs11xyBiBxfclveRfLbxm2ymq2qGGxmQGGkILXg4bF+yYC4B+e/xAc7/X0B8VZdf7FgWaXTkJJWfam1wJPUocL7ycP10Ck4Y2K1PmA8xrIZaExM99mRJCWxRtlSLKqvjPctmUKa904=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IymEJ6kN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9fYvqTvi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1Nqs6L0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwAlTJJu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFA7321A3B;
	Tue,  6 Aug 2024 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722955700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIy6LB74tYno7F1w+6DejLLIb5pKKiajOSRCccD1aDM=;
	b=IymEJ6kNuU6w6OIG5OEOPNzOnZBqxoZJRbbgfXSrDD0QFT1H5dw8URE9OEKDHY9RpUmjRM
	+cuVWrMVrAWPHT4LV5/dJ+bacP8AXXTbcwpE9iH8gS4raVVGd5Q6JVbI50hnrnut+pTbK1
	9FhpkpNRsxnFQHSubUzCxXxdPLd/f0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722955700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIy6LB74tYno7F1w+6DejLLIb5pKKiajOSRCccD1aDM=;
	b=9fYvqTvi3aI3xAU/AaLcw5WAnO8j2lV3e8Y9vMsaDdltF0tDiVyMczMUdxfliY047nDiKp
	CEIfhq+AVl+VHkCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722955698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIy6LB74tYno7F1w+6DejLLIb5pKKiajOSRCccD1aDM=;
	b=W1Nqs6L0Wq9GmsmANpB1PJ/SoeuAy5/4AOJhKGhN33TaPUZP1+XM9mGZiyxLNkD+arbmm3
	lZrucRCjTUZwQiRaKK+xV9qTaXexTQbn4vU4uzDlEntHE7O8JW6z2DJ+p33AlkbJAt1DTz
	QhG5ZB3rDX2Ym9M9O4pNGQnjV0MRuSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722955698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIy6LB74tYno7F1w+6DejLLIb5pKKiajOSRCccD1aDM=;
	b=FwAlTJJuY02fGPm7yRre/vJ9VZBtC0+4oMShZYJXQH736yi93iVPw94Op3XvVvw+FQH8lU
	uryqBkSUP8K0LOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE07813770;
	Tue,  6 Aug 2024 14:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8tc0NrI3smatYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Aug 2024 14:48:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 859C3A0762; Tue,  6 Aug 2024 16:48:18 +0200 (CEST)
Date: Tue, 6 Aug 2024 16:48:18 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 02/10] ext4: optimize the
 EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
Message-ID: <20240806144818.rt2vb677cxghxykz@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802115120.362902-3-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [0.70 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Score: 0.70

On Fri 02-08-24 19:51:12, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When doing block allocation, magic EXT4_GET_BLOCKS_DELALLOC_RESERVE
> means the allocating range covers a range of delayed allocated clusters,
> the blocks and quotas have already been reserved in ext4_da_map_blocks(),
> we should update the reserved space and don't need to claim them again.
> 
> At the moment, we only set this magic in mpage_map_one_extent() when
> allocating a range of delayed allocated clusters in the write back path,
> it makes things complicated since we have to notice and deal with the
> case of allocating non-delayed allocated clusters separately in
> ext4_ext_map_blocks(). For example, it we fallocate some blocks that
> have been delayed allocated, free space would be claimed again in
> ext4_mb_new_blocks() (this is wrong exactily), and we can't claim quota
> space again, we have to release the quota reservations made for that
> previously delayed allocated clusters.
> 
> Move the position thats set the EXT4_GET_BLOCKS_DELALLOC_RESERVE to
> where we actually do block allocation, it could simplify above handling
> a lot, it means that we always set this magic once the allocation range
> covers delalloc blocks, no need to take care of the allocation path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Ah, nice idea. The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 112aec171ee9..91b2610a6dc5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -489,6 +489,14 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  	unsigned int status;
>  	int err, retval = 0;
>  
> +	/*
> +	 * We pass in the magic EXT4_GET_BLOCKS_DELALLOC_RESERVE
> +	 * indicates that the blocks and quotas has already been
> +	 * checked when the data was copied into the page cache.
> +	 */
> +	if (map->m_flags & EXT4_MAP_DELAYED)
> +		flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
> +
>  	/*
>  	 * Here we clear m_flags because after allocating an new extent,
>  	 * it will be set again.
> @@ -2224,11 +2232,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  	 * writeback and there is nothing we can do about it so it might result
>  	 * in data loss.  So use reserved blocks to allocate metadata if
>  	 * possible.
> -	 *
> -	 * We pass in the magic EXT4_GET_BLOCKS_DELALLOC_RESERVE if
> -	 * the blocks in question are delalloc blocks.  This indicates
> -	 * that the blocks and quotas has already been checked when
> -	 * the data was copied into the page cache.
>  	 */
>  	get_blocks_flags = EXT4_GET_BLOCKS_CREATE |
>  			   EXT4_GET_BLOCKS_METADATA_NOFAIL |
> @@ -2236,8 +2239,6 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  	dioread_nolock = ext4_should_dioread_nolock(inode);
>  	if (dioread_nolock)
>  		get_blocks_flags |= EXT4_GET_BLOCKS_IO_CREATE_EXT;
> -	if (map->m_flags & BIT(BH_Delay))
> -		get_blocks_flags |= EXT4_GET_BLOCKS_DELALLOC_RESERVE;
>  
>  	err = ext4_map_blocks(handle, inode, map, get_blocks_flags);
>  	if (err < 0)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

