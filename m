Return-Path: <linux-fsdevel+bounces-29602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8B97B533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 23:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94094B262DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0321192B8C;
	Tue, 17 Sep 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="otfEDEWv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTbQNMke";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="otfEDEWv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qTbQNMke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DE192594;
	Tue, 17 Sep 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608575; cv=none; b=rMjFUtq/PKMDif+xlLTTLN/O7ZdV4yCsNJYzrdeZCOl92Kwb7kWBtKqId6BCPt7WwE+2hFT6Vus5I7lh780ysg/z8TVzcDqnvNLt6YB8ZfzcEZn7p/9W/AR0aYkWvjBLBhHaBCqaq+h6NuKoXu27KwFxpm0UKek0vFBDtp3oe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608575; c=relaxed/simple;
	bh=U80A2QgmdDQ+lbcvzOnxUMw7XU6PGpCO/xL5QwdtEOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk3eKGhUJcx8jt1btyxEpD1zIcKPadoznt8Q5jQSCFzZksjv+eLUlLTuE4BTl7uRTxNaPPhm6vdry+h1sOkSmS+gpLZVaaPqGX+mm997XglNZOUaCoczODEKGECOaafOGTqA5I9DXwrx2QQy8QvgGod5Hsv+nlhma9dM05U2anI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=otfEDEWv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTbQNMke; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=otfEDEWv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qTbQNMke; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3AE55201E0;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qa95/ktdvyh9hNFNrsN46J5FSoqzSObFkyzebALZLcM=;
	b=otfEDEWvvhCi2pkswdoDo14sv5SIBWEPuecLEzcqT2uZLkiFDeiGORK7bhaUDSgu0Py/q+
	aNEN+wIy62cGLzNvx5LDO8vnZXs58yP7XW5AHAIW49MrMLfKy2m8IilsK0cxpK8NkcKniI
	t5yDGKUSmovDgE0UyF5Ry5iJPHDHMos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qa95/ktdvyh9hNFNrsN46J5FSoqzSObFkyzebALZLcM=;
	b=qTbQNMkeVFeVBbigZsOEJIvfqZbn8R5DnEdtUokLOFCXXX0l5lAMiYI63yYDAKDyGuE1YU
	sx9b3H/K+pjtYyCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726608571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qa95/ktdvyh9hNFNrsN46J5FSoqzSObFkyzebALZLcM=;
	b=otfEDEWvvhCi2pkswdoDo14sv5SIBWEPuecLEzcqT2uZLkiFDeiGORK7bhaUDSgu0Py/q+
	aNEN+wIy62cGLzNvx5LDO8vnZXs58yP7XW5AHAIW49MrMLfKy2m8IilsK0cxpK8NkcKniI
	t5yDGKUSmovDgE0UyF5Ry5iJPHDHMos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726608571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qa95/ktdvyh9hNFNrsN46J5FSoqzSObFkyzebALZLcM=;
	b=qTbQNMkeVFeVBbigZsOEJIvfqZbn8R5DnEdtUokLOFCXXX0l5lAMiYI63yYDAKDyGuE1YU
	sx9b3H/K+pjtYyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27B7513AB6;
	Tue, 17 Sep 2024 21:29:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8TOrCbv06WaiMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 21:29:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E39EA0AC2; Tue, 17 Sep 2024 18:50:07 +0200 (CEST)
Date: Tue, 17 Sep 2024 18:50:07 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 01/10] ext4: write out dirty data before dropping pages
Message-ID: <20240917165007.j5dywaekvnirfffm@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-2-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 14:29:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current zero range, punch hole and collapse range have a common
> potential data loss problem. In general, ext4_zero_range(),
> ext4_collapse_range() and ext4_punch_hold() will discard all page cache
> of the operation range before converting the extents status. However,
> the first two functions don't write back dirty data before discarding
> page cache, and ext4_punch_hold() write back at the very beginning
> without holding i_rwsem and mapping invalidate lock. Hence, if some bad
> things (e.g. EIO or ENOMEM) happens just after dropping dirty page
> cache, the operation will failed but the user's valid data in the dirty
> page cache will be lost. Fix this by write all dirty data under i_rwsem
> and mapping invalidate lock before discarding pages.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I'm not sure this is the direction we want to go. When zeroing / collapsing
/ punching writing out all the data we are going to remove seems suboptimal
and we can spend significant time doing work that is mostly unnecessary.
After all with truncate we also drop pagecache pages and the do on-disk
modification which can fail.

The case of EIO is in my opinion OK - when there are disk errors, we are
going to loose data and e2fsck is needed. So protecting with writeout
against possible damage is pointless. For ENOMEM I agree we should better
preserve filesystem consistency. Is there some case where we would keep
filesystem inconsistent on ENOMEM?

								Honza

