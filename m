Return-Path: <linux-fsdevel+bounces-36427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430F9E3A21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 13:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD5B35DB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826541B6547;
	Wed,  4 Dec 2024 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YOPM27LM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HiIksDW9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGliZR8x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySWB1iAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23C1B414A;
	Wed,  4 Dec 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313933; cv=none; b=JJJpkeNGq37caeVgT12syB9X4MFFK8VdHDKwehym6XySfXR7PHdP7B4QwA/giz6MfVJYZ9zHNZDS8VEMbvft7oI9IpfggIAwP8qaI8x9Qq70PIRN/S+ut0J4QG2oqWPePgWjcjGnm/TWCUvaUfUyRMUsdFfjzNS5rFbUUeK2PH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313933; c=relaxed/simple;
	bh=n5ibmNeHATLwSIxnz5fTtLU1dkBdJBjDv3ZZIe3bFbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPzWyJhpaIjbqNgvuHtV8pZRsgLbTHmCuLQ8sHfFfNl4QFy9IAKMwID3o58YY5w+u5VCsJykrH53Pe2zgG4FqZLyeEjEIsZ1XuYRi7vSzGDQKd5fIxSNDmzTmxHcTJEPMcPLYGRyPThlqehgzuKH5oo3fHrbMLViNRIURipgiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YOPM27LM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HiIksDW9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGliZR8x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySWB1iAa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F7672115B;
	Wed,  4 Dec 2024 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EvK9kGpyqlJLIZfqsmrhUNVq5qGxQvvYQh+x/z0bEQc=;
	b=YOPM27LMbfdEX3+sbpa3rd8Kg69eSNeId+XWyn8a3VFtHfwyPLJqYNdgibXYndc4R06mZ/
	2UCXO4QrbsV+3FM/0OUed5JzZqaZ06jyc9lL/3T7YEi2UysXcySeqRTTDSBapM9Yhc5D2g
	HnyA4GrFyKRYZpmSCPdqC7QCw8RhvDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EvK9kGpyqlJLIZfqsmrhUNVq5qGxQvvYQh+x/z0bEQc=;
	b=HiIksDW9VIz8stUZyRCPdJHXxL0lxZVt69uU8JOdtypmOkmgIY0xW+Wof6Iqi6yVDT70jI
	u8Bw4y7xEZhETFDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733313928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EvK9kGpyqlJLIZfqsmrhUNVq5qGxQvvYQh+x/z0bEQc=;
	b=TGliZR8x837fpWRWb3KoeDsVL2B9ejk2/rxzy9Wm7HmvxSFGFcBhEsv1ZZXvM7zdGWZ6QT
	8pgR7R9A1V/c72NLyYgNxVIPYl7e/BHxS/BsOGcBHyJc7BonhE54Szx0R0kNAM6/MnXIJT
	InCc59B9UUOqP58MKWZqmUGpDtUB/IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733313928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EvK9kGpyqlJLIZfqsmrhUNVq5qGxQvvYQh+x/z0bEQc=;
	b=ySWB1iAaeKSXGwAip6zBBWATHBQcynM8gn0abJyFAlkD7kcZrSaXeif1c5fzO0IFnDuqRp
	rNgvPNOx749DmCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1AA01396E;
	Wed,  4 Dec 2024 12:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s32zOodFUGdxHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 12:05:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A24FCA0918; Wed,  4 Dec 2024 13:05:27 +0100 (CET)
Date: Wed, 4 Dec 2024 13:05:27 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
	zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 09/27] ext4: move out inode_lock into ext4_fallocate()
Message-ID: <20241204120527.jus6ymhsddxhlqjz@quack3>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
 <20241022111059.2566137-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022111059.2566137-10-yi.zhang@huaweicloud.com>
X-Spam-Level: 
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
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 22-10-24 19:10:40, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, all five sub-functions of ext4_fallocate() acquire the
> inode's i_rwsem at the beginning and release it before exiting. This
> process can be simplified by factoring out the management of i_rwsem
> into the ext4_fallocate() function.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Ah, nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

and please ignore my comments about renaming 'out' labels :).

								Honza

