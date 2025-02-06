Return-Path: <linux-fsdevel+bounces-41074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666BCA2A9B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2F7A437F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1481624E0;
	Thu,  6 Feb 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4hJZ75L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45721EA7D0;
	Thu,  6 Feb 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848160; cv=none; b=bxN1lsj2yhurErjLfO8A1XJGJarIH9VyG2xLDSAUgnSyqLph6rUfX8xIno5rrAyciTWbgO2IrIxnKl9FV7vqLM8H3W56C9bP/Zhf9IphymOPKSjoGlfRO6nZ7kqdnFvoPgHMYvsn3AMUKL0YXe9l6VDnf4oKgSi8HP87lO1PqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848160; c=relaxed/simple;
	bh=E7aGuq8KgR9pSc3ZhIWYRUQk2M25H3YKV3wDss9W8ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfFiFHMMX9Sz3GRl+RhHLo2a5h68mbj8xVVrM7D/whkaPCs8RE1C4+l8rJgY8C6UeAiMfEszuMawzJiOCLr8SmXksmmF60NdFbpiXPOLRs6NgXSLn/Dwsdi9aXbI4mlIp8WAa4bFfCYM7uFj8LRCqR2PpJRVZqnDVPcrmsBcnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4hJZ75L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3EFC4CEDD;
	Thu,  6 Feb 2025 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738848159;
	bh=E7aGuq8KgR9pSc3ZhIWYRUQk2M25H3YKV3wDss9W8ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4hJZ75LBy6QaPPDuu3LyBVDpnRRm/ePajI061nWAXZiGsFBpBU1s2t3xKD2GAxIm
	 EyV8+So7vvzkDLh441OKVe86XjuvQowRrXxGBDMnzZEHinaLafhrZTbOer+fi4yS/h
	 mt0NT/4oC/GPn+Cm+8myEop7DaG/SMfoBULCM96HkrIx6mJuE+lnMIgyxo5acO7EiP
	 joF3jX1A9sEI6NPIQTxV8zvNzjkSC48yz1JD7qZo01RjFgGWWzWjZQxCr+hwynkRUZ
	 rTM/UtoKkwF3EBWolbJoHy2a9ALyNjTMy7mxNx0T3x7O9NJ7Pip92WTDMGrLhSOicp
	 drrX1DeVF1aKw==
Date: Thu, 6 Feb 2025 14:22:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/19] VFS: introduce inode flags to report locking needs
 for directory ops
Message-ID: <20250206-gasversorger-flugbereit-9eed46e951f9@brauner>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-11-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-11-neilb@suse.de>

On Thu, Feb 06, 2025 at 04:42:47PM +1100, NeilBrown wrote:
> If a filesystem supports _async ops for some directory ops we can take a
> "shared" lock on i_rwsem otherwise we must take an "exclusive" lock.  As
> the filesystem may support some async ops but not others we need to
> easily determine which.
> 
> With this patch we group the ops into 4 groups that are likely be
> supported together:
> 
> CREATE: create, link, mkdir, mknod
> REMOVE: rmdir, unlink
> RENAME: rename
> OPEN: atomic_open, create
> 
> and set S_ASYNC_XXX for each when the inode in initialised.
> 
> We also add a LOOKUP_REMOVE intent flag which will be used by locking
> interfaces to help know which group is being used.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/dcache.c           | 24 ++++++++++++++++++++++++
>  include/linux/fs.h    |  5 +++++
>  include/linux/namei.h |  5 +++--
>  3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index e49607d00d2d..37c0f655166d 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -384,6 +384,27 @@ static inline void __d_set_inode_and_type(struct dentry *dentry,
>  	smp_store_release(&dentry->d_flags, flags);
>  }
>  
> +static void set_inode_flags(struct inode *inode)
> +{
> +	const struct inode_operations *i_op = inode->i_op;
> +
> +	lockdep_assert_held(&inode->i_lock);
> +	if ((i_op->create_async || !i_op->create) &&
> +	    (i_op->link_async || !i_op->link) &&
> +	    (i_op->symlink_async || !i_op->symlink) &&
> +	    (i_op->mkdir_async || !i_op->mkdir) &&
> +	    (i_op->mknod_async || !i_op->mknod))
> +		inode->i_flags |= S_ASYNC_CREATE;
> +	if ((i_op->unlink_async || !i_op->unlink) &&
> +	    (i_op->mkdir_async || !i_op->mkdir))
> +		inode->i_flags |= S_ASYNC_REMOVE;
> +	if (i_op->rename_async)
> +		inode->i_flags |= S_ASYNC_RENAME;
> +	if (i_op->atomic_open_async ||
> +	    (!i_op->atomic_open && i_op->create_async))
> +		inode->i_flags |= S_ASYNC_OPEN;
> +}

