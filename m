Return-Path: <linux-fsdevel+bounces-41082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A8A2AAB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B253A4BF3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8321C7018;
	Thu,  6 Feb 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZpztGuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABE1C6FF9;
	Thu,  6 Feb 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850802; cv=none; b=iKw8/pnyXaoVFc2p4O89HMLtPkzfRn/BT6SZwjXVzLcZZGHQ8oqcjclBsnJfTCuW457O6MPlAUNQGmknbiB0eoRwF+CLk+khem2GHs6C+JGP9KF6GOXjvZ2Xr+QzsGL5wJF1iJWGqIWTPXQAw4auuQ8+XlqGGJtTg1pFO/xmhT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850802; c=relaxed/simple;
	bh=P3e3ooxpAvA2H3YjD79h2LwkU6gOYvh+dG5fz9R6zv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsGFBTv/TCofmZVOcNxlFFf2gWap7VK/lwn4lj3lQVMA6IMgJaVAlmvbnJ+OTR0OmK+9OTaLdkrZOqk71Oi0f/ETSduLM2KZtF//T82xsZcOXNpXLqjRZDrazXm9dssLDapuYgYpAK1ZHKE1vk1rXnjWYJ9SlKCvrqF4Zvvio2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZpztGuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F74C4CEDD;
	Thu,  6 Feb 2025 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738850800;
	bh=P3e3ooxpAvA2H3YjD79h2LwkU6gOYvh+dG5fz9R6zv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZpztGuOZfIk467J+34IO/LCsUbO5UO2B82SBqC6IHGG9bymrmplhBSlUX8iKstof
	 QMXQvOopttoiOgwbSZZFVO6ovDBwGZ09k7IJjxj5dcKWwzTCuD3owBlLMq5RFypluP
	 KWOeKdEyeSVJnT4X+fpseNZJsjKLN+Yu09sBMOgbqZO6R79eaQNRnvQf2rbr1sYTit
	 bUQBs/zUvp4FxdtmRRZud1rdYJbV51ycsWmXT3ABVyXbKp2kdm1ecg0zTiqbsvSOey
	 /NZ2nuSN/b4xTstCXKQHRnpb/FQFxitJTrt8D0eTbdKZnmyO3CXn8+cS9BLfvUOYL+
	 hu78LoxvB/HJw==
Date: Thu, 6 Feb 2025 15:06:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/19] VFS: Ensure no async updates happening in
 directory being removed.
Message-ID: <20250206-ungeeignet-erhielten-1e46ff51d728@brauner>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-15-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-15-neilb@suse.de>

On Thu, Feb 06, 2025 at 04:42:51PM +1100, NeilBrown wrote:
> vfs_rmdir takes an exclusive lock on the target directory to ensure
> nothing new is created in it while the rmdir progresses.  With the

It also excludes concurrent mount operations.

> possibility of async updates continuing after the inode lock is dropped
> we now need extra protection.
> 
> Any async updates will have DCACHE_PAR_UPDATE set on the dentry.  We
> simply wait for that flag to be cleared on all children.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/dcache.c |  2 +-
>  fs/namei.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index fb331596f1b1..90dee859d138 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -53,7 +53,7 @@
>   *   - d_lru
>   *   - d_count
>   *   - d_unhashed()
> - *   - d_parent and d_chilren
> + *   - d_parent and d_children
>   *   - childrens' d_sib and d_parent
>   *   - d_u.d_alias, d_inode
>   *
> diff --git a/fs/namei.c b/fs/namei.c
> index 3a107d6098be..e8a85c9f431c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1839,6 +1839,27 @@ bool d_update_lock(struct dentry *dentry,
>  	return true;
>  }
>  
> +static void d_update_wait(struct dentry *dentry, unsigned int subclass)
> +{
> +	/* Note this may only ever be called in a context where we have
> +	 * a lock preventing this dentry from becoming locked, possibly
> +	 * an update lock on the parent dentry.  The must be a smp_mb()
> +	 * after that lock is taken and before this is called so that
> +	 * the following test is safe. d_update_lock() provides that
> +	 * barrier.
> +	 */
> +	if (!(dentry->d_flags & DCACHE_PAR_UPDATE))
> +		return
> +	lock_acquire_exclusive(&dentry->d_update_map, subclass,
> +			       0, NULL, _THIS_IP_);
> +	spin_lock(&dentry->d_lock);
> +	wait_var_event_spinlock(&dentry->d_flags,
> +				!check_dentry_locked(dentry),
> +				&dentry->d_lock);
> +	spin_unlock(&dentry->d_lock);
> +	lock_map_release(&dentry->d_update_map);
> +}
> +
>  bool d_update_trylock(struct dentry *dentry,
>  		      struct dentry *base,
>  		      const struct qstr *last)
> @@ -4688,6 +4709,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		     struct dentry *dentry)
>  {
>  	int error = may_delete(idmap, dir, dentry, 1);
> +	struct dentry *child;
>  
>  	if (error)
>  		return error;
> @@ -4697,6 +4719,24 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  
>  	dget(dentry);
>  	inode_lock(dentry->d_inode);
> +	/*
> +	 * Some children of dentry might be active in an async update.
> +	 * We need to wait for them.  New children cannot be locked
> +	 * while the inode lock is held.
> +	 */
> +again:
> +	spin_lock(&dentry->d_lock);
> +	for (child = d_first_child(dentry); child;
> +	     child = d_next_sibling(child)) {
> +		if (child->d_flags & DCACHE_PAR_UPDATE) {
> +			dget(child);
> +			spin_unlock(&dentry->d_lock);
> +			d_update_wait(child, I_MUTEX_CHILD);
> +			dput(child);
> +			goto again;
> +		}
> +	}
> +	spin_unlock(&dentry->d_lock);

That looks like it can cause stalls when you call rmdir on a directory
that has a lots of children and a larg-ish subset of them has pending
async updates, no?

