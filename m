Return-Path: <linux-fsdevel+bounces-51304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D073DAD53A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655807AA6BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0436B2E6131;
	Wed, 11 Jun 2025 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWTKigqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645072E610D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640787; cv=none; b=AHALy0rkYaxlzOZyEry7x+oyp+RHxLFrz7R0kLyY5wBZzaF5BmA6Db/qx0iqG7+/r4WMVmGOPP3oPeVwEi1tKOzUvcD8j7bkO4/nf4qmjIBzneJ4/uE9XfqusyQyMlDTGVz0fZTZTcB6wgGE1kpseyTqADUi3xyDWSgX557R4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640787; c=relaxed/simple;
	bh=OUd1WGY3Zujqxx6l0QJCvmIMxs6QHfyGCVFIyiirZKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTBNkS+0Z0X+lbh5nPNO8b2ESJmx3cQLJjzZAZEVXosweTzOVda4gT+55tmwKcynplf1cdKfSmW724brsk0nUnbbkGJ7YfeZeKRQ8y13SzJofCAuyJviNyMHzZb0VXa5B+dFbQmUANEBYnL1YG7eb2NC1zIMVWnbTHAlCfRu0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWTKigqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72626C4CEEE;
	Wed, 11 Jun 2025 11:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749640786;
	bh=OUd1WGY3Zujqxx6l0QJCvmIMxs6QHfyGCVFIyiirZKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWTKigqw/g0CuZ3ruwtI1PcWaW/8pebXam7UeBVlhkgQqvumWh5c7IPKtxRAHPdzv
	 CMjAchDb9mRqcTWwwH/gFsnzF8raUhWCEeodwKUGX6gwm4h1+NC1skzpGy/GE1Wo4k
	 TMi2020pvJ3ijjJm+h3BQDPvNW6RwgvBFaegCvyXkuCIx5lvWMfaNkmEyWJ53BWlcn
	 dKGkH3IiHwmr0tOqhfh34GFrJUBQRwze2Ib/MGqX/H+R4RRl1tUy9iu5vK9adPDOr9
	 0CbbzruKd+dq5alpkhhyQtKFHbIya3Ca+ua8LM1Yi4MhuL8FYq5ykwk3wGrhSKYP+N
	 kePi7mVAfU5JQ==
Date: Wed, 11 Jun 2025 13:19:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/26] get rid of mountpoint->m_count
Message-ID: <20250611-leidwesen-kundschaft-92abc4565458@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-25-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-25-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:47AM +0100, Al Viro wrote:
> struct mountpoint has an odd kinda-sorta refcount in it.  It's always
> either equal to or one above the number of mounts attached to that
> mountpoint.
> 
> "One above" happens when a function takes a temporary reference to
> mountpoint.  Things get simpler if we express that as inserting
> a local object into ->m_list and removing it to drop the reference.
> 
> New calling conventions:
> 
> 1) lock_mount(), do_lock_mount(), get_mountpoint() and lookup_mountpoint()
> take an extra struct pinned_mountpoint * argument and returns 0/-E...
> (or true/false in case of lookup_mountpoint()) instead of returning
> struct mountpoint pointers.  In case of success, the struct mountpoint *
> we used to get can be found as pinned_mountpoint.mp
> 
> 2) unlock_mount() (always paired with lock_mount()/do_lock_mount()) takes
> an address of struct pinned_mountpoint - the same that had been passed to
> lock_mount()/do_lock_mount().
> 
> 3) put_mountpoint() for a temporary reference (paired with get_mountpoint()
> or lookup_mountpoint()) is replaced with unpin_mountpoint(), which takes
> the address of pinned_mountpoint we passed to matching {get,lookup}_mountpoint().
> 
> 4) all instances of pinned_mountpoint are local variables; they always live on
> stack.  {} is used for initializer, after successful {get,lookup}_mountpoint()
> we must make sure to call unpin_mountpoint() before leaving the scope and

This feels well-suited for a DEFINE_FREE based annotation so that
unpin_mountpoint() is called when the scope ends.

