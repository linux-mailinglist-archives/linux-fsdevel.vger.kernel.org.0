Return-Path: <linux-fsdevel+bounces-28538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D69096B897
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4711F25AAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DEA1D0141;
	Wed,  4 Sep 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3typWsL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k089uiug";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3typWsL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k089uiug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910A1CF7D2;
	Wed,  4 Sep 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445873; cv=none; b=QxBmjYSq4R0tsYDOtu3C8AA9bL7mR16NjN3lSdSQ20gqHXCFfmnxVeVOPIFB7S1rPfWwuRC9ENqbhBz2ZCtf9FtJwuunhSlaziChoNX4woUwbSIBNubmjSwnGGh7SijgaCoNg/qM3FUZHfIekHZzjbMXKYO24sPPTPjQow3fhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445873; c=relaxed/simple;
	bh=Vt19YejQLGkjUqvrVVyG50PQ4PxNu45Gl66ScVUOt8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqNReZVuIwssLvr7OJ6gxuUe60LYLfH52AtyopvuSfXs3ZRLbMUS6TyF/8f+EBNeNSj07EhfoLj4GgxN8w9h7MVt6xI+bIK2Hrj4uadAo1r0dc0wUItZIOxAIllq19SyMGYh0UEUl0DLxwsMAYoox4vYj08oN6Sc5g3fzSkwiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3typWsL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k089uiug; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3typWsL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k089uiug; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7493F219E7;
	Wed,  4 Sep 2024 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twXWpsZnz0cylI2dcNgo3imh3jWjDml5cL3Iwux1DfA=;
	b=z3typWsLQx+9c2vA0Fpp5KkN0PY3WPWPloH1jKtXs13Z8Dg/G4jbMRL2m8hbQ/98OrcQ3K
	l7EBoFEWeWJtJgpocdOaKt+xBR2cLmlGwH9ro6TQyWjLqPbG/VqbTFT9m7xERlQrtYZ1cV
	OEYWfqtdFWfA62P8P+NBJeFZIyaWV98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twXWpsZnz0cylI2dcNgo3imh3jWjDml5cL3Iwux1DfA=;
	b=k089uiugmHUj0KJJC9NmlWNkkmhS4f+YmXkRRWW7gg0vSakYkdH41DZ29dbwJq1qSyUssX
	93OQ9tIbAye9wbDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725445869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twXWpsZnz0cylI2dcNgo3imh3jWjDml5cL3Iwux1DfA=;
	b=z3typWsLQx+9c2vA0Fpp5KkN0PY3WPWPloH1jKtXs13Z8Dg/G4jbMRL2m8hbQ/98OrcQ3K
	l7EBoFEWeWJtJgpocdOaKt+xBR2cLmlGwH9ro6TQyWjLqPbG/VqbTFT9m7xERlQrtYZ1cV
	OEYWfqtdFWfA62P8P+NBJeFZIyaWV98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725445869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twXWpsZnz0cylI2dcNgo3imh3jWjDml5cL3Iwux1DfA=;
	b=k089uiugmHUj0KJJC9NmlWNkkmhS4f+YmXkRRWW7gg0vSakYkdH41DZ29dbwJq1qSyUssX
	93OQ9tIbAye9wbDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 538E2139D2;
	Wed,  4 Sep 2024 10:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OhRkFO022GY9KgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 10:31:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0695A0968; Wed,  4 Sep 2024 12:31:04 +0200 (CEST)
