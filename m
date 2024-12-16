Return-Path: <linux-fsdevel+bounces-37498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9349F3404
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0351881B3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A313B2A5;
	Mon, 16 Dec 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIg9t4hd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4PFMQ9YD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIg9t4hd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4PFMQ9YD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C980C0C;
	Mon, 16 Dec 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361672; cv=none; b=L69lSWS2Q0wDSJwdI1dfiJeG5WhxolCgMb11EQoCqZxlfcppHaM85JEJjxKVFbwtSA1llROJLJuI2XXY0nR1Vlr7fMtEAL8IwiUlwkqgU9KdViSIFQMkucv+OQsXQZZCWEufdR3GfrhESFdke9nZQu9SP05SdbhfLa6yuhKpwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361672; c=relaxed/simple;
	bh=/NBlow0EvoYA8m9kIaEaSxfBaKp1qovi3EzMyrS2i7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZHA+OgnDF6491y+T2bMQujVLGfKz7ZQFVX6+nGmeZDj4rpvLXF5QBjcpK6OeCLFrHgAnE3og+vsv2le/dCeZPMY3hi/kYEE3c6BhtC4u6yRKf//iLQb+9z7/giENBNxgfCYwjgVVV53Zxrh3ZlYag7pewOSetWQWJoj4ieGUb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIg9t4hd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4PFMQ9YD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIg9t4hd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4PFMQ9YD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E5FA2110B;
	Mon, 16 Dec 2024 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734361666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJv6d1i9PO1pRdNyHpHYej6ek7lSKnKm24AKkNOM/uM=;
	b=uIg9t4hdn/QoDjq2qFisPDKKt7x0NyITeIj6dwE2W5jOR1YgeX3wdmiPmNVxjHLk0t0KAd
	/0WOwcqaWkWu6Vg4YUB2hZdKRU0DwQRoOSDrK/NnBfr309nVy79+hotZh7SrJLbWwmy5Ot
	I4DWYPzBRGSy0U0uad9cBtwKQVE99JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734361666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJv6d1i9PO1pRdNyHpHYej6ek7lSKnKm24AKkNOM/uM=;
	b=4PFMQ9YDfA/dRe/lWSrURuhNun+OJWFEOd6iK26VGuxIFkHNmNEdBu5wpTUcfZwMo83BKR
	k7W1uMat+lBsPqDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uIg9t4hd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4PFMQ9YD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734361666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJv6d1i9PO1pRdNyHpHYej6ek7lSKnKm24AKkNOM/uM=;
	b=uIg9t4hdn/QoDjq2qFisPDKKt7x0NyITeIj6dwE2W5jOR1YgeX3wdmiPmNVxjHLk0t0KAd
	/0WOwcqaWkWu6Vg4YUB2hZdKRU0DwQRoOSDrK/NnBfr309nVy79+hotZh7SrJLbWwmy5Ot
	I4DWYPzBRGSy0U0uad9cBtwKQVE99JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734361666;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GJv6d1i9PO1pRdNyHpHYej6ek7lSKnKm24AKkNOM/uM=;
	b=4PFMQ9YDfA/dRe/lWSrURuhNun+OJWFEOd6iK26VGuxIFkHNmNEdBu5wpTUcfZwMo83BKR
	k7W1uMat+lBsPqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9160713418;
	Mon, 16 Dec 2024 15:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CTt8I0JCYGedDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Dec 2024 15:07:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 53638A0935; Mon, 16 Dec 2024 16:07:42 +0100 (CET)
Date: Mon, 16 Dec 2024 16:07:42 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 04/10] ext4: refactor ext4_punch_hole()
Message-ID: <20241216150742.hioqpy7t2vf3knri@quack3>
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216013915.3392419-5-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 9E5FA2110B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 16-12-24 09:39:09, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The current implementation of ext4_punch_hole() contains complex
> position calculations and stale error tags. To improve the code's
> clarity and maintainability, it is essential to clean up the code and
> improve its readability, this can be achieved by: a) simplifying and
> renaming variables; b) eliminating unnecessary position calculations;
> c) writing back all data in data=journal mode, and drop page cache from
> the original offset to the end, rather than using aligned blocks,
> d) renaming the stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |   2 +
>  fs/ext4/inode.c | 119 +++++++++++++++++++++---------------------------
>  2 files changed, 55 insertions(+), 66 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8843929b46ce..8be06d5f5b43 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -367,6 +367,8 @@ struct ext4_io_submit {
>  #define EXT4_MAX_BLOCKS(size, offset, blkbits) \
>  	((EXT4_BLOCK_ALIGN(size + offset, blkbits) >> blkbits) - (offset >> \
>  								  blkbits))
> +#define EXT4_B_TO_LBLK(inode, offset) \
> +	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
>  
>  /* Translate a block number to a cluster number */
>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index a5ba2b71d508..7720d3700b27 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4008,13 +4008,13 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
>  	handle_t *handle;
>  	unsigned int credits;
> -	int ret = 0, ret2 = 0;
> +	int ret = 0;
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
>  
> @@ -4022,36 +4022,27 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
> +	if (!IS_ALIGNED(offset | end, sb->s_blocksize)) {
>  		ret = ext4_inode_attach_jinode(inode);
>  		if (ret < 0)
> -			goto out_mutex;
> -
> +			goto out;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -4059,7 +4050,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -4069,22 +4060,16 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_dio;
> +		goto out_invalidate_lock;
>  
> -	first_block_offset = round_up(offset, sb->s_blocksize);
> -	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
> +	ret = ext4_update_disksize_before_punch(inode, offset, length);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
>  	/* Now release the pages and zero block aligned part of pages*/
> -	if (last_block_offset > first_block_offset) {
> -		ret = ext4_update_disksize_before_punch(inode, offset, length);
> -		if (ret)
> -			goto out_dio;
> -
> -		ret = ext4_truncate_page_cache_block_range(inode,
> -				first_block_offset, last_block_offset + 1);
> -		if (ret)
> -			goto out_dio;
> -	}
> +	ret = ext4_truncate_page_cache_block_range(inode, offset, end);
> +	if (ret)
> +		goto out_invalidate_lock;
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		credits = ext4_writepage_trans_blocks(inode);
> @@ -4094,52 +4079,54 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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
> +	start_lblk = EXT4_B_TO_LBLK(inode, offset);
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
>  				      EXTENT_STATUS_HOLE, 0);
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
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

