Return-Path: <linux-fsdevel+bounces-63945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 508D2BD2964
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 677E24EA4E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375E2FF17A;
	Mon, 13 Oct 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F6UMplvD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fKNqF91V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F6UMplvD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fKNqF91V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B102E2DC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351812; cv=none; b=o72yvnMAv4bdxqU8bnDdBJ3kUP+ZxwYzsvCjvzP/g1re6HaiIqwQFqWPLm8X7RNk6Ar/CJ8fnRdYbfxZPt0V7c+zqelGfXzg7X0CQinmIHDbsC7qVw8J5nQTc8kGoXBHX+JG0Uqr8ePHsm6aVlebGynCq0oetS5fTmeSPSgjR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351812; c=relaxed/simple;
	bh=BiUqejgXtG7VwpR15ojOqYjCijU/rwJkpBnfQxktN1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZRMrydWTDi7lH0dITy00Gc7o/U3/unFln2l9s3zFLjAaRmCMPodom4qWv2t8zYcmOVjXjynO9J00bAedLkx5g5qQss8+vUdEEVPubZhB+flMQjjLJ5u5Sq6NyN31GsarHUZHbEOgSzLAXT0AuHfoWvJR3NCVumUq0kQ8l6B3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F6UMplvD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fKNqF91V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F6UMplvD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fKNqF91V; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BC0C218EE;
	Mon, 13 Oct 2025 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760351808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlhNYV5TDpmS8ZMvY4oSQVMXvJcytm001245BsXWKaQ=;
	b=F6UMplvDjIDAooNouua976NVZ7HtupvXZfZEPM8064KmVdPqKTDNraWC4Tp4yOZvPu/bsO
	pGWKSRI+B9iOc8GOgnudZeaf+FpxFNngF9Ft3Q0g4IAFPRk7qXF3YQhZOwVSAyjC3smsv0
	JpAFQn11pTYKMUGkt7twwjOFjjbnyKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760351808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlhNYV5TDpmS8ZMvY4oSQVMXvJcytm001245BsXWKaQ=;
	b=fKNqF91VfUONJoExK5zL+nZeZksA0NNvUneygm2cg3TRbp/j0BDTcr0MaxU3S+eZ/H2UnN
	SiDA0BaHVX3mKlAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F6UMplvD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fKNqF91V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760351808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlhNYV5TDpmS8ZMvY4oSQVMXvJcytm001245BsXWKaQ=;
	b=F6UMplvDjIDAooNouua976NVZ7HtupvXZfZEPM8064KmVdPqKTDNraWC4Tp4yOZvPu/bsO
	pGWKSRI+B9iOc8GOgnudZeaf+FpxFNngF9Ft3Q0g4IAFPRk7qXF3YQhZOwVSAyjC3smsv0
	JpAFQn11pTYKMUGkt7twwjOFjjbnyKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760351808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlhNYV5TDpmS8ZMvY4oSQVMXvJcytm001245BsXWKaQ=;
	b=fKNqF91VfUONJoExK5zL+nZeZksA0NNvUneygm2cg3TRbp/j0BDTcr0MaxU3S+eZ/H2UnN
	SiDA0BaHVX3mKlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 545FD13874;
	Mon, 13 Oct 2025 10:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uHU4FEDW7GiWMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 10:36:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ABB6A0A58; Mon, 13 Oct 2025 12:36:48 +0200 (CEST)
Date: Mon, 13 Oct 2025 12:36:48 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 09/12] ext4: introduce mext_move_extent()
Message-ID: <wyqilf2hfdx5vemrtvczz4nzijzzw5vw3qsnzmi54cof4dvnqd@tg4v7bmz7dks>
References: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
 <20251013015128.499308-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013015128.499308-10-yi.zhang@huaweicloud.com>
