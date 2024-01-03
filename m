Return-Path: <linux-fsdevel+bounces-7175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB7822C35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3D7B20E97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5118EA3;
	Wed,  3 Jan 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxFZQYy/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fUnTn6pQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RxFZQYy/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fUnTn6pQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D618E3C;
	Wed,  3 Jan 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E59A1FD14;
	Wed,  3 Jan 2024 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704281707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2Ep/9P5IZE4+G9Bla8dB5ARxYNh4FKlAPpzelC9JZc=;
	b=RxFZQYy/PubsTBXhBVW3caajDrl2NZe1K0VeYp4yf2+RGiobiqDqRLCmC+G+EqRjgvA3Q1
	St0aLMYw0A5Z1OTbQLh2lGlg4u1StbgG+XtsYxahLMpIrvxxu32Ft9E+0vdWiYuHi36c/y
	mXkFOYKXwaxUVIeBxSwBZVMKZne9WXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704281707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2Ep/9P5IZE4+G9Bla8dB5ARxYNh4FKlAPpzelC9JZc=;
	b=fUnTn6pQdk42beyQRROH+pwk/FIOdPOh+X7sxl4fB1qe7cqDdXo67GFUyvb7rmLS5U5pEr
	g4omNbgvGOiLsyDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704281707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2Ep/9P5IZE4+G9Bla8dB5ARxYNh4FKlAPpzelC9JZc=;
	b=RxFZQYy/PubsTBXhBVW3caajDrl2NZe1K0VeYp4yf2+RGiobiqDqRLCmC+G+EqRjgvA3Q1
	St0aLMYw0A5Z1OTbQLh2lGlg4u1StbgG+XtsYxahLMpIrvxxu32Ft9E+0vdWiYuHi36c/y
	mXkFOYKXwaxUVIeBxSwBZVMKZne9WXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704281707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w2Ep/9P5IZE4+G9Bla8dB5ARxYNh4FKlAPpzelC9JZc=;
	b=fUnTn6pQdk42beyQRROH+pwk/FIOdPOh+X7sxl4fB1qe7cqDdXo67GFUyvb7rmLS5U5pEr
	g4omNbgvGOiLsyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7247413AA6;
	Wed,  3 Jan 2024 11:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 46ffG2tGlWVCFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 11:35:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17BE2A07EF; Wed,  3 Jan 2024 12:35:06 +0100 (CET)
Date: Wed, 3 Jan 2024 12:35:06 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v2 06/25] ext4: make ext4_set_iomap() recognize
 IOMAP_DELALLOC map type
Message-ID: <20240103113506.kopblefmbkvs4twn@quack3>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
 <20240102123918.799062-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102123918.799062-7-yi.zhang@huaweicloud.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue 02-01-24 20:38:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since ext4_map_blocks() can recognize a delayed allocated only extent,
> make ext4_set_iomap() can also recognize it, and remove the useless
> separate check in ext4_iomap_begin_report().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 32 +++-----------------------------
>  1 file changed, 3 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c141bf6d8db2..0458d7f0c059 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3261,6 +3261,9 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  		iomap->addr = (u64) map->m_pblk << blkbits;
>  		if (flags & IOMAP_DAX)
>  			iomap->addr += EXT4_SB(inode->i_sb)->s_dax_part_off;
> +	} else if (map->m_flags & EXT4_MAP_DELAYED) {
> +		iomap->type = IOMAP_DELALLOC;
> +		iomap->addr = IOMAP_NULL_ADDR;
>  	} else {
>  		iomap->type = IOMAP_HOLE;
>  		iomap->addr = IOMAP_NULL_ADDR;
> @@ -3423,35 +3426,11 @@ const struct iomap_ops ext4_iomap_overwrite_ops = {
>  	.iomap_end		= ext4_iomap_end,
>  };
>  
> -static bool ext4_iomap_is_delalloc(struct inode *inode,
> -				   struct ext4_map_blocks *map)
> -{
> -	struct extent_status es;
> -	ext4_lblk_t offset = 0, end = map->m_lblk + map->m_len - 1;
> -
> -	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> -				  map->m_lblk, end, &es);
> -
> -	if (!es.es_len || es.es_lblk > end)
> -		return false;
> -
> -	if (es.es_lblk > map->m_lblk) {
> -		map->m_len = es.es_lblk - map->m_lblk;
> -		return false;
> -	}
> -
> -	offset = map->m_lblk - es.es_lblk;
> -	map->m_len = es.es_len - offset;
> -
> -	return true;
> -}
> -
>  static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  				   loff_t length, unsigned int flags,
>  				   struct iomap *iomap, struct iomap *srcmap)
>  {
>  	int ret;
> -	bool delalloc = false;
>  	struct ext4_map_blocks map;
>  	u8 blkbits = inode->i_blkbits;
>  
> @@ -3492,13 +3471,8 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
>  	ret = ext4_map_blocks(NULL, inode, &map, 0);
>  	if (ret < 0)
>  		return ret;
> -	if (ret == 0)
> -		delalloc = ext4_iomap_is_delalloc(inode, &map);
> -
>  set_iomap:
>  	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
> -	if (delalloc && iomap->type == IOMAP_HOLE)
> -		iomap->type = IOMAP_DELALLOC;
>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

