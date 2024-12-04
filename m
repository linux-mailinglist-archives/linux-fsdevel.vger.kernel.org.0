Return-Path: <linux-fsdevel+bounces-36430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343DE9E398F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CA016957A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81BF1B81B2;
	Wed,  4 Dec 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DoxBcsx2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EubDeTLC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DoxBcsx2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EubDeTLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEB1AF0A4;
	Wed,  4 Dec 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314249; cv=none; b=YVgUujbEEhozmWwzlVTySpi7WqF65fJtjo1FHoTQI+iSQelqEAYu2ozUXXcZivdLousI/GizPPhGMS3x7V1cmgdxabMecvP+VQxho/3ftbOmoWtLXEBBTj/wOWwG7VEEfjrzHAcFB4GPGB8vZDtw6jXu7m/pPDRpZGe5/+J7gZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314249; c=relaxed/simple;
	bh=3dx7ecRoJfLGF3tR33oNu2pYKwgMMcMrz7TrQ8EJtf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrwn1kC6SU8ie8XDxGjjrM6+oIUTr5XNSYm+xF4Xlf2v/cGaoIfcUmiPIqrVT5DDDSX84ekUdncNpwPBVqusl2Xf1WPdBFXsiz9AFxlcbJeZeiHx4neEg4P1WsX/O/2THcdrmCV/jld6IKnAoAo4lnBhtlqU74ECk6lCEChkvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DoxBcsx2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EubDeTLC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DoxBcsx2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EubDeTLC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0217E2115F;
	Wed,  4 Dec 2024 12:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733314245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF5sh9bExnZf8OyyFNGO8bBcNhsjDAYz93eCh4gM4lY=;
	b=DoxBcsx2/UqT58mK3X2AyNWpZlQYo/lyx/67pvW+fOilW2WceKXqx9gL/grqz2+rOYidMq
	izpujUFWAAy2KoEayMqnkyQIK2tZykIxA4ssX5u7++zyMnkhBrsYPwI/SIxmek3Ulvsr89
	KaRv7D7i7UPilzREU+MuFWjzO6k/Rps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733314245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF5sh9bExnZf8OyyFNGO8bBcNhsjDAYz93eCh4gM4lY=;
	b=EubDeTLCJ07LUdTYHgMeW2IbFvAktypjZBENU/MdUpqR5XUoO9nHzODbk/tNTUG+KMnI3C
	Nwmy8n269bWdHVAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733314245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF5sh9bExnZf8OyyFNGO8bBcNhsjDAYz93eCh4gM4lY=;
	b=DoxBcsx2/UqT58mK3X2AyNWpZlQYo/lyx/67pvW+fOilW2WceKXqx9gL/grqz2+rOYidMq
	izpujUFWAAy2KoEayMqnkyQIK2tZykIxA4ssX5u7++zyMnkhBrsYPwI/SIxmek3Ulvsr89
	KaRv7D7i7UPilzREU+MuFWjzO6k/Rps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733314245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF5sh9bExnZf8OyyFNGO8bBcNhsjDAYz93eCh4gM4lY=;
	b=EubDeTLCJ07LUdTYHgMeW2IbFvAktypjZBENU/MdUpqR5XUoO9nHzODbk/tNTUG+KMnI3C
	Nwmy8n269bWdHVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6B2D1396E;
	Wed,  4 Dec 2024 12:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id axtJOMRGUGcUIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 12:10:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0792A0918; Wed,  4 Dec 2024 13:10:36 +0100 (CET)
