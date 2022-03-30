Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51864EBA85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 08:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiC3GCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 02:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243113AbiC3GCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:02:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A151CB16;
        Tue, 29 Mar 2022 23:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QMWT9HOFh5h5bvyOmnUYIuCvOmb24iZ90JHmyrXWtdo=; b=fWu9IeRU6R+CIOuIVc1iq4v3F8
        o1yGvrNp8FVx+vlixl02Vx1dsdjeypdTZlUnRQh+2d2LE83IKTIZjfWKZolNiHNA9Oaqg/6efFIsG
        QufkwCnXL9nWfpefvi8DTsNdLqN9jgrR2ZaRxpCll+rFbN/bFbKb8uIW/ejYLukpyYWtqlmELsfVr
        YnKPaeyjMk11SIIIYIs0IufLZx1SmrjujoiOx4YNQBv4yglpTBwqNJN+rq/OYyiaxKX970E0MtOcg
        k6ii+xG0NMpXrDwOa9Cg0+l5wgoXcCA/Mb6YDGhJKMN9ACpM/uFI913Nu6EcaaTSwWGXLUQbSAMTR
        LtAWwbeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZRNl-00EO6f-Iv; Wed, 30 Mar 2022 06:00:37 +0000
Date:   Tue, 29 Mar 2022 23:00:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v11 7/8] xfs: Implement ->notify_failure() for XFS
Message-ID: <YkPyBQer+KRiregd@infradead.org>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227120747.711169-8-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -1892,6 +1893,8 @@ xfs_free_buftarg(
>  	list_lru_destroy(&btp->bt_lru);
>  
>  	blkdev_issue_flush(btp->bt_bdev);
> +	if (btp->bt_daxdev)
> +		dax_unregister_holder(btp->bt_daxdev, btp->bt_mount);
>  	fs_put_dax(btp->bt_daxdev);
>  
>  	kmem_free(btp);
> @@ -1939,6 +1942,7 @@ xfs_alloc_buftarg(
>  	struct block_device	*bdev)
>  {
>  	xfs_buftarg_t		*btp;
> +	int			error;
>  
>  	btp = kmem_zalloc(sizeof(*btp), KM_NOFS);
>  
> @@ -1946,6 +1950,14 @@ xfs_alloc_buftarg(
>  	btp->bt_dev =  bdev->bd_dev;
>  	btp->bt_bdev = bdev;
>  	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
> +	if (btp->bt_daxdev) {
> +		error = dax_register_holder(btp->bt_daxdev, mp,
> +				&xfs_dax_holder_operations);
> +		if (error) {
> +			xfs_err(mp, "DAX device already in use?!");
> +			goto error_free;
> +		}
> +	}

It seems to me that just passing the holder and holder ops to
fs_dax_get_by_bdev and the holder to dax_unregister_holder would
significantly simply the interface here.

Dan, what do you think?

> +#if IS_ENABLED(CONFIG_MEMORY_FAILURE) && IS_ENABLED(CONFIG_FS_DAX)

No real need for the IS_ENABLED.  Also any reason to even build this
file if the options are not set?  It seems like
xfs_dax_holder_operations should just be defined to NULL and the
whole file not supported if we can't support the functionality.

Dan: not for this series, but is there any reason not to require
MEMORY_FAILURE for DAX to start with?

> +
> +	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
> +	ddev_end = ddev_start +
> +		(mp->m_ddev_targp->bt_bdev->bd_nr_sectors << SECTOR_SHIFT) - 1;

This should use bdev_nr_bytes.

But didn't we say we don't want to support notifications on partitioned
devices and thus don't actually need all this?

> +
> +	/* Ignore the range out of filesystem area */
> +	if ((offset + len) < ddev_start)

No need for the inner braces.

> +	if ((offset + len) > ddev_end)

No need for the braces either.

> diff --git a/fs/xfs/xfs_notify_failure.h b/fs/xfs/xfs_notify_failure.h
> new file mode 100644
> index 000000000000..76187b9620f9
> --- /dev/null
> +++ b/fs/xfs/xfs_notify_failure.h
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Fujitsu.  All Rights Reserved.
> + */
> +#ifndef __XFS_NOTIFY_FAILURE_H__
> +#define __XFS_NOTIFY_FAILURE_H__
> +
> +extern const struct dax_holder_operations xfs_dax_holder_operations;
> +
> +#endif  /* __XFS_NOTIFY_FAILURE_H__ */

Dowe really need a new header for this vs just sequeezing it into
xfs_super.h or something like that?

> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e8f37bdc8354..b8de6ed2c888 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -353,6 +353,12 @@ xfs_setup_dax_always(
>  		return -EINVAL;
>  	}
>  
> +	if (xfs_has_reflink(mp) && !xfs_has_rmapbt(mp)) {
> +		xfs_alert(mp,
> +			"need rmapbt when both DAX and reflink enabled.");
> +		return -EINVAL;
> +	}

Right now we can't even enable reflink with DAX yet, so adding this
here seems premature - it should go into the patch allowing DAX+reflink.

