Return-Path: <linux-fsdevel+bounces-29828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912B197E770
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B751C21185
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AC5193436;
	Mon, 23 Sep 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvl3F49c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGY8kuZY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvl3F49c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGY8kuZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDC192D7E;
	Mon, 23 Sep 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079657; cv=none; b=pfNVrskN8spXCpPiEOAe98YCic6crIut3WMLvdLbiAikDVlwDx1AILvM5flhalUdTFNbAac7+JV74iYdcXBt1h7mrkcacCG2lJziYZ7L6Aa+t/iNa7QqjHh85l3jlRK3I3qt/ZHblAsbRsV1bs4nWeaf24TKhVz7UCLoNTWFqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079657; c=relaxed/simple;
	bh=GqHq2PDW3f8bGIaCfl0g+Yv3qTbUNV94rofgjMwHWj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkHe+yiP28qynfY3fdB4qeg/3X4g3IVvG6UBwgxe5dVaeqbkp6f9MCCzU4gjnllemc2YtnVpd5BQEEmzvmHGYpnnZWnHcz6Xpjp3uev0nPdxqUlKqpHaY3KqCLSdEXiQzt9d8QhDTes8HRTFG9pmNP36dHVbZxloT+Is4YiM8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvl3F49c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FGY8kuZY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvl3F49c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FGY8kuZY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48E631F7A5;
	Mon, 23 Sep 2024 08:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727079653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KZpjNHDu94Ylr2t2PZPijpnyCtUTNnKe6nggAve46g=;
	b=zvl3F49cGUAoQkFgorRSWCoGU4XdFTA0jXApEAAdb4nKhSp8NN7R4IQHH5H2LEjAHcgmKn
	ysmCd15tupnWluc85DxpzEZJDpqnNHh+U6sb3BvHkDphAm/Za4bL13/UwaLw4cH3ZH1n62
	5/5sYmhXNOtf6IH2oqxXur8JuWGKuro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727079653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KZpjNHDu94Ylr2t2PZPijpnyCtUTNnKe6nggAve46g=;
	b=FGY8kuZYJkKL0PJM023q/LvRxjJSWiDWsvec6cWV7BeBaiw4unKNleXxfC+ODjPFczaXJu
	Fg25vh6kNYqoZeDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727079653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KZpjNHDu94Ylr2t2PZPijpnyCtUTNnKe6nggAve46g=;
	b=zvl3F49cGUAoQkFgorRSWCoGU4XdFTA0jXApEAAdb4nKhSp8NN7R4IQHH5H2LEjAHcgmKn
	ysmCd15tupnWluc85DxpzEZJDpqnNHh+U6sb3BvHkDphAm/Za4bL13/UwaLw4cH3ZH1n62
	5/5sYmhXNOtf6IH2oqxXur8JuWGKuro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727079653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KZpjNHDu94Ylr2t2PZPijpnyCtUTNnKe6nggAve46g=;
	b=FGY8kuZYJkKL0PJM023q/LvRxjJSWiDWsvec6cWV7BeBaiw4unKNleXxfC+ODjPFczaXJu
	Fg25vh6kNYqoZeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C0C313A64;
	Mon, 23 Sep 2024 08:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hv62DuUk8Wa8bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 08:20:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DCC00A0ABF; Mon, 23 Sep 2024 10:20:52 +0200 (CEST)
