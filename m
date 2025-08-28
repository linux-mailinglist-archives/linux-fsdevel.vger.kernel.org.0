Return-Path: <linux-fsdevel+bounces-59479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074DCB39AAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9242164873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E030DD19;
	Thu, 28 Aug 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0PBrRAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DD2C21CF;
	Thu, 28 Aug 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378298; cv=none; b=Xxt6vcSm7tJs+I//8BU9iygoY6P0+81Pt6jIWFs426v07fk/aeqP7bHgsgHpI1v5VMEiANkk8pibDAQSAbRENFlYZnQ9FLic09yKWVzHKGp6ZWgtP4QS7TyVv9H1hedErP1Bs2Tp/9AdDYGc+Xg8sSYFfBQ0L/HwnbTDb+dQaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378298; c=relaxed/simple;
	bh=g80NSokOKzbDphxTK5RFEycB5nQciSZPx4OtF6fh1bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epCJPksUdaIhHo5B6p9BA8cpSN33UzrjLNDuzYATrKWHBYv0HhUcRg09BNJJflzHuqGyutn4RwRz1k+ZGX2rlVku/3ykCYXqq9pQ30i01lw/92F2YsWKAdYH1Ol+z8GCob3lKRCfmgkM5cSSUDmYN0SPGhqJ4cF029To7nHvljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0PBrRAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4CEC4CEEB;
	Thu, 28 Aug 2025 10:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756378297;
	bh=g80NSokOKzbDphxTK5RFEycB5nQciSZPx4OtF6fh1bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0PBrRAKfAfhZUbkjO+zjwt2GictTrYHIIl5MO0ZdeKJmde4jXFN01Acf0x+ME4/v
	 S3Giw28MJSFlIadnXOax1vus07qKvqj852P3Pu5LG3cf5YRfH49grzw8rDwGmhwGx7
	 oiIWP7IYsPEe9QqyZhYlAIP6nCIlwJVY0e7WDgCTpUNLufSl/EsCFcbKhWSKxgtqpx
	 iiBKwKH4DXQzHMxkEY90qZOoI+q8kiLd3+YDpugKKdThUurlwOqUMtAZP6ncJ8D4Yj
	 nJD94ure8w5Z2Bzm6qv+GPBc3CNh7hjB4yGw1FIDpNqWr8IHrvNJqRWKBntFgI3dsQ
	 hFq/Tx8BqizuA==
Date: Thu, 28 Aug 2025 12:51:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 19/54] fs: hold a full ref while the inode is on a LRU
Message-ID: <20250828-bazillus-notaufnahme-e2a95efb4dff@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <7ea665f486c7fba75d44b9d01c5a0151a0ecae73.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ea665f486c7fba75d44b9d01c5a0151a0ecae73.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:19AM -0400, Josef Bacik wrote:
> We want to eliminate 0 refcount inodes that can be used. To that end,
> make the LRU's hold a full reference on the inode while it is on an LRU
> list. From there we can change the eviction code to always just iput the
> inode, and the LRU operations will just add or drop a full reference
> where appropriate.
> 
> We also now must take into account unlink, and avoid adding the inode to
> the LRU if it has an nlink of 0.

