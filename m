Return-Path: <linux-fsdevel+bounces-9840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F88A8454F0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA81C28B603
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3115B97F;
	Thu,  1 Feb 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfGrGkJK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zukp3r0e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1F2vwTPB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KbVoGEfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70B4DA1D;
	Thu,  1 Feb 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782356; cv=none; b=J3zNcVr+MNQDc9Y+kMOUsLZXfxXcO35ovbCZq+syHodyYi5i9Ss95V/O5Il7crU1KYgLhYUwxZYe61+ULjWZ+My676W+LzH30+q9GMnSOumfHiPQYDYEu81SwhAujxiKydvEsMmHQfxqVsyWgZsMgKKintCFjCEM2v1ehlkS0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782356; c=relaxed/simple;
	bh=glqnaOrw99WbsqaODgoP8uBbBO8xHAlSTS2Y5GZhGjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4oYO9957/m0Z2eaFt6hGy67zL8TbYAy+t8dZaeDNNTlhRH0uctepCsjvlL+kK/9pEL/qiO4bEACw1DW9COHSbkz9Wbdcd8zB6bdXriPB60SasYKeWf3s2UNEfnXrqcftxqmjfRIsczvXPoMW69a0eStMUdjxguMz0+vglSQGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfGrGkJK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zukp3r0e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1F2vwTPB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KbVoGEfq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 127B421D7C;
	Thu,  1 Feb 2024 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5xZyX41Y+lbArgsfZb+5EzGix8I4WbaQTYL4qZ6HQ8=;
	b=BfGrGkJKfn/7BRldSVrAIBMlFnPjPzK5sK3lAmyJJTV0nu5aOh3gaTk9HCGlCu5q4nLwtg
	Pk6ZHEoLRhB1qX7vxjYLgwMnW+4fwW6M1jJiBtHfwsrGbxUk5oz4M1bwFx+ZaTS80lCdZ6
	dZee75Dd7xmt3jeHlTKThW3BjvIqv6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5xZyX41Y+lbArgsfZb+5EzGix8I4WbaQTYL4qZ6HQ8=;
	b=Zukp3r0eBSQD8fk9wro6EmJ00uLqW9MSsXB2yywV+rEz5JEeK98XaETcBP8jE7B9uraZlq
	UsvSa+BXPNu115Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5xZyX41Y+lbArgsfZb+5EzGix8I4WbaQTYL4qZ6HQ8=;
	b=1F2vwTPBjb7WseZmOuK/qul3IIcVOLYDOESWgdeNsx+cuy4Izxp9sFfrLZoYfepth/5GLX
	s5WXM8jPiG1pVLw9kVEUt/aHVUXuXPBtPHUbN2u4KaE5iqBUIMm/uE2TvKZh5e0SJwdQl5
	rzG4Y1EWPKGk0Xp21brNyKbyx0s3cJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5xZyX41Y+lbArgsfZb+5EzGix8I4WbaQTYL4qZ6HQ8=;
	b=KbVoGEfqIBqC4u7OEDS0gU6HcUD3ZE5bkYZEoeozx3ze/q4LUIdDTa04aCG8SbPANftJQ2
	y8sU4qVTIFG+PkCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 053581329F;
	Thu,  1 Feb 2024 10:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id y/E/AZBuu2X4XAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:12:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AAED7A0809; Thu,  1 Feb 2024 11:12:31 +0100 (CET)
Date: Thu, 1 Feb 2024 11:12:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 17/34] target: port block device access to file
Message-ID: <20240201101231.5qefy6zj7arpz2pc@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-17-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-17-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1F2vwTPB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KbVoGEfq
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 127B421D7C
X-Spam-Flag: NO

