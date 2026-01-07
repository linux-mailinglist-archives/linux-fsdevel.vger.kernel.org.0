Return-Path: <linux-fsdevel+bounces-72585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F1CFC4CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7FE3012262
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A126E6F3;
	Wed,  7 Jan 2026 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YrsYVswX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A47DA66;
	Wed,  7 Jan 2026 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767770268; cv=none; b=iQYlAgAKC/GBiLADlEDOivlKY8iVQOpP0B2OjmEfcPaO1868Vi//PP6ar1GM9iAlHSvsj56krE2QPW8/lkTycAxoz8GaXpJKRSplx0s7z+q1bPrT41o4GtgQDvy4Qr9H2Y3aOdSsoDIqO64SNXat2YEP+x7saVsZheLph1seyGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767770268; c=relaxed/simple;
	bh=kgjyUt0uKuW4/iXH+ecR2njM9JOGda83VmKrcTi22P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Glps/5EFc9G9HUxF/Pelb0GMExL3ak599qZdfq6LqE6MLTvpE52U346MdKYY9u4/m6lr285sG5/xi6qjfM3S7ewtmnwM6nZr3LMly0qViSa7jB95gduOJIjMGLxyldGcm3kcBHGUMJsTxtM//qxhp2HYGI4hG0dG6z8uho2ebmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YrsYVswX; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sQnGWCK1oBv8AuiIVg2UnDEz74VkSVgFsLNjqhNRibQ=;
	b=YrsYVswXO9O+rfs12KPLUfp7aK7j8liXbZ20rfpBz1qUeB6tRulkjr0ye3194aEfRhmrFKaId
	fO3H4YI0YpeTE5JR7I56XMQuPH2404pnUZ/z1FMMAENj2YYLr7O6GGLfXvexb57kWgpsRbTv4zn
	Q5Tpo090xpejsgW1333oEY0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dmK694m89z1prMm;
	Wed,  7 Jan 2026 15:14:25 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id F02C64056D;
	Wed,  7 Jan 2026 15:17:42 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Jan 2026 15:17:42 +0800
Message-ID: <07212138-c0fc-4a64-a323-9cab978bf610@huawei.com>
Date: Wed, 7 Jan 2026 15:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/10] erofs: introduce the page cache share feature
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>
CC: <djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	<brauner@kernel.org>
References: <20251231090118.541061-1-lihongbo22@huawei.com>
 <20251231090118.541061-8-lihongbo22@huawei.com>
 <99a517aa-744b-487b-bce8-294b69a0cd50@linux.alibaba.com>
 <b690d435-7e9c-4424-a681-d3f798176202@huawei.com>
 <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <df2889c0-6027-4f42-a013-b01357fd0005@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi, Xiang

