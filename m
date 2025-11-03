Return-Path: <linux-fsdevel+bounces-66721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87838C2A8C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B89814E86A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30A62DC33B;
	Mon,  3 Nov 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DMUHCcR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPloq+ei";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DMUHCcR6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPloq+ei"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C476298CD7
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158111; cv=none; b=A+6OQzXrCG1UVBz9v/Ql0hJt3CLJFc96nT2xbVEYKdxgtOJ4SCwRePgQkeSk2taF0ERTe6HVt07NRffUxUe3iJxZ2Ntc+zcDMEvWFZqL9Q7IETqW8dbJLMqAlEV8LS4eBsxomHgMnyLUo4M0GWBdwTMPyrog7Nt9gH/s/ifj8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158111; c=relaxed/simple;
	bh=EIDI+Bk6DD0QB1WJAzqCAB7kbHSUBYZTlyGguj7SCq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWDDyjzTtOvE2GyVe3+w3EEMcpc2y2BuRYrfsJatdH0ChBa15HbtRW/T0gJnmJd391jaN9Ad3kcvv/3uF60U9xqsZl2liafEkz6c9bPEZ/yqQchvTwYLEXUoqlV5gOEU8ICk0Kfsze3RCLMnyjOnzrvkgeuKroj48KMVUB8TbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DMUHCcR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPloq+ei; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DMUHCcR6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPloq+ei; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6EC71F79B;
	Mon,  3 Nov 2025 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762158107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P+YFfYJ7Oo7a+aU12KSiOjJezUYQkqsHZDirkxMulU=;
	b=DMUHCcR6PU0KZo8vatzMfsgP0j82Xe8C7r09DyOUFaX2fjzhrFNR4rapLwyrrJObZsCCyL
	S2AD7kVGZVhnqWppW2VjC196mhrW36sNM3sulFBAB9rNs1ELQQP5XXeKJCHi1OOJGKSlfM
	FJpE7fGndS4So+zhh1IBUipB5HcYsdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762158107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P+YFfYJ7Oo7a+aU12KSiOjJezUYQkqsHZDirkxMulU=;
	b=BPloq+eiULzzndArlKxR8wYpEuBzfMap5A+kCKfrJSza775RzS580B3BHrFnZ6E4h4MYut
	fx4ZlIk+1Hxhp/BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762158107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P+YFfYJ7Oo7a+aU12KSiOjJezUYQkqsHZDirkxMulU=;
	b=DMUHCcR6PU0KZo8vatzMfsgP0j82Xe8C7r09DyOUFaX2fjzhrFNR4rapLwyrrJObZsCCyL
	S2AD7kVGZVhnqWppW2VjC196mhrW36sNM3sulFBAB9rNs1ELQQP5XXeKJCHi1OOJGKSlfM
	FJpE7fGndS4So+zhh1IBUipB5HcYsdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762158107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P+YFfYJ7Oo7a+aU12KSiOjJezUYQkqsHZDirkxMulU=;
	b=BPloq+eiULzzndArlKxR8wYpEuBzfMap5A+kCKfrJSza775RzS580B3BHrFnZ6E4h4MYut
	fx4ZlIk+1Hxhp/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92C1A1364F;
	Mon,  3 Nov 2025 08:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wlLQIxtmCGmNaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:21:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00409A2A64; Mon,  3 Nov 2025 09:21:38 +0100 (CET)
Date: Mon, 3 Nov 2025 09:21:38 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 09/25] ext4: add EXT4_LBLK_TO_B macro for logical block
 to bytes conversion