> after successful {do_,}lock_mount() we must make sure to call unlock_mount()
> before leaving the scope.
> 
> 5) all manipulations of ->m_count are gone, along with ->m_count itself.
> struct mountpoint lives while its ->m_list is non-empty.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Debatable whether that's really an improvement but sure,
Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/mount.h     |   1 -
>  fs/namespace.c | 186 ++++++++++++++++++++++++-------------------------
>  2 files changed, 92 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/mount.h b/fs/mount.h
> index 9b3de2eef68a..684480087da2 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -44,7 +44,6 @@ struct mountpoint {
>  	struct hlist_node m_hash;
>  	struct dentry *m_dentry;
>  	struct hlist_head m_list;
> -	int m_count;
>  };
>  
>  struct mount {
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 777e4c3b2c12..1f1cf1d6a464 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -910,42 +910,48 @@ bool __is_local_mountpoint(const struct dentry *dentry)
>  	return is_covered;
>  }
>  
> -static struct mountpoint *lookup_mountpoint(struct dentry *dentry)
> +struct pinned_mountpoint {
> +	struct hlist_node node;
> +	struct mountpoint *mp;
> +};
> +
> +static bool lookup_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
>  {
>  	struct hlist_head *chain = mp_hash(dentry);
>  	struct mountpoint *mp;
>  
>  	hlist_for_each_entry(mp, chain, m_hash) {
>  		if (mp->m_dentry == dentry) {
> -			mp->m_count++;
> -			return mp;
> +			hlist_add_head(&m->node, &mp->m_list);
> +			m->mp = mp;
> +			return true;
>  		}
>  	}
> -	return NULL;
> +	return false;
>  }
>  
> -static struct mountpoint *get_mountpoint(struct dentry *dentry)
> +static int get_mountpoint(struct dentry *dentry, struct pinned_mountpoint *m)
>  {
> -	struct mountpoint *mp, *new = NULL;
> +	struct mountpoint *mp __free(kfree) = NULL;
> +	bool found;
>  	int ret;
>  
>  	if (d_mountpoint(dentry)) {
>  		/* might be worth a WARN_ON() */
>  		if (d_unlinked(dentry))
> -			return ERR_PTR(-ENOENT);
> +			return -ENOENT;
>  mountpoint:
>  		read_seqlock_excl(&mount_lock);
> -		mp = lookup_mountpoint(dentry);
> +		found = lookup_mountpoint(dentry, m);
>  		read_sequnlock_excl(&mount_lock);
> -		if (mp)
> -			goto done;
> +		if (found)
> +			return 0;
>  	}
>  
> -	if (!new)
> -		new = kmalloc(sizeof(struct mountpoint), GFP_KERNEL);
> -	if (!new)
> -		return ERR_PTR(-ENOMEM);
> -
> +	if (!mp)
> +		mp = kmalloc(sizeof(struct mountpoint), GFP_KERNEL);
> +	if (!mp)
> +		return -ENOMEM;
>  
>  	/* Exactly one processes may set d_mounted */
>  	ret = d_set_mounted(dentry);
> @@ -955,34 +961,28 @@ static struct mountpoint *get_mountpoint(struct dentry *dentry)
>  		goto mountpoint;
>  
>  	/* The dentry is not available as a mountpoint? */
> -	mp = ERR_PTR(ret);
>  	if (ret)
> -		goto done;
> +		return ret;
>  
>  	/* Add the new mountpoint to the hash table */
>  	read_seqlock_excl(&mount_lock);
> -	new->m_dentry = dget(dentry);
> -	new->m_count = 1;
> -	hlist_add_head(&new->m_hash, mp_hash(dentry));
> -	INIT_HLIST_HEAD(&new->m_list);
> +	mp->m_dentry = dget(dentry);
> +	hlist_add_head(&mp->m_hash, mp_hash(dentry));
> +	INIT_HLIST_HEAD(&mp->m_list);
> +	hlist_add_head(&m->node, &mp->m_list);
> +	m->mp = no_free_ptr(mp);
>  	read_sequnlock_excl(&mount_lock);
> -
> -	mp = new;
> -	new = NULL;
> -done:
> -	kfree(new);
> -	return mp;
> +	return 0;
>  }
>  
>  /*
>   * vfsmount lock must be held.  Additionally, the caller is responsible
>   * for serializing calls for given disposal list.
>   */
> -static void __put_mountpoint(struct mountpoint *mp, struct list_head *list)
> +static void maybe_free_mountpoint(struct mountpoint *mp, struct list_head *list)
>  {
> -	if (!--mp->m_count) {
> +	if (hlist_empty(&mp->m_list)) {
>  		struct dentry *dentry = mp->m_dentry;
> -		BUG_ON(!hlist_empty(&mp->m_list));
>  		spin_lock(&dentry->d_lock);
>  		dentry->d_flags &= ~DCACHE_MOUNTED;
>  		spin_unlock(&dentry->d_lock);
> @@ -992,10 +992,15 @@ static void __put_mountpoint(struct mountpoint *mp, struct list_head *list)
>  	}
>  }
>  
> -/* called with namespace_lock and vfsmount lock */
> -static void put_mountpoint(struct mountpoint *mp)
> +/*
> + * locks: mount_lock [read_seqlock_excl], namespace_sem [excl]
> + */
> +static void unpin_mountpoint(struct pinned_mountpoint *m)
>  {
> -	__put_mountpoint(mp, &ex_mountpoints);
> +	if (m->mp) {
> +		hlist_del(&m->node);
> +		maybe_free_mountpoint(m->mp, &ex_mountpoints);
> +	}
>  }
>  
>  static inline int check_mnt(struct mount *mnt)
> @@ -1049,7 +1054,7 @@ static void __umount_mnt(struct mount *mnt, struct list_head *shrink_list)
>  	hlist_del_init(&mnt->mnt_mp_list);
>  	mp = mnt->mnt_mp;
>  	mnt->mnt_mp = NULL;
> -	__put_mountpoint(mp, shrink_list);
> +	maybe_free_mountpoint(mp, shrink_list);
>  }
>  
>  /*
> @@ -1067,7 +1072,6 @@ void mnt_set_mountpoint(struct mount *mnt,
>  			struct mountpoint *mp,
>  			struct mount *child_mnt)
>  {
> -	mp->m_count++;
>  	mnt_add_count(mnt, 1);	/* essentially, that's mntget */
>  	child_mnt->mnt_mountpoint = mp->m_dentry;
>  	child_mnt->mnt_parent = mnt;
> @@ -1116,7 +1120,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
>  
>  	attach_mnt(mnt, parent, mp);
>  
> -	put_mountpoint(old_mp);
> +	maybe_free_mountpoint(old_mp, &ex_mountpoints);
>  	mnt_add_count(old_parent, -1);
>  }
>  
> @@ -2024,25 +2028,24 @@ static int do_umount(struct mount *mnt, int flags)
>   */
>  void __detach_mounts(struct dentry *dentry)
>  {
> -	struct mountpoint *mp;
> +	struct pinned_mountpoint mp = {};
>  	struct mount *mnt;
>  
>  	namespace_lock();
>  	lock_mount_hash();
> -	mp = lookup_mountpoint(dentry);
> -	if (!mp)
> +	if (!lookup_mountpoint(dentry, &mp))
>  		goto out_unlock;
>  
>  	event++;
> -	while (!hlist_empty(&mp->m_list)) {
> -		mnt = hlist_entry(mp->m_list.first, struct mount, mnt_mp_list);
> +	while (mp.node.next) {
> +		mnt = hlist_entry(mp.node.next, struct mount, mnt_mp_list);
>  		if (mnt->mnt.mnt_flags & MNT_UMOUNT) {
>  			umount_mnt(mnt);
>  			hlist_add_head(&mnt->mnt_umount, &unmounted);
>  		}
>  		else umount_tree(mnt, UMOUNT_CONNECTED);
>  	}
> -	put_mountpoint(mp);
> +	unpin_mountpoint(&mp);
>  out_unlock:
>  	unlock_mount_hash();
>  	namespace_unlock();
> @@ -2618,7 +2621,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
>  	HLIST_HEAD(tree_list);
>  	struct mnt_namespace *ns = dest_mnt->mnt_ns;
> -	struct mountpoint *smp;
> +	struct pinned_mountpoint root = {};
>  	struct mount *child, *p;
>  	struct hlist_node *n;
>  	int err = 0;
> @@ -2628,9 +2631,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  	 * Preallocate a mountpoint in case the new mounts need to be
>  	 * mounted beneath mounts on the same mountpoint.
>  	 */
> -	smp = get_mountpoint(source_mnt->mnt.mnt_root);
> -	if (IS_ERR(smp))
> -		return PTR_ERR(smp);
> +	err = get_mountpoint(source_mnt->mnt.mnt_root, &root);
> +	if (err)
> +		return err;
>  
>  	/* Is there space to add these mounts to the mount namespace? */
>  	if (!moving) {
> @@ -2680,13 +2683,13 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  		q = __lookup_mnt(&child->mnt_parent->mnt,
>  				 child->mnt_mountpoint);
>  		if (q)
> -			mnt_change_mountpoint(child, smp, q);
> +			mnt_change_mountpoint(child, root.mp, q);
>  		/* Notice when we are propagating across user namespaces */
>  		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
>  			lock_mnt_tree(child);
>  		commit_tree(child);
>  	}
> -	put_mountpoint(smp);
> +	unpin_mountpoint(&root);
>  	unlock_mount_hash();
>  
>  	return 0;
> @@ -2703,7 +2706,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  	ns->pending_mounts = 0;
>  
>  	read_seqlock_excl(&mount_lock);
> -	put_mountpoint(smp);
> +	unpin_mountpoint(&root);
>  	read_sequnlock_excl(&mount_lock);
>  
>  	return err;
> @@ -2743,12 +2746,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>   * Return: Either the target mountpoint on the top mount or the top
>   *         mount's mountpoint.
>   */
> -static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
> +static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bool beneath)
>  {
>  	struct vfsmount *mnt = path->mnt;
>  	struct dentry *dentry;
> -	struct mountpoint *mp = ERR_PTR(-ENOENT);
>  	struct path under = {};
> +	int err = -ENOENT;
>  
>  	for (;;) {
>  		struct mount *m = real_mount(mnt);
> @@ -2786,8 +2789,8 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
>  			path->dentry = dget(mnt->mnt_root);
>  			continue;	// got overmounted
>  		}
> -		mp = get_mountpoint(dentry);
> -		if (IS_ERR(mp))
> +		err = get_mountpoint(dentry, pinned);
> +		if (err)
>  			break;
>  		if (beneath) {
>  			/*
> @@ -2798,25 +2801,25 @@ static struct mountpoint *do_lock_mount(struct path *path, bool beneath)
>  			 */
>  			path_put(&under);
>  		}
> -		return mp;
> +		return 0;
>  	}
>  	namespace_unlock();
>  	inode_unlock(dentry->d_inode);
>  	if (beneath)
>  		path_put(&under);
> -	return mp;
> +	return err;
>  }
>  
> -static inline struct mountpoint *lock_mount(struct path *path)
> +static inline int lock_mount(struct path *path, struct pinned_mountpoint *m)
>  {
> -	return do_lock_mount(path, false);
> +	return do_lock_mount(path, m, false);
>  }
>  
> -static void unlock_mount(struct mountpoint *where)
> +static void unlock_mount(struct pinned_mountpoint *m)
>  {
> -	inode_unlock(where->m_dentry->d_inode);
> +	inode_unlock(m->mp->m_dentry->d_inode);
>  	read_seqlock_excl(&mount_lock);
> -	put_mountpoint(where);
> +	unpin_mountpoint(m);
>  	read_sequnlock_excl(&mount_lock);
>  	namespace_unlock();
>  }
> @@ -2981,7 +2984,7 @@ static int do_loopback(struct path *path, const char *old_name,
>  {
>  	struct path old_path;
>  	struct mount *mnt = NULL, *parent;
> -	struct mountpoint *mp;
> +	struct pinned_mountpoint mp = {};
>  	int err;
>  	if (!old_name || !*old_name)
>  		return -EINVAL;
> @@ -2993,11 +2996,9 @@ static int do_loopback(struct path *path, const char *old_name,
>  	if (mnt_ns_loop(old_path.dentry))
>  		goto out;
>  
> -	mp = lock_mount(path);
> -	if (IS_ERR(mp)) {
> -		err = PTR_ERR(mp);
> +	err = lock_mount(path, &mp);
> +	if (err)
>  		goto out;
> -	}
>  
>  	parent = real_mount(path->mnt);
>  	if (!check_mnt(parent))
> @@ -3009,14 +3010,14 @@ static int do_loopback(struct path *path, const char *old_name,
>  		goto out2;
>  	}
>  
> -	err = graft_tree(mnt, parent, mp);
> +	err = graft_tree(mnt, parent, mp.mp);
>  	if (err) {
>  		lock_mount_hash();
>  		umount_tree(mnt, UMOUNT_SYNC);
>  		unlock_mount_hash();
>  	}
>  out2:
> -	unlock_mount(mp);
> +	unlock_mount(&mp);
>  out:
>  	path_put(&old_path);
>  	return err;
> @@ -3560,13 +3561,13 @@ static int do_move_mount(struct path *old_path,
>  	struct mount *p;
>  	struct mount *old;
>  	struct mount *parent;
> -	struct mountpoint *mp;
> +	struct pinned_mountpoint mp;
>  	int err;
>  	bool beneath = flags & MNT_TREE_BENEATH;
>  
> -	mp = do_lock_mount(new_path, beneath);
> -	if (IS_ERR(mp))
> -		return PTR_ERR(mp);
> +	err = do_lock_mount(new_path, &mp, beneath);
> +	if (err)
> +		return err;
>  
>  	old = real_mount(old_path->mnt);
>  	p = real_mount(new_path->mnt);
> @@ -3615,7 +3616,7 @@ static int do_move_mount(struct path *old_path,
>  		goto out;
>  
>  	if (beneath) {
> -		err = can_move_mount_beneath(old_path, new_path, mp);
> +		err = can_move_mount_beneath(old_path, new_path, mp.mp);
>  		if (err)
>  			goto out;
>  
> @@ -3635,9 +3636,9 @@ static int do_move_mount(struct path *old_path,
>  	if (mount_is_ancestor(old, p))
>  		goto out;
>  
> -	err = attach_recursive_mnt(old, p, mp);
> +	err = attach_recursive_mnt(old, p, mp.mp);
>  out:
> -	unlock_mount(mp);
> +	unlock_mount(&mp);
>  	if (!err) {
>  		if (!is_anon_ns(ns)) {
>  			mntput_no_expire(parent);
> @@ -3707,7 +3708,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  			   unsigned int mnt_flags)
>  {
>  	struct vfsmount *mnt;
> -	struct mountpoint *mp;
> +	struct pinned_mountpoint mp = {};
>  	struct super_block *sb = fc->root->d_sb;
>  	int error;
>  
> @@ -3728,13 +3729,12 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
>  
>  	mnt_warn_timestamp_expiry(mountpoint, mnt);
>  
> -	mp = lock_mount(mountpoint);
> -	if (IS_ERR(mp)) {
> -		mntput(mnt);
> -		return PTR_ERR(mp);
> +	error = lock_mount(mountpoint, &mp);
> +	if (!error) {
> +		error = do_add_mount(real_mount(mnt), mp.mp,
> +				     mountpoint, mnt_flags);
> +		unlock_mount(&mp);
>  	}
> -	error = do_add_mount(real_mount(mnt), mp, mountpoint, mnt_flags);
> -	unlock_mount(mp);
>  	if (error < 0)
>  		mntput(mnt);
>  	return error;
> @@ -3802,7 +3802,7 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
>  int finish_automount(struct vfsmount *m, const struct path *path)
>  {
>  	struct dentry *dentry = path->dentry;
> -	struct mountpoint *mp;
> +	struct pinned_mountpoint mp = {};
>  	struct mount *mnt;
>  	int err;
>  
> @@ -3834,14 +3834,13 @@ int finish_automount(struct vfsmount *m, const struct path *path)
>  		err = 0;
>  		goto discard_locked;
>  	}
> -	mp = get_mountpoint(dentry);
> -	if (IS_ERR(mp)) {
> -		err = PTR_ERR(mp);
> +	err = get_mountpoint(dentry, &mp);
> +	if (err)
>  		goto discard_locked;
> -	}
>  
> -	err = do_add_mount(mnt, mp, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
> -	unlock_mount(mp);
> +	err = do_add_mount(mnt, mp.mp, path,
> +			   path->mnt->mnt_flags | MNT_SHRINKABLE);
> +	unlock_mount(&mp);
>  	if (unlikely(err))
>  		goto discard;
>  	return 0;
> @@ -4642,7 +4641,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>  {
>  	struct path new, old, root;
>  	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
> -	struct mountpoint *old_mp;
> +	struct pinned_mountpoint old_mp = {};
>  	int error;
>  
>  	if (!may_mount())
> @@ -4663,9 +4662,8 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>  		goto out2;
>  
>  	get_fs_root(current->fs, &root);
> -	old_mp = lock_mount(&old);
> -	error = PTR_ERR(old_mp);
> -	if (IS_ERR(old_mp))
> +	error = lock_mount(&old, &old_mp);
> +	if (error)
>  		goto out3;
>  
>  	error = -EINVAL;
> @@ -4714,7 +4712,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>  	umount_mnt(root_mnt);
>  	mnt_add_count(root_parent, -1);
>  	/* mount old root on put_old */
> -	attach_mnt(root_mnt, old_mnt, old_mp);
> +	attach_mnt(root_mnt, old_mnt, old_mp.mp);
>  	touch_mnt_namespace(current->nsproxy->mnt_ns);
>  	/* A moved mount should not expire automatically */
>  	list_del_init(&new_mnt->mnt_expire);
> @@ -4724,7 +4722,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
>  	chroot_fs_refs(&root, &new);
>  	error = 0;
>  out4:
> -	unlock_mount(old_mp);
> +	unlock_mount(&old_mp);
>  	if (!error)
>  		mntput_no_expire(ex_parent);
>  out3:
> -- 
> 2.39.5
> 

