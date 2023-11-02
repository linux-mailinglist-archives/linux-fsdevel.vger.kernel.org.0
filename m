Return-Path: <linux-fsdevel+bounces-1825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD83B7DF446
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB26281B72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990C18E3E;
	Thu,  2 Nov 2023 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2pEmtEN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M0TljGHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CA18E2D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 13:48:50 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9276195
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 06:48:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4321A21A4C;
	Thu,  2 Nov 2023 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698932923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubiSME8bsfVSDj7/Y+TrKWdyzuRT0XCbDYgi7aZ7Ass=;
	b=i2pEmtENzRjR9K3dVbjdC//I1IvqCXx6ucHwOgeclLLGk/7nEqwrr0B+48MhHRBEIH8RZ3
	k1w93of53GL9IfIPHiAX3I+pzxX4xBPu9kVYjAdTMpdt9JA/3cBry4d+b/yaW1jCrXrP2W
	ghT08RtJ0mY+GkGP0FFVkYVA1Z1cYa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698932923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ubiSME8bsfVSDj7/Y+TrKWdyzuRT0XCbDYgi7aZ7Ass=;
	b=M0TljGHOTYgJP1yukpUWBAUt1GNQzMRzRITizm4sxo+o2cplzLQ1HiLQnjqdmVNk6F5dDC
	Gsu7wfTtVQvraQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34AB8138EC;
	Thu,  2 Nov 2023 13:48:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id C5jODLuoQ2UOfAAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 02 Nov 2023 13:48:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B7D49A06E3; Thu,  2 Nov 2023 14:48:42 +0100 (CET)
Date: Thu, 2 Nov 2023 14:48:42 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: make s_count atomic_t
Message-ID: <20231102134842.tu26pykjpzgi4veo@quack3>
References: <20231027-neurologie-miterleben-a8c52a745463@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027-neurologie-miterleben-a8c52a745463@brauner>

On Fri 27-10-23 11:35:20, Christian Brauner wrote:
> So, I believe we can drop the sb_lock in bdev_super_lock() for all
> holder operations if we turn s_count into an atomic. It will slightly
> change semantics for list walks like iterate_supers() but imho that's
> fine. It'll mean that list walkes need a acquire sb_lock, then try to
> get reference via atomic_inc_not_zero().
> 
> The logic there is simply that if you still found the superblock on the
> list then yes, someone could now concurrently drop s_count to zero
> behind your back. But because you hold sb_lock they can't remove it from
> the list behind your back.
> 
> So if you now fail atomic_inc_not_zero() then you know that someone
> concurrently managed to drop the ref to zero and wants to remove that sb
> from the list. So you just ignore that super block and go on walking the
> list. If however, you manage to get an active reference things are fine
> and you can try to trade that temporary reference for an active
> reference. So my theory at least...
> 
> Yes, ofc we add atomics but for superblocks we shouldn't care especially
> we have less and less list walkers. Both get_super() and
> get_active_super() are gone after all.
> 
> I'm running xfstests as I'm sending this and I need to start finishing
> PRs so in RFC mode. Thoughts?
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

So in principle I agree we can get rid of some sb_lock use if we convert
sb->s_count to an atomic type. However does this bring any significant
benefit? I would not expect sb_lock to be contended and as you say you need
to be more careful about the races then so that is a reason against such
change.

								Honza

