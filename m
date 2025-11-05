Return-Path: <linux-fsdevel+bounces-67076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217C9C34D2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 10:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60983BFE16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 09:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280892FCC1E;
	Wed,  5 Nov 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L/5v6uA4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ntew6u+s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mGFNUeh0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wqB1cCja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3D2FA0D3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334329; cv=none; b=AtuCyzWMF0yoPAOOsxHUPpi2p8ss85H3wQa0W7otY8NiVbC7pZ+mqHjnNfQd0y/1xWgRVvzqwsPjVuJGMti8GyS8oMolPJY60HCzPkPgieq8brJodEQ9AMrOJCASQEaB5TAGxVnssY0SQhKDG7UMh0hvGsF57EF0sABwFhYlLkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334329; c=relaxed/simple;
	bh=+JqqFvTmCpNBwqHgRg2NZsakqCExA0Dnjs9Ogu3eFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5toMcssHAEF7mG5bh70TVxAfnPmWVb3rwoC07IE/jrj+8B94Olipn5Ks2lMxPpZrRw2xKpNDR0L7eqZghGZqMgCRx/ZQzqNs9UUe6/xX9O24NwSOZYkDofXZenNGu10X7YTtGWTA7U5Hl4hDGrXrqK7ZZ6v+3MjRNfPF2g3Ilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L/5v6uA4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ntew6u+s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mGFNUeh0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wqB1cCja; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C54941F394;
	Wed,  5 Nov 2025 09:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUHNWHY9N3N9CS8EUbNMZ/Hd+PugtBGD/ByWJUAr0TI=;
	b=L/5v6uA4jQmSUe+rmgFBMs0e+y2W37fa7N280Puhbcx39WTudZhEP8yb73+Kh3PaDt3Dpr
	WN/EDq/88YX9ff4cM0s+7dFKXUxR5lKDMDbsk8CUutWp72U0VW0I340ELI8aNXZs935Cn2
	GZOdEA1hTEo1AYEnc3u7eQ7v4opA87w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUHNWHY9N3N9CS8EUbNMZ/Hd+PugtBGD/ByWJUAr0TI=;
	b=Ntew6u+sECbXiA5T5xacYOSTY5OVu0yTDT/4kR8DOnxfwC19o2aWC1J1OGC//T9+6vkdMo
	OIKnIlMg1U//vKDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mGFNUeh0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wqB1cCja
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762334325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUHNWHY9N3N9CS8EUbNMZ/Hd+PugtBGD/ByWJUAr0TI=;
	b=mGFNUeh0F0IXW9J44zNqtXoSYn8Iv/jo4aVX6RTO5WxoiSp4Ac4FxuLPj4JEPniue7pXlk
	qSumBQF3S5UC4cn0a7d6F8tnhlhf3mXCmtXBRtXjZ17onU2xEGnx3HLh5REZ+9KiXBufPz
	fc2H4UnNVKqcyW498Od7EYm564lyRZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762334325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUHNWHY9N3N9CS8EUbNMZ/Hd+PugtBGD/ByWJUAr0TI=;
	b=wqB1cCja5TwBB4BQFUcTqubtIQ0/vgQreTWbmreJZ9MI/nryCjIlyhENWTiKDFCj29ycjE
	q4+9xbce/WUxcGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BABE5132DD;
	Wed,  5 Nov 2025 09:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id reiVLXUWC2lPEgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Nov 2025 09:18:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74665A083B; Wed,  5 Nov 2025 10:18:45 +0100 (CET)
Date: Wed, 5 Nov 2025 10:18:45 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	libaokun1@huawei.com
Subject: Re: [PATCH 13/25] ext4: support large block size in
 ext4_mb_init_cache()
Message-ID: <n3jvaazkla3usq5vx4kxsfkr33d2mwm4eu7xpgf7qssktmjwgu@btxoicdj3vrr>
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-14-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025032221.2905818-14-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: C54941F394
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,huawei.com:email,suse.com:email]
X-Spamd-Bar: /

