Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769B6346BF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhCWWQC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbhCWWPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:15:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8CC061574;
        Tue, 23 Mar 2021 15:15:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 567541F454D0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, smcv@collabora.com,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: [RFC PATCH 3/4] mm: shmem: Add IOCTL support for tmpfs
Organization: Collabora
References: <20210323195941.69720-1-andrealmeid@collabora.com>
        <20210323195941.69720-4-andrealmeid@collabora.com>
Date:   Tue, 23 Mar 2021 18:15:01 -0400
In-Reply-To: <20210323195941.69720-4-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Tue, 23 Mar 2021 16:59:40 -0300")
Message-ID: <87tup1bjq2.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Implement IOCTL operations for files to set/get file flags. Implement
> the only supported flag by now, that is S_CASEFOLD.
>
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  include/linux/shmem_fs.h |  4 ++
>  mm/shmem.c               | 84 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 29ee64352807..2c89c5a66508 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -140,4 +140,8 @@ extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
>  				 dst_addr)      ({ BUG(); 0; })
>  #endif
>  
> +#define TMPFS_CASEFOLD_FL	0x40000000 /* Casefolded file */
> +#define TMPFS_USER_FLS		TMPFS_CASEFOLD_FL /* Userspace supported flags */
> +#define TMPFS_FLS		S_CASEFOLD /* Kernel supported flags */

Minor nit: FLS?  _FLAGS is short enough :).

> +
>  #endif
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 20df81763995..2f2c996d215b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -258,6 +258,7 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
>  static const struct super_operations shmem_ops;
>  const struct address_space_operations shmem_aops;
>  static const struct file_operations shmem_file_operations;
> +static const struct file_operations shmem_dir_operations;
>  static const struct inode_operations shmem_inode_operations;
>  static const struct inode_operations shmem_dir_inode_operations;
>  static const struct inode_operations shmem_special_inode_operations;
> @@ -2347,7 +2348,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>  			/* Some things misbehave if size == 0 on a directory */
>  			inode->i_size = 2 * BOGO_DIRENT_SIZE;
>  			inode->i_op = &shmem_dir_inode_operations;
> -			inode->i_fop = &simple_dir_operations;
> +			inode->i_fop = &shmem_dir_operations;
>  			break;
>  		case S_IFLNK:
>  			/*
> @@ -2838,6 +2839,76 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>  	return error;
>  }
>  
> +static long shmem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	int ret;
> +	u32 fsflags = 0, old, new = 0;
> +	struct inode *inode = file_inode(file);
> +	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
> +
> +	switch (cmd) {
> +	case FS_IOC_GETFLAGS:
> +		if ((inode->i_flags & S_CASEFOLD) && S_ISDIR(inode->i_mode))
> +			fsflags |= TMPFS_CASEFOLD_FL;
> +
> +		if (put_user(fsflags, (int __user *)arg))
> +			return -EFAULT;
> +
> +		return 0;
> +
> +	case FS_IOC_SETFLAGS:
> +		if (get_user(fsflags, (int __user *)arg))
> +			return -EFAULT;
> +
> +		old = inode->i_flags;
> +
> +		if (fsflags & ~TMPFS_USER_FLS)
> +			return -EINVAL;
> +
> +		if (fsflags & TMPFS_CASEFOLD_FL) {
> +			if (!sbinfo->casefold) {
> +				pr_err("tmpfs: casefold disabled at this mount point\n");

Minor nit: no point in logging an error here.  The user has simply not
enabled casefolding.  The error returned below should be enough.

> +				return -EOPNOTSUPP;
> +			}
> +
> +			if (!S_ISDIR(inode->i_mode))
> +				return -ENOTDIR;
> +
> +			if (!simple_empty(file_dentry(file)))
> +				return -ENOTEMPTY;
> +
> +			new |= S_CASEFOLD;
> +		} else if (old & S_CASEFOLD) {
> +			if (!simple_empty(file_dentry(file)))
> +				return -ENOTEMPTY;
> +		}
> +
> +		ret = mnt_want_write_file(file);
> +		if (ret)
> +			return ret;
> +
> +		inode_lock(inode);
> +
> +		ret = vfs_ioc_setflags_prepare(inode, old, new);
> +		if (ret) {
> +			inode_unlock(inode);
> +			mnt_drop_write_file(file);
> +			return ret;
> +		}
> +
> +		inode_set_flags(inode, new, TMPFS_FLS);
> +
> +		inode_unlock(inode);
> +		mnt_drop_write_file(file);
> +		return 0;
> +
> +	default:
> +		return -ENOTTY;
> +	}
> +
> +	return 0;
> +}
> +
>  static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
> @@ -3916,6 +3987,7 @@ static const struct file_operations shmem_file_operations = {
>  	.splice_read	= generic_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= shmem_fallocate,
> +	.unlocked_ioctl = shmem_ioctl,
>  #endif
>  };
>  
> @@ -3928,6 +4000,16 @@ static const struct inode_operations shmem_inode_operations = {
>  #endif
>  };
>  
> +static const struct file_operations shmem_dir_operations = {
> +	.open		= dcache_dir_open,
> +	.release	= dcache_dir_close,
> +	.llseek		= dcache_dir_lseek,
> +	.read		= generic_read_dir,
> +	.iterate_shared	= dcache_readdir,
> +	.fsync		= noop_fsync,
> +	.unlocked_ioctl = shmem_ioctl,
> +};
> +
>  static const struct inode_operations shmem_dir_inode_operations = {
>  #ifdef CONFIG_TMPFS
>  	.create		= shmem_create,

-- 
Gabriel Krisman Bertazi
