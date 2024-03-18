Return-Path: <linux-fsdevel+bounces-14723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A92CE87E59C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 10:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE5CB2128A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8F2C694;
	Mon, 18 Mar 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bGzaSV9P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrLzzAHs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w6kVA0iK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDFBtx52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD62C684;
	Mon, 18 Mar 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753749; cv=none; b=OykkSEjj+y15DHEQz5c0mcqHUgXQlpPNS19Q3RNxSgg4/7uaBKOWExgCciLACOwtx0U6Np64mUmDas7dIAIFPew0hoitgrnWpK28UG1cfFQoqW9pUgMixw77jhTw6Edc4go3tu3hX706EuC/xzXFZzdcf8Iv80myqNRfY8QpoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753749; c=relaxed/simple;
	bh=YB7Nput7gyoYeZjQKvKFl9SFdfZHqHfrmo3S2a64UtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cga34Yz6F9hX1AzXl843HlOpJZ3x44tWGydLZuAP4NEtyS/o7cTnCJ00HULS5GLTGN5LBbzWZ3cYNQ4yBIvRAvx3g4mYhFHdGFnXIMpwNjSwtRFWf1xkBaFA/uxyilVqaVazaw5IjYRrMcFjbuFDfQbc3JhxRWjmj6T+Ui1Sw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bGzaSV9P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrLzzAHs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w6kVA0iK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDFBtx52; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5FD45C324;
	Mon, 18 Mar 2024 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710753745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PKXwT21zGp7h0P23JiHp9Uxx7vGKylqN1ycx8ujs+cY=;
	b=bGzaSV9PmTC17piPa+FfeQLOqeYNWANak3uA2dqes54c71HpczmoCaZvSCznj6PQSjP2Qq
	yP5BDrKk3oYYDxe1Fv3enNVEWuMdQhphtQ/tYmU931sJUwDjpzyvkRwskYQKDj3/nJeFDp
	Wn2DJNLa5sSeTN7ck3jaWMsEjKgieNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710753745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PKXwT21zGp7h0P23JiHp9Uxx7vGKylqN1ycx8ujs+cY=;
	b=NrLzzAHsh26EVpRNB1EUEhhKvwWSu4JnpBqjgqzur9DcktMBviEwOilXNbU47ZSx8GSKYh
	Q6GsuGW7nOhGzuCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710753743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PKXwT21zGp7h0P23JiHp9Uxx7vGKylqN1ycx8ujs+cY=;
	b=w6kVA0iKB12APM3/l2fIFkJ5m6PIkZbfpV4yQ99tuNUgwoqWmwyz5gDfKaYIDNXxgAPYfI
	qCQIZyuIXP7bFtwn/FATgpE/jdVnsEjpNWAOWt0Dm7DVaJ8EZXW8lACW35MyQA79naRuve
	rKn41jrlvXyJFODfgL5qPsXnrrCWYdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710753743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PKXwT21zGp7h0P23JiHp9Uxx7vGKylqN1ycx8ujs+cY=;
	b=NDFBtx52tJ6B7wc0zcEpKZPimbu5oLzGObGTTFqn/3p6e7Y/HRsjX+4onxcEb59glD9rZ1
	jxc63njrEd+ttlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAA391349D;
	Mon, 18 Mar 2024 09:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o/52Mc8H+GW6SgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Mar 2024 09:22:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A91AA07D9; Mon, 18 Mar 2024 10:22:19 +0100 (CET)
Date: Mon, 18 Mar 2024 10:22:19 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 18/19] scsi: factor out a helper
 bdev_read_folio() from scsi_bios_ptable()
Message-ID: <20240318092219.t7ausibxzgoawscl@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-19-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-19-yukuai1@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
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
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:54, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> scsi_bios_ptable() is reading without opening disk as file, factor out
> a helper to read into block device page cache to prevent access bd_inode
> directly from scsi.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me. Either before or after split feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c           | 19 +++++++++++++++++++
>  drivers/scsi/scsicam.c |  3 +--
>  include/linux/blkdev.h |  1 +
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 60a1479eae83..b7af04d34af2 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1211,6 +1211,25 @@ unsigned int block_size(struct block_device *bdev)
>  }
>  EXPORT_SYMBOL_GPL(block_size);
>  
> +/**
> + * bdev_read_folio - Read into block device page cache.
> + * @bdev: the block device which holds the cache to read.
> + * @pos: the offset that allocated folio will contain.
> + *
> + * Read one page into the block device page cache. If it succeeds, the folio
> + * returned will contain @pos;
> + *
> + * This is only used for scsi_bios_ptable(), the bdev is not opened as files.
> + *
> + * Return: Uptodate folio on success, ERR_PTR() on failure.
> + */
> +struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos)
> +{
> +	return mapping_read_folio_gfp(bdev_mapping(bdev),
> +				      pos >> PAGE_SHIFT, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(bdev_read_folio);
> +
>  static int __init setup_bdev_allow_write_mounted(char *str)
>  {
>  	if (kstrtobool(str, &bdev_allow_write_mounted))
> diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
> index e2c7d8ef205f..1c99b964a0eb 100644
> --- a/drivers/scsi/scsicam.c
> +++ b/drivers/scsi/scsicam.c
> @@ -32,11 +32,10 @@
>   */
>  unsigned char *scsi_bios_ptable(struct block_device *dev)
>  {
> -	struct address_space *mapping = bdev_whole(dev)->bd_inode->i_mapping;
>  	unsigned char *res = NULL;
>  	struct folio *folio;
>  
> -	folio = read_mapping_folio(mapping, 0, NULL);
> +	folio = bdev_read_folio(bdev_whole(dev), 0);
>  	if (IS_ERR(folio))
>  		return NULL;
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c510f334c84f..3fb02e3a527a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1514,6 +1514,7 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
>  int bd_prepare_to_claim(struct block_device *bdev, void *holder,
>  		const struct blk_holder_ops *hops);
>  void bd_abort_claiming(struct block_device *bdev, void *holder);
> +struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos);
>  
>  /* just for blk-cgroup, don't use elsewhere */
>  struct block_device *blkdev_get_no_open(dev_t dev);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

