Return-Path: <linux-fsdevel+bounces-59495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB90B39DA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B4536822C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804B30FC3E;
	Thu, 28 Aug 2025 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr+RVPEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5920C001;
	Thu, 28 Aug 2025 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385267; cv=none; b=YQN34DwcupMLpj+Mc6Asu9gDwb2G51Xwj7vw4t8k31GmdMQN/9EnkVI4e8ChF8Ob+bZ6ou9HKUWiOtGrvyBehVRM3hiN+6qMJWiuC6rBa+6g9TRNeO5ZdN8beY5grwfarAebrYeoeI3AMS2zsRwaoaHGGs1PaAjUuQpNc7mcpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385267; c=relaxed/simple;
	bh=1wnS3WQ9ntCPs2/KgVbvMQMxVeRuJzqVBkWWnF92Odo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG8aUhY0bPKbX1+cQx2k3HKQqeZJpqbJJppZ8sRffqMcLxJInzn1HMUbH18igCBfb1jfYUTB5kV8U8a51/+6RQJVZZtvq1t+grdVM6G/U95Mm0A/esT63ue2K/VyMDTaWHclskrjkxrg3W7BVQOJH8NGsldyk1F//1bUGhN3+Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr+RVPEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25E8C4CEEB;
	Thu, 28 Aug 2025 12:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756385266;
	bh=1wnS3WQ9ntCPs2/KgVbvMQMxVeRuJzqVBkWWnF92Odo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lr+RVPEN5ycTWf4H6rO43zrA1oGmm1+Rp7NO7Zuf7haDyoXpE0m4LwXJzEtizKkeW
	 VzP888WzbJJpQI0Dnyny5hothhgOBeL3yfoDWPLtm5wMpepdQvepmHqrA3coYyRgpk
	 ArG5SKWWb53k2el3DPlpf5VlEUN4mKtHhH9NQamGnu1vq4WZggZlykA9/EOq5SumVz
	 3Q8Pp4SzSZSxbfks3h8DRhYEnVMH6tR/nnlMvLVHcx8PxsM29TStz5Qos9To5xh6Dh
	 mz5q8hvChhFwZ68NywiX2FKkadk+odPyvDRtN1TNBT3XAS6a6ThTEi755uY06F4fTZ
	 /uZ4+F6lFfHig==
Date: Thu, 28 Aug 2025 14:47:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 52/54] fs: remove I_REFERENCED
Message-ID: <20250828-boomen-jagdrevier-885a71cd5080@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <6e9872dad14133dd05f1142da46d86e456815208.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e9872dad14133dd05f1142da46d86e456815208.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:52AM -0400, Josef Bacik wrote:
> Because we have referenced inodes on the LRU we've had to change the
> behavior to make sure we remove the inode from the LRU when we reference
> it.

All for this patch but I'm confused by this sentence. Maybe:

"Because inodes must hold a full refcount while on the LRU we've had to
change the behavior to make sure we remove the inode from the LRU when
someone takes another full refcount to it."?

Basically, I_REFERENCED was a way to sidestep the problem that if there
was another access to the inode and it was already on the LRU we had to
do something to acknowledge that.

