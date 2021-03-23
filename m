Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FF2345D34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 12:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCWLoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 07:44:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhCWLn5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:43:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EEC8CAD71;
        Tue, 23 Mar 2021 11:43:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21887DA7AE; Tue, 23 Mar 2021 12:41:51 +0100 (CET)
Date:   Tue, 23 Mar 2021 12:41:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 04/18] btrfs: convert to miscattr
Message-ID: <20210323114150.GE7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-5-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322144916.137245-5-mszeredi@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:49:02PM +0100, Miklos Szeredi wrote:
> Use the miscattr API to let the VFS handle locking, permission checking and
> conversion.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Cc: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h |   3 +
>  fs/btrfs/inode.c |   4 +
>  fs/btrfs/ioctl.c | 249 +++++++++--------------------------------------
>  3 files changed, 52 insertions(+), 204 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index bd659354d043..c79886675c16 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3184,6 +3184,9 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
>  /* ioctl.c */
>  long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int btrfs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
> +int btrfs_miscattr_set(struct user_namespace *mnt_userns,
> +		       struct dentry *dentry, struct miscattr *ma);
>  int btrfs_ioctl_get_supported_features(void __user *arg);
>  void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
>  int __pure btrfs_is_empty_uuid(u8 *uuid);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2e1c282c202d..e21642f17396 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -10556,6 +10556,8 @@ static const struct inode_operations btrfs_dir_inode_operations = {
>  	.set_acl	= btrfs_set_acl,
>  	.update_time	= btrfs_update_time,
>  	.tmpfile        = btrfs_tmpfile,
> +	.miscattr_get	= btrfs_miscattr_get,
> +	.miscattr_set	= btrfs_miscattr_set,
>  };
>  
>  static const struct file_operations btrfs_dir_file_operations = {
> @@ -10609,6 +10611,8 @@ static const struct inode_operations btrfs_file_inode_operations = {
>  	.get_acl	= btrfs_get_acl,
>  	.set_acl	= btrfs_set_acl,
>  	.update_time	= btrfs_update_time,
> +	.miscattr_get	= btrfs_miscattr_get,
> +	.miscattr_set	= btrfs_miscattr_set,
>  };
>  static const struct inode_operations btrfs_special_inode_operations = {
>  	.getattr	= btrfs_getattr,
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 072e77726e94..5ce445a9a331 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -26,6 +26,7 @@
>  #include <linux/btrfs.h>
>  #include <linux/uaccess.h>
>  #include <linux/iversion.h>
> +#include <linux/miscattr.h>
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "export.h"
> @@ -153,16 +154,6 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
>  		      new_fl);
>  }
>  
> -static int btrfs_ioctl_getflags(struct file *file, void __user *arg)
> -{
> -	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
> -	unsigned int flags = btrfs_inode_flags_to_fsflags(binode->flags);
> -
> -	if (copy_to_user(arg, &flags, sizeof(flags)))
> -		return -EFAULT;
> -	return 0;
> -}
> -
>  /*
>   * Check if @flags are a supported and valid set of FS_*_FL flags and that
>   * the old and new flags are not conflicting
> @@ -201,9 +192,34 @@ static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
>  	return 0;
>  }
>  
> -static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
> +bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
> +			enum btrfs_exclusive_operation type)
>  {
> -	struct inode *inode = file_inode(file);
> +	return !cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE, type);
> +}
> +
> +void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
> +{
> +	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
> +	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
> +}

This function is moved around for no reason, it's not relevant for the
attributes in any way and is exported so there's no problem with
visibility eg. due to being static.

> +/*
> + * Set flags/xflags from the internal inode flags. The remaining items of
> + * fsxattr are zeroed.
> + */
> +int btrfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
> +{
> +	struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
> +
> +	miscattr_fill_flags(ma, btrfs_inode_flags_to_fsflags(binode->flags));
> +	return 0;
> +}
> +
> +int btrfs_miscattr_set(struct user_namespace *mnt_userns,
> +		       struct dentry *dentry, struct miscattr *ma)
> +{
> +	struct inode *inode = d_inode(dentry);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	struct btrfs_inode *binode = BTRFS_I(inode);
>  	struct btrfs_root *root = binode->root;
> @@ -213,34 +229,21 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  	const char *comp = NULL;
>  	u32 binode_flags;
>  
> -	if (!inode_owner_or_capable(&init_user_ns, inode))
> -		return -EPERM;
> -
>  	if (btrfs_root_readonly(root))
>  		return -EROFS;
>  
> -	if (copy_from_user(&fsflags, arg, sizeof(fsflags)))
> -		return -EFAULT;
> -
> -	ret = mnt_want_write_file(file);
> -	if (ret)
> -		return ret;
> +	if (miscattr_has_xattr(ma))
> +		return -EOPNOTSUPP;
>  
> -	inode_lock(inode);
> -	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
> +	fsflags = btrfs_mask_fsflags_for_type(inode, ma->flags);
>  	old_fsflags = btrfs_inode_flags_to_fsflags(binode->flags);
> -
> -	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
> -	if (ret)
> -		goto out_unlock;
> -
>  	ret = check_fsflags(old_fsflags, fsflags);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	ret = check_fsflags_compatible(fs_info, fsflags);
>  	if (ret)
> -		goto out_unlock;
> +		return ret;
>  
>  	binode_flags = binode->flags;
>  	if (fsflags & FS_SYNC_FL)
> @@ -263,6 +266,13 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  		binode_flags |= BTRFS_INODE_NOATIME;
>  	else
>  		binode_flags &= ~BTRFS_INODE_NOATIME;
> +
> +	/* if coming from FS_IOC_FSSETXATTR then skip unconverted flags */

	/* If coming from FS_IOC_FSSETXATTR then skip unconverted flags */

> +	if (!ma->flags_valid) {
> +		trans = btrfs_start_transaction(root, 1);
> +		goto update_flags;
> +	}
> +
>  	if (fsflags & FS_DIRSYNC_FL)
>  		binode_flags |= BTRFS_INODE_DIRSYNC;
>  	else
> @@ -303,10 +313,8 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  		binode_flags |= BTRFS_INODE_NOCOMPRESS;
>  	} else if (fsflags & FS_COMPR_FL) {
>  
> -		if (IS_SWAPFILE(inode)) {
> -			ret = -ETXTBSY;
> -			goto out_unlock;
> -		}
> +		if (IS_SWAPFILE(inode))
> +			return -ETXTBSY;
>  
>  		binode_flags |= BTRFS_INODE_COMPRESS;
>  		binode_flags &= ~BTRFS_INODE_NOCOMPRESS;
> @@ -323,10 +331,8 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  	 * 2 for properties
>  	 */
>  	trans = btrfs_start_transaction(root, 3);
> -	if (IS_ERR(trans)) {
> -		ret = PTR_ERR(trans);
> -		goto out_unlock;
> -	}
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
>  
>  	if (comp) {
>  		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp,
> @@ -344,6 +350,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  		}
>  	}
>  
> +update_flags:
>  	binode->flags = binode_flags;
>  	btrfs_sync_inode_flags_to_i_flags(inode);
>  	inode_inc_iversion(inode);
> @@ -352,158 +359,6 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
>  
>   out_end_trans:
>  	btrfs_end_transaction(trans);
> - out_unlock:
> -	inode_unlock(inode);
> -	mnt_drop_write_file(file);
> -	return ret;
> -}
> -
> -/*
> - * Translate btrfs internal inode flags to xflags as expected by the
> - * FS_IOC_FSGETXATT ioctl. Filter only the supported ones, unknown flags are
> - * silently dropped.
> - */
> -static unsigned int btrfs_inode_flags_to_xflags(unsigned int flags)
> -{
> -	unsigned int xflags = 0;
> -
> -	if (flags & BTRFS_INODE_APPEND)
> -		xflags |= FS_XFLAG_APPEND;
> -	if (flags & BTRFS_INODE_IMMUTABLE)
> -		xflags |= FS_XFLAG_IMMUTABLE;
> -	if (flags & BTRFS_INODE_NOATIME)
> -		xflags |= FS_XFLAG_NOATIME;
> -	if (flags & BTRFS_INODE_NODUMP)
> -		xflags |= FS_XFLAG_NODUMP;
> -	if (flags & BTRFS_INODE_SYNC)
> -		xflags |= FS_XFLAG_SYNC;
> -
> -	return xflags;
> -}
> -
> -/* Check if @flags are a supported and valid set of FS_XFLAGS_* flags */
> -static int check_xflags(unsigned int flags)
> -{
> -	if (flags & ~(FS_XFLAG_APPEND | FS_XFLAG_IMMUTABLE | FS_XFLAG_NOATIME |
> -		      FS_XFLAG_NODUMP | FS_XFLAG_SYNC))
> -		return -EOPNOTSUPP;
> -	return 0;
> -}
> -
> -bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
> -			enum btrfs_exclusive_operation type)
> -{
> -	return !cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE, type);
> -}
> -
> -void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
> -{
> -	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
> -	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
> -}

