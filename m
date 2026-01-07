Return-Path: <linux-fsdevel+bounces-72584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB2CFC475
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 08:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A10330222EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 07:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD2626B95B;
	Wed,  7 Jan 2026 07:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vxgqHgGY";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vxgqHgGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C013AD26;
	Wed,  7 Jan 2026 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769455; cv=none; b=jDOTQ8C8R571rXYV0BGJsPenkHrApHypxmCC1WPK634jWY/TFnrLBm76Ysepl5cDADM5Hfjk76cHwi/GbEkMwl3eB697Y2teKS88VR3quaI+lV9WcVv7zch0rbVNh99YESm3mgKnEjh/NQLG7gd3RS9wBDYxCj9uDx4TneXivDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769455; c=relaxed/simple;
	bh=zdh1qZ5bTqxkwJdlkWc7fxcH46bRa6PEfnp2vaWVbFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t+V9+udvKyE0cqIxWELBZY1ckUBhjMesju8bpgVzx1NX7NlQjT3w+qYJBltlOmyEBFmHcAdvnMy7yIbcNah5UaDqxNRi4KqwixN6YrNabSZEWsWxp4+yAw8xgoUzKyaR3LFUPnCfa6vmIyUtB2dNdzd6soMufsBIq4th6c74B+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vxgqHgGY; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vxgqHgGY; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YY8PcO9qsoQe1xVlObX8q2GEXJSWIjL02+oezf/vcg4=;
	b=vxgqHgGY0Uvg82KDe+/vX8VpyXzhdX0uhai16trjzvgfFr8oiWInYqyiEXRPWu22HAQZGZY6D
	TJNFWyVW7vwkZTkW5fow/kc1wHY2aGwBC2c1llcB9BZpBwbisAFCoI9Iu40IqKyWj5sgJLjGfik
	U0boGdPpRGbj1bw4dhJ2N24=
Received: from canpmsgout12.his.huawei.com (unknown [172.19.92.144])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dmJWN6KtXz1BGBc;
	Wed,  7 Jan 2026 14:47:44 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YY8PcO9qsoQe1xVlObX8q2GEXJSWIjL02+oezf/vcg4=;
	b=vxgqHgGY0Uvg82KDe+/vX8VpyXzhdX0uhai16trjzvgfFr8oiWInYqyiEXRPWu22HAQZGZY6D
	TJNFWyVW7vwkZTkW5fow/kc1wHY2aGwBC2c1llcB9BZpBwbisAFCoI9Iu40IqKyWj5sgJLjGfik
	U0boGdPpRGbj1bw4dhJ2N24=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmJSv1dh2znTY4;
	Wed,  7 Jan 2026 14:45:35 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 84AB240539;
	Wed,  7 Jan 2026 14:48:39 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 14:48:38 +0800
Message-ID: <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
Date: Wed, 7 Jan 2026 14:48:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	<brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi, Xiang

