Return-Path: <linux-fsdevel+bounces-59478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97468B39A8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE4E170D38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3430C615;
	Thu, 28 Aug 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApSX0+/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86D25D549;
	Thu, 28 Aug 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377838; cv=none; b=TbKVy3GLZ9AbCgemXw+N05l5Pobtd+UWVyaj9G3CHHFduUB3+o5Cw0XqIfFm9LWQvMf41vk1I7i+gk+kov9da3UqWIp8n/JGTBxXUbgp4F6zO855rPDlE4I/8s2mDoczJ9WZQ0/sDjH7m2jhD1oSXic/0Y3z5iAS1AwWvF/Mn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377838; c=relaxed/simple;
	bh=Ud5LkHBi0UVhCbTH/RwocCS9I+67FF1ERYrez+561z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1J8GkGVy56NKy+lAV5A9WCCXysHiUp6N3iKbaitOYfPHgDWAJEfgl1/4fQgsRAPHxeT/MSxoJmbc76lcD5TRYNP3G3xbB/zfYt3kxFaDliCwr/beKDS0nyEExu1F5yw7ZLlwaxcQrUf7pQuhzRl0CXXKArsqi2AFvpgNGyexBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApSX0+/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3891AC4CEF4;
	Thu, 28 Aug 2025 10:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756377838;
	bh=Ud5LkHBi0UVhCbTH/RwocCS9I+67FF1ERYrez+561z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApSX0+/ctbcaSTJyEoRsFJYyLN6+vT/oeUov8XFkW5Q9bumJGu0ftctj38uRY8HX6
	 18hiYlERJPekAKn7AkcQwY61zk8m9tE7NIONg5qLSm7TgrQ5DRzhtaDHwouN4AC7hW
	 u5A382DxBdZDh6zXEy3qepmzmKZcA/Hf9JqsWGGE0UIIJZspPQApqrKw0/Sc2X6G+I
	 YezF2GDUnaQ8OYOvzz85xUpFQSdOQyYP1rOzno4nLt0q/cKABdmNdNhgBbqaFLcwDe
	 PVky3YZ8HSX7TVZWNEoyi0A2vZKfZ7x/i3lAIj6O53F809QmvMFor7hkGfTBv8v+cg
	 ctCPPe8V/o2KQ==
Date: Thu, 28 Aug 2025 12:43:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 17/54] fs: remove the inode from the LRU list on
 unlink/rmdir
Message-ID: <20250828-rockermilieu-absender-ae4d11591ec9@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <3552943716349efa4ff107bb590ac6b980183735.1756222465.git.josef@toxicpanda.com>
 <20250828-leiden-getan-25237f019cf1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828-leiden-getan-25237f019cf1@brauner>

On Thu, Aug 28, 2025 at 11:06:37AM +0200, Christian Brauner wrote:
> On Tue, Aug 26, 2025 at 11:39:17AM -0400, Josef Bacik wrote:
> > We can end up with an inode on the LRU list or the cached list, then at
> > some point in the future go to unlink that inode and then still have an
> > elevated i_count reference for that inode because it is on one of these
> > lists.
> > 
> > The more common case is the cached list. We open a file, write to it,
> > truncate some of it which triggers the inode_add_lru code in the
> > pagecache, adding it to the cached LRU.  Then we unlink this inode, and
> > it exists until writeback or reclaim kicks in and removes the inode.
> > 
> > To handle this case, delete the inode from the LRU list when it is
> > unlinked, so we have the best case scenario for immediately freeing the
> > inode.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/namei.c | 30 +++++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 138a693c2346..e56dcb5747e4 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4438,6 +4438,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
> >  int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> >  		     struct dentry *dentry)
> >  {
> > +	struct inode *inode = dentry->d_inode;
> >  	int error = may_delete(idmap, dir, dentry, 1);
> >  
> >  	if (error)
> > @@ -4447,11 +4448,11 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> >  		return -EPERM;
> >  
> >  	dget(dentry);
> > -	inode_lock(dentry->d_inode);
> > +	inode_lock(inode);
> >  
> >  	error = -EBUSY;
> >  	if (is_local_mountpoint(dentry) ||
> > -	    (dentry->d_inode->i_flags & S_KERNEL_FILE))
> > +	    (inode->i_flags & S_KERNEL_FILE))
> >  		goto out;
> >  
> >  	error = security_inode_rmdir(dir, dentry);
> > @@ -4463,12 +4464,21 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
> >  		goto out;
> >  
> >  	shrink_dcache_parent(dentry);
> > -	dentry->d_inode->i_flags |= S_DEAD;
> > +	inode->i_flags |= S_DEAD;
> >  	dont_mount(dentry);
> >  	detach_mounts(dentry);
> >  
> >  out:
> > -	inode_unlock(dentry->d_inode);
> > +	/*
> > +	 * The inode may be on the LRU list, so delete it from the LRU at this
> > +	 * point in order to make sure that the inode is freed as soon as
> > +	 * possible.
> > +	 */
> > +	spin_lock(&inode->i_lock);
> > +	inode_lru_list_del(inode);
> > +	spin_unlock(&inode->i_lock);
> > +
> > +	inode_unlock(inode);
> >  	dput(dentry);
> >  	if (!error)
> >  		d_delete_notify(dir, dentry);
> > @@ -4653,8 +4663,18 @@ int do_unlinkat(int dfd, struct filename *name)
> >  		dput(dentry);
> 
> Why are you doing that in do_unlinkat() instead of vfs_unlink() (as
> you're doing it in vfs_rmdir() and not do_rmdir())?
> 
> Doing it in do_unlinkat() means any stacking filesystem such as
> overlayfs will end up skipping the LRU list removal as they use
> vfs_unlink() directly.
> 
> And does btrfs subvolume/snapshot deletion special treatment as well for
> this as it's semantically equivalent to an rmdir?

Another thing. If this is unlinking an inode with multiple hardlinks
then vfs_unlink() might not remove the inode if it's not the last
hardlink. Do you really want to remove the inode from the LRU list in
that case as well?

> >  	}
> >  	inode_unlock(path.dentry->d_inode);
> > -	if (inode)
> > +	if (inode) {
> > +		/*
> > +		 * The LRU may be holding a reference, remove the inode from the
> > +		 * LRU here before dropping our hopefully final reference on the
> > +		 * inode.
> > +		 */
> > +		spin_lock(&inode->i_lock);
> > +		inode_lru_list_del(inode);
> > +		spin_unlock(&inode->i_lock);
> > +
> >  		iput(inode);	/* truncate the inode here */
> > +	}
> >  	inode = NULL;
> >  	if (delegated_inode) {
> >  		error = break_deleg_wait(&delegated_inode);
> > -- 
> > 2.49.0
> > 