Same, btrfs_exclop_start and btrfs_exclop_finish are not relevant to the
attributes.

> -
> -/*
> - * Set the xflags from the internal inode flags. The remaining items of fsxattr
> - * are zeroed.
> - */
> -static int btrfs_ioctl_fsgetxattr(struct file *file, void __user *arg)
> -{
> -	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
> -	struct fsxattr fa;
> -
> -	simple_fill_fsxattr(&fa, btrfs_inode_flags_to_xflags(binode->flags));
> -	if (copy_to_user(arg, &fa, sizeof(fa)))
> -		return -EFAULT;
> -
> -	return 0;
> -}
> -
> -static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
> -{
> -	struct inode *inode = file_inode(file);
> -	struct btrfs_inode *binode = BTRFS_I(inode);
> -	struct btrfs_root *root = binode->root;
> -	struct btrfs_trans_handle *trans;
> -	struct fsxattr fa, old_fa;
> -	unsigned old_flags;
> -	unsigned old_i_flags;
> -	int ret = 0;
> -
> -	if (!inode_owner_or_capable(&init_user_ns, inode))
> -		return -EPERM;
> -
> -	if (btrfs_root_readonly(root))
> -		return -EROFS;
> -
> -	if (copy_from_user(&fa, arg, sizeof(fa)))
> -		return -EFAULT;
> -
> -	ret = check_xflags(fa.fsx_xflags);
> -	if (ret)
> -		return ret;
> -
> -	if (fa.fsx_extsize != 0 || fa.fsx_projid != 0 || fa.fsx_cowextsize != 0)
> -		return -EOPNOTSUPP;
> -
> -	ret = mnt_want_write_file(file);
> -	if (ret)
> -		return ret;
> -
> -	inode_lock(inode);
> -
> -	old_flags = binode->flags;
> -	old_i_flags = inode->i_flags;
> -
> -	simple_fill_fsxattr(&old_fa,
> -			    btrfs_inode_flags_to_xflags(binode->flags));
> -	ret = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
> -	if (ret)
> -		goto out_unlock;
> -
> -	if (fa.fsx_xflags & FS_XFLAG_SYNC)
> -		binode->flags |= BTRFS_INODE_SYNC;
> -	else
> -		binode->flags &= ~BTRFS_INODE_SYNC;
> -	if (fa.fsx_xflags & FS_XFLAG_IMMUTABLE)
> -		binode->flags |= BTRFS_INODE_IMMUTABLE;
> -	else
> -		binode->flags &= ~BTRFS_INODE_IMMUTABLE;
> -	if (fa.fsx_xflags & FS_XFLAG_APPEND)
> -		binode->flags |= BTRFS_INODE_APPEND;
> -	else
> -		binode->flags &= ~BTRFS_INODE_APPEND;
> -	if (fa.fsx_xflags & FS_XFLAG_NODUMP)
> -		binode->flags |= BTRFS_INODE_NODUMP;
> -	else
> -		binode->flags &= ~BTRFS_INODE_NODUMP;
> -	if (fa.fsx_xflags & FS_XFLAG_NOATIME)
> -		binode->flags |= BTRFS_INODE_NOATIME;
> -	else
> -		binode->flags &= ~BTRFS_INODE_NOATIME;
> -
> -	/* 1 item for the inode */

This comment hasn't been copied to btrfs_miscattr_set where the
transaction is started.

> -	trans = btrfs_start_transaction(root, 1);

Other than that it looks that the conversion is complete, but I'll do
another review round once you send and update.

I think you should enhance description in each per-fs conversion so the
patch is readable standalone, eg. mentioning that the miscattr API wraps
all the other attributes, enumerate them and note that the specific code
handling them is deleted. Thanks.
