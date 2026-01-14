Return-Path: <linux-fsdevel+bounces-73655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE19D1DFCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C91403063E70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1B3876CF;
	Wed, 14 Jan 2026 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c+oFxyzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440FB322B69;
	Wed, 14 Jan 2026 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385917; cv=none; b=p0CAqKFzQDqH9giXe6KwDHnfA5YxiRx19FOd+btIBbktirK5weS2G4mEmz9MoAzB2BCofbjnpT9XutQpRQPnVtK8FiqYcEnVB02l80dxej7GFlE3UZLP09ZvhjcE6uAFgN4FgwE/1n7YtBwu8Zz3c3iUvPgu0HTMA9tQHskWgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385917; c=relaxed/simple;
	bh=jxAvK+0MQQ93n0Ly0Iu9Zaub8TeqLO9CtBxKE80ghAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kp01JXOHnWmOanti8C3bjVOeU8DAbGA2jb62xJuQYOHz3QfQnrtMDqKWG5Xbx8MkG8o7rK2umkC1C0ilNSG0T0pJ/ql3OnUcHtERyXKwveUmzVUiThRAW7NQlb8Vb3/cFjnHlKl9laKTrHxgncdrk+Mtd4AdueTUFvti1r6Y8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c+oFxyzy; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768385905; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o00tZO1BRqDla6LLYZnqwEjDn3GXeSgVcSia+LuUZc8=;
	b=c+oFxyzyRWXq6gwDP67UFqJMtC9UsZd+JcdMNJJoz3pLjsc2/sibzWH6z8ar2r371MoRdY0yhMlzaDvXTzWrVRTCYEo/rGuxVzllJ7Hm2yA9a2JBuwgzmab1BXAoeuB2apzU4MA4DM26aFqiCWpLoIl1mTGpV1flA6n4SXIQpT4=
Received: from 30.221.131.219(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx26M8._1768385904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 18:18:25 +0800
Message-ID: <6defede0-2d2f-4193-8eb1-a1e1d842a8e3@linux.alibaba.com>
Date: Wed, 14 Jan 2026 18:18:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260109102856.598531-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260109102856.598531-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/9 18:28, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading
> identical files (e.g., *.so files) from two different minor versions of
> container images will cost multiple copies of the same page cache,
> since different containers have different mount points. Therefore,
> sharing the page cache for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. It allocate a
> deduplicated inode and use its page cache as shared. Reads for files
> with identical content will ultimately be routed to the page cache of
> the deduplicated inode. In this way, a single page cache satisfies
> multiple read requests for different files with the same contents.
> 
> We introduce inode_share mount option to enable the page sharing mode
> during mounting.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   Documentation/filesystems/erofs.rst |   5 +
>   fs/erofs/Makefile                   |   1 +
>   fs/erofs/internal.h                 |  31 ++++++
>   fs/erofs/ishare.c                   | 165 ++++++++++++++++++++++++++++
>   fs/erofs/super.c                    |  53 ++++++++-
>   fs/erofs/xattr.c                    |  32 ++++++
>   fs/erofs/xattr.h                    |   3 +
>   7 files changed, 288 insertions(+), 2 deletions(-)
>   create mode 100644 fs/erofs/ishare.c
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 08194f194b94..27d3caa3c73c 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra device to be used together.
>   fsid=%s                Specify a filesystem image ID for Fscache back-end.
>   domain_id=%s           Specify a domain ID in fscache mode so that different images
>                          with the same blobs under a given domain ID can share storage.
> +                       Also used for inode page sharing mode which defines a sharing
> +                       domain.
>   fsoffset=%llu          Specify block-aligned filesystem offset for the primary device.
> +inode_share            Enable inode page sharing for this filesystem.  Inodes with
> +                       identical content within the same domain ID can share the
> +                       page cache.
>   ===================    =========================================================
>   
>   Sysfs Entries
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 549abc424763..a80e1762b607 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index ec79e8b44d3b..810fc4675091 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -179,6 +179,7 @@ struct erofs_sb_info {
>   #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
>   #define EROFS_MOUNT_DAX_NEVER		0x00000080
>   #define EROFS_MOUNT_DIRECT_IO		0x00000100
> +#define EROFS_MOUNT_INODE_SHARE		0x00000200
>   
>   #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
>   #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
> @@ -269,6 +270,11 @@ static inline u64 erofs_nid_to_ino64(struct erofs_sb_info *sbi, erofs_nid_t nid)
>   /* default readahead size of directories */
>   #define EROFS_DIR_RA_BYTES	16384
>   
> +struct erofs_inode_fingerprint {
> +	u8 *opaque;
> +	int size;
> +};
> +
>   struct erofs_inode {
>   	erofs_nid_t nid;
>   
> @@ -304,6 +310,18 @@ struct erofs_inode {
>   		};
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	};
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	struct list_head ishare_list;
> +	union {
> +		/* for each anon shared inode */
> +		struct {
> +			struct erofs_inode_fingerprint fingerprint;
> +			spinlock_t ishare_lock;
> +		};
> +		/* for each real inode */
> +		struct inode *sharedinode;
> +	};
> +#endif
>   	/* the corresponding vfs inode */
>   	struct inode vfs_inode;
>   };
> @@ -410,6 +428,7 @@ extern const struct inode_operations erofs_dir_iops;
>   
>   extern const struct file_operations erofs_file_fops;
>   extern const struct file_operations erofs_dir_fops;
> +extern const struct file_operations erofs_ishare_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> @@ -541,6 +560,18 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>   #endif
>   
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +int __init erofs_init_ishare(void);
> +void erofs_exit_ishare(void);
> +bool erofs_ishare_fill_inode(struct inode *inode);
> +void erofs_ishare_free_inode(struct inode *inode);
> +#else
> +static inline int erofs_init_ishare(void) { return 0; }
> +static inline void erofs_exit_ishare(void) {}
> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +#endif
> +
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>   			unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> new file mode 100644
> index 000000000000..36d9d5922a75
> --- /dev/null
> +++ b/fs/erofs/ishare.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include <linux/xxhash.h>
> +#include <linux/mount.h>
> +#include "internal.h"
> +#include "xattr.h"
> +
> +#include "../internal.h"
> +
> +static struct vfsmount *erofs_ishare_mnt;
> +
> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
> +{
> +	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
> +	struct erofs_inode_fingerprint *fp2 = data;
> +
> +	return fp1->size == fp2->size &&
> +		!memcmp(fp1->opaque, fp2->opaque, fp2->size);
> +}
> +
> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +
> +	vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
> +	INIT_LIST_HEAD(&vi->ishare_list);
> +	spin_lock_init(&vi->ishare_lock);
> +	return 0;
> +}
> +
> +bool erofs_ishare_fill_inode(struct inode *inode)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct erofs_inode_fingerprint fp;
> +	struct inode *sharedinode;
> +	unsigned long hash;
> +
> +	if (erofs_xattr_fill_inode_fingerprint(&fp, inode, sbi->domain_id))
> +		return false;
> +	hash = xxh32(fp.opaque, fp.size, 0);
> +	sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
> +				   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
> +				   &fp);
> +	if (!sharedinode) {
> +		kfree(fp.opaque);
> +		return false;
> +	}
> +
> +	vi->sharedinode = sharedinode;
> +	if (inode_state_read_once(sharedinode) & I_NEW) {
> +		if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +			sharedinode->i_mapping->a_ops = &z_erofs_aops;

It seems that it caused a build warning:
https://lore.kernel.org/r/202601130827.dHbGXL3Y-lkp@intel.com

> +		} else {
> +			sharedinode->i_mapping->a_ops = &erofs_aops;
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +			if (erofs_is_fileio_mode(sbi))
> +				sharedinode->i_mapping->a_ops = &erofs_fileio_aops;
> +#endif
> +		}

