Return-Path: <linux-fsdevel+bounces-14463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36587CF00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA131F2360E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F403B795;
	Fri, 15 Mar 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QKe2N4qi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/yPl0+n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QKe2N4qi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/yPl0+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3053A1A6;
	Fri, 15 Mar 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513262; cv=none; b=mExlqtCktoaXiRjiZ1R1XePMCeTSfl/J/6RRc9HfJQXtEU0PH/QrLWpRK7qqRidqTruukwcib6xC+t+EujWwk88lE9QZjuyufVLfldR/KuwgPnNT3oOstSFb9VTIMA1QQiuODDMhwvshOF2KIgK4+vU8ljoGMCLctcpWi5L/sdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513262; c=relaxed/simple;
	bh=jQa4418iVjNmn3tCPf2miTB10f2xqAu87DCKovmD0qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xy0fBF+3JP180R89EQpyZFRAJjr8AMW8m0Kguk4iYnFzYFKQ5TlKPuATBh2SS3+Yg7unjYaqE+APGaPDR82N6D+uZg41foJeplKjphQW7BMnLrWHVQuORsrqBijquVas/p6NqG8N6BNX5CnHdeetXUohTqNqKyKX5IkUuGL3IgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QKe2N4qi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/yPl0+n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QKe2N4qi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/yPl0+n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03F3421CE0;
	Fri, 15 Mar 2024 14:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTkt8NVmdVnS5ABs+2cgg1QEWbKZqI1u1DolVkbIuwY=;
	b=QKe2N4qi68quofjug1vs0LCH22CbwknMY5nWWaM1ilKE86uHKuKlXxcx8NVPOUVNyFXsPr
	TvGbQFAA65aTkZ+0bineioDvjdNKIIlnxvRKzIGOxvlOkTvGkfUT9xW7zHMxEc8OzB31UD
	oYs1iZw87V5rkM4FfffCUF774w3CgWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTkt8NVmdVnS5ABs+2cgg1QEWbKZqI1u1DolVkbIuwY=;
	b=y/yPl0+nVPN+UrUA3TCNtdLuu8xoKUVhzjnORidyDxggNNDsGBb0BB9pSN4/1R9Lm9UVjb
	emZCGOOUxFdq3aAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710513259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTkt8NVmdVnS5ABs+2cgg1QEWbKZqI1u1DolVkbIuwY=;
	b=QKe2N4qi68quofjug1vs0LCH22CbwknMY5nWWaM1ilKE86uHKuKlXxcx8NVPOUVNyFXsPr
	TvGbQFAA65aTkZ+0bineioDvjdNKIIlnxvRKzIGOxvlOkTvGkfUT9xW7zHMxEc8OzB31UD
	oYs1iZw87V5rkM4FfffCUF774w3CgWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710513259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TTkt8NVmdVnS5ABs+2cgg1QEWbKZqI1u1DolVkbIuwY=;
	b=y/yPl0+nVPN+UrUA3TCNtdLuu8xoKUVhzjnORidyDxggNNDsGBb0BB9pSN4/1R9Lm9UVjb
	emZCGOOUxFdq3aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EECD413460;
	Fri, 15 Mar 2024 14:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7IxLOmpc9GUvQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Mar 2024 14:34:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 98A47A07D9; Fri, 15 Mar 2024 15:34:14 +0100 (CET)
Date: Fri, 15 Mar 2024 15:34:14 +0100
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 02/19] block: remove sync_blockdev_nowait()
Message-ID: <20240315143414.mvhsqld524gclwwg@quack3>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-3-yukuai1@huaweicloud.com>
X-Spam-Score: -4.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QKe2N4qi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="y/yPl0+n"
X-Rspamd-Queue-Id: 03F3421CE0

On Thu 22-02-24 20:45:38, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that all filesystems stash the bdev file, it's ok to flush the file
> mapping directly.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bdev.c           | 8 --------
>  fs/fat/inode.c         | 2 +-
>  fs/ntfs3/inode.c       | 2 +-
>  fs/sync.c              | 9 ++++++---
>  include/linux/blkdev.h | 5 -----
>  5 files changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 726a2805a1ce..49dcff483289 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -188,14 +188,6 @@ int sb_min_blocksize(struct super_block *sb, int size)
>  
>  EXPORT_SYMBOL(sb_min_blocksize);
>  
> -int sync_blockdev_nowait(struct block_device *bdev)
> -{
> -	if (!bdev)
> -		return 0;
> -	return filemap_flush(bdev->bd_inode->i_mapping);
> -}
> -EXPORT_SYMBOL_GPL(sync_blockdev_nowait);
> -
>  /*
>   * Write out and wait upon all the dirty data associated with a block
>   * device via its mapping.  Does not take the superblock lock.
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 5c813696d1ff..8527aef51841 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1945,7 +1945,7 @@ int fat_flush_inodes(struct super_block *sb, struct inode *i1, struct inode *i2)
>  	if (!ret && i2)
>  		ret = writeback_inode(i2);
>  	if (!ret)
> -		ret = sync_blockdev_nowait(sb->s_bdev);
> +		ret = filemap_flush(sb->s_bdev_file->f_mapping);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(fat_flush_inodes);
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index eb7a8c9fba01..3c4c878f6d77 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1081,7 +1081,7 @@ int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
>  	if (!ret && i2)
>  		ret = writeback_inode(i2);
>  	if (!ret)
> -		ret = sync_blockdev_nowait(sb->s_bdev);
> +		ret = filemap_flush(sb->s_bdev_file->f_mapping);
>  	return ret;
>  }
>  
> diff --git a/fs/sync.c b/fs/sync.c
> index dc725914e1ed..3a43062790d9 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -57,9 +57,12 @@ int sync_filesystem(struct super_block *sb)
>  		if (ret)
>  			return ret;
>  	}
> -	ret = sync_blockdev_nowait(sb->s_bdev);
> -	if (ret)
> -		return ret;
> +
> +	if (sb->s_bdev_file) {
> +		ret = filemap_flush(sb->s_bdev_file->f_mapping);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	sync_inodes_sb(sb);
>  	if (sb->s_op->sync_fs) {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index eb1f6eeaddc5..9e96811c8915 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1528,7 +1528,6 @@ unsigned int block_size(struct block_device *bdev);
>  void invalidate_bdev(struct block_device *bdev);
>  int sync_blockdev(struct block_device *bdev);
>  int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
> -int sync_blockdev_nowait(struct block_device *bdev);
>  void sync_bdevs(bool wait);
>  void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
>  void printk_all_partitions(void);
> @@ -1541,10 +1540,6 @@ static inline int sync_blockdev(struct block_device *bdev)
>  {
>  	return 0;
>  }
> -static inline int sync_blockdev_nowait(struct block_device *bdev)
> -{
> -	return 0;
> -}
>  static inline void sync_bdevs(bool wait)
>  {
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

