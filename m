Return-Path: <linux-fsdevel+bounces-71961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79189CD86E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0264303D885
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C7313E0C;
	Tue, 23 Dec 2025 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iV88S8pZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E6311C15;
	Tue, 23 Dec 2025 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766477478; cv=none; b=JRM7GAmTiUBdAWSSYi8nyzfk9AdMq2T3w9nWDkAqhkSfuBsznJnubKRB9fESdYffodqg78abzRV7rf+VCmqchV/kG9z7ICLadXWYykjEhQYgPAlrD123+Njj0Jvgk7/fUrKiQDlf3yUVSXCFC2i3xaPjtLRXfH/VejEm+LyMoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766477478; c=relaxed/simple;
	bh=JLzrcuvirbUyanC4l3ivszPVcAuDk/lKGE7Sre2ZN9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ap3CVLtpskhQK7L4R4p9Yq2g/sEYUq9G84MfBmLVQIF1/UhoT8KdaAerzQDRqNknAMCTF1plNKw/oE2HqQwWBKQyWWtG3Y5Mrc6LDT3tNzYBEiEt4jsGtY+Vi0YIUEpi5RTX7YCaJCthJy7uNvsxUS2nPE0JhdJUm1hPTxr+Dfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iV88S8pZ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766477470; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MFtCT6ljMZlWxq7rA6g0GTsTl9xpHYQaYPejwGEQhVc=;
	b=iV88S8pZhBMn7y0BJtafGH2HYCsHNDaowIM3BUNXYZGpAW0+shhwqAfEAOZKCy/tQF3RmTwW7doiG6htc9sopyFPd7mLOqv6m8ZXyhx5P9v7XcdAzUetgwl5ggBIlkDAwfGKPYS4a2CyatlIiLiE5ymSoHW53nzukZc+/eQrF9A=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX-qdK_1766477469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:11:09 +0800
Message-ID: <97b475d1-d25e-4bea-b0b5-4bc7e65083f4@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:11:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
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
>   fs/erofs/ishare.c   | 211 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/erofs/super.c    |  34 ++++++-
>   4 files changed, 272 insertions(+), 3 deletions(-)
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
> index 99e2857173c3..ae9560434324 100644
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

I think it would be better to reform as below:

struct erofs_inode_fingerprint {
	u8 *opaque;
	int size;
};

	struct list_head ishare_list;
	union {
		struct {
			struct erofs_inode_fingerprint fingerprint;
			spinlock_t ishare_lock;
		};
		struct inode *realinode;
	};


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
> +int __init erofs_init_ishare(void);
> +void erofs_exit_ishare(void);
> +bool erofs_ishare_fill_inode(struct inode *inode);
> +void erofs_ishare_free_inode(struct inode *inode);
> +#else
> +static inline int erofs_init_ishare(void) { return 0; }
> +static inline void erofs_exit_ishare(void) {}
> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { return false; }
> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +
>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>   			unsigned long arg);
> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
> new file mode 100644
> index 000000000000..4b46016bcd03
> --- /dev/null
> +++ b/fs/erofs/ishare.c
> @@ -0,0 +1,211 @@
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
> +static struct vfsmount *erofs_ishare_mnt;
> +
> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);

	struct erofs_inode_fingerprint *fp1 = &EROFS_I(inode)->fingerprint;
	struct erofs_inode_fingerprint *fp2 = data;

	return fp1->size == fp2->size &&
		!memcmp(fp1->opaque, fp2->opaque, fp2->size);

	return vi->fingerprint.opaque && memcmp(vi->

> +
> +	return vi->fingerprint && memcmp(vi->fingerprint, data,
> +			sizeof(size_t) + *(size_t *)data) == 0;
> +}
> +
> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +> +	vi->fingerprint = data;

	vi->fingerprint = *(struct erofs_inode_fingerprint *)data;

> +	INIT_LIST_HEAD(&vi->backing_head);
> +	spin_lock_init(&vi->lock);
> +	return 0;
> +}
> +
> +bool erofs_ishare_fill_inode(struct inode *inode)
> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
> +	struct erofs_xattr_prefix_item *ishare_prefix;

just call
	struct erofs_xattr_prefix_item *prefix;

is fine, since it's unambiguous.

> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct inode *idedup;
> +	/*
> +	 * fingerprint layout:
> +	 * fingerprint length + fingerprint content (xattr_value + domain_id)
> +	 */

That is too hard to follow, just convert to what I mentioned above;

	struct erofs_inode_fingerprint fp;

> +	char *ishare_key, *fingerprint;

	char *infix;

> +	ssize_t ishare_vlen;

	size_t valuelen;

> +	unsigned long hash;
> +	int key_idx;

	int base_index;

> +
> +	if (!sbi->domain_id || !erofs_sb_has_ishare_xattrs(sbi))
> +		return false;
> +
> +	ishare_prefix = sbi->xattr_prefixes + sbi->ishare_xattr_pfx;
> +	ishare_key = ishare_prefix->prefix->infix;
> +	key_idx = ishare_prefix->prefix->base_index;
> +	ishare_vlen = erofs_getxattr(inode, key_idx, ishare_key, NULL, 0);
> +	if (ishare_vlen <= 0 || ishare_vlen > (1 << sbi->blkszbits))
> +		return false;
> +

Then:
	fp.size = valuelen + strlen(sbi->domain_id);
	fp.opaque = kmalloc(fp.size, GFP_KERNEL);

And fix the remaining logic.

Thanks,
Gao Xiang