Date: Mon, 23 Sep 2024 10:20:52 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 08/10] ext4: factor out ext4_do_fallocate()
Message-ID: <20240923082052.s7b7k23iybukujij@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904062925.716856-9-yi.zhang@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 04-09-24 14:29:23, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now the real job of normal fallocate are open code in ext4_fallocate(),
> factor out a new helper ext4_do_fallocate() to do the real job, like
> others functions (e.g. ext4_zero_range()) in ext4_fallocate() do, this
> can make the code more clear, no functional changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 125 ++++++++++++++++++++++------------------------
>  1 file changed, 60 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a6c24c229cb4..06b2c1190181 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4662,6 +4662,58 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	return ret;
>  }
>  
> +static long ext4_do_fallocate(struct file *file, loff_t offset,
> +			      loff_t len, int mode)
> +{
> +	struct inode *inode = file_inode(file);
> +	loff_t end = offset + len;
> +	loff_t new_size = 0;
> +	ext4_lblk_t start_lblk, len_lblk;
> +	int ret;
> +
> +	trace_ext4_fallocate_enter(inode, offset, len, mode);
> +
> +	start_lblk = offset >> inode->i_blkbits;
> +	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
> +
> +	inode_lock(inode);
> +
> +	/* We only support preallocation for extent-based files only. */
> +	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> +	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
> +		new_size = end;
> +		ret = inode_newsize_ok(inode, new_size);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> +	inode_dio_wait(inode);
> +
> +	ret = file_modified(file);
> +	if (ret)
> +		goto out;
> +
> +	ret = ext4_alloc_file_blocks(file, start_lblk, len_lblk, new_size,
> +				     EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT);
> +	if (ret)
> +		goto out;
> +
> +	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> +		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> +					EXT4_I(inode)->i_sync_tid);
> +	}
> +out:
> +	inode_unlock(inode);
> +	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
> +	return ret;
> +}
> +
>  /*
>   * preallocate space for a file. This implements ext4's fallocate file
>   * operation, which gets called from sys_fallocate system call.
> @@ -4672,12 +4724,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  {
>  	struct inode *inode = file_inode(file);
> -	loff_t new_size = 0;
> -	unsigned int max_blocks;
> -	int ret = 0;
> -	int flags;
> -	ext4_lblk_t lblk;
> -	unsigned int blkbits = inode->i_blkbits;
> +	int ret;
>  
>  	/*
>  	 * Encrypted inodes can't handle collapse range or insert
> @@ -4699,71 +4746,19 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	ret = ext4_convert_inline_data(inode);
>  	inode_unlock(inode);
>  	if (ret)
> -		goto exit;
> +		return ret;
>  
> -	if (mode & FALLOC_FL_PUNCH_HOLE) {
> +	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret = ext4_punch_hole(file, offset, len);
> -		goto exit;
> -	}
> -
> -	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
> +	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
>  		ret = ext4_collapse_range(file, offset, len);
> -		goto exit;
> -	}
> -
> -	if (mode & FALLOC_FL_INSERT_RANGE) {
> +	else if (mode & FALLOC_FL_INSERT_RANGE)
>  		ret = ext4_insert_range(file, offset, len);
> -		goto exit;
> -	}
> -
> -	if (mode & FALLOC_FL_ZERO_RANGE) {
> +	else if (mode & FALLOC_FL_ZERO_RANGE)
>  		ret = ext4_zero_range(file, offset, len, mode);
> -		goto exit;
> -	}
> -	trace_ext4_fallocate_enter(inode, offset, len, mode);
> -	lblk = offset >> blkbits;
> -
> -	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
> -	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
> -
> -	inode_lock(inode);
> -
> -	/*
> -	 * We only support preallocation for extent-based files only
> -	 */
> -	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
> -		ret = -EOPNOTSUPP;
> -		goto out;
> -	}
> -
> -	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> -	    (offset + len > inode->i_size ||
> -	     offset + len > EXT4_I(inode)->i_disksize)) {
> -		new_size = offset + len;
> -		ret = inode_newsize_ok(inode, new_size);
> -		if (ret)
> -			goto out;
> -	}
> -
> -	/* Wait all existing dio workers, newcomers will block on i_rwsem */
> -	inode_dio_wait(inode);
> -
> -	ret = file_modified(file);
> -	if (ret)
> -		goto out;
> -
> -	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
> -	if (ret)
> -		goto out;
> +	else
> +		ret = ext4_do_fallocate(file, offset, len, mode);
>  
> -	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
> -		ret = ext4_fc_commit(EXT4_SB(inode->i_sb)->s_journal,
> -					EXT4_I(inode)->i_sync_tid);
> -	}
> -out:
> -	inode_unlock(inode);
> -	trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> -exit:
>  	return ret;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

