Return-Path: <linux-fsdevel+bounces-67268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EBBC39C60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 10:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D677B3AF11D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010B3090E4;
	Thu,  6 Nov 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C/fWtJPb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y0Aok+VE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ge0vQiTj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJ8qPQ2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794430B51A
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420543; cv=none; b=fgHSzoJlwldYr6YKpNwVNe3NsLCWBsX0QzU7A3QzYtirkvEKAtpfgTiFWJDxTpX7WPnXgShJeFBDTt/v/16F3Gese7tRH9RX4b961gTVJv5GIXQfaBDoiv4WPpF14w9gfOQKUzBgXM0dvay1i3cz+8N3A0aidmeoRLIqhJeuTKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420543; c=relaxed/simple;
	bh=Ym9wpKbyGYK+lSGT9Y6tw98v3cdwk7PQ3TiqZm9gAMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZZGwzFQqiK1cN7fNyJ65M1NFjEIzC2DhH2P9mgbHMLxII+pym2Q+4eZVmpNwuY751ytiJo382uz6N9G+/YO+F/O2pn/5pA6OTKIfgT8mWzYGxv4+FQ8/bnTPQT4zTEVXPkTyDsg9F8FnzFEs3rUS0aVK6Uo5f6oNAN5MrGLhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C/fWtJPb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y0Aok+VE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ge0vQiTj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJ8qPQ2i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A1F92117A;
	Thu,  6 Nov 2025 09:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762420539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7EJyEl/k7DT8f9HbU1Gh+BkGTTsTzDuULRregCfnYb4=;
	b=C/fWtJPbGhc0gm+wcXd1RssXuDKsArXoiTvEWIfmaMJdg0VfFe+VAqWtnIpPYDJyT21puY
	M7P5Fyo89sxoW1unVC9qXclO3Xp3WOu4jJywgkH1ccn8g500Xx+ibB72wk6Pe94z951zT9
	S3xpvnadC0yVfPPuMxCa1/BnjJ8XYgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762420539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7EJyEl/k7DT8f9HbU1Gh+BkGTTsTzDuULRregCfnYb4=;
	b=y0Aok+VE6+VgI/e34WmQNRXLdnJFoiDzVYLmmEiqw6Jhm/HmiNifTVoOgjQqYP0kz4o3sm
	g77EnK++lnM1fxBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762420538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7EJyEl/k7DT8f9HbU1Gh+BkGTTsTzDuULRregCfnYb4=;
	b=ge0vQiTjkBGS4d8Q+hXFf0TWvUv8FHOxgGi/3KVyF135gTDocVjmO1Dr69E7vFVNtAwNtx
	k3p67thvqHe4LGJTxc402CqgakrlcykWtWO8e/4J174kbEXFPzehYlOW+z/HdZprZcvUW4
	ScevaT2/P4VppzuGpb5odUehBJ8xOVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762420538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7EJyEl/k7DT8f9HbU1Gh+BkGTTsTzDuULRregCfnYb4=;
	b=GJ8qPQ2i6Lxm817y3Cu0yIY8EiJ9uldQT0ramhS032FF1MstThDnubU7YQqvZ3Ui4/jpvw
	VKIcpyzHtKwY5iAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB2F139A9;
	Thu,  6 Nov 2025 09:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id stFSIjpnDGmmBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Nov 2025 09:15:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3CE46A0927; Thu,  6 Nov 2025 10:15:38 +0100 (CET)
Date: Thu, 6 Nov 2025 10:15:38 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 1/4] ext4: make ext4_es_cache_extent() support overwrite
 existing extents
Message-ID: <l7tb75bsk52ybeok737b7o4ag4zeleowtddf3v6wcbnhbom4tx@xv643wp5wp6a>
References: <20251031062905.4135909-1-yi.zhang@huaweicloud.com>
 <20251031062905.4135909-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031062905.4135909-2-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 31-10-25 14:29:02, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Currently, ext4_es_cache_extent() is used to load extents into the
