Return-Path: <linux-fsdevel+bounces-14478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDBF87CFDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF991F2398F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58853D0BC;
	Fri, 15 Mar 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tFS71oDE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1wG3RQpB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tFS71oDE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1wG3RQpB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638321BDE0;
	Fri, 15 Mar 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515488; cv=none; b=fAELYe7om9UbCSHPzNJDP3eZBKfU8KIUtRhIxAqfmOt2zHHNMSHOZZheRahi09XDCT8XpQpkpywnDr8e3uZ1vK0gdf0v8X4ib1PWeIrv51HoLOuB8ThL1gNOUziJsN7mxBorfdxWE2TmxBsw5+kLTsFUj01KlAdpLg0TS91HTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515488; c=relaxed/simple;
	bh=nGAhlMt3Vu+wa2WGXRaxVKtBjCRn5rd92ungb9Ve43c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngfa4YkggkzRo9jAx7/OMzEI33IkVxJ46/gbacEcaQLv0N99NjB2oHUb9nlPV6w9OWvqE3swM/P55V3C5kQMfRVu4zTojrbGZRyzpK9kqz9hr3ZzyITO8vsYPUkecc097YzzxqM24vEW3DGO7YycqNkLgDI3Lc+9+cGp6oGRBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tFS71oDE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1wG3RQpB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tFS71oDE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1wG3RQpB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DC6A21D31;
	Fri, 15 Mar 2024 15:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78TR34U5VWAH29V7dkyQ9/7DB1o6EuQGdaeyEZaLyz0=;
	b=tFS71oDE34KHzdux2YIbsIzjUg6pXvoK6ZtP4IX6CrfCN1wlsJ1Hwo7R7CN7kCiVkuHWV/
	i/fWtwbDlODYMK0rKUEVG9s6/ZDEiFEus5atSuyqBkRDXV45r+cVq9oC7Gw+ATqv9wSbKU
	aJ9/4sx1uaSDQjUOqUnQSxvch5PWsU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78TR34U5VWAH29V7dkyQ9/7DB1o6EuQGdaeyEZaLyz0=;
	b=1wG3RQpBRTZKs0wa5r+/ySSqWU0D8iArs6naDYv68AvLTWLzwcI6h4c06gCJTqDJeVTjr/
	PZX4+r07cLAblfAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710515482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78TR34U5VWAH29V7dkyQ9/7DB1o6EuQGdaeyEZaLyz0=;
	b=tFS71oDE34KHzdux2YIbsIzjUg6pXvoK6ZtP4IX6CrfCN1wlsJ1Hwo7R7CN7kCiVkuHWV/
	i/fWtwbDlODYMK0rKUEVG9s6/ZDEiFEus5atSuyqBkRDXV45r+cVq9oC7Gw+ATqv9wSbKU
	aJ9/4sx1uaSDQjUOqUnQSxvch5PWsU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710515482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=78TR34U5VWAH29V7dkyQ9/7DB1o6EuQGdaeyEZaLyz0=;
	b=1wG3RQpBRTZKs0wa5r+/ySSqWU0D8iArs6naDYv68AvLTWLzwcI6h4c06gCJTqDJeVTjr/
	PZX4+r07cLAblfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 939861368C;
	Fri, 15 Mar 2024 15:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0gwHJBpl9GWJTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 15:11:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 52FACA07D9; Fri, 15 Mar 2024 16:11:22 +0100 (CET)
Date: Fri, 15 Mar 2024 16:11:22 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 15/19] bcache: prevent direct access of
 bd_inode
Message-ID: <20240315151122.nofcrvpochxc3h24@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-16-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-16-yukuai1@huaweicloud.com>
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Thu 22-02-24 20:45:51, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all bcache stash the file of opened bdev, it's ok to get
> mapping from the file.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/md/bcache/super.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 4153c9ddbe0b..ec9efa79d5a8 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -163,15 +163,16 @@ static const char *read_super_common(struct cache_sb *sb,  struct block_device *
>  }
>  
>  
> -static const char *read_super(struct cache_sb *sb, struct block_device *bdev,
> +static const char *read_super(struct cache_sb *sb, struct file *bdev_file,
>  			      struct cache_sb_disk **res)
>  {
>  	const char *err;
> +	struct block_device *bdev = file_bdev(bdev_file);
>  	struct cache_sb_disk *s;
>  	struct page *page;
>  	unsigned int i;
>  
> -	page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
> +	page = read_cache_page_gfp(bdev_file->f_mapping,
>  				   SB_OFFSET >> PAGE_SHIFT, GFP_KERNEL);
>  	if (IS_ERR(page))
>  		return "IO error";
> @@ -2564,7 +2565,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
>  	if (set_blocksize(file_bdev(bdev_file), 4096))
>  		goto out_blkdev_put;
>  
> -	err = read_super(sb, file_bdev(bdev_file), &sb_disk);
> +	err = read_super(sb, bdev_file, &sb_disk);
>  	if (err)
>  		goto out_blkdev_put;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

