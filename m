Return-Path: <linux-fsdevel+bounces-58983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F6B33AA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E8C3B21A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7F2C08CD;
	Mon, 25 Aug 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0AemYYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAF262FC1;
	Mon, 25 Aug 2025 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113612; cv=none; b=VMrrsNGtqkaVF9MWaTLL82kVFzODBXX5FlI9jLzojX90Stfsg0Y2tsXffTFEa0+55bCiu8JTqi0iA6HGz8fugq2aqDIlJPZ33j/wPyJ6KAXOF3DylxWOsvEha8F+TS5ISul8M5QbMfdAmgmbNGIPnuApciE9ID18P0/sLhXRbjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113612; c=relaxed/simple;
	bh=YM4gPNHWwpKmZ/tfcDO7SmhM7k8s6x2Ncn3uEarRtDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emvCZB9SnsocxQ7gqIicQ5A9axe4bK467ZO+2pDz7WmMCR8tSmd4Nw8MzkixiaJekx6QOIhTsnW3h7Wz4ErHf8sBbfqpA3tBJkmeBGqsAWEtyoNlHHwXLxs6Yyg0KnTC3uBabXdbs2J3nsk2GaugTh8PJ9Aqcaz+yc+8mHbijzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0AemYYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D88C116B1;
	Mon, 25 Aug 2025 09:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756113612;
	bh=YM4gPNHWwpKmZ/tfcDO7SmhM7k8s6x2Ncn3uEarRtDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0AemYYQ1/KIqIKc5ihinz9NLpkJMD+1gWqoFWb+kcJzWO/0bnsVuGimSFir7LnDf
	 Ff+f8a1FoJ2a0BEIp/p5bA+2MRLuDX3UuV0vkELOy90ln9FNy3TJm0Ird5tFvbvTBc
	 3HN0ZblmNrgIvzTTPn+ZjYpgafTQdvnf1lrhpMWcRUwwT41iJAfPW+YWhK0XoSbeav
	 C5SkIFTdn6nKVaML+ZDWP6Pv02vEVxBNJfEcLcPNGuFoj7rwc5AVH5X4gaODVyJwk1
	 zp2mQlDx92gp44XqZcOpjFEl8C89a6aoZis6gGpfqp628Y0m4xB8r2AOfQ6zYCBX39
	 gx05o75fQcFkQ==