Date: Wed, 4 Dec 2024 13:10:36 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 10/27] ext4: move out common parts into ext4_fallocate()
Message-ID: <20241204121036.7itzlr5nndpajx2a@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-11-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 22-10-24 19:10:41, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, all zeroing ranges, punch holes, collapse ranges, and insert
> ranges first wait for all existing direct I/O workers to complete, and
> then they acquire the mapping's invalidate lock before performing the
> actual work. These common components are nearly identical, so we can
> simplify the code by factoring them out into the ext4_fallocate().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 121 ++++++++++++++++------------------------------
>  fs/ext4/inode.c   |  23 +--------
>  2 files changed, 43 insertions(+), 101 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a2db4e85790f..d5067d5aa449 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4587,23 +4587,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  			return ret;
>  	}
>  
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released
> -	 * from page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
> -
>  	/*
>  	 * For journalled data we need to write (and checkpoint) pages before
>  	 * discarding page cache to avoid inconsitent data on disk in case of
> @@ -4616,7 +4599,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		ext4_truncate_folios_range(inode, offset, end);
>  	}
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	/* Now release the pages and zero block aligned part of pages */
>  	truncate_pagecache_range(inode, offset, end - 1);
> @@ -4630,7 +4613,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
>  					     new_size, flags);
>  		if (ret)
> -			goto out_invalidate_lock;
> +			return ret;
>  	}
>  
>  	/* Zero range excluding the unaligned edges */
> @@ -4643,11 +4626,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
>  					     new_size, flags);
>  		if (ret)
> -			goto out_invalidate_lock;
> +			return ret;
>  	}
>  	/* Finish zeroing out if it doesn't contain partial block */
>  	if (!(offset & (blocksize - 1)) && !(end & (blocksize - 1)))
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	/*
>  	 * In worst case we have to writeout two nonadjacent unwritten
> @@ -4660,7 +4643,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(inode->i_sb, ret);
> -		goto out_invalidate_lock;
> +		return ret;
>  	}
>  
>  	/* Zero out partial block at the edges of the range */
> @@ -4680,8 +4663,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> @@ -4714,13 +4695,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  			goto out;
>  	}
>  
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		goto out;
> -
>  	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
>  				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
>  	if (ret)
> @@ -4745,6 +4719,7 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  {
>  	struct inode *inode = file_inode(file);
> +	struct address_space *mapping = file->f_mapping;
>  	int ret;
>  
>  	/*
> @@ -4768,6 +4743,29 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	if (ret)
>  		goto out;
>  
> +	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> +	inode_dio_wait(inode);
> +
> +	ret = file_modified(file);
> +	if (ret)
> +		return ret;
> +
> +	if ((mode & FALLOC_FL_MODE_MASK) == FALLOC_FL_ALLOCATE_RANGE) {
> +		ret = ext4_do_fallocate(file, offset, len, mode);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Follow-up operations will drop page cache, hold invalidate lock
> +	 * to prevent page faults from reinstantiating pages we have
> +	 * released from page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
> +
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto out_invalidate_lock;
> +
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = ext4_punch_hole(file, offset, len);
>  	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
> @@ -4777,7 +4775,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	else if (mode & FALLOC_FL_ZERO_RANGE)
>  		ret = ext4_zero_range(file, offset, len, mode);
>  	else
> -		ret = ext4_do_fallocate(file, offset, len, mode);
> +		ret = -EOPNOTSUPP;
> +
> +out_invalidate_lock:
> +	filemap_invalidate_unlock(mapping);
>  out:
>  	inode_unlock(inode);
>  	return ret;
> @@ -5304,23 +5305,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	if (end >= inode->i_size)
>  		return -EINVAL;
>  
> -	/* Wait for existing dio to complete */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released from
> -	 * page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
> -
>  	/*
>  	 * Write tail of the last page before removed range and data that
>  	 * will be shifted since they will get removed from the page cache
> @@ -5334,16 +5318,15 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	if (!ret)
>  		ret = filemap_write_and_wait_range(mapping, end, LLONG_MAX);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	truncate_pagecache(inode, start);
>  
>  	credits = ext4_writepage_trans_blocks(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		goto out_invalidate_lock;
> -	}
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
>  	start_lblk = offset >> inode->i_blkbits;
> @@ -5382,8 +5365,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> @@ -5424,23 +5405,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	if (len > inode->i_sb->s_maxbytes - inode->i_size)
>  		return -EFBIG;
>  
> -	/* Wait for existing dio to complete */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released from
> -	 * page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
> -
>  	/*
>  	 * Write out all dirty pages. Need to round down to align start offset
>  	 * to page size boundary for page size > block size.
> @@ -5448,16 +5412,15 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	start = round_down(offset, PAGE_SIZE);
>  	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	truncate_pagecache(inode, start);
>  
>  	credits = ext4_writepage_trans_blocks(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		goto out_invalidate_lock;
> -	}
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
>  	/* Expand file to avoid data loss if there is error while shifting */
> @@ -5528,8 +5491,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bea19cd6e676..1ccf84a64b7b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3992,23 +3992,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  			return ret;
>  	}
>  
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * Prevent page faults from reinstantiating pages we have released from
> -	 * page cache.
> -	 */
> -	filemap_invalidate_lock(mapping);
> -
> -	ret = ext4_break_layouts(inode);
> -	if (ret)
> -		goto out_invalidate_lock;
> -
>  	/*
>  	 * For journalled data we need to write (and checkpoint) pages
>  	 * before discarding page cache to avoid inconsitent data on
> @@ -4021,7 +4004,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ext4_truncate_folios_range(inode, offset, end);
>  	}
>  	if (ret)
> -		goto out_invalidate_lock;
> +		return ret;
>  
>  	/* Now release the pages and zero block aligned part of pages*/
>  	truncate_pagecache_range(inode, offset, end - 1);
> @@ -4034,7 +4017,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(sb, ret);
> -		goto out_invalidate_lock;
> +		return ret;
>  	}
>  
>  	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
> @@ -4079,8 +4062,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  		ext4_handle_sync(handle);
>  out_handle:
>  	ext4_journal_stop(handle);
> -out_invalidate_lock:
> -	filemap_invalidate_unlock(mapping);
>  	return ret;
>  }
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

