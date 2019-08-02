Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2187FD7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 17:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfHBP1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 11:27:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732701AbfHBP1k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:27:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1098B307D985;
        Fri,  2 Aug 2019 15:27:40 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83B935D9D3;
        Fri,  2 Aug 2019 15:27:39 +0000 (UTC)
Date:   Fri, 2 Aug 2019 11:27:37 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/24] shrinkers: use will_defer for GFP_NOFS sensitive
 shrinkers
Message-ID: <20190802152737.GB60893@bfoster>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801021752.4986-3-david@fromorbit.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 15:27:40 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:17:30PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> For shrinkers that currently avoid scanning when called under
> GFP_NOFS contexts, conver them to use the new ->will_defer flag
> rather than checking and returning errors during scans.
> 
> This makes it very clear that these shrinkers are not doing any work
> because of the context limitations, not because there is no work
> that can be done.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  drivers/staging/android/ashmem.c |  8 ++++----
>  fs/gfs2/glock.c                  |  5 +++--
>  fs/gfs2/quota.c                  |  6 +++---
>  fs/nfs/dir.c                     |  6 +++---
>  fs/super.c                       |  6 +++---
>  fs/xfs/xfs_buf.c                 |  4 ++++
>  fs/xfs/xfs_qm.c                  | 11 ++++++++---
>  net/sunrpc/auth.c                |  5 ++---
>  8 files changed, 30 insertions(+), 21 deletions(-)
> 
...
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index ca0849043f54..6e0f76532535 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1680,6 +1680,10 @@ xfs_buftarg_shrink_count(
>  {
>  	struct xfs_buftarg	*btp = container_of(shrink,
>  					struct xfs_buftarg, bt_shrinker);
> +
> +	if (!(sc->gfp_mask & __GFP_FS))
> +		sc->will_defer = true;
> +
>  	return list_lru_shrink_count(&btp->bt_lru, sc);
>  }

This hunk looks like a behavior change / bug fix..? The rest of the
patch converts existing logic to bail out of scans to use the new count
time defer mechanism. The change is probably fine, but I think we should
have a separate patch to introduce this behavior in the first place
(which BTW could be sent as a standalone patch and just picked up by
this on eventual rebase).

Brian

>  
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 5e7a37f0cf84..13c842e8f13b 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -502,9 +502,6 @@ xfs_qm_shrink_scan(
>  	unsigned long		freed;
>  	int			error;
>  
> -	if ((sc->gfp_mask & (__GFP_FS|__GFP_DIRECT_RECLAIM)) != (__GFP_FS|__GFP_DIRECT_RECLAIM))
> -		return 0;
> -
>  	INIT_LIST_HEAD(&isol.buffers);
>  	INIT_LIST_HEAD(&isol.dispose);
>  
> @@ -534,6 +531,14 @@ xfs_qm_shrink_count(
>  	struct xfs_quotainfo	*qi = container_of(shrink,
>  					struct xfs_quotainfo, qi_shrinker);
>  
> +	/*
> +	 * __GFP_DIRECT_RECLAIM is used here to avoid blocking kswapd
> +	 */
> +	if ((sc->gfp_mask & (__GFP_FS|__GFP_DIRECT_RECLAIM)) !=
> +					(__GFP_FS|__GFP_DIRECT_RECLAIM)) {
> +		sc->will_defer = true;
> +	}
> +
>  	return list_lru_shrink_count(&qi->qi_lru, sc);
>  }
>  
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index cdb05b48de44..6babcbac4a00 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -527,9 +527,6 @@ static unsigned long
>  rpcauth_cache_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  
>  {
> -	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
> -		return SHRINK_STOP;
> -
>  	/* nothing left, don't come back */
>  	if (list_empty(&cred_unused))
>  		return SHRINK_STOP;
> @@ -541,6 +538,8 @@ static unsigned long
>  rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  
>  {
> +	if ((sc->gfp_mask & GFP_KERNEL) != GFP_KERNEL)
> +		sc->will_defer = true;
>  	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
>  }
>  
> -- 
> 2.22.0
> 
