Return-Path: <linux-fsdevel+bounces-29769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD3A97D866
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF122839E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29BD178383;
	Fri, 20 Sep 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A0oTSivR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ani3vDmJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A0oTSivR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ani3vDmJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215361E517;
	Fri, 20 Sep 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726850148; cv=none; b=a9g+bBGZLSCWQR/K0jRH3H6TlBFXPEXVMrxC1uTcP9Pu0/gfjU8lXyYMi7R65Op29Hpp3gPsMpxJHln/1Hc2PznxKggPwo4pNxaG2h0ly1d2NdgQNzHLE7FUZ3vpXw40keGVzG7bvniohHvlCT1uJkU/VKeMcGFg1i0I8OuKlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726850148; c=relaxed/simple;
	bh=U1K3hjNo+2BD1NjE9tQIDGJc9ZUuXNFJ65+wI/ahEHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaCzZpEFs2lPPmW1UQxK3oAIeKjEvTpQIr5TC3SN/1r5/EsoIqhKhwoRhwukKJLF2nzvgcq4BNIH4xFnYFfeNhWMovEgToDt25lFMhi19oPFw+vzpEenYu2lSndDuZ85v1mvvCx/SHmt2aGv8Owj1Lrp2LPP8NJGrCLxR+L6OME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A0oTSivR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ani3vDmJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A0oTSivR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ani3vDmJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E93E1FC81;
	Fri, 20 Sep 2024 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726850144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwyo6JrHL24YFWmzvjiKIz8myG6NFWRehZfGJj3iGDY=;
	b=A0oTSivRRZFrKqPlGBdT1Yxb5n7Dop78y7d0HjMj/qjXrFHFHmjQHyXnV48U/4Ly50eiH9
	CzlFRgQNILLscTO6Lny/Ap+tl/B9y1EXz4eJrkQSp5Kb5MTK6vFr91+ATfote51GxUHa1p
	3n5xUrjogTmSFJacFFqxamRg3EpI/ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726850144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwyo6JrHL24YFWmzvjiKIz8myG6NFWRehZfGJj3iGDY=;
	b=ani3vDmJ9Bu+0wHng6zC3TgUG5sVMyqRpliCpZ5Y8mJ3AuTFGpwSdb/BWLlV+QE1l89KFH
	7aMsQ9IC7wyqgpAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726850144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwyo6JrHL24YFWmzvjiKIz8myG6NFWRehZfGJj3iGDY=;
	b=A0oTSivRRZFrKqPlGBdT1Yxb5n7Dop78y7d0HjMj/qjXrFHFHmjQHyXnV48U/4Ly50eiH9
	CzlFRgQNILLscTO6Lny/Ap+tl/B9y1EXz4eJrkQSp5Kb5MTK6vFr91+ATfote51GxUHa1p
	3n5xUrjogTmSFJacFFqxamRg3EpI/ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726850144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwyo6JrHL24YFWmzvjiKIz8myG6NFWRehZfGJj3iGDY=;
	b=ani3vDmJ9Bu+0wHng6zC3TgUG5sVMyqRpliCpZ5Y8mJ3AuTFGpwSdb/BWLlV+QE1l89KFH
	7aMsQ9IC7wyqgpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3154D13AA7;
	Fri, 20 Sep 2024 16:35:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xcwLDF2k7Wa4cQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 16:35:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 16BF1A08BD; Fri, 20 Sep 2024 18:35:08 +0200 (CEST)
Date: Fri, 20 Sep 2024 18:35:08 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 06/10] ext4: refactor ext4_collapse_range()
Message-ID: <20240920163508.7467lwwu6xp3rg2d@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-7-yi.zhang@huaweicloud.com>
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