Date: Mon, 25 Aug 2025 11:20:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 17/50] fs: hold a full ref while the inode is on a LRU
Message-ID: <20250825-affekt-ruckartig-e7da04294931@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <113ec167162bbaccc02fa3c3bf1a2c7d3e5a3e82.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <113ec167162bbaccc02fa3c3bf1a2c7d3e5a3e82.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:28PM -0400, Josef Bacik wrote:
> We want to eliminate 0 refcount inodes that can be used. To that end,
> make the LRU's hold a full reference on the inode while it is on an LRU
> list. From there we can change the eviction code to always just iput the
> inode, and the LRU operations will just add or drop a full reference
> where appropriate.
> 
> We also now must take into account unlink, and drop our LRU reference
> when we go to an nlink of 0.  We will also avoid adding inodes with a
> nlink of 0 as they can be reclaimed immediately.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 105 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 57 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 80ad327746a7..de0ec791f9a3 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -434,8 +434,18 @@ void drop_nlink(struct inode *inode)
>  {
>  	WARN_ON(inode->i_nlink == 0);
>  	inode->__i_nlink--;
> -	if (!inode->i_nlink)
> +	if (!inode->i_nlink) {
> +		/*
> +		 * LRU's hold a full ref on the inode, but if we've unlinked it
> +		 * then we want the inode to be freed when the last user goes,
> +		 * so delete the inode from the LRU list.
> +		 */
> +		spin_lock(&inode->i_lock);
> +		inode_lru_list_del(inode);
> +		spin_unlock(&inode->i_lock);
> +
>  		atomic_long_inc(&inode->i_sb->s_remove_count);
> +	}

As written this doesn't work because you can have callers that have
already acquired inode->i_lock(). For example, afs:

        new_inode = d_inode(new_dentry);
        if (new_inode) {
                spin_lock(&new_inode->i_lock);
                if (S_ISDIR(new_inode->i_mode))
                        clear_nlink(new_inode);
                else if (new_inode->i_nlink > 0)
                        drop_nlink(new_inode);
                spin_unlock(&new_inode->i_lock);
        }

>  }
>  EXPORT_SYMBOL(drop_nlink);
>  
> @@ -451,6 +461,12 @@ void clear_nlink(struct inode *inode)
>  {
>  	if (inode->i_nlink) {
>  		inode->__i_nlink = 0;
> +
> +		/* See comment in drop_nlink(). */
> +		spin_lock(&inode->i_lock);
> +		inode_lru_list_del(inode);
> +		spin_unlock(&inode->i_lock);
> +
>  		atomic_long_inc(&inode->i_sb->s_remove_count);
>  	}
>  }
> @@ -555,6 +571,8 @@ static void inode_add_cached_lru(struct inode *inode)
>  
>  	if (inode->i_state & I_CACHED_LRU)
>  		return;
> +	if (inode->__i_nlink == 0)
> +		return;
>  	if (!list_empty(&inode->i_lru))
>  		return;
>  
> @@ -562,7 +580,7 @@ static void inode_add_cached_lru(struct inode *inode)
>  	spin_lock(&inode->i_sb->s_cached_inodes_lock);
>  	list_add(&inode->i_lru, &inode->i_sb->s_cached_inodes);
>  	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
> -	iobj_get(inode);
> +	__iget(inode);
>  }
>  
>  static bool __inode_del_cached_lru(struct inode *inode)
> @@ -582,7 +600,7 @@ static bool __inode_del_cached_lru(struct inode *inode)
>  static bool inode_del_cached_lru(struct inode *inode)
>  {
>  	if (__inode_del_cached_lru(inode)) {
> -		iobj_put(inode);
> +		iput(inode);
>  		return true;
>  	}
>  	return false;
> @@ -598,6 +616,8 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  		return;
>  	if (atomic_read(&inode->i_count))
>  		return;
> +	if (inode->__i_nlink == 0)
> +		return;
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE))
>  		return;
>  	if (inode_needs_cached(inode)) {
> @@ -609,7 +629,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
>  		inode->i_state |= I_LRU;
>  		if (need_ref)
> -			iobj_get(inode);
> +			__iget(inode);
>  		this_cpu_inc(nr_unused);
>  	} else if (rotate) {
>  		inode->i_state |= I_REFERENCED;
> @@ -655,7 +675,7 @@ void inode_lru_list_del(struct inode *inode)
>  
>  	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
>  		inode->i_state &= ~I_LRU;
> -		iobj_put(inode);
> +		iput(inode);
>  		this_cpu_dec(nr_unused);
>  	}
>  }
> @@ -926,6 +946,7 @@ static void evict(struct inode *inode)
>  	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
>  }
>  
> +static void iput_evict(struct inode *inode);
>  /*
>   * dispose_list - dispose of the contents of a local list
>   * @head: the head of the list to free
> @@ -933,20 +954,14 @@ static void evict(struct inode *inode)
>   * Dispose-list gets a local list with local inodes in it, so it doesn't
>   * need to worry about list corruption and SMP locks.
>   */
> -static void dispose_list(struct list_head *head, bool for_lru)
> +static void dispose_list(struct list_head *head)
>  {
>  	while (!list_empty(head)) {
>  		struct inode *inode;
>  
>  		inode = list_first_entry(head, struct inode, i_lru);
>  		list_del_init(&inode->i_lru);
> -
> -		if (for_lru) {
> -			evict(inode);
> -			iobj_put(inode);
> -		} else {
> -			iput(inode);
> -		}
> +		iput_evict(inode);
>  		cond_resched();
>  	}
>  }
> @@ -987,13 +1002,13 @@ void evict_inodes(struct super_block *sb)
>  		if (need_resched()) {
>  			spin_unlock(&sb->s_inode_list_lock);
>  			cond_resched();
> -			dispose_list(&dispose, false);
> +			dispose_list(&dispose);
>  			goto again;
>  		}
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
>  
> -	dispose_list(&dispose, false);
> +	dispose_list(&dispose);
>  }
>  EXPORT_SYMBOL_GPL(evict_inodes);
>  
> @@ -1031,22 +1046,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	if (inode_needs_cached(inode)) {
>  		list_lru_isolate(lru, &inode->i_lru);
>  		inode_add_cached_lru(inode);
> -		iobj_put(inode);
> -		spin_unlock(&inode->i_lock);
> -		this_cpu_dec(nr_unused);
> -		return LRU_REMOVED;
> -	}
> -
> -	/*
> -	 * Inodes can get referenced, redirtied, or repopulated while
> -	 * they're already on the LRU, and this can make them
> -	 * unreclaimable for a while. Remove them lazily here; iput,
> -	 * sync, or the last page cache deletion will requeue them.
> -	 */
> -	if (atomic_read(&inode->i_count) ||
> -	    (inode->i_state & ~I_REFERENCED)) {
> -		list_lru_isolate(lru, &inode->i_lru);
> -		inode->i_state &= ~I_LRU;
> +		iput(inode);
>  		spin_unlock(&inode->i_lock);
>  		this_cpu_dec(nr_unused);
>  		return LRU_REMOVED;
> @@ -1082,7 +1082,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	}
>  
>  	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state |= I_FREEING;
>  	inode->i_state &= ~I_LRU;
>  	list_lru_isolate_move(lru, &inode->i_lru, freeable);
>  	spin_unlock(&inode->i_lock);
> @@ -1104,7 +1103,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  
>  	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
>  				     inode_lru_isolate, &freeable);
> -	dispose_list(&freeable, true);
> +	dispose_list(&freeable);
>  	return freed;
>  }
>  
> @@ -1967,7 +1966,7 @@ EXPORT_SYMBOL(generic_delete_inode);
>   * in cache if fs is alive, sync and evict if fs is
>   * shutting down.
>   */
> -static void iput_final(struct inode *inode)
> +static void iput_final(struct inode *inode, bool skip_lru)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	const struct super_operations *op = inode->i_sb->s_op;
> @@ -1981,7 +1980,7 @@ static void iput_final(struct inode *inode)
>  	else
>  		drop = generic_drop_inode(inode);
>  
> -	if (!drop &&
> +	if (!drop && !skip_lru &&
>  	    !(inode->i_state & I_DONTCACHE) &&
>  	    (sb->s_flags & SB_ACTIVE)) {
>  		__inode_add_lru(inode, true);
> @@ -1989,6 +1988,8 @@ static void iput_final(struct inode *inode)
>  		return;
>  	}
>  
> +	WARN_ON(!list_empty(&inode->i_lru));
> +
>  	state = inode->i_state;
>  	if (!drop) {
>  		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> @@ -2003,23 +2004,12 @@ static void iput_final(struct inode *inode)
>  	}
>  
>  	WRITE_ONCE(inode->i_state, state | I_FREEING);
> -	if (!list_empty(&inode->i_lru))
> -		inode_lru_list_del(inode);
>  	spin_unlock(&inode->i_lock);
>  
>  	evict(inode);
>  }
>  
> -/**
> - *	iput	- put an inode
> - *	@inode: inode to put
> - *
> - *	Puts an inode, dropping its usage count. If the inode use count hits
> - *	zero, the inode is then freed and may also be destroyed.
> - *
> - *	Consequently, iput() can sleep.
> - */
> -void iput(struct inode *inode)
> +static void __iput(struct inode *inode, bool skip_lru)
>  {
>  	if (!inode)
>  		return;
> @@ -2037,12 +2027,31 @@ void iput(struct inode *inode)
>  
>  	spin_lock(&inode->i_lock);
>  	if (atomic_dec_and_test(&inode->i_count))
> -		iput_final(inode);
> +		iput_final(inode, skip_lru);
>  	else
>  		spin_unlock(&inode->i_lock);
>  
>  	iobj_put(inode);
>  }
> +
> +static void iput_evict(struct inode *inode)
> +{
> +	__iput(inode, true);
> +}
> +
> +/**
> + *	iput	- put an inode
> + *	@inode: inode to put
> + *
> + *	Puts an inode, dropping its usage count. If the inode use count hits
> + *	zero, the inode is then freed and may also be destroyed.
> + *
> + *	Consequently, iput() can sleep.
> + */
> +void iput(struct inode *inode)
> +{
> +	__iput(inode, false);
> +}
>  EXPORT_SYMBOL(iput);
>  
>  /**
> -- 
> 2.49.0
> 

