Return-Path: <linux-fsdevel+bounces-18082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D88B5415
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 11:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA66B21EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A222325;
	Mon, 29 Apr 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eNN7qaz5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWNpUOpl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eNN7qaz5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lWNpUOpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CE17C79;
	Mon, 29 Apr 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382202; cv=none; b=WMU5k+EAZQzdHn8pyRQ42TEinsGzABVk3bzlFYGiGroAmdPcvTmwDoUbEZifbZ6YViEB9TCskcNn0Ed9AcHnIuymQfomCpCwSL0UfyTaf+ZP++nkzFucgdlH/e3nqoms9KCykePokTH25KZB3o7oqH0WMqvNKtADKGvqu20CKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382202; c=relaxed/simple;
	bh=PM3rm9sJ3XXMac97KaA781z9Csz1LCVGKqqhBW+iepY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usO9Iy4f4yZk5tlGoPXQ4ZMnVAYxfki04WAH7CqjdrimDT/xh1JgsY8aKTeyZXiKQ+j/7nYZ98k33h83Mxd20gi0RrQLvpHS/dh4QW2rMqLOE0CTsqYP9BOaPXZ6sPZ3xAZNXwd8/uhGqXYnDFmZ7StRaKqzNZqalyMWVA1/D9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eNN7qaz5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWNpUOpl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eNN7qaz5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lWNpUOpl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8971722C75;
	Mon, 29 Apr 2024 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714382198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRurLGkkVdZyuJUDoC2YMI/uos6X723oAWOeFZjxMLM=;
	b=eNN7qaz58QxU+1KUwxhCGJquTxElKBAEHAxGOdOYWdONEb1vekmRZHyLNRTj2Ae5IBcTn2
	7Y29lzpGnrwbAJRfWQMWk2NKCcm8h7RnbTFOqS3i4hSlBvvaueJ6Q4Ir5/7+yHEYO5CvNw
	FTP496WNTj1ZlSMjHhXiGGmEldrbh+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714382198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRurLGkkVdZyuJUDoC2YMI/uos6X723oAWOeFZjxMLM=;
	b=lWNpUOplmVgD3+GpT1hppaQ+MRiDgenwNZQmGyJta3fCRT1J79WaFCBhv9rU96OF6MmH9y
	9732RfYrpYni2BBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eNN7qaz5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lWNpUOpl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714382198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRurLGkkVdZyuJUDoC2YMI/uos6X723oAWOeFZjxMLM=;
	b=eNN7qaz58QxU+1KUwxhCGJquTxElKBAEHAxGOdOYWdONEb1vekmRZHyLNRTj2Ae5IBcTn2
	7Y29lzpGnrwbAJRfWQMWk2NKCcm8h7RnbTFOqS3i4hSlBvvaueJ6Q4Ir5/7+yHEYO5CvNw
	FTP496WNTj1ZlSMjHhXiGGmEldrbh+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714382198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRurLGkkVdZyuJUDoC2YMI/uos6X723oAWOeFZjxMLM=;
	b=lWNpUOplmVgD3+GpT1hppaQ+MRiDgenwNZQmGyJta3fCRT1J79WaFCBhv9rU96OF6MmH9y
	9732RfYrpYni2BBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C934138A7;
	Mon, 29 Apr 2024 09:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YdkiHnZlL2YAHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 09:16:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19675A082F; Mon, 29 Apr 2024 11:16:38 +0200 (CEST)
Date: Mon, 29 Apr 2024 11:16:38 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 5/9] ext4: make ext4_es_insert_delayed_block() insert
 multi-blocks
Message-ID: <20240429091638.bghtdkbufbmhlw3r@quack3>
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
	NEURAL_HAM_SHORT(-0.20)[-0.984];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: 4.39
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: 8971722C75
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Wed 10-04-24 11:41:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Rename ext4_es_insert_delayed_block() to ext4_es_insert_delayed_extent()
> and pass length parameter to make it insert multi delalloc blocks once a
> time. For the case of bigalloc, expand the allocated parameter to
> lclu_allocated and end_allocated. lclu_allocated indicates the allocate
> state of the cluster which containing the lblk, end_allocated represents
> the end, and the middle clusters must be unallocated.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks mostly good, just one comment below:

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
						        ^^^^ "start / end
block" to make it clearer...

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

So there's one unclear thing here: What if 'lblk' and 'end' are in the same
cluster? We don't want two pending reservation structures for the cluster.
__insert_pending() already handles this gracefully but perhaps we don't
need to allocate 'pr2' in that case and call __insert_pending() at all? I
think it could be easily handled by something like:

	if (EXT4_B2C(lblk) == EXT4_B2C(end))
		end_allocated = false;

at appropriate place in ext4_es_insert_delayed_extent().

Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

