Return-Path: <linux-fsdevel+bounces-18072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237CE8B526A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4501F21A96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE8714A98;
	Mon, 29 Apr 2024 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZVlL78X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sq4E28UL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZVlL78X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sq4E28UL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E912E70;
	Mon, 29 Apr 2024 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714376081; cv=none; b=j2y5bP8rxrIxBx25J1hJ5hcQ2vcL5zzoCXiFIhYLzc0nXIVWGBaTeGVUO4IAbdGIHtpt/aIw2Hx4JRZCFyebi2N0REcJe30r80Wc9e0Ei6/E3J0f0oj0fst6OHhk9GhsOtcReUnX5erFXugcYDMpzB47+jtvKnA4sfm7+fsPAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714376081; c=relaxed/simple;
	bh=2xCgxt+SsLDnRwXH2d+bCIfyo4DmN2AZ9VLWDQ5Ic7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDFGSHc7kFxlMT4kl7zUeGvqRcB7sJOBF19m6JvgFXrmnV2lBCVXnMCndsNTGOnJ1y22lsLDYDsS7L6u94PIdfMzMc6svWuArls6+BkX7d4oqWUJqxyUvcM9vI5/Bsa3MEBtVIwpkO/Q+oGmH1MXSJXitWvn/ygqieKAJ2dx9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZVlL78X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sq4E28UL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZVlL78X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sq4E28UL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 644E822A8F;
	Mon, 29 Apr 2024 07:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714376077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGx/ylCmVxhvoe50C+EZpKaNVRUM0HVbXzxEoJJkY/k=;
	b=GZVlL78Xt+BeDNkLAVVOC8RhHEvhk1qO1G1oXQGdntqVFMItYNhmIhh2guQbyQrNqfnQcE
	RtC3hENZo3IJRVLGF7E18mOEdCabXMA/45qltCVdDXuU1nKgz+K4benCe6C7O8Zkdijtsr
	QTMqpbjCelPswhj+BGONSQ8QaW4T1ZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714376077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGx/ylCmVxhvoe50C+EZpKaNVRUM0HVbXzxEoJJkY/k=;
	b=sq4E28UL7Y7sGANwRY92lgR4uaJizGrPQuSxMN08XATOb2MPvr84XjKINcAswdZTdHyuDd
	jn4Nzukh+Fb7joDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GZVlL78X;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sq4E28UL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714376077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGx/ylCmVxhvoe50C+EZpKaNVRUM0HVbXzxEoJJkY/k=;
	b=GZVlL78Xt+BeDNkLAVVOC8RhHEvhk1qO1G1oXQGdntqVFMItYNhmIhh2guQbyQrNqfnQcE
	RtC3hENZo3IJRVLGF7E18mOEdCabXMA/45qltCVdDXuU1nKgz+K4benCe6C7O8Zkdijtsr
	QTMqpbjCelPswhj+BGONSQ8QaW4T1ZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714376077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGx/ylCmVxhvoe50C+EZpKaNVRUM0HVbXzxEoJJkY/k=;
	b=sq4E28UL7Y7sGANwRY92lgR4uaJizGrPQuSxMN08XATOb2MPvr84XjKINcAswdZTdHyuDd
	jn4Nzukh+Fb7joDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 563C1139DE;
	Mon, 29 Apr 2024 07:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LMyzFI1NL2YSeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 07:34:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2B46A082F; Mon, 29 Apr 2024 09:34:32 +0200 (CEST)
Date: Mon, 29 Apr 2024 09:34:32 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 4/9] ext4: drop iblock parameter
Message-ID: <20240429073432.lvv4fll7gmeupxm6@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-5-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 644E822A8F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 10-04-24 11:41:58, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The start block of the delalloc extent to be inserted is equal to
> map->m_lblk, just drop the duplicate iblock input parameter.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e4043ddb07a5..cccc16506f5f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1712,8 +1712,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>   * time. This function looks up the requested blocks and sets the
>   * buffer delay bit under the protection of i_data_sem.
>   */
> -static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
> -			      struct ext4_map_blocks *map,
> +static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  			      struct buffer_head *bh)
>  {
>  	struct extent_status es;
> @@ -1733,8 +1732,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  		  (unsigned long) map->m_lblk);
>  
>  	/* Lookup extent status tree firstly */
> -	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
> -		retval = es.es_len - (iblock - es.es_lblk);
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +		retval = es.es_len - (map->m_lblk - es.es_lblk);
>  		if (retval > map->m_len)
>  			retval = map->m_len;
>  		map->m_len = retval;
> @@ -1754,7 +1753,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  			return 0;
>  		}
>  
> -		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
> +		map->m_pblk = ext4_es_pblock(&es) + map->m_lblk - es.es_lblk;
>  		if (ext4_es_is_written(&es))
>  			map->m_flags |= EXT4_MAP_MAPPED;
>  		else if (ext4_es_is_unwritten(&es))
> @@ -1788,8 +1787,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  	 * inserting delalloc range haven't been delayed or allocated
>  	 * whitout holding i_rwsem and folio lock.
>  	 */
> -	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
> -		retval = es.es_len - (iblock - es.es_lblk);
> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> +		retval = es.es_len - (map->m_lblk - es.es_lblk);
>  		if (retval > map->m_len)
>  			retval = map->m_len;
>  		map->m_len = retval;
> @@ -1846,7 +1845,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
>  	 * preallocated blocks are unmapped but should treated
>  	 * the same as allocated blocks.
>  	 */
> -	ret = ext4_da_map_blocks(inode, iblock, &map, bh);
> +	ret = ext4_da_map_blocks(inode, &map, bh);
>  	if (ret <= 0)
>  		return ret;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

