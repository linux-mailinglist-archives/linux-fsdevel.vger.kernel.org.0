Return-Path: <linux-fsdevel+bounces-14462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C303287CEFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7641A2844FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379B3CF6D;
	Fri, 15 Mar 2024 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UDQsn2YP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gy+2/So2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lubee7FV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BYlsoznr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177C3C464;
	Fri, 15 Mar 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513103; cv=none; b=QHtctRA480u3c28fewhvnXQX6+rY/hHx2FXX0m4Gtb3HLNpFG20eL63i4mJAT/HavLulit83n/O0Xhy3iUMvHfQKDMdhaX2/1ZUt0BkWNADVpIW1V4jpH3ID5sAlAKLP7PB8LXVIoxlvTEb9kGDWMvooXzRRbYdzkS12AbmzY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513103; c=relaxed/simple;
	bh=z+Mwotlweaa+pybVk/6lgR2k6LNBy2bA0OIwXhuDGAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMYRE+WbdBSSjq31kYZsLdYWt4meUbxsGTF0E9SvpBNOkRwKCmHCYBOOgITfg2ooETTr8vw2UMOlO8EWKZszyhDeh3yI3RgIxIRfkgydXg+DtowhwwcU893JtEtJ6J7xxZrN2+3j3/jo7YGGI9QJD5bEsw0IUqqKBc3el1Stl1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UDQsn2YP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gy+2/So2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lubee7FV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BYlsoznr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE04521CE0;
	Fri, 15 Mar 2024 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XgBsfWN7IrynD21R6+Lt9RxvG8Rnjrd/90fh5jZjAQ=;
	b=UDQsn2YPc1ILWcghjMvFxDDTU3IuBr47YIiPSR6+CS7ByA1llKI/G3UDkCrFB9oFGcctUB
	thF1LBKfzcdsVRZVa/ZCxSYNh1XrdKk2PA/rYRG54+Ff5AiR7JQffK0QxIeRI1uHiwpBKl
	HEVwlhRHIrvq5vQiVsac6yRzG7loiLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XgBsfWN7IrynD21R6+Lt9RxvG8Rnjrd/90fh5jZjAQ=;
	b=gy+2/So2RDe3HP++q4B2y8vXmuE4ogSP1iAEh4tfmfsCr4FaJ72yXbRlv/7rk4lkYxAe6P
	IIip1BGNJiugiHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XgBsfWN7IrynD21R6+Lt9RxvG8Rnjrd/90fh5jZjAQ=;
	b=Lubee7FVmBslC0BLr4il9SaO3RnHoNgL/R+YuGJ/JMeww5TbkrJk22KYwrCdexfj2py0h3
	ONKVv+dMjME97Z6UszNKRnbOruRNOP+VmuAGB8r4rvPk0yysYxH5k4vcufkl3uXaW5XQXB
	m8sXDlrjkxP2k1IJPh20HiuUhSKjXu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XgBsfWN7IrynD21R6+Lt9RxvG8Rnjrd/90fh5jZjAQ=;
	b=BYlsoznrZFe8o+eee381BFBpNyPDhFTZqJZl/rFOJVerhic9IZ9i0Y6SG79aEmKUNBY6F1
	lg9dzOfh2f5JgGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2A5913460;
	Fri, 15 Mar 2024 14:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QQpjM8tb9GVVQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:31:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C586A07D9; Fri, 15 Mar 2024 15:31:35 +0100 (CET)
Date: Fri, 15 Mar 2024 15:31:35 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 01/19] block: move two helpers into bdev.c
Message-ID: <20240315143135.qnpw772rtys35now@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-2-yukuai1@huaweicloud.com>
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
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 22-02-24 20:45:37, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> disk_live() and block_size() access bd_inode directly, prepare to remove
> the field bd_inode from block_device, and only access bd_inode in block
> layer.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c           | 12 ++++++++++++
>  include/linux/blkdev.h | 12 ++----------
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 140093c99bdc..726a2805a1ce 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1196,6 +1196,18 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  	blkdev_put_no_open(bdev);
>  }
>  
> +bool disk_live(struct gendisk *disk)
> +{
> +	return !inode_unhashed(disk->part0->bd_inode);
> +}
> +EXPORT_SYMBOL_GPL(disk_live);
> +
> +unsigned int block_size(struct block_device *bdev)
> +{
> +	return 1 << bdev->bd_inode->i_blkbits;
> +}
> +EXPORT_SYMBOL_GPL(block_size);
> +
>  static int __init setup_bdev_allow_write_mounted(char *str)
>  {
>  	if (kstrtobool(str, &bdev_allow_write_mounted))
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 06e854186947..eb1f6eeaddc5 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -211,11 +211,6 @@ struct gendisk {
>  	struct blk_independent_access_ranges *ia_ranges;
>  };
>  
> -static inline bool disk_live(struct gendisk *disk)
> -{
> -	return !inode_unhashed(disk->part0->bd_inode);
> -}
> -
>  /**
>   * disk_openers - returns how many openers are there for a disk
>   * @disk: disk to check
> @@ -1359,11 +1354,6 @@ static inline unsigned int blksize_bits(unsigned int size)
>  	return order_base_2(size >> SECTOR_SHIFT) + SECTOR_SHIFT;
>  }
>  
> -static inline unsigned int block_size(struct block_device *bdev)
> -{
> -	return 1 << bdev->bd_inode->i_blkbits;
> -}
> -
>  int kblockd_schedule_work(struct work_struct *work);
>  int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
>  
> @@ -1531,6 +1521,8 @@ void blkdev_put_no_open(struct block_device *bdev);
>  
>  struct block_device *I_BDEV(struct inode *inode);
>  struct block_device *file_bdev(struct file *bdev_file);
> +bool disk_live(struct gendisk *disk);
> +unsigned int block_size(struct block_device *bdev);
>  
>  #ifdef CONFIG_BLOCK
>  void invalidate_bdev(struct block_device *bdev);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

