Return-Path: <linux-fsdevel+bounces-28511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6B96B808
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60031F23243
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AC01CF5E7;
	Wed,  4 Sep 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZczpRZnH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ffk22BFs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZczpRZnH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ffk22BFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2E18890D;
	Wed,  4 Sep 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444924; cv=none; b=LDz2thjznU25ix0HteGEIDuIKVGkocniVtknXRUXhdt3RDamxZiWNaaAxzYgjgC/UjQ15CMPwBWlZ+VsSL6JabuZBmWuICZ1r6gf5z5Y4am3yYQmHuXMrJm7W1RMayB3C0mGmwWzgUOOFlJ7CaOmiOH0rm23URmcvsqZychHVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444924; c=relaxed/simple;
	bh=KYXQSZAv+DfchmGmNWljAxqBAcAoYvO11cNyrR/rvp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiyHz0SdwxfOJHHdtwpHDw06WtedVIN08kBrPqoV2grNKLq+YylmG4PwElPBUuoYbB5U1Cx8CvZ63C6ZI1AQwCdHeJ3wSu4wFU9jTDzlZQRzJqEXJfzeKJQ5K/6VuCAWgL/c1+rHMDpi9sw95ka7nUVqVLRHYAmknuqALOqDG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZczpRZnH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ffk22BFs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZczpRZnH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ffk22BFs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 161A01F7B6;
	Wed,  4 Sep 2024 10:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725444920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyVy7B/FxJoOnTZ9bGv/WBLncJ7QZuFKKufblO0aj9E=;
	b=ZczpRZnHZWSXrR54mHw/xaynmDFLQ/JDVpn8VYWPDG99MXPluvojUTtvy+ZSACAe1nz2cE
	ymtu9ExgGPY0QrCKEqxA2luQtWnL9pqKE4KUo6z/Qeb59iGKaRcHQF9h1rJJDJmglGyA30
	/q2FQc3KjQNV1YmgTUFu/SK/pIJce30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725444920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyVy7B/FxJoOnTZ9bGv/WBLncJ7QZuFKKufblO0aj9E=;
	b=Ffk22BFsCTL4maHtLZudMnRqqpKBgtASxmg+hchUjPhbpKpchoeNW3K2XXq9lWeidYAGAa
	IHjARTIVG42w3PCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725444920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyVy7B/FxJoOnTZ9bGv/WBLncJ7QZuFKKufblO0aj9E=;
	b=ZczpRZnHZWSXrR54mHw/xaynmDFLQ/JDVpn8VYWPDG99MXPluvojUTtvy+ZSACAe1nz2cE
	ymtu9ExgGPY0QrCKEqxA2luQtWnL9pqKE4KUo6z/Qeb59iGKaRcHQF9h1rJJDJmglGyA30
	/q2FQc3KjQNV1YmgTUFu/SK/pIJce30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725444920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyVy7B/FxJoOnTZ9bGv/WBLncJ7QZuFKKufblO0aj9E=;
	b=Ffk22BFsCTL4maHtLZudMnRqqpKBgtASxmg+hchUjPhbpKpchoeNW3K2XXq9lWeidYAGAa
	IHjARTIVG42w3PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07171139D2;
	Wed,  4 Sep 2024 10:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hRtpATgz2GbKJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:15:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96D28A0968; Wed,  4 Sep 2024 12:15:15 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:15:15 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 04/12] ext4: let __revise_pending() return newly
 inserted pendings
Message-ID: <20240904101515.2v2pwvacjltss2zk@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-5-yi.zhang@huaweicloud.com>
X-Spam-Score: -2.30
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 13-08-24 20:34:44, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Let __insert_pending() return 1 after successfully inserting a new
> pending cluster, and also let __revise_pending() to return the number of
> of newly inserted pendings.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

AFAICS nothing really uses this functionality in this version of the
patchset so we can drop this patch?

								Honza

