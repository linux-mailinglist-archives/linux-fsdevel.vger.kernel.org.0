Return-Path: <linux-fsdevel+bounces-9696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3955844721
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E51B231A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02213541D;
	Wed, 31 Jan 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmMY0+zG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wy6497PF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmMY0+zG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wy6497PF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A3130E58;
	Wed, 31 Jan 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725714; cv=none; b=Gvu+SU5BCzKzMGMA/VDLR3+KIEcT0D4SVqMhxy8vKHyUQ+nWjIVyGufdWyLSBbNqhgVzuvOm2ixuc8SFYvYFwCBmWHCULZrVZMI6D22PdMdSyLHqIiMRNdOJiUF8x6sxEC4z6M+iQfzmqD5xG3t9zSKqwpjcCLzXW5Ocstz8dm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725714; c=relaxed/simple;
	bh=cIIaGRbZ5E1X87Rem3nWNpi0lua0t16BcuBdJEVdEf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVO9Scon7H7wcXoFj+aLttOGbK00veJlcvwvZTuFqbSaHi7fh/blNPjkTtu1u979kipkp+HdSyoHDiVCC3b0yxv1XZlmjHIuOssGZEM4rzMvM593875t1oSy6ehJXIpKR4+CDT/RYZlKZs+9jtuCtcMCNXqfYwp3cXYTmEElt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmMY0+zG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wy6497PF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmMY0+zG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wy6497PF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A73F1FB8E;
	Wed, 31 Jan 2024 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNt7DCAA4RDLq3J7OHaCk1+4rKPCh+Lr1KGTODDGDo8=;
	b=HmMY0+zGrL7/IpaJkx5/ZrQGwvgEnqWy70tl+c7pCoFRoFtl26odMSTOUAn2C04wfCGiIb
	+3sxl+zqw7y4c8ep5OzgQUzqDLuG7ZHWdFbMZHl2Z5EpPtXEqDvy9nPqDegRnzEjxtQ7Ys
	bGZlDS98Ia1tbFXjHFne+eOzZ+iXgFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNt7DCAA4RDLq3J7OHaCk1+4rKPCh+Lr1KGTODDGDo8=;
	b=Wy6497PFLvumEJdZLMLQ4jKKigrdblOtmtVpZaSNvv4ArmEKC9/NlaZFHH61chLyCHGz11
	0aRm0AJBECVd0DBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNt7DCAA4RDLq3J7OHaCk1+4rKPCh+Lr1KGTODDGDo8=;
	b=HmMY0+zGrL7/IpaJkx5/ZrQGwvgEnqWy70tl+c7pCoFRoFtl26odMSTOUAn2C04wfCGiIb
	+3sxl+zqw7y4c8ep5OzgQUzqDLuG7ZHWdFbMZHl2Z5EpPtXEqDvy9nPqDegRnzEjxtQ7Ys
	bGZlDS98Ia1tbFXjHFne+eOzZ+iXgFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNt7DCAA4RDLq3J7OHaCk1+4rKPCh+Lr1KGTODDGDo8=;
	b=Wy6497PFLvumEJdZLMLQ4jKKigrdblOtmtVpZaSNvv4ArmEKC9/NlaZFHH61chLyCHGz11
	0aRm0AJBECVd0DBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E29E139D9;
	Wed, 31 Jan 2024 18:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pNldB0+RumXjJgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 18:28:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3148A0809; Wed, 31 Jan 2024 19:28:30 +0100 (CET)