X-Rspamd-Queue-Id: 6BC0C218EE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 13-10-25 09:51:25, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When moving extents, the current move_extent_per_page() process can only
> move extents of length PAGE_SIZE at a time, which is highly inefficient,
> especially when the fragmentation of the file is not particularly
> severe, this will result in a large number of unnecessary extent split
> and merge operations. Moreover, since the ext4 file system now supports
> large folios, using PAGE_SIZE as the processing unit is no longer
> practical.
> 
> Therefore, introduce a new move extents method, mext_move_extent(). It
> moves one extent of the origin inode at a time, but not exceeding the
> size of a folio. The parameters for the move are passed through the new
> mext_data data structure, which includes the origin inode, donor inode,
> the mapping extent of the origin inode to be moved, and the starting
> offset of the donor inode.
> 
> The move process is similar to move_extent_per_page() and can be
> categorized into three types: MEXT_SKIP_EXTENT, MEXT_MOVE_EXTENT, and
> MEXT_COPY_DATA. MEXT_SKIP_EXTENT indicates that the corresponding area
> of the donor file is a hole, meaning no actual space is allocated, so
> the move is skipped. MEXT_MOVE_EXTENT indicates that the corresponding
> areas of both the origin and donor files are unwritten, so no data needs
> to be copied; only the extents are swapped. MEXT_COPY_DATA indicates
> that the corresponding areas of both the origin and donor files contain
> data, so data must be copied. The data copying is performed in three
> steps: first, the data from the original location is read into the page
> cache; then, the extents are swapped, and the page cache is rebuilt to
> reflect the index of the physical blocks; finally, the dirty page cache
> is marked and written back to ensure that the data is written to disk
> before the metadata is persisted.
> 
> One important point to note is that the folio lock and i_data_sem are
> held only during the moving process. Therefore, before moving an extent,
> it is necessary to check whether the sequence cookie of the area to be
> moved has changed while holding the folio lock. If a change is detected,
> it indicates that concurrent write-back operations may have occurred
> during this period, and the type of the extent to be moved can no longer
> be considered reliable. For example, it may have changed from unwritten
> to written. In such cases, return -ESTALE, and the calling function
> should reacquire the move extent of the original file and retry the
> movement.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 224 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 2df6072b26c0..92a716c56740 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -13,6 +13,13 @@
>  #include "ext4.h"
>  #include "ext4_extents.h"
>  
> +struct mext_data {
> +	struct inode *orig_inode;	/* Origin file inode */
> +	struct inode *donor_inode;	/* Donor file inode */
> +	struct ext4_map_blocks orig_map;/* Origin file's move mapping */
> +	ext4_lblk_t donor_lblk;		/* Start block of the donor file */
> +};
> +
>  /**
>   * get_ext_path() - Find an extent path for designated logical block number.
>   * @inode:	inode to be searched
> @@ -164,6 +171,14 @@ mext_folio_double_lock(struct inode *inode1, struct inode *inode2,
>  	return 0;
>  }
>  
> +static void mext_folio_double_unlock(struct folio *folio[2])
> +{
> +	folio_unlock(folio[0]);
> +	folio_put(folio[0]);
> +	folio_unlock(folio[1]);
> +	folio_put(folio[1]);
> +}
> +
>  /* Force folio buffers uptodate w/o dropping folio's lock */
>  static int mext_folio_mkuptodate(struct folio *folio, size_t from, size_t to)
>  {
> @@ -238,6 +253,215 @@ static int mext_folio_mkuptodate(struct folio *folio, size_t from, size_t to)
>  	return 0;
>  }
>  
> +enum mext_move_type {MEXT_SKIP_EXTENT, MEXT_MOVE_EXTENT, MEXT_COPY_DATA};
> +
> +/*
> + * Start to move extent between the origin inode and the donor inode,
> + * hold one folio for each inode and check the candidate moving extent
> + * mapping status again.
> + */
> +static int mext_move_begin(struct mext_data *mext, struct folio *folio[2],
> +			   enum mext_move_type *move_type)
> +{
> +	struct inode *orig_inode = mext->orig_inode;
> +	struct inode *donor_inode = mext->donor_inode;
> +	unsigned int blkbits = orig_inode->i_blkbits;
> +	struct ext4_map_blocks donor_map = {0};
> +	loff_t orig_pos, donor_pos;
> +	size_t move_len;
> +	int ret;
> +
> +	orig_pos = ((loff_t)mext->orig_map.m_lblk) << blkbits;
> +	donor_pos = ((loff_t)mext->donor_lblk) << blkbits;
> +	ret = mext_folio_double_lock(orig_inode, donor_inode,
> +			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT, folio);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Check the origin inode's mapping information again under the
> +	 * folio lock, as we do not hold the i_data_sem at all times, and
> +	 * it may change during the concurrent write-back operation.
> +	 */
> +	if (mext->orig_map.m_seq != READ_ONCE(EXT4_I(orig_inode)->i_es_seq)) {
> +		ret = -ESTALE;
> +		goto error;
> +	}
> +
> +	/* Adjust the moving length according to the length of shorter folio. */
> +	move_len = umin(folio_pos(folio[0]) + folio_size(folio[0]) - orig_pos,
> +			folio_pos(folio[1]) + folio_size(folio[1]) - donor_pos);
> +	move_len >>= blkbits;
> +	if (move_len < mext->orig_map.m_len)
> +		mext->orig_map.m_len = move_len;
> +
> +	donor_map.m_lblk = mext->donor_lblk;
> +	donor_map.m_len = mext->orig_map.m_len;
> +	donor_map.m_flags = 0;
> +	ret = ext4_map_blocks(NULL, donor_inode, &donor_map, 0);
> +	if (ret < 0)
> +		goto error;
> +
> +	/* Adjust the moving length according to the donor mapping length. */
> +	mext->orig_map.m_len = donor_map.m_len;
> +
> +	/* Skip moving if the donor range is a hole or a delalloc extent. */
> +	if (!(donor_map.m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)))
> +		*move_type = MEXT_SKIP_EXTENT;
> +	/* If both mapping ranges are unwritten, no need to copy data. */
> +	else if ((mext->orig_map.m_flags & EXT4_MAP_UNWRITTEN) &&
> +		 (donor_map.m_flags & EXT4_MAP_UNWRITTEN))
> +		*move_type = MEXT_MOVE_EXTENT;
> +	else
> +		*move_type = MEXT_COPY_DATA;
> +
> +	return 0;
> +error:
> +	mext_folio_double_unlock(folio);
> +	return ret;
> +}
> +
> +/*
> + * Re-create the new moved mapping buffers of the original inode and commit
> + * the entire written range.
> + */
> +static int mext_folio_mkwrite(struct inode *inode, struct folio *folio,
> +			      size_t from, size_t to)
> +{
> +	unsigned int blocksize = i_blocksize(inode);
> +	struct buffer_head *bh, *head;
> +	size_t block_start, block_end;
> +	sector_t block;
> +	int ret;
> +
> +	head = folio_buffers(folio);
> +	if (!head)
> +		head = create_empty_buffers(folio, blocksize, 0);
> +
> +	block = folio_pos(folio) >> inode->i_blkbits;
> +	block_end = 0;
> +	bh = head;
> +	do {
> +		block_start = block_end;
> +		block_end = block_start + blocksize;
> +		if (block_end <= from || block_start >= to)
> +			continue;
> +
> +		ret = ext4_get_block(inode, block, bh, 0);
> +		if (ret)
> +			return ret;
> +	} while (block++, (bh = bh->b_this_page) != head);
> +
> +	block_commit_write(folio, from, to);
> +	return 0;
> +}
> +
> +/*
> + * Save the data in original inode extent blocks and replace one folio size
> + * aligned original inode extent with one or one partial donor inode extent,
> + * and then write out the saved data in new original inode blocks. Pass out
> + * the replaced block count through m_len. Return 0 on success, and an error
> + * code otherwise.
> + */
> +static __used int mext_move_extent(struct mext_data *mext, u64 *m_len)
> +{
> +	struct inode *orig_inode = mext->orig_inode;
> +	struct inode *donor_inode = mext->donor_inode;
> +	struct ext4_map_blocks *orig_map = &mext->orig_map;
> +	unsigned int blkbits = orig_inode->i_blkbits;
> +	struct folio *folio[2] = {NULL, NULL};
> +	loff_t from, length;
> +	enum mext_move_type move_type = 0;
> +	handle_t *handle;
> +	u64 r_len = 0;
> +	unsigned int credits;
> +	int ret, ret2;
> +
> +	*m_len = 0;
> +	credits = ext4_chunk_trans_extent(orig_inode, 0) * 2;
> +	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, credits);
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +
> +	ret = mext_move_begin(mext, folio, &move_type);
> +	if (ret)
> +		goto stop_handle;
> +
> +	if (move_type == MEXT_SKIP_EXTENT)
> +		goto unlock;
> +
> +	/*
> +	 * Copy the data. First, read the original inode data into the page
> +	 * cache. Then, release the existing mapping relationships and swap
> +	 * the extent. Finally, re-establish the new mapping relationships
> +	 * and dirty the page cache.
> +	 */
> +	if (move_type == MEXT_COPY_DATA) {
> +		from = offset_in_folio(folio[0],
> +				((loff_t)orig_map->m_lblk) << blkbits);
> +		length = ((loff_t)orig_map->m_len) << blkbits;
> +
> +		ret = mext_folio_mkuptodate(folio[0], from, from + length);
> +		if (ret)
> +			goto unlock;
> +	}
> +
> +	if (!filemap_release_folio(folio[0], 0) ||
> +	    !filemap_release_folio(folio[1], 0)) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	/* Move extent */
> +	ext4_double_down_write_data_sem(orig_inode, donor_inode);
> +	*m_len = ext4_swap_extents(handle, orig_inode, donor_inode,
> +				   orig_map->m_lblk, mext->donor_lblk,
> +				   orig_map->m_len, 1, &ret);
> +	ext4_double_up_write_data_sem(orig_inode, donor_inode);
> +
> +	/* A short-length swap cannot occur after a successful swap extent. */
> +	if (WARN_ON_ONCE(!ret && (*m_len != orig_map->m_len)))
> +		ret = -EIO;
> +
> +	if (!(*m_len) || (move_type == MEXT_MOVE_EXTENT))
> +		goto unlock;
> +
> +	/* Copy data */
> +	length = (*m_len) << blkbits;
> +	ret2 = mext_folio_mkwrite(orig_inode, folio[0], from, from + length);
> +	if (ret2) {
> +		if (!ret)
> +			ret = ret2;
> +		goto repair_branches;
> +	}
> +	/*
> +	 * Even in case of data=writeback it is reasonable to pin
> +	 * inode to transaction, to prevent unexpected data loss.
> +	 */
> +	ret2 = ext4_jbd2_inode_add_write(handle, orig_inode,
> +			((loff_t)orig_map->m_lblk) << blkbits, length);
> +	if (!ret)
> +		ret = ret2;
> +unlock:
> +	mext_folio_double_unlock(folio);
> +stop_handle:
> +	ext4_journal_stop(handle);
> +	return ret;
> +
> +repair_branches:
> +	ret2 = 0;
> +	r_len = ext4_swap_extents(handle, donor_inode, orig_inode,
> +				  mext->donor_lblk, orig_map->m_lblk,
> +				  *m_len, 0, &ret2);
> +	if (ret2 || r_len != *m_len) {
> +		ext4_error_inode_block(orig_inode, (sector_t)(orig_map->m_lblk),
> +				       EIO, "Unable to copy data block, data will be lost!");
> +		ret = -EIO;
> +	}
> +	*m_len = 0;
> +	goto unlock;
> +}
> +
>  /**
>   * move_extent_per_page - Move extent data per page
>   *
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

