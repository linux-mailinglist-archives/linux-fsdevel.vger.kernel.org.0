Return-Path: <linux-fsdevel+bounces-19772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C544D8C9A74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB7D281EC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116C208D7;
	Mon, 20 May 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YcgpFrop";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="np0MN4ld";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YcgpFrop";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="np0MN4ld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C17468E;
	Mon, 20 May 2024 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197845; cv=none; b=TaboDZuif8800MzYslAO9YlihwYlQ+Sa6wUEvEuVoZItUIjebI/Rg8/vYvz3mtAfIBz/98apjfdQ9Xs8k/xqQx6fpNW/StQf3KUM+ZXEEZZQMIP7Yt8Z3M+dfx1d2DpfPPNFRCSeJK1IcBLFkwErVkKwdkMEbiCsccourqDEY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197845; c=relaxed/simple;
	bh=jDB07f25m/8VdNYLtPu4VtyuzRZAEp4rLDnxII32KEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmpDkXM+1PB4olg7TFthaSeoIip71xp+lR3ARyMsAk8VtoCQ/tHwBJho6NLgn0Dzbzxhw1G3qr7/Rhx1Q5lJ4bu22OMnQeRPToUzwDwgE0FP9mErGKqgvsjNaL8X0t72gKpd0pIZGljyuo1mIrltuEeDChHrexJnCRXrgqhrW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YcgpFrop; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=np0MN4ld; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YcgpFrop; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=np0MN4ld; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE28933C95;
	Mon, 20 May 2024 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716197842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVUHeC5Oeqc5t/I8Wprafz2LKwDdXeIY2YgQkBuR1oE=;
	b=YcgpFrop+RjoEvEwWH3pqY+mhd039FcMyUHg+G5gNcZSat4ftSjocMM+YY+3ENW0Ovygdh
	ukKwg2VjD6Tc8KKLP3pYtVQ4QydOmfEFe3PJ5xa+s1K5ORHkpgIfJNFEZESJr0CZazh9jR
	KwEVmAJ2g/dqsdub6w/4VJrSG31eyCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716197842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVUHeC5Oeqc5t/I8Wprafz2LKwDdXeIY2YgQkBuR1oE=;
	b=np0MN4ldwu128j3hmLUyLr6ewSDUe/4b8MElk4ubD+r8POMJet3rSnWtL9LjJ4VV6riSm+
	RiglcVkfDTOVuHCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YcgpFrop;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=np0MN4ld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716197842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVUHeC5Oeqc5t/I8Wprafz2LKwDdXeIY2YgQkBuR1oE=;
	b=YcgpFrop+RjoEvEwWH3pqY+mhd039FcMyUHg+G5gNcZSat4ftSjocMM+YY+3ENW0Ovygdh
	ukKwg2VjD6Tc8KKLP3pYtVQ4QydOmfEFe3PJ5xa+s1K5ORHkpgIfJNFEZESJr0CZazh9jR
	KwEVmAJ2g/dqsdub6w/4VJrSG31eyCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716197842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wVUHeC5Oeqc5t/I8Wprafz2LKwDdXeIY2YgQkBuR1oE=;
	b=np0MN4ldwu128j3hmLUyLr6ewSDUe/4b8MElk4ubD+r8POMJet3rSnWtL9LjJ4VV6riSm+
	RiglcVkfDTOVuHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA52513A6B;
	Mon, 20 May 2024 09:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gdsHNdEZS2bWBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 09:37:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8B926A0888; Mon, 20 May 2024 11:37:21 +0200 (CEST)
Date: Mon, 20 May 2024 11:37:21 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v5 08/10] ext4: factor out a helper to check the cluster
 allocation state
Message-ID: <20240520093721.xqrhhn43ldvhoh5y@quack3>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
 <20240517124005.347221-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517124005.347221-9-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EE28933C95
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:dkim,suse.cz:email]

On Fri 17-05-24 20:40:03, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Factor out a common helper ext4_clu_alloc_state(), check whether the
> cluster containing a delalloc block to be added has been allocated or
> has delalloc reservation, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 55 ++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0c52969654ac..eefedb7264c7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1649,6 +1649,35 @@ static void ext4_print_free_blocks(struct inode *inode)
>  	return;
>  }
>  
> +/*
> + * Check whether the cluster containing lblk has been allocated or has
> + * delalloc reservation.
> + *
> + * Returns 0 if the cluster doesn't have either, 1 if it has delalloc
> + * reservation, 2 if it's already been allocated, negative error code on
> + * failure.
> + */
> +static int ext4_clu_alloc_state(struct inode *inode, ext4_lblk_t lblk)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	int ret;
> +
> +	/* Has delalloc reservation? */
> +	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
> +		return 1;
> +
> +	/* Already been allocated? */
> +	if (ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk))
> +		return 2;
> +	ret = ext4_clu_mapped(inode, EXT4_B2C(sbi, lblk));
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		return 2;
> +
> +	return 0;
> +}
> +
>  /*
>   * ext4_insert_delayed_block - adds a delayed block to the extents status
>   *                             tree, incrementing the reserved cluster/block
> @@ -1682,23 +1711,15 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  		if (ret != 0)   /* ENOSPC */
>  			return ret;
>  	} else {   /* bigalloc */
> -		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
> -			if (!ext4_es_scan_clu(inode,
> -					      &ext4_es_is_mapped, lblk)) {
> -				ret = ext4_clu_mapped(inode,
> -						      EXT4_B2C(sbi, lblk));
> -				if (ret < 0)
> -					return ret;
> -				if (ret == 0) {
> -					ret = ext4_da_reserve_space(inode, 1);
> -					if (ret != 0)   /* ENOSPC */
> -						return ret;
> -				} else {
> -					allocated = true;
> -				}
> -			} else {
> -				allocated = true;
> -			}
> +		ret = ext4_clu_alloc_state(inode, lblk);
> +		if (ret < 0)
> +			return ret;
> +		if (ret == 2)
> +			allocated = true;
> +		if (ret == 0) {
> +			ret = ext4_da_reserve_space(inode, 1);
> +			if (ret != 0)   /* ENOSPC */
> +				return ret;
>  		}
>  	}
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