> ---
>  fs/ext4/extents.c | 90 +++++++++++++++--------------------------------
>  fs/ext4/inode.c   | 13 +++----
>  2 files changed, 33 insertions(+), 70 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2f727104f53d..a2db4e85790f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4573,23 +4573,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	int ret, flags, credits;
>  
>  	trace_ext4_zero_range(inode, offset, len, mode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
> -	inode_lock(inode);
> -
> -	/*
> -	 * Indirect files do not support unwritten extents
> -	 */
> -	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> +	/* Indirect files do not support unwritten extents */
> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
> +		return -EOPNOTSUPP;
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
>  	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
>  		new_size = end;
>  		ret = inode_newsize_ok(inode, new_size);
>  		if (ret)
> -			goto out;
> +			return ret;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -4597,7 +4592,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released
> @@ -4687,8 +4682,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> @@ -4702,12 +4695,11 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  	int ret;
>  
>  	trace_ext4_fallocate_enter(inode, offset, len, mode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	start_lblk = offset >> inode->i_blkbits;
>  	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
>  
> -	inode_lock(inode);
> -
>  	/* We only support preallocation for extent-based files only. */
>  	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
>  		ret = -EOPNOTSUPP;
> @@ -4739,7 +4731,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
>  					EXT4_I(inode)->i_sync_tid);
>  	}
>  out:
> -	inode_unlock(inode);
>  	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
>  	return ret;
>  }
> @@ -4774,9 +4765,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  
>  	inode_lock(inode);
>  	ret = ext4_convert_inline_data(inode);
> -	inode_unlock(inode);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = ext4_punch_hole(file, offset, len);
> @@ -4788,7 +4778,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		ret = ext4_zero_range(file, offset, len, mode);
>  	else
>  		ret = ext4_do_fallocate(file, offset, len, mode);
> -
> +out:
> +	inode_unlock(inode);
>  	return ret;
>  }
>  
> @@ -5298,36 +5289,27 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	int ret;
>  
>  	trace_ext4_collapse_range(inode, offset, len);
> -
> -	inode_lock(inode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	/* Currently just for extent based files */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		return -EOPNOTSUPP;
>  	/* Collapse range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> +		return -EINVAL;
>  	/*
>  	 * There is no need to overlap collapse range with EOF, in which case
>  	 * it is effectively a truncate operation
>  	 */
> -	if (end >= inode->i_size) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (end >= inode->i_size)
> +		return -EINVAL;
>  
>  	/* Wait for existing dio to complete */
>  	inode_dio_wait(inode);
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5402,8 +5384,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> @@ -5429,39 +5409,27 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	loff_t start;
>  
>  	trace_ext4_insert_range(inode, offset, len);
> -
> -	inode_lock(inode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	/* Currently just for extent based files */
> -	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> +	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> +		return -EOPNOTSUPP;
>  	/* Insert range works only on fs cluster size aligned regions. */
> -	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> +	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
> +		return -EINVAL;
>  	/* Offset must be less than i_size */
> -	if (offset >= inode->i_size) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
> +	if (offset >= inode->i_size)
> +		return -EINVAL;
>  	/* Check whether the maximum file size would be exceeded */
> -	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
> -		ret = -EFBIG;
> -		goto out;
> -	}
> +	if (len > inode->i_sb->s_maxbytes - inode->i_size)
> +		return -EFBIG;
>  
>  	/* Wait for existing dio to complete */
>  	inode_dio_wait(inode);
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -5562,8 +5530,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1d128333bd06..bea19cd6e676 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3962,15 +3962,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	unsigned long blocksize = i_blocksize(inode);
>  	handle_t *handle;
>  	unsigned int credits;
> -	int ret = 0;
> +	int ret;
>  
>  	trace_ext4_punch_hole(inode, offset, length, 0);
> -
> -	inode_lock(inode);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
>  
>  	/* No need to punch hole beyond i_size */
>  	if (offset >= inode->i_size)
> -		goto out;
> +		return 0;
>  
>  	/*
>  	 * If the hole extends beyond i_size, set the hole to end after
> @@ -3990,7 +3989,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (offset & (blocksize - 1) || end & (blocksize - 1)) {
>  		ret = ext4_inode_attach_jinode(inode);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  	}
>  
>  	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> @@ -3998,7 +3997,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	ret = file_modified(file);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * Prevent page faults from reinstantiating pages we have released from
> @@ -4082,8 +4081,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	ext4_journal_stop(handle);
>  out_invalidate_lock:
>  	filemap_invalidate_unlock(mapping);
> -out:
> -	inode_unlock(inode);
>  	return ret;
>  }
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