Message-ID: <ejsz6cihhpg2qdxewjgq5j26dihf5m3twingzij3iow2igrilh@hvd5mvqw466d>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-10-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-10-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Sat 25-10-25 11:22:05, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    |  1 +
>  fs/ext4/extents.c |  2 +-
>  fs/ext4/inode.c   | 20 +++++++++-----------
>  fs/ext4/namei.c   |  8 +++-----
>  fs/ext4/verity.c  |  2 +-
>  5 files changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index bca6c3709673..9b236f620b3a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -367,6 +367,7 @@ struct ext4_io_submit {
>  								  blkbits))
>  #define EXT4_B_TO_LBLK(inode, offset) \
>  	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
> +#define EXT4_LBLK_TO_B(inode, lblk) ((loff_t)(lblk) << (inode)->i_blkbits)
>  
>  /* Translate a block number to a cluster number */
>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ca5499e9412b..da640c88b863 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4562,7 +4562,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
>  		 * allow a full retry cycle for any remaining allocations
>  		 */
>  		retries = 0;
> -		epos = (loff_t)(map.m_lblk + ret) << blkbits;
> +		epos = EXT4_LBLK_TO_B(inode, map.m_lblk + ret);
>  		inode_set_ctime_current(inode);
>  		if (new_size) {
>  			if (epos > new_size)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 889761ed51dd..73c1da90b604 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -825,9 +825,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
>  		    !ext4_is_quota_file(inode) &&
>  		    ext4_should_order_data(inode)) {
> -			loff_t start_byte =
> -				(loff_t)map->m_lblk << inode->i_blkbits;
> -			loff_t length = (loff_t)map->m_len << inode->i_blkbits;
> +			loff_t start_byte = EXT4_LBLK_TO_B(inode, map->m_lblk);
> +			loff_t length = EXT4_LBLK_TO_B(inode, map->m_len);
>  
>  			if (flags & EXT4_GET_BLOCKS_IO_SUBMIT)
>  				ret = ext4_jbd2_inode_add_wait(handle, inode,
> @@ -2225,7 +2224,6 @@ static int mpage_process_folio(struct mpage_da_data *mpd, struct folio *folio,
>  	ext4_lblk_t lblk = *m_lblk;
>  	ext4_fsblk_t pblock = *m_pblk;
>  	int err = 0;
> -	int blkbits = mpd->inode->i_blkbits;
>  	ssize_t io_end_size = 0;
>  	struct ext4_io_end_vec *io_end_vec = ext4_last_io_end_vec(io_end);
>  
> @@ -2251,7 +2249,8 @@ static int mpage_process_folio(struct mpage_da_data *mpd, struct folio *folio,
>  					err = PTR_ERR(io_end_vec);
>  					goto out;
>  				}
> -				io_end_vec->offset = (loff_t)mpd->map.m_lblk << blkbits;
> +				io_end_vec->offset = EXT4_LBLK_TO_B(mpd->inode,
> +								mpd->map.m_lblk);
>  			}
>  			*map_bh = true;
>  			goto out;
> @@ -2261,7 +2260,7 @@ static int mpage_process_folio(struct mpage_da_data *mpd, struct folio *folio,
>  			bh->b_blocknr = pblock++;
>  		}
>  		clear_buffer_unwritten(bh);
> -		io_end_size += (1 << blkbits);
> +		io_end_size += i_blocksize(mpd->inode);
>  	} while (lblk++, (bh = bh->b_this_page) != head);
>  
>  	io_end_vec->size += io_end_size;
> @@ -2463,7 +2462,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  	io_end_vec = ext4_alloc_io_end_vec(io_end);
>  	if (IS_ERR(io_end_vec))
>  		return PTR_ERR(io_end_vec);
> -	io_end_vec->offset = ((loff_t)map->m_lblk) << inode->i_blkbits;
> +	io_end_vec->offset = EXT4_LBLK_TO_B(inode, map->m_lblk);
>  	do {
>  		err = mpage_map_one_extent(handle, mpd);
>  		if (err < 0) {
> @@ -3503,8 +3502,8 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
>  	else
>  		iomap->bdev = inode->i_sb->s_bdev;
> -	iomap->offset = (u64) map->m_lblk << blkbits;
> -	iomap->length = (u64) map->m_len << blkbits;
> +	iomap->offset = EXT4_LBLK_TO_B(inode, map->m_lblk);
> +	iomap->length = EXT4_LBLK_TO_B(inode, map->m_len);
>  
>  	if ((map->m_flags & EXT4_MAP_MAPPED) &&
>  	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> @@ -3678,7 +3677,6 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  			    unsigned int flags)
>  {
>  	handle_t *handle;
> -	u8 blkbits = inode->i_blkbits;
>  	int ret, dio_credits, m_flags = 0, retries = 0;
>  	bool force_commit = false;
>  
> @@ -3737,7 +3735,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>  	 * i_disksize out to i_size. This could be beyond where direct I/O is
>  	 * happening and thus expose allocated blocks to direct I/O reads.
>  	 */
> -	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
> +	else if (EXT4_LBLK_TO_B(inode, map->m_lblk) >= i_size_read(inode))
>  		m_flags = EXT4_GET_BLOCKS_CREATE;
>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 2cd36f59c9e3..78cefb7cc9a7 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1076,7 +1076,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
>  	for (; de < top; de = ext4_next_entry(de, dir->i_sb->s_blocksize)) {
>  		if (ext4_check_dir_entry(dir, NULL, de, bh,
>  				bh->b_data, bh->b_size,
> -				(block<<EXT4_BLOCK_SIZE_BITS(dir->i_sb))
> +				EXT4_LBLK_TO_B(dir, block)
>  					 + ((char *)de - bh->b_data))) {
>  			/* silently ignore the rest of the block */
>  			break;
> @@ -1630,7 +1630,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
>  		}
>  		set_buffer_verified(bh);
>  		i = search_dirblock(bh, dir, fname,
> -			    block << EXT4_BLOCK_SIZE_BITS(sb), res_dir);
> +				    EXT4_LBLK_TO_B(dir, block), res_dir);
>  		if (i == 1) {
>  			EXT4_I(dir)->i_dir_start_lookup = block;
>  			ret = bh;
> @@ -1710,7 +1710,6 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
>  			struct ext4_filename *fname,
>  			struct ext4_dir_entry_2 **res_dir)
>  {
> -	struct super_block * sb = dir->i_sb;
>  	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
>  	struct buffer_head *bh;
>  	ext4_lblk_t block;
> @@ -1729,8 +1728,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
>  			goto errout;
>  
>  		retval = search_dirblock(bh, dir, fname,
> -					 block << EXT4_BLOCK_SIZE_BITS(sb),
> -					 res_dir);
> +					 EXT4_LBLK_TO_B(dir, block), res_dir);
>  		if (retval == 1)
>  			goto success;
>  		brelse(bh);
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index d9203228ce97..7a980a8059bd 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -302,7 +302,7 @@ static int ext4_get_verity_descriptor_location(struct inode *inode,
>  
>  	end_lblk = le32_to_cpu(last_extent->ee_block) +
>  		   ext4_ext_get_actual_len(last_extent);
> -	desc_size_pos = (u64)end_lblk << inode->i_blkbits;
> +	desc_size_pos = EXT4_LBLK_TO_B(inode, end_lblk);
>  	ext4_free_ext_path(path);
>  
>  	if (desc_size_pos < sizeof(desc_size_disk))
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

