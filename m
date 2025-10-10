Return-Path: <linux-fsdevel+bounces-63758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4008FBCD4DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C696E4E6134
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E352F3C1F;
	Fri, 10 Oct 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mvX2P05/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ngH8eUtN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvqYDBn/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r52+pjcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065C283145
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103537; cv=none; b=cBDywmNH/7+N+1lbMza6nhNIUlV54xp43VtATVCjL4dhFXPBuOeVkZx4LGbDX9DNKp6VlvAH2u3lZFAYwWGcAjzUgofMZlNpy0DDIYMfrIJASmIJc4YvDvBjHuOb4KyEJC6LbogpLEFVsqUEsTHnU4eGkwlxRYs2X142q1esBKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103537; c=relaxed/simple;
	bh=FhN+McgrA585TU0E5PGSmbWFkzh2mRDChh8LLkSvc2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKo7bsK4aN7XqUv4faaBOKiSTq2C8kE7hNtqb80mrhfKzcHiu23okeHgHkaWhPoXrWhEAUS6ZqdF5LvZ6hdKFdiktIgbKV5Ht2BZ6wn+mFKC/9dKeBL5+tEd93Wmbp+s8Jf7dymR86+fkFPcX1HOF3bZ4uI7mOeJJurOQAXFCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mvX2P05/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ngH8eUtN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvqYDBn/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r52+pjcf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCF6F21D4B;
	Fri, 10 Oct 2025 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760103533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCf/AuvFoBxToTliNDZv9PN9oX+BvYLNGth3isDIeXo=;
	b=mvX2P05//UWaKjTr+H7wswtyJkZQ0jdRr2Nc+4GhNchvzZV0OT/L1uRzmG6XwW9cYibyku
	tnQCQKi1mmJknsiy9KkjL0vHXTA1AW69tJyJBmj4Ng+vN/W35j1xaJVjgV5UG+1OfJXYZr
	K/yvH+lz+U2Hx9OlE+cMzW8uNPIiTKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760103533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCf/AuvFoBxToTliNDZv9PN9oX+BvYLNGth3isDIeXo=;
	b=ngH8eUtNu2zvz7EXzkrh7WddUyLicab2U91vVjuWT9i5FgwQO8AZc5iRqLgcnAHYUtY9JB
	Ys19TmbcHMkHvYAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="vvqYDBn/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r52+pjcf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760103532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCf/AuvFoBxToTliNDZv9PN9oX+BvYLNGth3isDIeXo=;
	b=vvqYDBn/vI/biIKNvW1cVwJ564qG+uhciixyl3aecvilz7VNU4SvnS5+TtnVzObHbD0NDd
	7NX1MUAwFfuUSY3FeCnmTwyzGOedUv6Rm2Boz+0IUa7rnKp5ss1ogbtkEuRp9e24EsGtK7
	d/7ADWr39gecz5gJ0AZcHXczEiOshXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760103532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCf/AuvFoBxToTliNDZv9PN9oX+BvYLNGth3isDIeXo=;
	b=r52+pjcfEQGu2Fxe+s3jHtZ9L7IN48Gq87v/ehImdyJ40VIIKRqZzA5i53sLqEKqad/Qkl
	0FYA9FQ0/NO5rACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDA0A1375D;
	Fri, 10 Oct 2025 13:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PGQwMmwM6WiQZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 13:38:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14371A0A58; Fri, 10 Oct 2025 15:38:52 +0200 (CEST)
Date: Fri, 10 Oct 2025 15:38:52 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 09/12] ext4: introduce mext_move_extent()
Message-ID: <pkhkxgsoa3e3svcwudqo5jckurdqnhkdd6ckbkvgp424lxfcvn@h4nazw5rrd77>
References: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
 <20251010103326.3353700-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010103326.3353700-10-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DCF6F21D4B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:email,huawei.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Fri 10-10-25 18:33:23, Zhang Yi wrote:
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

...

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
> +	ret = mext_folio_mkwrite(orig_inode, folio[0], from, from + length);
> +	if (ret)
> +		goto repair_branches;

I think you need to be careful here and below to not overwrite 'ret' if it
is != 0. So something like:

	ret2 = mext_folio_mkwrite(..)
	if (ret2) {
		if (!ret)
			ret = ret2;
		goto repair_branches;
	}

and something similar below. Otherwise the patch looks good to me.

								Honza

> +	/*
> +	 * Even in case of data=writeback it is reasonable to pin
> +	 * inode to transaction, to prevent unexpected data loss.
> +	 */
> +	ret = ext4_jbd2_inode_add_write(handle, orig_inode,
> +			((loff_t)orig_map->m_lblk) << blkbits, length);
> +unlock:
> +	mext_folio_double_unlock(folio);
> +stop_handle:
> +	ext4_journal_stop(handle);
> +	return ret;
> +
> +repair_branches:
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

