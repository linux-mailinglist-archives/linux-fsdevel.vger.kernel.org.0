Return-Path: <linux-fsdevel+bounces-37994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C349F9DAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 02:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CE7A1FC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD817588;
	Sat, 21 Dec 2024 01:21:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6110F2
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744107; cv=none; b=c4iYwXj4hM0c/5u70XATWsyOtkNi4jHfkiA6re3aWBIBGzbOXMrOsa2fyjqb8QeDpJRlqXkb3LM1LlhxILouUhZ63nSs1ROaYE6oS48Ex++6L2zqja5z1zd9H8ens+vCOT2I2NdX5yIdoHNU7pL0yO3YmIRFj/nP6XwV1VAcDzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744107; c=relaxed/simple;
	bh=SSVXfIwCYLlRynLUZ/XpRx7cJQNwSNNm8pLeqZZO5rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVuk/6QNpiw6UFeyBbOBKrdTqWxogXH4FACvzTkthE81b3zx2UgaIiN8gS8JFdCmz0gCjB4tuTVpZyybcJwwLoJRweHlgza76iD0CU/aan5e29QN/totaPsMbMjIoBvsO3/5odmIt7Tw2OUgRLLY+pa2Yyyu+XGRc74pI3e9DLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.150])
	by sina.com (10.185.250.22) with ESMTP
	id 6766181C000024A7; Sat, 21 Dec 2024 09:21:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7878927602662
