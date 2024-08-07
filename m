Return-Path: <linux-fsdevel+bounces-25334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D618C94AF1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 19:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F227B25F32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFCF13DBB7;
	Wed,  7 Aug 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9Ww8RDd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="omWwUP+4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f9Ww8RDd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="omWwUP+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239A80BEC;
	Wed,  7 Aug 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052907; cv=none; b=KxP+J8sZmZsjrJJkGwy/9nhEO5uJ9BoX90dWtbvPkOlhvao3xBgurFySGUGeyvCqu11f4PPaT4w6/b8o+nyYwElg4pq14kIOSSJm9FBSPpiHObq5TQzkT3RU4bnjy4urx6BFMA3Db+krkJ/BE0Ko9NWqbGYdhOeD3j/UHtKmf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052907; c=relaxed/simple;
	bh=gxnzrZK532UzXDU9oJooQnA7p6wuT0+Yfq3+XQ/ick4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enMRPASCEFXfb0KDp0vLBHkImhCK4YjtFIcRCL2oiTD7sij0SVoCa8Q26gpzu7nhS6w7r3Kh4VEa2PUK79gYiNOY8SxAU+/vUuGA4s878Hv7G6pOD7Flb2FSSfJRa/upeBdq4Z5nDQTP333pAtPqzjvprHCaseILChsBGmuec94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9Ww8RDd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=omWwUP+4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f9Ww8RDd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=omWwUP+4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50A101FB98;
	Wed,  7 Aug 2024 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723052903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izW4UerVRQHs5fzbafGixcUtLUBiwOZn6UJ4BD67bEU=;
	b=f9Ww8RDdu3QM3qBdVLQ3pFl3xt6Uwhalt8Ht6j4JHXjuLaBb8UnLygcN4cmM0nyj/8S6I2
	PIvsYWE7HOtNQ4D1tOjg0shshFgmxpMDyLxwNCp+XteuAX1wu8KCUr80t6BCpx7Edq5q/K
	bdIiDKclZJ9CYrGts8rMOk/iCM3/0sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723052903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izW4UerVRQHs5fzbafGixcUtLUBiwOZn6UJ4BD67bEU=;
	b=omWwUP+4wezOkL4Kpf3lbGnbJYY5G2hPopgIo7/F5fokQkhOKGTKA1U07/6Y1lYDy7kqB9
	fhis+fsqqNzLitDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f9Ww8RDd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=omWwUP+4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723052903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izW4UerVRQHs5fzbafGixcUtLUBiwOZn6UJ4BD67bEU=;
	b=f9Ww8RDdu3QM3qBdVLQ3pFl3xt6Uwhalt8Ht6j4JHXjuLaBb8UnLygcN4cmM0nyj/8S6I2
	PIvsYWE7HOtNQ4D1tOjg0shshFgmxpMDyLxwNCp+XteuAX1wu8KCUr80t6BCpx7Edq5q/K
	bdIiDKclZJ9CYrGts8rMOk/iCM3/0sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723052903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=izW4UerVRQHs5fzbafGixcUtLUBiwOZn6UJ4BD67bEU=;
	b=omWwUP+4wezOkL4Kpf3lbGnbJYY5G2hPopgIo7/F5fokQkhOKGTKA1U07/6Y1lYDy7kqB9
	fhis+fsqqNzLitDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DA8213A7D;
	Wed,  7 Aug 2024 17:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QLvLDmezs2Y6KAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 17:48:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D8FE2A0762; Wed,  7 Aug 2024 19:48:18 +0200 (CEST)
Date: Wed, 7 Aug 2024 19:48:18 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 09/10] ext4: drop ext4_es_is_delonly()
Message-ID: <20240807174818.bt6b4qhub7ydy5r5@quack3>
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-10-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802115120.362902-10-yi.zhang@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,huawei.com:email,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 50A101FB98

On Fri 02-08-24 19:51:19, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Since we don't add delayed flag in unwritten extents, so there is no
> difference between ext4_es_is_delayed() and ext4_es_is_delonly(),
> just drop ext4_es_is_delonly().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. But please also add assertion when inserting extent into status
tree that only one of EXTENT_STATUS_WRITTEN, EXTENT_STATUS_UNWRITTEN,
EXTENT_STATUS_DELAYED, and EXTENT_STATUS_HOLE is set.
Also perhaps add comment to EXTENT_STATUS_DELAYED (and other) definition that
these states are exclusive. Thanks!

									Honza

> ---
>  fs/ext4/extents_status.c | 18 +++++++++---------
>  fs/ext4/extents_status.h |  5 -----
>  fs/ext4/inode.c          |  4 ++--
>  3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index e482ac818317..5fb0a02405ba 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -563,8 +563,8 @@ static int ext4_es_can_be_merged(struct extent_status *es1,
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
> @@ -1139,7 +1139,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	ext4_lblk_t i, end, nclu;
>  
> -	if (!ext4_es_is_delonly(es))
> +	if (!ext4_es_is_delayed(es))
>  		return;
>  
>  	WARN_ON(len <= 0);
> @@ -1291,7 +1291,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  		es = rc->left_es;
>  		while (es && ext4_es_end(es) >=
>  		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
> -			if (ext4_es_is_delonly(es)) {
> +			if (ext4_es_is_delayed(es)) {
>  				rc->ndelonly_cluster--;
>  				left_delonly = true;
>  				break;
> @@ -1311,7 +1311,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  			}
>  			while (es && es->es_lblk <=
>  			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
> -				if (ext4_es_is_delonly(es)) {
> +				if (ext4_es_is_delayed(es)) {
>  					rc->ndelonly_cluster--;
>  					right_delonly = true;
>  					break;
> @@ -2239,7 +2239,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  	if (EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) {
>  		first = EXT4_LBLK_CMASK(sbi, lblk);
>  		if (first != lblk)
> -			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
> +			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
>  						first, lblk - 1);
>  		if (f_del) {
>  			ret = __insert_pending(inode, first, prealloc);
> @@ -2251,7 +2251,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  			       sbi->s_cluster_ratio - 1;
>  			if (last != end)
>  				l_del = __es_scan_range(inode,
> -							&ext4_es_is_delonly,
> +							&ext4_es_is_delayed,
>  							end + 1, last);
>  			if (l_del) {
>  				ret = __insert_pending(inode, last, prealloc);
> @@ -2264,7 +2264,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  	} else {
>  		first = EXT4_LBLK_CMASK(sbi, lblk);
>  		if (first != lblk)
> -			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
> +			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
>  						first, lblk - 1);
>  		if (f_del) {
>  			ret = __insert_pending(inode, first, prealloc);
> @@ -2276,7 +2276,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>  
>  		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
>  		if (last != end)
> -			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
> +			l_del = __es_scan_range(inode, &ext4_es_is_delayed,
>  						end + 1, last);
>  		if (l_del) {
>  			ret = __insert_pending(inode, last, prealloc);
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 5b49cb3b9aff..e484c60e55e3 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -184,11 +184,6 @@ static inline int ext4_es_is_mapped(struct extent_status *es)
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
> index 8bd65a45a26a..2b301c165468 100644
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

