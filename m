Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA686737
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfHHQgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 12:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732698AbfHHQgz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:36:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6010664467;
        Thu,  8 Aug 2019 16:36:55 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D7710016EB;
        Thu,  8 Aug 2019 16:36:54 +0000 (UTC)
Date:   Thu, 8 Aug 2019 12:36:53 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/24] xfs: track reclaimable inodes using a LRU list
Message-ID: <20190808163653.GB24551@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-23-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-23-david@fromorbit.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 08 Aug 2019 16:36:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:50PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Now that we don't do IO from the inode reclaim code, there is no
> need to optimise inode scanning order for optimal IO
> characteristics. The AIL takes care of that for us, so now reclaim
> can focus on selecting the best inodes to reclaim.
> 
> Hence we can change the inode reclaim algorithm to a real LRU and
> remove the need to use the radix tree to track and walk inodes under
> reclaim. This frees up a radix tree bit and simplifies the code that
> marks inodes are reclaim candidates. It also simplifies the reclaim
> code - we don't need batching anymore and all the reclaim logic
> can be added to the LRU isolation callback.
> 
> Further, we get node aware reclaim at the xfs_inode level, which
> should help the per-node reclaim code free relevant inodes faster.
> 
> We can re-use the VFS inode lru pointers - once the inode has been
> reclaimed from the VFS, we can use these pointers ourselves. Hence
> we don't need to grow the inode to change the way we index
> reclaimable inodes.
> 
> Start by adding the list_lru tracking in parallel with the existing
> reclaim code. This makes it easier to see the LRU infrastructure
> separate to the reclaim algorithm changes. Especially the locking
> order, which is ip->i_flags_lock -> list_lru lock.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_icache.c | 31 +++++++------------------------
>  fs/xfs/xfs_icache.h |  1 -
>  fs/xfs/xfs_mount.h  |  1 +
>  fs/xfs/xfs_super.c  | 31 ++++++++++++++++++++++++-------
>  4 files changed, 32 insertions(+), 32 deletions(-)
> 
...
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index a59d3a21be5c..b5c4c1b6fd19 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
...
> @@ -1801,7 +1817,8 @@ xfs_fs_nr_cached_objects(
>  	/* Paranoia: catch incorrect calls during mount setup or teardown */
>  	if (WARN_ON_ONCE(!sb->s_fs_info))
>  		return 0;
> -	return xfs_reclaim_inodes_count(XFS_M(sb));
> +
> +	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);

Do we not need locking here, or are we just skipping it because this
apparently maintains a count field and accuracy isn't critical? If the
latter, a one liner comment would be useful.

Brian

>  }
>  
>  static long
> -- 
> 2.22.0
> 
