Return-Path: <linux-fsdevel+bounces-37500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D5D9F3471
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03E91645BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433471487E5;
	Mon, 16 Dec 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ruW8bxYt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydutSlNK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ruW8bxYt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydutSlNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA013B7BC;
	Mon, 16 Dec 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734362686; cv=none; b=SdTEWQ3aPp6ZwsnYwsxa1AxtE1WmQvATurV20zlY82HPimqTVA8x5yBxc5glsGw6k6PZzwJBPlyCayo7Yh6GN8ryQ57WkVdhPvjd3DYl/R8sTkXHpjpVYK3KxqWL/CnRKal2VH3SOSRaSL++wT4Vfq/zBOQGVMskKLiRwVGoFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734362686; c=relaxed/simple;
	bh=jEvwFMbNVVsOIfG01HbGwH6lEGq2ZEPsQzp0nvpX8hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL6D2hkOjcwa8NfjsTvcUe2yYiU1aeuKR0pENP1aauoZot0DHZDZs89YdfjI7vG9BOiSw+f83E393ejNaj4/h79XEDH2u/NDfz1Vz7FqnLP7mYhQodYMkBGlLaP5y31Q0CyJP6E6+mlbFGOu0CqH5FMWcwNm/qIOntUxPxwiXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ruW8bxYt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydutSlNK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ruW8bxYt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydutSlNK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A6951F385;
	Mon, 16 Dec 2024 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734362682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PoZvQ9WmZd4gLIo5PU5zQB0sptKp16IF9exvOst5Q4=;
	b=ruW8bxYtAKzeKRY/quJvFhN/Rxu4fGe253q59uy5kPWARgSwOfmilEsdQQTsb1y+R3hu4e
	bv+2bWcjrrvn++RcyFY2B0TNRHFIZ1ScKMKtAGtRB1HeZA7gHy+D1kJlORjtIngx7bLdcc
	wgbYTHrH2jGRbGfGrjWTYdWJ0D6mSPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734362682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PoZvQ9WmZd4gLIo5PU5zQB0sptKp16IF9exvOst5Q4=;
	b=ydutSlNKBiiSCxR4vSni2/f8HUb8wnghluHjEHpoMOghnKZoaWBDurfIu0TgF2aY/HyE/V
	MBn2BgguaW6ELJBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734362682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PoZvQ9WmZd4gLIo5PU5zQB0sptKp16IF9exvOst5Q4=;
	b=ruW8bxYtAKzeKRY/quJvFhN/Rxu4fGe253q59uy5kPWARgSwOfmilEsdQQTsb1y+R3hu4e
	bv+2bWcjrrvn++RcyFY2B0TNRHFIZ1ScKMKtAGtRB1HeZA7gHy+D1kJlORjtIngx7bLdcc
	wgbYTHrH2jGRbGfGrjWTYdWJ0D6mSPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734362682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5PoZvQ9WmZd4gLIo5PU5zQB0sptKp16IF9exvOst5Q4=;
	b=ydutSlNKBiiSCxR4vSni2/f8HUb8wnghluHjEHpoMOghnKZoaWBDurfIu0TgF2aY/HyE/V
	MBn2BgguaW6ELJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 786E713418;
	Mon, 16 Dec 2024 15:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SAtgHTpGYGcJFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Dec 2024 15:24:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2AFCDA09C6; Mon, 16 Dec 2024 16:24:42 +0100 (CET)
