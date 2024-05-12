Return-Path: <linux-fsdevel+bounces-19373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E18C4236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B867A28390F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBFA153833;
	Mon, 13 May 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bPOx6Lg4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bh6tiYiK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bPOx6Lg4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bh6tiYiK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037D153502;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607697; cv=none; b=T07Khx+X79Haup9+aQmMOukr/4UG5Zabu4VNAbHzo3ssA5xogA1kgg8eLIOvC+j3HsqQPyXL/C+fXXPEOBiOFbfzyg9VjH/EXx7x0BQWxiw10LRqiHwt2dJ8So7hkOSDZ7eVeVhJAfVxJnf1cZFs3hFiLF8ccbglgniug+BIQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607697; c=relaxed/simple;
	bh=IkSOH/QJ8zX9eo1mKMpoGAbAiN5je0pKXZRsyN9fS68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbvsCvZek+zYv9mdfiVZWaZ3x17Kn0/8dDFMmv0QWvsVePkT5F2qJvzFZ26ledNeQgDLdXCRe8e1M7aMYoNb80HXpW7qjoCryCSUriNoli9GfZ1bygjvqkCg4+UCMBD9YB45i8uPJl7BD/16V5N9W7iXqlI08LjUQVBUD0hquFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bPOx6Lg4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bh6tiYiK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bPOx6Lg4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bh6tiYiK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47C885C0CF;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfyKwuuDXilYt4nEIc0rThmaU3gsgN260hitOkp56pY=;
	b=bPOx6Lg4ZxoXjRrbSXdE1Bl2RPL3AApxnuYvHr5iUVwP4kSLBAk8OuAUCI9TRKPBQlDBkg
	lzeKHtxufC1mN9Ha6paXYxUKN74F/aYoI2Ti2mAQ0Y+Yw/E+8AsFTKRI5FW+j+nzWoyGQj
	q5V7tQXIuLfdE6gk92HFs9A3mXuPF8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfyKwuuDXilYt4nEIc0rThmaU3gsgN260hitOkp56pY=;
	b=bh6tiYiK/U29vEF6vD3djuzFvFA9FD5nkM6RnuP1mkg06y7E6lyULBst9Uasl+aYxKRCv2
	w2fy3uw1XzzpXrCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfyKwuuDXilYt4nEIc0rThmaU3gsgN260hitOkp56pY=;
	b=bPOx6Lg4ZxoXjRrbSXdE1Bl2RPL3AApxnuYvHr5iUVwP4kSLBAk8OuAUCI9TRKPBQlDBkg
	lzeKHtxufC1mN9Ha6paXYxUKN74F/aYoI2Ti2mAQ0Y+Yw/E+8AsFTKRI5FW+j+nzWoyGQj
	q5V7tQXIuLfdE6gk92HFs9A3mXuPF8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfyKwuuDXilYt4nEIc0rThmaU3gsgN260hitOkp56pY=;
	b=bh6tiYiK/U29vEF6vD3djuzFvFA9FD5nkM6RnuP1mkg06y7E6lyULBst9Uasl+aYxKRCv2
	w2fy3uw1XzzpXrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1283113A5F;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GFp8BI4YQmYfDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 045A3A0909; Sun, 12 May 2024 17:19:59 +0200 (CEST)
Date: Sun, 12 May 2024 17:19:59 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 06/10] ext4: make ext4_es_insert_delayed_block()
 insert multi-blocks
Message-ID: <20240512151959.ka2knnekhio3ovf3@quack3>
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
 <20240508061220.967970-7-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508061220.967970-7-yi.zhang@huaweicloud.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email]

