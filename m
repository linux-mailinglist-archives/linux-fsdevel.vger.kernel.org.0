Return-Path: <linux-fsdevel+bounces-9864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8215845601
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 12:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086171C23850
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD015CD40;
	Thu,  1 Feb 2024 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRVJcxGx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VugIF0EN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJU9U5mR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuH6emO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03763A1C3;
	Thu,  1 Feb 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785746; cv=none; b=egMECN9BgrYfr+JjvG+ny1Qyo+gOpdvYGNIMrhwfw7FJcANWyhKU02NgeLcLk50aCJ37pETgaUpElRAJN/mkS9QS5lwmPNWkYEQvCtgJj5DsoO0oNKRVys81zw+iMTJNZ5YuCJhRd72ns8LhjPRmJdAgo4h7OlDHi32WkNoJk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785746; c=relaxed/simple;
	bh=KBigWgjLMljZmzNMzOUIOrEGNm/ohDHY7qmTf8EWgKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2H42wZXoICgexA3cFP60t1+1PBRMwSRvgDNMAN9syEtAv78LfgGCAcdwq8sWhwUIwzbvavcLam1l/vj5qr7FrN1khdZQq6vxcKo+VSEVpr8dpKoIacvrCeiM+Db1OWc1P0oSzYkWeE3fd65/Z9cKudIMPqp0Kf02tvNUfFqSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRVJcxGx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VugIF0EN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJU9U5mR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuH6emO8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8D461FBB5;
	Thu,  1 Feb 2024 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706785743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62ZeoTI0aCGxBj3ztecxkcJjdtrdtHwvv4ehy7eGs5Y=;
	b=NRVJcxGxl8+OmOy0lSKW8kiqx3/6VXWza3CO95HGsocSZiaNWftIngyiR2fSxGb+yJruqY
	sE7PKHTgvVi4WQFR70+fqMhZzL3LPlxTaNInQ/daL1DYo/YFJ2pR6KcTiaYPjz6Z76i6oA
	ClX73qn2HjwKhklskXdsZOF06JDHclc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706785743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62ZeoTI0aCGxBj3ztecxkcJjdtrdtHwvv4ehy7eGs5Y=;
	b=VugIF0ENoy+8Sr+KjG1n5sgbnhfJ3ST/eD2seEVdOtfsZhPAPvU4gPt2GCfjwrNApPjshV
	dHJkxPVjeezsy3CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706785742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62ZeoTI0aCGxBj3ztecxkcJjdtrdtHwvv4ehy7eGs5Y=;
	b=tJU9U5mR3txnXbEo1/qc9n5TovmscsLGakp7a7PxB+5PPeIrHZ+RczOscTuV6pFw/HBwee
	DKYHtfrf3fTSMZ6P1E+WeAO20Ykfv1m01O9GRdmgMgaJPgfFtLEIBLPeugJAgSdT+8phr5
	gUc/Se5KVorAuUhp4TllQ5eEZnqraZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706785742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62ZeoTI0aCGxBj3ztecxkcJjdtrdtHwvv4ehy7eGs5Y=;
	b=WuH6emO8oumA4YAA0Xr3lj5b9rcQ4syJ/P6vvjgAknJlItsuLLrVp5GYzJsLF7OgsIS9zS
	FJXfBm4FoGTQAsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF53139B1;
	Thu,  1 Feb 2024 11:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CsZbLs57u2WLFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 11:09:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54C40A0809; Thu,  1 Feb 2024 12:08:58 +0100 (CET)
Date: Thu, 1 Feb 2024 12:08:58 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240201110858.on47ef4cmp23jhcv@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tJU9U5mR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WuH6emO8
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C8D461FBB5
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:48, Christian Brauner wrote:
> Make it possible to detected a block device that was opened with
> restricted write access solely based on its file operations that it was
> opened with. This avoids wasting an FMODE_* flag.
> 
> def_blk_fops isn't needed to check whether something is a block device
> checking the inode type is enough for that. And def_blk_fops_restricted
> can be kept private to the block layer.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I don't think we need def_blk_fops_restricted. If we have BLK_OPEN_WRITE
file against a bdev with bdev_writes_blocked() == true, we are sure this is
the handle blocking other writes so we can unblock them in
bdev_yield_write_access()...

								Honza

> ---
>  block/bdev.c | 16 ++++++++++++----
>  block/blk.h  |  2 ++
>  block/fops.c |  3 +++
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 71eaa1b5b7eb..9d96a43f198d 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -799,13 +799,16 @@ static void bdev_claim_write_access(struct block_device *bdev, blk_mode_t mode)
>  		bdev->bd_writers++;
>  }
>  
> -static void bdev_yield_write_access(struct block_device *bdev, blk_mode_t mode)
> +static void bdev_yield_write_access(struct file *bdev_file, blk_mode_t mode)
>  {
> +	struct block_device *bdev;
> +
>  	if (bdev_allow_write_mounted)
>  		return;
>  
> +	bdev = file_bdev(bdev_file);
>  	/* Yield exclusive or shared write access. */
> -	if (mode & BLK_OPEN_RESTRICT_WRITES)
> +	if (bdev_file->f_op == &def_blk_fops_restricted)
>  		bdev_unblock_writes(bdev);
>  	else if (mode & BLK_OPEN_WRITE)
>  		bdev->bd_writers--;
> @@ -959,6 +962,7 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  				   const struct blk_holder_ops *hops)
>  {
>  	struct file *bdev_file;
> +	const struct file_operations *blk_fops;
>  	struct block_device *bdev;
>  	unsigned int flags;
>  	int ret;
> @@ -972,8 +976,12 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		return ERR_PTR(-ENXIO);
>  
>  	flags = blk_to_file_flags(mode);
> +	if (mode & BLK_OPEN_RESTRICT_WRITES)
> +		blk_fops = &def_blk_fops_restricted;
> +	else
> +		blk_fops = &def_blk_fops;
>  	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
> -			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
> +			blockdev_mnt, "", flags | O_LARGEFILE, blk_fops);
>  	if (IS_ERR(bdev_file)) {
>  		blkdev_put_no_open(bdev);
>  		return bdev_file;
> @@ -1033,7 +1041,7 @@ void bdev_release(struct file *bdev_file)
>  		sync_blockdev(bdev);
>  
>  	mutex_lock(&disk->open_mutex);
> -	bdev_yield_write_access(bdev, handle->mode);
> +	bdev_yield_write_access(bdev_file, handle->mode);
>  
>  	if (handle->holder)
>  		bd_end_claim(bdev, handle->holder);
> diff --git a/block/blk.h b/block/blk.h
> index 7ca24814f3a0..dfa958909c54 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -9,6 +9,8 @@
>  
>  struct elevator_type;
>  
> +extern const struct file_operations def_blk_fops_restricted;
> +
>  /* Max future timer expiry for timeouts */
>  #define BLK_MAX_TIMEOUT		(5 * HZ)
>  
> diff --git a/block/fops.c b/block/fops.c
> index 5589bf9c3822..f56bdfe459de 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -862,6 +862,9 @@ const struct file_operations def_blk_fops = {
>  	.fallocate	= blkdev_fallocate,
>  };
>  
> +/* Indicator that this block device is opened with restricted write access. */
> +const struct file_operations def_blk_fops_restricted = def_blk_fops;
> +
>  static __init int blkdev_init(void)
>  {
>  	return bioset_init(&blkdev_dio_pool, 4,
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

