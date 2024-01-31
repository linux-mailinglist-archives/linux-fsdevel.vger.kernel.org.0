Return-Path: <linux-fsdevel+bounces-9695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01305844714
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C2B2946B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76273131E5A;
	Wed, 31 Jan 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="elZf61vJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jVg0HzBE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rl7W90wT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wNuusyKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7D130E31;
	Wed, 31 Jan 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725607; cv=none; b=m1V47em+imrLjtUniBoSVF20oPDu2so9jR3m5wjAz3ppRfP/ZeevlLT8relq75WDaDWJNy+JGpinLufBocLQ1jaxlg4UZrDFb9/kV38dK/WiR6eUp4yGzpJuln/5cGZbjt00XbG83Vyr6uoaL96Ge6Rq6V6O1jhrY0uZRCb39jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725607; c=relaxed/simple;
	bh=HMg3JPrBSPrBNrDSLPWjOcaN90dS2VUt1IiP5RXpcDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBqzbnZOJhi4TfuubkhT+SZd1KXw48Tquad1u767K+paOYuy9LJZey8F9QLGEC/Y+2kEi3W+uwuyXsvYxQvGzoDJQ0DbBnqQP9B8mT86boU345vTnmAbzPgsAU9eiuNrgneVpHUNSfspvD4nTPjZxPmUEIRm0IvnxXsevLYzN0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=elZf61vJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jVg0HzBE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rl7W90wT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wNuusyKH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD22B1FB95;
	Wed, 31 Jan 2024 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8PG4BUHNpMc0hwpVbrwPIZqHkf1Anh3sNuUDDdELzE=;
	b=elZf61vJUmE0li8J6Dc+GD+POQ08hZ69fXtz4EHgliwh/JvlqIb3x4oSRHG9+am958KeDO
	MefHM8faJcqm4/6meLdvEcsirdlkezCOfFs067K6qPSFrCaeEPHqdiAVX7J/MjhBcZhELI
	Owgx04SuIIrNu7MaLPk9SD8nDAUK+Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8PG4BUHNpMc0hwpVbrwPIZqHkf1Anh3sNuUDDdELzE=;
	b=jVg0HzBEgZaTfo0wM/ELg5o6M+UD2w/89jmYClZlFEdFdxiIKRWaICZrZpPFPcD5UzbKWj
	2ON9nLvd4O+y0nBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8PG4BUHNpMc0hwpVbrwPIZqHkf1Anh3sNuUDDdELzE=;
	b=rl7W90wTRc1YquyGKCmiM3jxUPRKYkeFI9dvcVg3cobHXwlVPWWGj341CLLgYH/FbJs4z7
	s5INczkq1olzy0t593Kp30uKMT6Me92ULU2HSl1Y3CwpgL71V5P4Ao+NucVunjd/QPCw3N
	Tj7Fzp2MoX1+kCyu4f+xKlASEESoDrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8PG4BUHNpMc0hwpVbrwPIZqHkf1Anh3sNuUDDdELzE=;
	b=wNuusyKHqelFCdjGLLWdYbL/Qz7AxYae5SBeTnl9JpLlijUCVYqOqH+PRy5nd+8J5a2Cdz
	/Dle4gwHmRdmtPDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CEDD7139D9;
	Wed, 31 Jan 2024 18:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6d8xMuOQumWJJgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:26:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 70C2DA0809; Wed, 31 Jan 2024 19:26:43 +0100 (CET)
Date: Wed, 31 Jan 2024 19:26:43 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 09/34] pktcdvd: port block device access to file
Message-ID: <20240131182643.zus2d63tmrnlf2pu@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-9-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-9-adbd023e19cc@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rl7W90wT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wNuusyKH
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
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: DD22B1FB95
X-Spam-Flag: NO

