Return-Path: <linux-fsdevel+bounces-59972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3F1B3FD1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E043BFFF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23852F60DA;
	Tue,  2 Sep 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTq/Ggqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8C2EA15D
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810555; cv=none; b=syMgBF+yR4Jfy7uVBJ9a8xH4nkOEFPcDMtG3VmsMCMmqvuCtMQvwYYgKfGkX0S4/KlHfyX+vQMCVi6Toku6u1xsvR30dxrZsn3evWqEX1tc0TNGjPMAiImzLwCxyrW7CcIZ1UCrKkRyvWwM4oBIDki/q6e6yZyfNTcOQp38hTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810555; c=relaxed/simple;
	bh=radfpS+bnN9oXc+yikZ3rrWhpVBhl1b3eUyHzv34n2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEwzTdwH57KuGduHo1QljDyOt5ne2+gjbnTebP7SnKCFU6taT6Lv/5zubm4PdGMBkcEhPi5TTMxE5By8Vb0pjHypr1HgDDDhC8aRggNXKat7xC+VS2pIv/9txWgfqFqoO9CBnxM4ITEznizgOXNeOdflM37U0GZsjtbQhmhs1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTq/Ggqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD62C4CEED;
	Tue,  2 Sep 2025 10:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756810554;
	bh=radfpS+bnN9oXc+yikZ3rrWhpVBhl1b3eUyHzv34n2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTq/GgqwzaQ/YRtqPT9BkFC1AUxM36zaDZenRvT2+ayIQSBlC0cJQuRablcWwc7L1
	 /VbItQItwWFxO19v15+rKzfeDvlr21D8zbA/6BzxJvUSKrHmeEmKt70lGQ0HEWd4Pp
	 GcO4+gTlv6/GsJJFu4IHGcLIdkigfgrYd4QwHLV3kHasVDuUu9YDDCQQzllUujG8gB
	 HoXADXar246Secstd+nvFk4ueInlqXdUNQaY2461sUY3onEo0jLxL/cu8hR0jKgIZF
	 S5hbUrhtDJd92Lo5M/dyYEmvmsMueZcPRH6Z+OV6c2gHlNwzBBGab/jXhUBYkKx1QZ
	 v6X6eyU2iZ1Ow==
