Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935D4D6363
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfJNNHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 09:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNHL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:07:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96EC73098215;
        Mon, 14 Oct 2019 13:07:11 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 045A65C241;
        Mon, 14 Oct 2019 13:07:10 +0000 (UTC)
Date:   Mon, 14 Oct 2019 09:07:09 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/26] xfs: track reclaimable inodes using a LRU list
Message-ID: <20191014130709.GD12380@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-23-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-23-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 14 Oct 2019 13:07:11 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:20PM +1100, Dave Chinner wrote:
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

Looks reasonable:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_icache.c | 32 ++++++++------------------------
>  fs/xfs/xfs_icache.h |  1 -
>  fs/xfs/xfs_mount.h  |  1 +
>  fs/xfs/xfs_super.c  | 29 ++++++++++++++++++++++-------
>  4 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 39c56200f1ce..06fdaa746674 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -198,6 +198,8 @@ xfs_inode_set_reclaim_tag(
>  	xfs_perag_set_reclaim_tag(pag);
>  	__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
>  
> +	list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
> +
>  	spin_unlock(&ip->i_flags_lock);
>  	spin_unlock(&pag->pag_ici_lock);
>  	xfs_perag_put(pag);
> @@ -370,12 +372,10 @@ xfs_iget_cache_hit(
>  
>  		/*
>  		 * We need to set XFS_IRECLAIM to prevent xfs_reclaim_inode
> -		 * from stomping over us while we recycle the inode.  We can't
> -		 * clear the radix tree reclaimable tag yet as it requires
> -		 * pag_ici_lock to be held exclusive.
> +		 * from stomping over us while we recycle the inode. Remove it
> +		 * from the LRU straight away so we can re-init the VFS inode.
>  		 */
>  		ip->i_flags |= XFS_IRECLAIM;
> -
>  		spin_unlock(&ip->i_flags_lock);
>  		rcu_read_unlock();
>  
> @@ -407,6 +407,7 @@ xfs_iget_cache_hit(
>  		 */
>  		ip->i_flags &= ~XFS_IRECLAIM_RESET_FLAGS;
>  		ip->i_flags |= XFS_INEW;
> +		list_lru_del(&mp->m_inode_lru, &inode->i_lru);
>  		xfs_inode_clear_reclaim_tag(pag, ip->i_ino);
>  		inode->i_state = I_NEW;
>  		ip->i_sick = 0;
> @@ -1138,6 +1139,9 @@ xfs_reclaim_inode(
>  	ino = ip->i_ino; /* for radix_tree_delete */
>  	ip->i_flags = XFS_IRECLAIM;
>  	ip->i_ino = 0;
> +
> +	/* XXX: temporary until lru based reclaim */
> +	list_lru_del(&pag->pag_mount->m_inode_lru, &VFS_I(ip)->i_lru);
>  	spin_unlock(&ip->i_flags_lock);
>  
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> @@ -1329,26 +1333,6 @@ xfs_reclaim_inodes_nr(
>  	return xfs_reclaim_inodes_ag(mp, sync_mode, nr_to_scan);
>  }
>  
> -/*
> - * Return the number of reclaimable inodes in the filesystem for
> - * the shrinker to determine how much to reclaim.
> - */
> -int
> -xfs_reclaim_inodes_count(
> -	struct xfs_mount	*mp)
> -{
> -	struct xfs_perag	*pag;
> -	xfs_agnumber_t		ag = 0;
> -	int			reclaimable = 0;
> -
> -	while ((pag = xfs_perag_get_tag(mp, ag, XFS_ICI_RECLAIM_TAG))) {
> -		ag = pag->pag_agno + 1;
> -		reclaimable += pag->pag_ici_reclaimable;
> -		xfs_perag_put(pag);
> -	}
> -	return reclaimable;
> -}
> -
>  STATIC int
>  xfs_inode_match_id(
>  	struct xfs_inode	*ip,
> diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
> index 1c9b9edb2986..0ab08b58cd45 100644
> --- a/fs/xfs/xfs_icache.h
> +++ b/fs/xfs/xfs_icache.h
> @@ -50,7 +50,6 @@ struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
>  void xfs_inode_free(struct xfs_inode *ip);
>  
>  void xfs_reclaim_inodes(struct xfs_mount *mp);
> -int xfs_reclaim_inodes_count(struct xfs_mount *mp);
>  long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
>  
>  void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index f0cc952ad527..f1e4c2eae984 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -75,6 +75,7 @@ typedef struct xfs_mount {
>  	uint8_t			m_rt_sick;
>  
>  	struct xfs_ail		*m_ail;		/* fs active log item list */
> +	struct list_lru		m_inode_lru;
>  
>  	struct xfs_sb		m_sb;		/* copy of fs superblock */
>  	spinlock_t		m_sb_lock;	/* sb counter lock */
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index d0619bf02a5d..01f08706a3fb 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -920,28 +920,31 @@ xfs_fs_destroy_inode(
>  	struct inode		*inode)
>  {
>  	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
>  
>  	trace_xfs_destroy_inode(ip);
>  
>  	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
> -	XFS_STATS_INC(ip->i_mount, vn_rele);
> -	XFS_STATS_INC(ip->i_mount, vn_remove);
> +	XFS_STATS_INC(mp, vn_rele);
> +	XFS_STATS_INC(mp, vn_remove);
>  
>  	xfs_inactive(ip);
>  
> -	if (!XFS_FORCED_SHUTDOWN(ip->i_mount) && ip->i_delayed_blks) {
> +	if (!XFS_FORCED_SHUTDOWN(mp) && ip->i_delayed_blks) {
>  		xfs_check_delalloc(ip, XFS_DATA_FORK);
>  		xfs_check_delalloc(ip, XFS_COW_FORK);
>  		ASSERT(0);
>  	}
>  
> -	XFS_STATS_INC(ip->i_mount, vn_reclaim);
> +	XFS_STATS_INC(mp, vn_reclaim);
>  
>  	/*
>  	 * We should never get here with one of the reclaim flags already set.
>  	 */
> -	ASSERT_ALWAYS(!xfs_iflags_test(ip, XFS_IRECLAIMABLE));
> -	ASSERT_ALWAYS(!xfs_iflags_test(ip, XFS_IRECLAIM));
> +	spin_lock(&ip->i_flags_lock);
> +	ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIMABLE));
> +	ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIM));
> +	spin_unlock(&ip->i_flags_lock);
>  
>  	/*
>  	 * We always use background reclaim here because even if the
> @@ -1542,6 +1545,15 @@ xfs_mount_alloc(
>  	if (!mp)
>  		return NULL;
>  
> +	/*
> +	 * The inode lru needs to be associated with the superblock shrinker,
> +	 * and like the rest of the superblock shrinker, it's memcg aware.
> +	 */
> +	if (list_lru_init_memcg(&mp->m_inode_lru, &sb->s_shrink)) {
> +		kfree(mp);
> +		return NULL;
> +	}
> +
>  	mp->m_super = sb;
>  	spin_lock_init(&mp->m_sb_lock);
>  	spin_lock_init(&mp->m_agirotor_lock);
> @@ -1751,6 +1763,7 @@ xfs_fs_fill_super(
>   out_free_fsname:
>  	sb->s_fs_info = NULL;
>  	xfs_free_fsname(mp);
> +	list_lru_destroy(&mp->m_inode_lru);
>  	kfree(mp);
>   out:
>  	return error;
> @@ -1783,6 +1796,7 @@ xfs_fs_put_super(
>  
>  	sb->s_fs_info = NULL;
>  	xfs_free_fsname(mp);
> +	list_lru_destroy(&mp->m_inode_lru);
>  	kfree(mp);
>  }
>  
> @@ -1804,7 +1818,8 @@ xfs_fs_nr_cached_objects(
>  	/* Paranoia: catch incorrect calls during mount setup or teardown */
>  	if (WARN_ON_ONCE(!sb->s_fs_info))
>  		return 0;
> -	return xfs_reclaim_inodes_count(XFS_M(sb));
> +
> +	return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
>  }
>  
>  static long
> -- 
> 2.23.0.rc1
> 