This is now completely put on it's head by just taking them always off
in such cases and afaict we only do that when we take another full
reference (or I guess when it's actually evicted).

> 
> We do this to account for the fact that we may end up with an inode on
> the LRU list, and then unlink the inode. We want the last iput() in the
> unlink() to actually evict the inode ideally, so we don't want it to
> stick around on the LRU and be evicted that way.
> 
> With that behavior change we no longer need I_REFERENCED, as we're
> always removing the inode from the LRU list on a subsequent access if
> it's on the LRU.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/inode.c                       | 36 +++++++-------------------------
>  include/linux/fs.h               | 22 +++++++++----------
>  include/trace/events/writeback.h |  1 -
>  3 files changed, 17 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 8f61761ca021..4f77db7aca75 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -591,7 +591,12 @@ static bool inode_del_cached_lru(struct inode *inode)
>  	return false;
>  }
>  
> -static void __inode_add_lru(struct inode *inode, bool rotate)
> +/*
> + * Add inode to LRU if needed (inode is unused and clean).
> + *
> + * Needs inode->i_lock held.
> + */
> +void inode_add_lru(struct inode *inode)
>  {
>  	bool need_ref = true;
>  
> @@ -614,8 +619,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
>  		if (need_ref)
>  			__iget(inode);
>  		this_cpu_inc(nr_unused);
> -	} else if (rotate) {
> -		inode->i_state |= I_REFERENCED;
>  	}
>  }
>  
> @@ -630,16 +633,6 @@ struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
>  }
>  EXPORT_SYMBOL(inode_bit_waitqueue);
>  
> -/*
> - * Add inode to LRU if needed (inode is unused and clean).
> - *
> - * Needs inode->i_lock held.
> - */
> -void inode_add_lru(struct inode *inode)
> -{
> -	__inode_add_lru(inode, false);
> -}
> -
>  /*
>   * Caller must be holding it's own i_count reference on this inode in order to
>   * prevent this being the final iput.
> @@ -1001,14 +994,6 @@ EXPORT_SYMBOL_GPL(evict_inodes);
>  
>  /*
>   * Isolate the inode from the LRU in preparation for freeing it.
> - *
> - * If the inode has the I_REFERENCED flag set, then it means that it has been
> - * used recently - the flag is set in iput_final(). When we encounter such an
> - * inode, clear the flag and move it to the back of the LRU so it gets another
> - * pass through the LRU before it gets reclaimed. This is necessary because of
> - * the fact we are doing lazy LRU updates to minimise lock contention so the
> - * LRU does not have strict ordering. Hence we don't want to reclaim inodes
> - * with this flag set because they are the inodes that are out of order.
>   */
>  static enum lru_status inode_lru_isolate(struct list_head *item,
>  		struct list_lru_one *lru, void *arg)
> @@ -1039,13 +1024,6 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  		return LRU_REMOVED;
>  	}
>  
> -	/* Recently referenced inodes get one more pass */
> -	if (inode->i_state & I_REFERENCED) {
> -		inode->i_state &= ~I_REFERENCED;
> -		spin_unlock(&inode->i_lock);
> -		return LRU_ROTATE;
> -	}
> -
>  	/*
>  	 * On highmem systems, mapping_shrinkable() permits dropping
>  	 * page cache in order to free up struct inodes: lowmem might
> @@ -1995,7 +1973,7 @@ static bool maybe_add_lru(struct inode *inode, bool skip_lru)
>  	if (!(sb->s_flags & SB_ACTIVE))
>  		return drop;
>  
> -	__inode_add_lru(inode, true);
> +	inode_add_lru(inode);
>  	return drop;
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2a7e7fc96431..39cde53c1b3b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -715,7 +715,6 @@ is_uncached_acl(struct posix_acl *acl)
>   *			address once it is done. The bit is also used to pin
>   *			the inode in memory for flusher thread.
>   *
> - * I_REFERENCED		Marks the inode as recently references on the LRU list.
>   *
>   * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
>   *			synchronize competing switching instances and to tell
> @@ -764,17 +763,16 @@ enum inode_state_flags_t {
>  	I_DIRTY_DATASYNC	= (1U << 4),
>  	I_DIRTY_PAGES		= (1U << 5),
>  	I_CLEAR			= (1U << 6),
> -	I_REFERENCED		= (1U << 7),
> -	I_LINKABLE		= (1U << 8),
> -	I_DIRTY_TIME		= (1U << 9),
> -	I_WB_SWITCH		= (1U << 10),
> -	I_OVL_INUSE		= (1U << 11),
> -	I_CREATING		= (1U << 12),
> -	I_DONTCACHE		= (1U << 13),
> -	I_SYNC_QUEUED		= (1U << 14),
> -	I_PINNING_NETFS_WB	= (1U << 15),
> -	I_LRU			= (1U << 16),
> -	I_CACHED_LRU		= (1U << 17)
> +	I_LINKABLE		= (1U << 7),
> +	I_DIRTY_TIME		= (1U << 8),
> +	I_WB_SWITCH		= (1U << 9),
> +	I_OVL_INUSE		= (1U << 10),
> +	I_CREATING		= (1U << 11),
> +	I_DONTCACHE		= (1U << 12),
> +	I_SYNC_QUEUED		= (1U << 13),
> +	I_PINNING_NETFS_WB	= (1U << 14),
> +	I_LRU			= (1U << 15),
> +	I_CACHED_LRU		= (1U << 16)
>  };
>  
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 58ee61f3d91d..b419b8060dda 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -18,7 +18,6 @@
>  		{I_CLEAR,		"I_CLEAR"},		\
>  		{I_SYNC,		"I_SYNC"},		\
>  		{I_DIRTY_TIME,		"I_DIRTY_TIME"},	\
> -		{I_REFERENCED,		"I_REFERENCED"},	\
>  		{I_LINKABLE,		"I_LINKABLE"},		\
>  		{I_WB_SWITCH,		"I_WB_SWITCH"},		\
>  		{I_OVL_INUSE,		"I_OVL_INUSE"},		\
> -- 
> 2.49.0
> 