> ---
>  fs/super.c         | 93 ++++++++++++++++++++++++++--------------------
>  include/linux/fs.h |  2 +-
>  2 files changed, 53 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 71e5e61cfc9e..c58de6bb5633 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -375,7 +375,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	INIT_LIST_HEAD(&s->s_inodes_wb);
>  	spin_lock_init(&s->s_inode_wblist_lock);
>  
> -	s->s_count = 1;
> +	atomic_set(&s->s_count, 1);
>  	atomic_set(&s->s_active, 1);
>  	mutex_init(&s->s_vfs_rename_mutex);
>  	lockdep_set_class(&s->s_vfs_rename_mutex, &type->s_vfs_rename_key);
> @@ -409,19 +409,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  /*
>   * Drop a superblock's refcount.  The caller must hold sb_lock.
>   */
> -static void __put_super(struct super_block *s)
> -{
> -	if (!--s->s_count) {
> -		list_del_init(&s->s_list);
> -		WARN_ON(s->s_dentry_lru.node);
> -		WARN_ON(s->s_inode_lru.node);
> -		WARN_ON(!list_empty(&s->s_mounts));
> -		security_sb_free(s);
> -		put_user_ns(s->s_user_ns);
> -		kfree(s->s_subtype);
> -		call_rcu(&s->rcu, destroy_super_rcu);
> -	}
> -}
>  
>  /**
>   *	put_super	-	drop a temporary reference to superblock
> @@ -430,10 +417,20 @@ static void __put_super(struct super_block *s)
>   *	Drops a temporary reference, frees superblock if there's no
>   *	references left.
>   */
> -void put_super(struct super_block *sb)
> +void put_super(struct super_block *s)
>  {
> +	if (!atomic_dec_and_test(&s->s_count))
> +		return;
> +
>  	spin_lock(&sb_lock);
> -	__put_super(sb);
> +	list_del_init(&s->s_list);
> +	WARN_ON(s->s_dentry_lru.node);
> +	WARN_ON(s->s_inode_lru.node);
> +	WARN_ON(!list_empty(&s->s_mounts));
> +	security_sb_free(s);
> +	put_user_ns(s->s_user_ns);
> +	kfree(s->s_subtype);
> +	call_rcu(&s->rcu, destroy_super_rcu);
>  	spin_unlock(&sb_lock);
>  }
>  
> @@ -548,8 +545,11 @@ static bool grab_super(struct super_block *sb)
>  {
>  	bool locked;
>  
> -	sb->s_count++;
> +	locked = atomic_inc_not_zero(&sb->s_count);
>  	spin_unlock(&sb_lock);
> +	if (!locked)
> +		return false;
> +
>  	locked = super_lock_excl(sb);
>  	if (locked) {
>  		if (atomic_inc_not_zero(&sb->s_active)) {
> @@ -908,19 +908,20 @@ static void __iterate_supers(void (*f)(struct super_block *))
>  		/* Pairs with memory marrier in super_wake(). */
>  		if (smp_load_acquire(&sb->s_flags) & SB_DYING)
>  			continue;
> -		sb->s_count++;
> +		if (!atomic_inc_not_zero(&sb->s_count))
> +			continue;
>  		spin_unlock(&sb_lock);
>  
>  		f(sb);
>  
> -		spin_lock(&sb_lock);
>  		if (p)
> -			__put_super(p);
> +			put_super(p);
>  		p = sb;
> +		spin_lock(&sb_lock);
>  	}
> -	if (p)
> -		__put_super(p);
>  	spin_unlock(&sb_lock);
> +	if (p)
> +		put_super(p);
>  }
>  /**
>   *	iterate_supers - call function for all active superblocks
> @@ -938,7 +939,8 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  	list_for_each_entry(sb, &super_blocks, s_list) {
>  		bool locked;
>  
> -		sb->s_count++;
> +		if (!atomic_inc_not_zero(&sb->s_count))
> +			continue;
>  		spin_unlock(&sb_lock);
>  
>  		locked = super_lock_shared(sb);
> @@ -948,14 +950,14 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  			super_unlock_shared(sb);
>  		}
>  
> -		spin_lock(&sb_lock);
>  		if (p)
> -			__put_super(p);
> +			put_super(p);
>  		p = sb;
> +		spin_lock(&sb_lock);
>  	}
> -	if (p)
> -		__put_super(p);
>  	spin_unlock(&sb_lock);
> +	if (p)
> +		put_super(p);
>  }
>  
>  /**
> @@ -976,7 +978,8 @@ void iterate_supers_type(struct file_system_type *type,
>  	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
>  		bool locked;
>  
> -		sb->s_count++;
> +		if (!atomic_inc_not_zero(&sb->s_count))
> +			continue;
>  		spin_unlock(&sb_lock);
>  
>  		locked = super_lock_shared(sb);
> @@ -986,14 +989,14 @@ void iterate_supers_type(struct file_system_type *type,
>  			super_unlock_shared(sb);
>  		}
>  
> -		spin_lock(&sb_lock);
>  		if (p)
> -			__put_super(p);
> +			put_super(p);
>  		p = sb;
> +		spin_lock(&sb_lock);
>  	}
> -	if (p)
> -		__put_super(p);
>  	spin_unlock(&sb_lock);
> +	if (p)
> +		put_super(p);
>  }
>  
>  EXPORT_SYMBOL(iterate_supers_type);
> @@ -1007,7 +1010,8 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  		if (sb->s_dev ==  dev) {
>  			bool locked;
>  
> -			sb->s_count++;
> +			if (!atomic_inc_not_zero(&sb->s_count))
> +				continue;
>  			spin_unlock(&sb_lock);
>  			/* still alive? */
>  			locked = super_lock(sb, excl);
> @@ -1017,8 +1021,8 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  				super_unlock(sb, excl);
>  			}
>  			/* nope, got unmounted */
> +			put_super(sb);
>  			spin_lock(&sb_lock);
> -			__put_super(sb);
>  			break;
>  		}
>  	}
> @@ -1387,20 +1391,27 @@ static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
>  	__releases(&bdev->bd_holder_lock)
>  {
>  	struct super_block *sb = bdev->bd_holder;
> -	bool locked;
> +	bool active;
>  
>  	lockdep_assert_held(&bdev->bd_holder_lock);
>  	lockdep_assert_not_held(&sb->s_umount);
>  	lockdep_assert_not_held(&bdev->bd_disk->open_mutex);
>  
> -	/* Make sure sb doesn't go away from under us */
> -	spin_lock(&sb_lock);
> -	sb->s_count++;
> -	spin_unlock(&sb_lock);
> +	active = atomic_inc_not_zero(&sb->s_count);
>  
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
> -	locked = super_lock(sb, excl);
> +	/*
> +	 * The bd_holder_lock guarantees that @sb is still valid.
> +	 * sb->s_count can't be zero. If it were it would mean that we
> +	 * found a block device that has bdev->bd_holder set to a
> +	 * superblock that's about to be freed. IOW, there's a UAF
> +	 * somewhere...
> +	 */
> +	if (WARN_ON_ONCE(!active))
> +		return NULL;
> +
> +	active = super_lock(sb, excl);
>  
>  	/*
>  	 * If the superblock wasn't already SB_DYING then we hold
> @@ -1408,7 +1419,7 @@ static struct super_block *bdev_super_lock(struct block_device *bdev, bool excl)
>           */
>  	put_super(sb);
>  
> -	if (!locked)
> +	if (!active)
>  		return NULL;
>  
>  	if (!sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5174e821d451..68e453c155af 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1201,7 +1201,7 @@ struct super_block {
>  	unsigned long		s_magic;
>  	struct dentry		*s_root;
>  	struct rw_semaphore	s_umount;
> -	int			s_count;
> +	atomic_t		s_count;
>  	atomic_t		s_active;
>  #ifdef CONFIG_SECURITY
>  	void                    *s_security;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

