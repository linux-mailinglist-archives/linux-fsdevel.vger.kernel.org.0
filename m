Return-Path: <linux-fsdevel+bounces-28530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9FB96B842
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6489F1C21C75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168E1CF5E7;
	Wed,  4 Sep 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QHWBMeez";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EWjdTdTL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZIOjC+E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ZStil5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7D1CF5C3;
	Wed,  4 Sep 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445374; cv=none; b=XQS2v1gBwnWrWrohBYaYxMWRWvFj2Yr8GRIRD7kTEqHtMEpIkeo4U9308UmHZaUfhXQ5ETTmY6wCqE3EeNf2VUrrZQyY0owTsar341HaxO1zra6op1+0JoQu/sQ1+d8MdYrwNyogQadqX+P9OW6/BOVDcKOlyMv84udpnbpPB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445374; c=relaxed/simple;
	bh=+Z9rUzJJ2EslWFIE43FLoqRiRs7FsXiOaKfnFjYYcag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8KzHxaFCgR6s3v1edZgHTa9Y+GawyOL5wdb4sXxsgN6LoN842kJMtnB1x/FDXtikS5DBE4hCnIan5gjRfYcn7+fCOxvHzEEVJs7Ec29/4TfxsJPi+5LxBZSyV8HwOymfM1j5bDM4sEHWkgh24RsrDYaH7cVsdgewP7Phlgd3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QHWBMeez; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EWjdTdTL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZIOjC+E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ZStil5r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F14B0219D2;
	Wed,  4 Sep 2024 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOl7QfOxycHkfw9C2wu0StbOWo++oEUZUEuQFl1DuGI=;
	b=QHWBMeezFSyPrPQxhno/X7KJvlc3ZEpPRaWI+O16Vbz40HudSMAwpKQYhk2TD7kd7tydlQ
	8qcSpfCd0frny2cyJy6EnsLNgzpPdO6Zl+42R8hEVU/U7BpZi2vZag3ramvt4Ybg8D8uBf
	nQO9w9p1zjTUFnJ86Imo6XM+45KnuZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOl7QfOxycHkfw9C2wu0StbOWo++oEUZUEuQFl1DuGI=;
	b=EWjdTdTL2JMiM/9M+J/Yv43m3IqlUSC5oXqlPgVSOTQWu73km/FuJCXFbebDKnwpe1S3je
	pjzwgad3LhsgBhAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOl7QfOxycHkfw9C2wu0StbOWo++oEUZUEuQFl1DuGI=;
	b=sZIOjC+Ey19+wjlVDZvVloSOkWQ3CD5Qsyd52L/5mdlxFSigzryuEqhp8YQRkdpxHNZgcs
	YtkgKCc4dGo9Z72cjRewi96yIO0Vk+ZchtT2m41SrygYAbR2qJdZZixyl85xMVgTjw+jT7
	qY5xcQWvBSY+7NsQLVBJJzdMENFqkhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vOl7QfOxycHkfw9C2wu0StbOWo++oEUZUEuQFl1DuGI=;
	b=9ZStil5r+vV1YPTo7Bl47hTA98bxjtn7flHPR4DH3RRhu/nw5ZZJRY2gsTY+HrZviSntVQ
	4974dAP6tNwBuNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA694139D2;
	Wed,  4 Sep 2024 10:22:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wn5QNfg02Ga6JwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:22:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7A70DA0968; Wed,  4 Sep 2024 12:22:44 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:22:44 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 06/12] ext4: update delalloc data reserve spcae in
 ext4_es_insert_extent()
