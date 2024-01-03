Return-Path: <linux-fsdevel+bounces-7171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EA822BC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4B0283517
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA3318E13;
	Wed,  3 Jan 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yNYG2MKD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeUY+zdi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yNYG2MKD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CeUY+zdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96018E00;
	Wed,  3 Jan 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 965021FD0E;
	Wed,  3 Jan 2024 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704279775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkCthtzt9XA7SQMzPGZlgrISTbGs2tObIyO8wIa7Rs8=;
	b=yNYG2MKD3TSW3Wl9w1E+AU2lx4DoKYiGlL4UmfL3dXfLAn2K0pmYmwK3VWNncOD5GX/TlZ
	er6dahG15/gNRZyigg+OwfzybbekU3GxuAlhfM/d+vmuT1ZIDpTW4FnBlvM7reBEoDQUF+
	nLcCq4TeBacMmx9vROjdEFWbWiLkrwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704279775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkCthtzt9XA7SQMzPGZlgrISTbGs2tObIyO8wIa7Rs8=;
	b=CeUY+zdi1EfWJefmgJ/TqOiXQh09umia916vkcOpuVZ52xVXNZ8aZcga+drks1vaioXQeR
	FcYKVGoUoIrUi6BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704279775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkCthtzt9XA7SQMzPGZlgrISTbGs2tObIyO8wIa7Rs8=;
	b=yNYG2MKD3TSW3Wl9w1E+AU2lx4DoKYiGlL4UmfL3dXfLAn2K0pmYmwK3VWNncOD5GX/TlZ
	er6dahG15/gNRZyigg+OwfzybbekU3GxuAlhfM/d+vmuT1ZIDpTW4FnBlvM7reBEoDQUF+
	nLcCq4TeBacMmx9vROjdEFWbWiLkrwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704279775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkCthtzt9XA7SQMzPGZlgrISTbGs2tObIyO8wIa7Rs8=;
	b=CeUY+zdi1EfWJefmgJ/TqOiXQh09umia916vkcOpuVZ52xVXNZ8aZcga+drks1vaioXQeR
	FcYKVGoUoIrUi6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8924E1340C;
	Wed,  3 Jan 2024 11:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NRh3Id8+lWV8CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 11:02:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1EEB4A07EF; Wed,  3 Jan 2024 12:02:55 +0100 (CET)
Date: Wed, 3 Jan 2024 12:02:55 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v2 03/25] ext4: correct the hole length returned by
 ext4_map_blocks()
Message-ID: <20240103110255.7uebqb2iy4jcy6sh@quack3>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
 <20240102123918.799062-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102123918.799062-4-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.10
X-Spam-Flag: NO

On Tue 02-01-24 20:38:56, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In ext4_map_blocks(), if we can't find a range of mapping in the
> extents cache, we are calling ext4_ext_map_blocks() to search the real
> path and ext4_ext_determine_hole() to determine the hole range. But if
> the querying range was partially or completely overlaped by a delalloc
> extent, we can't find it in the real extent path, so the returned hole
> length could be incorrect.
> 
> Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
> extent, but it searches start from the expanded hole_start, doesn't
> start from the querying range, so the delalloc extent found could not be
> the one that overlaped the querying range, plus, it also didn't adjust
> the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
> delalloc and insert adjusted hole extent in ext4_ext_determine_hole().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Some small comments below.

> @@ -4062,6 +4038,66 @@ static int get_implied_cluster_alloc(struct super_block *sb,
>  	return 0;
>  }
>  
> +/*
> + * Determine hole length around the given logical block, first try to
> + * locate and expand the hole from the given @path, and then adjust it
> + * if it's partially or completely converted to delayed extents.
> + */
> +static void ext4_ext_determine_hole(struct inode *inode,
> +				    struct ext4_ext_path *path,
> +				    struct ext4_map_blocks *map)
> +{

I'd prefer to keep setting of 'map' inside ext4_ext_map_blocks() to make it
more obvious there and just pass map->m_lblk into
ext4_ext_determine_hole(). ext4_ext_determine_hole() will just return the
length of the extent from lblk that was mapped (i.e. 'len').

Also I'd probably call this function like ext4_ext_determine_insert_hole()
to make it more obvious the function modifies the status tree.

Otherwise the patch looks good to me.

								Honza

> +	ext4_lblk_t hole_start, len;
> +	struct extent_status es;
> +
> +	hole_start = map->m_lblk;
> +	len = ext4_ext_find_hole(inode, path, &hole_start);
> +again:
> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
> +				  hole_start + len - 1, &es);
> +	if (!es.es_len)
> +		goto insert_hole;
> +
> +	/*
> +	 * Found a delayed range in the hole, handle it if the delayed
> +	 * range is before, behind and straddle the queried range.
> +	 */
> +	if (map->m_lblk >= es.es_lblk + es.es_len) {
> +		/*
> +		 * Before the queried range, find again from the queried
> +		 * start block.
> +		 */
> +		len -= map->m_lblk - hole_start;
> +		hole_start = map->m_lblk;
> +		goto again;
> +	} else if (in_range(map->m_lblk, es.es_lblk, es.es_len)) {
> +		/*
> +		 * Straddle the beginning of the queried range, it's no
> +		 * longer a hole, adjust the length to the delayed extent's
> +		 * after map->m_lblk.
> +		 */
> +		len = es.es_lblk + es.es_len - map->m_lblk;
> +		goto out;
> +	} else {
> +		/*
> +		 * Partially or completely behind the queried range, update
> +		 * hole length until the beginning of the delayed extent.
> +		 */
> +		len = min(es.es_lblk - hole_start, len);
> +	}
> +
> +insert_hole:
> +	/* Put just found gap into cache to speed up subsequent requests */
> +	ext_debug(inode, " -> %u:%u\n", hole_start, len);
> +	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
> +
> +	/* Update hole_len to reflect hole size after map->m_lblk */
> +	if (hole_start != map->m_lblk)
> +		len -= map->m_lblk - hole_start;
> +out:
> +	map->m_pblk = 0;
> +	map->m_len = min_t(unsigned int, map->m_len, len);
> +}
>  
>  /*
>   * Block allocation/map/preallocation routine for extents based files
> @@ -4179,22 +4215,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	 * we couldn't try to create block if create flag is zero
>  	 */
>  	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
> -		ext4_lblk_t hole_start, hole_len;
> -
> -		hole_start = map->m_lblk;
> -		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
> -		/*
> -		 * put just found gap into cache to speed up
> -		 * subsequent requests
> -		 */
> -		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
> -
> -		/* Update hole_len to reflect hole size after map->m_lblk */
> -		if (hole_start != map->m_lblk)
> -			hole_len -= map->m_lblk - hole_start;
> -		map->m_pblk = 0;
> -		map->m_len = min_t(unsigned int, map->m_len, hole_len);
> -
> +		ext4_ext_determine_hole(inode, path, map);
>  		goto out;
>  	}
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

