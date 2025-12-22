Return-Path: <linux-fsdevel+bounces-71818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BBECD537F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 10:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 967863001E29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7EF2D879F;
	Mon, 22 Dec 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="boQ0cIMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1248B25392C;
	Mon, 22 Dec 2025 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766394007; cv=none; b=lapBk52pp6O6rfE3tbiKIbK97FHZ9hLtSq1WutkuHdbJJYs5qHCnOQrF6vCSoIh2Sb1q5QkRrStvLSUp7w9ePcCC17T1I50frpb2BbrAe/8/67wtpqKsbqfUJIQU/lysUPylsABl47cDKlcNOHtlYM/E92BI/MCSLn9qxjR2pUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766394007; c=relaxed/simple;
	bh=Mw7QlnxD32b/cakXZn+KDv2Gz48OxebV8tvlBOeVB+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9Zq5kImHt2bxAc1l1ziT+cumAq+Uwcq17s4NkY1xoPL2lgkZ6iIxItq8uzKKMK2r+pocZhP36rWLlOuceJXxnEAk/bz6t1CFAxow7IjO0dInUilY4KoGr9xutXSIBKYz3r/oe7yLoJlOrBMccp9bti2Z37EyXBFnSuWM9uF5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=boQ0cIMy; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766393994; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jxe/cEa4eH1xVqpEhm+0NGaPUe2ug5mEQxd/s0liBI4=;
	b=boQ0cIMyoTPIkfKDa/n23LnqKJBagno2T7fP80+cu78wGVHntFJ+EBM866cKKcaDCyfGkUYjyd7vsbUICNDgUcMtGBNFCmLJ4BkL0flzzw3RVPwK7H7EIfrf/RSbg4HN8zp1I9DaM5Iop+QKUFuy902MYQaChkbMY0irVzJwjGI=
Received: from 30.221.132.255(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvOAy0V_1766393993 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 16:59:53 +0800
Message-ID: <37fafc56-af2f-4a73-a5b7-2041049b8c71@linux.alibaba.com>
Date: Mon, 22 Dec 2025 16:59:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, joannelkoong@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251117132537.227116-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hongbo,

On 2025/11/17 21:25, Hongbo Li wrote:
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
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/erofs/Makefile   |   1 +
>   fs/erofs/internal.h |  29 ++++++
>   fs/erofs/ishare.c   | 241 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c    |  31 +++++-
>   4 files changed, 300 insertions(+), 2 deletions(-)
>   create mode 100644 fs/erofs/ishare.c
> 
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
> index 3033252211ba..93ad34f2b488 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -304,6 +304,22 @@ struct erofs_inode {
>   		};
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	};
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	union {
> +		/* internal dedup inode */
> +		struct {
> +			char *fingerprint;
> +			spinlock_t lock;
> +			/* all backing inodes */
> +			struct list_head backing_head;
> +		};
> +
> +		struct {
> +			struct inode *ishare;
> +			struct list_head backing_link;
> +		};
> +	};
> +#endif
>   	/* the corresponding vfs inode */
>   	struct inode vfs_inode;
>   };
> @@ -410,6 +426,7 @@ extern const struct inode_operations erofs_dir_iops;
>   
>   extern const struct file_operations erofs_file_fops;
>   extern const struct file_operations erofs_dir_fops;
> +extern const struct file_operations erofs_ishare_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> @@ -541,6 +558,18 @@ static inline struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>   #endif
>   
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +int erofs_ishare_init(struct super_block *sb);
> +void erofs_ishare_exit(struct super_block *sb);
> +bool erofs_ishare_fill_inode(struct inode *inode);
> +void erofs_ishare_free_inode(struct inode *inode);
> +#else
> +static inline int erofs_ishare_init(struct super_block *sb) { return 0; }
> +static inline void erofs_ishare_exit(struct super_block *sb) {}
> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>   			unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> new file mode 100644
> index 000000000000..f386efb260da
> --- /dev/null
> +++ b/fs/erofs/ishare.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include <linux/xxhash.h>
> +#include <linux/refcount.h>
> +#include <linux/mount.h>
> +#include <linux/mutex.h>
> +#include <linux/ramfs.h>
> +#include "internal.h"
> +#include "xattr.h"
> +
> +#include "../internal.h"
> +
> +static DEFINE_MUTEX(erofs_ishare_lock);
> +static struct vfsmount *erofs_ishare_mnt;
> +static refcount_t erofs_ishare_supers;
> +
> +int erofs_ishare_init(struct super_block *sb)
> +{
> +	struct vfsmount *mnt = NULL;
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	if (!erofs_sb_has_ishare_key(sbi))
> +		return 0;
> +
> +	mutex_lock(&erofs_ishare_lock);
> +	if (erofs_ishare_mnt) {
> +		refcount_inc(&erofs_ishare_supers);
> +	} else {
> +		mnt = kern_mount(&erofs_anon_fs_type);
> +		if (!IS_ERR(mnt)) {
> +			erofs_ishare_mnt = mnt;
> +			refcount_set(&erofs_ishare_supers, 1);
> +		}
> +	}
> +	mutex_unlock(&erofs_ishare_lock);

It seems this part is too complex, we could just
kern_mount() once.

and kern_unmount() before unregistering the module.

And since `erofs_anon_fs_type` is an internal fstype, we
could drop ".owner" field to avoid it from unloading the fs
module I think.

> +	return IS_ERR(mnt) ? PTR_ERR(mnt) : 0;
> +}
> +
> +void erofs_ishare_exit(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct vfsmount *tmp;
> +
> +	if (!erofs_sb_has_ishare_key(sbi) || !erofs_ishare_mnt)
> +		return;
> +
> +	mutex_lock(&erofs_ishare_lock);
> +	if (refcount_dec_and_test(&erofs_ishare_supers)) {
> +		tmp = erofs_ishare_mnt;
> +		erofs_ishare_mnt = NULL;
> +		mutex_unlock(&erofs_ishare_lock);
> +		kern_unmount(tmp);
> +		mutex_lock(&erofs_ishare_lock);
> +	}
> +	mutex_unlock(&erofs_ishare_lock);

Same here.

Thanks,
Gao Xiang