On 2026/1/7 14:08, Gao Xiang wrote:
> 
> 
> On 2025/12/31 17:01, Hongbo Li wrote:
>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>
>> Currently, reading files with different paths (or names) but the same
>> content will consume multiple copies of the page cache, even if the
>> content of these page caches is the same. For example, reading
>> identical files (e.g., *.so files) from two different minor versions of
>> container images will cost multiple copies of the same page cache,
>> since different containers have different mount points. Therefore,
>> sharing the page cache for files with the same content can save memory.
>>
>> This introduces the page cache share feature in erofs. It allocate a
>> deduplicated inode and use its page cache as shared. Reads for files
>> with identical content will ultimately be routed to the page cache of
>> the deduplicated inode. In this way, a single page cache satisfies
>> multiple read requests for different files with the same contents.
>>
>> We introduce inode_share mount option to enable the page sharing mode
>> during mounting.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   Documentation/filesystems/erofs.rst |   5 +
>>   fs/erofs/Makefile                   |   1 +
>>   fs/erofs/internal.h                 |  31 +++++
>>   fs/erofs/ishare.c                   | 170 ++++++++++++++++++++++++++++
>>   fs/erofs/super.c                    |  55 ++++++++-
>>   fs/erofs/xattr.c                    |  34 ++++++
>>   fs/erofs/xattr.h                    |   3 +
>>   7 files changed, 297 insertions(+), 2 deletions(-)
>>   create mode 100644 fs/erofs/ishare.c
>>
>> diff --git a/Documentation/filesystems/erofs.rst 
>> b/Documentation/filesystems/erofs.rst
>> index 08194f194b94..27d3caa3c73c 100644
>> --- a/Documentation/filesystems/erofs.rst
>> +++ b/Documentation/filesystems/erofs.rst
>> @@ -128,7 +128,12 @@ device=%s              Specify a path to an extra 
>> device to be used together.
>>   fsid=%s                Specify a filesystem image ID for Fscache 
>> back-end.
>>   domain_id=%s           Specify a domain ID in fscache mode so that 
>> different images
>>                          with the same blobs under a given domain ID 
>> can share storage.
>> +                       Also used for inode page sharing mode which 
>> defines a sharing
>> +                       domain.
>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>> the primary device.
>> +inode_share            Enable inode page sharing for this 
>> filesystem.  Inodes with
>> +                       identical content within the same domain ID 
>> can share the
>> +                       page cache.
>>   ===================    
>> =========================================================
>>   Sysfs Entries
>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>> index 549abc424763..a80e1762b607 100644
>> --- a/fs/erofs/Makefile
>> +++ b/fs/erofs/Makefile
>> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += 
>> decompressor_zstd.o
>>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index ec79e8b44d3b..6ef1cdd9d651 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -179,6 +179,7 @@ struct erofs_sb_info {
>>   #define EROFS_MOUNT_DAX_ALWAYS        0x00000040
>>   #define EROFS_MOUNT_DAX_NEVER        0x00000080
>>   #define EROFS_MOUNT_DIRECT_IO        0x00000100
>> +#define EROFS_MOUNT_INODE_SHARE        0x00000200
>>   #define clear_opt(opt, option)    ((opt)->mount_opt &= 
>> ~EROFS_MOUNT_##option)
>>   #define set_opt(opt, option)    ((opt)->mount_opt |= 
>> EROFS_MOUNT_##option)
>> @@ -269,6 +270,11 @@ static inline u64 erofs_nid_to_ino64(struct 
>> erofs_sb_info *sbi, erofs_nid_t nid)
>>   /* default readahead size of directories */
>>   #define EROFS_DIR_RA_BYTES    16384
>> +struct erofs_inode_fingerprint {
>> +    u8 *opaque;
>> +    int size;
>> +};
>> +
>>   struct erofs_inode {
>>       erofs_nid_t nid;
>> @@ -304,6 +310,18 @@ struct erofs_inode {
>>           };
>>   #endif    /* CONFIG_EROFS_FS_ZIP */
>>       };
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    struct list_head ishare_list;
>> +    union {
>> +        /* for each anon shared inode */
>> +        struct {
>> +            struct erofs_inode_fingerprint fingerprint;
>> +            spinlock_t ishare_lock;
>> +        };
>> +        /* for each real inode */
>> +        struct inode *sharedinode;
>> +    };
>> +#endif
>>       /* the corresponding vfs inode */
>>       struct inode vfs_inode;
>>   };
>> @@ -410,6 +428,7 @@ extern const struct inode_operations erofs_dir_iops;
>>   extern const struct file_operations erofs_file_fops;
>>   extern const struct file_operations erofs_dir_fops;
>> +extern const struct file_operations erofs_ishare_fops;
>>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>> @@ -541,6 +560,18 @@ static inline struct bio 
>> *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>>   #endif
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +int __init erofs_init_ishare(void);
>> +void erofs_exit_ishare(void);
>> +bool erofs_ishare_fill_inode(struct inode *inode);
>> +void erofs_ishare_free_inode(struct inode *inode);
>> +#else
>> +static inline int erofs_init_ishare(void) { return 0; }
>> +static inline void erofs_exit_ishare(void) {}
>> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { 
>> return false; }
>> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
>> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +
>>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long 
>> arg);
>>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>               unsigned long arg);
>> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
>> new file mode 100644
>> index 000000000000..e93d379d4a3a
>> --- /dev/null
>> +++ b/fs/erofs/ishare.c
>> @@ -0,0 +1,170 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024, Alibaba Cloud
>> + */
>> +#include <linux/xxhash.h>
>> +#include <linux/mount.h>
>> +#include "internal.h"
>> +#include "xattr.h"
>> +
>> +#include "../internal.h"
>> +
>> +static struct vfsmount *erofs_ishare_mnt;
>> +
>> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
>> +    struct erofs_inode_fingerprint *fp2 = data;
>> +
>> +    return fp1->size == fp2->size &&
>> +        !memcmp(fp1->opaque, fp2->opaque, fp2->size);
>> +}
>> +
>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock_init(&vi->ishare_lock);
>> +    return 0;
>> +}
>> +
>> +bool erofs_ishare_fill_inode(struct inode *inode)
>> +{
>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct erofs_inode_fingerprint fp;
>> +    struct inode *sharedinode;
>> +    unsigned long hash;
>> +
>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>> +        return false;
>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>> +    if (!fp.size)
>> +        return false;
> 
> Why not just:
> 
>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>          return false;
> 

When erofs_sb_has_ishare_xattrs returns false, 
erofs_xattr_fill_ishare_fp also considers success. We can skip quickly 
for inode when ishare_xattrs is disabled by checking fp.size.

Thanks,
Hongbo

> Also I think
>      erofs_xattr_fill_inode_fingerprint()
> is a better name for this function.
> 
>> +    hash = xxh32(fp.opaque, fp.size, 0);
>> +    sharedinode = iget5_locked(erofs_ishare_mnt->mnt_sb, hash,
>> +                   erofs_ishare_iget5_eq, erofs_ishare_iget5_set,
>> +                   &fp);
>> +    if (!sharedinode) {
>> +        kfree(fp.opaque);
>> +        return false;
>> +    }
>> +
>> +    vi->sharedinode = sharedinode;
>> +    if (inode_state_read_once(sharedinode) & I_NEW) {
>> +        if (erofs_inode_is_data_compressed(vi->datalayout))
>> +            sharedinode->i_mapping->a_ops = &z_erofs_aops;
>> +        else
>> +            sharedinode->i_mapping->a_ops = &erofs_aops;
>> +        sharedinode->i_mode = vi->vfs_inode.i_mode;
>> +        sharedinode->i_size = vi->vfs_inode.i_size;
>> +        unlock_new_inode(sharedinode);
>> +    } else {
>> +        kfree(fp.opaque);
>> +    }
>> +    INIT_LIST_HEAD(&vi->ishare_list);
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_add(&vi->ishare_list, &EROFS_I(sharedinode)->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    return true;
>> +}
>> +
>> +void erofs_ishare_free_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +    struct inode *sharedinode = vi->sharedinode;
>> +
>> +    if (!sharedinode)
>> +        return;
>> +    spin_lock(&EROFS_I(sharedinode)->ishare_lock);
>> +    list_del(&vi->ishare_list);
>> +    spin_unlock(&EROFS_I(sharedinode)->ishare_lock);
>> +    iput(sharedinode);
>> +    vi->sharedinode = NULL;
>> +}
>> +
>> +static int erofs_ishare_file_open(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct inode *sharedinode;
>> +    struct file *realfile;
>> +
>> +    sharedinode = EROFS_I(inode)->sharedinode;
>> +    realfile = alloc_empty_backing_file(O_RDONLY|O_NOATIME, 
>> current_cred());
>> +    if (IS_ERR(realfile))
>> +        return PTR_ERR(realfile);
>> +    ihold(sharedinode);
>> +    realfile->f_op = &erofs_file_fops;
>> +    realfile->f_inode = sharedinode;
>> +    realfile->f_mapping = sharedinode->i_mapping;
>> +    path_get(&file->f_path);
>> +    backing_file_set_user_path(realfile, &file->f_path);
>> +
>> +    file_ra_state_init(&realfile->f_ra, file->f_mapping);
>> +    realfile->private_data = EROFS_I(inode);
>> +    file->private_data = realfile;
>> +    return 0;
>> +}
>> +
>> +static int erofs_ishare_file_release(struct inode *inode, struct file 
>> *file)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    iput(realfile->f_inode);
>> +    fput(realfile);
>> +    file->private_data = NULL;
>> +    return 0;
>> +}
>> +
>> +static ssize_t erofs_ishare_file_read_iter(struct kiocb *iocb,
>> +                       struct iov_iter *to)
>> +{
>> +    struct file *realfile = iocb->ki_filp->private_data;
>> +    struct kiocb dedup_iocb;
>> +    ssize_t nread;
>> +
>> +    if (!iov_iter_count(to))
>> +        return 0;
>> +
>> +    /* fallback to the original file in DIRECT mode */
>> +    if (iocb->ki_flags & IOCB_DIRECT)
>> +        realfile = iocb->ki_filp;
>> +
>> +    kiocb_clone(&dedup_iocb, iocb, realfile);
>> +    nread = filemap_read(&dedup_iocb, to, 0);
>> +    iocb->ki_pos = dedup_iocb.ki_pos;
> 
> I think it will not work for the AIO cases.
> 
> In order to make it simplified, how about just
> allowing sync and non-direct I/O first, and
> defering DIO/AIO support later?
> 
>> +    file_accessed(iocb->ki_filp);
> 
> I don't think it's useful in practice.
> 
> 
>> +    return nread;
>> +}
>> +
>> +static int erofs_ishare_mmap(struct file *file, struct vm_area_struct 
>> *vma)
>> +{
>> +    struct file *realfile = file->private_data;
>> +
>> +    vma_set_file(vma, realfile);
>> +    return generic_file_readonly_mmap(file, vma);
>> +}
>> +
>> +const struct file_operations erofs_ishare_fops = {
>> +    .open        = erofs_ishare_file_open,
>> +    .llseek        = generic_file_llseek,
>> +    .read_iter    = erofs_ishare_file_read_iter,
>> +    .mmap        = erofs_ishare_mmap,
>> +    .release    = erofs_ishare_file_release,
>> +    .get_unmapped_area = thp_get_unmapped_area,
>> +    .splice_read    = filemap_splice_read,
>> +};
>> +
>> +int __init erofs_init_ishare(void)
>> +{
>> +    erofs_ishare_mnt = kern_mount(&erofs_anon_fs_type);
>> +    if (IS_ERR(erofs_ishare_mnt))
>> +        return PTR_ERR(erofs_ishare_mnt);
>> +    return 0;
> 
>      return PTR_ERR_OR_ZERO(erofs_ishare_mnt);
> 
>> +}
>> +
>> +void erofs_exit_ishare(void)
>> +{
>> +    kern_unmount(erofs_ishare_mnt);
>> +}
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 960da62636ad..6489241c5e42 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -396,6 +396,7 @@ static void erofs_default_options(struct 
>> erofs_sb_info *sbi)
>>   enum {
>>       Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>>       Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
>> +    Opt_inode_share,
>>   };
>>   static const struct constant_table erofs_param_cache_strategy[] = {
>> @@ -423,6 +424,7 @@ static const struct fs_parameter_spec 
>> erofs_fs_parameters[] = {
>>       fsparam_string("domain_id",    Opt_domain_id),
>>       fsparam_flag_no("directio",    Opt_directio),
>>       fsparam_u64("fsoffset",        Opt_fsoffset),
>> +    fsparam_flag("inode_share",    Opt_inode_share),
>>       {}
>>   };
>> @@ -551,6 +553,14 @@ static int erofs_fc_parse_param(struct fs_context 
>> *fc,
>>       case Opt_fsoffset:
>>           sbi->dif0.fsoff = result.uint_64;
>>           break;
>> +#if defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
>> +    case Opt_inode_share:
>> +        set_opt(&sbi->opt, INODE_SHARE);
>> +#else
>> +    case Opt_inode_share:
>> +        errorfc(fc, "%s option not supported", 
>> erofs_fs_parameters[opt].name);
>> +#endif
> 
> 
>      case Opt_inode_share:
> #ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>          set_opt(&sbi->opt, INODE_SHARE);
> #else
>          errorfc(fc, "%s option not supported", 
> erofs_fs_parameters[opt].name);
> #endif
>          break;
> 
>> +        break;
>>       }
>>       return 0;
>>   }
>> @@ -649,6 +659,16 @@ static int erofs_fc_fill_super(struct super_block 
>> *sb, struct fs_context *fc)
>>       sb->s_maxbytes = MAX_LFS_FILESIZE;
>>       sb->s_op = &erofs_sops;
>> +    if (sbi->domain_id &&
>> +        (!sbi->fsid && !test_opt(&sbi->opt, INODE_SHARE))) {
>> +        errorfc(fc, "domain_id should be with fsid or inode_share 
>> option");
>> +        return -EINVAL;
>> +    }
> 
> Is that really needed?
> 
> 
> 
>> +    if (test_opt(&sbi->opt, DAX_ALWAYS) && test_opt(&sbi->opt, 
>> INODE_SHARE)) {
>> +        errorfc(fc, "dax is not allowed when inode_share is on");
> 
>          errorfc(fc, "FSDAX is not allowed when inode_share is on");
> 
> Thanks,
> Gao Xiang

