Return-Path: <linux-fsdevel+bounces-29768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B889E97D85D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C228417B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02131442F4;
	Fri, 20 Sep 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2bBYtpqP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILXpyyKC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2bBYtpqP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILXpyyKC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE528683;
	Fri, 20 Sep 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726849896; cv=none; b=TvjVOrBncJbirA9e+cxH8gn+TRzHbzjlAIjrA6/9Ei/2m/Iwq/w1CpaYo8DPs9ce0Dp+JU4/FZt0LKS1H6n1h/ejwLBPNRr97w9wLx+Q3qmE9yM5kmPd3+ogH/jit5wz/t22NFaYU0Zh4spNTP5nIUB0fo7VDQfOdHDyn2PzvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726849896; c=relaxed/simple;
	bh=Zzgpq0Stt5lDzpRpIUSeF3Y8ni8PvXvpriC9NeFFrWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyO2l0KreuuPkmfWHnuvWKBLiat7COMgkt6Ftt7GvfZYcJ5E6uBHNbZVotFaP3a/NSF31Y3trXzvsBjscQQeJu3kjZw9t2BG7j1tYdZYNZLjDD+NWrAgfZsN4zkrBSrmDMaBbGxKpZUEHPYNeBtepLnNaYDN6pELH+rvQPVY6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2bBYtpqP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILXpyyKC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2bBYtpqP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILXpyyKC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 682CF33A49;
	Fri, 20 Sep 2024 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726849892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJ57FEFRvk0goV9VnPeaByOfpHpTKw17Psx2YyTtEo=;
	b=2bBYtpqPeKCR89htQD9o9qWuSFdnEepLq1Fc13cKzmOoxMjBqkacqFBoK0UW1x5m/VYdvU
	b7N71c8YI/ZdjYohZCTDkdDXI2TZf6NPYGxrptFvcA6DZppdVv7AX++GH9Vn6aovLmyJcx
	hhz+vjbr8WDNUlPh7/4f8FpX0ZNq1es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726849892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJ57FEFRvk0goV9VnPeaByOfpHpTKw17Psx2YyTtEo=;
	b=ILXpyyKC/1wTSDiY14vzI+fX/vdT7dkMfow/tmlSw0OgtM4AQ16srYAs4zSr6E97xjTklk
	j1+AAQ9eTAFNv/BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2bBYtpqP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ILXpyyKC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726849892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJ57FEFRvk0goV9VnPeaByOfpHpTKw17Psx2YyTtEo=;
	b=2bBYtpqPeKCR89htQD9o9qWuSFdnEepLq1Fc13cKzmOoxMjBqkacqFBoK0UW1x5m/VYdvU
	b7N71c8YI/ZdjYohZCTDkdDXI2TZf6NPYGxrptFvcA6DZppdVv7AX++GH9Vn6aovLmyJcx
	hhz+vjbr8WDNUlPh7/4f8FpX0ZNq1es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726849892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulJ57FEFRvk0goV9VnPeaByOfpHpTKw17Psx2YyTtEo=;
	b=ILXpyyKC/1wTSDiY14vzI+fX/vdT7dkMfow/tmlSw0OgtM4AQ16srYAs4zSr6E97xjTklk
	j1+AAQ9eTAFNv/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C191413AA7;
	Fri, 20 Sep 2024 16:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id joc7L2Oj7Wa8cAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 16:31:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD509A08BD; Fri, 20 Sep 2024 18:31:19 +0200 (CEST)
