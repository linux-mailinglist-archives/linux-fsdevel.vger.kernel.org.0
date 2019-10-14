Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348A5D6361
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbfJNNHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 09:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNHD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:07:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CD7CA707;
        Mon, 14 Oct 2019 13:07:03 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDCEC19C68;
        Mon, 14 Oct 2019 13:07:02 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:07:01 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 21/26] xfs: remove mode from xfs_reclaim_inodes()
Message-ID: <20191014130701.GC12380@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-22-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-22-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 14 Oct 2019 13:07:03 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:19PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because it's always SYNC_WAIT now.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Modulo the function name discussion:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_icache.c | 7 +++----
>  fs/xfs/xfs_icache.h | 2 +-
>  fs/xfs/xfs_mount.c  | 4 ++--
>  fs/xfs/xfs_super.c  | 3 +--
>  4 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index ed996b37bda0..39c56200f1ce 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -1293,12 +1293,11 @@ xfs_reclaim_inodes_ag(
>  	return freed;
>  }
>  
> -int
> +void
>  xfs_reclaim_inodes(
> -	xfs_mount_t	*mp,
> -	int		mode)
> +	struct xfs_mount	*mp)
>  {
> -	return xfs_reclaim_inodes_ag(mp, mode, INT_MAX);
> +	xfs_reclaim_inodes_ag(mp, SYNC_WAIT, INT_MAX);
>  }
>  
>  /*
> diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
> index 4c0d8920cc54..1c9b9edb2986 100644
> --- a/fs/xfs/xfs_icache.h
> +++ b/fs/xfs/xfs_icache.h
> @@ -49,7 +49,7 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *tp, xfs_ino_t ino,
>  struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
>  void xfs_inode_free(struct xfs_inode *ip);
>  
> -int xfs_reclaim_inodes(struct xfs_mount *mp, int mode);
> +void xfs_reclaim_inodes(struct xfs_mount *mp);
>  int xfs_reclaim_inodes_count(struct xfs_mount *mp);
>  long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
>  
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index ecbc21af9100..3a38fe7c4f8d 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -988,7 +988,7 @@ xfs_mountfs(
>  	 * qm_unmount_quotas and therefore rely on qm_unmount to release the
>  	 * quota inodes.
>  	 */
> -	xfs_reclaim_inodes(mp, SYNC_WAIT);
> +	xfs_reclaim_inodes(mp);
>  	xfs_health_unmount(mp);
>   out_log_dealloc:
>  	mp->m_flags |= XFS_MOUNT_UNMOUNTING;
> @@ -1070,7 +1070,7 @@ xfs_unmountfs(
>  	 * reclaim just to be sure. We can stop background inode reclaim
>  	 * here as well if it is still running.
>  	 */
> -	xfs_reclaim_inodes(mp, SYNC_WAIT);
> +	xfs_reclaim_inodes(mp);
>  	xfs_health_unmount(mp);
>  
>  	xfs_qm_unmount(mp);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 74767e6f48a7..d0619bf02a5d 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1180,8 +1180,7 @@ xfs_quiesce_attr(
>  	xfs_log_force(mp, XFS_LOG_SYNC);
>  
>  	/* reclaim inodes to do any IO before the freeze completes */
> -	xfs_reclaim_inodes(mp, 0);
> -	xfs_reclaim_inodes(mp, SYNC_WAIT);
> +	xfs_reclaim_inodes(mp);
>  
>  	/* Push the superblock and write an unmount record */
>  	error = xfs_log_sbcount(mp);
> -- 
> 2.23.0.rc1
> 
