Return-Path: <linux-fsdevel+bounces-50743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92415ACF17E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A971893C02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179B2749DB;
	Thu,  5 Jun 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aF8i/twk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvfzTuvH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aF8i/twk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SvfzTuvH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537461DB34B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132276; cv=none; b=QHofkUajJPlVPPO304+hMpNk0e8ATZhqzYGdKSFS1bIT+bvmZz1N2t19Jf4a/1OaBg/qeDtshTqSEi85t2riMGPX/ljK4EMaE5R8upXo2nkttWZP3oJ04iGO2hErIgBzaXcvZyoeQZyRp+sOoFubhlMi6eF0BVDSejJQVanbuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132276; c=relaxed/simple;
	bh=Ai9SbHa2YTe/Z1rVm8kKoYZgbjtCpF/V8a2at75CfI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVKnGMzSyxyBV5dIVoT3bXF7zCHm6Yua0cGI6jv29/cUZsxGTGk3jG86CA/d9Bh0gsaMVFEXtpBQyT+OJUlD2pOp6f23S7oeqxYyjA0r16ZSp94idNmjJcPpadRhlhX4+0DGx4D8ZNCB+E1hNtmgpRh4IU6NXYDHisHUiDxgr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aF8i/twk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvfzTuvH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aF8i/twk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SvfzTuvH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62E041F78F;
	Thu,  5 Jun 2025 14:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749132271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyFX+LIyHfbRGP5nue2JWW0bqHTgKw29r7vdBC1picM=;
	b=aF8i/twk8gQ/6c7RhDW2B+Mugdrjrdc8F96nSO99pPCleDZKZVk6OHgOeq4llqKJVYs5c6
	KI5SjThUBJJgZBAtedNvy2DNCZggMeAgmwgZCPcKxDX8WTJGKJJn+ycaRzFXSUEZJ1ZWq1
	OpaY66ZFxA3Xt4cBlP89f7e3bZI0Jn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749132271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyFX+LIyHfbRGP5nue2JWW0bqHTgKw29r7vdBC1picM=;
	b=SvfzTuvH/RpYBONB3MT9a4x4iHq+f5aVqCAI7YY8AF8knvIHQZquPy3gLHDNsT7rEjtdp/
	+cMsNXXvGr0QT7Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="aF8i/twk";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SvfzTuvH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749132271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyFX+LIyHfbRGP5nue2JWW0bqHTgKw29r7vdBC1picM=;
	b=aF8i/twk8gQ/6c7RhDW2B+Mugdrjrdc8F96nSO99pPCleDZKZVk6OHgOeq4llqKJVYs5c6
	KI5SjThUBJJgZBAtedNvy2DNCZggMeAgmwgZCPcKxDX8WTJGKJJn+ycaRzFXSUEZJ1ZWq1
	OpaY66ZFxA3Xt4cBlP89f7e3bZI0Jn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749132271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyFX+LIyHfbRGP5nue2JWW0bqHTgKw29r7vdBC1picM=;
	b=SvfzTuvH/RpYBONB3MT9a4x4iHq+f5aVqCAI7YY8AF8knvIHQZquPy3gLHDNsT7rEjtdp/
	+cMsNXXvGr0QT7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 477991373E;
	Thu,  5 Jun 2025 14:04:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a3ZvEe+jQWgyPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Jun 2025 14:04:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DFFE5A0951; Thu,  5 Jun 2025 16:04:30 +0200 (CEST)
Date: Thu, 5 Jun 2025 16:04:30 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 1/5] ext4: restart handle if credits are insufficient
 during writepages
Message-ID: <byiax3ykefdvmu47xrgrndguxabwvakescnkanbhwwqoec7yky@dvzzkic5uzf3>
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
 <20250530062858.458039-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530062858.458039-2-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email,huawei.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 62E041F78F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Fri 30-05-25 14:28:54, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> After large folios are supported on ext4, writing back a sufficiently
