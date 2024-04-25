Return-Path: <linux-fsdevel+bounces-17807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D029C8B25C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 17:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018671C20BFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A514C59B;
	Thu, 25 Apr 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DgRuxTSK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oCaagx+/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DgRuxTSK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oCaagx+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7715E1CF8A;
	Thu, 25 Apr 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060605; cv=none; b=mOPicmK/HOWCgM21zPWDXKpprijRgj4pGXl7gKma+hHGDg3gFk09N4qyK5LM7O6Zsb92ouKU8QywHlS4mu91NS8rda2JYahnA2nauVpvD2sQaP0Qkn8HxS7TWp1vTy43tzDJAAMSuKHDmVwPGA9tdlAyoFeLihPKwUNwLoQ2Klo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060605; c=relaxed/simple;
	bh=rminTBqlI9Ejh5/fJ6myvWUCTfKYJWGA04MMjsdiw9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxXmoe/oWTRkPxQ5TMfRT7fB+tQ8OiARVRVxmbJpLd/qF871+PS/+Oml9v4aTa7+E7QE/bRWZPiZN5oXbOjZ0NVl+71ocIxOvabQSX/534eO8/dKi+0QEJIu86Y3xssJIcRhU+Hw8VWsbsQc8CdAlNcwD8rzj9vzm95GaPYK29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DgRuxTSK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oCaagx+/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DgRuxTSK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oCaagx+/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54BBF33F1F;
	Thu, 25 Apr 2024 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714060601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q9m8/hk1j+u8N+t6hPEwgeP01chLTSivyKGByuv6ng=;
	b=DgRuxTSKp4+3uQrw3RPS6ZCzegxf7Yw8dw8Rb6SG6VqWFzO5NAGc0cP2n76FwIK7ynZcmz
	Ney5MVb114c3Ad1rLG+4i9spTtobD5fPbEEuMsetF2ttQuXWpaSFs1LJhffL0stUf52Jj9
	pPVay+pp0l03Rb3TS/QOPI9oLcqMReE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714060601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q9m8/hk1j+u8N+t6hPEwgeP01chLTSivyKGByuv6ng=;
	b=oCaagx+/fKSnXJyLknWs05M0hCLQ+NLfz9l5RBD6xgkqmeXLfzHVXByckDa46NQiemPg/g
	T7Lo76ja+dtFe+Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714060601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q9m8/hk1j+u8N+t6hPEwgeP01chLTSivyKGByuv6ng=;
	b=DgRuxTSKp4+3uQrw3RPS6ZCzegxf7Yw8dw8Rb6SG6VqWFzO5NAGc0cP2n76FwIK7ynZcmz
	Ney5MVb114c3Ad1rLG+4i9spTtobD5fPbEEuMsetF2ttQuXWpaSFs1LJhffL0stUf52Jj9
	pPVay+pp0l03Rb3TS/QOPI9oLcqMReE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714060601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q9m8/hk1j+u8N+t6hPEwgeP01chLTSivyKGByuv6ng=;
	b=oCaagx+/fKSnXJyLknWs05M0hCLQ+NLfz9l5RBD6xgkqmeXLfzHVXByckDa46NQiemPg/g
	T7Lo76ja+dtFe+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BC0C1393C;
	Thu, 25 Apr 2024 15:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D4p2Ejl9Kma8GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Apr 2024 15:56:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2C73A0861; Thu, 25 Apr 2024 17:56:40 +0200 (CEST)
Date: Thu, 25 Apr 2024 17:56:40 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/9] ext4: trim delalloc extent
Message-ID: <20240425155640.ktvqqwhteitysaby@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-4-yi.zhang@huaweicloud.com>
X-Spam-Level: ****
X-Spamd-Result: default: False [4.30 / 50.00];
	BAYES_SPAM(5.10)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: 4.30
X-Spam-Flag: NO

On Wed 10-04-24 11:41:57, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The cached delalloc or hole extent should be trimed to the map->map_len
> if we map delalloc blocks in ext4_da_map_blocks(). But it doesn't
> trigger any issue now because the map->m_len is always set to one and we
> always insert one delayed block once a time. Fix this by trim the extent
> once we get one from the cached extent tree, prearing for mapping a
> extent with multiple delalloc blocks.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Well, but we already do the trimming in ext4_da_map_blocks(), don't we? You
just move it to a different place... Or do you mean that we actually didn't
set 'map' at all in some cases and now we do? In either case the 'map'
handling looks a bit sloppy in ext4_da_map_blocks() as e.g. the
'add_delayed' case doesn't seem to bother with properly setting 'map' based
on what it does. So maybe we should clean that up to always set 'map' just
before returning at the same place where we update the 'bh'? And maybe bh
update could be updated in some common helper because it's content is
determined by the 'map' content?

								Honza

> ---
>  fs/ext4/inode.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 118b0497a954..e4043ddb07a5 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1734,6 +1734,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  
>  	/* Lookup extent status tree firstly */
>  	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
> +		retval = es.es_len - (iblock - es.es_lblk);
> +		if (retval > map->m_len)
> +			retval = map->m_len;
> +		map->m_len = retval;
> +
>  		if (ext4_es_is_hole(&es))
>  			goto add_delayed;
>  
> @@ -1750,10 +1755,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  		}
>  
>  		map->m_pblk = ext4_es_pblock(&es) + iblock - es.es_lblk;
> -		retval = es.es_len - (iblock - es.es_lblk);
> -		if (retval > map->m_len)
> -			retval = map->m_len;
> -		map->m_len = retval;
>  		if (ext4_es_is_written(&es))
>  			map->m_flags |= EXT4_MAP_MAPPED;
>  		else if (ext4_es_is_unwritten(&es))
> @@ -1788,6 +1789,11 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  	 * whitout holding i_rwsem and folio lock.
>  	 */
>  	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
> +		retval = es.es_len - (iblock - es.es_lblk);
> +		if (retval > map->m_len)
> +			retval = map->m_len;
> +		map->m_len = retval;
> +
>  		if (!ext4_es_is_hole(&es)) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			goto found;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

