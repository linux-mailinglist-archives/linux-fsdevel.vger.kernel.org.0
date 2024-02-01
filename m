Return-Path: <linux-fsdevel+bounces-9847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F9845517
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033ED1C22795
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAB215B11F;
	Thu,  1 Feb 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2gMCmtSQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="//+vnuMf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2gMCmtSQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="//+vnuMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144974D9F9;
	Thu,  1 Feb 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782800; cv=none; b=KeUmCogOuR1so/5OzZD0aLFHNppfLjbr72vFF0ZjGFqDDP7E+k3C+qZq7fLOcjvEnjw9y1MXZRFu7udZ77peB8C/mTxwqf+91Mahu/ZhlKspb+JnDKpV20y9g9SCoGibj4B2OuEyR4BZzKvcWP9YJVSpRqTxuhXhnJY7MuBluH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782800; c=relaxed/simple;
	bh=wCyiYel65TZe+x7pHCkABtCbifUIvfPnWid1DOSmhsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7AYA8RQ82D1TmD5HfCJBSXpdCGOoLZ5SIH6eQWfPyHrD6GWeueIFW3+L/BvQ3i7QockGRDXK2TjbIn+3uP08ONe50bPgP8uIqPFE+sW9IspO1axCpgS7rWvsLjGPTXcr4AN5WlzZKoFS5xsZhu8xdsM9Nx0QNLeXCYeWhMyEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2gMCmtSQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=//+vnuMf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2gMCmtSQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=//+vnuMf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 329A421DD7;
	Thu,  1 Feb 2024 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wL4wVLPoPID+Gdvnna9scF5q0dAZR+dsbZ/IV3xwl4k=;
	b=2gMCmtSQPVpTMNGqLNjy7AoZXxJ7JJF5ug+e7pQowZkiR+0NXqtpb2IqbW3gMFDAsCe/ps
	2RnO3vvCjd666VIilG5ePB0xWzvkcgULMaQFr1iv2vnMckrzuT9+nOsdqgX4hPNL44rZuy
	PiCxQdDQZvly0hQFHbt9nV1IAeg/EvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wL4wVLPoPID+Gdvnna9scF5q0dAZR+dsbZ/IV3xwl4k=;
	b=//+vnuMfsI+ZD9ryao2djPrtmc18g4gjoY4No1VpyUM8vTWqTGQsfg91RFeeiwMxh05GQq
	16dwQBFtP6N1oJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wL4wVLPoPID+Gdvnna9scF5q0dAZR+dsbZ/IV3xwl4k=;
	b=2gMCmtSQPVpTMNGqLNjy7AoZXxJ7JJF5ug+e7pQowZkiR+0NXqtpb2IqbW3gMFDAsCe/ps
	2RnO3vvCjd666VIilG5ePB0xWzvkcgULMaQFr1iv2vnMckrzuT9+nOsdqgX4hPNL44rZuy
	PiCxQdDQZvly0hQFHbt9nV1IAeg/EvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wL4wVLPoPID+Gdvnna9scF5q0dAZR+dsbZ/IV3xwl4k=;
	b=//+vnuMfsI+ZD9ryao2djPrtmc18g4gjoY4No1VpyUM8vTWqTGQsfg91RFeeiwMxh05GQq
	16dwQBFtP6N1oJCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 276E31329F;
	Thu,  1 Feb 2024 10:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PjKdCU1wu2WgXgAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:19:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E61FDA0809; Thu,  1 Feb 2024 11:19:56 +0100 (CET)
