Return-Path: <linux-fsdevel+bounces-52249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D56AE0B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E651BC6A90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7026228BA82;
	Thu, 19 Jun 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9wPiqlW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2K+HySr5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9wPiqlW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2K+HySr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE4235046
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350123; cv=none; b=XWpOPokeHSEeuKoOUUA50oOHoptWozA4/fkT+uUARrne708fEgdn5H6/1nS1GeKg6ATxbOw2boTln4+iCmzigwDTmowG2dXFWM9ndgZP/ApROVfBQPlgiyg1SQ20rJPhSq+txmjLgDulJBTksEz4niJFgFr3nyz+THioPbHE/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350123; c=relaxed/simple;
	bh=7K6oZcAivfBhwTNb5BmkSij8yNph5jyg7D+Rul5+QL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/MfH94i4hoUC7cFmX7624bXHC/rELqb3wbCYokxM7RYohjkmgbLOViuD1JpEDjoQkwQKQJ6z2+8tvmdEoLTKcfrIu4L2ZwiHQHLpfO3bomLMmGg12AsvWXfqjYruw2mequVx8X5nnYJBqMvBHyInBK8kjfCSmfhjdEl1LnLl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9wPiqlW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2K+HySr5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9wPiqlW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2K+HySr5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34EDC1F38D;
	Thu, 19 Jun 2025 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750350120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBXhWz3cKH2Kv/pzpJfoID2U/545GzOHbh+GauCAbd8=;
	b=g9wPiqlW2Fnixj8kN17u08WSq+o7hxcFwJx7fP2WToLzdV9dscaK4jeii7cyPWf4YU/gWO
	8fSHyGnum/hl1sTLmdVXBBsKYbgmMlUkxHBU6c/8EeOM65GbyUYe+URPhOVU0W5p7uvFDB
	9rhcDk3XeOmbh9NXaQt9KHZtw9FCwSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750350120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBXhWz3cKH2Kv/pzpJfoID2U/545GzOHbh+GauCAbd8=;
	b=2K+HySr5dWstC+6lT2F5WnWJ3x4oP2Qg+I7Lf7bsX6wWtHlHQkGYxvf02EG4H6flbpU3iP
	xaUOtohRFXn2WwBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750350120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBXhWz3cKH2Kv/pzpJfoID2U/545GzOHbh+GauCAbd8=;
	b=g9wPiqlW2Fnixj8kN17u08WSq+o7hxcFwJx7fP2WToLzdV9dscaK4jeii7cyPWf4YU/gWO
	8fSHyGnum/hl1sTLmdVXBBsKYbgmMlUkxHBU6c/8EeOM65GbyUYe+URPhOVU0W5p7uvFDB
	9rhcDk3XeOmbh9NXaQt9KHZtw9FCwSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750350120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBXhWz3cKH2Kv/pzpJfoID2U/545GzOHbh+GauCAbd8=;
	b=2K+HySr5dWstC+6lT2F5WnWJ3x4oP2Qg+I7Lf7bsX6wWtHlHQkGYxvf02EG4H6flbpU3iP
	xaUOtohRFXn2WwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 019B7136CC;
	Thu, 19 Jun 2025 16:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TZwcACg5VGhIQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 16:21:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 853AEA29FA; Thu, 19 Jun 2025 18:21:59 +0200 (CEST)
Date: Thu, 19 Jun 2025 18:21:59 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 2/6] ext4: fix stale data if it bail out of the
 extents mapping loop
Message-ID: <m5drn6xauyaksmui7b3vpua24ttgmjnwsi3sgavpelxlcwivsw@6bpmobqvpw7f>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-3-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611111625.1668035-3-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 

