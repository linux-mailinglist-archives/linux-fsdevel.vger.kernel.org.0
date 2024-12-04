Return-Path: <linux-fsdevel+bounces-36420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 607CF9E3A0A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5582FB3618D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE31B983F;
	Wed,  4 Dec 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmss/YR+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2bewKa6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lmss/YR+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2bewKa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07B1B87CE;
	Wed,  4 Dec 2024 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313142; cv=none; b=SQyeXrr5FBwMLZpPK7xko88jjlTqW6Y/p3A82w9TgceVji4ow358bKeLFTQIaVo1ZT0TLPl1gwPRJYGOEMWpLShYyDjrg5yhbLlTb3JObFcdk27sB0MzDJZ0WO30PTiSUZYK5HFTmglpb4gqPDXB47qJHwkopUnGeAghrM/cLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313142; c=relaxed/simple;
	bh=i54XaDik5hTRYewBS6estFUpTx0Hb6ZOlLAnppD/474=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1IIdMLSA/AJCnUwB0dyLXmkIPHfNOB25BDBMc+0QcY9mt4axJ1D0djECjwjpFbggyvPsoshZfnFOXYa3VneNeT4c0vMaPC7FDH7mFw3SJ5stZz7k1+VUVvDzL8GsnxbFUeAn6u89f48bkX6ZoC6vIncJ1+0OqNqzGIaWup87bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmss/YR+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2bewKa6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lmss/YR+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2bewKa6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36E591F365;
	Wed,  4 Dec 2024 11:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZl7ryS+LbB4XSwukNQg2yPXvorACSKaUyYPz+m5bcc=;
	b=lmss/YR+tNz8bpVqHGUAAokFEw2psqIjFqoA6TEoBsFJrgJnHyF5lskFOYtDJHyTMt3iXN
	D+YgUW0SAghwh4/+jz0dVie98W4U8SyxDKswhIeTguj056DAxcR4amm1RM1NNK8E/9ZcJc
	KMBAejJfzeAQvgFMRgWge/2sMuXAxgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZl7ryS+LbB4XSwukNQg2yPXvorACSKaUyYPz+m5bcc=;
	b=T2bewKa6JDhnPTtgOLCc7ekKhcfUNJ7hjOjfCcRSJeVZVLY9L/AmKDut4XA8UuwQaFJ5mT
	WCte8UvcvLySJjCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="lmss/YR+";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T2bewKa6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZl7ryS+LbB4XSwukNQg2yPXvorACSKaUyYPz+m5bcc=;
	b=lmss/YR+tNz8bpVqHGUAAokFEw2psqIjFqoA6TEoBsFJrgJnHyF5lskFOYtDJHyTMt3iXN
	D+YgUW0SAghwh4/+jz0dVie98W4U8SyxDKswhIeTguj056DAxcR4amm1RM1NNK8E/9ZcJc
	KMBAejJfzeAQvgFMRgWge/2sMuXAxgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZl7ryS+LbB4XSwukNQg2yPXvorACSKaUyYPz+m5bcc=;
	b=T2bewKa6JDhnPTtgOLCc7ekKhcfUNJ7hjOjfCcRSJeVZVLY9L/AmKDut4XA8UuwQaFJ5mT
	WCte8UvcvLySJjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E7111396E;
	Wed,  4 Dec 2024 11:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XdlnB3FCUGcPGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 11:52:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C65E0A0918; Wed,  4 Dec 2024 12:52:08 +0100 (CET)
Date: Wed, 4 Dec 2024 12:52:08 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 05/27] ext4: refactor ext4_zero_range()
Message-ID: <20241204115208.g4lswqfbwrwmwtqw@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-6-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 36E591F365
X-Spam-Score: -2.51
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,fromorbit.com,google.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,huawei.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 22-10-24 19:10:36, Zhang Yi wrote:
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

...

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
> -
> -	}

So I think we should keep this first ext4_alloc_file_blocks() call before
we truncate the page cache. Otherwise if ext4_alloc_file_blocks() fails due
to ENOSPC, we have already lost the dirty data originally in the zeroed
range. All the other failure modes are kind of catastrophic anyway, so they
are fine after dropping the page cache. But this is can be quite common and
should be handled more gracefully.

								Honza

> -
> -	/* Zero range excluding the unaligned edges */
> -	if (max_blocks > 0) {
> -		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
> -			  EXT4_EX_NOCACHE);
> +		goto out;
>  
> -		/*
> -		 * Prevent page faults from reinstantiating pages we have
> -		 * released from page cache.
> -		 */
> -		filemap_invalidate_lock(mapping);
> +	/*
> +	 * Prevent page faults from reinstantiating pages we have released
> +	 * from page cache.
> +	 */
> +	filemap_invalidate_lock(mapping);
>  
> -		ret = ext4_break_layouts(inode);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +	ret = ext4_break_layouts(inode);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
> +	/*
> +	 * For journalled data we need to write (and checkpoint) pages before
> +	 * discarding page cache to avoid inconsitent data on disk in case of
> +	 * crash before zeroing trans is committed.
> +	 */
> +	if (ext4_should_journal_data(inode)) {
> +		ret = filemap_write_and_wait_range(mapping, offset, end - 1);
> +	} else {
>  		ret = ext4_update_disksize_before_punch(inode, offset, len);
> -		if (ret) {
> -			filemap_invalidate_unlock(mapping);
> -			goto out_mutex;
> -		}
> +		ext4_truncate_folios_range(inode, offset, end);
> +	}
> +	if (ret)
> +		goto out_invalidate_lock;
>  
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
> +	/* Now release the pages and zero block aligned part of pages */
> +	truncate_pagecache_range(inode, offset, end - 1);
>  
> -		/* Now release the pages and zero block aligned part of pages */
> -		ext4_truncate_folios_range(inode, start, end);
> -		truncate_pagecache_range(inode, start, end - 1);
> +	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> +	/* Preallocate the range including the unaligned edges */
> +	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
> +		ext4_lblk_t alloc_lblk = offset >> blkbits;
> +		ext4_lblk_t len_lblk = EXT4_MAX_BLOCKS(len, offset, blkbits);
>  
> -		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> -					     flags);
> -		filemap_invalidate_unlock(mapping);
> +		ret = ext4_alloc_file_blocks(file, alloc_lblk, len_lblk,
> +					     new_size, flags);
>  		if (ret)
> -			goto out_mutex;
> +			goto out_invalidate_lock;
>  	}
> -	if (!partial_begin && !partial_end)
> -		goto out_mutex;
> +
> +	/* Zero range excluding the unaligned edges */
> +	start_lblk = round_up(offset, blocksize) >> blkbits;
> +	end_lblk = end >> blkbits;
> +	if (end_lblk > start_lblk) {
> +		ext4_lblk_t zero_blks = end_lblk - start_lblk;
> +
> +		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
> +		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
> +					     new_size, flags);
> +		if (ret)
> +			goto out_invalidate_lock;
> +	}
> +	/* Finish zeroing out if it doesn't contain partial block */
> +	if (!(offset & (blocksize - 1)) && !(end & (blocksize - 1)))
> +		goto out_invalidate_lock;
>  
>  	/*
>  	 * In worst case we have to writeout two nonadjacent unwritten
> @@ -4700,25 +4665,29 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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

