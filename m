Return-Path: <linux-fsdevel+bounces-70014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A14C8E4AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F4E3A65AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF83321B5;
	Thu, 27 Nov 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QVeVaQns";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTUaqBD9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QVeVaQns";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTUaqBD9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB61F12F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247402; cv=none; b=V34fU2Q+p6QSUEcGDWpWATDChOzP2CMGl81wfFBcVjCSs2wcOI2pHw6yg82NZyGQi7lO/1MMQmKFLk118BMzgePb5KrV4GOp6MbmzjN29b0F/v1OV1GEhXZiCp0ezMUIDnqHgxzhXKV6Gn1FrlWztS+MmqL3jIn+tvjz79VFcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247402; c=relaxed/simple;
	bh=hvbwBPSDCBBVBl4U6yD99+smN7ivbEVfPtV+andSADQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie+6hYbf4JKxeO8mkZVYyVk4SIFyA90ckTbgzTVGRxw8VatHmVuR9vpGCyvIzoIxrrtdL8zxi//KvO9fXTDcn9/T/OzaMz4Off3fLRLX1HHlrYJQbe6oYAmBwA5dzF/Cp3Zku8ahznHIIvqX7oWpgFM7HilL+uZI8IMDmxhahlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QVeVaQns; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTUaqBD9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QVeVaQns; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTUaqBD9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3265222BE2;
	Thu, 27 Nov 2025 12:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764247399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEvcDGunbC0dO604lSPOmgzO0paJIzpiiaHZmw+wwb0=;
	b=QVeVaQns9KsL2yfSINDksFoPmEXXEr2q8n3xLalqsMHxE7x6fbuGVgW/XggLaaA5vLSmVq
	yrHmhys3qa/3RfGX6nMM9AIGYntRXvt9g+xp4r2NzJ7IxSvalvElt7yVjxxCdQXLHT3DJD
	luy6rXjpdHnJDaAgrpjfsmHZ12xzovI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764247399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEvcDGunbC0dO604lSPOmgzO0paJIzpiiaHZmw+wwb0=;
	b=RTUaqBD93Q+BeWo6TTFLbOjaUi8HmgzLGNGit6QlBy+VBwpzt7L1GA6EKH4Us77lag4H6y
	4cpwRK0EQKBTd5Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764247399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEvcDGunbC0dO604lSPOmgzO0paJIzpiiaHZmw+wwb0=;
	b=QVeVaQns9KsL2yfSINDksFoPmEXXEr2q8n3xLalqsMHxE7x6fbuGVgW/XggLaaA5vLSmVq
	yrHmhys3qa/3RfGX6nMM9AIGYntRXvt9g+xp4r2NzJ7IxSvalvElt7yVjxxCdQXLHT3DJD
	luy6rXjpdHnJDaAgrpjfsmHZ12xzovI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764247399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AEvcDGunbC0dO604lSPOmgzO0paJIzpiiaHZmw+wwb0=;
	b=RTUaqBD93Q+BeWo6TTFLbOjaUi8HmgzLGNGit6QlBy+VBwpzt7L1GA6EKH4Us77lag4H6y
	4cpwRK0EQKBTd5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CD9C3EA63;
	Thu, 27 Nov 2025 12:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /3sGB2dHKGlFIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 12:43:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87E2FA0C94; Thu, 27 Nov 2025 13:43:18 +0100 (CET)
Date: Thu, 27 Nov 2025 13:43:18 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 08/13] ext4: cleanup useless out tag in
 __es_remove_extent()
Message-ID: <nxm5jp4iilin4evuebffrd23eptmjwfbvayvd4vq62hi37s4vz@3ldgakx4yr5v>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-9-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121060811.1685783-9-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,huawei.com,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 21-11-25 14:08:06, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The out tag in __es_remove_extent() is just return err value, we can
          ^^^ this should be 'label'

> return it directly if something bad happens. Therefore, remove the
> useless out tag and rename out_get_reserved to out.
              ^^^ label

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index e04fbf10fe4f..04d56f8f6c0c 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1434,7 +1434,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct extent_status orig_es;
>  	ext4_lblk_t len1, len2;
>  	ext4_fsblk_t block;
> -	int err = 0;
> +	int err;
>  	bool count_reserved = true;
>  	struct rsvd_count rc;
>  
> @@ -1443,9 +1443,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	es = __es_tree_search(&tree->root, lblk);
>  	if (!es)
> -		goto out;
> +		return 0;
>  	if (es->es_lblk > end)
> -		goto out;
> +		return 0;
>  
>  	/* Simply invalidate cache_es. */
>  	tree->cache_es = NULL;
> @@ -1480,7 +1480,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  				es->es_lblk = orig_es.es_lblk;
>  				es->es_len = orig_es.es_len;
> -				goto out;
> +				return err;
>  			}
>  		} else {
>  			es->es_lblk = end + 1;
> @@ -1494,7 +1494,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		if (count_reserved)
>  			count_rsvd(inode, orig_es.es_lblk + len1,
>  				   orig_es.es_len - len1 - len2, &orig_es, &rc);
> -		goto out_get_reserved;
> +		goto out;
>  	}
>  
>  	if (len1 > 0) {
> @@ -1536,11 +1536,10 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		}
>  	}
>  
> -out_get_reserved:
> +out:
>  	if (count_reserved)
>  		*reserved = get_rsvd(inode, end, es, &rc);
> -out:
> -	return err;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

