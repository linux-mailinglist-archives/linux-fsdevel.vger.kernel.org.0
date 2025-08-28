Return-Path: <linux-fsdevel+bounces-59476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C65B39988
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5111E7BAC32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917E830C36B;
	Thu, 28 Aug 2025 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tULajMBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2E3093DB;
	Thu, 28 Aug 2025 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376290; cv=none; b=mU+V7fc0CIXxMN5u0eM2Pn844QnI09QbOlUfCo46WWRL8wIAwVn0adrW/aOqNdY4mptDMAOZuR3dfWdILx7IdJ+ygfWmlYrLAGh0c4BogwJ1HHadSbfqCk0HcEW1jb11yqa5G5iSobAAu5hEqppFbHRqE13r5Ja1qedZnxZqqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376290; c=relaxed/simple;
	bh=IrZCAV3PdWuNFsGR7eTCbmhKrE0snUqtzcfOHlYbiAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjd7X5oCbcYZYzr56dl3XL5Ov49XMU8gFh6+mSNKOf/Ikp+Zjkbm2iLwSfrfIakIbSuSFshaOi2uqTtDDHUdb5jAWz1G5UzFBkSjfwRV6T4GZcUT2mHD/zQiSdszYJdw98+Owu8CquQuJea9XiqIt+iV2EVA/nUe3Sh1t7T1Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tULajMBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8946AC4CEEB;
	Thu, 28 Aug 2025 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756376289;
	bh=IrZCAV3PdWuNFsGR7eTCbmhKrE0snUqtzcfOHlYbiAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tULajMBdSGhYNBSXwi73N9CuZt4b+Vdp0+To2kzNYbtrNRBV4Yel3+6yfdSDFURci
	 QEQzr8obPc0y09PXgulSw4l+F+0L54iMLgj5I6Mxj4+SelcjvYqmnujVonBeFjLZuw
	 +9Xi+FTcxdyHRSn8ddCG5zNaPwe3vYqdzg8aDkKiVhqNTTHX1PItZBuEt5S/0+l3zg
	 xqKamDaq3hKFdsaRoneX1cxndFJjNq4h+ElH7xwjvghPJJbOZqg91KT+ehU64S3Udl
	 E76cnzgiouYeYD5abZauTbgKGDSLiIlnrjjHRXrSeryiWj8u+5LOhGZOLYNosBeYZ3
	 VlIhxzyBOrwpg==
Date: Thu, 28 Aug 2025 12:18:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 18/54] fs: change evict_inodes to use iput instead of
 evict directly
Message-ID: <20250828-umgegangen-festbesuch-cd75065a043d@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <2e71234c109ee6a45a469022436cc5c3d31914ed.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e71234c109ee6a45a469022436cc5c3d31914ed.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:18AM -0400, Josef Bacik wrote:
> At evict_inodes() time, we no longer have SB_ACTIVE set, so we can
> easily go through the normal iput path to clear any inodes. Update
> dispose_list() to check how we need to free the inode, and then grab a
> full reference to the inode while we're looping through the remaining
> inodes, and simply iput them at the end.
> 
> Since we're just calling iput we don't really care about the i_count on
> the inode at the current time.  Remove the i_count checks and just call
> iput on every inode we find.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 399598e90693..ede9118bb649 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -933,7 +933,7 @@ static void evict(struct inode *inode)
>   * Dispose-list gets a local list with local inodes in it, so it doesn't
>   * need to worry about list corruption and SMP locks.
>   */
> -static void dispose_list(struct list_head *head)
> +static void dispose_list(struct list_head *head, bool for_lru)
>  {
>  	while (!list_empty(head)) {
>  		struct inode *inode;
> @@ -941,8 +941,12 @@ static void dispose_list(struct list_head *head)
>  		inode = list_first_entry(head, struct inode, i_lru);
>  		list_del_init(&inode->i_lru);
>  
> -		evict(inode);
> -		iobj_put(inode);
> +		if (for_lru) {
> +			evict(inode);
> +			iobj_put(inode);
> +		} else {
> +			iput(inode);
> +		}

I would really like to see a transitionary comment here or at least some
more details in the commit. Something like:

	Once the inode has gone through iput_final() and has ended up on
	the LRU it's inode->i_count will have gone to zero but the LRU
	still holds an inode->i_obj_count reference. So we need to evict
	and put that i_obj_count reference when disposing the collected
	inodes.

	When the inodes have been collected via evict_inodes() e.g, on
	umount() they will now be made to hold a full reference that we
	can simply iput().

	Calling iput() in this case is safe as we no longer have
	SB_ACTIVE set and thus cannot be readded to the LRU.

I think that's easier to follow and better describes the change.

But, there's a wrinkle. It is not guaranteed that at evict_inodes() time
SB_ACTIVE isn't raised anymore. Afaict, both bch2_fs_bdev_mark_dead()
and fs_bdev_mark_dead() will be called with SB_ACTIVE set from the block
layer on device removal. So in that case iput() would add them back to
the LRU.

>  		cond_resched();
>  	}
>  }
> @@ -964,21 +968,13 @@ void evict_inodes(struct super_block *sb)
>  again:
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> -		if (icount_read(inode))
> -			continue;
> -
>  		spin_lock(&inode->i_lock);
> -		if (icount_read(inode)) {
> -			spin_unlock(&inode->i_lock);
> -			continue;
> -		}
>  		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
>  			spin_unlock(&inode->i_lock);
>  			continue;
>  		}
>  
> -		inode->i_state |= I_FREEING;
> -		iobj_get(inode);
> +		__iget(inode);
>  		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		list_add(&inode->i_lru, &dispose);
> @@ -991,13 +987,13 @@ void evict_inodes(struct super_block *sb)
>  		if (need_resched()) {
>  			spin_unlock(&sb->s_inode_list_lock);
>  			cond_resched();
> -			dispose_list(&dispose);
> +			dispose_list(&dispose, false);
>  			goto again;
>  		}
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
>  
> -	dispose_list(&dispose);
> +	dispose_list(&dispose, false);
>  }
>  EXPORT_SYMBOL_GPL(evict_inodes);
>  
> @@ -1108,7 +1104,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  
>  	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
>  				     inode_lru_isolate, &freeable);
> -	dispose_list(&freeable);
> +	dispose_list(&freeable, true);
>  	return freed;
>  }
>  
> -- 
> 2.49.0
> 

