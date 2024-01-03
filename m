Return-Path: <linux-fsdevel+bounces-7165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D2822AA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 10:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C54F1C23201
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BD1864C;
	Wed,  3 Jan 2024 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qB8vf1hf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHSpvrTn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qB8vf1hf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHSpvrTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C001862A;
	Wed,  3 Jan 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 759D51F79E;
	Wed,  3 Jan 2024 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704275790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDn3hdIl2vZfTIGXyAfw4FepSpSEp9kAZFSPVO0zHqw=;
	b=qB8vf1hfrJGZ0MZr7M1qmD9j+6eihB/vRijSAj8bg0z2Y28Yj2pCFiSOefh/R0ajjf/Q7I
	xhwdj82JaLNnIxGdN0EiHeMejeLcDOd0htCihTIvP45rf0GrdZiQKx7iZPVbMro2DhZreZ
	XYxM1Htqg68dc40dLhPFNYL8gvr5T2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704275790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDn3hdIl2vZfTIGXyAfw4FepSpSEp9kAZFSPVO0zHqw=;
	b=uHSpvrTnU5rjCbY2ms2WXs3/BV6BaRT6VIAVQlhMJRTHpN1kPKamLlmuMONUveFOPgjJH3
	11m23fMjOJgPKYCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704275790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDn3hdIl2vZfTIGXyAfw4FepSpSEp9kAZFSPVO0zHqw=;
	b=qB8vf1hfrJGZ0MZr7M1qmD9j+6eihB/vRijSAj8bg0z2Y28Yj2pCFiSOefh/R0ajjf/Q7I
	xhwdj82JaLNnIxGdN0EiHeMejeLcDOd0htCihTIvP45rf0GrdZiQKx7iZPVbMro2DhZreZ
	XYxM1Htqg68dc40dLhPFNYL8gvr5T2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704275790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDn3hdIl2vZfTIGXyAfw4FepSpSEp9kAZFSPVO0zHqw=;
	b=uHSpvrTnU5rjCbY2ms2WXs3/BV6BaRT6VIAVQlhMJRTHpN1kPKamLlmuMONUveFOPgjJH3
	11m23fMjOJgPKYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69C6413AA6;
	Wed,  3 Jan 2024 09:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Aj/RGU4vlWVUdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 09:56:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AFF9A07EF; Wed,  3 Jan 2024 10:56:30 +0100 (CET)
Date: Wed, 3 Jan 2024 10:56:30 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH v2 01/25] ext4: refactor ext4_da_map_blocks()
Message-ID: <20240103095630.jdabiefig4wcyapu@quack3>
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
 <20240102123918.799062-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102123918.799062-2-yi.zhang@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.62
X-Spamd-Bar: +
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.62 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.07)[62.09%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,infradead.org,kernel.org,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qB8vf1hf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uHSpvrTn
X-Spam-Level: *
X-Rspamd-Queue-Id: 759D51F79E

On Tue 02-01-24 20:38:54, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Refactor and cleanup ext4_da_map_blocks(), reduce some unnecessary
> parameters and branches, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 61277f7f8722..5b0d3075be12 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1704,7 +1704,6 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  	/* Lookup extent status tree firstly */
>  	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
>  		if (ext4_es_is_hole(&es)) {
> -			retval = 0;
>  			down_read(&EXT4_I(inode)->i_data_sem);
>  			goto add_delayed;
>  		}
> @@ -1749,26 +1748,9 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
>  	else
>  		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
> -
> -add_delayed:
> -	if (retval == 0) {
> -		int ret;
> -
> -		/*
> -		 * XXX: __block_prepare_write() unmaps passed block,
> -		 * is it OK?
> -		 */
> -
> -		ret = ext4_insert_delayed_block(inode, map->m_lblk);
> -		if (ret != 0) {
> -			retval = ret;
> -			goto out_unlock;
> -		}
> -
> -		map_bh(bh, inode->i_sb, invalid_block);
> -		set_buffer_new(bh);
> -		set_buffer_delay(bh);
> -	} else if (retval > 0) {
> +	if (retval < 0)
> +		goto out_unlock;
> +	if (retval > 0) {
>  		unsigned int status;
>  
>  		if (unlikely(retval != map->m_len)) {
> @@ -1783,11 +1765,24 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>  				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>  				      map->m_pblk, status);
> +		goto out_unlock;
>  	}
>  
> +add_delayed:
> +	/*
> +	 * XXX: __block_prepare_write() unmaps passed block,
> +	 * is it OK?
> +	 */
> +	retval = ext4_insert_delayed_block(inode, map->m_lblk);
> +	if (retval)
> +		goto out_unlock;
> +
> +	map_bh(bh, inode->i_sb, invalid_block);
> +	set_buffer_new(bh);
> +	set_buffer_delay(bh);
> +
>  out_unlock:
>  	up_read((&EXT4_I(inode)->i_data_sem));
> -
>  	return retval;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