Date: Fri, 20 Sep 2024 18:31:19 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 05/10] ext4: refactor ext4_punch_hole()
Message-ID: <20240920163119.dhfhrdrxa74t63kq@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-6-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 682CF33A49
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 14:29:20, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current ext4_punch_hole() is full of complex position calculation and
> stale error out tags. In order to clean up the code and make things
> clear, refactor it by a) simplify and rename variables, make the style
> the same as ext4_zero_range(), b) remove some unnecessary position
> calculations, always write back dirty data and drop cache from offset to
> end, instead of only write back aligned blocks, c) rename the three
> stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 114 ++++++++++++++++++++++--------------------------
>  1 file changed, 51 insertions(+), 63 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9343ce9f2b01..dfaf9e9d6ad8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3916,13 +3916,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  {
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
> -	ext4_lblk_t first_block, stop_block;
> +	ext4_lblk_t start_lblk, end_lblk;
>  	struct address_space *mapping = inode->i_mapping;
> -	loff_t first_block_offset, last_block_offset, max_length;
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	loff_t max_end = EXT4_SB(sb)->s_bitmap_maxbytes - sb->s_blocksize;
> +	loff_t end = offset + length;
> +	unsigned long blocksize = i_blocksize(inode);
>  	handle_t *handle;
>  	unsigned int credits;
> -	int ret = 0, ret2 = 0;
> +	int ret = 0;
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> @@ -3930,36 +3931,27 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
> -	 * If the hole extends beyond i_size, set the hole
> -	 * to end after the page that contains i_size
> +	 * If the hole extends beyond i_size, set the hole to end after
> +	 * the page that contains i_size, and also make sure that the hole
> +	 * within one block before last range.
>  	 */
> -	if (offset + length > inode->i_size) {
> -		length = inode->i_size +
> -		   PAGE_SIZE - (inode->i_size & (PAGE_SIZE - 1)) -
> -		   offset;
> -	}
> +	if (end > inode->i_size)
> +		end = round_up(inode->i_size, PAGE_SIZE);
> +	if (end > max_end)
> +		end = max_end;
> +	length = end - offset;
>  
>  	/*
> -	 * For punch hole the length + offset needs to be within one block
> -	 * before last range. Adjust the length if it goes beyond that limit.
> +	 * Attach jinode to inode for jbd2 if we do any zeroing of partial
> +	 * block.
>  	 */
> -	max_length = sbi->s_bitmap_maxbytes - inode->i_sb->s_blocksize;
> -	if (offset + length > max_length)
> -		length = max_length - offset;
> -
> -	if (offset & (sb->s_blocksize - 1) ||
> -	    (offset + length) & (sb->s_blocksize - 1)) {
> -		/*
> -		 * Attach jinode to inode for jbd2 if we do any zeroing of
> -		 * partial block
> -		 */
> +	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
>  		ret = ext4_inode_attach_jinode(inode);
>  		if (ret < 0)
> -			goto out_mutex;
> -
> +			goto out;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -3967,7 +3959,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -3977,23 +3969,17 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_dio;
> +		goto out_invalidate_lock;
>  
>  	/* Write out all dirty pages to avoid race conditions */
>  	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> -		ret = filemap_write_and_wait_range(mapping, offset,
> -						   offset + length - 1);
> +		ret = filemap_write_and_wait_range(mapping, offset, end - 1);
>  		if (ret)
> -			goto out_dio;
> +			goto out_invalidate_lock;
>  	}
>  
> -	first_block_offset = round_up(offset, sb->s_blocksize);
> -	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
> -
>  	/* Now release the pages and zero block aligned part of pages*/
> -	if (last_block_offset > first_block_offset)
> -		truncate_pagecache_range(inode, first_block_offset,
> -					 last_block_offset);
> +	truncate_pagecache_range(inode, offset, end - 1);
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		credits = ext4_writepage_trans_blocks(inode);
> @@ -4003,52 +3989,54 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
>  		ext4_std_error(sb, ret);
> -		goto out_dio;
> +		goto out_invalidate_lock;
>  	}
>  
> -	ret = ext4_zero_partial_blocks(handle, inode, offset,
> -				       length);
> +	ret = ext4_zero_partial_blocks(handle, inode, offset, length);
>  	if (ret)
> -		goto out_stop;
> -
> -	first_block = (offset + sb->s_blocksize - 1) >>
> -		EXT4_BLOCK_SIZE_BITS(sb);
> -	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
> +		goto out_handle;
>  
>  	/* If there are blocks to remove, do it */
> -	if (stop_block > first_block) {
> -		ext4_lblk_t hole_len = stop_block - first_block;
> +	start_lblk = round_up(offset, blocksize) >> inode->i_blkbits;
> +	end_lblk = end >> inode->i_blkbits;
> +
> +	if (end_lblk > start_lblk) {
> +		ext4_lblk_t hole_len = end_lblk - start_lblk;
>  
>  		down_write(&EXT4_I(inode)->i_data_sem);
>  		ext4_discard_preallocations(inode);
>  
> -		ext4_es_remove_extent(inode, first_block, hole_len);
> +		ext4_es_remove_extent(inode, start_lblk, hole_len);
>  
>  		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -			ret = ext4_ext_remove_space(inode, first_block,
> -						    stop_block - 1);
> +			ret = ext4_ext_remove_space(inode, start_lblk,
> +						    end_lblk - 1);
>  		else
> -			ret = ext4_ind_remove_space(handle, inode, first_block,
> -						    stop_block);
> +			ret = ext4_ind_remove_space(handle, inode, start_lblk,
> +						    end_lblk);
> +		if (ret) {
> +			up_write(&EXT4_I(inode)->i_data_sem);
> +			goto out_handle;
> +		}
>  
> -		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
> +		ext4_es_insert_extent(inode, start_lblk, hole_len, ~0,
>  				      EXTENT_STATUS_HOLE);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  	}
> -	ext4_fc_track_range(handle, inode, first_block, stop_block);
> +	ext4_fc_track_range(handle, inode, start_lblk, end_lblk);
> +
> +	ret = ext4_mark_inode_dirty(handle, inode);
> +	if (unlikely(ret))
> +		goto out_handle;
> +
> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
> -
> -	ret2 = ext4_mark_inode_dirty(handle, inode);
> -	if (unlikely(ret2))
> -		ret = ret2;
> -	if (ret >= 0)
> -		ext4_update_inode_fsync_trans(handle, inode, 1);
> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_dio:
> +out_invalidate_lock:
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