I think this is unpleasant. As I said we should fold _async into the
normal methods. Then we can add:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f..1d19f72448fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2186,6 +2186,7 @@ int wrap_directory_iterator(struct file *, struct dir_context *,
        { return wrap_directory_iterator(file, ctx, x); }

 struct inode_operations {
+       iop_flags_t iop_flags;
        struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
        const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
        int (*permission) (struct mnt_idmap *, struct inode *, int);

which is similar to what I did for

struct file_operations {
        struct module *owner;
        fop_flags_t fop_flags;

and introduce

IOP_ASYNC_CREATE
IOP_ASYNC_OPEN

etc and then filesystems can just do:

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index df9669d4ded7..90c7aeb49466 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10859,6 +10859,7 @@ static void nfs4_disable_swap(struct inode *inode)
 }

 static const struct inode_operations nfs4_dir_inode_operations = {
+       .iop_flags      = IOP_ASYNC_CREATE | IOP_ASYNC_OPEN,
        .create         = nfs_create,
        .lookup         = nfs_lookup,
        .atomic_open    = nfs_atomic_open,

and then you can raise S_ASYNC_OPEN and so on based on the flags, not
the individual methods.

> +
>  static inline void __d_clear_type_and_inode(struct dentry *dentry)
>  {
>  	unsigned flags = READ_ONCE(dentry->d_flags);
> @@ -1893,6 +1914,7 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
>  	raw_write_seqcount_begin(&dentry->d_seq);
>  	__d_set_inode_and_type(dentry, inode, add_flags);
>  	raw_write_seqcount_end(&dentry->d_seq);
> +	set_inode_flags(inode);
>  	fsnotify_update_flags(dentry);
>  	spin_unlock(&dentry->d_lock);
>  }
> @@ -1999,6 +2021,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
>  
>  		spin_lock(&new->d_lock);
>  		__d_set_inode_and_type(new, inode, add_flags);
> +		set_inode_flags(inode);
>  		hlist_add_head(&new->d_u.d_alias, &inode->i_dentry);
>  		if (!disconnected) {
>  			hlist_bl_lock(&sb->s_roots);
> @@ -2701,6 +2724,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
>  		raw_write_seqcount_begin(&dentry->d_seq);
>  		__d_set_inode_and_type(dentry, inode, add_flags);
>  		raw_write_seqcount_end(&dentry->d_seq);
> +		set_inode_flags(inode);
>  		fsnotify_update_flags(dentry);
>  	}
>  	__d_rehash(dentry);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e414400c2487..9a9282fef347 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2361,6 +2361,11 @@ struct super_operations {
>  #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
>  #define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
>  
> +#define S_ASYNC_CREATE	BIT(18)	/* create, link, symlink, mkdir, mknod all _async */
> +#define S_ASYNC_REMOVE	BIT(19)	/* unlink, mkdir both _async */
> +#define S_ASYNC_RENAME	BIT(20) /* rename_async supported */
> +#define S_ASYNC_OPEN	BIT(21) /* atomic_open_async or create_async supported */
> +
>  /*
>   * Note that nosuid etc flags are inode-specific: setting some file-system
>   * flags just means all the inodes inherit those flags by default. It might be
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 76c587a5ec3a..72e351640406 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -40,10 +40,11 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
>  #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
>  #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
>  #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
> +#define LOOKUP_REMOVE		BIT(20)	/* ... in target of object removal */
>  
>  #define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
> -				 LOOKUP_RENAME_TARGET)
> -/* 4 spare bits for intent */
> +				 LOOKUP_RENAME_TARGET | LOOKUP_REMOVE)
> +/* 3 spare bits for intent */
>  
>  /* Scoping flags for lookup. */
>  #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
> -- 
> 2.47.1
> 

