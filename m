Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F842DB66A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 23:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgLOWRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 17:17:51 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:40033 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgLOWRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:17:39 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id B60E61ACD12;
        Wed, 16 Dec 2020 09:16:51 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kpIck-004MEv-Bl; Wed, 16 Dec 2020 09:16:50 +1100
Date:   Wed, 16 Dec 2020 09:16:50 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/2] iomap: Separate out generic_write_sync() from
 iomap_dio_complete()
Message-ID: <20201215221650.GR3913616@dread.disaster.area>
References: <cover.1608053602.git.rgoldwyn@suse.com>
 <f52d649dd35c616786b54ff7d76c6bcf95f9197e.1608053602.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52d649dd35c616786b54ff7d76c6bcf95f9197e.1608053602.git.rgoldwyn@suse.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10 a=iox4zFpeAAAA:8 a=7-415B0cAAAA:8
        a=vO0O9KBZJt_N6kGT6psA:9 a=CjuIK1q_8ugA:10 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:06:35PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This introduces a separate function __iomap_dio_complte() which
> completes the Direct I/O without performing the write sync.
> 
> Filesystems such as btrfs which require an inode_lock for sync can call
> __iomap_dio_complete() and must perform sync on their own after unlock.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/direct-io.c  | 16 +++++++++++++---
>  include/linux/iomap.h |  2 +-
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 933f234d5bec..11a108f39fd9 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -76,7 +76,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
>  		dio->submit.cookie = submit_bio(bio);
>  }
>  
> -ssize_t iomap_dio_complete(struct iomap_dio *dio)
> +ssize_t __iomap_dio_complete(struct iomap_dio *dio)
>  {
>  	const struct iomap_dio_ops *dops = dio->dops;
>  	struct kiocb *iocb = dio->iocb;
> @@ -119,18 +119,28 @@ ssize_t iomap_dio_complete(struct iomap_dio *dio)
>  	}
>  
>  	inode_dio_end(file_inode(iocb->ki_filp));
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__iomap_dio_complete);
> +
> +ssize_t iomap_dio_complete(struct iomap_dio *dio)
> +{
> +	ssize_t ret;
> +
> +	ret = __iomap_dio_complete(dio);
>  	/*
>  	 * If this is a DSYNC write, make sure we push it to stable storage now
>  	 * that we've written data.
>  	 */
>  	if (ret > 0 && (dio->flags & IOMAP_DIO_NEED_SYNC))
> -		ret = generic_write_sync(iocb, ret);
> +		ret = generic_write_sync(dio->iocb, ret);
>  
>  	kfree(dio);
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(iomap_dio_complete);
> +

NACK.

If you don't want iomap_dio_complete to do O_DSYNC work after
successfully writing data, strip those flags out of the kiocb
before you call iomap_dio_rw() and do it yourself after calling
iomap_dio_complete().

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