X-SMAIL-UIID: 28EB3B370EC34327B11C69BE0C58A134-20241221-092134-1
From: Hillf Danton <hdanton@sina.com>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] VFS: add inode_dir_lock/unlock
Date: Sat, 21 Dec 2024 09:21:20 +0800
Message-ID: <20241221012128.307-1-hdanton@sina.com>
In-Reply-To: <20241220030830.272429-9-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Dec 2024 13:54:26 +1100 NeilBrown <neilb@suse.de>
> During the transition from providing exclusive locking on the directory
> for directory modifying operation to providing exclusive locking only on
> the dentry with a shared lock on the directory - we need an alternate
> way to provide exclusion on the directory for file systems which haven't
> been converted.  This is provided by inode_dir_lock() and
> inode_dir_inlock().
> This uses a bit in i_state for locking, and wait_var_event_spinlock() for
> waiting.
> 
Inventing anything like mutex sounds bad.

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/inode.c         |  3 ++
>  fs/namei.c         | 81 +++++++++++++++++++++++++++++++++++++---------
>  include/linux/fs.h |  5 +++
>  3 files changed, 74 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 6b4c77268fc0..9ba69837aa56 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -492,6 +492,8 @@ EXPORT_SYMBOL(address_space_init_once);
>   */
>  void inode_init_once(struct inode *inode)
>  {
> +	static struct lock_class_key __key;
> +
>  	memset(inode, 0, sizeof(*inode));
>  	INIT_HLIST_NODE(&inode->i_hash);
>  	INIT_LIST_HEAD(&inode->i_devices);
> @@ -501,6 +503,7 @@ void inode_init_once(struct inode *inode)
>  	INIT_LIST_HEAD(&inode->i_sb_list);
>  	__address_space_init_once(&inode->i_data);
>  	i_size_ordered_init(inode);
> +	lockdep_init_map(&inode->i_dirlock_map, "I_DIR_LOCKED", &__key, 0);
>  }
>  EXPORT_SYMBOL(inode_init_once);
>  
> diff --git a/fs/namei.c b/fs/namei.c
> index 371c80902c59..68750b15dbf4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3364,6 +3364,34 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
>  	return mode;
>  }
>  
> +static bool check_dir_locked(struct inode *dir)
> +{
> +	if (dir->i_state & I_DIR_LOCKED) {
> +		dir->i_state |= I_DIR_LOCK_WAITER;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static void inode_lock_dir(struct inode *dir)
> +{
> +	lock_acquire_exclusive(&dir->i_dirlock_map, 0, 0, NULL, _THIS_IP_);
> +	spin_lock(&dir->i_lock);
> +	wait_var_event_spinlock(dir, !check_dir_locked(dir),
> +				&dir->i_lock);
> +	dir->i_state |= I_DIR_LOCKED;
> +	spin_unlock(&dir->i_lock);
> +}
> +
> +static void inode_unlock_dir(struct inode *dir)
> +{
> +	lock_map_release(&dir->i_dirlock_map);
> +	spin_lock(&dir->i_lock);
> +	dir->i_state &= ~(I_DIR_LOCKED | I_DIR_LOCK_WAITER);
> +	wake_up_var_locked(dir, &dir->i_lock);
> +	spin_unlock(&dir->i_lock);
> +}
> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -3396,10 +3424,13 @@ int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
>  	error = security_inode_create(dir, dentry, mode);
>  	if (error)
>  		return error;
> -	if (dir->i_op->create_shared)
> +	if (dir->i_op->create_shared) {
>  		error = dir->i_op->create_shared(idmap, dir, dentry, mode, want_excl);
> -	else
> +	} else {
> +		inode_lock_dir(dir);
>  		error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
> +		inode_unlock_dir(dir);
> +	}
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -3699,16 +3730,19 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		file->f_mode |= FMODE_CREATED;
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>  
> -		if (dir_inode->i_op->create_shared)
> +		if (dir_inode->i_op->create_shared) {
>  			error = dir_inode->i_op->create_shared(idmap, dir_inode,
>  							       dentry, mode,
>  							       open_flag & O_EXCL);
> -		else if (dir_inode->i_op->create)
> +		} else if (dir_inode->i_op->create) {
> +			inode_lock_dir(dir_inode);
>  			error = dir_inode->i_op->create(idmap, dir_inode,
>  							dentry, mode,
>  							open_flag & O_EXCL);
> -		else
> +			inode_unlock_dir(dir_inode);
> +		} else {
>  			error = -EACCES;
> +		}
>  		if (error)
>  			goto out_dput;
>  	}
> @@ -4227,10 +4261,13 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	if (dir->i_op->mknod_shared)
> +	if (dir->i_op->mknod_shared) {
>  		error = dir->i_op->mknod_shared(idmap, dir, dentry, mode, dev);
> -	else
> +	} else {
> +		inode_lock_dir(dir);
>  		error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
> +		inode_unlock_dir(dir);
> +	}
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -4360,7 +4397,9 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  		else if (de)
>  			dput(de);
>  	} else {
> +		inode_lock_dir(dir);
>  		error = dir->i_op->mkdir(idmap, dir, dentry, mode);
> +		inode_unlock_dir(dir);
>  	}
>  	if (!error)
>  		fsnotify_mkdir(dir, dentry);
> @@ -4521,10 +4560,13 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		goto out;
>  
> -	if (dir->i_op->rmdir_shared)
> +	if (dir->i_op->rmdir_shared) {
>  		error = dir->i_op->rmdir_shared(dir, dentry);
> -	else
> +	} else {
> +		inode_lock_dir(dir);
>  		error = dir->i_op->rmdir(dir, dentry);
> +		inode_unlock_dir(dir);
> +	}
>  	if (error)
>  		goto out;
>  
> @@ -4648,10 +4690,13 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
>  			error = try_break_deleg(target, delegated_inode);
>  			if (error)
>  				goto out;
> -			if (dir->i_op->unlink_shared)
> +			if (dir->i_op->unlink_shared) {
>  				error = dir->i_op->unlink_shared(dir, dentry);
> -			else
> +			} else {
> +				inode_lock_dir(dir);
>  				error = dir->i_op->unlink(dir, dentry);
> +				inode_unlock_dir(dir);
> +			}
>  			if (!error) {
>  				dont_mount(dentry);
>  				detach_mounts(dentry);
> @@ -4792,10 +4837,13 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	if (error)
>  		return error;
>  
> -	if (dir->i_op->symlink_shared)
> +	if (dir->i_op->symlink_shared) {
>  		error = dir->i_op->symlink_shared(idmap, dir, dentry, oldname);
> -	else
> +	} else {
> +		inode_lock_dir(dir);
>  		error = dir->i_op->symlink(idmap, dir, dentry, oldname);
> +		inode_unlock_dir(dir);
> +	}
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -4920,10 +4968,13 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  		error = try_break_deleg(inode, delegated_inode);
>  		if (error)
>  			;
> -		else if (dir->i_op->link_shared)
> +		else if (dir->i_op->link_shared) {
>  			error = dir->i_op->link_shared(old_dentry, dir, new_dentry);
> -		else
> +		} else {
> +			inode_lock_dir(dir);
>  			error = dir->i_op->link(old_dentry, dir, new_dentry);
> +			inode_unlock_dir(dir);
> +		}
>  	}
>  
>  	if (!error && (inode->i_state & I_LINKABLE)) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 68eba181175b..3ca92a54f28e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -722,6 +722,8 @@ struct inode {
>  		void (*free_inode)(struct inode *);
>  	};
>  	struct file_lock_context	*i_flctx;
> +
> +	struct lockdep_map	i_dirlock_map;	/* For tracking I_DIR_LOCKED locks */

The cost of this map says no to any attempt inventing mutex in any form.