Message-ID: <20240904102244.ekzzhbwnzbtpeyjw@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-7-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 13-08-24 20:34:46, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Now that we update data reserved space for delalloc after allocating
> new blocks in ext4_{ind|ext}_map_blocks(), and if bigalloc feature is
> enabled, we also need to query the extents_status tree to calculate the
> exact reserved clusters. This is complicated now and it appears that
> it's better to do this job in ext4_es_insert_extent(), because
> __es_remove_extent() have already count delalloc blocks when removing
> delalloc extents and __revise_pending() return new adding pending count,
> we could update the reserved blocks easily in ext4_es_insert_extent().
> 
> We direct reduce the reserved cluster count when replacing a delalloc
> extent. However, thers are two special cases need to concern about the
> quota claiming when doing direct block allocation (e.g. from fallocate).
> 
> A),
> fallocate a range that covers a delalloc extent but start with
> non-delayed allocated blocks, e.g. a hole.
> 
>   hhhhhhh+ddddddd+ddddddd
>   ^^^^^^^^^^^^^^^^^^^^^^^  fallocate this range
> 
> Current ext4_map_blocks() can't always trim the extent since it may
> release i_data_sem before calling ext4_map_create_blocks() and raced by
> another delayed allocation. Hence the EXT4_GET_BLOCKS_DELALLOC_RESERVE
> may not set even when we are replacing a delalloc extent, without this
> flag set, the quota has already been claimed by ext4_mb_new_blocks(), so
> we should release the quota reservations instead of claim them again.
> 
> B),
> bigalloc feature is enabled, fallocate a range that contains non-delayed
> allocated blocks.
> 
>   |<         one cluster       >|
>   hhhhhhh+hhhhhhh+hhhhhhh+ddddddd
>   ^^^^^^^  fallocate this range
> 
> This case is similar to above case, the EXT4_GET_BLOCKS_DELALLOC_RESERVE
> flag is also not set.
> 
> Hence we should release the quota reservations if we replace a delalloc
> extent but without EXT4_GET_BLOCKS_DELALLOC_RESERVE set.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I really like how simple this ended being! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c        | 37 -------------------------------------
>  fs/ext4/extents_status.c | 25 ++++++++++++++++++++++++-
>  fs/ext4/indirect.c       |  7 -------
>  3 files changed, 24 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 671dacd7c873..db8f9d79477c 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4357,43 +4357,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  		goto out;
>  	}
>  
> -	/*
> -	 * Reduce the reserved cluster count to reflect successful deferred
> -	 * allocation of delayed allocated clusters or direct allocation of
> -	 * clusters discovered to be delayed allocated.  Once allocated, a
> -	 * cluster is not included in the reserved count.
> -	 */
> -	if (test_opt(inode->i_sb, DELALLOC) && allocated_clusters) {
> -		if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) {
> -			/*
> -			 * When allocating delayed allocated clusters, simply
> -			 * reduce the reserved cluster count and claim quota
> -			 */
> -			ext4_da_update_reserve_space(inode, allocated_clusters,
> -							1);
> -		} else {
> -			ext4_lblk_t lblk, len;
> -			unsigned int n;
> -
> -			/*
> -			 * When allocating non-delayed allocated clusters
> -			 * (from fallocate, filemap, DIO, or clusters
> -			 * allocated when delalloc has been disabled by
> -			 * ext4_nonda_switch), reduce the reserved cluster
> -			 * count by the number of allocated clusters that
> -			 * have previously been delayed allocated.  Quota
> -			 * has been claimed by ext4_mb_new_blocks() above,
> -			 * so release the quota reservations made for any
> -			 * previously delayed allocated clusters.
> -			 */
> -			lblk = EXT4_LBLK_CMASK(sbi, map->m_lblk);
> -			len = allocated_clusters << sbi->s_cluster_bits;
> -			n = ext4_es_delayed_clu(inode, lblk, len);
> -			if (n > 0)
> -				ext4_da_update_reserve_space(inode, (int) n, 0);
> -		}
> -	}
> -
>  	/*
>  	 * Cache the extent and update transaction to commit on fdatasync only
>  	 * when it is _not_ an unwritten extent.
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 0580bc4bc762..41adf0d69959 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -853,6 +853,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status newes;
>  	ext4_lblk_t end = lblk + len - 1;
>  	int err1 = 0, err2 = 0, err3 = 0;
> +	int resv_used = 0, pending = 0;
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct extent_status *es1 = NULL;
>  	struct extent_status *es2 = NULL;
> @@ -891,7 +892,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  		pr = __alloc_pending(true);
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  
> -	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
> +	err1 = __es_remove_extent(inode, lblk, end, &resv_used, es1);
>  	if (err1 != 0)
>  		goto error;
>  	/* Free preallocated extent if it didn't get used. */
> @@ -921,9 +922,31 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  			__free_pending(pr);
>  			pr = NULL;
>  		}
> +		pending = err3;
>  	}
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> +	/*
> +	 * Reduce the reserved cluster count to reflect successful deferred
> +	 * allocation of delayed allocated clusters or direct allocation of
> +	 * clusters discovered to be delayed allocated.  Once allocated, a
> +	 * cluster is not included in the reserved count.
> +	 *
> +	 * When direct allocating (from fallocate, filemap, DIO, or clusters
> +	 * allocated when delalloc has been disabled by ext4_nonda_switch())
> +	 * an extent either 1) contains delayed blocks but start with
> +	 * non-delayed allocated blocks (e.g. hole) or 2) contains non-delayed
> +	 * allocated blocks which belong to delayed allocated clusters when
> +	 * bigalloc feature is enabled, quota has already been claimed by
> +	 * ext4_mb_new_blocks(), so release the quota reservations made for
> +	 * any previously delayed allocated clusters instead of claim them
> +	 * again.
> +	 */
> +	resv_used += pending;
> +	if (resv_used)
> +		ext4_da_update_reserve_space(inode, resv_used,
> +				flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE);
> +
>  	if (err1 || err2 || err3 < 0)
>  		goto retry;
>  
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index d8ca7f64f952..7404f0935c90 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -652,13 +652,6 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
>  	count = ar.len;
>  
> -	/*
> -	 * Update reserved blocks/metadata blocks after successful block
> -	 * allocation which had been deferred till now.
> -	 */
> -	if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> -		ext4_da_update_reserve_space(inode, count, 1);
> -
>  got_it:
>  	map->m_flags |= EXT4_MAP_MAPPED;
>  	map->m_pblk = le32_to_cpu(chain[depth-1].key);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