On Sat 25-10-25 11:22:09, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Currently, ext4_mb_init_cache() uses blocks_per_page to calculate the
> folio index and offset. However, when blocksize is larger than PAGE_SIZE,
> blocks_per_page becomes zero, leading to a potential division-by-zero bug.
> 
> Since we now have the folio, we know its exact size. This allows us to
> convert {blocks, groups}_per_page to {blocks, groups}_per_folio, thus
> supporting block sizes greater than page size.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 44 ++++++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d42d768a705a..31f4c7d65eb4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1329,26 +1329,25 @@ static void mb_regenerate_buddy(struct ext4_buddy *e4b)
>   * block bitmap and buddy information. The information are
>   * stored in the inode as
>   *
> - * {                        page                        }
> + * {                        folio                        }
>   * [ group 0 bitmap][ group 0 buddy] [group 1][ group 1]...
>   *
>   *
>   * one block each for bitmap and buddy information.
> - * So for each group we take up 2 blocks. A page can
> - * contain blocks_per_page (PAGE_SIZE / blocksize)  blocks.
> - * So it can have information regarding groups_per_page which
> - * is blocks_per_page/2
> + * So for each group we take up 2 blocks. A folio can
> + * contain blocks_per_folio (folio_size / blocksize)  blocks.
> + * So it can have information regarding groups_per_folio which
> + * is blocks_per_folio/2
>   *
>   * Locking note:  This routine takes the block group lock of all groups
> - * for this page; do not hold this lock when calling this routine!
> + * for this folio; do not hold this lock when calling this routine!
>   */
> -
>  static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>  {
>  	ext4_group_t ngroups;
>  	unsigned int blocksize;
> -	int blocks_per_page;
> -	int groups_per_page;
> +	int blocks_per_folio;
> +	int groups_per_folio;
>  	int err = 0;
>  	int i;
>  	ext4_group_t first_group, group;
> @@ -1365,27 +1364,24 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>  	sb = inode->i_sb;
>  	ngroups = ext4_get_groups_count(sb);
>  	blocksize = i_blocksize(inode);
> -	blocks_per_page = PAGE_SIZE / blocksize;
> +	blocks_per_folio = folio_size(folio) / blocksize;
> +	WARN_ON_ONCE(!blocks_per_folio);
> +	groups_per_folio = DIV_ROUND_UP(blocks_per_folio, 2);
>  
>  	mb_debug(sb, "init folio %lu\n", folio->index);
>  
> -	groups_per_page = blocks_per_page >> 1;
> -	if (groups_per_page == 0)
> -		groups_per_page = 1;
> -
>  	/* allocate buffer_heads to read bitmaps */
> -	if (groups_per_page > 1) {
> -		i = sizeof(struct buffer_head *) * groups_per_page;
> +	if (groups_per_folio > 1) {
> +		i = sizeof(struct buffer_head *) * groups_per_folio;
>  		bh = kzalloc(i, gfp);
>  		if (bh == NULL)
>  			return -ENOMEM;
>  	} else
>  		bh = &bhs;
>  
> -	first_group = folio->index * blocks_per_page / 2;
> -
>  	/* read all groups the folio covers into the cache */
> -	for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
> +	first_group = EXT4_P_TO_LBLK(inode, folio->index) / 2;
> +	for (i = 0, group = first_group; i < groups_per_folio; i++, group++) {
>  		if (group >= ngroups)
>  			break;
>  
> @@ -1393,7 +1389,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>  		if (!grinfo)
>  			continue;
>  		/*
> -		 * If page is uptodate then we came here after online resize
> +		 * If folio is uptodate then we came here after online resize
>  		 * which added some new uninitialized group info structs, so
>  		 * we must skip all initialized uptodate buddies on the folio,
>  		 * which may be currently in use by an allocating task.
> @@ -1413,7 +1409,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>  	}
>  
>  	/* wait for I/O completion */
> -	for (i = 0, group = first_group; i < groups_per_page; i++, group++) {
> +	for (i = 0, group = first_group; i < groups_per_folio; i++, group++) {
>  		int err2;
>  
>  		if (!bh[i])
> @@ -1423,8 +1419,8 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>  			err = err2;
>  	}
>  
> -	first_block = folio->index * blocks_per_page;
> -	for (i = 0; i < blocks_per_page; i++) {
> +	first_block = EXT4_P_TO_LBLK(inode, folio->index);
> +	for (i = 0; i < blocks_per_folio; i++) {
>  		group = (first_block + i) >> 1;
>  		if (group >= ngroups)
>  			break;
> @@ -1501,7 +1497,7 @@ static int ext4_mb_init_cache(struct folio *folio, char *incore, gfp_t gfp)
>  
>  out:
>  	if (bh) {
> -		for (i = 0; i < groups_per_page; i++)
> +		for (i = 0; i < groups_per_folio; i++)
>  			brelse(bh[i]);
>  		if (bh != &bhs)
>  			kfree(bh);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