Date: Mon, 16 Dec 2024 16:24:42 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 05/10] ext4: refactor ext4_zero_range()
Message-ID: <20241216152442.7vg4x6cpuj26gurb@quack3>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-6-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 16-12-24 09:39:10, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The current implementation of ext4_zero_range() contains complex
> position calculations and stale error tags. To improve the code's
> clarity and maintainability, it is essential to clean up the code and
> improve its readability, this can be achieved by: a) simplifying and
> renaming variables, making the style the same as ext4_punch_hole(); b)
> eliminating unnecessary position calculations, writing back all data in
> data=journal mode, and drop page cache from the original offset to the
> end, rather than using aligned blocks; c) renaming the stale out_mutex
> tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 142 +++++++++++++++++++---------------------------
>  1 file changed, 57 insertions(+), 85 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 7fb38aab241d..97ad6fea58d3 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4570,40 +4570,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	struct inode *inode = file_inode(file);
>  	struct address_space *mapping = file->f_mapping;
>  	handle_t *handle = NULL;
> -	unsigned int max_blocks;
>  	loff_t new_size = 0;
> -	int ret = 0;
> -	int flags;
> -	int credits;
> -	int partial_begin, partial_end;
> -	loff_t start, end;
> -	ext4_lblk_t lblk;
> +	loff_t end = offset + len;
> +	ext4_lblk_t start_lblk, end_lblk;
> +	unsigned int blocksize = i_blocksize(inode);
>  	unsigned int blkbits = inode->i_blkbits;
> +	int ret, flags, credits;
>  
>  	trace_ext4_zero_range(inode, offset, len, mode);
>  
> -	/*
> -	 * Round up offset. This is not fallocate, we need to zero out
> -	 * blocks, so convert interior block aligned part of the range to
> -	 * unwritten and possibly manually zero out unaligned parts of the
> -	 * range. Here, start and partial_begin are inclusive, end and
> -	 * partial_end are exclusive.
> -	 */
> -	start = round_up(offset, 1 << blkbits);
> -	end = round_down((offset + len), 1 << blkbits);
> -
> -	if (start < offset || end > offset + len)
> -		return -EINVAL;
> -	partial_begin = offset & ((1 << blkbits) - 1);
> -	partial_end = (offset + len) & ((1 << blkbits) - 1);
> -
> -	lblk = start >> blkbits;
> -	max_blocks = (end >> blkbits);
> -	if (max_blocks < lblk)
> -		max_blocks = 0;
> -	else
> -		max_blocks -= lblk;
> -
>  	inode_lock(inode);
>  
>  	/*
> @@ -4611,77 +4586,70 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	 */
>  	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
>  		ret = -EOPNOTSUPP;
> -		goto out_mutex;
> +		goto out;
>  	}
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> -	    (offset + len > inode->i_size ||
> -	     offset + len > EXT4_I(inode)->i_disksize)) {
> -		new_size = offset + len;
> +	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
> +		new_size = end;
>  		ret = inode_newsize_ok(inode, new_size);
>  		if (ret)
> -			goto out_mutex;
> +			goto out;
>  	}
>  
> -	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> -
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
>  	inode_dio_wait(inode);
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> -
> -	/* Preallocate the range including the unaligned edges */
> -	if (partial_begin || partial_end) {
> -		ret = ext4_alloc_file_blocks(file,
> -				round_down(offset, 1 << blkbits) >> blkbits,
> -				(round_up((offset + len), 1 << blkbits) -
> -				 round_down(offset, 1 << blkbits)) >> blkbits,
> -				new_size, flags);
> -		if (ret)
> -			goto out_mutex;
> +		goto out;
>  
> -	}
> +	/*
> +	 * Prevent page faults from reinstantiating pages we have released
> +	 * from page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
>  
> -	/* Zero range excluding the unaligned edges */
> -	if (max_blocks > 0) {
> -		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
> -			  EXT4_EX_NOCACHE);
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
> -		/*
> -		 * Prevent page faults from reinstantiating pages we have
> -		 * released from page cache.
> -		 */
> -		filemap_invalidate_lock(mapping);
> +	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> +	/* Preallocate the range including the unaligned edges */
> +	if (!IS_ALIGNED(offset | end, blocksize)) {
> +		ext4_lblk_t alloc_lblk = offset >> blkbits;
> +		ext4_lblk_t len_lblk = EXT4_MAX_BLOCKS(len, offset, blkbits);
>  
> -		ret = ext4_break_layouts(inode);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
> +					     new_size, flags);
> +		if (ret)
> +			goto out_invalidate_lock;
> +	}
>  
> -		ret = ext4_update_disksize_before_punch(inode, offset, len);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +	ret = ext4_update_disksize_before_punch(inode, offset, len);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
> -		/* Now release the pages and zero block aligned part of pages */
> -		ret = ext4_truncate_page_cache_block_range(inode, start, end);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +	/* Now release the pages and zero block aligned part of pages */
> +	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
> -		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> -					     flags);
> -		filemap_invalidate_unlock(mapping);
> +	/* Zero range excluding the unaligned edges */
> +	start_lblk = EXT4_B_TO_LBLK(inode, offset);
> +	end_lblk = end >> blkbits;
> +	if (end_lblk > start_lblk) {
> +		ext4_lblk_t zero_blks = end_lblk - start_lblk;
> +
> +		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
> +		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
> +					     new_size, flags);
>  		if (ret)
> -			goto out_mutex;
> +			goto out_invalidate_lock;
>  	}
> -	if (!partial_begin && !partial_end)
> -		goto out_mutex;
> +	/* Finish zeroing out if it doesn't contain partial block */
> +	if (IS_ALIGNED(offset | end, blocksize))
> +		goto out_invalidate_lock;
>  
>  	/*
>  	 * In worst case we have to writeout two nonadjacent unwritten
> @@ -4694,25 +4662,29 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(inode->i_sb, ret);
> -		goto out_mutex;
> +		goto out_invalidate_lock;
>  	}
>  
> +	/* Zero out partial block at the edges of the range */
> +	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
> +	if (ret)
> +		goto out_handle;
> +
>  	if (new_size)
>  		ext4_update_inode_size(inode, new_size);
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	if (unlikely(ret))
>  		goto out_handle;
> -	/* Zero out partial block at the edges of the range */
> -	ret = ext4_zero_partial_blocks(handle, inode, offset, len);
> -	if (ret >= 0)
> -		ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	if (file->f_flags & O_SYNC)
>  		ext4_handle_sync(handle);
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_mutex:
> +out_invalidate_lock:
> +	filemap_invalidate_unlock(mapping);
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