On Tue 23-01-24 14:26:26, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/pktcdvd.c | 68 ++++++++++++++++++++++++-------------------------
>  include/linux/pktcdvd.h |  4 +--
>  2 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> index d56d972aadb3..c21444716e43 100644
> --- a/drivers/block/pktcdvd.c
> +++ b/drivers/block/pktcdvd.c
> @@ -340,8 +340,8 @@ static ssize_t device_map_show(const struct class *c, const struct class_attribu
>  		n += sysfs_emit_at(data, n, "%s %u:%u %u:%u\n",
>  			pd->disk->disk_name,
>  			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
> -			MAJOR(pd->bdev_handle->bdev->bd_dev),
> -			MINOR(pd->bdev_handle->bdev->bd_dev));
> +			MAJOR(file_bdev(pd->bdev_file)->bd_dev),
> +			MINOR(file_bdev(pd->bdev_file)->bd_dev));
>  	}
>  	mutex_unlock(&ctl_mutex);
>  	return n;
> @@ -438,7 +438,7 @@ static int pkt_seq_show(struct seq_file *m, void *p)
>  	int states[PACKET_NUM_STATES];
>  
>  	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name,
> -		   pd->bdev_handle->bdev);
> +		   file_bdev(pd->bdev_file));
>  
>  	seq_printf(m, "\nSettings:\n");
>  	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
> @@ -715,7 +715,7 @@ static void pkt_rbtree_insert(struct pktcdvd_device *pd, struct pkt_rb_node *nod
>   */
>  static int pkt_generic_packet(struct pktcdvd_device *pd, struct packet_command *cgc)
>  {
> -	struct request_queue *q = bdev_get_queue(pd->bdev_handle->bdev);
> +	struct request_queue *q = bdev_get_queue(file_bdev(pd->bdev_file));
>  	struct scsi_cmnd *scmd;
>  	struct request *rq;
>  	int ret = 0;
> @@ -1048,7 +1048,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
>  			continue;
>  
>  		bio = pkt->r_bios[f];
> -		bio_init(bio, pd->bdev_handle->bdev, bio->bi_inline_vecs, 1,
> +		bio_init(bio, file_bdev(pd->bdev_file), bio->bi_inline_vecs, 1,
>  			 REQ_OP_READ);
>  		bio->bi_iter.bi_sector = pkt->sector + f * (CD_FRAMESIZE >> 9);
>  		bio->bi_end_io = pkt_end_io_read;
> @@ -1264,7 +1264,7 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
>  	struct device *ddev = disk_to_dev(pd->disk);
>  	int f;
>  
> -	bio_init(pkt->w_bio, pd->bdev_handle->bdev, pkt->w_bio->bi_inline_vecs,
> +	bio_init(pkt->w_bio, file_bdev(pd->bdev_file), pkt->w_bio->bi_inline_vecs,
>  		 pkt->frames, REQ_OP_WRITE);
>  	pkt->w_bio->bi_iter.bi_sector = pkt->sector;
>  	pkt->w_bio->bi_end_io = pkt_end_io_packet_write;
> @@ -2162,20 +2162,20 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
>  	int ret;
>  	long lba;
>  	struct request_queue *q;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  
>  	/*
>  	 * We need to re-open the cdrom device without O_NONBLOCK to be able
>  	 * to read/write from/to it. It is already opened in O_NONBLOCK mode
>  	 * so open should not fail.
>  	 */
> -	bdev_handle = bdev_open_by_dev(pd->bdev_handle->bdev->bd_dev,
> +	bdev_file = bdev_file_open_by_dev(file_bdev(pd->bdev_file)->bd_dev,
>  				       BLK_OPEN_READ, pd, NULL);
> -	if (IS_ERR(bdev_handle)) {
> -		ret = PTR_ERR(bdev_handle);
> +	if (IS_ERR(bdev_file)) {
> +		ret = PTR_ERR(bdev_file);
>  		goto out;
>  	}
> -	pd->open_bdev_handle = bdev_handle;
> +	pd->f_open_bdev = bdev_file;
>  
>  	ret = pkt_get_last_written(pd, &lba);
>  	if (ret) {
> @@ -2184,9 +2184,9 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
>  	}
>  
>  	set_capacity(pd->disk, lba << 2);
> -	set_capacity_and_notify(pd->bdev_handle->bdev->bd_disk, lba << 2);
> +	set_capacity_and_notify(file_bdev(pd->bdev_file)->bd_disk, lba << 2);
>  
> -	q = bdev_get_queue(pd->bdev_handle->bdev);
> +	q = bdev_get_queue(file_bdev(pd->bdev_file));
>  	if (write) {
>  		ret = pkt_open_write(pd);
>  		if (ret)
> @@ -2218,7 +2218,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
>  	return 0;
>  
>  out_putdev:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  out:
>  	return ret;
>  }
> @@ -2237,8 +2237,8 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
>  	pkt_lock_door(pd, 0);
>  
>  	pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
> -	bdev_release(pd->open_bdev_handle);
> -	pd->open_bdev_handle = NULL;
> +	fput(pd->f_open_bdev);
> +	pd->f_open_bdev = NULL;
>  
>  	pkt_shrink_pktlist(pd);
>  }
> @@ -2326,7 +2326,7 @@ static void pkt_end_io_read_cloned(struct bio *bio)
>  
>  static void pkt_make_request_read(struct pktcdvd_device *pd, struct bio *bio)
>  {
> -	struct bio *cloned_bio = bio_alloc_clone(pd->bdev_handle->bdev, bio,
> +	struct bio *cloned_bio = bio_alloc_clone(file_bdev(pd->bdev_file), bio,
>  		GFP_NOIO, &pkt_bio_set);
>  	struct packet_stacked_data *psd = mempool_alloc(&psd_pool, GFP_NOIO);
>  
> @@ -2497,7 +2497,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
>  {
>  	struct device *ddev = disk_to_dev(pd->disk);
>  	int i;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	struct scsi_device *sdev;
>  
>  	if (pd->pkt_dev == dev) {
> @@ -2508,9 +2508,9 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
>  		struct pktcdvd_device *pd2 = pkt_devs[i];
>  		if (!pd2)
>  			continue;
> -		if (pd2->bdev_handle->bdev->bd_dev == dev) {
> +		if (file_bdev(pd2->bdev_file)->bd_dev == dev) {
>  			dev_err(ddev, "%pg already setup\n",
> -				pd2->bdev_handle->bdev);
> +				file_bdev(pd2->bdev_file));
>  			return -EBUSY;
>  		}
>  		if (pd2->pkt_dev == dev) {
> @@ -2519,13 +2519,13 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
>  		}
>  	}
>  
> -	bdev_handle = bdev_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
> +	bdev_file = bdev_file_open_by_dev(dev, BLK_OPEN_READ | BLK_OPEN_NDELAY,
>  				       NULL, NULL);
> -	if (IS_ERR(bdev_handle))
> -		return PTR_ERR(bdev_handle);
> -	sdev = scsi_device_from_queue(bdev_handle->bdev->bd_disk->queue);
> +	if (IS_ERR(bdev_file))
> +		return PTR_ERR(bdev_file);
> +	sdev = scsi_device_from_queue(file_bdev(bdev_file)->bd_disk->queue);
>  	if (!sdev) {
> -		bdev_release(bdev_handle);
> +		fput(bdev_file);
>  		return -EINVAL;
>  	}
>  	put_device(&sdev->sdev_gendev);
> @@ -2533,8 +2533,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
>  	/* This is safe, since we have a reference from open(). */
>  	__module_get(THIS_MODULE);
>  
> -	pd->bdev_handle = bdev_handle;
> -	set_blocksize(bdev_handle->bdev, CD_FRAMESIZE);
> +	pd->bdev_file = bdev_file;
> +	set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
>  
>  	pkt_init_queue(pd);
>  
> @@ -2546,11 +2546,11 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
>  	}
>  
>  	proc_create_single_data(pd->disk->disk_name, 0, pkt_proc, pkt_seq_show, pd);
> -	dev_notice(ddev, "writer mapped to %pg\n", bdev_handle->bdev);
> +	dev_notice(ddev, "writer mapped to %pg\n", file_bdev(bdev_file));
>  	return 0;
>  
>  out_mem:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  	/* This is safe: open() is still holding a reference. */
>  	module_put(THIS_MODULE);
>  	return -ENOMEM;
> @@ -2605,9 +2605,9 @@ static unsigned int pkt_check_events(struct gendisk *disk,
>  
>  	if (!pd)
>  		return 0;
> -	if (!pd->bdev_handle)
> +	if (!pd->bdev_file)
>  		return 0;
> -	attached_disk = pd->bdev_handle->bdev->bd_disk;
> +	attached_disk = file_bdev(pd->bdev_file)->bd_disk;
>  	if (!attached_disk || !attached_disk->fops->check_events)
>  		return 0;
>  	return attached_disk->fops->check_events(attached_disk, clearing);
> @@ -2692,7 +2692,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
>  		goto out_mem2;
>  
>  	/* inherit events of the host device */
> -	disk->events = pd->bdev_handle->bdev->bd_disk->events;
> +	disk->events = file_bdev(pd->bdev_file)->bd_disk->events;
>  
>  	ret = add_disk(disk);
>  	if (ret)
> @@ -2757,7 +2757,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
>  	pkt_debugfs_dev_remove(pd);
>  	pkt_sysfs_dev_remove(pd);
>  
> -	bdev_release(pd->bdev_handle);
> +	fput(pd->bdev_file);
>  
>  	remove_proc_entry(pd->disk->disk_name, pkt_proc);
>  	dev_notice(ddev, "writer unmapped\n");
> @@ -2784,7 +2784,7 @@ static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
>  
>  	pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
>  	if (pd) {
> -		ctrl_cmd->dev = new_encode_dev(pd->bdev_handle->bdev->bd_dev);
> +		ctrl_cmd->dev = new_encode_dev(file_bdev(pd->bdev_file)->bd_dev);
>  		ctrl_cmd->pkt_dev = new_encode_dev(pd->pkt_dev);
>  	} else {
>  		ctrl_cmd->dev = 0;
> diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
> index 79594aeb160d..2f1b952d596a 100644
> --- a/include/linux/pktcdvd.h
> +++ b/include/linux/pktcdvd.h
> @@ -154,9 +154,9 @@ struct packet_stacked_data
>  
>  struct pktcdvd_device
>  {
> -	struct bdev_handle	*bdev_handle;	/* dev attached */
> +	struct file		*bdev_file;	/* dev attached */
>  	/* handle acquired for bdev during pkt_open_dev() */
> -	struct bdev_handle	*open_bdev_handle;
> +	struct file		*f_open_bdev;
>  	dev_t			pkt_dev;	/* our dev */
>  	struct packet_settings	settings;
>  	struct packet_stats	stats;
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

