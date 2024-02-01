Return-Path: <linux-fsdevel+bounces-9849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A67E845530
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2256F28B004
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1326715B965;
	Thu,  1 Feb 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lq3wcl1M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JaUO9ry8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lq3wcl1M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JaUO9ry8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA711F941;
	Thu,  1 Feb 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782977; cv=none; b=uiFo9JPsWyaBPVZwBRT6JfjvL4s6vbPaaaCVK6+w5NTgU4Eu3ooXO9cYoYkgRvoAweMfvgUYcJiYs+D2iI41wC3ZT5OkcC3aO09zEe9smyNPxCc0h+ULk4Oza6PWvoxvju32O/sWcYLiEohAyeuE0UtdJtVnZljohOFC49cug8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782977; c=relaxed/simple;
	bh=K+Ghti0skIExCC04frCO2ZEIlPLyeHrMPCUEttf1eRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYGJEFHxVR9EWo4SW9zmr5+mC76vTRjspdL3kMwcBA81yBUX4QCzyg1z2kB39mcrS7UaD+fL2g/yQ9airL8J34V/x8gD9IyU65K4wmI9RRQxCAWEbqFDgNm+m4nvr/6GUmYumHmXujS9miqnRA2Km/UhDHv3E9LR1U7gyc/+yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lq3wcl1M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JaUO9ry8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lq3wcl1M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JaUO9ry8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F24821DED;
	Thu,  1 Feb 2024 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J99WxWeZTr5orY2tP9BXMWzq/Fr2ZlR50Ku6XiqXMQA=;
	b=lq3wcl1MiyPq4Yq96iOQgzUc53anuxGycjl7JgNEvXT3RtYvrrs1uVkviqmMZorNeN1UQM
	YcnaI4cNvuO11wgEzS/zrMCj3aWS2ucSh31+jkJwqgKV01USTlFMp5QbK8Pw0F/L4xJm4e
	AgP9nQuQKzD7ajLBxlTWN/EyTJjBxvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J99WxWeZTr5orY2tP9BXMWzq/Fr2ZlR50Ku6XiqXMQA=;
	b=JaUO9ry82qh6l13C2PF5/73Mw0K1kTrtYPuRgJVrX4RKNRR5a8ELbr8+jwM5HJUBuLP4Ag
	HRLIpx3W8eJFcdAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706782974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J99WxWeZTr5orY2tP9BXMWzq/Fr2ZlR50Ku6XiqXMQA=;
	b=lq3wcl1MiyPq4Yq96iOQgzUc53anuxGycjl7JgNEvXT3RtYvrrs1uVkviqmMZorNeN1UQM
	YcnaI4cNvuO11wgEzS/zrMCj3aWS2ucSh31+jkJwqgKV01USTlFMp5QbK8Pw0F/L4xJm4e
	AgP9nQuQKzD7ajLBxlTWN/EyTJjBxvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706782974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J99WxWeZTr5orY2tP9BXMWzq/Fr2ZlR50Ku6XiqXMQA=;
	b=JaUO9ry82qh6l13C2PF5/73Mw0K1kTrtYPuRgJVrX4RKNRR5a8ELbr8+jwM5HJUBuLP4Ag
	HRLIpx3W8eJFcdAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 066AF1329F;
	Thu,  1 Feb 2024 10:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rs6OAf5wu2VTXwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 10:22:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3CE6A0809; Thu,  1 Feb 2024 11:22:53 +0100 (CET)
