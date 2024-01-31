Return-Path: <linux-fsdevel+bounces-9697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C54A84472A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612EAB2595B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D3BDF66;
	Wed, 31 Jan 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i/ZhbspJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KigTmmnP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i/ZhbspJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KigTmmnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8C1C32;
	Wed, 31 Jan 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725876; cv=none; b=pcXpmVFQWm/ccOuTtNJT9FhJ1T4BkEPof+vAXqOB0x7iG0lqxOUFfK8Ui3m+j10aUS0R9NVu8Qh1c+9OsqmjZRw4OFD0ZRMu/DNmXeH+4Uvgf7+W0Za0zOg8cj8Bm4zV3gU7vMoWz8wnkv5/y5+5bB5nCt20bnDfidTC+dmNzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725876; c=relaxed/simple;
	bh=Cp8yfORAEvA26Jzc66pCpKj/jGt8V8Zhq5l2vn1XKKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY6fp4Gh82ePMNaz9efwettLyJSHOifzQgo1Gt5+lp/x5D7sQrzunv8ZQPfxqcPombNX+Ny9CmVt6KYV9+EAoD+15aHXya2HqP8uQvudw2tX5LLW2bP5f4cESC85u1UxW5bXqUJOH+rpfC1TaDNMilJM6wLtckyXY/hUpo2I22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i/ZhbspJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KigTmmnP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i/ZhbspJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KigTmmnP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4BCA22023;
	Wed, 31 Jan 2024 18:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgXh8tznsLu0ZiwNgVy5bRlVm7Z4Roj4BZsjMxZJtos=;
	b=i/ZhbspJq5eGUqzQ5iRK1VniuYD5LCNzaDYTtdQ15cLngocIrrErergarYq0rDanT/qZey
	EClS6ItgtVa3i+Wy+dhH6oQSEQgpnwJ+AbuJYr3gxhcrDOZYzLz2XzP6P+/+QRTZGrlJDN
	LzXHcFpRYjBIw0cZL6cCoq76ud1zhZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgXh8tznsLu0ZiwNgVy5bRlVm7Z4Roj4BZsjMxZJtos=;
	b=KigTmmnP82IhyyUmnRXpjgvX0seX6qiYhsVjt/0nvOUlb/qe0uolYK5ehvKA/h4Y+4xciE
	0fiaQAvJfajOKeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgXh8tznsLu0ZiwNgVy5bRlVm7Z4Roj4BZsjMxZJtos=;
	b=i/ZhbspJq5eGUqzQ5iRK1VniuYD5LCNzaDYTtdQ15cLngocIrrErergarYq0rDanT/qZey
	EClS6ItgtVa3i+Wy+dhH6oQSEQgpnwJ+AbuJYr3gxhcrDOZYzLz2XzP6P+/+QRTZGrlJDN
	LzXHcFpRYjBIw0cZL6cCoq76ud1zhZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgXh8tznsLu0ZiwNgVy5bRlVm7Z4Roj4BZsjMxZJtos=;
	b=KigTmmnP82IhyyUmnRXpjgvX0seX6qiYhsVjt/0nvOUlb/qe0uolYK5ehvKA/h4Y+4xciE
	0fiaQAvJfajOKeDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E890139D9;
	Wed, 31 Jan 2024 18:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CmN7IvCRumWDJwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:31:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1823CA0809; Wed, 31 Jan 2024 19:31:12 +0100 (CET)
