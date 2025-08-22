Return-Path: <linux-fsdevel+bounces-58830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57959B31D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196621894F89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2E2D47FA;
	Fri, 22 Aug 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICoy1DuH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16878214A91;
	Fri, 22 Aug 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874528; cv=none; b=A2a5qW+D3KAZsOZOuedcmEsiaFrzNcqYncLa9fRf8HlxljLAp7yrYqRAUJ02gO/Fxt6dei1sODz7U9w6DvriLYulcgRImlpOhVNZKNAHuXYBcqX/Efq27938qv4Hqj+S6wXd0l6D4FOq8VjA57V7+4/Za7meiEjjTTh6/mIDJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874528; c=relaxed/simple;
	bh=8gH+a19O/Y6JqE1AA1u8pNQtU1JspAntRf4MSzxY3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f17PLTmPs6NBOZ/CyqC1OBJtuC6V9qY9ailZz+crl4Fa7PvfRTNy+4VIQ1DIuM6CP6hEk9tZ0NUgRmP/H2rc0pnN4ghz+K+ZmUoIvulonfeQ6Xny78O7xH63f7GjJcM6X24fQqYMOZgQrHzimOh7FfrmkcxYLy5J7Vb/EgTRtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICoy1DuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36982C4CEED;
	Fri, 22 Aug 2025 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755874527;
	bh=8gH+a19O/Y6JqE1AA1u8pNQtU1JspAntRf4MSzxY3W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICoy1DuHAj6UI3CiZefiI6whmJMMg1K+vIE/hGeoPUbX6Lzv/HldcQs/u1fY4vfEf
	 Hoj8pku6WhUzJt3MJBstQ4oTiJiHIeItzM8aGC4VDT3Au9ft1h/tlysGU1LNZba5Of
	 24akePPryXMPmi40gWpM5eaXlQN5ZeyEt6DUlPyS3qpcTmUsB9Ss6UcvCpixVJ5R7r
	 rbuz1BvGuaKrUL4OYgLhXDGpf4rg4baakEz8oBfuf3pxz1WVLOfRlSAPpRbwrxG9Qo
	 Yca5XgaBEQNOMv06bZd1L0PgJC7JUGwZ3uG1u/aNOmtma0aTCGGLd6Vg58ietgZ0DK
	 E+WBeiruBOmyg==
Date: Fri, 22 Aug 2025 16:55:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 14/50] fs: maintain a list of pinned inodes
Message-ID: <20250822-tagebuch-verteidigen-a0865d468f88@brauner>
References: <cover.1755806649.git.josef@toxicpanda.com>
 <cbca76c429c4f3418cc219deb1a9eb917a77cde0.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbca76c429c4f3418cc219deb1a9eb917a77cde0.1755806649.git.josef@toxicpanda.com>