On Wed 11-06-25 19:16:21, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> During the process of writing back folios, if
> mpage_map_and_submit_extent() exits the extent mapping loop due to an
> ENOSPC or ENOMEM error, it may result in stale data or filesystem
> inconsistency in environments where the block size is smaller than the
> folio size.
> 
> When mapping a discontinuous folio in mpage_map_and_submit_extent(),
> some buffers may have already be mapped. If we exit the mapping loop
> prematurely, the folio data within the mapped range will not be written
> back, and the file's disk size will not be updated. Once the transaction
> that includes this range of extents is committed, this can lead to stale
> data or filesystem inconsistency.
> 
> Fix this by submitting the current processing partial mapped folio and
> update the disk size to the end of the mapped range.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3a086fee7989..d0db6e3bf158 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2362,6 +2362,42 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>  	return 0;
>  }
>  
> +/*
> + * This is used to submit mapped buffers in a single folio that is not fully
> + * mapped for various reasons, such as insufficient space or journal credits.
> + */
> +static int mpage_submit_buffers(struct mpage_da_data *mpd, loff_t pos)
> +{
> +	struct inode *inode = mpd->inode;
> +	struct folio *folio;
> +	int ret;
> +
> +	folio = filemap_get_folio(inode->i_mapping, mpd->first_page);
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
> +
> +	ret = mpage_submit_folio(mpd, folio);
> +	if (ret)
> +		goto out;
> +	/*
> +	 * Update first_page to prevent this folio from being released in
> +	 * mpage_release_unused_pages(), it should not equal to the folio
> +	 * index.
> +	 *
> +	 * The first_page will be reset to the aligned folio index when this
> +	 * folio is written again in the next round. Additionally, do not
> +	 * update wbc->nr_to_write here, as it will be updated once the
> +	 * entire folio has finished processing.
> +	 */
> +	mpd->first_page = round_up(pos, PAGE_SIZE) >> PAGE_SHIFT;

Well, but there can be many folios between mpd->first_page and pos. And
this way you avoid cleaning them up (unlocking them and dropping elevated
refcount) before we restart next loop. How is this going to work?

Also I don't see in this patch where mpd->first_page would get set back to
retry writing this folio. What am I missing?

> +	WARN_ON_ONCE((folio->index == mpd->first_page) ||
> +		     !folio_contains(folio, pos >> PAGE_SHIFT));
> +out:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	return ret;
> +}
> +
>  /*
>   * mpage_map_and_submit_extent - map extent starting at mpd->lblk of length
>   *				 mpd->len and submit pages underlying it for IO
> @@ -2412,8 +2448,16 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  			 */
>  			if ((err == -ENOMEM) ||
>  			    (err == -ENOSPC && ext4_count_free_clusters(sb))) {
> -				if (progress)
> +				/*
> +				 * We may have already allocated extents for
> +				 * some bhs inside the folio, issue the
> +				 * corresponding data to prevent stale data.
> +				 */
> +				if (progress) {
> +					if (mpage_submit_buffers(mpd, disksize))
> +						goto invalidate_dirty_pages;
>  					goto update_disksize;
> +				}
>  				return err;
>  			}
>  			ext4_msg(sb, KERN_CRIT,
> @@ -2432,6 +2476,8 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  			*give_up_on_write = true;
>  			return err;
>  		}
> +		disksize = ((loff_t)(map->m_lblk + map->m_len)) <<
> +				inode->i_blkbits;

I don't think setting disksize like this is correct in case
mpage_map_and_submit_buffers() below fails (when extent covers many folios
and we don't succeed in writing them all). In that case we may need to keep
disksize somewhere in the middle of the extent.

Overall I don't think we need to modify disksize handling here. It is fine
to leave (part of) the extent dangling beyond disksize until we retry the
writeback in these rare cases.

>  		progress = 1;
>  		/*
>  		 * Update buffer state, submit mapped pages, and get us new
> @@ -2442,12 +2488,12 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  			goto update_disksize;
>  	} while (map->m_len);
>  
> +	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
>  update_disksize:
>  	/*
>  	 * Update on-disk size after IO is submitted.  Races with
>  	 * truncate are avoided by checking i_size under i_data_sem.
>  	 */
> -	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
>  	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
>  		int err2;
>  		loff_t i_size;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