Date: Thu, 1 Feb 2024 11:19:56 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 23/34] jfs: port block device access to file
Message-ID: <20240201101956.arwor6tcdrooypxc@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-23-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-23-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2gMCmtSQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="//+vnuMf"
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 329A421DD7
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:40, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jfs/jfs_logmgr.c | 26 +++++++++++++-------------
>  fs/jfs/jfs_logmgr.h |  2 +-
>  fs/jfs/jfs_mount.c  |  2 +-
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 8691463956d1..73389c68e251 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -1058,7 +1058,7 @@ void jfs_syncpt(struct jfs_log *log, int hard_sync)
>  int lmLogOpen(struct super_block *sb)
>  {
>  	int rc;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct jfs_log *log;
>  	struct jfs_sb_info *sbi = JFS_SBI(sb);
>  
> @@ -1070,7 +1070,7 @@ int lmLogOpen(struct super_block *sb)
>  
>  	mutex_lock(&jfs_log_mutex);
>  	list_for_each_entry(log, &jfs_external_logs, journal_list) {
> -		if (log->bdev_handle->bdev->bd_dev == sbi->logdev) {
> +		if (file_bdev(log->bdev_file)->bd_dev == sbi->logdev) {
>  			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
>  				jfs_warn("wrong uuid on JFS journal");
>  				mutex_unlock(&jfs_log_mutex);
> @@ -1100,14 +1100,14 @@ int lmLogOpen(struct super_block *sb)
>  	 * file systems to log may have n-to-1 relationship;
>  	 */
>  
> -	bdev_handle = bdev_open_by_dev(sbi->logdev,
> +	bdev_file = bdev_file_open_by_dev(sbi->logdev,
>  			BLK_OPEN_READ | BLK_OPEN_WRITE, log, NULL);
> -	if (IS_ERR(bdev_handle)) {
> -		rc = PTR_ERR(bdev_handle);
> +	if (IS_ERR(bdev_file)) {
> +		rc = PTR_ERR(bdev_file);
>  		goto free;
>  	}
>  
> -	log->bdev_handle = bdev_handle;
> +	log->bdev_file = bdev_file;
>  	uuid_copy(&log->uuid, &sbi->loguuid);
>  
>  	/*
> @@ -1141,7 +1141,7 @@ int lmLogOpen(struct super_block *sb)
>  	lbmLogShutdown(log);
>  
>        close:		/* close external log device */
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  
>        free:		/* free log descriptor */
>  	mutex_unlock(&jfs_log_mutex);
> @@ -1162,7 +1162,7 @@ static int open_inline_log(struct super_block *sb)
>  	init_waitqueue_head(&log->syncwait);
>  
>  	set_bit(log_INLINELOG, &log->flag);
> -	log->bdev_handle = sb_bdev_handle(sb);
> +	log->bdev_file = sb->s_bdev_file;
>  	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
>  	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>
>  	    (L2LOGPSIZE - sb->s_blocksize_bits);
> @@ -1436,7 +1436,7 @@ int lmLogClose(struct super_block *sb)
>  {
>  	struct jfs_sb_info *sbi = JFS_SBI(sb);
>  	struct jfs_log *log = sbi->log;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	int rc = 0;
>  
>  	jfs_info("lmLogClose: log:0x%p", log);
> @@ -1482,10 +1482,10 @@ int lmLogClose(struct super_block *sb)
>  	 *	external log as separate logical volume
>  	 */
>  	list_del(&log->journal_list);
> -	bdev_handle = log->bdev_handle;
> +	bdev_file = log->bdev_file;
>  	rc = lmLogShutdown(log);
>  
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  
>  	kfree(log);
>  
> @@ -1972,7 +1972,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
>  
>  	bp->l_flag |= lbmREAD;
>  
> -	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_READ, GFP_NOFS);
> +	bio = bio_alloc(file_bdev(log->bdev_file), 1, REQ_OP_READ, GFP_NOFS);
>  	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
>  	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
>  	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
> @@ -2115,7 +2115,7 @@ static void lbmStartIO(struct lbuf * bp)
>  	jfs_info("lbmStartIO");
>  
>  	if (!log->no_integrity)
> -		bdev = log->bdev_handle->bdev;
> +		bdev = file_bdev(log->bdev_file);
>  
>  	bio = bio_alloc(bdev, 1, REQ_OP_WRITE | REQ_SYNC,
>  			GFP_NOFS);
> diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
> index 84aa2d253907..8b8994e48cd0 100644
> --- a/fs/jfs/jfs_logmgr.h
> +++ b/fs/jfs/jfs_logmgr.h
> @@ -356,7 +356,7 @@ struct jfs_log {
>  				 *    before writing syncpt.
>  				 */
>  	struct list_head journal_list; /* Global list */
> -	struct bdev_handle *bdev_handle; /* 4: log lv pointer */
> +	struct file *bdev_file;	/* 4: log lv pointer */
>  	int serial;		/* 4: log mount serial number */
>  
>  	s64 base;		/* @8: log extent address (inline log ) */
> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> index 9b5c6a20b30c..98f9a432c336 100644
> --- a/fs/jfs/jfs_mount.c
> +++ b/fs/jfs/jfs_mount.c
> @@ -431,7 +431,7 @@ int updateSuper(struct super_block *sb, uint state)
>  	if (state == FM_MOUNT) {
>  		/* record log's dev_t and mount serial number */
>  		j_sb->s_logdev = cpu_to_le32(
> -			new_encode_dev(sbi->log->bdev_handle->bdev->bd_dev));
> +			new_encode_dev(file_bdev(sbi->log->bdev_file)->bd_dev));
>  		j_sb->s_logserial = cpu_to_le32(sbi->log->serial);
>  	} else if (state == FM_CLEAN) {
>  		/*
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