Date: Wed, 31 Jan 2024 19:28:30 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 10/34] rnbd: port block device access to file
Message-ID: <20240131182830.lq54hshc7eej7ncx@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-10-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-10-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HmMY0+zG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wy6497PF
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2A73F1FB8E
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Tue 23-01-24 14:26:27, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/block/rnbd/rnbd-srv.c | 28 ++++++++++++++--------------
>  drivers/block/rnbd/rnbd-srv.h |  2 +-
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 3a0d5dcec6f2..f6e3a3c4b76c 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -145,7 +145,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
>  	priv->sess_dev = sess_dev;
>  	priv->id = id;
>  
> -	bio = bio_alloc(sess_dev->bdev_handle->bdev, 1,
> +	bio = bio_alloc(file_bdev(sess_dev->bdev_file), 1,
>  			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
>  	if (bio_add_page(bio, virt_to_page(data), datalen,
>  			offset_in_page(data)) != datalen) {
> @@ -219,7 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
>  	rnbd_put_sess_dev(sess_dev);
>  	wait_for_completion(&dc); /* wait for inflights to drop to zero */
>  
> -	bdev_release(sess_dev->bdev_handle);
> +	fput(sess_dev->bdev_file);
>  	mutex_lock(&sess_dev->dev->lock);
>  	list_del(&sess_dev->dev_list);
>  	if (!sess_dev->readonly)
> @@ -534,7 +534,7 @@ rnbd_srv_get_or_create_srv_dev(struct block_device *bdev,
>  static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
>  					struct rnbd_srv_sess_dev *sess_dev)
>  {
> -	struct block_device *bdev = sess_dev->bdev_handle->bdev;
> +	struct block_device *bdev = file_bdev(sess_dev->bdev_file);
>  
>  	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
>  	rsp->device_id = cpu_to_le32(sess_dev->device_id);
> @@ -560,7 +560,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
>  static struct rnbd_srv_sess_dev *
>  rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
>  			      const struct rnbd_msg_open *open_msg,
> -			      struct bdev_handle *handle, bool readonly,
> +			      struct file *bdev_file, bool readonly,
>  			      struct rnbd_srv_dev *srv_dev)
>  {
>  	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
> @@ -572,7 +572,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
>  
>  	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
>  
> -	sdev->bdev_handle	= handle;
> +	sdev->bdev_file		= bdev_file;
>  	sdev->sess		= srv_sess;
>  	sdev->dev		= srv_dev;
>  	sdev->readonly		= readonly;
> @@ -678,7 +678,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>  	struct rnbd_srv_dev *srv_dev;
>  	struct rnbd_srv_sess_dev *srv_sess_dev;
>  	const struct rnbd_msg_open *open_msg = msg;
> -	struct bdev_handle *bdev_handle;
> +	struct file *bdev_file;
>  	blk_mode_t open_flags = BLK_OPEN_READ;
>  	char *full_path;
>  	struct rnbd_msg_open_rsp *rsp = data;
> @@ -716,15 +716,15 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>  		goto reject;
>  	}
>  
> -	bdev_handle = bdev_open_by_path(full_path, open_flags, NULL, NULL);
> -	if (IS_ERR(bdev_handle)) {
> -		ret = PTR_ERR(bdev_handle);
> +	bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
> +	if (IS_ERR(bdev_file)) {
> +		ret = PTR_ERR(bdev_file);
>  		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",
> -		       full_path, srv_sess->sessname, bdev_handle);
> +		       full_path, srv_sess->sessname, bdev_file);
>  		goto free_path;
>  	}
>  
> -	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev_handle->bdev, srv_sess,
> +	srv_dev = rnbd_srv_get_or_create_srv_dev(file_bdev(bdev_file), srv_sess,
>  						  open_msg->access_mode);
>  	if (IS_ERR(srv_dev)) {
>  		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %pe\n",
> @@ -734,7 +734,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>  	}
>  
>  	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
> -				bdev_handle,
> +				bdev_file,
>  				open_msg->access_mode == RNBD_ACCESS_RO,
>  				srv_dev);
>  	if (IS_ERR(srv_sess_dev)) {
> @@ -750,7 +750,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>  	 */
>  	mutex_lock(&srv_dev->lock);
>  	if (!srv_dev->dev_kobj.state_in_sysfs) {
> -		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev_handle->bdev);
> +		ret = rnbd_srv_create_dev_sysfs(srv_dev, file_bdev(bdev_file));
>  		if (ret) {
>  			mutex_unlock(&srv_dev->lock);
>  			rnbd_srv_err(srv_sess_dev,
> @@ -793,7 +793,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
>  	}
>  	rnbd_put_srv_dev(srv_dev);
>  blkdev_put:
> -	bdev_release(bdev_handle);
> +	fput(bdev_file);
>  free_path:
>  	kfree(full_path);
>  reject:
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> index 343cc682b617..18d873808b8d 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -46,7 +46,7 @@ struct rnbd_srv_dev {
>  struct rnbd_srv_sess_dev {
>  	/* Entry inside rnbd_srv_dev struct */
>  	struct list_head		dev_list;
> -	struct bdev_handle		*bdev_handle;
> +	struct file			*bdev_file;
>  	struct rnbd_srv_session		*sess;
>  	struct rnbd_srv_dev		*dev;
>  	struct kobject                  kobj;
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