> ---
>  fs/ext4/extents_status.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 024cd37d53b3..4d24b56cfaf0 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -887,7 +887,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  		es1 = __es_alloc_extent(true);
>  	if ((err1 || err2) && !es2)
>  		es2 = __es_alloc_extent(true);
> -	if ((err1 || err2 || err3) && revise_pending && !pr)
> +	if ((err1 || err2 || err3 < 0) && revise_pending && !pr)
>  		pr = __alloc_pending(true);
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  
> @@ -915,7 +915,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	if (revise_pending) {
>  		err3 = __revise_pending(inode, lblk, len, &pr);
> -		if (err3 != 0)
> +		if (err3 < 0)
>  			goto error;
>  		if (pr) {
>  			__free_pending(pr);
> @@ -924,7 +924,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	}
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> -	if (err1 || err2 || err3)
> +	if (err1 || err2 || err3 < 0)
>  		goto retry;
>  
>  	ext4_es_print_tree(inode);
> @@ -1933,7 +1933,7 @@ static struct pending_reservation *__get_pending(struct inode *inode,
>   * @lblk - logical block in the cluster to be added
>   * @prealloc - preallocated pending entry
>   *
> - * Returns 0 on successful insertion and -ENOMEM on failure.  If the
> + * Returns 1 on successful insertion and -ENOMEM on failure.  If the
>   * pending reservation is already in the set, returns successfully.
>   */
>  static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
> @@ -1977,6 +1977,7 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
>  
>  	rb_link_node(&pr->rb_node, parent, p);
>  	rb_insert_color(&pr->rb_node, &tree->root);
> +	ret = 1;
>  
>  out:
>  	return ret;
> @@ -2098,7 +2099,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  		es1 = __es_alloc_extent(true);
>  	if ((err1 || err2) && !es2)
>  		es2 = __es_alloc_extent(true);
> -	if (err1 || err2 || err3) {
> +	if (err1 || err2 || err3 < 0) {
>  		if (lclu_allocated && !pr1)
>  			pr1 = __alloc_pending(true);
>  		if (end_allocated && !pr2)
> @@ -2128,7 +2129,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	if (lclu_allocated) {
>  		err3 = __insert_pending(inode, lblk, &pr1);
> -		if (err3 != 0)
> +		if (err3 < 0)
>  			goto error;
>  		if (pr1) {
>  			__free_pending(pr1);
> @@ -2137,7 +2138,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  	}
>  	if (end_allocated) {
>  		err3 = __insert_pending(inode, end, &pr2);
> -		if (err3 != 0)
> +		if (err3 < 0)
>  			goto error;
>  		if (pr2) {
>  			__free_pending(pr2);
> @@ -2146,7 +2147,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
>  	}
>  error:
>  	write_unlock(&EXT4_I(inode)->i_es_lock);
> -	if (err1 || err2 || err3)
> +	if (err1 || err2 || err3 < 0)
>  		goto retry;
>  
>  	ext4_es_print_tree(inode);
> @@ -2256,7 +2257,9 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
>   *
>   * Used after a newly allocated extent is added to the extents status tree.
>   * Requires that the extents in the range have either written or unwritten
> - * status.  Must be called while holding i_es_lock.
> + * status.  Must be called while holding i_es_lock. Returns number of new
> + * inserts pending cluster on insert pendings, returns 0 on remove pendings,
> + * return -ENOMEM on failure.
>   */
>  static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  			    ext4_lblk_t len,
> @@ -2266,6 +2269,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  	ext4_lblk_t end = lblk + len - 1;
>  	ext4_lblk_t first, last;
>  	bool f_del = false, l_del = false;
> +	int pendings = 0;
>  	int ret = 0;
>  
>  	if (len == 0)
> @@ -2293,6 +2297,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  			ret = __insert_pending(inode, first, prealloc);
>  			if (ret < 0)
>  				goto out;
> +			pendings += ret;
>  		} else {
>  			last = EXT4_LBLK_CMASK(sbi, end) +
>  			       sbi->s_cluster_ratio - 1;
> @@ -2304,6 +2309,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  				ret = __insert_pending(inode, last, prealloc);
>  				if (ret < 0)
>  					goto out;
> +				pendings += ret;
>  			} else
>  				__remove_pending(inode, last);
>  		}
> @@ -2316,6 +2322,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  			ret = __insert_pending(inode, first, prealloc);
>  			if (ret < 0)
>  				goto out;
> +			pendings += ret;
>  		} else
>  			__remove_pending(inode, first);
>  
> @@ -2327,9 +2334,10 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  			ret = __insert_pending(inode, last, prealloc);
>  			if (ret < 0)
>  				goto out;
> +			pendings += ret;
>  		} else
>  			__remove_pending(inode, last);
>  	}
>  out:
> -	return ret;
> +	return (ret < 0) ? ret : pendings;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

