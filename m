Return-Path: <linux-fsdevel+bounces-29827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F312E97E764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216B91C20EC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2126193434;
	Mon, 23 Sep 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uit34mVk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1EKH3RrJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uit34mVk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1EKH3RrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07342193084;
	Mon, 23 Sep 2024 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079466; cv=none; b=R0WTsCQWbPnnNvD1twKGbA2eVARzAMRmyjmP8BamZbAW1ET50yG8nt1sfq7INEFajknhOnVtLSY1zzUC9ptbQQ7w5ASQ6jj4Tvyj5egh2locWhMX9eh3MBfmUjm07cJ159WKCrNs9WjZ22enSr176OzQqNbcv604h9skegzx1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079466; c=relaxed/simple;
	bh=7QyszSUb6K4ZjwL63BE96f2q8ltB+m5AppKCDGiWfBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6sqmBWag0Dozt93ow+WV+aQ8+P0F9qtgM8SdorwTZWn2oyrNOQTLY9ecHI11QE/Q4McS/yDt3bUV7uRxgXJD6fDTeboXb3SvGMREfLipaKVO9Z2cpvMqmx61HejIMCvfUmVJYKw3LPSr7XPNqB+6OtzaGt/8CvN01XxKCDVGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uit34mVk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1EKH3RrJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uit34mVk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1EKH3RrJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03A571F7A5;
	Mon, 23 Sep 2024 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727079462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myJghHjusT5mrevIm8EsfN10qf3WOaV2N4/mw7njeKw=;
	b=uit34mVkPPHBnGludLipRVC5LgoxHhtMQNfwNYR2d+9m3Q66yovy8aHadAI6f1oj8jCntq
	KD+iUodXpTHtWvU/XwHQVK4iRTmNi4L55ULGnN51CBi9OhEokc9ya/GcJURP1RM4mf+AjU
	rrB1RkJuAL7mp5UTZbi0LGr3ltdZpyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727079462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myJghHjusT5mrevIm8EsfN10qf3WOaV2N4/mw7njeKw=;
	b=1EKH3RrJMEvcQwTmdc68wk/8OBoO20mjK2UvZU0e0y6WVCWy/S1Fgt9z34P+Xm3tBh9RNi
	4vzicqH53GgnQUAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uit34mVk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1EKH3RrJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727079462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myJghHjusT5mrevIm8EsfN10qf3WOaV2N4/mw7njeKw=;
	b=uit34mVkPPHBnGludLipRVC5LgoxHhtMQNfwNYR2d+9m3Q66yovy8aHadAI6f1oj8jCntq
	KD+iUodXpTHtWvU/XwHQVK4iRTmNi4L55ULGnN51CBi9OhEokc9ya/GcJURP1RM4mf+AjU
	rrB1RkJuAL7mp5UTZbi0LGr3ltdZpyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727079462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myJghHjusT5mrevIm8EsfN10qf3WOaV2N4/mw7njeKw=;
	b=1EKH3RrJMEvcQwTmdc68wk/8OBoO20mjK2UvZU0e0y6WVCWy/S1Fgt9z34P+Xm3tBh9RNi
	4vzicqH53GgnQUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF92613A64;
	Mon, 23 Sep 2024 08:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lNGMNiUk8WbnawAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 08:17:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D5FFA0ABF; Mon, 23 Sep 2024 10:17:41 +0200 (CEST)