> extent status tree when reading on-disk extent blocks. Since it may be
> called while moving or modifying the extent tree, so it does not
> overwrite existing extents in the extent status tree and is only used
> for the initial loading.
> 
> There are many other places in ext4 where on-disk extents are inserted
> into the extent status tree, such as in ext4_map_query_blocks().
> Currently, they call ext4_es_insert_extent() to perform the insertion,
> but they don't modify the extents, so ext4_es_cache_extent() would be a
> more appropriate choice. However, when ext4_map_query_blocks() inserts
> an extent, it may overwrite a short existing extent of the same type.
> Therefore, to prepare for the replacements, we need to extend
> ext4_es_cache_extent() to allow it to overwrite existing extents with
> the same type.
> 
> In addition, since cached extents can be more lenient than the extents
> they modify and do not involve modifying reserved blocks, it is not
> necessary to ensure that the insertion operation succeeds as strictly as
> in the ext4_es_insert_extent() function.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for writing this series! I think we can actually simplify things
event further. Extent status tree operations can be divided into three
groups:
1) Lookups in es tree - protected only by i_es_lock.
2) Caching of on-disk state into es tree - protected by i_es_lock and
   i_data_sem (at least in read mode).
3) Modification of existing state - protected by i_es_lock and i_data_sem
   in write mode.

Now because 2) has exclusion vs 3) due to i_data_sem, the observation is
that 2) should never see a real conflict - i.e., all intersecting entries
in es tree have the same status, otherwise this is a bug. So I think that 
ext4_es_cache_extent() should always walk the whole inserted range, verify
the statuses match and merge all these entries into a single one. This
isn't going to be slower than what we have today because your
__es_remove_extent(), __es_insert_extent() pair is effectively doing the
same thing, just without checking the statuses. That way we always get the
checking and also ext4_es_cache_extent() doesn't have to have the
overwriting and non-overwriting variant. What do you think?

								Honza

> ---
>  fs/ext4/extents.c        |  4 ++--
>  fs/ext4/extents_status.c | 28 +++++++++++++++++++++-------
>  fs/ext4/extents_status.h |  2 +-
>  3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index ca5499e9412b..c42ceb5aae37 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -537,12 +537,12 @@ static void ext4_cache_extents(struct inode *inode,
>  
>  		if (prev && (prev != lblk))
>  			ext4_es_cache_extent(inode, prev, lblk - prev, ~0,
> -					     EXTENT_STATUS_HOLE);
> +					     EXTENT_STATUS_HOLE, false);
>  
>  		if (ext4_ext_is_unwritten(ex))
>  			status = EXTENT_STATUS_UNWRITTEN;
>  		ext4_es_cache_extent(inode, lblk, len,
> -				     ext4_ext_pblock(ex), status);
> +				     ext4_ext_pblock(ex), status, false);
>  		prev = lblk + len;
>  	}
>  }
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 31dc0496f8d0..f9546ecf7340 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -986,13 +986,19 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  }
>  
>  /*
> - * ext4_es_cache_extent() inserts information into the extent status
> - * tree if and only if there isn't information about the range in
> - * question already.
> + * ext4_es_cache_extent() inserts extent information into the extent status
> + * tree. If 'overwrite' is not set, it inserts extent only if there isn't
> + * information about the specified range. Otherwise, it overwrites the
> + * current information.
> + *
> + * Note that this interface is only used for caching on-disk extent
> + * information and cannot be used to convert existing extents in the extent
> + * status tree. To convert existing extents, use ext4_es_insert_extent()
> + * instead.
>   */
>  void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  			  ext4_lblk_t len, ext4_fsblk_t pblk,
> -			  unsigned int status)
> +			  unsigned int status, bool overwrite)
>  {
>  	struct extent_status *es;
>  	struct extent_status newes;
> @@ -1012,10 +1018,18 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  	BUG_ON(end < lblk);
>  
>  	write_lock(&EXT4_I(inode)->i_es_lock);
> -
>  	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
> -	if (!es || es->es_lblk > end)
> -		__es_insert_extent(inode, &newes, NULL);
> +	if (es && es->es_lblk <= end) {
> +		if (!overwrite)
> +			goto unlock;
> +
> +		/* Only extents of the same type can be overwritten. */
> +		WARN_ON_ONCE(ext4_es_type(es) != status);
> +		if (__es_remove_extent(inode, lblk, end, NULL, NULL))
> +			goto unlock;
> +	}
> +	__es_insert_extent(inode, &newes, NULL);
> +unlock:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>  }
>  
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 8f9c008d11e8..415f7c223a46 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -139,7 +139,7 @@ extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  				  bool delalloc_reserve_used);
>  extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
>  				 ext4_lblk_t len, ext4_fsblk_t pblk,
> -				 unsigned int status);
> +				 unsigned int status, bool overwrite);
>  extern void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  				  ext4_lblk_t len);
>  extern void ext4_es_find_extent_range(struct inode *inode,
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

