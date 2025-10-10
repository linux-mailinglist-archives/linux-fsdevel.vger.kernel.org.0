Return-Path: <linux-fsdevel+bounces-63759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C17BCD4F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A234202EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFD72F3C03;
	Fri, 10 Oct 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1HwnyDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/NEAfJdT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1HwnyDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/NEAfJdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357B2F25EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103686; cv=none; b=L6yKATaj3T3/SVmXcp4OO2Vs1JpdmCbEnC+2kX60JDjBx+LP7ElXP46O3BEg6fVpOtqMxfKySdPaGWR0yKVBTmVVObirxEU6YGsj1Q5dYoxW/neJCaPzNFOz046602UP7F5HGRPXiRlwOfgv6rPS9ogOSe0nIZBT8XKTxRg23GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103686; c=relaxed/simple;
	bh=An1oHMgrkJs38BVTD+HoLE2SPDnwgZ3L+6I3yXO0PCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpD45bK8AF6M8CvAr/PLm0t9gqK02cIGjrH7Uy9ucMu28/zfmlKfYRHM7AA0Uwb7nhJayZkPGi5IRM1NS166t33VYKBe4pgT6Yq5Fup6COu6awZd8dD9lgDmP2hywe9YU8R7Ac2jFAELWFET3ZFOvjr6jsmVz5OHRz5gGOCHHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1HwnyDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/NEAfJdT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1HwnyDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/NEAfJdT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 369CB21CFF;
	Fri, 10 Oct 2025 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760103681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6QY0pRXyeAhuWwZPoWn0eD56DMZpR9a5PP5EI+dP7Q=;
	b=W1HwnyDt6z9cLtD9xdm2pa3xbc1aI2GQaKNpzbKJp1+L7GgSmV9yVXJc+tjrcKpuZ+NaKY
	6miifK5GM9dtFleWIAxbktlXL0fL1cGFeAJXcuAgWHXl/u1KVowr3KEjRkOzcMFHhHmo3m
	2LIpO9i4Bx6jvjL6ucIoqPFCTpj2z+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760103681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6QY0pRXyeAhuWwZPoWn0eD56DMZpR9a5PP5EI+dP7Q=;
	b=/NEAfJdT/wy1FmDyOx71KoxdqReq5m59SFTwIYEHNUty+fBC/faolk497ZZHcl+7P9dr15
	XBFhNeXJy4PnevCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W1HwnyDt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/NEAfJdT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760103681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6QY0pRXyeAhuWwZPoWn0eD56DMZpR9a5PP5EI+dP7Q=;
	b=W1HwnyDt6z9cLtD9xdm2pa3xbc1aI2GQaKNpzbKJp1+L7GgSmV9yVXJc+tjrcKpuZ+NaKY
	6miifK5GM9dtFleWIAxbktlXL0fL1cGFeAJXcuAgWHXl/u1KVowr3KEjRkOzcMFHhHmo3m
	2LIpO9i4Bx6jvjL6ucIoqPFCTpj2z+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760103681;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B6QY0pRXyeAhuWwZPoWn0eD56DMZpR9a5PP5EI+dP7Q=;
	b=/NEAfJdT/wy1FmDyOx71KoxdqReq5m59SFTwIYEHNUty+fBC/faolk497ZZHcl+7P9dr15
	XBFhNeXJy4PnevCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ED9F1375D;
	Fri, 10 Oct 2025 13:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4nmdAwEN6WjlaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 13:41:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32A9AA0A58; Fri, 10 Oct 2025 15:41:20 +0200 (CEST)
Date: Fri, 10 Oct 2025 15:41:20 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 10/12] ext4: switch to using the new extent movement
 method
Message-ID: <aebi7rs34c2gcsgenuond2v7ebbkw737ypugxbrmozd6aaiik5@w4pa3v6fprlu>
References: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
 <20251010103326.3353700-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010103326.3353700-11-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 369CB21CFF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 10-10-25 18:33:24, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now that we have mext_move_extent(), we can switch to this new interface
