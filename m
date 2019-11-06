Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97987F1C56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 18:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbfKFRVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 12:21:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729384AbfKFRVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573060882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbEpAwa+V1r2mQr5coxjxNGhGovVZVTiWegQGbPT5xM=;
        b=X3afT0DNanAxbDsiynL/Aym9jVdp9bkCFQPhqZenm6eXDj/e0Sz9P8U7d4P/gE0/Gq0M4+
        fCe3HaM6RQeYg+ZHAtRJMkvwBaOpEKlxmtuTJyw1ZSgh/hu/v87pIELwl9KHPsHZ7Q/BpZ
        dR+KzBqXBoIOqocHNl1ZsjlQDJObXEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-ZKyHZloaNZqMSSWMmp_2xg-1; Wed, 06 Nov 2019 12:21:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35DFB1005500;
        Wed,  6 Nov 2019 17:21:16 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8499D5C1B5;
        Wed,  6 Nov 2019 17:21:15 +0000 (UTC)
Date:   Wed, 6 Nov 2019 12:21:13 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/28] xfs: remove unusued old inode reclaim code
Message-ID: <20191106172113.GC37080@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-26-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-26-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZKyHZloaNZqMSSWMmp_2xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:15AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Now that the custom AG radix tree walker has been replaced and
> removed, we don't need the radix tree tags anymore, nor the reclaim
> cursors or the locks taht protect it. Remove all remaining traces of
> these things.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_icache.c | 82 +--------------------------------------------
>  fs/xfs/xfs_icache.h |  7 ++--
>  fs/xfs/xfs_mount.c  |  4 ---
>  fs/xfs/xfs_mount.h  |  3 --
>  fs/xfs/xfs_super.c  |  5 +--
>  5 files changed, 6 insertions(+), 95 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 05dd292bfdb6..71a729e29260 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -139,83 +139,6 @@ xfs_inode_free(
>  =09__xfs_inode_free(ip);
>  }
> =20
> -static void
> -xfs_perag_set_reclaim_tag(
> -=09struct xfs_perag=09*pag)
> -{
> -=09struct xfs_mount=09*mp =3D pag->pag_mount;
> -
> -=09lockdep_assert_held(&pag->pag_ici_lock);
> -=09if (pag->pag_ici_reclaimable++)
> -=09=09return;
> -
> -=09/* propagate the reclaim tag up into the perag radix tree */
> -=09spin_lock(&mp->m_perag_lock);
> -=09radix_tree_tag_set(&mp->m_perag_tree, pag->pag_agno,
> -=09=09=09   XFS_ICI_RECLAIM_TAG);
> -=09spin_unlock(&mp->m_perag_lock);
> -
> -=09trace_xfs_perag_set_reclaim(mp, pag->pag_agno, -1, _RET_IP_);
> -}
> -
> -static void
> -xfs_perag_clear_reclaim_tag(
> -=09struct xfs_perag=09*pag)
> -{
> -=09struct xfs_mount=09*mp =3D pag->pag_mount;
> -
> -=09lockdep_assert_held(&pag->pag_ici_lock);
> -=09if (--pag->pag_ici_reclaimable)
> -=09=09return;
> -
> -=09/* clear the reclaim tag from the perag radix tree */
> -=09spin_lock(&mp->m_perag_lock);
> -=09radix_tree_tag_clear(&mp->m_perag_tree, pag->pag_agno,
> -=09=09=09     XFS_ICI_RECLAIM_TAG);
> -=09spin_unlock(&mp->m_perag_lock);
> -=09trace_xfs_perag_clear_reclaim(mp, pag->pag_agno, -1, _RET_IP_);
> -}
> -
> -
> -/*
> - * We set the inode flag atomically with the radix tree tag.
> - * Once we get tag lookups on the radix tree, this inode flag
> - * can go away.
> - */
> -void
> -xfs_inode_set_reclaim_tag(
> -=09struct xfs_inode=09*ip)
> -{
> -=09struct xfs_mount=09*mp =3D ip->i_mount;
> -=09struct xfs_perag=09*pag;
> -
> -=09pag =3D xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
> -=09spin_lock(&pag->pag_ici_lock);
> -=09spin_lock(&ip->i_flags_lock);
> -
> -=09radix_tree_tag_set(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, ip->i_ino=
),
> -=09=09=09   XFS_ICI_RECLAIM_TAG);
> -=09xfs_perag_set_reclaim_tag(pag);
> -=09__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
> -
> -=09list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
> -
> -=09spin_unlock(&ip->i_flags_lock);
> -=09spin_unlock(&pag->pag_ici_lock);
> -=09xfs_perag_put(pag);
> -}
> -
> -STATIC void
> -xfs_inode_clear_reclaim_tag(
> -=09struct xfs_perag=09*pag,
> -=09xfs_ino_t=09=09ino)
> -{
> -=09radix_tree_tag_clear(&pag->pag_ici_root,
> -=09=09=09     XFS_INO_TO_AGINO(pag->pag_mount, ino),
> -=09=09=09     XFS_ICI_RECLAIM_TAG);
> -=09xfs_perag_clear_reclaim_tag(pag);
> -}
> -
>  static void
>  xfs_inew_wait(
>  =09struct xfs_inode=09*ip)
> @@ -397,18 +320,16 @@ xfs_iget_cache_hit(
>  =09=09=09goto out_error;
>  =09=09}
> =20
> -=09=09spin_lock(&pag->pag_ici_lock);
> -=09=09spin_lock(&ip->i_flags_lock);
> =20
>  =09=09/*
>  =09=09 * Clear the per-lifetime state in the inode as we are now
>  =09=09 * effectively a new inode and need to return to the initial
>  =09=09 * state before reuse occurs.
>  =09=09 */
> +=09=09spin_lock(&ip->i_flags_lock);
>  =09=09ip->i_flags &=3D ~XFS_IRECLAIM_RESET_FLAGS;
>  =09=09ip->i_flags |=3D XFS_INEW;
>  =09=09list_lru_del(&mp->m_inode_lru, &inode->i_lru);
> -=09=09xfs_inode_clear_reclaim_tag(pag, ip->i_ino);
>  =09=09inode->i_state =3D I_NEW;
>  =09=09ip->i_sick =3D 0;
>  =09=09ip->i_checked =3D 0;
> @@ -417,7 +338,6 @@ xfs_iget_cache_hit(
>  =09=09init_rwsem(&inode->i_rwsem);
> =20
>  =09=09spin_unlock(&ip->i_flags_lock);
> -=09=09spin_unlock(&pag->pag_ici_lock);
>  =09} else {
>  =09=09/* If the VFS inode is being torn down, pause and try again. */
>  =09=09if (!igrab(inode)) {
> diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
> index 86e858e4a281..ec646b9e88b7 100644
> --- a/fs/xfs/xfs_icache.h
> +++ b/fs/xfs/xfs_icache.h
> @@ -25,9 +25,8 @@ struct xfs_eofblocks {
>   */
>  #define XFS_ICI_NO_TAG=09=09(-1)=09/* special flag for an untagged looku=
p
>  =09=09=09=09=09   in xfs_inode_ag_iterator */
> -#define XFS_ICI_RECLAIM_TAG=090=09/* inode is to be reclaimed */
> -#define XFS_ICI_EOFBLOCKS_TAG=091=09/* inode has blocks beyond EOF */
> -#define XFS_ICI_COWBLOCKS_TAG=092=09/* inode can have cow blocks to gc *=
/
> +#define XFS_ICI_EOFBLOCKS_TAG=090=09/* inode has blocks beyond EOF */
> +#define XFS_ICI_COWBLOCKS_TAG=091=09/* inode can have cow blocks to gc *=
/
> =20
>  /*
>   * Flags for xfs_iget()
> @@ -68,8 +67,6 @@ enum lru_status xfs_inode_reclaim_isolate(struct list_h=
ead *item,
>  void xfs_dispose_inodes(struct list_head *freeable);
>  void xfs_reclaim_all_inodes(struct xfs_mount *mp);
> =20
> -void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
> -
>  void xfs_inode_set_eofblocks_tag(struct xfs_inode *ip);
>  void xfs_inode_clear_eofblocks_tag(struct xfs_inode *ip);
>  int xfs_icache_free_eofblocks(struct xfs_mount *, struct xfs_eofblocks *=
);
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 5f3fd1d8f63f..9d60a4e033a0 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -148,7 +148,6 @@ xfs_free_perag(
>  =09=09ASSERT(atomic_read(&pag->pag_ref) =3D=3D 0);
>  =09=09xfs_iunlink_destroy(pag);
>  =09=09xfs_buf_hash_destroy(pag);
> -=09=09mutex_destroy(&pag->pag_ici_reclaim_lock);
>  =09=09call_rcu(&pag->rcu_head, __xfs_free_perag);
>  =09}
>  }
> @@ -200,7 +199,6 @@ xfs_initialize_perag(
>  =09=09pag->pag_agno =3D index;
>  =09=09pag->pag_mount =3D mp;
>  =09=09spin_lock_init(&pag->pag_ici_lock);
> -=09=09mutex_init(&pag->pag_ici_reclaim_lock);
>  =09=09INIT_RADIX_TREE(&pag->pag_ici_root, GFP_ATOMIC);
>  =09=09if (xfs_buf_hash_init(pag))
>  =09=09=09goto out_free_pag;
> @@ -242,7 +240,6 @@ xfs_initialize_perag(
>  out_hash_destroy:
>  =09xfs_buf_hash_destroy(pag);
>  out_free_pag:
> -=09mutex_destroy(&pag->pag_ici_reclaim_lock);
>  =09kmem_free(pag);
>  out_unwind_new_pags:
>  =09/* unwind any prior newly initialized pags */
> @@ -252,7 +249,6 @@ xfs_initialize_perag(
>  =09=09=09break;
>  =09=09xfs_buf_hash_destroy(pag);
>  =09=09xfs_iunlink_destroy(pag);
> -=09=09mutex_destroy(&pag->pag_ici_reclaim_lock);
>  =09=09kmem_free(pag);
>  =09}
>  =09return error;
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 4f153ee17e18..dea05cd867bf 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -343,9 +343,6 @@ typedef struct xfs_perag {
> =20
>  =09spinlock_t=09pag_ici_lock;=09/* incore inode cache lock */
>  =09struct radix_tree_root pag_ici_root;=09/* incore inode cache root */
> -=09int=09=09pag_ici_reclaimable;=09/* reclaimable inodes */
> -=09struct mutex=09pag_ici_reclaim_lock;=09/* serialisation point */
> -=09unsigned long=09pag_ici_reclaim_cursor;=09/* reclaim restart point */
> =20
>  =09/* buffer cache index */
>  =09spinlock_t=09pag_buf_lock;=09/* lock for pag_buf_hash */
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 096ae31b5436..d2200fbce139 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -916,7 +916,6 @@ xfs_fs_destroy_inode(
>  =09spin_lock(&ip->i_flags_lock);
>  =09ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIMABLE));
>  =09ASSERT_ALWAYS(!__xfs_iflags_test(ip, XFS_IRECLAIM));
> -=09spin_unlock(&ip->i_flags_lock);
> =20
>  =09/*
>  =09 * We always use background reclaim here because even if the
> @@ -925,7 +924,9 @@ xfs_fs_destroy_inode(
>  =09 * this more efficiently than we can here, so simply let background
>  =09 * reclaim tear down all inodes.
>  =09 */
> -=09xfs_inode_set_reclaim_tag(ip);
> +=09__xfs_iflags_set(ip, XFS_IRECLAIMABLE);
> +=09list_lru_add(&mp->m_inode_lru, &VFS_I(ip)->i_lru);
> +=09spin_unlock(&ip->i_flags_lock);
>  }
> =20
>  static void
> --=20
> 2.24.0.rc0
>=20