On Tue 23-01-24 14:26:34, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/target/target_core_iblock.c | 18 +++++++++---------
>  drivers/target/target_core_iblock.h |  2 +-
>  drivers/target/target_core_pscsi.c  | 22 +++++++++++-----------
>  drivers/target/target_core_pscsi.h  |  2 +-
>  4 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
> index 8eb9eb7ce5df..7f6ca8177845 100644
> --- a/drivers/target/target_core_iblock.c
> +++ b/drivers/target/target_core_iblock.c
> @@ -91,7 +91,7 @@ static int iblock_configure_device(struct se_device *dev)
>  {
>  	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
>  	struct request_queue *q;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct block_device *bd;
>  	struct blk_integrity *bi;
>  	blk_mode_t mode = BLK_OPEN_READ;
> @@ -117,14 +117,14 @@ static int iblock_configure_device(struct se_device *dev)
>  	else
>  		dev->dev_flags |= DF_READ_ONLY;
>  
> -	bdev_handle = bdev_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
> +	bdev_file = bdev_file_open_by_path(ib_dev->ibd_udev_path, mode, ib_dev,
>  					NULL);
> -	if (IS_ERR(bdev_handle)) {
> -		ret = PTR_ERR(bdev_handle);
> +	if (IS_ERR(bdev_file)) {
> +		ret = PTR_ERR(bdev_file);
>  		goto out_free_bioset;
>  	}
> -	ib_dev->ibd_bdev_handle = bdev_handle;
> -	ib_dev->ibd_bd = bd = bdev_handle->bdev;
> +	ib_dev->ibd_bdev_file = bdev_file;
> +	ib_dev->ibd_bd = bd = file_bdev(bdev_file);
>  
>  	q = bdev_get_queue(bd);
>  
> @@ -180,7 +180,7 @@ static int iblock_configure_device(struct se_device *dev)
>  	return 0;
>  
>  out_blkdev_put:
> -	bdev_release(ib_dev->ibd_bdev_handle);
> +	fput(ib_dev->ibd_bdev_file);
>  out_free_bioset:
>  	bioset_exit(&ib_dev->ibd_bio_set);
>  out:
> @@ -205,8 +205,8 @@ static void iblock_destroy_device(struct se_device *dev)
>  {
>  	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
>  
> -	if (ib_dev->ibd_bdev_handle)
> -		bdev_release(ib_dev->ibd_bdev_handle);
> +	if (ib_dev->ibd_bdev_file)
> +		fput(ib_dev->ibd_bdev_file);
>  	bioset_exit(&ib_dev->ibd_bio_set);
>  }
>  
> diff --git a/drivers/target/target_core_iblock.h b/drivers/target/target_core_iblock.h
> index 683f9a55945b..91f6f4280666 100644
> --- a/drivers/target/target_core_iblock.h
> +++ b/drivers/target/target_core_iblock.h
> @@ -32,7 +32,7 @@ struct iblock_dev {
>  	u32	ibd_flags;
>  	struct bio_set	ibd_bio_set;
>  	struct block_device *ibd_bd;
> -	struct bdev_handle *ibd_bdev_handle;
> +	struct file *ibd_bdev_file;
>  	bool ibd_readonly;
>  	struct iblock_dev_plug *ibd_plug;
>  } ____cacheline_aligned;
> diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
> index 41b7489d37ce..9aedd682d10c 100644
> --- a/drivers/target/target_core_pscsi.c
> +++ b/drivers/target/target_core_pscsi.c
> @@ -352,7 +352,7 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
>  	struct pscsi_hba_virt *phv = dev->se_hba->hba_ptr;
>  	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
>  	struct Scsi_Host *sh = sd->host;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	int ret;
>  
>  	if (scsi_device_get(sd)) {
> @@ -366,18 +366,18 @@ static int pscsi_create_type_disk(struct se_device *dev, struct scsi_device *sd)
>  	 * Claim exclusive struct block_device access to struct scsi_device
>  	 * for TYPE_DISK and TYPE_ZBC using supplied udev_path
>  	 */
> -	bdev_handle = bdev_open_by_path(dev->udev_path,
> +	bdev_file = bdev_file_open_by_path(dev->udev_path,
>  				BLK_OPEN_WRITE | BLK_OPEN_READ, pdv, NULL);
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		pr_err("pSCSI: bdev_open_by_path() failed\n");
>  		scsi_device_put(sd);
> -		return PTR_ERR(bdev_handle);
> +		return PTR_ERR(bdev_file);
>  	}
> -	pdv->pdv_bdev_handle = bdev_handle;
> +	pdv->pdv_bdev_file = bdev_file;
>  
>  	ret = pscsi_add_device_to_list(dev, sd);
>  	if (ret) {
> -		bdev_release(bdev_handle);
> +		fput(bdev_file);
>  		scsi_device_put(sd);
>  		return ret;
>  	}
> @@ -564,9 +564,9 @@ static void pscsi_destroy_device(struct se_device *dev)
>  		 * from pscsi_create_type_disk()
>  		 */
>  		if ((sd->type == TYPE_DISK || sd->type == TYPE_ZBC) &&
> -		    pdv->pdv_bdev_handle) {
> -			bdev_release(pdv->pdv_bdev_handle);
> -			pdv->pdv_bdev_handle = NULL;
> +		    pdv->pdv_bdev_file) {
> +			fput(pdv->pdv_bdev_file);
> +			pdv->pdv_bdev_file = NULL;
>  		}
>  		/*
>  		 * For HBA mode PHV_LLD_SCSI_HOST_NO, release the reference
> @@ -994,8 +994,8 @@ static sector_t pscsi_get_blocks(struct se_device *dev)
>  {
>  	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
>  
> -	if (pdv->pdv_bdev_handle)
> -		return bdev_nr_sectors(pdv->pdv_bdev_handle->bdev);
> +	if (pdv->pdv_bdev_file)
> +		return bdev_nr_sectors(file_bdev(pdv->pdv_bdev_file));
>  	return 0;
>  }
>  
> diff --git a/drivers/target/target_core_pscsi.h b/drivers/target/target_core_pscsi.h
> index b0a3ef136592..9acaa21e4c78 100644
> --- a/drivers/target/target_core_pscsi.h
> +++ b/drivers/target/target_core_pscsi.h
> @@ -37,7 +37,7 @@ struct pscsi_dev_virt {
>  	int	pdv_channel_id;
>  	int	pdv_target_id;
>  	int	pdv_lun_id;
> -	struct bdev_handle *pdv_bdev_handle;
> +	struct file *pdv_bdev_file;
>  	struct scsi_device *pdv_sd;
>  	struct Scsi_Host *pdv_lld_host;
>  } ____cacheline_aligned;
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