It would be good to explain why. I'm pretty sure it's because of the
prior patch in the series that drops the inode from the LRU on
unlink/rmdir and you want to avoid adding it back.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c | 87 +++++++++++++++++++++++++-----------------------------
>  1 file changed, 40 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index ede9118bb649..9001f809add0 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -555,11 +555,13 @@ static void inode_add_cached_lru(struct inode *inode)
>  
>  	if (inode->i_state & I_CACHED_LRU)
>  		return;
> +	if (inode->__i_nlink == 0)
> +		return;
>  	if (!list_empty(&inode->i_lru))
>  		return;
>  
>  	inode->i_state |= I_CACHED_LRU;
> -	iobj_get(inode);
> +	__iget(inode);
>  	spin_lock(&inode->i_sb->s_cached_inodes_lock);
>  	list_add(&inode->i_lru, &inode->i_sb->s_cached_inodes);
>  	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
> @@ -582,7 +584,7 @@ static bool __inode_del_cached_lru(struct inode *inode)
>  static bool inode_del_cached_lru(struct inode *inode)
>  {
>  	if (__inode_del_cached_lru(inode)) {
> -		iobj_put(inode);
> +		iput(inode);
>  		return true;
>  	}
>  	return false;
> @@ -598,6 +600,8 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  		return;
>  	if (icount_read(inode))
>  		return;
> +	if (inode->__i_nlink == 0)
> +		return;
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE))
>  		return;
>  	if (inode_needs_cached(inode)) {
> @@ -609,7 +613,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
>  		inode->i_state |= I_LRU;
>  		if (need_ref)
> -			iobj_get(inode);
> +			__iget(inode);
>  		this_cpu_inc(nr_unused);
>  	} else if (rotate) {
>  		inode->i_state |= I_REFERENCED;
> @@ -655,7 +659,7 @@ void inode_lru_list_del(struct inode *inode)
>  
>  	if (list_lru_del_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
>  		inode->i_state &= ~I_LRU;
> -		iobj_put(inode);
> +		iput(inode);
>  		this_cpu_dec(nr_unused);
>  	}
>  }
> @@ -926,6 +930,7 @@ static void evict(struct inode *inode)
>  	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
>  }
>  
> +static void iput_evict(struct inode *inode);
>  /*
>   * dispose_list - dispose of the contents of a local list
>   * @head: the head of the list to free
> @@ -933,20 +938,14 @@ static void evict(struct inode *inode)
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

Ok, so this allows evict_inodes() to run on an SB_ACTIVE superblock.

>  		cond_resched();
>  	}
>  }
> @@ -987,13 +986,13 @@ void evict_inodes(struct super_block *sb)
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
> @@ -1031,22 +1030,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
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
> -	if (icount_read(inode) ||
> -	    (inode->i_state & ~I_REFERENCED)) {
> -		list_lru_isolate(lru, &inode->i_lru);
> -		inode->i_state &= ~I_LRU;
> +		iput(inode);
>  		spin_unlock(&inode->i_lock);
>  		this_cpu_dec(nr_unused);
>  		return LRU_REMOVED;
> @@ -1082,7 +1066,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	}
>  
>  	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state |= I_FREEING;
>  	inode->i_state &= ~I_LRU;
>  	list_lru_isolate_move(lru, &inode->i_lru, freeable);
>  	spin_unlock(&inode->i_lock);
> @@ -1104,7 +1087,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  
>  	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
>  				     inode_lru_isolate, &freeable);
> -	dispose_list(&freeable, true);
> +	dispose_list(&freeable);
>  	return freed;
>  }
>  
> @@ -1967,7 +1950,7 @@ EXPORT_SYMBOL(generic_delete_inode);
>   * in cache if fs is alive, sync and evict if fs is
>   * shutting down.
>   */
> -static void iput_final(struct inode *inode)
> +static void iput_final(struct inode *inode, bool skip_lru)
>  {
>  	struct super_block *sb = inode->i_sb;
>  	const struct super_operations *op = inode->i_sb->s_op;
> @@ -1981,7 +1964,7 @@ static void iput_final(struct inode *inode)
>  	else
>  		drop = generic_drop_inode(inode);
>  
> -	if (!drop &&
> +	if (!drop && !skip_lru &&
>  	    !(inode->i_state & I_DONTCACHE) &&
>  	    (sb->s_flags & SB_ACTIVE)) {
>  		__inode_add_lru(inode, true);
> @@ -1989,6 +1972,8 @@ static void iput_final(struct inode *inode)
>  		return;
>  	}
>  
> +	WARN_ON(!list_empty(&inode->i_lru));
> +
>  	state = inode->i_state;
>  	if (!drop) {
>  		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
> @@ -2003,23 +1988,12 @@ static void iput_final(struct inode *inode)
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
> @@ -2038,12 +2012,31 @@ void iput(struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	if (atomic_dec_and_test(&inode->i_count)) {
>  		/* iput_final() drops i_lock */
> -		iput_final(inode);
> +		iput_final(inode, skip_lru);
>  	} else {
>  		spin_unlock(&inode->i_lock);
>  	}
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

