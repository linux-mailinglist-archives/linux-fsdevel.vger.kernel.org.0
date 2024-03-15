Return-Path: <linux-fsdevel+bounces-14467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689987CF4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762101C20AFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2B45BE2;
	Fri, 15 Mar 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4jc7nzk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vjykzb5/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wKYhUCsO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZ+ePpmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543E40BE3;
	Fri, 15 Mar 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513901; cv=none; b=KE7AKdNDkuwjlZ9+hu84FwbmPdR2NJui2k+fKrxjAEbS2tsgKEt6eYF+Da+NUbTNZKpQEHP4tzwsCFbCLvQUu9SWhF0w6z3L3PFkDQBigwBo4xMLlTyVCNCYJfKFI5LyrcqC5IfPhODAau+Iq7FaLGMfxGQx9wb+25XOaRWGJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513901; c=relaxed/simple;
	bh=RE4yhONF3vXHweDxFAryUXZTPXqQrRz5Y+twp45lWwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0D82Q3m3tq3DpwUGFY25E2Bf6VN3N/VjY4+1mZv/Ewa2bacLl/6CdceGdv4Rw9liKtBnHsIs0bpcZJhFdGuC5/mGcmxkxxY9cVPIA72nlGA4Tdpy4rA/64GctUrm20Q2xrBxlpFYS9/SAniCzkn2aZ0B9DaH+9RLTjqbmnKbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4jc7nzk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vjykzb5/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wKYhUCsO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iZ+ePpmT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1F831FB67;
	Fri, 15 Mar 2024 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL4cJfwJ8KqwVJq/pXpLitKtTDaCpaePXd+BYgtvQBo=;
	b=h4jc7nzkA486G48msvkp33WF3vnBZZVEt7y5geYE8gGHMV3PUq49XumAxvHsOeZ1sdPxbm
	4LCmK5df0wo9yZUjpAeYpI7i1fCxtYcxMiYfKR99Elq75CovuVBQa3MFIdNif4Wfc6yovS
	4BOMEh9h7Mr8MSRincQtsHXRXuZtxMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL4cJfwJ8KqwVJq/pXpLitKtTDaCpaePXd+BYgtvQBo=;
	b=vjykzb5/aDXA2s4JQy+MuaV75nqpVwUzBcolUHai9prAWJnnKx/drVFnzoaMRqx81oXYXa
	mResqrZc6s16ijDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL4cJfwJ8KqwVJq/pXpLitKtTDaCpaePXd+BYgtvQBo=;
	b=wKYhUCsOxu2fKB/1KEbqwt5imXebGeE9aa8/p1K+BwFMZ9Oa91bdAZ1PNRuc2osxqIEJZk
	B9EAxZx8n8BDmrzyfMTsAhRD1M1K1s25ZqRygF9tJau72cmrFz7jbkQucO/x5wGNl2wwfL
	cUTggrTW8EIVFMfjSN69RAVqHmEmpew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL4cJfwJ8KqwVJq/pXpLitKtTDaCpaePXd+BYgtvQBo=;
	b=iZ+ePpmTW8aMQ137EzpMisjZngGBpTeviRjYCCp2yEU8ZLQSX1gcOCBk7YCfc3ms4V20gO
	HfFyak/OFoYvaZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4B9C1368C;
	Fri, 15 Mar 2024 14:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKQDMOhe9GWeRAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:44:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81355A07D9; Fri, 15 Mar 2024 15:44:48 +0100 (CET)
Date: Fri, 15 Mar 2024 15:44:48 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 04/19] block: prevent direct access of
 bd_inode
