Return-Path: <linux-fsdevel+bounces-18087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB18B54BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090221F222FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CA2C19D;
	Mon, 29 Apr 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HXxgVW5a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kPsbnGNg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z0kAkhRv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDjuMkNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03F175AD;
	Mon, 29 Apr 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385233; cv=none; b=VfwTCKUMmfbRPtyDNLMlXMToww4sGJzEJ5z8MVIsmu0XHianj1su2BW8p6coFOhboRS64LrDjkgJgs4Ji/nFnMrSzg7EQBGo+bDU3dP6u7VMEbGyDUCXgZKBIz+Eh8MnMqKzEjgThqthg0TD73DSH0qqUDmWF43VEOU9kRK3fz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385233; c=relaxed/simple;
	bh=tnLl2jPMenbNTfLFfohwlXKXbjfz0tzvcHd0AORMFlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBntfBk8DeKqE5tQVnxIJBPSEUTeFbL4Mep/UgTs/VKRbGJai8xPGaFSiEFm5B1GhleC3fh9GU/m9mJ2If2FGyntgM4tPsgdNlzR4GSjsekdU0I/aLdrIQIRgFJ/l/jcRyYjkSo1hhA98kW0pQ8d5zv6XB6WQMgrJ8CNNakiSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HXxgVW5a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kPsbnGNg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z0kAkhRv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDjuMkNX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D534720487;
	Mon, 29 Apr 2024 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714385224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4p/UVbO0510MXZtxjjFvwXo8LAejFaDTeM95p7NfPc=;
	b=HXxgVW5amdWdbaD3Zp4n8UbnrCJdvMTEYgmedEsfOk2gCNwYsuYU1zrMY9vHEDvSsm4Lvk
	3r1ysmIdEv1B12zN+gyRsoPQCNQKBm8yl3Ffk5FBsvOawe7906oE3V09q9WpshuQGYPco3
	OxAGgW5hrgL4EotIYU54kGYEeZ3GsYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714385224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4p/UVbO0510MXZtxjjFvwXo8LAejFaDTeM95p7NfPc=;
	b=kPsbnGNggVzmnkJMGRYMTg4m8dQGLRBXgS/0l56ee6cKgWOS78UDy5qTJDqFaQhhGDteFy
	Q5k8IbazQU+OvrCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=z0kAkhRv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VDjuMkNX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714385223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4p/UVbO0510MXZtxjjFvwXo8LAejFaDTeM95p7NfPc=;
	b=z0kAkhRvWf4RPdFwjgupC2JGuBFrPacymQx+k19poAfuBH6ep3kKTEZSlRfLRZU9mHyrFC
	lEFpS6Atl2uwhIdJl0H9pAkzqRKKffFYDeZDlIuUZ+Q3yqlwz6T+iAGef2ROvkosJvIeiY
	39h80CorJ/NSBF8A6oAO2+5CglDvDjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714385223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4p/UVbO0510MXZtxjjFvwXo8LAejFaDTeM95p7NfPc=;
	b=VDjuMkNXVbNEgS1e+rApHiax7RdwHAxiwrltccrisuRGPYbDocKPYCAlHpv35kGI+Y4KRT
	ZNue82xazJSL4mAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C749C139DE;
	Mon, 29 Apr 2024 10:07:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tWRhMEdxL2bBLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 10:07:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A35BA082F; Mon, 29 Apr 2024 12:06:59 +0200 (CEST)
Date: Mon, 29 Apr 2024 12:06:59 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 8/9] ext4: make ext4_insert_delayed_block() insert
 multi-blocks
Message-ID: <20240429100659.pudgimunspsmrthy@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-9-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D534720487
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 10-04-24 11:42:02, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Rename ext4_insert_delayed_block() to ext4_insert_delayed_blocks(),
> pass length parameter to make it insert multi delalloc blocks once a
> time. For non-bigalloc case, just reserve len blocks and insert delalloc
> extent. For bigalloc case, we can ensure the middle clusters are not
> allocated, but need to check whether the start and end clusters are
> delayed/allocated, if not, we should reserve more space for the start
> and/or end block(s).
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the patch. Some comments below.

> ---
>  fs/ext4/inode.c | 51 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 46c34baa848a..08e2692b7286 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1678,24 +1678,28 @@ static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
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
> -	int ret;
> -	bool allocated = false;
> +	int resv_clu, ret;
	    ^^^ this variable is in prinple the length of the extent. Thus
it should be ext4_lblk_t type.

> +	bool lclu_allocated = false;
> +	bool end_allocated = false;
> +	ext4_lblk_t end = lblk + len - 1;
>  
>  	/*
> -	 * If the cluster containing lblk is shared with a delayed,
> +	 * If the cluster containing lblk or end is shared with a delayed,
>  	 * written, or unwritten extent in a bigalloc file system, it's
>  	 * already been accounted for and does not need to be reserved.
>  	 * A pending reservation must be made for the cluster if it's
> @@ -1706,21 +1710,38 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  	 * extents status tree doesn't get a match.
>  	 */
>  	if (sbi->s_cluster_ratio == 1) {
> -		ret = ext4_da_reserve_space(inode, 1);
> +		ret = ext4_da_reserve_space(inode, len);
>  		if (ret != 0)   /* ENOSPC */
>  			return ret;
>  	} else {   /* bigalloc */
> -		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
> +		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) - 1;
> +		if (resv_clu < 0)
> +			resv_clu = 0;

Here resv_clu going negative is strange I'm not sure the math is 100%
correct in all the cases. I think it would be more logical as:

		resv_clu = EXT4_B2C(sbi, end) - EXT4_B2C(sbi, lblk) + 1;

and then update resv_clu below as:

> +
> +		ret = ext4_da_check_clu_allocated(inode, lblk, &lclu_allocated);
>  		if (ret < 0)
>  			return ret;
> -		if (ret > 0) {
> -			ret = ext4_da_reserve_space(inode, 1);
> +		if (ret > 0)
> +			resv_clu++;

Here we would do:
		if (ret == 0)
			resv_clu--;

> +
> +		if (EXT4_B2C(sbi, lblk) != EXT4_B2C(sbi, end)) {
> +			ret = ext4_da_check_clu_allocated(inode, end,
> +							  &end_allocated);
> +			if (ret < 0)
> +				return ret;
> +			if (ret > 0)
> +				resv_clu++;

And similarly here:
			if (ret == 0)
				resv_clu--;

									Honza

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
> @@ -1823,7 +1844,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map,
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

