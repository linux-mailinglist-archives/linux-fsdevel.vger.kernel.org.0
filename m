Return-Path: <linux-fsdevel+bounces-63590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82CBC4BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 14:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06DAB4EC4FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C642036E9;
	Wed,  8 Oct 2025 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BYp4jDFZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoHzBTBT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BYp4jDFZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QoHzBTBT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CD1221F1F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925770; cv=none; b=oREIeVeNVS4pcL7VEjngMoYAS83l25tY3QuM5kxDEatr+UsXQPn8xsU2jsYAOYprSJK+pkG2lFblAJ1zQARBhdrs06PDvbdm8qVIIIZX6BQe5W6cqlPIjB7qTQm8H0HGFx4YyhiJ/KtEjpCL6Ivl8VgV2yPId3SVxNsY7RRLJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925770; c=relaxed/simple;
	bh=t0lTvZ6X+XWSt22q1tWSMfP6gGwXSJ/Kzub4TBam+kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV3waw1lvSE4HLJLoaI6LW5G2VwkEhdHoR49wenB2IlpN/+VnF3DBN/v9NWAhpb3xJ3/orwlR+GwNyd29hPsUOQAwZ+3kEyRUap45RGnizasoKT/plbSKif2OVX3T2IUgP4vGhHA88xPEzCMDKWOMrQwpm2UTuA3XJ7HU0B3TTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BYp4jDFZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoHzBTBT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BYp4jDFZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QoHzBTBT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 916881F792;
	Wed,  8 Oct 2025 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759925764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFU/C/Oy4l92biDocMS0dOZ4DgWNv2XUCD/V5cwxPoU=;
	b=BYp4jDFZ1z8m0GX38YokIKtCZF27ZZP6JHaz+1RaGIyMv9do6a2G+DEX34nIfRa4K5yGn+
	hcI2m6LSbWagZp9sA2bAc+Ot1Ihb6BaKKc9XQwAhFoGpTOLA1J4NlBlMarUR2hchjHy8n5
	dBR1LLfFrcV0NLJKNNAS9ZFndHGZEK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759925764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFU/C/Oy4l92biDocMS0dOZ4DgWNv2XUCD/V5cwxPoU=;
	b=QoHzBTBTu0cjWuChqsoL0nBHbK4JJht65GUe/Rl3vRVte6jYXWy/8YluNzlOcj5KZKnCu0
	bLB27GzIFVXlV7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759925764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFU/C/Oy4l92biDocMS0dOZ4DgWNv2XUCD/V5cwxPoU=;
	b=BYp4jDFZ1z8m0GX38YokIKtCZF27ZZP6JHaz+1RaGIyMv9do6a2G+DEX34nIfRa4K5yGn+
	hcI2m6LSbWagZp9sA2bAc+Ot1Ihb6BaKKc9XQwAhFoGpTOLA1J4NlBlMarUR2hchjHy8n5
	dBR1LLfFrcV0NLJKNNAS9ZFndHGZEK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759925764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFU/C/Oy4l92biDocMS0dOZ4DgWNv2XUCD/V5cwxPoU=;
	b=QoHzBTBTu0cjWuChqsoL0nBHbK4JJht65GUe/Rl3vRVte6jYXWy/8YluNzlOcj5KZKnCu0
	bLB27GzIFVXlV7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D41C13A3D;
	Wed,  8 Oct 2025 12:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iWuJHgRW5mjAOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 12:16:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A845A0A9C; Wed,  8 Oct 2025 14:16:04 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:16:04 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 10/13] ext4: introduce mext_move_extent()
Message-ID: <2fxg5kszehzzaw5zbj6ptkxujzslxmudk3izentavxlkarm5mw@3yissfw5dru7>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-11-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-11-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 25-09-25 17:26:06, Zhang Yi wrote:
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

Nice, just one nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

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
> +	/* Adjust the moving length according to the minor folios length. */
						 ^^^ ... the length of shorter folio


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