On Thu, Aug 21, 2025 at 04:18:25PM -0400, Josef Bacik wrote:
> Currently we have relied on dirty inodes and inodes with cache on them
> to simply be left hanging around on the system outside of an LRU. The
> only way to make sure these inodes are eventually reclaimed is because
> dirty writeback will grab a reference on the inode and then iput it when
> it's done, potentially getting it on the LRU. For the cached case the
> page cache deletion path will call inode_add_lru when the inode no
> longer has cached pages in order to make sure the inode object can be
> freed eventually.  In the unmount case we walk all inodes and free them
> so this all works out fine.
> 
> But we want to eliminate 0 i_count objects as a concept, so we need a
> mechanism to hold a reference on these pinned inodes. To that end, add a
> list to the super block that contains any inodes that are cached for one
> reason or another.
> 
> When we call inode_add_lru(), if the inode falls into one of these
> categories, we will add it to the cached inode list and hold an
> i_obj_count reference.  If the inode does not fall into one of these
> categories it will be moved to the normal LRU, which is already holds an
> i_obj_count reference.
> 
> The dirty case we will delete it from the LRU if it is on one, and then
> the iput after the writeout will make sure it's placed onto the correct
> list at that point.
> 
> The page cache case will migrate it when it calls inode_add_lru() when
> deleting pages from the page cache.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/fs-writeback.c                |   8 +++
>  fs/inode.c                       | 102 +++++++++++++++++++++++++++++--
>  fs/internal.h                    |   1 +
>  fs/super.c                       |   3 +
>  include/linux/fs.h               |  11 ++++
>  include/trace/events/writeback.h |   3 +-
>  6 files changed, 121 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index d2e1fb1a0787..111a9d8215bf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2736,6 +2736,14 @@ static void wait_sb_inodes(struct super_block *sb)
>  			continue;
>  		}
>  		__iget(inode);
> +
> +		/*
> +		 * We could have potentially ended up on the cached LRU list, so
> +		 * remove ourselves from this list now that we have a reference,
> +		 * the iput will handle placing it back on the appropriate LRU
> +		 * list if necessary.
> +		 */
> +		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
>  		rcu_read_unlock();
>  
> diff --git a/fs/inode.c b/fs/inode.c
> index 94769b356224..adcba0a4d776 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -319,6 +319,23 @@ void free_inode_nonrcu(struct inode *inode)
>  }
>  EXPORT_SYMBOL(free_inode_nonrcu);
>  
> +/*
> + * Some inodes need to stay pinned in memory because they are dirty or there are
> + * cached pages that the VM wants to keep around to avoid thrashing. This does
> + * the appropriate checks to see if we want to sheild this inode from periodic
> + * reclaim. Must be called with ->i_lock held.
> + */
> +static bool inode_needs_cached(struct inode *inode)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +
> +	if (inode->i_state & (I_DIRTY_ALL | I_SYNC))
> +		return true;
> +	if (!mapping_shrinkable(&inode->i_data))
> +		return true;
> +	return false;
> +}
> +
>  static void i_callback(struct rcu_head *head)
>  {
>  	struct inode *inode = container_of(head, struct inode, i_rcu);
> @@ -532,20 +549,67 @@ void ihold(struct inode *inode)
>  }
>  EXPORT_SYMBOL(ihold);
>  
> +static void inode_add_cached_lru(struct inode *inode)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +
> +	if (inode->i_state & I_CACHED_LRU)
> +		return;
> +	if (!list_empty(&inode->i_lru))
> +		return;
> +
> +	inode->i_state |= I_CACHED_LRU;
> +	spin_lock(&inode->i_sb->s_cached_inodes_lock);
> +	list_add(&inode->i_lru, &inode->i_sb->s_cached_inodes);
> +	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
> +	iobj_get(inode);
> +}

For mere correctness you likely want the iobj_get() before you're adding
it to the list so it ends up on the list with the i_obj_count already
bumped.

