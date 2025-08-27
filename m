Return-Path: <linux-fsdevel+bounces-59362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E8B38269
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605B73BBAEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740F31A072;
	Wed, 27 Aug 2025 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyMR+Nqy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF628135B;
	Wed, 27 Aug 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297974; cv=none; b=gFNfFuMrmQyHhW4rrb1blMSXbR+wRsj5d46ysdVp8jynRLElznlAgzwa7l4X8K+Hwl8KUmMJywMG8kfVt061KhJyZgxY2tc98IcQSUELIG7OzHL8XNuzNulOtaCSZYjMjlF/0Go12Hagjw1qFPl2cR+Wgg+vVbTsAjeGqf014QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297974; c=relaxed/simple;
	bh=mV5rlgU/CFJxGU5w5AqoeVeGLZRe5V/Uh5NsLYLndms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgVVMNxbfw6q+SaEbDHyPcy/wAheVKVxPK3U1dioHAhwsFb2K53K8Ls/7UPDSHVucgxKw3B4sXs352tBkvn2VPdRNNOB+1uTht4qaugl3cinn8JAtV7pBhb/6iMy0e/NEwCBaIWHJrdnO7zsfzc+0GL6hM5bd/HRaDCBj8ej234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyMR+Nqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0387C4CEF4;
	Wed, 27 Aug 2025 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756297973;
	bh=mV5rlgU/CFJxGU5w5AqoeVeGLZRe5V/Uh5NsLYLndms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GyMR+Nqye+vuPW6jrC96Uknufe2hfleujjfprHV/1ax3E1WhaBhQq6qGSVXBPAO4j
	 lLrhAsN6sxdKtV7mH2WVltH/IDe0T3H/0hcn9mV3GAR3eRH29IftSI1g60vRyBfLau
	 NcS+FpvodXW0T5EMs3Yk5TNeuLC1YpnGKLSUCa76gYGqLG5FotLzhRz6pUChnU4PxW
	 aUPnPQ768ubmGoHgd65HYmZoPCntkmvtWYtHWQudYkOyfNbqBbYPW/bW2qaImIKUaR
	 oTHhNRr8bKoL+U1aPN0Kay7vEAFj8rr9mBYSACX/7oP8b8mY9h4iKGD9uDIn559IL2
	 PtgI7UNJl1SsA==
Date: Wed, 27 Aug 2025 14:32:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <20250827-bratkartoffeln-weltschmerz-fc60227f43e7@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> We can end up with an inode on the LRU list or the cached list, then at
> some point in the future go to unlink that inode and then still have an
> elevated i_count reference for that inode because it is on one of these
> lists.
> 
> The more common case is the cached list. We open a file, write to it,
> truncate some of it which triggers the inode_add_lru code in the
> pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> it exists until writeback or reclaim kicks in and removes the inode.
> 
> To handle this case, delete the inode from the LRU list when it is
> unlinked, so we have the best case scenario for immediately freeing the
> inode.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

I'm not too fond of this particular change I think it's really misplaced
and the correct place is indeed drop_nlink() and clear_nlink().

I'm pretty sure that the number of callers that hold i_lock around
drop_nlink() and clear_nlink() is relatively small. So it might just be
preferable to drop_nlink_locked() and clear_nlink_locked() and just
switch the few places over to it. I think you have tooling to give you a
preliminary glimpse what and how many callers do this...


>  fs/namei.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 138a693c2346..e56dcb5747e4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4438,6 +4438,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
>  int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		     struct dentry *dentry)
>  {
> +	struct inode *inode = dentry->d_inode;
>  	int error = may_delete(idmap, dir, dentry, 1);
>  
>  	if (error)
> @@ -4447,11 +4448,11 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		return -EPERM;
>  
>  	dget(dentry);
> -	inode_lock(dentry->d_inode);
> +	inode_lock(inode);
>  
>  	error = -EBUSY;
>  	if (is_local_mountpoint(dentry) ||
> -	    (dentry->d_inode->i_flags & S_KERNEL_FILE))
> +	    (inode->i_flags & S_KERNEL_FILE))
>  		goto out;
>  
>  	error = security_inode_rmdir(dir, dentry);
> @@ -4463,12 +4464,21 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out;
>  
>  	shrink_dcache_parent(dentry);
> -	dentry->d_inode->i_flags |= S_DEAD;
> +	inode->i_flags |= S_DEAD;
>  	dont_mount(dentry);
>  	detach_mounts(dentry);
>  
>  out:
> -	inode_unlock(dentry->d_inode);
> +	/*
> +	 * The inode may be on the LRU list, so delete it from the LRU at this
> +	 * point in order to make sure that the inode is freed as soon as
> +	 * possible.
> +	 */
> +	spin_lock(&inode->i_lock);
> +	inode_lru_list_del(inode);
> +	spin_unlock(&inode->i_lock);
> +
> +	inode_unlock(inode);
>  	dput(dentry);
>  	if (!error)
>  		d_delete_notify(dir, dentry);
> @@ -4653,8 +4663,18 @@ int do_unlinkat(int dfd, struct filename *name)
>  		dput(dentry);
>  	}
>  	inode_unlock(path.dentry->d_inode);
> -	if (inode)
> +	if (inode) {
> +		/*
> +		 * The LRU may be holding a reference, remove the inode from the
> +		 * LRU here before dropping our hopefully final reference on the
> +		 * inode.
> +		 */
> +		spin_lock(&inode->i_lock);
> +		inode_lru_list_del(inode);
> +		spin_unlock(&inode->i_lock);
> +
>  		iput(inode);	/* truncate the inode here */
> +	}
>  	inode = NULL;
>  	if (delegated_inode) {
>  		error = break_deleg_wait(&delegated_inode);
> -- 
> 2.49.0
> 

