Return-Path: <linux-fsdevel+bounces-19375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170178C423A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D0B24166
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E8153BC4;
	Mon, 13 May 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L/e7ZTiv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0imQAEWB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L/e7ZTiv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0imQAEWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EB153503;
	Mon, 13 May 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607698; cv=none; b=VrB+MzT4rQslBdJ75t/NnpKGxTElqIBYZz+3tohy8NhrLNOSuqwh37HlpVA9fAUQv9pKHoOsNwHGH4J41fY2yFfM71kvT472CflWwJADFUSvVbEayitSw0wA5O2gHhQfeKQWWAJ4r3waJUh8NkDapLN3E8X8OcBhacoXpWcSUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607698; c=relaxed/simple;
	bh=I058s5Bm3g9FtZ0OhfTKaLzuBW49N2aTJDi8c0hi6Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpJw6GTrsmiE+C9AZRBEm4771yRnRR72UaWnAg1FkvGlKjc1qhyNmef/gwRqJnvGqd5Wm2uyiDwdS8Y6goqpuAIIW/ziQpMoCetCTkVNU15Dq7gqFkMuyG7TL3ekE+8myFPFIRasf1rVjza9Qa5VVnP24RAuxQbWW/tu1Bdwyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L/e7ZTiv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0imQAEWB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L/e7ZTiv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0imQAEWB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75C6D34A46;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7I5poiZpYvTWGLzitLsLJMzwvwqLlJFnVOXnFHMGRFQ=;
	b=L/e7ZTivaUjJzx3gJvOyzbz9WAl6nysZXu+OtPWLKdZ7aRTyrjn871SK3Et93XWG80qjll
	3u4I9Obh5f9ugiS39ATJHszxS1Iz7ulecgxnsYyq1Ak2IADuNrurSOqhjz89pmQUK1Vh6z
	4axOitp8NKBaGG9nVssUqUucaZGW9/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7I5poiZpYvTWGLzitLsLJMzwvwqLlJFnVOXnFHMGRFQ=;
	b=0imQAEWBusqJnV0Pf9gRGGahZ0HBA/FtIl7yOtbktECjSkdYakUX9ymLdmmSuU9nZaA552
	uEoeMqWKY6WpQXBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7I5poiZpYvTWGLzitLsLJMzwvwqLlJFnVOXnFHMGRFQ=;
	b=L/e7ZTivaUjJzx3gJvOyzbz9WAl6nysZXu+OtPWLKdZ7aRTyrjn871SK3Et93XWG80qjll
	3u4I9Obh5f9ugiS39ATJHszxS1Iz7ulecgxnsYyq1Ak2IADuNrurSOqhjz89pmQUK1Vh6z
	4axOitp8NKBaGG9nVssUqUucaZGW9/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7I5poiZpYvTWGLzitLsLJMzwvwqLlJFnVOXnFHMGRFQ=;
	b=0imQAEWBusqJnV0Pf9gRGGahZ0HBA/FtIl7yOtbktECjSkdYakUX9ymLdmmSuU9nZaA552
	uEoeMqWKY6WpQXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20A4413A66;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TON/B44YQmYnDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DD921A0917; Sun, 12 May 2024 23:47:51 +0200 (CEST)
Date: Sun, 12 May 2024 23:47:51 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 09/10] ext4: make ext4_insert_delayed_block() insert
 multi-blocks
Message-ID: <20240512214751.b4dv6qnhubpuknrc@quack3>
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
 <20240508061220.967970-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508061220.967970-10-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Wed 08-05-24 14:12:19, Zhang Yi wrote:
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

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 48 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6e418d3f8e87..c56386d1b10d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1678,24 +1678,29 @@ static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
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
> @@ -1706,21 +1711,36 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	 * extents status tree doesn't get a match.
>  	 */
>  	if (sbi->s_cluster_ratio == 1) {
> -		ret = ext4_da_reserve_space(inode, 1);
> +		ret = ext4_da_reserve_space(inode, len);
>  		if (ret != 0)   /* ENOSPC */
>  			return ret;
>  	} else {   /* bigalloc */
> -		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
> +		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) + 1;
> +
> +		ret = ext4_da_check_clu_allocated(inode, lblk, &lclu_allocated);
>  		if (ret < 0)
>  			return ret;
> -		if (ret > 0) {
> -			ret = ext4_da_reserve_space(inode, 1);
> +		if (ret == 0)
> +			resv_clu--;
> +
> +		if (EXT4_B2C(sbi, lblk) != EXT4_B2C(sbi, end)) {
> +			ret = ext4_da_check_clu_allocated(inode, end,
> +							  &end_allocated);
> +			if (ret < 0)
> +				return ret;
> +			if (ret == 0)
> +				resv_clu--;
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
> @@ -1825,7 +1845,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
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