> +
> +static bool __inode_del_cached_lru(struct inode *inode)
> +{
> +	lockdep_assert_held(&inode->i_lock);
> +
> +	if (!(inode->i_state & I_CACHED_LRU))
> +		return false;
> +
> +	inode->i_state &= ~I_CACHED_LRU;
> +	spin_lock(&inode->i_sb->s_cached_inodes_lock);
> +	list_del_init(&inode->i_lru);
> +	spin_unlock(&inode->i_sb->s_cached_inodes_lock);
> +	return true;
> +}
> +
> +static bool inode_del_cached_lru(struct inode *inode)
> +{
> +	if (__inode_del_cached_lru(inode)) {
> +		iobj_put(inode);
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void __inode_add_lru(struct inode *inode, bool rotate)
>  {
> -	if (inode->i_state & (I_DIRTY_ALL | I_SYNC | I_FREEING | I_WILL_FREE))
> +	bool need_ref = true;
> +
> +	lockdep_assert_held(&inode->i_lock);
> +
> +	if (inode->i_state & (I_FREEING | I_WILL_FREE))
>  		return;
>  	if (atomic_read(&inode->i_count))

Btw, we have a bunch of atomic_read() calls on i_count. We should really
have a helper for that just like we do for files. So we should add
icount() or something similarly named. Accessing reference counts
directly should ideally never happen...

>  		return;
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE))
>  		return;
> -	if (!mapping_shrinkable(&inode->i_data))
> +	if (inode_needs_cached(inode)) {
> +		inode_add_cached_lru(inode);
>  		return;
> +	}
>  
> +	need_ref = __inode_del_cached_lru(inode) == false;
>  	if (list_lru_add_obj(&inode->i_sb->s_inode_lru, &inode->i_lru)) {
> -		iobj_get(inode);
>  		inode->i_state |= I_LRU;
> +		if (need_ref)
> +			iobj_get(inode);
>  		this_cpu_inc(nr_unused);
>  	} else if (rotate) {
>  		inode->i_state |= I_REFERENCED;
> @@ -573,8 +637,19 @@ void inode_add_lru(struct inode *inode)
>  	__inode_add_lru(inode, false);
>  }
>  
> -static void inode_lru_list_del(struct inode *inode)
> +/*
> + * Caller must be holding it's own i_count reference on this inode in order to
> + * prevent this being the final iput.
> + *
> + * Needs inode->i_lock held.
> + */
> +void inode_lru_list_del(struct inode *inode)
>  {
> +	lockdep_assert_held(&inode->i_lock);
> +
> +	if (inode_del_cached_lru(inode))
> +		return;
> +
>  	if (!(inode->i_state & I_LRU))
>  		return;
>  
> @@ -950,6 +1025,22 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	if (!spin_trylock(&inode->i_lock))
>  		return LRU_SKIP;
>  
> +	/*
> +	 * This inode is either dirty or has page cache we want to keep around,
> +	 * so move it to the cached list.
> +	 *
> +	 * We drop the extra i_obj_count reference we grab when adding it to the
> +	 * cached lru.
> +	 */
> +	if (inode_needs_cached(inode)) {
> +		list_lru_isolate(lru, &inode->i_lru);
> +		inode_add_cached_lru(inode);
> +		iobj_put(inode);
> +		spin_unlock(&inode->i_lock);
> +		this_cpu_dec(nr_unused);
> +		return LRU_REMOVED;
> +	}
> +
>  	/*
>  	 * Inodes can get referenced, redirtied, or repopulated while
>  	 * they're already on the LRU, and this can make them
> @@ -957,8 +1048,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  	 * sync, or the last page cache deletion will requeue them.
>  	 */
>  	if (atomic_read(&inode->i_count) ||
> -	    (inode->i_state & ~I_REFERENCED) ||
> -	    !mapping_shrinkable(&inode->i_data)) {
> +	    (inode->i_state & ~I_REFERENCED)) {
>  		list_lru_isolate(lru, &inode->i_lru);
>  		inode->i_state &= ~I_LRU;
>  		spin_unlock(&inode->i_lock);
> diff --git a/fs/internal.h b/fs/internal.h
> index 38e8aab27bbd..17ecee7056d5 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -207,6 +207,7 @@ extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
>  int dentry_needs_remove_privs(struct mnt_idmap *, struct dentry *dentry);
>  bool in_group_or_capable(struct mnt_idmap *idmap,
>  			 const struct inode *inode, vfsgid_t vfsgid);
> +void inode_lru_list_del(struct inode *inode);
>  
>  /*
>   * fs-writeback.c
> diff --git a/fs/super.c b/fs/super.c
> index a038848e8d1f..bf3e6d9055af 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -364,6 +364,8 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	spin_lock_init(&s->s_inode_list_lock);
>  	INIT_LIST_HEAD(&s->s_inodes_wb);
>  	spin_lock_init(&s->s_inode_wblist_lock);
> +	INIT_LIST_HEAD(&s->s_cached_inodes);
> +	spin_lock_init(&s->s_cached_inodes_lock);
>  
>  	s->s_count = 1;
>  	atomic_set(&s->s_active, 1);
> @@ -409,6 +411,7 @@ static void __put_super(struct super_block *s)
>  		WARN_ON(s->s_dentry_lru.node);
>  		WARN_ON(s->s_inode_lru.node);
>  		WARN_ON(!list_empty(&s->s_mounts));
> +		WARN_ON(!list_empty(&s->s_cached_inodes));
>  		call_rcu(&s->rcu, destroy_super_rcu);
>  	}
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 509e696a4df0..8384ed81a5ad 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -749,6 +749,9 @@ is_uncached_acl(struct posix_acl *acl)
>   *			->i_lru is on the LRU and those that are using ->i_lru
>   *			for some other means.
>   *
> + * I_CACHED_LRU		Inode is cached because it is dirty or isn't shrinkable,
> + *			and thus is on the s_cached_inode_lru list.
> + *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
>   *
>   * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> @@ -786,6 +789,7 @@ enum inode_state_bits {
>  	INODE_BIT(I_SYNC_QUEUED),
>  	INODE_BIT(I_PINNING_NETFS_WB),
>  	INODE_BIT(I_LRU),
> +	INODE_BIT(I_CACHED_LRU),
>  };
>  
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> @@ -1584,6 +1588,13 @@ struct super_block {
>  
>  	spinlock_t		s_inode_wblist_lock;
>  	struct list_head	s_inodes_wb;	/* writeback inodes */
> +
> +	/*
> +	 * Cached inodes, any inodes that their reference is held by another
> +	 * mechanism, such as dirty inodes or unshrinkable inodes.
> +	 */
> +	spinlock_t		s_cached_inodes_lock;
> +	struct list_head	s_cached_inodes;
>  } __randomize_layout;
>  
>  static inline struct user_namespace *i_user_ns(const struct inode *inode)
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 486f85aca84d..6949329c744a 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -29,7 +29,8 @@
>  		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
>  		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
>  		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
> -		{I_LRU,			"I_LRU"}		\
> +		{I_LRU,			"I_LRU"},		\
> +		{I_CACHED_LRU,		"I_CACHED_LRU"}		\
>  	)
>  
>  /* enums need to be exported to user space */
> -- 
> 2.49.0
> 