On Wed 08-05-24 14:12:16, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Rename ext4_es_insert_delayed_block() to ext4_es_insert_delayed_extent()
> and pass length parameter to make it insert multiple delalloc blocks at
> a time. For the case of bigalloc, split the allocated parameter to
> lclu_allocated and end_allocated. lclu_allocated indicates the
> allocation state of the cluster which is containing the lblk,
> end_allocated indicates the allocation state of the extent end, clusters
> in the middle of delay allocated extent must be unallocated.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c    | 70 ++++++++++++++++++++++++++-----------
>  fs/ext4/extents_status.h    |  5 +--
>  fs/ext4/inode.c             |  2 +-
>  include/trace/events/ext4.h | 16 +++++----
>  4 files changed, 62 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 4a00e2f019d9..23caf1f028b0 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -2052,34 +2052,49 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
>  }
>  
>  /*
> - * ext4_es_insert_delayed_block - adds a delayed block to the extents status
> - *                                tree, adding a pending reservation where
> - *                                needed
> + * ext4_es_insert_delayed_extent - adds some delayed blocks to the extents
> + *                                 status tree, adding a pending reservation
> + *                                 where needed
>   *
>   * @inode - file containing the newly added block
> - * @lblk - logical block to be added
> - * @allocated - indicates whether a physical cluster has been allocated for
> - *              the logical cluster that contains the block
> + * @lblk - start logical block to be added
> + * @len - length of blocks to be added
> + * @lclu_allocated/end_allocated - indicates whether a physical cluster has
> + *                                 been allocated for the logical cluster
> + *                                 that contains the start/end block. Note that
> + *                                 end_allocated should always be set to false
> + *                                 if the start and the end block are in the
> + *                                 same cluster
>   */
> -void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> -				  bool allocated)
> +void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
> +				   ext4_lblk_t len, bool lclu_allocated,
> +				   bool end_allocated)
>  {
> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct extent_status newes;
> +	ext4_lblk_t end = lblk + len - 1;
>  	int err1 = 0, err2 = 0, err3 = 0;
>  	struct extent_status *es1 = NULL;
>  	struct extent_status *es2 = NULL;
> -	struct pending_reservation *pr = NULL;
> +	struct pending_reservation *pr1 = NULL;
> +	struct pending_reservation *pr2 = NULL;
>  
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
> -		 lblk, inode->i_ino);
> +	es_debug("add [%u/%u) delayed to extent status tree of inode %lu\n",
> +		 lblk, len, inode->i_ino);
> +	if (!len)
> +		return;
> +
> +	WARN_ON_ONCE((EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) &&
> +		     end_allocated);
>  
>  	newes.es_lblk = lblk;
> -	newes.es_len = 1;
> +	newes.es_len = len;
>  	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
> -	trace_ext4_es_insert_delayed_block(inode, &newes, allocated);
> +	trace_ext4_es_insert_delayed_extent(inode, &newes, lclu_allocated,
> +					    end_allocated);
>  
>  	ext4_es_insert_extent_check(inode, &newes);
>  
> @@ -2088,11 +2103,15 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  		es1 = __es_alloc_extent(true);
>  	if ((err1 || err2) && !es2)
>  		es2 = __es_alloc_extent(true);
> -	if ((err1 || err2 || err3) && allocated && !pr)
> -		pr = __alloc_pending(true);
> +	if (err1 || err2 || err3) {
> +		if (lclu_allocated && !pr1)
> +			pr1 = __alloc_pending(true);
> +		if (end_allocated && !pr2)
> +			pr2 = __alloc_pending(true);
> +	}
>  	write_lock(&EXT4_I(inode)->i_es_lock);
>  
> -	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
> +	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
>  	if (err1 != 0)
>  		goto error;
>  	/* Free preallocated extent if it didn't get used. */
> @@ -2112,13 +2131,22 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  		es2 = NULL;
>  	}
>  
> -	if (allocated) {
> -		err3 = __insert_pending(inode, lblk, &pr);
> +	if (lclu_allocated) {
> +		err3 = __insert_pending(inode, lblk, &pr1);
>  		if (err3 != 0)
>  			goto error;
> -		if (pr) {
> -			__free_pending(pr);
> -			pr = NULL;
> +		if (pr1) {
> +			__free_pending(pr1);
> +			pr1 = NULL;
> +		}
> +	}
> +	if (end_allocated) {
> +		err3 = __insert_pending(inode, end, &pr2);
> +		if (err3 != 0)
> +			goto error;
> +		if (pr2) {
> +			__free_pending(pr2);
> +			pr2 = NULL;
>  		}
>  	}
>  error:
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index d9847a4a25db..3c8e2edee5d5 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -249,8 +249,9 @@ extern void ext4_exit_pending(void);
>  extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
>  extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
>  extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
> -extern void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> -					 bool allocated);
> +extern void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
> +					  ext4_lblk_t len, bool lclu_allocated,
> +					  bool end_allocated);
>  extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
>  					ext4_lblk_t len);
>  extern void ext4_clear_inode_es(struct inode *inode);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index de157aebc306..f64fe8b873ce 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1702,7 +1702,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>  		}
>  	}
>  
> -	ext4_es_insert_delayed_block(inode, lblk, allocated);
> +	ext4_es_insert_delayed_extent(inode, lblk, 1, allocated, false);
>  	return 0;
>  }
>  
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index a697f4b77162..6b41ac61310f 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -2478,11 +2478,11 @@ TRACE_EVENT(ext4_es_shrink,
>  		  __entry->scan_time, __entry->nr_skipped, __entry->retried)
>  );
>  
> -TRACE_EVENT(ext4_es_insert_delayed_block,
> +TRACE_EVENT(ext4_es_insert_delayed_extent,
>  	TP_PROTO(struct inode *inode, struct extent_status *es,
> -		 bool allocated),
> +		 bool lclu_allocated, bool end_allocated),
>  
> -	TP_ARGS(inode, es, allocated),
> +	TP_ARGS(inode, es, lclu_allocated, end_allocated),
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,		dev		)
> @@ -2491,7 +2491,8 @@ TRACE_EVENT(ext4_es_insert_delayed_block,
>  		__field(	ext4_lblk_t,	len		)
>  		__field(	ext4_fsblk_t,	pblk		)
>  		__field(	char,		status		)
> -		__field(	bool,		allocated	)
> +		__field(	bool,		lclu_allocated	)
> +		__field(	bool,		end_allocated	)
>  	),
>  
>  	TP_fast_assign(
> @@ -2501,16 +2502,17 @@ TRACE_EVENT(ext4_es_insert_delayed_block,
>  		__entry->len		= es->es_len;
>  		__entry->pblk		= ext4_es_show_pblock(es);
>  		__entry->status		= ext4_es_status(es);
> -		__entry->allocated	= allocated;
> +		__entry->lclu_allocated	= lclu_allocated;
> +		__entry->end_allocated	= end_allocated;
>  	),
>  
>  	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
> -		  "allocated %d",
> +		  "allocated %d %d",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  (unsigned long) __entry->ino,
>  		  __entry->lblk, __entry->len,
>  		  __entry->pblk, show_extent_status(__entry->status),
> -		  __entry->allocated)
> +		  __entry->lclu_allocated, __entry->end_allocated)
>  );
>  
>  /* fsmap traces */
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