> and deprecate move_extent_per_page(). First, after acquiring the
> i_rwsem, we can directly use ext4_map_blocks() to obtain a contiguous
> extent from the original inode as the extent to be moved. It can and
> it's safe to get mapping information from the extent status tree without
> needing to access the ondisk extent tree, because ext4_move_extent()
> will check the sequence cookie under the folio lock. Then, after
> populating the mext_data structure, we call ext4_move_extent() to move
> the extent. Finally, the length of the extent will be adjusted in
> mext.orig_map.m_len and the actual length moved is returned through
> m_len.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 395 ++++++------------------------------------
>  1 file changed, 51 insertions(+), 344 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index aa243be36200..85f5ae53a2d6 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -20,29 +20,6 @@ struct mext_data {
>  	ext4_lblk_t donor_lblk;		/* Start block of the donor file */
>  };
>  
> -/**
> - * get_ext_path() - Find an extent path for designated logical block number.
> - * @inode:	inode to be searched
> - * @lblock:	logical block number to find an extent path
> - * @path:	pointer to an extent path
> - *
> - * ext4_find_extent wrapper. Return an extent path pointer on success,
> - * or an error pointer on failure.
> - */
> -static inline struct ext4_ext_path *
> -get_ext_path(struct inode *inode, ext4_lblk_t lblock,
> -	     struct ext4_ext_path *path)
> -{
> -	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
> -	if (IS_ERR(path))
> -		return path;
> -	if (path[ext_depth(inode)].p_ext == NULL) {
> -		ext4_free_ext_path(path);
> -		return ERR_PTR(-ENODATA);
> -	}
> -	return path;
> -}
> -
>  /**
>   * ext4_double_down_write_data_sem() - write lock two inodes's i_data_sem
>   * @first: inode to be locked
> @@ -59,7 +36,6 @@ ext4_double_down_write_data_sem(struct inode *first, struct inode *second)
>  	} else {
>  		down_write(&EXT4_I(second)->i_data_sem);
>  		down_write_nested(&EXT4_I(first)->i_data_sem, I_DATA_SEM_OTHER);
> -
>  	}
>  }
>  
> @@ -78,42 +54,6 @@ ext4_double_up_write_data_sem(struct inode *orig_inode,
>  	up_write(&EXT4_I(donor_inode)->i_data_sem);
>  }
>  
> -/**
> - * mext_check_coverage - Check that all extents in range has the same type
> - *
> - * @inode:		inode in question
> - * @from:		block offset of inode
> - * @count:		block count to be checked
> - * @unwritten:		extents expected to be unwritten
> - * @err:		pointer to save error value
> - *
> - * Return 1 if all extents in range has expected type, and zero otherwise.
> - */
> -static int
> -mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
> -		    int unwritten, int *err)
> -{
> -	struct ext4_ext_path *path = NULL;
> -	struct ext4_extent *ext;
> -	int ret = 0;
> -	ext4_lblk_t last = from + count;
> -	while (from < last) {
> -		path = get_ext_path(inode, from, path);
> -		if (IS_ERR(path)) {
> -			*err = PTR_ERR(path);
> -			return ret;
> -		}
> -		ext = path[ext_depth(inode)].p_ext;
> -		if (unwritten != ext4_ext_is_unwritten(ext))
> -			goto out;
> -		from += ext4_ext_get_actual_len(ext);
> -	}
> -	ret = 1;
> -out:
> -	ext4_free_ext_path(path);
> -	return ret;
> -}
> -
>  /**
>   * mext_folio_double_lock - Grab and lock folio on both @inode1 and @inode2
>   *
> @@ -363,7 +303,7 @@ static int mext_folio_mkwrite(struct inode *inode, struct folio *folio,
>   * the replaced block count through m_len. Return 0 on success, and an error
>   * code otherwise.
>   */
> -static __used int mext_move_extent(struct mext_data *mext, u64 *m_len)
> +static int mext_move_extent(struct mext_data *mext, u64 *m_len)
>  {
>  	struct inode *orig_inode = mext->orig_inode;
>  	struct inode *donor_inode = mext->donor_inode;
> @@ -456,210 +396,6 @@ static __used int mext_move_extent(struct mext_data *mext, u64 *m_len)
>  	goto unlock;
>  }
>  
> -/**
> - * move_extent_per_page - Move extent data per page
> - *
> - * @o_filp:			file structure of original file
> - * @donor_inode:		donor inode
> - * @orig_page_offset:		page index on original file
> - * @donor_page_offset:		page index on donor file
> - * @data_offset_in_page:	block index where data swapping starts
> - * @block_len_in_page:		the number of blocks to be swapped
> - * @unwritten:			orig extent is unwritten or not
> - * @err:			pointer to save return value
> - *
> - * Save the data in original inode blocks and replace original inode extents
> - * with donor inode extents by calling ext4_swap_extents().
> - * Finally, write out the saved data in new original inode blocks. Return
> - * replaced block count.
> - */
> -static int
> -move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
> -		     pgoff_t orig_page_offset, pgoff_t donor_page_offset,
> -		     int data_offset_in_page,
> -		     int block_len_in_page, int unwritten, int *err)
> -{
> -	struct inode *orig_inode = file_inode(o_filp);
> -	struct folio *folio[2] = {NULL, NULL};
> -	handle_t *handle;
> -	ext4_lblk_t orig_blk_offset, donor_blk_offset;
> -	unsigned long blocksize = orig_inode->i_sb->s_blocksize;
> -	unsigned int tmp_data_size, data_size, replaced_size;
> -	int i, err2, jblocks, retries = 0;
> -	int replaced_count = 0;
> -	int from;
> -	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
> -	struct super_block *sb = orig_inode->i_sb;
> -	struct buffer_head *bh = NULL;
> -
> -	/*
> -	 * It needs twice the amount of ordinary journal buffers because
> -	 * inode and donor_inode may change each different metadata blocks.
> -	 */
> -again:
> -	*err = 0;
> -	jblocks = ext4_meta_trans_blocks(orig_inode, block_len_in_page,
> -					 block_len_in_page) * 2;
> -	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, jblocks);
> -	if (IS_ERR(handle)) {
> -		*err = PTR_ERR(handle);
> -		return 0;
> -	}
> -
> -	orig_blk_offset = orig_page_offset * blocks_per_page +
> -		data_offset_in_page;
> -
> -	donor_blk_offset = donor_page_offset * blocks_per_page +
> -		data_offset_in_page;
> -
> -	/* Calculate data_size */
> -	if ((orig_blk_offset + block_len_in_page - 1) ==
> -	    ((orig_inode->i_size - 1) >> orig_inode->i_blkbits)) {
> -		/* Replace the last block */
> -		tmp_data_size = orig_inode->i_size & (blocksize - 1);
> -		/*
> -		 * If data_size equal zero, it shows data_size is multiples of
> -		 * blocksize. So we set appropriate value.
> -		 */
> -		if (tmp_data_size == 0)
> -			tmp_data_size = blocksize;
> -
> -		data_size = tmp_data_size +
> -			((block_len_in_page - 1) << orig_inode->i_blkbits);
> -	} else
> -		data_size = block_len_in_page << orig_inode->i_blkbits;
> -
> -	replaced_size = data_size;
> -
> -	*err = mext_folio_double_lock(orig_inode, donor_inode, orig_page_offset,
> -				     donor_page_offset, folio);
> -	if (unlikely(*err < 0))
> -		goto stop_journal;
> -	/*
> -	 * If orig extent was unwritten it can become initialized
> -	 * at any time after i_data_sem was dropped, in order to
> -	 * serialize with delalloc we have recheck extent while we
> -	 * hold page's lock, if it is still the case data copy is not
> -	 * necessary, just swap data blocks between orig and donor.
> -	 */
> -	if (unwritten) {
> -		ext4_double_down_write_data_sem(orig_inode, donor_inode);
> -		/* If any of extents in range became initialized we have to
> -		 * fallback to data copying */
> -		unwritten = mext_check_coverage(orig_inode, orig_blk_offset,
> -						block_len_in_page, 1, err);
> -		if (*err)
> -			goto drop_data_sem;
> -
> -		unwritten &= mext_check_coverage(donor_inode, donor_blk_offset,
> -						 block_len_in_page, 1, err);
> -		if (*err)
> -			goto drop_data_sem;
> -
> -		if (!unwritten) {
> -			ext4_double_up_write_data_sem(orig_inode, donor_inode);
> -			goto data_copy;
> -		}
> -		if (!filemap_release_folio(folio[0], 0) ||
> -		    !filemap_release_folio(folio[1], 0)) {
> -			*err = -EBUSY;
> -			goto drop_data_sem;
> -		}
> -		replaced_count = ext4_swap_extents(handle, orig_inode,
> -						   donor_inode, orig_blk_offset,
> -						   donor_blk_offset,
> -						   block_len_in_page, 1, err);
> -	drop_data_sem:
> -		ext4_double_up_write_data_sem(orig_inode, donor_inode);
> -		goto unlock_folios;
> -	}
> -data_copy:
> -	from = offset_in_folio(folio[0],
> -			       orig_blk_offset << orig_inode->i_blkbits);
> -	*err = mext_folio_mkuptodate(folio[0], from, from + replaced_size);
> -	if (*err)
> -		goto unlock_folios;
> -
> -	/* At this point all buffers in range are uptodate, old mapping layout
> -	 * is no longer required, try to drop it now. */
> -	if (!filemap_release_folio(folio[0], 0) ||
> -	    !filemap_release_folio(folio[1], 0)) {
> -		*err = -EBUSY;
> -		goto unlock_folios;
> -	}
> -	ext4_double_down_write_data_sem(orig_inode, donor_inode);
> -	replaced_count = ext4_swap_extents(handle, orig_inode, donor_inode,
> -					       orig_blk_offset, donor_blk_offset,
> -					   block_len_in_page, 1, err);
> -	ext4_double_up_write_data_sem(orig_inode, donor_inode);
> -	if (*err) {
> -		if (replaced_count) {
> -			block_len_in_page = replaced_count;
> -			replaced_size =
> -				block_len_in_page << orig_inode->i_blkbits;
> -		} else
> -			goto unlock_folios;
> -	}
> -	/* Perform all necessary steps similar write_begin()/write_end()
> -	 * but keeping in mind that i_size will not change */
> -	bh = folio_buffers(folio[0]);
> -	if (!bh)
> -		bh = create_empty_buffers(folio[0],
> -				1 << orig_inode->i_blkbits, 0);
> -	for (i = 0; i < from >> orig_inode->i_blkbits; i++)
> -		bh = bh->b_this_page;
> -	for (i = 0; i < block_len_in_page; i++) {
> -		*err = ext4_get_block(orig_inode, orig_blk_offset + i, bh, 0);
> -		if (*err < 0)
> -			goto repair_branches;
> -		bh = bh->b_this_page;
> -	}
> -
> -	block_commit_write(folio[0], from, from + replaced_size);
> -
> -	/* Even in case of data=writeback it is reasonable to pin
> -	 * inode to transaction, to prevent unexpected data loss */
> -	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
> -			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
> -
> -unlock_folios:
> -	folio_unlock(folio[0]);
> -	folio_put(folio[0]);
> -	folio_unlock(folio[1]);
> -	folio_put(folio[1]);
> -stop_journal:
> -	ext4_journal_stop(handle);
> -	if (*err == -ENOSPC &&
> -	    ext4_should_retry_alloc(sb, &retries))
> -		goto again;
> -	/* Buffer was busy because probably is pinned to journal transaction,
> -	 * force transaction commit may help to free it. */
> -	if (*err == -EBUSY && retries++ < 4 && EXT4_SB(sb)->s_journal &&
> -	    jbd2_journal_force_commit_nested(EXT4_SB(sb)->s_journal))
> -		goto again;
> -	return replaced_count;
> -
> -repair_branches:
> -	/*
> -	 * This should never ever happen!
> -	 * Extents are swapped already, but we are not able to copy data.
> -	 * Try to swap extents to it's original places
> -	 */
> -	ext4_double_down_write_data_sem(orig_inode, donor_inode);
> -	replaced_count = ext4_swap_extents(handle, donor_inode, orig_inode,
> -					       orig_blk_offset, donor_blk_offset,
> -					   block_len_in_page, 0, &err2);
> -	ext4_double_up_write_data_sem(orig_inode, donor_inode);
> -	if (replaced_count != block_len_in_page) {
> -		ext4_error_inode_block(orig_inode, (sector_t)(orig_blk_offset),
> -				       EIO, "Unable to copy data block,"
> -				       " data will be lost.");
> -		*err = -EIO;
> -	}
> -	replaced_count = 0;
> -	goto unlock_folios;
> -}
> -
>  /*
>   * Check the validity of the basic filesystem environment and the
>   * inodes' support status.
> @@ -821,106 +557,81 @@ static int mext_check_adjust_range(struct inode *orig_inode,
>   *
>   * This function returns 0 and moved block length is set in moved_len
>   * if succeed, otherwise returns error value.
> - *
>   */
> -int
> -ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
> -		  __u64 donor_blk, __u64 len, __u64 *moved_len)
> +int ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
> +		      __u64 donor_blk, __u64 len, __u64 *moved_len)
>  {
>  	struct inode *orig_inode = file_inode(o_filp);
>  	struct inode *donor_inode = file_inode(d_filp);
> -	struct ext4_ext_path *path = NULL;
> -	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
> -	ext4_lblk_t o_end, o_start = orig_blk;
> -	ext4_lblk_t d_start = donor_blk;
> +	struct mext_data mext;
> +	struct super_block *sb = orig_inode->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	int retries = 0;
> +	u64 m_len;
>  	int ret;
>  
> +	*moved_len = 0;
> +
>  	/* Protect orig and donor inodes against a truncate */
>  	lock_two_nondirectories(orig_inode, donor_inode);
>  
>  	ret = mext_check_validity(orig_inode, donor_inode);
>  	if (ret)
> -		goto unlock;
> +		goto out;
>  
>  	/* Wait for all existing dio workers */
>  	inode_dio_wait(orig_inode);
>  	inode_dio_wait(donor_inode);
>  
> -	/* Protect extent tree against block allocations via delalloc */
> -	ext4_double_down_write_data_sem(orig_inode, donor_inode);
>  	/* Check and adjust the specified move_extent range. */
>  	ret = mext_check_adjust_range(orig_inode, donor_inode, orig_blk,
>  				      donor_blk, &len);
>  	if (ret)
>  		goto out;
> -	o_end = o_start + len;
>  
> -	*moved_len = 0;
> -	while (o_start < o_end) {
> -		struct ext4_extent *ex;
> -		ext4_lblk_t cur_blk, next_blk;
> -		pgoff_t orig_page_index, donor_page_index;
> -		int offset_in_page;
> -		int unwritten, cur_len;
> -
> -		path = get_ext_path(orig_inode, o_start, path);
> -		if (IS_ERR(path)) {
> -			ret = PTR_ERR(path);
> +	mext.orig_inode = orig_inode;
> +	mext.donor_inode = donor_inode;
> +	while (len) {
> +		mext.orig_map.m_lblk = orig_blk;
> +		mext.orig_map.m_len = len;
> +		mext.orig_map.m_flags = 0;
> +		mext.donor_lblk = donor_blk;
> +
> +		ret = ext4_map_blocks(NULL, orig_inode, &mext.orig_map, 0);
> +		if (ret < 0)
>  			goto out;
> -		}
> -		ex = path[path->p_depth].p_ext;
> -		cur_blk = le32_to_cpu(ex->ee_block);
> -		cur_len = ext4_ext_get_actual_len(ex);
> -		/* Check hole before the start pos */
> -		if (cur_blk + cur_len - 1 < o_start) {
> -			next_blk = ext4_ext_next_allocated_block(path);
> -			if (next_blk == EXT_MAX_BLOCKS) {
> -				ret = -ENODATA;
> -				goto out;
> +
> +		/* Skip moving if it is a hole or a delalloc extent. */
> +		if (mext.orig_map.m_flags &
> +		    (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> +			ret = mext_move_extent(&mext, &m_len);
> +			*moved_len += m_len;
> +			if (!ret)
> +				goto next;
> +
> +			/* Move failed or partially failed. */
> +			if (m_len) {
> +				orig_blk += m_len;
> +				donor_blk += m_len;
> +				len -= m_len;
>  			}
> -			d_start += next_blk - o_start;
> -			o_start = next_blk;
> -			continue;
> -		/* Check hole after the start pos */
> -		} else if (cur_blk > o_start) {
> -			/* Skip hole */
> -			d_start += cur_blk - o_start;
> -			o_start = cur_blk;
> -			/* Extent inside requested range ?*/
> -			if (cur_blk >= o_end)
> -				goto out;
> -		} else { /* in_range(o_start, o_blk, o_len) */
> -			cur_len += cur_blk - o_start;
> +			if (ret == -ESTALE)
> +				continue;
> +			if (ret == -ENOSPC &&
> +			    ext4_should_retry_alloc(sb, &retries))
> +				continue;
> +			if (ret == -EBUSY &&
> +			    sbi->s_journal && retries++ < 4 &&
> +			    jbd2_journal_force_commit_nested(sbi->s_journal))
> +				continue;
> +
> +			goto out;
>  		}
> -		unwritten = ext4_ext_is_unwritten(ex);
> -		if (o_end - o_start < cur_len)
> -			cur_len = o_end - o_start;
> -
> -		orig_page_index = o_start >> (PAGE_SHIFT -
> -					       orig_inode->i_blkbits);
> -		donor_page_index = d_start >> (PAGE_SHIFT -
> -					       donor_inode->i_blkbits);
> -		offset_in_page = o_start % blocks_per_page;
> -		if (cur_len > blocks_per_page - offset_in_page)
> -			cur_len = blocks_per_page - offset_in_page;
> -		/*
> -		 * Up semaphore to avoid following problems:
> -		 * a. transaction deadlock among ext4_journal_start,
> -		 *    ->write_begin via pagefault, and jbd2_journal_commit
> -		 * b. racing with ->read_folio, ->write_begin, and
> -		 *    ext4_get_block in move_extent_per_page
> -		 */
> -		ext4_double_up_write_data_sem(orig_inode, donor_inode);
> -		/* Swap original branches with new branches */
> -		*moved_len += move_extent_per_page(o_filp, donor_inode,
> -				     orig_page_index, donor_page_index,
> -				     offset_in_page, cur_len,
> -				     unwritten, &ret);
> -		ext4_double_down_write_data_sem(orig_inode, donor_inode);
> -		if (ret < 0)
> -			break;
> -		o_start += cur_len;
> -		d_start += cur_len;
> +next:
> +		orig_blk += mext.orig_map.m_len;
> +		donor_blk += mext.orig_map.m_len;
> +		len -= mext.orig_map.m_len;
> +		retries = 0;
>  	}
>  
>  out:
> @@ -929,10 +640,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		ext4_discard_preallocations(donor_inode);
>  	}
>  
> -	ext4_free_ext_path(path);
> -	ext4_double_up_write_data_sem(orig_inode, donor_inode);
> -unlock:
>  	unlock_two_nondirectories(orig_inode, donor_inode);
> -
>  	return ret;
>  }
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

