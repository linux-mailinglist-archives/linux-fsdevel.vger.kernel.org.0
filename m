Return-Path: <linux-fsdevel+bounces-63583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1528BC490B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 13:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F7734EED83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E462F7449;
	Wed,  8 Oct 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="paMqCL3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="STRGpFEd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="paMqCL3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="STRGpFEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4322F4A0A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922941; cv=none; b=fjUU2PwoA3UZ2+X4cohiSp/gbIDU4ljGzA4kO9iZIBPkBCJPGHsTMZ5ilsG4O44Jwz8r4MzAQeHlGyZi5UPp2hhNsXydBn4RlWygbkwZkA1ABj3pZdQSEDBBAVxIkXI7Q+FeVCO4+sgg5lFF6PAUu5ga48L6YXYiwZ/eZlsPTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922941; c=relaxed/simple;
	bh=W6HYvSTQL+ketjlyhzJdSP6L024Oizxpa9h/796ZCMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5CbOqJiyao7dfe17ZmTHNVu8zW4meQRtii3IGUgFJ5HGqKoqIJgwvkUtrSQ88xiX2htaKjpbU9lo/a5TSqPUPRj1uAwjH2cW/6VBNClaYLk1htpRv574IoxPwTA+eGi6RkPjsCPdyOJcjPjteD0t42RDVPWK0/UUb/4cpiGbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=paMqCL3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=STRGpFEd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=paMqCL3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=STRGpFEd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D21B71F395;
	Wed,  8 Oct 2025 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyauT+WnInxx5CLov3DoOxTDXNUztAoU+zpFUnumpPA=;
	b=paMqCL3fAwb0fTSPVxSQd8fseTsc4c3+0K+BEuXy1sG+jtqOZr5+bFkTA7kRqsezhJART9
	XHAwCtiG4AODKd7GPbEvV5lxGeGb+fVK9NF2kdwCdKoS3NzWsuJbPEftXF14a6rVIxYzsj
	VVhvdVq+UBr59Fv6yNYWPD+YpMcq+Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyauT+WnInxx5CLov3DoOxTDXNUztAoU+zpFUnumpPA=;
	b=STRGpFEdm7btKUZ7Z/tCotIjuRk8ga3uVRciOm9op8ByhePT69VbsRfxrh53w9nzigwhpA
	hXQHQ3peBHdpBBAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759922937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyauT+WnInxx5CLov3DoOxTDXNUztAoU+zpFUnumpPA=;
	b=paMqCL3fAwb0fTSPVxSQd8fseTsc4c3+0K+BEuXy1sG+jtqOZr5+bFkTA7kRqsezhJART9
	XHAwCtiG4AODKd7GPbEvV5lxGeGb+fVK9NF2kdwCdKoS3NzWsuJbPEftXF14a6rVIxYzsj
	VVhvdVq+UBr59Fv6yNYWPD+YpMcq+Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759922937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyauT+WnInxx5CLov3DoOxTDXNUztAoU+zpFUnumpPA=;
	b=STRGpFEdm7btKUZ7Z/tCotIjuRk8ga3uVRciOm9op8ByhePT69VbsRfxrh53w9nzigwhpA
	hXQHQ3peBHdpBBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B97A713693;
	Wed,  8 Oct 2025 11:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +HpFLflK5mjlKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 11:28:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B9DBA0ACD; Wed,  8 Oct 2025 13:28:57 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:28:57 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 04/13] ext4: make ext4_es_lookup_extent() pass out the
 extent seq counter
Message-ID: <5qdt2outacmgyrz4w5lqokwhp3haifs5z22hrgg22fd4kgbyzt@2y54npfzwwzv>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-5-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 25-09-25 17:26:00, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When querying extents in the extent status tree, we should hold the
> data_sem if we want to obtain the sequence number as a valid cookie
> simultaneously. However, currently, ext4_map_blocks() calls
> ext4_es_lookup_extent() without holding data_sem. Therefore, we should
> acquire i_es_lock instead, which also ensures that the sequence cookie
> and the extent remain consistent. Consequently, make
> ext4_es_lookup_extent() to pass out the sequence number when necessary.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c        | 2 +-
>  fs/ext4/extents_status.c | 6 ++++--
>  fs/ext4/extents_status.h | 2 +-
>  fs/ext4/inode.c          | 8 ++++----
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ca5499e9412b..c7d219e6c6d8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2213,7 +2213,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
>  	while (block <= end) {
>  		next = 0;
>  		flags = 0;
> -		if (!ext4_es_lookup_extent(inode, block, &next, &es))
> +		if (!ext4_es_lookup_extent(inode, block, &next, &es, NULL))
>  			break;
>  		if (ext4_es_is_unwritten(&es))
>  			flags |= FIEMAP_EXTENT_UNWRITTEN;
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 62886e18e2a3..9bf2f48d8ffe 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1035,8 +1035,8 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>   * Return: 1 on found, 0 on not
>   */
>  int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
> -			  ext4_lblk_t *next_lblk,
> -			  struct extent_status *es)
> +			  ext4_lblk_t *next_lblk, struct extent_status *es,
> +			  u64 *pseq)
>  {
>  	struct ext4_es_tree *tree;
>  	struct ext4_es_stats *stats;
> @@ -1095,6 +1095,8 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
>  			} else
>  				*next_lblk = 0;
>  		}
> +		if (pseq)
> +			*pseq = EXT4_I(inode)->i_es_seq;
>  	} else {
>  		percpu_counter_inc(&stats->es_stats_cache_misses);
>  	}
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 8f9c008d11e8..f3396cf32b44 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -148,7 +148,7 @@ extern void ext4_es_find_extent_range(struct inode *inode,
>  				      struct extent_status *es);
>  extern int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
>  				 ext4_lblk_t *next_lblk,
> -				 struct extent_status *es);
> +				 struct extent_status *es, u64 *pseq);
>  extern bool ext4_es_scan_range(struct inode *inode,
>  			       int (*matching_fn)(struct extent_status *es),
>  			       ext4_lblk_t lblk, ext4_lblk_t end);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..c7fac4b89c88 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -649,7 +649,7 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  	 * extent status tree.
>  	 */
>  	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
>  		if (ext4_es_is_written(&es))
>  			return retval;
>  	}
> @@ -723,7 +723,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		ext4_check_map_extents_env(inode);
>  
>  	/* Lookup extent status tree firstly */
> -	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>  			map->m_pblk = ext4_es_pblock(&es) +
>  					map->m_lblk - es.es_lblk;
> @@ -1908,7 +1908,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>  	ext4_check_map_extents_env(inode);
>  
>  	/* Lookup extent status tree firstly */
> -	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
>  		map->m_len = min_t(unsigned int, map->m_len,
>  				   es.es_len - (map->m_lblk - es.es_lblk));
>  
> @@ -1961,7 +1961,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>  	 * is held in write mode, before inserting a new da entry in
>  	 * the extent status tree.
>  	 */
> -	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es, NULL)) {
>  		map->m_len = min_t(unsigned int, map->m_len,
>  				   es.es_len - (map->m_lblk - es.es_lblk));
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