Date: Thu, 1 Feb 2024 11:22:53 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 25/34] ocfs2: port block device access to file
Message-ID: <20240201102253.5zrvbufygffehjgf@quack3>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-25-adbd023e19cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-vfs-bdev-file-v2-25-adbd023e19cc@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue 23-01-24 14:26:42, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/cluster/heartbeat.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 4d7efefa98c5..1bde1281d514 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -213,7 +213,7 @@ struct o2hb_region {
>  	unsigned int		hr_num_pages;
>  
>  	struct page             **hr_slot_data;
> -	struct bdev_handle	*hr_bdev_handle;
> +	struct file		*hr_bdev_file;
>  	struct o2hb_disk_slot	*hr_slots;
>  
>  	/* live node map of this region */
> @@ -263,7 +263,7 @@ struct o2hb_region {
>  
>  static inline struct block_device *reg_bdev(struct o2hb_region *reg)
>  {
> -	return reg->hr_bdev_handle ? reg->hr_bdev_handle->bdev : NULL;
> +	return reg->hr_bdev_file ? file_bdev(reg->hr_bdev_file) : NULL;
>  }
>  
>  struct o2hb_bio_wait_ctxt {
> @@ -1509,8 +1509,8 @@ static void o2hb_region_release(struct config_item *item)
>  		kfree(reg->hr_slot_data);
>  	}
>  
> -	if (reg->hr_bdev_handle)
> -		bdev_release(reg->hr_bdev_handle);
> +	if (reg->hr_bdev_file)
> +		fput(reg->hr_bdev_file);
>  
>  	kfree(reg->hr_slots);
>  
> @@ -1569,7 +1569,7 @@ static ssize_t o2hb_region_block_bytes_store(struct config_item *item,
>  	unsigned long block_bytes;
>  	unsigned int block_bits;
>  
> -	if (reg->hr_bdev_handle)
> +	if (reg->hr_bdev_file)
>  		return -EINVAL;
>  
>  	status = o2hb_read_block_input(reg, page, &block_bytes,
> @@ -1598,7 +1598,7 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
>  	char *p = (char *)page;
>  	ssize_t ret;
>  
> -	if (reg->hr_bdev_handle)
> +	if (reg->hr_bdev_file)
>  		return -EINVAL;
>  
>  	ret = kstrtoull(p, 0, &tmp);
> @@ -1623,7 +1623,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
>  	unsigned long tmp;
>  	char *p = (char *)page;
>  
> -	if (reg->hr_bdev_handle)
> +	if (reg->hr_bdev_file)
>  		return -EINVAL;
>  
>  	tmp = simple_strtoul(p, &p, 0);
> @@ -1642,7 +1642,7 @@ static ssize_t o2hb_region_dev_show(struct config_item *item, char *page)
>  {
>  	unsigned int ret = 0;
>  
> -	if (to_o2hb_region(item)->hr_bdev_handle)
> +	if (to_o2hb_region(item)->hr_bdev_file)
>  		ret = sprintf(page, "%pg\n", reg_bdev(to_o2hb_region(item)));
>  
>  	return ret;
> @@ -1753,7 +1753,7 @@ static int o2hb_populate_slot_data(struct o2hb_region *reg)
>  }
>  
>  /*
> - * this is acting as commit; we set up all of hr_bdev_handle and hr_task or
> + * this is acting as commit; we set up all of hr_bdev_file and hr_task or
>   * nothing
>   */
>  static ssize_t o2hb_region_dev_store(struct config_item *item,
> @@ -1769,7 +1769,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	ssize_t ret = -EINVAL;
>  	int live_threshold;
>  
> -	if (reg->hr_bdev_handle)
> +	if (reg->hr_bdev_file)
>  		goto out;
>  
>  	/* We can't heartbeat without having had our node number
> @@ -1795,11 +1795,11 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  	if (!S_ISBLK(f.file->f_mapping->host->i_mode))
>  		goto out2;
>  
> -	reg->hr_bdev_handle = bdev_open_by_dev(f.file->f_mapping->host->i_rdev,
> +	reg->hr_bdev_file = bdev_file_open_by_dev(f.file->f_mapping->host->i_rdev,
>  			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
> -	if (IS_ERR(reg->hr_bdev_handle)) {
> -		ret = PTR_ERR(reg->hr_bdev_handle);
> -		reg->hr_bdev_handle = NULL;
> +	if (IS_ERR(reg->hr_bdev_file)) {
> +		ret = PTR_ERR(reg->hr_bdev_file);
> +		reg->hr_bdev_file = NULL;
>  		goto out2;
>  	}
>  
> @@ -1903,8 +1903,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
>  
>  out3:
>  	if (ret < 0) {
> -		bdev_release(reg->hr_bdev_handle);
> -		reg->hr_bdev_handle = NULL;
> +		fput(reg->hr_bdev_file);
> +		reg->hr_bdev_file = NULL;
>  	}
>  out2:
>  	fdput(f);
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

