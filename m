Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC283F3F3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Aug 2021 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhHVMUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Aug 2021 08:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhHVMUr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:20:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D91D6126A;
        Sun, 22 Aug 2021 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629634806;
        bh=fnzZTcKvp2q8oy8pfW79kIB0yHT1Ujv1I88z7SOBbJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snUzs/Pgaxs6SPoVblzbomb44FY/Eaz9Ifoc/aZJuP+sYyIyFNIQPrUCv8+5/8qkX
         P3gOlvie33pV9YYQPoKY/TDNzSqc6OK/7+S6+KMoB5ze3cZyGX7R/2h9W8+Vu8RV73
         dOB5PUtq0IM7aMy7kumqt8d7owvClL0zdBsYoSAsg/6r3J33ET4H8IbkwRYx+zTNSF
         5kPwM3ySNoYWLPZY4OPFxQLpqqlt/Ff9LMKxJQvXIl5maxqEOMrH9k7Meh3vlGtm2E
         aDSyeE33z6JZGvJlMqaX6q5IH0yXiLti7CXVsyODR+9WPhY9b62wQp6R6IPN3YRK+X
         QZAK8xe+Vlenw==
Received: by pali.im (Postfix)
        id 585407C7; Sun, 22 Aug 2021 14:20:03 +0200 (CEST)
Date:   Sun, 22 Aug 2021 14:20:03 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>,
        viro@zeniv.linux.org.uk
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dsterba@suse.cz, aaptel@suse.com, willy@infradead.org,
        rdunlap@infradead.org, joe@perches.com, mark@harmstone.com,
        nborisov@suse.com, linux-ntfs-dev@lists.sourceforge.net,
        anton@tuxera.com, dan.carpenter@oracle.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20210822122003.kb56lexgvv6prf2t@pali>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729134943.778917-5-almaz.alexandrovich@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 29 July 2021 16:49:37 Konstantin Komarov wrote:
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> new file mode 100644
> index 000000000..b4369c61a
> --- /dev/null
> +++ b/fs/ntfs3/file.c
> @@ -0,0 +1,1130 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *
> + * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
> + *
> + *  regular file handling primitives for ntfs-based filesystems
> + */
> +#include <linux/backing-dev.h>
> +#include <linux/buffer_head.h>
> +#include <linux/compat.h>
> +#include <linux/falloc.h>
> +#include <linux/fiemap.h>
> +#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
> +#include <linux/nls.h>
> +
> +#include "debug.h"
> +#include "ntfs.h"
> +#include "ntfs_fs.h"
> +
> +static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
> +{
> +	struct fstrim_range __user *user_range;
> +	struct fstrim_range range;
> +	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
> +	int err;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (!blk_queue_discard(q))
> +		return -EOPNOTSUPP;
> +
> +	user_range = (struct fstrim_range __user *)arg;
> +	if (copy_from_user(&range, user_range, sizeof(range)))
> +		return -EFAULT;
> +
> +	range.minlen = max_t(u32, range.minlen, q->limits.discard_granularity);
> +
> +	err = ntfs_trim_fs(sbi, &range);
> +	if (err < 0)
> +		return err;
> +
> +	if (copy_to_user(user_range, &range, sizeof(range)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
> +{
> +	struct inode *inode = file_inode(filp);
> +	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
> +	u32 __user *user_attr = (u32 __user *)arg;
> +
> +	switch (cmd) {
> +	case FAT_IOCTL_GET_ATTRIBUTES:
> +		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
> +
> +	case FAT_IOCTL_GET_VOLUME_ID:
> +		return put_user(sbi->volume.ser_num, user_attr);
> +
> +	case FITRIM:
> +		return ntfs_ioctl_fitrim(sbi, arg);
> +	}
> +	return -ENOTTY; /* Inappropriate ioctl for device */
> +}

Hello! What with these two FAT_* ioctls in NTFS code? Should NTFS driver
really implements FAT ioctls? Because they looks like some legacy API
which is even not implemented by current ntfs.ko driver.

Specially, should FS driver implements ioctl for get volume id which in
this way? Because basically every fs have some kind of uuid / volume id
and they can be already retrieved by appropriate userspace tool.