Message-ID: <20240315144448.lxfiebfs2cxckrjc@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-5-yukuai1@huaweicloud.com>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Thu 22-02-24 20:45:40, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Add helpers to access bd_inode, prepare to remove the field 'bd_inode'
> after removing all the access from filesystems and drivers.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c            | 58 +++++++++++++++++++++++++++--------------
>  block/blk-zoned.c       |  4 +--
>  block/blk.h             |  2 ++
>  block/fops.c            |  2 +-
>  block/genhd.c           |  9 ++++---
>  block/ioctl.c           |  8 +++---
>  block/partitions/core.c |  8 +++---
>  7 files changed, 56 insertions(+), 35 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index e493d5c72edb..60a1479eae83 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -43,6 +43,21 @@ static inline struct bdev_inode *BDEV_I(struct inode *inode)
>  	return container_of(inode, struct bdev_inode, vfs_inode);
>  }
>  
> +static inline struct bdev_inode *BDEV_B(struct block_device *bdev)
> +{
> +	return container_of(bdev, struct bdev_inode, bdev);
> +}
> +
> +struct inode *bdev_inode(struct block_device *bdev)
> +{
> +	return &BDEV_B(bdev)->vfs_inode;
> +}
> +
> +struct address_space *bdev_mapping(struct block_device *bdev)
> +{
> +	return BDEV_B(bdev)->vfs_inode.i_mapping;
> +}
> +
>  struct block_device *I_BDEV(struct inode *inode)
>  {
>  	return &BDEV_I(inode)->bdev;
> @@ -57,7 +72,7 @@ EXPORT_SYMBOL(file_bdev);
>  
>  static void bdev_write_inode(struct block_device *bdev)
>  {
> -	struct inode *inode = bdev->bd_inode;
> +	struct inode *inode = bdev_inode(bdev);
>  	int ret;
>  
>  	spin_lock(&inode->i_lock);
> @@ -76,7 +91,7 @@ static void bdev_write_inode(struct block_device *bdev)
>  /* Kill _all_ buffers and pagecache , dirty or not.. */
>  static void kill_bdev(struct block_device *bdev)
>  {
> -	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = bdev_mapping(bdev);
>  
>  	if (mapping_empty(mapping))
>  		return;
> @@ -88,7 +103,7 @@ static void kill_bdev(struct block_device *bdev)
>  /* Invalidate clean unused buffers and pagecache. */
>  void invalidate_bdev(struct block_device *bdev)
>  {
> -	struct address_space *mapping = bdev->bd_inode->i_mapping;
> +	struct address_space *mapping = bdev_mapping(bdev);
>  
>  	if (mapping->nrpages) {
>  		invalidate_bh_lrus();
> @@ -116,7 +131,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>  			goto invalidate;
>  	}
>  
> -	truncate_inode_pages_range(bdev->bd_inode->i_mapping, lstart, lend);
> +	truncate_inode_pages_range(bdev_mapping(bdev), lstart, lend);
>  	if (!(mode & BLK_OPEN_EXCL))
>  		bd_abort_claiming(bdev, truncate_bdev_range);
>  	return 0;
> @@ -126,7 +141,7 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>  	 * Someone else has handle exclusively open. Try invalidating instead.
>  	 * The 'end' argument is inclusive so the rounding is safe.
>  	 */
> -	return invalidate_inode_pages2_range(bdev->bd_inode->i_mapping,
> +	return invalidate_inode_pages2_range(bdev_mapping(bdev),
>  					     lstart >> PAGE_SHIFT,
>  					     lend >> PAGE_SHIFT);
>  }
> @@ -134,14 +149,14 @@ int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>  static void set_init_blocksize(struct block_device *bdev)
>  {
>  	unsigned int bsize = bdev_logical_block_size(bdev);
> -	loff_t size = i_size_read(bdev->bd_inode);
> +	loff_t size = i_size_read(bdev_inode(bdev));
>  
>  	while (bsize < PAGE_SIZE) {
>  		if (size & bsize)
>  			break;
>  		bsize <<= 1;
>  	}
> -	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
> +	bdev_inode(bdev)->i_blkbits = blksize_bits(bsize);
>  }
>  
>  int set_blocksize(struct block_device *bdev, int size)
> @@ -155,9 +170,9 @@ int set_blocksize(struct block_device *bdev, int size)
>  		return -EINVAL;
>  
>  	/* Don't change the size if it is same as current */
> -	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
> +	if (bdev_inode(bdev)->i_blkbits != blksize_bits(size)) {
>  		sync_blockdev(bdev);
> -		bdev->bd_inode->i_blkbits = blksize_bits(size);
> +		bdev_inode(bdev)->i_blkbits = blksize_bits(size);
>  		kill_bdev(bdev);
>  	}
>  	return 0;
> @@ -196,7 +211,7 @@ int sync_blockdev(struct block_device *bdev)
>  {
>  	if (!bdev)
>  		return 0;
> -	return filemap_write_and_wait(bdev->bd_inode->i_mapping);
> +	return filemap_write_and_wait(bdev_mapping(bdev));
>  }
>  EXPORT_SYMBOL(sync_blockdev);
>  
> @@ -415,19 +430,22 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
>  {
>  	spin_lock(&bdev->bd_size_lock);
> -	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
> +	i_size_write(bdev_inode(bdev), (loff_t)sectors << SECTOR_SHIFT);
>  	bdev->bd_nr_sectors = sectors;
>  	spin_unlock(&bdev->bd_size_lock);
>  }
>  
>  void bdev_add(struct block_device *bdev, dev_t dev)
>  {
> +	struct inode *inode;
> +
>  	if (bdev_stable_writes(bdev))
> -		mapping_set_stable_writes(bdev->bd_inode->i_mapping);
> +		mapping_set_stable_writes(bdev_mapping(bdev));
>  	bdev->bd_dev = dev;
> -	bdev->bd_inode->i_rdev = dev;
> -	bdev->bd_inode->i_ino = dev;
> -	insert_inode_hash(bdev->bd_inode);
> +	inode = bdev_inode(bdev);
> +	inode->i_rdev = dev;
> +	inode->i_ino = dev;
> +	insert_inode_hash(inode);
>  }
>  
>  long nr_blockdev_pages(void)
> @@ -885,7 +903,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
>  	bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
>  	if (bdev_nowait(bdev))
>  		bdev_file->f_mode |= FMODE_NOWAIT;
> -	bdev_file->f_mapping = bdev->bd_inode->i_mapping;
> +	bdev_file->f_mapping = bdev_mapping(bdev);
>  	bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
>  	bdev_file->private_data = holder;
>  
> @@ -947,13 +965,13 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		return ERR_PTR(-ENXIO);
>  
>  	flags = blk_to_file_flags(mode);
> -	bdev_file = alloc_file_pseudo_noaccount(bdev->bd_inode,
> +	bdev_file = alloc_file_pseudo_noaccount(bdev_inode(bdev),
>  			blockdev_mnt, "", flags | O_LARGEFILE, &def_blk_fops);
>  	if (IS_ERR(bdev_file)) {
>  		blkdev_put_no_open(bdev);
>  		return bdev_file;
>  	}
> -	ihold(bdev->bd_inode);
> +	ihold(bdev_inode(bdev));
>  
>  	ret = bdev_open(bdev, mode, holder, hops, bdev_file);
>  	if (ret) {
> @@ -1183,13 +1201,13 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  
>  bool disk_live(struct gendisk *disk)
>  {
> -	return !inode_unhashed(disk->part0->bd_inode);
> +	return !inode_unhashed(bdev_inode(disk->part0));
>  }
>  EXPORT_SYMBOL_GPL(disk_live);
>  
>  unsigned int block_size(struct block_device *bdev)
>  {
> -	return 1 << bdev->bd_inode->i_blkbits;
> +	return 1 << bdev_inode(bdev)->i_blkbits;
>  }
>  EXPORT_SYMBOL_GPL(block_size);
>  
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index d4f4f8325eff..ab022d990703 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -399,7 +399,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  		op = REQ_OP_ZONE_RESET;
>  
>  		/* Invalidate the page cache, including dirty pages. */
> -		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
> +		filemap_invalidate_lock(bdev_mapping(bdev));
>  		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
>  		if (ret)
>  			goto fail;
> @@ -421,7 +421,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  
>  fail:
>  	if (cmd == BLKRESETZONE)
> -		filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
> +		filemap_invalidate_unlock(bdev_mapping(bdev));
>  
>  	return ret;
>  }
> diff --git a/block/blk.h b/block/blk.h
> index 72bc8d27cc70..b612538588cb 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -414,6 +414,8 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
>  }
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
> +struct inode *bdev_inode(struct block_device *bdev);
> +struct address_space *bdev_mapping(struct block_device *bdev);
>  struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
>  void bdev_add(struct block_device *bdev, dev_t dev);
>  
> diff --git a/block/fops.c b/block/fops.c
> index f4dcb9dd148d..1fcbdb131a8f 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -666,7 +666,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct block_device *bdev = I_BDEV(file->f_mapping->host);
> -	struct inode *bd_inode = bdev->bd_inode;
> +	struct inode *bd_inode = bdev_inode(bdev);
>  	loff_t size = bdev_nr_bytes(bdev);
>  	size_t shorted = 0;
>  	ssize_t ret;
> diff --git a/block/genhd.c b/block/genhd.c
> index 2f9834bdd14b..4f0f66b4798f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -656,7 +656,7 @@ void del_gendisk(struct gendisk *disk)
>  	 */
>  	mutex_lock(&disk->open_mutex);
>  	xa_for_each(&disk->part_tbl, idx, part)
> -		remove_inode_hash(part->bd_inode);
> +		remove_inode_hash(bdev_inode(part));
>  	mutex_unlock(&disk->open_mutex);
>  
>  	/*
> @@ -745,7 +745,7 @@ void invalidate_disk(struct gendisk *disk)
>  	struct block_device *bdev = disk->part0;
>  
>  	invalidate_bdev(bdev);
> -	bdev->bd_inode->i_mapping->wb_err = 0;
> +	bdev_mapping(bdev)->wb_err = 0;
>  	set_capacity(disk, 0);
>  }
>  EXPORT_SYMBOL(invalidate_disk);
> @@ -1191,7 +1191,8 @@ static void disk_release(struct device *dev)
>  	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
>  		disk->fops->free_disk(disk);
>  
> -	iput(disk->part0->bd_inode);	/* frees the disk */
> +	/* frees the disk */
> +	iput(bdev_inode(disk->part0));
>  }
>  
>  static int block_uevent(const struct device *dev, struct kobj_uevent_env *env)
> @@ -1381,7 +1382,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  out_destroy_part_tbl:
>  	xa_destroy(&disk->part_tbl);
>  	disk->part0->bd_disk = NULL;
> -	iput(disk->part0->bd_inode);
> +	iput(bdev_inode(disk->part0));
>  out_free_bdi:
>  	bdi_put(disk->bdi);
>  out_free_bioset:
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4c8aebee595f..cb5b378cff38 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -90,7 +90,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>  {
>  	uint64_t range[2];
>  	uint64_t start, len;
> -	struct inode *inode = bdev->bd_inode;
> +	struct inode *inode = bdev_inode(bdev);
>  	int err;
>  
>  	if (!(mode & BLK_OPEN_WRITE))
> @@ -144,12 +144,12 @@ static int blk_ioctl_secure_erase(struct block_device *bdev, blk_mode_t mode,
>  	if (start + len > bdev_nr_bytes(bdev))
>  		return -EINVAL;
>  
> -	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
> +	filemap_invalidate_lock(bdev_mapping(bdev));
>  	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
>  	if (!err)
>  		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
>  						GFP_KERNEL);
> -	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
> +	filemap_invalidate_unlock(bdev_mapping(bdev));
>  	return err;
>  }
>  
> @@ -159,7 +159,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
>  {
>  	uint64_t range[2];
>  	uint64_t start, end, len;
> -	struct inode *inode = bdev->bd_inode;
> +	struct inode *inode = bdev_inode(bdev);
>  	int err;
>  
>  	if (!(mode & BLK_OPEN_WRITE))
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 5f5ed5c75f04..6e91a4660588 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -243,7 +243,7 @@ static const struct attribute_group *part_attr_groups[] = {
>  static void part_release(struct device *dev)
>  {
>  	put_disk(dev_to_bdev(dev)->bd_disk);
> -	iput(dev_to_bdev(dev)->bd_inode);
> +	iput(bdev_inode(dev_to_bdev(dev)));
>  }
>  
>  static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
> @@ -480,7 +480,7 @@ int bdev_del_partition(struct gendisk *disk, int partno)
>  	 * Just delete the partition and invalidate it.
>  	 */
>  
> -	remove_inode_hash(part->bd_inode);
> +	remove_inode_hash(bdev_inode(part));
>  	invalidate_bdev(part);
>  	drop_partition(part);
>  	ret = 0;
> @@ -666,7 +666,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate)
>  		 * it cannot be looked up any more even when openers
>  		 * still hold references.
>  		 */
> -		remove_inode_hash(part->bd_inode);
> +		remove_inode_hash(bdev_inode(part));
>  
>  		/*
>  		 * If @disk->open_partitions isn't elevated but there's
> @@ -715,7 +715,7 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
>  
>  void *read_part_sector(struct parsed_partitions *state, sector_t n, Sector *p)
>  {
> -	struct address_space *mapping = state->disk->part0->bd_inode->i_mapping;
> +	struct address_space *mapping = bdev_mapping(state->disk->part0);
>  	struct folio *folio;
>  
>  	if (n >= get_capacity(state->disk)) {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

