Return-Path: <linux-fsdevel+bounces-7172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71951822BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FC1B2208D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DB618E12;
	Wed,  3 Jan 2024 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="osrUd+eO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="paJRFk/1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="osrUd+eO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="paJRFk/1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0118E00;
	Wed,  3 Jan 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9940B21AA4;
	Wed,  3 Jan 2024 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704279857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vmqWz431b4Agc8sUx/1iVlhop5JHKRGoznG+9WmKGQ=;
	b=osrUd+eOrvhE25pP8ZVihRw8LogVo3ntGpsvuGJHGGhvt7y4gxAcJ2UAR+tRR3Nl8bkERW
	3AabOqPA8jrWbwF7SQjD03c/L65WQ39AA7aaMSaZZmw4k/iZEuyVS0AWKWnYNWlGptolHF
	bdh6h5oPhu0lU/Em6Eq7vXZnEvS4i2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704279857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vmqWz431b4Agc8sUx/1iVlhop5JHKRGoznG+9WmKGQ=;
	b=paJRFk/19z5gt+Ig9jjSZjt67hayIV2VGRN+ovfD+E7vEwA5kxv+v68K5djSu6QLEOZZo/
	TPmAbV14bTU6mdBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704279857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vmqWz431b4Agc8sUx/1iVlhop5JHKRGoznG+9WmKGQ=;
	b=osrUd+eOrvhE25pP8ZVihRw8LogVo3ntGpsvuGJHGGhvt7y4gxAcJ2UAR+tRR3Nl8bkERW
	3AabOqPA8jrWbwF7SQjD03c/L65WQ39AA7aaMSaZZmw4k/iZEuyVS0AWKWnYNWlGptolHF
	bdh6h5oPhu0lU/Em6Eq7vXZnEvS4i2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704279857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8vmqWz431b4Agc8sUx/1iVlhop5JHKRGoznG+9WmKGQ=;
	b=paJRFk/19z5gt+Ig9jjSZjt67hayIV2VGRN+ovfD+E7vEwA5kxv+v68K5djSu6QLEOZZo/
	TPmAbV14bTU6mdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 738C51340C;
	Wed,  3 Jan 2024 11:04:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tOcxHDE/lWXfCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 11:04:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 336DEA07EF; Wed,  3 Jan 2024 12:04:17 +0100 (CET)
Date: Wed, 3 Jan 2024 12:04:17 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v2 04/25] ext4: add a hole extent entry in cache
 after punch
Message-ID: <20240103110417.6del4dd3ulraikcz@quack3>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
 <20240102123918.799062-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102123918.799062-5-yi.zhang@huaweicloud.com>
X-Spam-Level: *
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.26 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.45)[78.89%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=osrUd+eO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="paJRFk/1"
X-Spam-Score: -0.26
X-Rspamd-Queue-Id: 9940B21AA4

On Tue 02-01-24 20:38:57, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In order to cache hole extents in the extent status tree and keep the
> hole length as long as possible, re-add a hole entry to the cache just
> after punching a hole.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 142c67f5c7fc..1b5e6409f958 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4000,12 +4000,12 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	/* If there are blocks to remove, do it */
>  	if (stop_block > first_block) {
> +		ext4_lblk_t hole_len = stop_block - first_block;
>  
>  		down_write(&EXT4_I(inode)->i_data_sem);
>  		ext4_discard_preallocations(inode, 0);
>  
> -		ext4_es_remove_extent(inode, first_block,
> -				      stop_block - first_block);
> +		ext4_es_remove_extent(inode, first_block, hole_len);
>  
>  		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  			ret = ext4_ext_remove_space(inode, first_block,
> @@ -4014,6 +4014,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  			ret = ext4_ind_remove_space(handle, inode, first_block,
>  						    stop_block);
>  
> +		ext4_es_insert_extent(inode, first_block, hole_len, ~0,
> +				      EXTENT_STATUS_HOLE);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  	}
>  	ext4_fc_track_range(handle, inode, first_block, stop_block);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