Date: Tue, 2 Sep 2025 12:55:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 35/63] do_lock_mount(): don't modify path.
Message-ID: <20250902-keimzelle-hitze-38cec80fae8f@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-35-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-35-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:38AM +0100, Al Viro wrote:
> Currently do_lock_mount() has the target path switched to whatever
> might be overmounting it.  We _do_ want to have the parent
> mount/mountpoint chosen on top of the overmounting pile; however,
> the way it's done has unpleasant races - if umount propagation
> removes the overmount while we'd been trying to set the environment
> up, we might end up failing if our target path strays into that overmount
> just before the overmount gets kicked out.
> 
> Users of do_lock_mount() do not need the target path changed - they
> have all information in res->{parent,mp}; only one place (in
> do_move_mount()) currently uses the resulting path->mnt, and that value
> is trivial to reconstruct by the original value of path->mnt + chosen
> parent mount.
> 
> Let's keep the target path unchanged; it avoids a bunch of subtle races
> and it's not hard to do:
> 	do
> 		as mount_locked_reader
> 			find the prospective parent mount/mountpoint dentry
> 			grab references if it's not the original target
> 		lock the prospective mountpoint dentry
> 		take namespace_sem exclusive
> 		if prospective parent/mountpoint would be different now
> 			err = -EAGAIN
> 		else if location has been unmounted
> 			err = -ENOENT
> 		else if mountpoint dentry is not allowed to be mounted on
> 			err = -ENOENT
> 		else if beneath and the top of the pile was the absolute root
> 			err = -EINVAL
> 		else
> 			try to get struct mountpoint (by dentry), set
> 			err to 0 on success and -ENO{MEM,ENT} on failure
> 		if err != 0
> 			res->parent = ERR_PTR(err)
> 			drop locks
> 		else
> 			res->parent = prospective parent
> 		drop temporary references
> 	while err == -EAGAIN
> 
> A somewhat subtle part is that dropping temporary references is allowed.
> Neither mounts nor dentries should be evicted by a thread that holds
> namespace_sem.  On success we are dropping those references under
> namespace_sem, so we need to be sure that these are not the last
> references remaining.  However, on success we'd already verified (under
> namespace_sem) that original target is still mounted and that mount
> and dentry we are about to drop are still reachable from it via the
> mount tree.  That guarantees that we are not about to drop the last
> remaining references.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 126 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 68 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index ebecb03972c5..b77d2df606a1 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2727,6 +2727,27 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>  	return err;
>  }
>  
> +static inline struct mount *where_to_mount(const struct path *path,
> +					   struct dentry **dentry,
> +					   bool beneath)
> +{
> +	struct mount *m;
> +
> +	if (unlikely(beneath)) {
> +		m = topmost_overmount(real_mount(path->mnt));
> +		*dentry = m->mnt_mountpoint;
> +		return m->mnt_parent;

No need for that else. This can just be:

if (unlikely(beneath)) {
	m = topmost_overmount(real_mount(path->mnt));
	*dentry = m->mnt_mountpoint;
	return m->mnt_parent;
}

m = __lookup_mnt(path->mnt, *dentry = path->dentry);
if (unlikely(m)) {
	m = topmost_overmount(m);
	*dentry = m->mnt.mnt_root;
	return m;
}
return real_mount(path->mnt);

> +	} else {
> +		m = __lookup_mnt(path->mnt, *dentry = path->dentry);

The assignment to *dentry during argument passing looks really weird.
I would prefer if we didn't do that.

> +		if (unlikely(m)) {
> +			m = topmost_overmount(m);
> +			*dentry = m->mnt.mnt_root;
> +			return m;
> +		}
> +		return real_mount(path->mnt);
> +	}
> +}
> +
>  /**
>   * do_lock_mount - acquire environment for mounting
>   * @path:	target path
> @@ -2758,84 +2779,69 @@ static int attach_recursive_mnt(struct mount *source_mnt,
>   * case we also require the location to be at the root of a mount
>   * that has a parent (i.e. is not a root of some namespace).
>   */
> -static void do_lock_mount(struct path *path, struct pinned_mountpoint *res, bool beneath)
> +static void do_lock_mount(const struct path *path,
> +			  struct pinned_mountpoint *res,
> +			  bool beneath)
>  {
> -	struct vfsmount *mnt = path->mnt;
> -	struct dentry *dentry;
> -	struct path under = {};
> -	int err = -ENOENT;
> +	int err;
>  
>  	if (unlikely(beneath) && !path_mounted(path)) {
>  		res->parent = ERR_PTR(-EINVAL);
>  		return;
>  	}
>  
> -	for (;;) {
> -		struct mount *m = real_mount(mnt);
> -
> -		if (beneath) {
> -			path_put(&under);
> -			read_seqlock_excl(&mount_lock);
> -			if (unlikely(!mnt_has_parent(m))) {
> -				read_sequnlock_excl(&mount_lock);
> -				res->parent = ERR_PTR(-EINVAL);
> -				return;
> +	do {
> +		struct dentry *dentry, *d;
> +		struct mount *m, *n;
> +
> +		scoped_guard(mount_locked_reader) {
> +			m = where_to_mount(path, &dentry, beneath);
> +			if (&m->mnt != path->mnt) {
> +				mntget(&m->mnt);
> +				dget(dentry);
>  			}
> -			under.mnt = mntget(&m->mnt_parent->mnt);
> -			under.dentry = dget(m->mnt_mountpoint);
> -			read_sequnlock_excl(&mount_lock);
> -			dentry = under.dentry;
> -		} else {
> -			dentry = path->dentry;
>  		}
>  
>  		inode_lock(dentry->d_inode);
>  		namespace_lock();
>  
> -		if (unlikely(cant_mount(dentry) || !is_mounted(mnt)))
> -			break;		// not to be mounted on
> +		// check if the chain of mounts (if any) has changed.
> +		scoped_guard(mount_locked_reader)
> +			n = where_to_mount(path, &d, beneath);
>  
> -		if (beneath && unlikely(m->mnt_mountpoint != dentry ||
> -				        &m->mnt_parent->mnt != under.mnt)) {
> -			namespace_unlock();
> -			inode_unlock(dentry->d_inode);
> -			continue;	// got moved
> -		}
> +		if (unlikely(n != m || dentry != d))
> +			err = -EAGAIN;		// something moved, retry
> +		else if (unlikely(cant_mount(dentry) || !is_mounted(path->mnt)))
> +			err = -ENOENT;		// not to be mounted on
> +		else if (beneath && &m->mnt == path->mnt && !m->overmount)
> +			err = -EINVAL;
> +		else
> +			err = get_mountpoint(dentry, res);
>  
> -		mnt = lookup_mnt(path);
> -		if (unlikely(mnt)) {
> +		if (unlikely(err)) {
> +			res->parent = ERR_PTR(err);
>  			namespace_unlock();
>  			inode_unlock(dentry->d_inode);
> -			path_put(path);
> -			path->mnt = mnt;
> -			path->dentry = dget(mnt->mnt_root);
> -			continue;	// got overmounted
> +		} else {
> +			res->parent = m;
>  		}
> -		err = get_mountpoint(dentry, res);
> -		if (err)
> -			break;
> -		if (beneath) {
> -			/*
> -			 * @under duplicates the references that will stay
> -			 * at least until namespace_unlock(), so the path_put()
> -			 * below is safe (and OK to do under namespace_lock -
> -			 * we are not dropping the final references here).
> -			 */
> -			path_put(&under);
> -			res->parent = real_mount(path->mnt)->mnt_parent;
> -			return;
> +		/*
> +		 * Drop the temporary references.  This is subtle - on success
> +		 * we are doing that under namespace_sem, which would normally
> +		 * be forbidden.  However, in that case we are guaranteed that
> +		 * refcounts won't reach zero, since we know that path->mnt
> +		 * is mounted and thus all mounts reachable from it are pinned

"is mounted and we hold the namespace semaphore and thus all mounts
reachable [...]"

With these things fixed:

Reviewed-by: Christian Brauner <brauner@kernel.org>

Unless I forgot something this means I should've gone through the whole
series.