On Wed 04-09-24 14:29:21, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Simplify ext4_collapse_range() and make the code style the same as
> ext4_zero_range() and ext4_punch_hole(), refactor it by a) rename
> variables, b) drop redundant input parameters checking, move others to
> under i_rwsem, preparing for later refactor, c) rename the three stale
> error tags.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 80 +++++++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2fb0c2e303c7..5c0b4d512531 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5265,43 +5265,35 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	struct inode *inode = file_inode(file);
>  	struct super_block *sb = inode->i_sb;
>  	struct address_space *mapping = inode->i_mapping;
> -	ext4_lblk_t punch_start, punch_stop;
> +	ext4_lblk_t start_lblk, end_lblk;
>  	handle_t *handle;
>  	unsigned int credits;
> -	loff_t new_size, ioffset;
> +	loff_t start, new_size;
>  	int ret;
>  
> -	/*
> -	 * We need to test this early because xfstests assumes that a
> -	 * collapse range of (0, 1) will return EOPNOTSUPP if the file
> -	 * system does not support collapse range.
> -	 */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		return -EOPNOTSUPP;
> +	trace_ext4_collapse_range(inode, offset, len);
>  
> -	/* Collapse range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> -		return -EINVAL;
> +	inode_lock(inode);
>  
> -	trace_ext4_collapse_range(inode, offset, len);
> +	/* Currently just for extent based files */
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
>  
> -	punch_start = offset >> EXT4_BLOCK_SIZE_BITS(sb);
> -	punch_stop = (offset + len) >> EXT4_BLOCK_SIZE_BITS(sb);
> +	/* Collapse range works only on fs cluster size aligned regions. */
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>  
> -	inode_lock(inode);
>  	/*
>  	 * There is no need to overlap collapse range with EOF, in which case
>  	 * it is effectively a truncate operation
>  	 */
>  	if (offset + len >= inode->i_size) {
>  		ret = -EINVAL;
> -		goto out_mutex;
> -	}
> -
> -	/* Currently just for extent based files */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		ret = -EOPNOTSUPP;
> -		goto out_mutex;
> +		goto out;
>  	}
>  
>  	/* Wait for existing dio to complete */
> @@ -5309,7 +5301,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out_mutex;
> +		goto out;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5319,43 +5311,46 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  
>  	ret = ext4_break_layouts(inode);
>  	if (ret)
> -		goto out_mmap;
> +		goto out_invalidate_lock;
>  
>  	/*
>  	 * Need to round down offset to be aligned with page size boundary
>  	 * for page size > block size.
>  	 */
> -	ioffset = round_down(offset, PAGE_SIZE);
> +	start = round_down(offset, PAGE_SIZE);
>  	/* Write out all dirty pages */
> -	ret = filemap_write_and_wait_range(mapping, ioffset, LLONG_MAX);
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
> +	start_lblk = offset >> inode->i_blkbits;
> +	end_lblk = (offset + len) >> inode->i_blkbits;
> +
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	ext4_discard_preallocations(inode);
> -	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
> +	ext4_es_remove_extent(inode, start_lblk, EXT_MAX_BLOCKS - start_lblk);
>  
> -	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
> +	ret = ext4_ext_remove_space(inode, start_lblk, end_lblk - 1);
>  	if (ret) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
> -		goto out_stop;
> +		goto out_handle;
>  	}
>  	ext4_discard_preallocations(inode);
>  
> -	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
> -				     punch_stop - punch_start, SHIFT_LEFT);
> +	ret = ext4_ext_shift_extents(inode, handle, end_lblk,
> +				     end_lblk - start_lblk, SHIFT_LEFT);
>  	if (ret) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
> -		goto out_stop;
> +		goto out_handle;
>  	}
>  
>  	new_size = inode->i_size - len;
> @@ -5363,16 +5358,19 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	EXT4_I(inode)->i_disksize = new_size;
>  
>  	up_write(&EXT4_I(inode)->i_data_sem);
> -	if (IS_SYNC(inode))
> -		ext4_handle_sync(handle);
>  	ret = ext4_mark_inode_dirty(handle, inode);
> +	if (ret)
> +		goto out_handle;
> +
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
> +	if (IS_SYNC(inode))
> +		ext4_handle_sync(handle);
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

