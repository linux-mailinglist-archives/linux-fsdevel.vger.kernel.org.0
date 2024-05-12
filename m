Return-Path: <linux-fsdevel+bounces-19377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC058C4245
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2831F217C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9A154BEB;
	Mon, 13 May 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDMPWsDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L5j6mNJH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDMPWsDl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L5j6mNJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A049D15350C;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607699; cv=none; b=SCJPqdinBoXbdyye+lTPaBCBydBzPsfvY39SC4gQYbWhuQFAtByygx5AuJ7fMwpVx/y378WTu5+gATGDiXEoZuaATK0kgYiEbEYTwej1YGJFvO9pQ62wZN7mDB2qfcwFoaa7xycJYhfNvKxp3mZGX+5Wp3kFgW67sc7RRZXCRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607699; c=relaxed/simple;
	bh=Sg+EICwdCUrjnHF/9vdyW64NLfEQouoxeJBc6xIQaaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFsnZxqwU1ISA0TfGOWvYVB47zPqhObBOiuA6MT+uh10EZohaD+kwhYajy6fIEoGJWFQplxIkD1gJ7U+zUUcLO2AV1h7/ll+lbn34qJy9IVqdiz2SfvXPBWZXs/P4JElLRV5Gbqft9yzAJJDW48b0kpvclTTdePK8LqBAK1bMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDMPWsDl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L5j6mNJH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDMPWsDl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L5j6mNJH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF83634A08;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ3/9uVi0I/ZwsAfox/LIaH1RxLHv69gQR1JBA2UvNg=;
	b=dDMPWsDlElO9ruRbKHh389gRH3FNkbMbCAt1FprJUKxFM4lFoZC1oe6QndHpiym6hOF/XM
	bm4W+YB4b2fRKMgYyK0HgL17cMkyUqzk6oN2Kf7bFOt7BarDZ6UXF7MAopufbWFhpUZV8S
	dWHgZ58cN5WBLTieRRMAsDWliQXtCkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ3/9uVi0I/ZwsAfox/LIaH1RxLHv69gQR1JBA2UvNg=;
	b=L5j6mNJHaCyNNNNIQhUwTRimALIN2XjLtE+bAYu4JXsbKEI0jnytR/SkhZgEH394yXEvPj
	qUAEljumSxut1GDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dDMPWsDl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=L5j6mNJH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ3/9uVi0I/ZwsAfox/LIaH1RxLHv69gQR1JBA2UvNg=;
	b=dDMPWsDlElO9ruRbKHh389gRH3FNkbMbCAt1FprJUKxFM4lFoZC1oe6QndHpiym6hOF/XM
	bm4W+YB4b2fRKMgYyK0HgL17cMkyUqzk6oN2Kf7bFOt7BarDZ6UXF7MAopufbWFhpUZV8S
	dWHgZ58cN5WBLTieRRMAsDWliQXtCkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ3/9uVi0I/ZwsAfox/LIaH1RxLHv69gQR1JBA2UvNg=;
	b=L5j6mNJHaCyNNNNIQhUwTRimALIN2XjLtE+bAYu4JXsbKEI0jnytR/SkhZgEH394yXEvPj
	qUAEljumSxut1GDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82F4E1372E;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VFPxH48YQmZBDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF009A090B; Sun, 12 May 2024 17:40:37 +0200 (CEST)
Date: Sun, 12 May 2024 17:40:37 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 08/10] ext4: factor out check for whether a cluster is
 allocated
Message-ID: <20240512154037.x6icodkj2zmzeqtg@quack3>
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
 <20240508061220.967970-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508061220.967970-9-yi.zhang@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BF83634A08
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,huawei.com:email,suse.cz:dkim]

On Wed 08-05-24 14:12:18, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Factor out a common helper ext4_da_check_clu_allocated(), check whether
> the cluster containing a delalloc block to be added has been delayed or
> allocated, no logic changes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

I have one suggestion for improvement here.

> +/*
> + * Check whether the cluster containing lblk has been delayed or allocated,
> + * if not, it means we should reserve a cluster when add delalloc, return 1,
> + * otherwise return 0 or error code.
> + */
> +static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
> +				       bool *allocated)

The name of the function does not quite match what it is returning and that
is confusing. Essentially we have three states here:

a) cluster allocated
b) cluster has delalloc reservation
c) cluster doesn't have either

So maybe we could call the function ext4_clu_alloc_state() and return 0 /
1 / 2 based on the state?

								Honza

> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	int ret;
> +
> +	*allocated = false;
> +	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
> +		return 0;
> +
> +	if (ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk))
> +		goto allocated;
> +
> +	ret = ext4_clu_mapped(inode, EXT4_B2C(sbi, lblk));
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		return 1;
> +allocated:
> +	*allocated = true;
> +	return 0;
> +}
> +
>  /*
>   * ext4_insert_delayed_block - adds a delayed block to the extents status
>   *                             tree, incrementing the reserved cluster/block
> @@ -1682,23 +1710,13 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
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
> +		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
> +		if (ret < 0)
> +			return ret;
> +		if (ret > 0) {
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

