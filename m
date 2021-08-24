Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5127F3F5D26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhHXLdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 07:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236670AbhHXLdv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:33:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4E47610F8;
        Tue, 24 Aug 2021 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629804788;
        bh=2Hc2s5MP8VgjPj7miIH53TIMlz5XScjpv+wx8O+JKHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHD2NIU/6yYZ1HNWv2I2wmTJNvlnhCJO30OIr+QFykf75+O0TDyWO8ocfcXI/f9YK
         yRMY7TMhVlrQ+eFRL8V/StoL3NpCmS1tXo47Ahu9d5Ia7sR+y6f7OimzzepX0wYtN8
         8DkyNbRbPZn6Vcnx0DWgwlZZ6cKBOid3LgG2xMQc77XDE6KGsiBg8tjQc2V8jYZck4
         GpvZ8xp2wIx7e1cgOmP7yGV+LMaXUC67JTlP2qn8HhMJPri2pcn8uI3CNXImW5FMpq
         qT0BC2CKxrdShXFFaLMdb8mHsz6/jYYGehQaLgRtBrLKHgieuj/CU7BtJRMYH/X4vw
         9U3RsSqf0FBHw==
Received: by pali.im (Postfix)
        id 43EB67A5; Tue, 24 Aug 2021 13:33:05 +0200 (CEST)
Date:   Tue, 24 Aug 2021 13:33:04 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     viro@zeniv.linux.org.uk,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dsterba@suse.cz, aaptel@suse.com, willy@infradead.org,
        rdunlap@infradead.org, joe@perches.com, mark@harmstone.com,
        nborisov@suse.com, linux-ntfs-dev@lists.sourceforge.net,
        anton@tuxera.com, dan.carpenter@oracle.com, hch@lst.de,
        ebiggers@kernel.org, andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20210824113304.eabzy7ulbuouzlac@pali>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-5-almaz.alexandrovich@paragon-software.com>
 <20210822122003.kb56lexgvv6prf2t@pali>
 <20210822143133.4meiisx2tbfgrz5l@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210822143133.4meiisx2tbfgrz5l@kari-VirtualBox>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sunday 22 August 2021 17:31:33 Kari Argillander wrote:
> On Sun, Aug 22, 2021 at 02:20:03PM +0200, Pali Rohár wrote:
> > On Thursday 29 July 2021 16:49:37 Konstantin Komarov wrote:
> > > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> > > new file mode 100644
> > > index 000000000..b4369c61a
> > > --- /dev/null
> > > +++ b/fs/ntfs3/file.c
> > > @@ -0,0 +1,1130 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + *
> > > + * Copyright (C) 2019-2021 Paragon Software GmbH, All rights reserved.
> > > + *
> > > + *  regular file handling primitives for ntfs-based filesystems
> > > + */
> > > +#include <linux/backing-dev.h>
> > > +#include <linux/buffer_head.h>
> > > +#include <linux/compat.h>
> > > +#include <linux/falloc.h>
> > > +#include <linux/fiemap.h>
> > > +#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
> > > +#include <linux/nls.h>
> > > +
> > > +#include "debug.h"
> > > +#include "ntfs.h"
> > > +#include "ntfs_fs.h"
> > > +
> > > +static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
> > > +{
> > > +	struct fstrim_range __user *user_range;
> > > +	struct fstrim_range range;
> > > +	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
> > > +	int err;
> > > +
> > > +	if (!capable(CAP_SYS_ADMIN))
> > > +		return -EPERM;
> > > +
> > > +	if (!blk_queue_discard(q))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	user_range = (struct fstrim_range __user *)arg;
> > > +	if (copy_from_user(&range, user_range, sizeof(range)))
> > > +		return -EFAULT;
> > > +
> > > +	range.minlen = max_t(u32, range.minlen, q->limits.discard_granularity);
> > > +
> > > +	err = ntfs_trim_fs(sbi, &range);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	if (copy_to_user(user_range, &range, sizeof(range)))
> > > +		return -EFAULT;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
> > > +{
> > > +	struct inode *inode = file_inode(filp);
> > > +	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
> > > +	u32 __user *user_attr = (u32 __user *)arg;
> > > +
> > > +	switch (cmd) {
> > > +	case FAT_IOCTL_GET_ATTRIBUTES:
> > > +		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
> > > +
> > > +	case FAT_IOCTL_GET_VOLUME_ID:
> > > +		return put_user(sbi->volume.ser_num, user_attr);
> > > +
> > > +	case FITRIM:
> > > +		return ntfs_ioctl_fitrim(sbi, arg);
> > > +	}
> > > +	return -ENOTTY; /* Inappropriate ioctl for device */
> > > +}
> > 
> > Hello! What with these two FAT_* ioctls in NTFS code? Should NTFS driver
> > really implements FAT ioctls? Because they looks like some legacy API
> > which is even not implemented by current ntfs.ko driver.
> 
> I was looking same thing when doing new ioctl for shutdown. These
> should be dropped completly before this gets upstream. Then we have
> more time to think what ioctl calls should used and which are
> necessarry.

Ok. I agree, these FAT* ioctls should not be included into upstream in
this way. Later we can decide how to handle them...

> > Specially, should FS driver implements ioctl for get volume id which in
> > this way? Because basically every fs have some kind of uuid / volume id
> > and they can be already retrieved by appropriate userspace tool.
> 
> My first impression when looking this code was that this is just copy
> paste work from fat driver. FITRIM is exactly the same. Whoever
> copyed it must have not thinked this very closly. Good thing you
> bringing this up.
> 
> I didn't want to just yet because there is quite lot messages and
> things which are in Komarov todo list. Hopefully radio silence will
> end soon. I'm afraid next message will be "Please pull" for Linus
> and then it cannot happend because of radio silence.
> 