Date: Mon, 23 Sep 2024 10:17:41 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 07/10] ext4: refactor ext4_insert_range()
Message-ID: <20240923081741.zbnwj5ybrvbwuj5m@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-8-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-8-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 03A571F7A5
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 04-09-24 14:29:22, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Simplify ext4_collapse_range() and make the code style the same as
> ext4_collapse_range(), refactor it by a) rename variables, b) drop
> redundant input parameters checking, move others to under i_rwsem,
> preparing for later refactor, c) rename the three stale error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 95 ++++++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 5c0b4d512531..a6c24c229cb4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5391,45 +5391,37 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	handle_t *handle;
>  	struct ext4_ext_path *path;
>  	struct ext4_extent *extent;
> -	ext4_lblk_t offset_lblk, len_lblk, ee_start_lblk = 0;
> +	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
>  	unsigned int credits, ee_len;
> -	int ret = 0, depth, split_flag = 0;
> -	loff_t ioffset;
> -
> -	/*
> -	 * We need to test this early because xfstests assumes that an
> -	 * insert range of (0, 1) will return EOPNOTSUPP if the file
> -	 * system does not support insert range.
> -	 */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		return -EOPNOTSUPP;
> -
> -	/* Insert range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> -		return -EINVAL;
> +	int ret, depth, split_flag = 0;
> +	loff_t start;
>  
>  	trace_ext4_insert_range(inode, offset, len);
>  
> -	offset_lblk = offset >> EXT4_BLOCK_SIZE_BITS(sb);
> -	len_lblk = len >> EXT4_BLOCK_SIZE_BITS(sb);
> -
>  	inode_lock(inode);
> +
>  	/* Currently just for extent based files */
>  	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
>  		ret = -EOPNOTSUPP;
> -		goto out_mutex;
> +		goto out;
>  	}
>  
> -	/* Check whether the maximum file size would be exceeded */
> -	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
> -		ret = -EFBIG;
> -		goto out_mutex;
> +	/* Insert range works only on fs cluster size aligned regions. */
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  
>  	/* Offset must be less than i_size */
>  	if (offset >= inode->i_size) {
>  		ret = -EINVAL;
> -		goto out_mutex;
> +		goto out;
> +	}
> +
> +	/* Check whether the maximum file size would be exceeded */
> +	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
> +		ret = -EFBIG;
> +		goto out;
>  	}
>  
>  	/* Wait for existing dio to complete */
> @@ -5437,7 +5429,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5447,25 +5439,24 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_mmap;
> +		goto out_invalidate_lock;
>  
>  	/*
>  	 * Need to round down to align start offset to page size boundary
>  	 * for page size > block size.
>  	 */
> -	ioffset = round_down(offset, PAGE_SIZE);
> +	start = round_down(offset, PAGE_SIZE);
>  	/* Write out all dirty pages */
> -	ret = filemap_write_and_wait_range(inode->i_mapping, ioffset,
> -			LLONG_MAX);
> +	ret = filemap_write_and_wait_range(mapping, start, LLONG_MAX);
>  	if (ret)
> -		goto out_mmap;
> -	truncate_pagecache(inode, ioffset);
> +		goto out_invalidate_lock;
> +	truncate_pagecache(inode, start);
>  
>  	credits = ext4_writepage_trans_blocks(inode);
>  	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
> -		goto out_mmap;
> +		goto out_invalidate_lock;
>  	}
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
> @@ -5474,15 +5465,18 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	EXT4_I(inode)->i_disksize += len;
>  	ret = ext4_mark_inode_dirty(handle, inode);
>  	if (ret)
> -		goto out_stop;
> +		goto out_handle;
> +
> +	start_lblk = offset >> inode->i_blkbits;
> +	len_lblk = len >> inode->i_blkbits;
>  
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	ext4_discard_preallocations(inode);
>  
> -	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
> +	path = ext4_find_extent(inode, start_lblk, NULL, 0);
>  	if (IS_ERR(path)) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
> -		goto out_stop;
> +		goto out_handle;
>  	}
>  
>  	depth = ext_depth(inode);
> @@ -5492,16 +5486,16 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		ee_len = ext4_ext_get_actual_len(extent);
>  
>  		/*
> -		 * If offset_lblk is not the starting block of extent, split
> -		 * the extent @offset_lblk
> +		 * If start_lblk is not the starting block of extent, split
> +		 * the extent @start_lblk
>  		 */
> -		if ((offset_lblk > ee_start_lblk) &&
> -				(offset_lblk < (ee_start_lblk + ee_len))) {
> +		if ((start_lblk > ee_start_lblk) &&
> +				(start_lblk < (ee_start_lblk + ee_len))) {
>  			if (ext4_ext_is_unwritten(extent))
>  				split_flag = EXT4_EXT_MARK_UNWRIT1 |
>  					EXT4_EXT_MARK_UNWRIT2;
>  			ret = ext4_split_extent_at(handle, inode, &path,
> -					offset_lblk, split_flag,
> +					start_lblk, split_flag,
>  					EXT4_EX_NOCACHE |
>  					EXT4_GET_BLOCKS_PRE_IO |
>  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
> @@ -5510,32 +5504,33 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		ext4_free_ext_path(path);
>  		if (ret < 0) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
> -			goto out_stop;
> +			goto out_handle;
>  		}
>  	} else {
>  		ext4_free_ext_path(path);
>  	}
>  
> -	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
> +	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
>  
>  	/*
> -	 * if offset_lblk lies in a hole which is at start of file, use
> +	 * if start_lblk lies in a hole which is at start of file, use
>  	 * ee_start_lblk to shift extents
>  	 */
>  	ret = ext4_ext_shift_extents(inode, handle,
> -		max(ee_start_lblk, offset_lblk), len_lblk, SHIFT_RIGHT);
> -
> +		max(ee_start_lblk, start_lblk), len_lblk, SHIFT_RIGHT);
>  	up_write(&EXT4_I(inode)->i_data_sem);
> +	if (ret)
> +		goto out_handle;
> +
> +	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	if (IS_SYNC(inode))
>  		ext4_handle_sync(handle);
> -	if (ret >= 0)
> -		ext4_update_inode_fsync_trans(handle, inode, 1);
>  
> -out_stop:
> +out_handle:
>  	ext4_journal_stop(handle);
> -out_mmap:
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