Date: Wed, 4 Sep 2024 12:31:04 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 12/12] ext4: drop all delonly descriptions
Message-ID: <20240904103104.a5oxkkbqpgu6uoms@quack3>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-13-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813123452.2824659-13-yi.zhang@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 13-08-24 20:34:52, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When counting reserved clusters, delayed type is always equal to delonly
> type now, hence drop all delonly descriptions in parameters and
> comments.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 66 +++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 68c47ecc01a5..c786691dabd3 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1067,7 +1067,7 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
>  }
>  
>  struct rsvd_count {
> -	int ndelonly;
> +	int ndelayed;
>  	bool first_do_lblk_found;
>  	ext4_lblk_t first_do_lblk;
>  	ext4_lblk_t last_do_lblk;
> @@ -1093,10 +1093,10 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct rb_node *node;
>  
> -	rc->ndelonly = 0;
> +	rc->ndelayed = 0;
>  
>  	/*
> -	 * for bigalloc, note the first delonly block in the range has not
> +	 * for bigalloc, note the first delayed block in the range has not
>  	 * been found, record the extent containing the block to the left of
>  	 * the region to be removed, if any, and note that there's no partial
>  	 * cluster to track
> @@ -1116,9 +1116,8 @@ static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
>  }
>  
>  /*
> - * count_rsvd - count the clusters containing delayed and not unwritten
> - *		(delonly) blocks in a range within an extent and add to
> - *	        the running tally in rsvd_count
> + * count_rsvd - count the clusters containing delayed blocks in a range
> + *	        within an extent and add to the running tally in rsvd_count
>   *
>   * @inode - file containing extent
>   * @lblk - first block in range
> @@ -1141,7 +1140,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  	WARN_ON(len <= 0);
>  
>  	if (sbi->s_cluster_ratio == 1) {
> -		rc->ndelonly += (int) len;
> +		rc->ndelayed += (int) len;
>  		return;
>  	}
>  
> @@ -1151,7 +1150,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  	end = lblk + (ext4_lblk_t) len - 1;
>  	end = (end > ext4_es_end(es)) ? ext4_es_end(es) : end;
>  
> -	/* record the first block of the first delonly extent seen */
> +	/* record the first block of the first delayed extent seen */
>  	if (!rc->first_do_lblk_found) {
>  		rc->first_do_lblk = i;
>  		rc->first_do_lblk_found = true;
> @@ -1165,7 +1164,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  	 * doesn't start with it, count it and stop tracking
>  	 */
>  	if (rc->partial && (rc->lclu != EXT4_B2C(sbi, i))) {
> -		rc->ndelonly++;
> +		rc->ndelayed++;
>  		rc->partial = false;
>  	}
>  
> @@ -1175,7 +1174,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  	 */
>  	if (EXT4_LBLK_COFF(sbi, i) != 0) {
>  		if (end >= EXT4_LBLK_CFILL(sbi, i)) {
> -			rc->ndelonly++;
> +			rc->ndelayed++;
>  			rc->partial = false;
>  			i = EXT4_LBLK_CFILL(sbi, i) + 1;
>  		}
> @@ -1183,11 +1182,11 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>  
>  	/*
>  	 * if the current cluster starts on a cluster boundary, count the
> -	 * number of whole delonly clusters in the extent
> +	 * number of whole delayed clusters in the extent
>  	 */
>  	if ((i + sbi->s_cluster_ratio - 1) <= end) {
>  		nclu = (end - i + 1) >> sbi->s_cluster_bits;
> -		rc->ndelonly += nclu;
> +		rc->ndelayed += nclu;
>  		i += nclu << sbi->s_cluster_bits;
>  	}
>  
> @@ -1247,10 +1246,9 @@ static struct pending_reservation *__pr_tree_search(struct rb_root *root,
>   * @rc - pointer to reserved count data
>   *
>   * The number of reservations to be released is equal to the number of
> - * clusters containing delayed and not unwritten (delonly) blocks within
> - * the range, minus the number of clusters still containing delonly blocks
> - * at the ends of the range, and minus the number of pending reservations
> - * within the range.
> + * clusters containing delayed blocks within the range, minus the number of
> + * clusters still containing delayed blocks at the ends of the range, and
> + * minus the number of pending reservations within the range.
>   */
>  static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  			     struct extent_status *right_es,
> @@ -1261,33 +1259,33 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
>  	struct rb_node *node;
>  	ext4_lblk_t first_lclu, last_lclu;
> -	bool left_delonly, right_delonly, count_pending;
> +	bool left_delayed, right_delayed, count_pending;
>  	struct extent_status *es;
>  
>  	if (sbi->s_cluster_ratio > 1) {
>  		/* count any remaining partial cluster */
>  		if (rc->partial)
> -			rc->ndelonly++;
> +			rc->ndelayed++;
>  
> -		if (rc->ndelonly == 0)
> +		if (rc->ndelayed == 0)
>  			return 0;
>  
>  		first_lclu = EXT4_B2C(sbi, rc->first_do_lblk);
>  		last_lclu = EXT4_B2C(sbi, rc->last_do_lblk);
>  
>  		/*
> -		 * decrease the delonly count by the number of clusters at the
> -		 * ends of the range that still contain delonly blocks -
> +		 * decrease the delayed count by the number of clusters at the
> +		 * ends of the range that still contain delayed blocks -
>  		 * these clusters still need to be reserved
>  		 */
> -		left_delonly = right_delonly = false;
> +		left_delayed = right_delayed = false;
>  
>  		es = rc->left_es;
>  		while (es && ext4_es_end(es) >=
>  		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
>  			if (ext4_es_is_delayed(es)) {
> -				rc->ndelonly--;
> -				left_delonly = true;
> +				rc->ndelayed--;
> +				left_delayed = true;
>  				break;
>  			}
>  			node = rb_prev(&es->rb_node);
> @@ -1295,7 +1293,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  				break;
>  			es = rb_entry(node, struct extent_status, rb_node);
>  		}
> -		if (right_es && (!left_delonly || first_lclu != last_lclu)) {
> +		if (right_es && (!left_delayed || first_lclu != last_lclu)) {
>  			if (end < ext4_es_end(right_es)) {
>  				es = right_es;
>  			} else {
> @@ -1306,8 +1304,8 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  			while (es && es->es_lblk <=
>  			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
>  				if (ext4_es_is_delayed(es)) {
> -					rc->ndelonly--;
> -					right_delonly = true;
> +					rc->ndelayed--;
> +					right_delayed = true;
>  					break;
>  				}
>  				node = rb_next(&es->rb_node);
> @@ -1321,21 +1319,21 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  		/*
>  		 * Determine the block range that should be searched for
>  		 * pending reservations, if any.  Clusters on the ends of the
> -		 * original removed range containing delonly blocks are
> +		 * original removed range containing delayed blocks are
>  		 * excluded.  They've already been accounted for and it's not
>  		 * possible to determine if an associated pending reservation
>  		 * should be released with the information available in the
>  		 * extents status tree.
>  		 */
>  		if (first_lclu == last_lclu) {
> -			if (left_delonly | right_delonly)
> +			if (left_delayed | right_delayed)
>  				count_pending = false;
>  			else
>  				count_pending = true;
>  		} else {
> -			if (left_delonly)
> +			if (left_delayed)
>  				first_lclu++;
> -			if (right_delonly)
> +			if (right_delayed)
>  				last_lclu--;
>  			if (first_lclu <= last_lclu)
>  				count_pending = true;
> @@ -1346,13 +1344,13 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  		/*
>  		 * a pending reservation found between first_lclu and last_lclu
>  		 * represents an allocated cluster that contained at least one
> -		 * delonly block, so the delonly total must be reduced by one
> +		 * delayed block, so the delayed total must be reduced by one
>  		 * for each pending reservation found and released
>  		 */
>  		if (count_pending) {
>  			pr = __pr_tree_search(&tree->root, first_lclu);
>  			while (pr && pr->lclu <= last_lclu) {
> -				rc->ndelonly--;
> +				rc->ndelayed--;
>  				node = rb_next(&pr->rb_node);
>  				rb_erase(&pr->rb_node, &tree->root);
>  				__free_pending(pr);
> @@ -1363,7 +1361,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>  			}
>  		}
>  	}
> -	return rc->ndelonly;
> +	return rc->ndelayed;
>  }
>  
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

