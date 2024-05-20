Return-Path: <linux-fsdevel+bounces-19773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6688C9A82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EADB1C218FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20ED224F2;
	Mon, 20 May 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TLu07Zye";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vRybEFAA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TLu07Zye";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vRybEFAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A851CA81;
	Mon, 20 May 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197994; cv=none; b=euGprq3KfzNnwLeZI+ypaESHD0bs61myQcCwcxOwEG+rWEEl/V8wtgD6bmmYLOI4DPnzAM++iA3Vs5PnC9qD8+KsEnHK39uP/gRlwe45nqfUot2Pwid6BuIIfiTdnZQf1ZwIZXr2jdTADeYmZ7ERnwEuTakn3ICLxXgEDU0s9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197994; c=relaxed/simple;
	bh=wLsHs5imOd7IuSeg1NQkgiaJnQHZxhdeLjqDXom70Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLHjFK+0M18fhwJtFS6SBzgho8l/VGFrjD+71mcbjTNebCYUYgySVP36eZyfFp6PhFPWnFSLU5hpooDPkZQ99cJh1UrI2bTcVMGrGv8wb6pLZ8fdWOmP8qiI6KNQFTuek9r5FaIyx4VbVarjlF8T3n5sWGTr/g6YQTtL9VjifHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TLu07Zye; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vRybEFAA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TLu07Zye; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vRybEFAA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 697C3203DA;
	Mon, 20 May 2024 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716197990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cakBZKjnNR+bOCCLkeDl065dNr01RP60y10RwuWggjE=;
	b=TLu07ZyeszAxqovU/mokZBXS/NIN4ierFqBktVBPu7Tuh2ZPsYPuabIFQ55F0IWS7x7daw
	W50Eb0u9q2xbTHhDnG38LAq6qs79Q8vCIGSim7ptgZSu6y7eq24Psh62iYD2WDAcbVa8wj
	kKwm5B/D4rADxjfrKTfvmE4RqqL7a1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716197990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cakBZKjnNR+bOCCLkeDl065dNr01RP60y10RwuWggjE=;
	b=vRybEFAAxp22SpTalgeu6BIUAUKv7877ErXrUA7+jUTewJ2ZjhkKYNDTPn6I4PazjAJIKj
	jLbCoLDk+YTw6QCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TLu07Zye;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vRybEFAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716197990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cakBZKjnNR+bOCCLkeDl065dNr01RP60y10RwuWggjE=;
	b=TLu07ZyeszAxqovU/mokZBXS/NIN4ierFqBktVBPu7Tuh2ZPsYPuabIFQ55F0IWS7x7daw
	W50Eb0u9q2xbTHhDnG38LAq6qs79Q8vCIGSim7ptgZSu6y7eq24Psh62iYD2WDAcbVa8wj
	kKwm5B/D4rADxjfrKTfvmE4RqqL7a1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716197990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cakBZKjnNR+bOCCLkeDl065dNr01RP60y10RwuWggjE=;
	b=vRybEFAAxp22SpTalgeu6BIUAUKv7877ErXrUA7+jUTewJ2ZjhkKYNDTPn6I4PazjAJIKj
	jLbCoLDk+YTw6QCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 564B013A6B;
	Mon, 20 May 2024 09:39:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pj/JFGYaS2ZhNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 09:39:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F30B5A0888; Mon, 20 May 2024 11:39:45 +0200 (CEST)
Date: Mon, 20 May 2024 11:39:45 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 09/10] ext4: make ext4_insert_delayed_block() insert
 multi-blocks
Message-ID: <20240520093945.mcfhnwxrj5ih67ua@quack3>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
 <20240517124005.347221-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517124005.347221-10-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 697C3203DA
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]

On Fri 17-05-24 20:40:04, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Rename ext4_insert_delayed_block() to ext4_insert_delayed_blocks(),
> pass length parameter to make it insert multiple delalloc blocks at a
> time. For non-bigalloc case, just reserve len blocks and insert delalloc
> extent. For bigalloc case, we can ensure that the clusters in the middle
> of a extent must be unallocated, we only need to check whether the start
> and end clusters are delayed/allocated. We should subtract the space for
> the start and/or end block(s) if they are allocated.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 51 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index eefedb7264c7..4febee4c833f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1679,24 +1679,29 @@ static int ext4_clu_alloc_state(struct inode *inode, ext4_lblk_t lblk)
>  }
>  
>  /*
> - * ext4_insert_delayed_block - adds a delayed block to the extents status
> - *                             tree, incrementing the reserved cluster/block
> - *                             count or making a pending reservation
> - *                             where needed
> + * ext4_insert_delayed_blocks - adds a multiple delayed blocks to the extents
> + *                              status tree, incrementing the reserved
> + *                              cluster/block count or making pending
> + *                              reservations where needed
>   *
>   * @inode - file containing the newly added block
> - * @lblk - logical block to be added
> + * @lblk - start logical block to be added
> + * @len - length of blocks to be added
>   *
>   * Returns 0 on success, negative error code on failure.
>   */
> -static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
> +static int ext4_insert_delayed_blocks(struct inode *inode, ext4_lblk_t lblk,
> +				      ext4_lblk_t len)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	int ret;
> -	bool allocated = false;
> +	bool lclu_allocated = false;
> +	bool end_allocated = false;
> +	ext4_lblk_t resv_clu;
> +	ext4_lblk_t end = lblk + len - 1;
>  
>  	/*
> -	 * If the cluster containing lblk is shared with a delayed,
> +	 * If the cluster containing lblk or end is shared with a delayed,
>  	 * written, or unwritten extent in a bigalloc file system, it's
>  	 * already been accounted for and does not need to be reserved.
>  	 * A pending reservation must be made for the cluster if it's
> @@ -1707,23 +1712,39 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	 * extents status tree doesn't get a match.
>  	 */
>  	if (sbi->s_cluster_ratio == 1) {
> -		ret = ext4_da_reserve_space(inode, 1);
> +		ret = ext4_da_reserve_space(inode, len);
>  		if (ret != 0)   /* ENOSPC */
>  			return ret;
>  	} else {   /* bigalloc */
> +		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) + 1;
> +
>  		ret = ext4_clu_alloc_state(inode, lblk);
>  		if (ret < 0)
>  			return ret;
> -		if (ret == 2)
> -			allocated = true;
> -		if (ret == 0) {
> -			ret = ext4_da_reserve_space(inode, 1);
> +		if (ret > 0) {
> +			resv_clu--;
> +			lclu_allocated = (ret == 2);
> +		}
> +
> +		if (EXT4_B2C(sbi, lblk) != EXT4_B2C(sbi, end)) {
> +			ret = ext4_clu_alloc_state(inode, end);
> +			if (ret < 0)
> +				return ret;
> +			if (ret > 0) {
> +				resv_clu--;
> +				end_allocated = (ret == 2);
> +			}
> +		}
> +
> +		if (resv_clu) {
> +			ret = ext4_da_reserve_space(inode, resv_clu);
>  			if (ret != 0)   /* ENOSPC */
>  				return ret;
>  		}
>  	}
>  
> -	ext4_es_insert_delayed_extent(inode, lblk, 1, allocated, false);
> +	ext4_es_insert_delayed_extent(inode, lblk, len, lclu_allocated,
> +				      end_allocated);
>  	return 0;
>  }
>  
> @@ -1828,7 +1849,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
>  		}
>  	}
>  
> -	retval = ext4_insert_delayed_block(inode, map->m_lblk);
> +	retval = ext4_insert_delayed_blocks(inode, map->m_lblk, map->m_len);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	if (retval)
>  		return retval;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