> ---
>  fs/ext4/extents.c | 77 +++++++++++++++++------------------------------
>  fs/ext4/inode.c   | 19 +++++-------
>  2 files changed, 36 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e067f2dd0335..7d5edfa2e630 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4602,6 +4602,24 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	if (ret)
>  		goto out_mutex;
>  
> +	/*
> +	 * Prevent page faults from reinstantiating pages we have released
> +	 * from page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
> +
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto out_invalidate_lock;
> +
> +	/*
> +	 * Write data that will be zeroed to preserve them when successfully
> +	 * discarding page cache below but fail to convert extents.
> +	 */
> +	ret = filemap_write_and_wait_range(mapping, start, end - 1);
> +	if (ret)
> +		goto out_invalidate_lock;
> +
>  	/* Preallocate the range including the unaligned edges */
>  	if (partial_begin || partial_end) {
>  		ret = ext4_alloc_file_blocks(file,
> @@ -4610,7 +4628,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  				 round_down(offset, 1 << blkbits)) >> blkbits,
>  				new_size, flags);
>  		if (ret)
> -			goto out_mutex;
> +			goto out_invalidate_lock;
>  
>  	}
>  
> @@ -4619,37 +4637,9 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
>  			  EXT4_EX_NOCACHE);
>  
> -		/*
> -		 * Prevent page faults from reinstantiating pages we have
> -		 * released from page cache.
> -		 */
> -		filemap_invalidate_lock(mapping);
> -
> -		ret = ext4_break_layouts(inode);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> -
>  		ret = ext4_update_disksize_before_punch(inode, offset, len);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> -
> -		/*
> -		 * For journalled data we need to write (and checkpoint) pages
> -		 * before discarding page cache to avoid inconsitent data on
> -		 * disk in case of crash before zeroing trans is committed.
> -		 */
> -		if (ext4_should_journal_data(inode)) {
> -			ret = filemap_write_and_wait_range(mapping, start,
> -							   end - 1);
> -			if (ret) {
> -				filemap_invalidate_unlock(mapping);
> -				goto out_mutex;
> -			}
> -		}
> +		if (ret)
> +			goto out_invalidate_lock;
>  
>  		/* Now release the pages and zero block aligned part of pages */
>  		truncate_pagecache_range(inode, start, end - 1);
> @@ -4657,12 +4647,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
>  					     flags);
> -		filemap_invalidate_unlock(mapping);
>  		if (ret)
> -			goto out_mutex;
> +			goto out_invalidate_lock;
>  	}
>  	if (!partial_begin && !partial_end)
> -		goto out_mutex;
> +		goto out_invalidate_lock;
>  
>  	/*
>  	 * In worst case we have to writeout two nonadjacent unwritten
> @@ -4675,7 +4664,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(inode->i_sb, ret);
> -		goto out_mutex;
> +		goto out_invalidate_lock;
>  	}
>  
>  	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> @@ -4694,6 +4683,8 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> +out_invalidate_lock:
> +	filemap_invalidate_unlock(mapping);
>  out_mutex:
>  	inode_unlock(inode);
>  	return ret;
> @@ -5363,20 +5354,8 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	 * for page size > block size.
>  	 */
>  	ioffset = round_down(offset, PAGE_SIZE);
> -	/*
> -	 * Write tail of the last page before removed range since it will get
> -	 * removed from the page cache below.
> -	 */
> -	ret = filemap_write_and_wait_range(mapping, ioffset, offset);
> -	if (ret)
> -		goto out_mmap;
> -	/*
> -	 * Write data that will be shifted to preserve them when discarding
> -	 * page cache below. We are also protected from pages becoming dirty
> -	 * by i_rwsem and invalidate_lock.
> -	 */
> -	ret = filemap_write_and_wait_range(mapping, offset + len,
> -					   LLONG_MAX);
> +	/* Write out all dirty pages */
> +	ret = filemap_write_and_wait_range(mapping, ioffset, LLONG_MAX);
>  	if (ret)
>  		goto out_mmap;
>  	truncate_pagecache(inode, ioffset);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..c3d7606a5315 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3957,17 +3957,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> -	/*
> -	 * Write out all dirty pages to avoid race conditions
> -	 * Then release them.
> -	 */
> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> -		ret = filemap_write_and_wait_range(mapping, offset,
> -						   offset + length - 1);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	inode_lock(inode);
>  
>  	/* No need to punch hole beyond i_size */
> @@ -4021,6 +4010,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (ret)
>  		goto out_dio;
>  
> +	/* Write out all dirty pages to avoid race conditions */
> +	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> +		ret = filemap_write_and_wait_range(mapping, offset,
> +						   offset + length - 1);
> +		if (ret)
> +			goto out_dio;
> +	}
> +
>  	first_block_offset = round_up(offset, sb->s_blocksize);
>  	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

