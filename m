Return-Path: <linux-fsdevel+bounces-28537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701896B881
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4536283C24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF91CF7A3;
	Wed,  4 Sep 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lH6DAcOP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoZXk6U9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lH6DAcOP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoZXk6U9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0869884A40;
	Wed,  4 Sep 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445754; cv=none; b=GDjU/bMKWhhLzaKRMSuJYEyxfpD1wD8kbGHkahSgpzrmNnDsXUK8+O2JWwSsOmsL91kEQgKgeCnzWp9DzYe6OaORzkEC9QY6+dC+ZVUh1sYzTveQ5GNiiB0OVMKuCNjP/ds6opfj3POcrNIojRD/qFURZbTLY1BJghfv136AHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445754; c=relaxed/simple;
	bh=UxVLT41D/DO8Tmt0NUgmBkXwDFhkN43lzVhTOheqQCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foOmIGU/2XQUpuRRdBEiTJRCSVkpaQVfrGaxmUhwHIzPKtZEEyHPxuINX40HQhf1cOe5P7nJ8ueZJXQf3uOl+MkYHm2AhGsukI+iMH+aTQM73pEp2Axo++SQ1cGFDHgsXHxY0sE+wel8kKkWzBNw2Lg1km3KMzSY+NfdGt+Euek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lH6DAcOP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoZXk6U9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lH6DAcOP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoZXk6U9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63DE6219E7;
	Wed,  4 Sep 2024 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xhHVm+kdMC0oAYtRNcHPjyGbTsP+Y7XDoyhfNSttUY=;
	b=lH6DAcOPglDdnmDGaGkooj+UE+lmw+NHnqAKy4nGoDGGAWW6P5TxpQxAM4X8lQT6qA0UXB
	CXFoOglBdr3ELsHYtJcJ3bginDZv9MsMihslrJ/FUVtWtZCiCZ20M/quOhmJO02hFDS36Q
	wte+7nHFiY1qAPo5a0hmw29rlT++zOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xhHVm+kdMC0oAYtRNcHPjyGbTsP+Y7XDoyhfNSttUY=;
	b=UoZXk6U9VmiF0cI+gcC90wwBE4xHThfowUk5HG/MxBeyEJpEmP6yeWLm7J57DcWSbB97E5
	1qRHkjlRoSULUmDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xhHVm+kdMC0oAYtRNcHPjyGbTsP+Y7XDoyhfNSttUY=;
	b=lH6DAcOPglDdnmDGaGkooj+UE+lmw+NHnqAKy4nGoDGGAWW6P5TxpQxAM4X8lQT6qA0UXB
	CXFoOglBdr3ELsHYtJcJ3bginDZv9MsMihslrJ/FUVtWtZCiCZ20M/quOhmJO02hFDS36Q
	wte+7nHFiY1qAPo5a0hmw29rlT++zOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xhHVm+kdMC0oAYtRNcHPjyGbTsP+Y7XDoyhfNSttUY=;
	b=UoZXk6U9VmiF0cI+gcC90wwBE4xHThfowUk5HG/MxBeyEJpEmP6yeWLm7J57DcWSbB97E5
	1qRHkjlRoSULUmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57E24139D2;
	Wed,  4 Sep 2024 10:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gg9yFXc22GaHKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:29:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FCB0A0968; Wed,  4 Sep 2024 12:28:56 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:28:56 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 11/12] ext4: drop ext4_es_is_delonly()