> large and discontinuous folio may consume a significant number of
> journal credits, placing considerable strain on the journal. For
> example, in a 20GB filesystem with 1K block size and 1MB journal size,
> writing back a 2MB folio could require thousands of credits in the
> worst-case scenario (when each block is discontinuous and distributed
> across different block groups), potentially exceeding the journal size.
> 
> Fix this by making the write-back process first reserves credits for one
> page and attempts to extend the transaction if the credits are
> insufficient. In particular, if the credits for a transaction reach
> their upper limit, stop the handle and initiate a new transaction.
> 
> Note that since we do not support partial folio writeouts, some blocks
> within this folio may have been allocated. These allocated extents are
> submitted through the current transaction, but the folio itself is not
> submitted. To prevent stale data and potential deadlocks in ordered
> mode, only the dioread_nolock mode supports this solution, as it always
> allocate unwritten extents.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Couple of simplification suggestions below and one bigger issue we need to
deal with.

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index be9a4cba35fd..5ef34c0c5633 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1680,6 +1680,7 @@ struct mpage_da_data {
>  	unsigned int do_map:1;
>  	unsigned int scanned_until_end:1;
>  	unsigned int journalled_more_data:1;
> +	unsigned int continue_map:1;
>  };
>  
>  static void mpage_release_unused_pages(struct mpage_da_data *mpd,
> @@ -2367,6 +2368,8 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>   *
>   * @handle - handle for journal operations
>   * @mpd - extent to map
> + * @needed_blocks - journal credits needed for one writepages iteration
> + * @check_blocks - journal credits needed for map one extent
>   * @give_up_on_write - we set this to true iff there is a fatal error and there
>   *                     is no hope of writing the data. The caller should discard
>   *                     dirty pages to avoid infinite loops.
> @@ -2383,6 +2386,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>   */
>  static int mpage_map_and_submit_extent(handle_t *handle,
>  				       struct mpage_da_data *mpd,
> +				       int needed_blocks, int check_blocks,
>  				       bool *give_up_on_write)
>  {
>  	struct inode *inode = mpd->inode;
> @@ -2393,6 +2397,8 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  	ext4_io_end_t *io_end = mpd->io_submit.io_end;
>  	struct ext4_io_end_vec *io_end_vec;
>  
> +	mpd->continue_map = 0;
> +
>  	io_end_vec = ext4_alloc_io_end_vec(io_end);
>  	if (IS_ERR(io_end_vec))
>  		return PTR_ERR(io_end_vec);
> @@ -2439,6 +2445,34 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  		err = mpage_map_and_submit_buffers(mpd);
>  		if (err < 0)
>  			goto update_disksize;
> +		if (!map->m_len)
> +			goto update_disksize;
> +
> +		/*
> +		 * For mapping a folio that is sufficiently large and
> +		 * discontinuous, the current handle credits may be
> +		 * insufficient, try to extend the handle.
> +		 */
> +		err = __ext4_journal_ensure_credits(handle, check_blocks,
> +				needed_blocks, 0);
> +		if (err < 0)
> +			goto update_disksize;

IMO it would be more logical to have __ext4_journal_ensure_credits() in
mpage_map_one_extent() where the handle is actually used. Also there it
would be pretty logical to do:

		/* Make sure transaction has enough credits for this extent */
		needed_credits = ext4_chunk_trans_blocks(inode, 1);
		err = ext4_journal_ensure_credits(handle, needed_credits, 0);

No need to extend the transaction by more than we need for this current
extent and also no need to propagate needed credits here.

If __ext4_journal_ensure_credits() cannot extend the transaction, we can
just return -EAGAIN (or something like that) and make sure the retry logic
on ENOSPC or similar transient errors in mpage_map_and_submit_extent()
applies properly.

> +		/*
> +		 * The credits for the current handle and transaction have
> +		 * reached their upper limit, stop the handle and initiate a
> +		 * new transaction. Note that some blocks in this folio may
> +		 * have been allocated, and these allocated extents are
> +		 * submitted through the current transaction, but the folio
> +		 * itself is not submitted. To prevent stale data and
> +		 * potential deadlock in ordered mode, only the
> +		 * dioread_nolock mode supports this.
> +		 */
> +		if (err > 0) {
> +			WARN_ON_ONCE(!ext4_should_dioread_nolock(inode));
> +			mpd->continue_map = 1;
> +			err = 0;
> +			goto update_disksize;
> +		}
>  	} while (map->m_len);
>  
>  update_disksize:
> @@ -2467,6 +2501,9 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  		if (!err)
>  			err = err2;
>  	}
> +	if (!err && mpd->continue_map)
> +		ext4_get_io_end(io_end);
> +

