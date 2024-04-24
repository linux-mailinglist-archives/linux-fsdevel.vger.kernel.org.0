Return-Path: <linux-fsdevel+bounces-17669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503908B1412
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0167628C47C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0862143C4E;
	Wed, 24 Apr 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFRTYMI2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SGKY+CcG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="unpeOc7c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="764smNO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92B14A85;
	Wed, 24 Apr 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989137; cv=none; b=kH1dt+XxqqBijjdY8XJd4qSOBso9AeIuQ1o42iXCdjgLVTgOULzd6+dIIuWZziVZmIBUQfq/Ql49riCRHF5JB8Ej00uKxR8XIfBzMw2ATCrGOCoiZvpZG6dgrPd2Z3nk3THETgvjh+BRCwjSpKy+2+WzKRRfogwICjM+DKnO+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989137; c=relaxed/simple;
	bh=uFuQn3p//KFyM9ZGDCMx/Jh1z/68XTHQS7py0Ub3zAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7HVQNi3pFyg6UVzCBO00BCealtCDUJwFhX7dTUO6X64l2UCoZKmKNalK3EGWIFPZqsVCysLX/eW+o9wuVamzXflpY8maIV9Y/pSY/0Akgr4OOvMXZOavCbq+nn96naX0Wamh/KilUTu19WuDW7JbpAVbzjKE8HX4KLR2u69fhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFRTYMI2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SGKY+CcG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=unpeOc7c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=764smNO6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7F63211FB;
	Wed, 24 Apr 2024 20:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713989133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hIle4x1lNLMgngw+ykkIuCoMdPNhaND5vxItn6xv+o=;
	b=LFRTYMI2D5i6zrPCEcORA6k+/5iN/QWnyT7gQXdk6SVYmW98lSVsX6fzR/uTejKVYQd827
	OJjAmcUkqxLmPr1H/VAKNbh3h3IeF/GBghA3icWebMVtrc6rNFHZxv8/BOMsj495BJlY4x
	iNwU5NHLfGSNPqWk/U5AfSf6dRPo3io=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713989133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hIle4x1lNLMgngw+ykkIuCoMdPNhaND5vxItn6xv+o=;
	b=SGKY+CcGR8JxIBxNzRcnKjOHyyeISRDqy6lfSQYYzxqyl9afi2LW+0CMKObZWg1t1oCJCl
	H6tlrqh42FvWC7AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713989132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hIle4x1lNLMgngw+ykkIuCoMdPNhaND5vxItn6xv+o=;
	b=unpeOc7c0KBzf7OReoQoLVZ+rRTxgR5AmxAqf33ThMCBztXdOPCCeK6XBlO4hXlevhAVUO
	z83zUYKlYbMiTY4taSN7SZlkU2IFFyEoK1K5gx6OMuZ68uK4Ya3KswK5L+LcMf1BhXlrvM
	NB7TYRai4pzwufRa6C5lPtKcv/eAA8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713989132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hIle4x1lNLMgngw+ykkIuCoMdPNhaND5vxItn6xv+o=;
	b=764smNO6jNphsirOraDszNCwOg009rLBE2Hv+vrgt1UhGTWPaTEYUjlz99/l/F5M/gLhxl
	ZDQZcoiTeNw43DCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE1FE13690;
	Wed, 24 Apr 2024 20:05:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uowwNgxmKWaKcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Apr 2024 20:05:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A056DA0861; Wed, 24 Apr 2024 22:05:28 +0200 (CEST)
Date: Wed, 24 Apr 2024 22:05:28 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 2/9] ext4: check the extent status again before
 inserting delalloc block
Message-ID: <20240424200528.zvcxcfv3vr6pn5r7@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-3-yi.zhang@huaweicloud.com>
X-Spam-Level: ****
X-Spamd-Result: default: False [4.30 / 50.00];
	BAYES_SPAM(5.10)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email]
X-Spam-Score: 4.30
X-Spam-Flag: NO

On Wed 10-04-24 11:41:56, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now we lookup extent status entry without holding the i_data_sem before
> inserting delalloc block, it works fine in buffered write path and
> because it holds i_rwsem and folio lock, and the mmap path holds folio
> lock, so the found extent locklessly couldn't be modified concurrently.
> But it could be raced by fallocate since it allocate block whitout
> holding i_rwsem and folio lock.
> 
> ext4_page_mkwrite()             ext4_fallocate()
>  block_page_mkwrite()
>   ext4_da_map_blocks()
>    //find hole in extent status tree
>                                  ext4_alloc_file_blocks()
>                                   ext4_map_blocks()
>                                    //allocate block and unwritten extent
>    ext4_insert_delayed_block()
>     ext4_da_reserve_space()
>      //reserve one more block
>     ext4_es_insert_delayed_block()
>      //drop unwritten extent and add delayed extent by mistake
> 
> Then, the delalloc extent is wrong until writeback, the one more
> reserved block can't be release any more and trigger below warning:
> 
>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
> 
> Hold i_data_sem in write mode directly can fix the problem, but it's
> expansive, we should keep the lockless check and check the extent again
> once we need to add an new delalloc block.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6a41172c06e1..118b0497a954 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1737,6 +1737,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  		if (ext4_es_is_hole(&es))
>  			goto add_delayed;
>  
> +found:
>  		/*
>  		 * Delayed extent could be allocated by fallocate.
>  		 * So we need to check it.
> @@ -1781,6 +1782,24 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  
>  add_delayed:
>  	down_write(&EXT4_I(inode)->i_data_sem);
> +	/*
> +	 * Lookup extents tree again under i_data_sem, make sure this
> +	 * inserting delalloc range haven't been delayed or allocated
> +	 * whitout holding i_rwsem and folio lock.
> +	 */
> +	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
> +		if (!ext4_es_is_hole(&es)) {
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			goto found;
> +		}
> +	} else if (!ext4_has_inline_data(inode)) {
> +		retval = ext4_map_query_blocks(NULL, inode, map);
> +		if (retval) {
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			return retval;
> +		}
> +	}
> +
>  	retval = ext4_insert_delayed_block(inode, map->m_lblk);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	if (retval)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