Date: Wed, 31 Jan 2024 19:31:12 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 11/34] xen: port block device access to file
Message-ID: <20240131183112.xqoje7r7vgkvutzb@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-11-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-11-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 4.30
X-Spamd-Result: default: False [4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue 23-01-24 14:26:28, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/xen-blkback/blkback.c |  4 ++--
>  drivers/block/xen-blkback/common.h  |  4 ++--
>  drivers/block/xen-blkback/xenbus.c  | 37 ++++++++++++++++++-------------------
>  3 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 4defd7f387c7..944576d582fb 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -465,7 +465,7 @@ static int xen_vbd_translate(struct phys_req *req, struct xen_blkif *blkif,
>  	}
>  
>  	req->dev  = vbd->pdevice;
> -	req->bdev = vbd->bdev_handle->bdev;
> +	req->bdev = file_bdev(vbd->bdev_file);
>  	rc = 0;
>  
>   out:
> @@ -969,7 +969,7 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
>  	int err = 0;
>  	int status = BLKIF_RSP_OKAY;
>  	struct xen_blkif *blkif = ring->blkif;
> -	struct block_device *bdev = blkif->vbd.bdev_handle->bdev;
> +	struct block_device *bdev = file_bdev(blkif->vbd.bdev_file);
>  	struct phys_req preq;
>  
>  	xen_blkif_get(blkif);
> diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
> index 1432c83183d0..b427d54bc120 100644
> --- a/drivers/block/xen-blkback/common.h
> +++ b/drivers/block/xen-blkback/common.h
> @@ -221,7 +221,7 @@ struct xen_vbd {
>  	unsigned char		type;
>  	/* phys device that this vbd maps to. */
>  	u32			pdevice;
> -	struct bdev_handle	*bdev_handle;
> +	struct file		*bdev_file;
>  	/* Cached size parameter. */
>  	sector_t		size;
>  	unsigned int		flush_support:1;
> @@ -360,7 +360,7 @@ struct pending_req {
>  };
>  
>  
> -#define vbd_sz(_v)	bdev_nr_sectors((_v)->bdev_handle->bdev)
> +#define vbd_sz(_v)	bdev_nr_sectors(file_bdev((_v)->bdev_file))
>  
>  #define xen_blkif_get(_b) (atomic_inc(&(_b)->refcnt))
>  #define xen_blkif_put(_b)				\
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index e34219ea2b05..0621878940ae 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -81,7 +81,7 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
>  	int i;
>  
>  	/* Not ready to connect? */
> -	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.bdev_handle)
> +	if (!blkif->rings || !blkif->rings[0].irq || !blkif->vbd.bdev_file)
>  		return;
>  
>  	/* Already connected? */
> @@ -99,13 +99,12 @@ static void xen_update_blkif_status(struct xen_blkif *blkif)
>  		return;
>  	}
>  
> -	err = sync_blockdev(blkif->vbd.bdev_handle->bdev);
> +	err = sync_blockdev(file_bdev(blkif->vbd.bdev_file));
>  	if (err) {
>  		xenbus_dev_error(blkif->be->dev, err, "block flush");
>  		return;
>  	}
> -	invalidate_inode_pages2(
> -			blkif->vbd.bdev_handle->bdev->bd_inode->i_mapping);
> +	invalidate_inode_pages2(blkif->vbd.bdev_file->f_mapping);
>  
>  	for (i = 0; i < blkif->nr_rings; i++) {
>  		ring = &blkif->rings[i];
> @@ -473,9 +472,9 @@ static void xenvbd_sysfs_delif(struct xenbus_device *dev)
>  
>  static void xen_vbd_free(struct xen_vbd *vbd)
>  {
> -	if (vbd->bdev_handle)
> -		bdev_release(vbd->bdev_handle);
> -	vbd->bdev_handle = NULL;
> +	if (vbd->bdev_file)
> +		fput(vbd->bdev_file);
> +	vbd->bdev_file = NULL;
>  }
>  
>  static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
> @@ -483,7 +482,7 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
>  			  int cdrom)
>  {
>  	struct xen_vbd *vbd;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  
>  	vbd = &blkif->vbd;
>  	vbd->handle   = handle;
> @@ -492,17 +491,17 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
>  
>  	vbd->pdevice  = MKDEV(major, minor);
>  
> -	bdev_handle = bdev_open_by_dev(vbd->pdevice, vbd->readonly ?
> +	bdev_file = bdev_file_open_by_dev(vbd->pdevice, vbd->readonly ?
>  				 BLK_OPEN_READ : BLK_OPEN_WRITE, NULL, NULL);
>  
> -	if (IS_ERR(bdev_handle)) {
> +	if (IS_ERR(bdev_file)) {
>  		pr_warn("xen_vbd_create: device %08x could not be opened\n",
>  			vbd->pdevice);
>  		return -ENOENT;
>  	}
>  
> -	vbd->bdev_handle = bdev_handle;
> -	if (vbd->bdev_handle->bdev->bd_disk == NULL) {
> +	vbd->bdev_file = bdev_file;
> +	if (file_bdev(vbd->bdev_file)->bd_disk == NULL) {
>  		pr_warn("xen_vbd_create: device %08x doesn't exist\n",
>  			vbd->pdevice);
>  		xen_vbd_free(vbd);
> @@ -510,14 +509,14 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
>  	}
>  	vbd->size = vbd_sz(vbd);
>  
> -	if (cdrom || disk_to_cdi(vbd->bdev_handle->bdev->bd_disk))
> +	if (cdrom || disk_to_cdi(file_bdev(vbd->bdev_file)->bd_disk))
>  		vbd->type |= VDISK_CDROM;
> -	if (vbd->bdev_handle->bdev->bd_disk->flags & GENHD_FL_REMOVABLE)
> +	if (file_bdev(vbd->bdev_file)->bd_disk->flags & GENHD_FL_REMOVABLE)
>  		vbd->type |= VDISK_REMOVABLE;
>  
> -	if (bdev_write_cache(bdev_handle->bdev))
> +	if (bdev_write_cache(file_bdev(bdev_file)))
>  		vbd->flush_support = true;
> -	if (bdev_max_secure_erase_sectors(bdev_handle->bdev))
> +	if (bdev_max_secure_erase_sectors(file_bdev(bdev_file)))
>  		vbd->discard_secure = true;
>  
>  	pr_debug("Successful creation of handle=%04x (dom=%u)\n",
> @@ -570,7 +569,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
>  	struct xen_blkif *blkif = be->blkif;
>  	int err;
>  	int state = 0;
> -	struct block_device *bdev = be->blkif->vbd.bdev_handle->bdev;
> +	struct block_device *bdev = file_bdev(be->blkif->vbd.bdev_file);
>  
>  	if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
>  		return;
> @@ -932,7 +931,7 @@ static void connect(struct backend_info *be)
>  	}
>  	err = xenbus_printf(xbt, dev->nodename, "sector-size", "%lu",
>  			    (unsigned long)bdev_logical_block_size(
> -					be->blkif->vbd.bdev_handle->bdev));
> +					file_bdev(be->blkif->vbd.bdev_file)));
>  	if (err) {
>  		xenbus_dev_fatal(dev, err, "writing %s/sector-size",
>  				 dev->nodename);
> @@ -940,7 +939,7 @@ static void connect(struct backend_info *be)
>  	}
>  	err = xenbus_printf(xbt, dev->nodename, "physical-sector-size", "%u",
>  			    bdev_physical_block_size(
> -					be->blkif->vbd.bdev_handle->bdev));
> +					file_bdev(be->blkif->vbd.bdev_file)));
>  	if (err)
>  		xenbus_dev_error(dev, err, "writing %s/physical-sector-size",
>  				 dev->nodename);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

