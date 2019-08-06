Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1550783886
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfHFSWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 14:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728582AbfHFSWP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:22:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 936F71E30F;
        Tue,  6 Aug 2019 18:22:15 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1B95C258;
        Tue,  6 Aug 2019 18:22:14 +0000 (UTC)
Date:   Tue, 6 Aug 2019 14:22:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/24] xfs: reduce kswapd blocking on inode locking.
Message-ID: <20190806182213.GF2979@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-19-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-19-david@fromorbit.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 06 Aug 2019 18:22:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:46PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When doing async node reclaiming, we grab a batch of inodes that we
> are likely able to reclaim and ignore those that are already
> flushing. However, when we actually go to reclaim them, the first
> thing we do is lock the inode. If we are racing with something
> else reclaiming the inode or flushing it because it is dirty,
> we block on the inode lock. Hence we can still block kswapd here.
> 
> Further, if we flush an inode, we also cluster all the other dirty
> inodes in that cluster into the same IO, flush locking them all.
> However, if the workload is operating on sequential inodes (e.g.
> created by a tarball extraction) most of these inodes will be
> sequntial in the cache and so in the same batch
> we've already grabbed for reclaim scanning.
> 
> As a result, it is common for all the inodes in the batch to be
> dirty and it is common for the first inode flushed to also flush all
> the inodes in the reclaim batch. In which case, they are now all
> going to be flush locked and we do not want to block on them.
> 

Hmm... I think I'm missing something with this description. For dirty
inodes that are flushed in a cluster via reclaim as described, aren't we
already blocking on all of the flush locks by virtue of the synchronous
I/O associated with the flush of the first dirty inode in that
particular cluster?

Brian

> Hence, for async reclaim (SYNC_TRYLOCK) make sure we always use
> trylock semantics and abort reclaim of an inode as quickly as we can
> without blocking kswapd.
> 
> Found via tracing and finding big batches of repeated lock/unlock
> runs on inodes that we just flushed by write clustering during
> reclaim.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/xfs_icache.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 2fa2f8dcf86b..e6b9030875b9 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -1104,11 +1104,23 @@ xfs_reclaim_inode(
>  
>  restart:
>  	error = 0;
> -	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -	if (!xfs_iflock_nowait(ip)) {
> -		if (!(sync_mode & SYNC_WAIT))
> +	/*
> +	 * Don't try to flush the inode if another inode in this cluster has
> +	 * already flushed it after we did the initial checks in
> +	 * xfs_reclaim_inode_grab().
> +	 */
> +	if (sync_mode & SYNC_TRYLOCK) {
> +		if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
>  			goto out;
> -		xfs_iflock(ip);
> +		if (!xfs_iflock_nowait(ip))
> +			goto out_unlock;
> +	} else {
> +		xfs_ilock(ip, XFS_ILOCK_EXCL);
> +		if (!xfs_iflock_nowait(ip)) {
> +			if (!(sync_mode & SYNC_WAIT))
> +				goto out_unlock;
> +			xfs_iflock(ip);
> +		}
>  	}
>  
>  	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
> @@ -1215,9 +1227,10 @@ xfs_reclaim_inode(
>  
>  out_ifunlock:
>  	xfs_ifunlock(ip);
> +out_unlock:
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  out:
>  	xfs_iflags_clear(ip, XFS_IRECLAIM);
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	/*
>  	 * We could return -EAGAIN here to make reclaim rescan the inode tree in
>  	 * a short while. However, this just burns CPU time scanning the tree
> -- 
> 2.22.0
> 
