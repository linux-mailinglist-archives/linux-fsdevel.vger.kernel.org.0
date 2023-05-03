Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854716F60B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 23:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjECV6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 17:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjECV6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 17:58:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19E176B4
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 14:58:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b50a02bffso4341194b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 14:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683151130; x=1685743130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=utvU5QtMOHItQUMD6lrtAs8Wr5pQXqi5OJWCl5bkj/0=;
        b=tvIXyHrnLyKA2x1/3ixxeDOmxncJn3NGOI34hCBw6aO0vlBonwcg1VFOG5j3O8dbXI
         6INVus5KAgUVJq2EsYw5CY9f9Ik16f7QXHgdKbNWrWt5O94CBfM1xEj4/vRg4s+5elHd
         FSc1O2VPz2/GHRq/pdkaGfYgQ1P1sRS6Bs+ZcHCC9woSFJBCySsUZM4dSURJ+ynG7Xot
         CHzooPFNGVLm90Gu2WAvozhH/rrV4glEWUZhEstADJ6Jqv1kQEEuy+jJSX9CeWXFshVu
         SdRH0tPycWs8EbaHXYCPYCihh0qtb5/2zAqhhJ6PbpqHs5YaC8mvf27EKhScsw321GZw
         6hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683151130; x=1685743130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utvU5QtMOHItQUMD6lrtAs8Wr5pQXqi5OJWCl5bkj/0=;
        b=YBYSdAxsfxe4nl4I5oHmivq1hTV0V+3i8dGoo/IA9rBqE1MvN57iJI6lO5MzIV7v9S
         pAkmSbAoITYp2CuMbXEYckBmW4ANiDuu4gsvsa7p6+p+ny0ImBNwjg2fWDLNE/rR1K3n
         H2X6EpB9UHbdSEOX81fFulnQiULA2jzK+CfnjhKJCNKBnhs1K7ztuT7FWaOM/ZbgCysg
         inArvyICtrFyJpEicYv9+QW5dwuHjDo7XhRtlmrRR4zmZC4FXoKdceK3K/3TCnemLCWG
         CFUS73u95kMUjlFQuzLo7Yx6hmXuN/IZvJIdiKnPooXfSdVO2v2bgzRVEVN/g8hg3RjO
         MI8w==
X-Gm-Message-State: AC+VfDyJ9tk3GYBwXEGcJbTL3+4iiO4uVFZrL2a4fr9/wuvhsmlH/Rxc
        srBveOxzEuUJkjxWEhNxAz/6bg==
X-Google-Smtp-Source: ACHHUZ6p7TCZTMBYI9apxL3KzrmzkMEgHVXC+J+6oGMOdBUet/QJwy+eVYfp51Of6HElOgcccqSInQ==
X-Received: by 2002:a05:6a20:1593:b0:f3:3578:6699 with SMTP id h19-20020a056a20159300b000f335786699mr28979966pzj.45.1683151130066;
        Wed, 03 May 2023 14:58:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm24025265pfb.104.2023.05.03.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:58:49 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1puKUo-00B0iy-Si; Thu, 04 May 2023 07:58:46 +1000
Date:   Thu, 4 May 2023 07:58:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
Message-ID: <20230503215846.GE3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-3-john.g.garry@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 06:38:07PM +0000, John Garry wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> Extend statx system call to return additional info for atomic write support
> support if the specified file is a block device.
> 
> Add initial support for a block device.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  block/bdev.c              | 21 +++++++++++++++++++++
>  fs/stat.c                 | 10 ++++++++++
>  include/linux/blkdev.h    |  4 ++++
>  include/linux/stat.h      |  2 ++
>  include/uapi/linux/stat.h |  7 ++++++-
>  5 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index 1795c7d4b99e..6a5fd5abaadc 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -1014,3 +1014,24 @@ void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  
>  	blkdev_put_no_open(bdev);
>  }
> +
> +/*
> + * Handle statx for block devices to get properties of WRITE ATOMIC
> + * feature support.
> + */
> +void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
> +{
> +	struct block_device *bdev;
> +
> +	bdev = blkdev_get_no_open(inode->i_rdev);
> +	if (!bdev)
> +		return;
> +
> +	stat->atomic_write_unit_min = queue_atomic_write_unit_min(bdev->bd_queue);
> +	stat->atomic_write_unit_max = queue_atomic_write_unit_max(bdev->bd_queue);
> +	stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
> +	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
> +	stat->result_mask |= STATX_WRITE_ATOMIC;
> +
> +	blkdev_put_no_open(bdev);
> +}
> diff --git a/fs/stat.c b/fs/stat.c
> index 7c238da22ef0..d20334a0e9ae 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -256,6 +256,14 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
>  			bdev_statx_dioalign(inode, stat);
>  	}
>  
> +	/* Handle STATX_WRITE_ATOMIC for block devices */
> +	if (request_mask & STATX_WRITE_ATOMIC) {
> +		struct inode *inode = d_backing_inode(path.dentry);
> +
> +		if (S_ISBLK(inode->i_mode))
> +			bdev_statx_atomic(inode, stat);
> +	}

This duplicates STATX_DIOALIGN bdev handling.

Really, the bdev attribute handling should be completely factored
out of vfs_statx() - blockdevs are not the common fastpath for stat
operations. Somthing like:

	/*
	 * If this is a block device inode, override the filesystem
	 * attributes with the block device specific parameters
	 * that need to be obtained from the bdev backing inode.
	 */
	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
		bdev_statx(path.dentry, stat);

And then all the overrides can go in the one function that doesn't
need to repeatedly check S_ISBLK()....


> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 6b6f2992338c..19d33b2897b2 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1527,6 +1527,7 @@ int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
>  int sync_blockdev_nowait(struct block_device *bdev);
>  void sync_bdevs(bool wait);
>  void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
> +void bdev_statx_atomic(struct inode *inode, struct kstat *stat);
>  void printk_all_partitions(void);
>  #else
>  static inline void invalidate_bdev(struct block_device *bdev)
> @@ -1546,6 +1547,9 @@ static inline void sync_bdevs(bool wait)
>  static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
>  {
>  }
> +static inline void bdev_statx_atomic(struct inode *inode, struct kstat *stat)
> +{
> +}
>  static inline void printk_all_partitions(void)
>  {
>  }

That also gets rid of the need for all these fine grained exports
out of the bdev code for statx....

> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 52150570d37a..dfa69ecfaacf 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -53,6 +53,8 @@ struct kstat {
>  	u32		dio_mem_align;
>  	u32		dio_offset_align;
>  	u64		change_cookie;
> +	u32		atomic_write_unit_max;
> +	u32		atomic_write_unit_min;
>  };
>  
>  /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7cab2c65d3d7..c99d7cac2aa6 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -127,7 +127,10 @@ struct statx {
>  	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
>  	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
>  	/* 0xa0 */
> -	__u64	__spare3[12];	/* Spare space for future expansion */
> +	__u32	stx_atomic_write_unit_max;
> +	__u32	stx_atomic_write_unit_min;
> +	/* 0xb0 */
> +	__u64	__spare3[11];	/* Spare space for future expansion */
>  	/* 0x100 */
>  };

No documentation on what units these are in. Is there a statx() man
page update for this addition?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