IMHO it would be more logical to not call ext4_put_io_end[_deferred]() in
ext4_do_writepages() if we see we need to continue doing mapping for the
current io_end.

That way it would be also more obvious that you've just reintroduced
deadlock fixed by 646caa9c8e196 ("ext4: fix deadlock during page
writeback"). This is actually a fundamental thing because for
ext4_journal_stop() to complete, we may need IO on the folio to finish
which means we need io_end to be processed. Even if we avoided the awkward
case with sync handle described in 646caa9c8e196, to be able to start a new
handle we may need to complete a previous transaction commit to be able to
make space in the journal.

Thinking some more about this holding ioend for a folio with partially
submitted IO is also deadlock prone because mpage_prepare_extent_to_map()
can call folio_wait_writeback() which will effectively wait for the last
reference to ioend to be dropped so that underlying extents can be
converted and folio_writeback bit cleared.

So what I think we need to do is that if we submit part of the folio and
cannot submit it all, we just redirty the folio and bail out of the mapping
loop (similarly as in ENOSPC case). Then once IO completes
mpage_prepare_extent_to_map() is able to start working on the folio again.
Since we cleared dirty bits in the buffers we should not be repeating the
work we already did...

								Honza

>  	return err;
>  }
>  
> @@ -2703,7 +2740,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  	handle_t *handle = NULL;
>  	struct inode *inode = mpd->inode;
>  	struct address_space *mapping = inode->i_mapping;
> -	int needed_blocks, rsv_blocks = 0, ret = 0;
> +	int needed_blocks, check_blocks, rsv_blocks = 0, ret = 0;
>  	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
>  	struct blk_plug plug;
>  	bool give_up_on_write = false;
> @@ -2825,10 +2862,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  
>  	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
>  		/* For each extent of pages we use new io_end */
> -		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
>  		if (!mpd->io_submit.io_end) {
> -			ret = -ENOMEM;
> -			break;
> +			mpd->io_submit.io_end =
> +					ext4_init_io_end(inode, GFP_KERNEL);
> +			if (!mpd->io_submit.io_end) {
> +				ret = -ENOMEM;
> +				break;
> +			}
>  		}
>  
>  		WARN_ON_ONCE(!mpd->can_map);
> @@ -2841,10 +2881,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		 */
>  		BUG_ON(ext4_should_journal_data(inode));
>  		needed_blocks = ext4_da_writepages_trans_blocks(inode);
> +		check_blocks = ext4_chunk_trans_blocks(inode,
> +				MAX_WRITEPAGES_EXTENT_LEN);
>  
>  		/* start a new transaction */
>  		handle = ext4_journal_start_with_reserve(inode,
> -				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
> +				EXT4_HT_WRITE_PAGE, needed_blocks,
> +				mpd->continue_map ? 0 : rsv_blocks);
>  		if (IS_ERR(handle)) {
>  			ret = PTR_ERR(handle);
>  			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
> @@ -2861,6 +2904,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  		ret = mpage_prepare_extent_to_map(mpd);
>  		if (!ret && mpd->map.m_len)
>  			ret = mpage_map_and_submit_extent(handle, mpd,
> +					needed_blocks, check_blocks,
>  					&give_up_on_write);
>  		/*
>  		 * Caution: If the handle is synchronous,
> @@ -2894,7 +2938,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>  			ext4_journal_stop(handle);
>  		} else
>  			ext4_put_io_end(mpd->io_submit.io_end);
> -		mpd->io_submit.io_end = NULL;
> +		if (ret || !mpd->continue_map)
> +			mpd->io_submit.io_end = NULL;
>  
>  		if (ret == -ENOSPC && sbi->s_journal) {
>  			/*
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

