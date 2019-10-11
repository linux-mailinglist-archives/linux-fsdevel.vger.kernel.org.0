Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D2D443C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfJKPaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 11:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfJKP37 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D10683065450;
        Fri, 11 Oct 2019 15:29:59 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53E745E1C5;
        Fri, 11 Oct 2019 15:29:59 +0000 (UTC)
Date:   Fri, 11 Oct 2019 11:29:57 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/26] xfs: don't block kswapd in inode reclaim
Message-ID: <20191011152957.GI61257@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-18-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-18-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 11 Oct 2019 15:29:59 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:15PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> We have a number of reasons for blocking kswapd in XFS inode
> reclaim, mainly all to do with the fact that memory reclaim has no
> feedback mechanisms to throttle on dirty slab objects that need IO
> to reclaim.
> 
> As a result, we currently throttle inode reclaim by issuing IO in
> the reclaim context. The unfortunate side effect of this is that it
> can cause long tail latencies in reclaim and for some workloads this
> can be a problem.
> 
> Now that the shrinkers finally have a method of telling kswapd to
> back off, we can start the process of making inode reclaim in XFS
> non-blocking. The first thing we need to do is not block kswapd, but
> so that doesn't cause immediate serious problems, make sure inode
> writeback is always underway when kswapd is running.
> 
> As we don't block kswapd now, we don't have to worry about reclaim
> scans taking long delays due to IO being issued and waited for.
> Hence while direct reclaim gets delayed by IO, kswapd will not and
> so it will keep pushing the AIL to clean inodes. Hence direct
> reclaim doesn't need to push the AIL anymore as kswapd will do it
> reliably now.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_icache.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 944add5ff8e0..edcc3f6bb3bf 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -1378,11 +1378,22 @@ xfs_reclaim_inodes_nr(
>  	struct xfs_mount	*mp,
>  	int			nr_to_scan)
>  {
> -	/* kick background reclaimer and push the AIL */
> +	int			sync_mode = SYNC_TRYLOCK;
> +
> +	/* kick background reclaimer */
>  	xfs_reclaim_work_queue(mp);
> -	xfs_ail_push_all(mp->m_ail);
>  
> -	return xfs_reclaim_inodes_ag(mp, SYNC_TRYLOCK | SYNC_WAIT, &nr_to_scan);
> +	/*
> +	 * For kswapd, we kick background inode writeback. For direct
> +	 * reclaim, we issue and wait on inode writeback to throttle
> +	 * reclaim rates and avoid shouty OOM-death.
> +	 */
> +	if (current_is_kswapd())
> +		xfs_ail_push_all(mp->m_ail);
> +	else
> +		sync_mode |= SYNC_WAIT;
> +
> +	return xfs_reclaim_inodes_ag(mp, sync_mode, &nr_to_scan);
>  }
>  
>  /*
> -- 
> 2.23.0.rc1
> 
