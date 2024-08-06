Return-Path: <linux-fsdevel+bounces-25117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0157094946C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C581F25FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AF1F937;
	Tue,  6 Aug 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d9oj+hsK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="arOjqBWZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d9oj+hsK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="arOjqBWZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F831799B;
	Tue,  6 Aug 2024 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957812; cv=none; b=bKzrEKR6EKqBaZ5fzsdloL1v//Xa1wQSpjePH6KZx6mZQyaHwt5f9CauEUutS+AFa0Itc6eJAx/kHRpZfWvIrqF/VXJRkFOOrK23O+7s7wOUL9rISiWT+koHD7fMg6EnL+SKVAUmDZkdcmnXejsicQCCsv4NC6d2UvnocOJ4mlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957812; c=relaxed/simple;
	bh=8kg3mfOpz7+Ec8CDih/G148yH0fU1Yxbw2ii02mQFa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIMS9UFJbF5miPn12BxbeGtia3N4sRYP0sQe1N2Lme9ihEWR8cyL47BbpL0OtyN4P6AlWD4HtWtor6g/ugR1UsnBxJnO62yDMKkUHb1lIv4RK41KzZkr6PZscVufrcgfJ7KqgLWSiicLcB5Z4GdLNntr+/ki4F5xMl7bspaxhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d9oj+hsK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=arOjqBWZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d9oj+hsK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=arOjqBWZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C53C21C38;
	Tue,  6 Aug 2024 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722957808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ekoGVZj6up6oDDMQ3dNZnr/+091be6k7VqzVnNRuMA=;
	b=d9oj+hsKNO4ngzpH/88pFbicELhXBTY0IF71+3gXs/cky2yZvJYndhLj+YW4yX7dVD67jk
	K2J27ZuZn5U0n+ehA+FDtaGENTiEhAoVkqAeB15Cksf4gq2HNV0bqPO4JiuUVWbZgBCtIp
	ViGM4l5Snt+SzzRTgAQjYuh+uvskc+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722957808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ekoGVZj6up6oDDMQ3dNZnr/+091be6k7VqzVnNRuMA=;
	b=arOjqBWZXtwB9JndLjIbtxpvOUBLf8No5veJ/vlQ60TgXR4g0vkatma5Icr1UqCimNI4K6
	dYIuf3XnCX0hVeAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d9oj+hsK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=arOjqBWZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722957808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ekoGVZj6up6oDDMQ3dNZnr/+091be6k7VqzVnNRuMA=;
	b=d9oj+hsKNO4ngzpH/88pFbicELhXBTY0IF71+3gXs/cky2yZvJYndhLj+YW4yX7dVD67jk
	K2J27ZuZn5U0n+ehA+FDtaGENTiEhAoVkqAeB15Cksf4gq2HNV0bqPO4JiuUVWbZgBCtIp
	ViGM4l5Snt+SzzRTgAQjYuh+uvskc+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722957808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ekoGVZj6up6oDDMQ3dNZnr/+091be6k7VqzVnNRuMA=;
	b=arOjqBWZXtwB9JndLjIbtxpvOUBLf8No5veJ/vlQ60TgXR4g0vkatma5Icr1UqCimNI4K6
	dYIuf3XnCX0hVeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E23813981;
	Tue,  6 Aug 2024 15:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ASYnD/A/smYqawAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Aug 2024 15:23:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9626A0762; Tue,  6 Aug 2024 17:23:27 +0200 (CEST)
Date: Tue, 6 Aug 2024 17:23:27 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 03/10] ext4: don't set EXTENT_STATUS_DELAYED on
 allocated blocks
Message-ID: <20240806152327.td572f7elpel4aeo@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802115120.362902-4-yi.zhang@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 4C53C21C38
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 0.49

On Fri 02-08-24 19:51:13, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we always set EXT4_GET_BLOCKS_DELALLOC_RESERVE when allocating
> delalloc blocks, there is no need to keep delayed flag on the unwritten
> extent status entry, so just drop it after allocation.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Let me improve the changelog because I was confused for some time before I
understood:

Currently, we release delayed allocation reservation when removing delayed
extent from extent status tree (which also happens when overwriting one
extent with another one). When we allocated unwritten extent under
some delayed allocated extent, we don't need the reservation anymore and
hence we don't need to preserve the EXT4_MAP_DELAYED status bit. Inserting
the new extent into extent status tree will properly release the
reservation.

Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 91b2610a6dc5..e9ce1e4e6acb 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -558,12 +558,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  
>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -	if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
> -	    !(status & EXTENT_STATUS_WRITTEN) &&
> -	    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
> -			       map->m_lblk + map->m_len - 1))
> -		status |= EXTENT_STATUS_DELAYED;
> -
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>  			      map->m_pblk, status);
>  
> @@ -682,11 +676,6 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  
>  		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -		if (!(flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE) &&
> -		    !(status & EXTENT_STATUS_WRITTEN) &&
> -		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
> -				       map->m_lblk + map->m_len - 1))
> -			status |= EXTENT_STATUS_DELAYED;
>  		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>  				      map->m_pblk, status);
>  	}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

