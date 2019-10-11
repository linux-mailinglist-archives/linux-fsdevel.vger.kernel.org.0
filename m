Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64C9D3FAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfJKMjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 08:39:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfJKMjm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:39:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CE6B10C092E;
        Fri, 11 Oct 2019 12:39:42 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FE2F60BE1;
        Fri, 11 Oct 2019 12:39:41 +0000 (UTC)
Date:   Fri, 11 Oct 2019 08:39:39 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191011123939.GD61257@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-5-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 11 Oct 2019 12:39:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:02PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The buffer cache shrinker frees more than just the xfs_buf slab
> objects - it also frees the pages attached to the buffers. Make sure
> the memory reclaim code accounts for this memory being freed
> correctly, similar to how the inode shrinker accounts for pages
> freed from the page cache due to mapping invalidation.
> 
> We also need to make sure that the mm subsystem knows these are
> reclaimable objects. We provide the memory reclaim subsystem with a
> a shrinker to reclaim xfs_bufs, so we should really mark the slab
> that way.
> 
> We also have a lot of xfs_bufs in a busy system, spread them around
> like we do inodes.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Seems reasonable, but for inodes we also spread the ili zone. Should we
not be consistent with bli's as well?

Brian

>  fs/xfs/xfs_buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index e484f6bead53..45b470f55ad7 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -324,6 +324,9 @@ xfs_buf_free(
>  
>  			__free_page(page);
>  		}
> +		if (current->reclaim_state)
> +			current->reclaim_state->reclaimed_slab +=
> +							bp->b_page_count;
>  	} else if (bp->b_flags & _XBF_KMEM)
>  		kmem_free(bp->b_addr);
>  	_xfs_buf_free_pages(bp);
> @@ -2064,7 +2067,8 @@ int __init
>  xfs_buf_init(void)
>  {
>  	xfs_buf_zone = kmem_zone_init_flags(sizeof(xfs_buf_t), "xfs_buf",
> -						KM_ZONE_HWALIGN, NULL);
> +			KM_ZONE_HWALIGN | KM_ZONE_SPREAD | KM_ZONE_RECLAIM,
> +			NULL);
>  	if (!xfs_buf_zone)
>  		goto out;
>  
> -- 
> 2.23.0.rc1
> 
