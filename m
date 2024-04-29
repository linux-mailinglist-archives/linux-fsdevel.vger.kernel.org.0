Return-Path: <linux-fsdevel+bounces-18083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED68B542E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982C7B21606
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DB7241E1;
	Mon, 29 Apr 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSG4mff9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GRW8KXda";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSG4mff9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GRW8KXda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB77225D9;
	Mon, 29 Apr 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382694; cv=none; b=Se2yWw4ai7LWSu+hn2OCxzN4oeuEuCS/e+Gc++a7QKFNVBqBrC5KLMPjOy+ih1wi7I1Iw7jKKZXxvoBJ+pcMNQZLi8yWn8Q+SzxgZBmM41aE/bAAO3qF4FgOMtqas9QVcVqN/CPcdKGpGgSgoxLw+ba6UJm75uZ/SIenNNVLBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382694; c=relaxed/simple;
	bh=sJPb7V8UizZTIbMgMDLFAyJMMWRvQV5ZANpdYz04Zsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXw3fSGqNLyG3ih6btJg+oYVgRRB4BJuC2VaoF0JWZYmqDohaoSthCqHzHQgCOBPFnuCv+rkr9NEf3X5P3ahaNoLAy02Wd6oFkzr/DDY5Sb02cTzcqdqUZY9FrqrU6M89Iatzsgzo6Qi65/uOLduTMT6u+WaVFxJ4bWxJB2sqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSG4mff9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GRW8KXda; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSG4mff9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GRW8KXda; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AA6320423;
	Mon, 29 Apr 2024 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714382690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyDjylYD8kVW2sGw7PTM8FVhAAfgVR7hitnf6n7o90=;
	b=mSG4mff9GcSBYKlY11yYjRrjjZUX/mcGCxDVFMBigEvZy+eLH/GXMAwLnloEthAiSm2QMM
	dKO3CVbiOJKnWk5AX+8eTp0cN4wvvCjjpxGB/6ex7D6o3B6Bx1LxfdzgDwJrXgGzQg0aTT
	dOMduZRinoWNZ0cKMJexLUX+kUp76Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714382690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyDjylYD8kVW2sGw7PTM8FVhAAfgVR7hitnf6n7o90=;
	b=GRW8KXdayFb5Z4RxZClr2WHU26mfV2hjHz6DFVlJx2BOQKrmGlI7erQFXlw/mEywXjMY04
	0XIkHR6Va4tlzSDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mSG4mff9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GRW8KXda
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714382690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyDjylYD8kVW2sGw7PTM8FVhAAfgVR7hitnf6n7o90=;
	b=mSG4mff9GcSBYKlY11yYjRrjjZUX/mcGCxDVFMBigEvZy+eLH/GXMAwLnloEthAiSm2QMM
	dKO3CVbiOJKnWk5AX+8eTp0cN4wvvCjjpxGB/6ex7D6o3B6Bx1LxfdzgDwJrXgGzQg0aTT
	dOMduZRinoWNZ0cKMJexLUX+kUp76Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714382690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpyDjylYD8kVW2sGw7PTM8FVhAAfgVR7hitnf6n7o90=;
	b=GRW8KXdayFb5Z4RxZClr2WHU26mfV2hjHz6DFVlJx2BOQKrmGlI7erQFXlw/mEywXjMY04
	0XIkHR6Va4tlzSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE99138A7;
	Mon, 29 Apr 2024 09:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0I49E2JnL2aJHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 09:24:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0F4EA082F; Mon, 29 Apr 2024 11:24:49 +0200 (CEST)
Date: Mon, 29 Apr 2024 11:24:49 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 5/9] ext4: make ext4_es_insert_delayed_block() insert
 multi-blocks
Message-ID: <20240429092449.6p5ynxw6flxu7t3b@quack3>
References: <20240410034203.2188357-1-yi.zhang@huaweicloud.com>
 <20240410034203.2188357-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410034203.2188357-6-yi.zhang@huaweicloud.com>
X-Spam-Level: ****
X-Spamd-Result: default: False [4.39 / 50.00];
	BAYES_SPAM(5.10)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: 4.39
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: 5AA6320423
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed 10-04-24 11:41:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>

I've realized I wanted to suggest some language changes for the changelog:

> Rename ext4_es_insert_delayed_block() to ext4_es_insert_delayed_extent()
> and pass length parameter to make it insert multi delalloc blocks once a
					      ^^^ multiple delalloc blocks
at a time.

> time. For the case of bigalloc, expand the allocated parameter to
				  ^^^^ split

> lclu_allocated and end_allocated. lclu_allocated indicates the allocate
								 ^^^
allocation

> state of the cluster which containing the lblk, end_allocated represents
			^^^^ which is containing                ^^^^
indicates the allocation state of the extent end

> the end, and the middle clusters must be unallocated.
       ^^^. Clusters in the middle of delay allocated extent must be
unallocated.

								Honza

> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/extents_status.c    | 63 ++++++++++++++++++++++++-------------
>  fs/ext4/extents_status.h    |  5 +--
>  fs/ext4/inode.c             |  2 +-
>  include/trace/events/ext4.h | 16 +++++-----
>  4 files changed, 55 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 4a00e2f019d9..2320b0d71001 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -2052,34 +2052,42 @@ bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk)
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
> + *                                 that contains the block
>   */
> -void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> -				  bool allocated)
> +void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
> +				   ext4_lblk_t len, bool lclu_allocated,
> +				   bool end_allocated)
>  {
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
> @@ -2088,11 +2096,15 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
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
> @@ -2112,13 +2124,22 @@ void ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
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
> index cccc16506f5f..d37233e2ed0b 100644
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

