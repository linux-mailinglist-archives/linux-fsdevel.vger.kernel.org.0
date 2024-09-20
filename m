Return-Path: <linux-fsdevel+bounces-29767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4062397D850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0246283277
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9117E006;
	Fri, 20 Sep 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HLFa2CxG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9inRGdee";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HLFa2CxG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9inRGdee"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9223417E003;
	Fri, 20 Sep 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849489; cv=none; b=gDPvLZ7IPisKfliGCJaFyVwBwYiQXlH0DwlD+SuzbAiDoUZXXxyFXvcTDH7nS+zQVtnhRoNSMj6Vzzg5W7qyuWHnV6JZL7gJ74tVNAz3Rt34LtNAjS7iP3jedNKeQ5gHT1vyBCNqDXAPiK+ODtV5DW0RFHdW/BDLjbHnXw/2rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849489; c=relaxed/simple;
	bh=KwCLXU36CkuUgCwd8TgpXlDQCl+rZJdRRn+cQonUp6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBWtIJCXZglW1YUdsGcM2gdK4gk6FcaXEYx8mdEvJONgH34MeFiVetrVBbUvqQfLRSMBkgAQQbar96r5MD97oUITIMpjTBmU9ZjpHYMtbAnVJZLOdHlus15Sa6HTzdNz1nJxTjGRAe4z7VD6UHuOLYOq/zy83VhdMPQw//SRam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HLFa2CxG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9inRGdee; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HLFa2CxG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9inRGdee; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B519D33A3E;
	Fri, 20 Sep 2024 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726849485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQOWrkA/WG22S0Ff5+HZ6LyJeXHjt9ekwamO2xCR3A0=;
	b=HLFa2CxG+1LHd7PoUgi7GPvsAU4MzwyfjVZie+WoSjunWkn9oQ49udMKD4UlM+Ao4zHyig
	5VnbtT9+0EnVq93RrpF4VIbvD6qdNH+TS/wpQextsTeDenbMpnQau6I26EUXDXpTh0qls7
	/m1Eqpoyzfrt31mJ7r0OzZhHoUdR6gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726849485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQOWrkA/WG22S0Ff5+HZ6LyJeXHjt9ekwamO2xCR3A0=;
	b=9inRGdeeMzqFgW+Tjm7bfKOihCtH9J/ghcpP4Wq7UZr2mZ7fa0w6+3F2DAMmhkpUjuZ+bd
	5hX8j3OR/vBKADAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726849485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQOWrkA/WG22S0Ff5+HZ6LyJeXHjt9ekwamO2xCR3A0=;
	b=HLFa2CxG+1LHd7PoUgi7GPvsAU4MzwyfjVZie+WoSjunWkn9oQ49udMKD4UlM+Ao4zHyig
	5VnbtT9+0EnVq93RrpF4VIbvD6qdNH+TS/wpQextsTeDenbMpnQau6I26EUXDXpTh0qls7
	/m1Eqpoyzfrt31mJ7r0OzZhHoUdR6gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726849485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQOWrkA/WG22S0Ff5+HZ6LyJeXHjt9ekwamO2xCR3A0=;
	b=9inRGdeeMzqFgW+Tjm7bfKOihCtH9J/ghcpP4Wq7UZr2mZ7fa0w6+3F2DAMmhkpUjuZ+bd
	5hX8j3OR/vBKADAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B62313AA7;
	Fri, 20 Sep 2024 16:24:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S41IFsah7WYNbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 16:24:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDD25A08BD; Fri, 20 Sep 2024 18:24:22 +0200 (CEST)
Date: Fri, 20 Sep 2024 18:24:22 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 04/10] ext4: refactor ext4_zero_range()
Message-ID: <20240920162422.sfoefd3bng6wwhir@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-5-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 04-09-24 14:29:19, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current ext4_zero_range() is full of complex position calculation and
> stale error out tags. In order to clean up the code and make things
> clear, refactor it by a) simplify and rename variables, b) remove some
> unnecessary position calculations, always write back dirty data and
> drop cache from offset to end, instead of only write back aligned
> blocks, c) rename the stale out_mutex tag.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 96 ++++++++++++++++++-----------------------------
>  1 file changed, 37 insertions(+), 59 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index d9fccf2970e9..2fb0c2e303c7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4540,40 +4540,15 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
> @@ -4581,26 +4556,23 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released
> @@ -4616,36 +4588,40 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	 * Write data that will be zeroed to preserve them when successfully
>  	 * discarding page cache below but fail to convert extents.
>  	 */
> -	ret = filemap_write_and_wait_range(mapping, start, end - 1);
> +	ret = filemap_write_and_wait_range(mapping, offset, end - 1);
>  	if (ret)
>  		goto out_invalidate_lock;
>  
> +	/* Now release the pages and zero block aligned part of pages */
> +	truncate_pagecache_range(inode, offset, end - 1);
> +
> +	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
>  	/* Preallocate the range including the unaligned edges */
> -	if (partial_begin || partial_end) {
> -		ret = ext4_alloc_file_blocks(file,
> -				round_down(offset, 1 << blkbits) >> blkbits,
> -				(round_up((offset + len), 1 << blkbits) -
> -				 round_down(offset, 1 << blkbits)) >> blkbits,
> -				new_size, flags);
> +	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
> +		ext4_lblk_t alloc_lblk = offset >> blkbits;
> +		ext4_lblk_t len_lblk = EXT4_MAX_BLOCKS(len, offset, blkbits);
> +
> +		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
> +					     new_size, flags);
>  		if (ret)
>  			goto out_invalidate_lock;
>  
>  	}
>  
>  	/* Zero range excluding the unaligned edges */
> -	if (max_blocks > 0) {
> -		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
> -			  EXT4_EX_NOCACHE);
> -
> -		/* Now release the pages and zero block aligned part of pages */
> -		truncate_pagecache_range(inode, start, end - 1);
> -
> -		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> -					     flags);
> +	start_lblk = round_up(offset, blocksize) >> blkbits;
> +	end_lblk = end >> blkbits;
> +	if (end_lblk > start_lblk) {
> +		ext4_lblk_t zero_blks = end_lblk - start_lblk;
> +
> +		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
> +		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
> +					     new_size, flags);
>  		if (ret)
>  			goto out_invalidate_lock;
>  	}
> -	if (!partial_begin && !partial_end)
> +	/* Finish zeroing out if it doesn't contain partial block */
> +	if (!(offset & (blocksize - 1)) && !(end & (blocksize - 1)))
>  		goto out_invalidate_lock;
>  
>  	/*
> @@ -4662,16 +4638,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		goto out_invalidate_lock;
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
> @@ -4679,7 +4657,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out_mutex:
> +out:
>  	inode_unlock(inode);
>  	return ret;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

