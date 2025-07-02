Return-Path: <linux-fsdevel+bounces-53657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9757AAF5A8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3FB4A260A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB5288528;
	Wed,  2 Jul 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQ+lOXPk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o9uKNu8q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rdOEvBsH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UpKUsUO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4C2882BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465245; cv=none; b=CP3s6aF5NgmZo07CZT33E3TPEQDmNEtpaZjC+I/nx6v5SwQxG05fFVGQTbZ6d8IvSJL3vQRdqOuA9PX/XrUeimf5fjJ8pBQFktnozGMGqCZSVBrJQFB3S6b9nvAiQflqnB2BjTZdZ+13GB3N+Z8lXfDlw99BpmAmpV/+HjR2DWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465245; c=relaxed/simple;
	bh=CPw5NRgLCwNjj9ai9N98APfrY0Hw+JsEaoUj+lC2KOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6pgVBksGFPGBeqmErnIXsdJpvEm0w30tz3ioNik22IBXNdrSWtMStggbdGQ41WJCTU0i2uHEJFeTiNjbTSnavXYMkt/aqWGKnU2Er7sdVHCNSr0KLVgLgs0tlOHuaJgzj0HrDKBv+wJOUQK4yhSt4B2YXjKQEwDBytpJjSGsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQ+lOXPk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o9uKNu8q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rdOEvBsH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UpKUsUO7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D64811F38D;
	Wed,  2 Jul 2025 14:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751465242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SV7bmhOdlIH0NdBvF6O/WX2LEqKAvt5d4MNC8jbNwY=;
	b=CQ+lOXPk+mfRa3pgdYjAwml0VIAIhktOMlJR7r6PgWN/eJW3AxBaX8awmJb2FpjFdSdrz7
	V4b2gZ9U9ll6FDTPaxLEU4vZt216QK4sz6Tz+mYElau4WfsaCJPXdIlIj5bLfPyAB0h6FS
	xXDTT2t2qSnweMsVmUSExbyIUED6E5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751465242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SV7bmhOdlIH0NdBvF6O/WX2LEqKAvt5d4MNC8jbNwY=;
	b=o9uKNu8qvZIGDrNa0peT5WSVTyqCd1Uaeupw6WWIEXoDhbSIbULMycuUAvGGVLdlW8KlQ8
	IhHhQm8902VzkGDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rdOEvBsH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UpKUsUO7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751465240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SV7bmhOdlIH0NdBvF6O/WX2LEqKAvt5d4MNC8jbNwY=;
	b=rdOEvBsHu//OmPiOGlf1M2JnFM5KyhxriHew0f1lPG/VH+3aCYBVFQFzeroamAnZk0gQQ/
	jsMnbhcs4Xm77s5aobE0aphyyItwzDdGFxCQXkGvsJTGvJkK0U174rIcDtM7DzKIy7iCQg
	9R7IlGBflxu+/uqr4VOG9xBJ4V0V3rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751465240;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SV7bmhOdlIH0NdBvF6O/WX2LEqKAvt5d4MNC8jbNwY=;
	b=UpKUsUO7P6CYQyFciX51J36LCL3WKR84lbxRsqVTYAsnhqhyuOjt4bnPUn+A5VI2W9yhAz
	GxzueyAPHm7BjSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA26F13A24;
	Wed,  2 Jul 2025 14:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qLRXMRg9ZWiwPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Jul 2025 14:07:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 61553A0A55; Wed,  2 Jul 2025 16:07:20 +0200 (CEST)
Date: Wed, 2 Jul 2025 16:07:20 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 03/10] ext4: fix stale data if it bail out of the
 extents mapping loop
Message-ID: <hybrquimicexphjrsgcqawpdwtkauemo7ckolnnoygvd5zbtg4@epiqru756uip>
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701130635.4079595-4-yi.zhang@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D64811F38D
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 01-07-25 21:06:28, Zhang Yi wrote:
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
> Fix this by submitting the current processing partially mapped folio.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one naming suggestion below:

> +/*
> + * This is used to submit mapped buffers in a single folio that is not fully
> + * mapped for various reasons, such as insufficient space or journal credits.
> + */
> +static int mpage_submit_buffers(struct mpage_da_data *mpd)

mpage_submit_buffers() sounds somewhat generic. How about
mpage_submit_partial_folio()?

								Honza

> +{
> +	struct inode *inode = mpd->inode;
> +	struct folio *folio;
> +	loff_t pos;
> +	int ret;
> +
> +	folio = filemap_get_folio(inode->i_mapping,
> +				  mpd->start_pos >> PAGE_SHIFT);
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
> +	/*
> +	 * The mapped position should be within the current processing folio
> +	 * but must not be the folio start position.
> +	 */
> +	pos = mpd->map.m_lblk << inode->i_blkbits;
> +	if (WARN_ON_ONCE((folio_pos(folio) == pos) ||
> +			 !folio_contains(folio, pos >> PAGE_SHIFT)))
> +		return -EINVAL;
> +
> +	ret = mpage_submit_folio(mpd, folio);
> +	if (ret)
> +		goto out;
> +	/*
> +	 * Update start_pos to prevent this folio from being released in
> +	 * mpage_release_unused_pages(), it will be reset to the aligned folio
> +	 * pos when this folio is written again in the next round. Additionally,
> +	 * do not update wbc->nr_to_write here, as it will be updated once the
> +	 * entire folio has finished processing.
> +	 */
> +	mpd->start_pos = pos;
> +out:
> +	folio_unlock(folio);
> +	folio_put(folio);
> +	return ret;
> +}
> +
>  /*
>   * mpage_map_and_submit_extent - map extent starting at mpd->lblk of length
>   *				 mpd->len and submit pages underlying it for IO
> @@ -2411,8 +2452,16 @@ static int mpage_map_and_submit_extent(handle_t *handle,
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
> +					if (mpage_submit_buffers(mpd))
> +						goto invalidate_dirty_pages;
>  					goto update_disksize;
> +				}
>  				return err;
>  			}
>  			ext4_msg(sb, KERN_CRIT,
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