On 2026/1/7 14:56, Gao Xiang wrote:
> 
> 
> On 2026/1/7 14:48, Hongbo Li wrote:
>> Hi, Xiang
>>
>> On 2026/1/7 14:08, Gao Xiang wrote:
>>>
>>>
>>> On 2025/12/31 17:01, Hongbo Li wrote:
>>>> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>>
>>>> Currently, reading files with different paths (or names) but the same
>>>> content will consume multiple copies of the page cache, even if the
>>>> content of these page caches is the same. For example, reading
>>>> identical files (e.g., *.so files) from two different minor versions of
>>>> container images will cost multiple copies of the same page cache,
>>>> since different containers have different mount points. Therefore,
>>>> sharing the page cache for files with the same content can save memory.
>>>>
>>>> This introduces the page cache share feature in erofs. It allocate a
>>>> deduplicated inode and use its page cache as shared. Reads for files
>>>> with identical content will ultimately be routed to the page cache of
>>>> the deduplicated inode. In this way, a single page cache satisfies
>>>> multiple read requests for different files with the same contents.
>>>>
>>>> We introduce inode_share mount option to enable the page sharing mode
>>>> during mounting.
>>>>
>>>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>> ---
>>>>   Documentation/filesystems/erofs.rst |   5 +
>>>>   fs/erofs/Makefile                   |   1 +
>>>>   fs/erofs/internal.h                 |  31 +++++
>>>>   fs/erofs/ishare.c                   | 170 
>>>> ++++++++++++++++++++++++++++
>>>>   fs/erofs/super.c                    |  55 ++++++++-
>>>>   fs/erofs/xattr.c                    |  34 ++++++
>>>>   fs/erofs/xattr.h                    |   3 +
>>>>   7 files changed, 297 insertions(+), 2 deletions(-)
>>>>   create mode 100644 fs/erofs/ishare.c
>>>>
>>>> diff --git a/Documentation/filesystems/erofs.rst 
>>>> b/Documentation/filesystems/erofs.rst
>>>> index 08194f194b94..27d3caa3c73c 100644
>>>> --- a/Documentation/filesystems/erofs.rst
>>>> +++ b/Documentation/filesystems/erofs.rst
>>>> @@ -128,7 +128,12 @@ device=%s              Specify a path to an 
>>>> extra device to be used together.
>>>>   fsid=%s                Specify a filesystem image ID for Fscache 
>>>> back-end.
>>>>   domain_id=%s           Specify a domain ID in fscache mode so that 
>>>> different images
>>>>                          with the same blobs under a given domain ID 
>>>> can share storage.
>>>> +                       Also used for inode page sharing mode which 
>>>> defines a sharing
>>>> +                       domain.
>>>>   fsoffset=%llu          Specify block-aligned filesystem offset for 
>>>> the primary device.
>>>> +inode_share            Enable inode page sharing for this 
>>>> filesystem.  Inodes with
>>>> +                       identical content within the same domain ID 
>>>> can share the
>>>> +                       page cache.
>>>>   =================== 
>>>> =========================================================
>>>>   Sysfs Entries
>>>> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
>>>> index 549abc424763..a80e1762b607 100644
>>>> --- a/fs/erofs/Makefile
>>>> +++ b/fs/erofs/Makefile
>>>> @@ -10,3 +10,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += 
>>>> decompressor_zstd.o
>>>>   erofs-$(CONFIG_EROFS_FS_ZIP_ACCEL) += decompressor_crypto.o
>>>>   erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
>>>>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
>>>> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += ishare.o
>>>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>>>> index ec79e8b44d3b..6ef1cdd9d651 100644
>>>> --- a/fs/erofs/internal.h
>>>> +++ b/fs/erofs/internal.h
>>>> @@ -179,6 +179,7 @@ struct erofs_sb_info {
>>>>   #define EROFS_MOUNT_DAX_ALWAYS        0x00000040
>>>>   #define EROFS_MOUNT_DAX_NEVER        0x00000080
>>>>   #define EROFS_MOUNT_DIRECT_IO        0x00000100
>>>> +#define EROFS_MOUNT_INODE_SHARE        0x00000200
>>>>   #define clear_opt(opt, option)    ((opt)->mount_opt &= 
>>>> ~EROFS_MOUNT_##option)
>>>>   #define set_opt(opt, option)    ((opt)->mount_opt |= 
>>>> EROFS_MOUNT_##option)
>>>> @@ -269,6 +270,11 @@ static inline u64 erofs_nid_to_ino64(struct 
>>>> erofs_sb_info *sbi, erofs_nid_t nid)
>>>>   /* default readahead size of directories */
>>>>   #define EROFS_DIR_RA_BYTES    16384
>>>> +struct erofs_inode_fingerprint {
>>>> +    u8 *opaque;
>>>> +    int size;
>>>> +};
>>>> +
>>>>   struct erofs_inode {
>>>>       erofs_nid_t nid;
>>>> @@ -304,6 +310,18 @@ struct erofs_inode {
>>>>           };
>>>>   #endif    /* CONFIG_EROFS_FS_ZIP */
>>>>       };
>>>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>>>> +    struct list_head ishare_list;
>>>> +    union {
>>>> +        /* for each anon shared inode */
>>>> +        struct {
>>>> +            struct erofs_inode_fingerprint fingerprint;
>>>> +            spinlock_t ishare_lock;
>>>> +        };
>>>> +        /* for each real inode */
>>>> +        struct inode *sharedinode;
>>>> +    };
>>>> +#endif
>>>>       /* the corresponding vfs inode */
>>>>       struct inode vfs_inode;
>>>>   };
>>>> @@ -410,6 +428,7 @@ extern const struct inode_operations 
>>>> erofs_dir_iops;
>>>>   extern const struct file_operations erofs_file_fops;
>>>>   extern const struct file_operations erofs_dir_fops;
>>>> +extern const struct file_operations erofs_ishare_fops;
>>>>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>>>> @@ -541,6 +560,18 @@ static inline struct bio 
>>>> *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev) {
>>>>   static inline void erofs_fscache_submit_bio(struct bio *bio) {}
>>>>   #endif
>>>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>>>> +int __init erofs_init_ishare(void);
>>>> +void erofs_exit_ishare(void);
>>>> +bool erofs_ishare_fill_inode(struct inode *inode);
>>>> +void erofs_ishare_free_inode(struct inode *inode);
>>>> +#else
>>>> +static inline int erofs_init_ishare(void) { return 0; }
>>>> +static inline void erofs_exit_ishare(void) {}
>>>> +static inline bool erofs_ishare_fill_inode(struct inode *inode) { 
>>>> return false; }
>>>> +static inline void erofs_ishare_free_inode(struct inode *inode) {}
>>>> +#endif // CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>>>> +
>>>>   long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned 
>>>> long arg);
>>>>   long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>>>               unsigned long arg);
>>>> diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
>>>> new file mode 100644
>>>> index 000000000000..e93d379d4a3a
>>>> --- /dev/null
>>>> +++ b/fs/erofs/ishare.c
>>>> @@ -0,0 +1,170 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Copyright (C) 2024, Alibaba Cloud
>>>> + */
>>>> +#include <linux/xxhash.h>
>>>> +#include <linux/mount.h>
>>>> +#include "internal.h"
>>>> +#include "xattr.h"
>>>> +
>>>> +#include "../internal.h"
>>>> +
>>>> +static struct vfsmount *erofs_ishare_mnt;
>>>> +
>>>> +static int erofs_ishare_iget5_eq(struct inode *inode, void *data)
>>>> +{
>>>> +    struct erofs_inode_fingerprint *fp1 = 
>>>> &EROFS_I(inode)->fingerprint;
>>>> +    struct erofs_inode_fingerprint *fp2 = data;
>>>> +
>>>> +    return fp1->size == fp2->size &&
>>>> +        !memcmp(fp1->opaque, fp2->opaque, fp2->size);
>>>> +}
>>>> +
>>>> +static int erofs_ishare_iget5_set(struct inode *inode, void *data)
>>>> +{
>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>> +
>>>> +    vi->fingerprint = *(struct erofs_inode_fingerprint *)data;
>>>> +    INIT_LIST_HEAD(&vi->ishare_list);
>>>> +    spin_lock_init(&vi->ishare_lock);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +bool erofs_ishare_fill_inode(struct inode *inode)
>>>> +{
>>>> +    struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
>>>> +    struct erofs_inode *vi = EROFS_I(inode);
>>>> +    struct erofs_inode_fingerprint fp;
>>>> +    struct inode *sharedinode;
>>>> +    unsigned long hash;
>>>> +
>>>> +    if (!test_opt(&sbi->opt, INODE_SHARE))
>>>> +        return false;
>>>> +    (void)erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id);
>>>> +    if (!fp.size)
>>>> +        return false;
>>>
>>> Why not just:
>>>
>>>      if (erofs_xattr_fill_ishare_fp(&fp, inode, sbi->domain_id))
>>>          return false;
>>>
>>
>> When erofs_sb_has_ishare_xattrs returns false, 
>> erofs_xattr_fill_ishare_fp also considers success.
> 
> Then why !test_opt(&sbi->opt, INODE_SHARE) didn't return?
> 

The MOUNT_INODE_SHARE flag is passed from user's mount option. And it is 
controllered by CONFIG_EROFS_FS_PAGE_CACHE_SHARE. I doesn't do the check 
when the superblock without ishare_xattrs. (It seems the mount options 
is static, although it is useless for mounting with inode_share on one 
EROFS image without ishare_xattrs).
So should we check that if the superblock has not ishare_xattrs feature, 
and we return -ENOSUPP?

Thanks,
Hongbo

> Thanks,
> Gao Xiang