Message-ID: <20240904102856.c3t57ftmjtz4h3w7@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-12-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-12-yi.zhang@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 13-08-24 20:34:51, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we don't add delayed flag in unwritten extents, so there is no
> difference between ext4_es_is_delayed() and ext4_es_is_delonly(),
> just drop ext4_es_is_delonly().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 18 +++++++++---------
>  fs/ext4/extents_status.h |  5 -----
>  fs/ext4/inode.c          |  4 ++--
>  3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index b372b98af366..68c47ecc01a5 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -558,8 +558,8 @@ static int ext4_es_can_be_merged(struct extent_status *es1,
>  	if (ext4_es_is_hole(es1))
>  		return 1;
>  
> -	/* we need to check delayed extent is without unwritten status */
> -	if (ext4_es_is_delayed(es1) && !ext4_es_is_unwritten(es1))
> +	/* we need to check delayed extent */
> +	if (ext4_es_is_delayed(es1))
>  		return 1;
>  
>  	return 0;
> @@ -1135,7 +1135,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	ext4_lblk_t i, end, nclu;
>  
> -	if (!ext4_es_is_delonly(es))
> +	if (!ext4_es_is_delayed(es))
>  		return;
>  
>  	WARN_ON(len <= 0);
> @@ -1285,7 +1285,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  		es = rc->left_es;
>  		while (es && ext4_es_end(es) >=
>  		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
> -			if (ext4_es_is_delonly(es)) {
> +			if (ext4_es_is_delayed(es)) {
>  				rc->ndelonly--;
>  				left_delonly = true;
>  				break;
> @@ -1305,7 +1305,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  			}
>  			while (es && es->es_lblk <=
>  			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
> -				if (ext4_es_is_delonly(es)) {
> +				if (ext4_es_is_delayed(es)) {
>  					rc->ndelonly--;
>  					right_delonly = true;
>  					break;
> @@ -2226,7 +2226,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) {
>  		first = EXT4_LBLK_CMASK(sbi, lblk);
>  		if (first != lblk)
> -			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
> +			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
>  						first, lblk - 1);
>  		if (f_del) {
>  			ret = __insert_pending(inode, first, prealloc);
> @@ -2238,7 +2238,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  			       sbi->s_cluster_ratio - 1;
>  			if (last != end)
>  				l_del = __es_scan_range(inode,
> -							&ext4_es_is_delonly,
> +							&ext4_es_is_delayed,
>  							end + 1, last);
>  			if (l_del) {
>  				ret = __insert_pending(inode, last, prealloc);
> @@ -2251,7 +2251,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  	} else {
>  		first = EXT4_LBLK_CMASK(sbi, lblk);
>  		if (first != lblk)
> -			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
> +			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
>  						first, lblk - 1);
>  		if (f_del) {
>  			ret = __insert_pending(inode, first, prealloc);
> @@ -2263,7 +2263,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  
>  		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
>  		if (last != end)
> -			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
> +			l_del = __es_scan_range(inode, &ext4_es_is_delayed,
>  						end + 1, last);
>  		if (l_del) {
>  			ret = __insert_pending(inode, last, prealloc);
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 7d7af642f7b2..4424232de298 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -190,11 +190,6 @@ static inline int ext4_es_is_mapped(struct extent_status *es)
>  	return (ext4_es_is_written(es) || ext4_es_is_unwritten(es));
>  }
>  
> -static inline int ext4_es_is_delonly(struct extent_status *es)
> -{
> -	return (ext4_es_is_delayed(es) && !ext4_es_is_unwritten(es));
> -}
> -
>  static inline void ext4_es_set_referenced(struct extent_status *es)
>  {
>  	es->es_pblk |= ((ext4_fsblk_t)EXTENT_STATUS_REFERENCED) << ES_SHIFT;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2fa13e9e78bc..bdf466d5a8d4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1645,7 +1645,7 @@ static int ext4_clu_alloc_state(struct inode *inode, ext4_lblk_t lblk)
>  	int ret;
>  
>  	/* Has delalloc reservation? */
> -	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
> +	if (ext4_es_scan_clu(inode, &ext4_es_is_delayed, lblk))
>  		return 1;
>  
>  	/* Already been allocated? */
> @@ -1766,7 +1766,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>  		 * Delayed extent could be allocated by fallocate.
>  		 * So we need to check it.
>  		 */
> -		if (ext4_es_is_delonly(&es)) {
> +		if (ext4_es_is_delayed(&es)) {
>  			map->m_flags |= EXT4_MAP_DELAYED;
>  			return 0;
>  		}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

