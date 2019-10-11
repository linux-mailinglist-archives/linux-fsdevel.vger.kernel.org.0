Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113C8D3FB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 14:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfJKMjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 08:39:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfJKMjy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:39:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8920A30224AA;
        Fri, 11 Oct 2019 12:39:54 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08B005DD63;
        Fri, 11 Oct 2019 12:39:53 +0000 (UTC)
Date:   Fri, 11 Oct 2019 08:39:52 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/26] xfs: correctly acount for reclaimable slabs
Message-ID: <20191011123952.GE61257@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-6-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 11 Oct 2019 12:39:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:03PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The XFS inode item slab actually reclaimed by inode shrinker
> callbacks from the memory reclaim subsystem. These should be marked
> as reclaimable so the mm subsystem has the full picture of how much
> memory it can actually reclaim from the XFS slab caches.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 8d1df9f8be07..f0aff1f034e6 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1919,7 +1919,7 @@ xfs_init_zones(void)
>  
>  	xfs_ili_zone =
>  		kmem_zone_init_flags(sizeof(xfs_inode_log_item_t), "xfs_ili",
> -					KM_ZONE_SPREAD, NULL);
> +					KM_ZONE_SPREAD | KM_ZONE_RECLAIM, NULL);
>  	if (!xfs_ili_zone)
>  		goto out_destroy_inode_zone;
>  	xfs_icreate_zone = kmem_zone_init(sizeof(struct xfs_icreate_item),
> -- 
> 2.23.0.rc1
> 