Can we introduce a new helper for those aops setting? such as:

void erofs_inode_set_aops(struct erofs_inode *inode,
			  struct erofs_inode *realinode, bool no_fscache)
{
	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
#ifdef CONFIG_EROFS_FS_ZIP
		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
				erofs_info, realinode->i_sb,
         	                  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
		inode->i_mapping->a_ops = &z_erofs_aops;
#else
		err = -EOPNOTSUPP;
#endif
         } else {
                 inode->i_mapping->a_ops = &erofs_aops;
#ifdef CONFIG_EROFS_FS_ONDEMAND
                 if (!nofscache && erofs_is_fscache_mode(realinode->i_sb))
                         inode->i_mapping->a_ops = &erofs_fscache_access_aops;
#endif
#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
                 if (erofs_is_fileio_mode(EROFS_SB(realinode->i_sb)))
                         inode->i_mapping->a_ops = &erofs_fileio_aops;
#endif
         }
}



> +		sharedinode->i_mode = vi->vfs_inode.i_mode;
> +		sharedinode->i_size = vi->vfs_inode.i_size;
> +		unlock_new_inode(sharedinode);
> +	} else {
> +		kfree(fp.opaque);
> +	}
> +	INIT_LIST_HEAD(&vi->ishare_list);
> +	spin_lock(&EROFS_I(sharedinode)->ishare_lock);
> +	list_add(&vi->ishare_list, &EROFS_I(sharedinode)->ishare_list);
> +	spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
> +	return true;
> +}
> +
> +void erofs_ishare_free_inode(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct inode *sharedinode = vi->sharedinode;
> +
> +	if (!sharedinode)
> +		return;
> +	spin_lock(&EROFS_I(sharedinode)->ishare_lock);
> +	list_del(&vi->ishare_list);
> +	spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
> +	iput(sharedinode);
> +	vi->sharedinode = NULL;
> +}
> +
> +static int erofs_ishare_file_open(struct inode *inode, struct file *file)
> +{
> +	struct inode *sharedinode = EROFS_I(inode)->sharedinode;
> +	struct file *realfile;
> +
> +	if (file->f_flags & O_DIRECT)
> +		return -EINVAL;
> +	realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, current_cred());
> +	if (IS_ERR(realfile))
> +		return PTR_ERR(realfile);
> +	ihold(sharedinode);
> +	realfile->f_op = &erofs_file_fops;
> +	realfile->f_inode = sharedinode;
> +	realfile->f_mapping = sharedinode->i_mapping;
> +	path_get(&file->f_path);
> +	backing_file_set_user_path(realfile, &file->f_path);
> +
> +	file_ra_state_init(&realfile->f_ra, file->f_mapping);
> +	realfile->private_data = EROFS_I(inode);
> +	file->private_data = realfile;
> +	return 0;
> +}
> +
> +static int erofs_ishare_file_release(struct inode *inode, struct file *file)
> +{
> +	struct file *realfile = file->private_data;
> +
> +	iput(realfile->f_inode);
> +	fput(realfile);
> +	file->private_data = NULL;
> +	return 0;
> +}
> +
> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
> +					   struct iov_iter *to)
> +{
> +	struct file *realfile = iocb->ki_filp->private_data;
> +	struct kiocb dedup_iocb;
> +	ssize_t nread;
> +
> +	if (!iov_iter_count(to))
> +		return 0;
> +	kiocb_clone(&dedup_iocb, iocb, realfile);
> +	nread = filemap_read(&dedup_iocb, to, 0);
> +	iocb->ki_pos = dedup_iocb.ki_pos;
> +	return nread;
> +}
> +
> +static int erofs_ishare_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct file *realfile = file->private_data;
> +
> +	vma_set_file(vma, realfile);
> +	return generic_file_readonly_mmap(file, vma);
> +}
> +
> +const struct file_operations erofs_ishare_fops = {
> +	.open		= erofs_ishare_file_open,
> +	.llseek		= generic_file_llseek,
> +	.read_iter	= erofs_ishare_file_read_iter,
> +	.mmap		= erofs_ishare_mmap,
> +	.release	= erofs_ishare_file_release,
> +	.get_unmapped_area = thp_get_unmapped_area,
> +	.splice_read	= filemap_splice_read,
> +};
> +
> +int __init erofs_init_ishare(void)
> +{
> +	erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
> +	return PTR_ERR_OR_ZERO(erofs_ishare_mnt);
> +}
> +
> +void erofs_exit_ishare(void)
> +{
> +	kern_unmount(erofs_ishare_mnt);
> +}
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 960da62636ad..f3cbf28efe11 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -396,6 +396,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
>   enum {
>   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>   	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
> +	Opt_inode_share,
>   };
>   
>   static const struct constant_table erofs_param_cache_strategy[] = {
> @@ -423,6 +424,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
>   	fsparam_string("domain_id",	Opt_domain_id),
>   	fsparam_flag_no("directio",	Opt_directio),
>   	fsparam_u64("fsoffset",		Opt_fsoffset),
> +	fsparam_flag("inode_share",	Opt_inode_share),
>   	{}
>   };
>   
> @@ -551,6 +553,13 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   	case Opt_fsoffset:
>   		sbi->dif0.fsoff = result.uint_64;
>   		break;
> +	case Opt_inode_share:
> +#if defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
> +		set_opt(&sbi->opt, INODE_SHARE);
> +#else
> +		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
> +#endif
> +		break;
>   	}
>   	return 0;
>   }
> @@ -649,6 +658,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   	sb->s_maxbytes = MAX_LFS_FILESIZE;
>   	sb->s_op = &erofs_sops;
>   
> +	if (test_opt(&sbi->opt, DAX_ALWAYS) && test_opt(&sbi->opt, INODE_SHARE)) {
> +		errorfc(fc, "FSDAX is not allowed when inode_ishare is on");
> +		return -EINVAL;
> +	}
> +
>   	sbi->blkszbits = PAGE_SHIFT;
>   	if (!sb->s_bdev) {
>   		/*
> @@ -719,6 +733,10 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   		erofs_info(sb, "unsupported blocksize for DAX");
>   		clear_opt(&sbi->opt, DAX_ALWAYS);
>   	}
> +	if (test_opt(&sbi->opt, INODE_SHARE) && !erofs_sb_has_ishare_xattrs(sbi)) {
> +		erofs_info(sb, "on-disk ishare xattrs not found. Turning off inode_share.");
> +		clear_opt(&sbi->opt, INODE_SHARE);
> +	}

It would be better to add a message like:

	if (test_opt(&sbi->opt, INODE_SHARE))
		erofs_info(sb, "EXPERIMENTAL EROFS page cache share support in use. Use at your own risk!");

At the end of erofs_read_superblock().

Thanks,
Gao Xiang

