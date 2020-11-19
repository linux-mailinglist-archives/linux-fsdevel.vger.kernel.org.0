Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6922B95A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 16:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgKSO77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:59:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgKSO76 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:59:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 681B7ABD6;
        Thu, 19 Nov 2020 14:59:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 26B541E130B; Thu, 19 Nov 2020 15:59:56 +0100 (CET)
Date:   Thu, 19 Nov 2020 15:59:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 18/20] fs: remove get_super_thawed and
 get_super_exclusive_thawed
Message-ID: <20201119145956.GA1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118084800.2339180-19-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-11-20 09:47:58, Christoph Hellwig wrote:
> Just open code the wait in the only caller of both functions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

As far as I remember, Al (added to CC) generally objected against exporting
bits from fs/super.c (like put_super(), __get_super()) in the past. FWIW I
also find a dedicated function in fs/super.c somewhat cleaner than
opencoding in quota code but I can live with both...

								Honza

> ---
>  fs/internal.h      |  2 ++
>  fs/quota/quota.c   | 31 +++++++++++++++++++++-------
>  fs/super.c         | 51 ++--------------------------------------------
>  include/linux/fs.h |  4 +---
>  4 files changed, 29 insertions(+), 59 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index a7cd0f64faa4ab..47be21dfeebef5 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -114,7 +114,9 @@ extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
>   */
>  extern int reconfigure_super(struct fs_context *);
>  extern bool trylock_super(struct super_block *sb);
> +struct super_block *__get_super(struct block_device *bdev, bool excl);
>  extern struct super_block *user_get_super(dev_t);
> +void put_super(struct super_block *sb);
>  extern bool mount_capable(struct fs_context *);
>  
>  /*
> diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> index 9af95c7a0bbe3c..f3d32b0d9008f2 100644
> --- a/fs/quota/quota.c
> +++ b/fs/quota/quota.c
> @@ -20,6 +20,7 @@
>  #include <linux/writeback.h>
>  #include <linux/nospec.h>
>  #include "compat.h"
> +#include "../internal.h"
>  
>  static int check_quotactl_permission(struct super_block *sb, int type, int cmd,
>  				     qid_t id)
> @@ -868,6 +869,7 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>  	struct block_device *bdev;
>  	struct super_block *sb;
>  	struct filename *tmp = getname(special);
> +	bool excl = false, thawed = false;
>  
>  	if (IS_ERR(tmp))
>  		return ERR_CAST(tmp);
> @@ -875,17 +877,32 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
>  	putname(tmp);
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
> -	if (quotactl_cmd_onoff(cmd))
> -		sb = get_super_exclusive_thawed(bdev);
> -	else if (quotactl_cmd_write(cmd))
> -		sb = get_super_thawed(bdev);
> -	else
> -		sb = get_super(bdev);
> +
> +	if (quotactl_cmd_onoff(cmd)) {
> +		excl = true;
> +		thawed = true;
> +	} else if (quotactl_cmd_write(cmd)) {
> +		thawed = true;
> +	}
> +
> +retry:
> +	sb = __get_super(bdev, excl);
> +	if (thawed && sb && sb->s_writers.frozen != SB_UNFROZEN) {
> +		if (excl)
> +			up_write(&sb->s_umount);
> +		else
> +			up_read(&sb->s_umount);
> +		wait_event(sb->s_writers.wait_unfrozen,
> +			   sb->s_writers.frozen == SB_UNFROZEN);
> +		put_super(sb);
> +		goto retry;
> +	}
> +
>  	bdput(bdev);
>  	if (!sb)
>  		return ERR_PTR(-ENODEV);
> -
>  	return sb;
> +
>  #else
>  	return ERR_PTR(-ENODEV);
>  #endif
> diff --git a/fs/super.c b/fs/super.c
> index 98bb0629ee108e..343e5c1e538d2a 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -307,7 +307,7 @@ static void __put_super(struct super_block *s)
>   *	Drops a temporary reference, frees superblock if there's no
>   *	references left.
>   */
> -static void put_super(struct super_block *sb)
> +void put_super(struct super_block *sb)
>  {
>  	spin_lock(&sb_lock);
>  	__put_super(sb);
> @@ -740,7 +740,7 @@ void iterate_supers_type(struct file_system_type *type,
>  
>  EXPORT_SYMBOL(iterate_supers_type);
>  
> -static struct super_block *__get_super(struct block_device *bdev, bool excl)
> +struct super_block *__get_super(struct block_device *bdev, bool excl)
>  {
>  	struct super_block *sb;
>  
> @@ -789,53 +789,6 @@ struct super_block *get_super(struct block_device *bdev)
>  }
>  EXPORT_SYMBOL(get_super);
>  
> -static struct super_block *__get_super_thawed(struct block_device *bdev,
> -					      bool excl)
> -{
> -	while (1) {
> -		struct super_block *s = __get_super(bdev, excl);
> -		if (!s || s->s_writers.frozen == SB_UNFROZEN)
> -			return s;
> -		if (!excl)
> -			up_read(&s->s_umount);
> -		else
> -			up_write(&s->s_umount);
> -		wait_event(s->s_writers.wait_unfrozen,
> -			   s->s_writers.frozen == SB_UNFROZEN);
> -		put_super(s);
> -	}
> -}
> -
> -/**
> - *	get_super_thawed - get thawed superblock of a device
> - *	@bdev: device to get the superblock for
> - *
> - *	Scans the superblock list and finds the superblock of the file system
> - *	mounted on the device. The superblock is returned once it is thawed
> - *	(or immediately if it was not frozen). %NULL is returned if no match
> - *	is found.
> - */
> -struct super_block *get_super_thawed(struct block_device *bdev)
> -{
> -	return __get_super_thawed(bdev, false);
> -}
> -EXPORT_SYMBOL(get_super_thawed);
> -
> -/**
> - *	get_super_exclusive_thawed - get thawed superblock of a device
> - *	@bdev: device to get the superblock for
> - *
> - *	Scans the superblock list and finds the superblock of the file system
> - *	mounted on the device. The superblock is returned once it is thawed
> - *	(or immediately if it was not frozen) and s_umount semaphore is held
> - *	in exclusive mode. %NULL is returned if no match is found.
> - */
> -struct super_block *get_super_exclusive_thawed(struct block_device *bdev)
> -{
> -	return __get_super_thawed(bdev, true);
> -}
> -EXPORT_SYMBOL(get_super_exclusive_thawed);
> -
>  /**
>   * get_active_super - get an active reference to the superblock of a device
>   * @bdev: device to get the superblock for
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8667d0cdc71e76..a61df0dd4f1989 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1409,7 +1409,7 @@ enum {
>  
>  struct sb_writers {
>  	int				frozen;		/* Is sb frozen? */
> -	wait_queue_head_t		wait_unfrozen;	/* for get_super_thawed() */
> +	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
>  	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
>  };
>  
> @@ -3132,8 +3132,6 @@ extern struct file_system_type *get_filesystem(struct file_system_type *fs);
>  extern void put_filesystem(struct file_system_type *fs);
>  extern struct file_system_type *get_fs_type(const char *name);
>  extern struct super_block *get_super(struct block_device *);
> -extern struct super_block *get_super_thawed(struct block_device *);
> -extern struct super_block *get_super_exclusive_thawed(struct block_device *bdev);
>  extern struct super_block *get_active_super(struct block_device *bdev);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
