Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC4F1C50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfKFRVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 12:21:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45293 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732227AbfKFRVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573060874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jdTPiicaYKpt1hJbRgKNmP6Z5yz6kmKb6JE7hZS7wak=;
        b=DPJznwPs5nrb1h5BN7+V6E8v/Ei8/Vd8ZaDC6zlr8dAdY38besHeKovb/bTgk1BI2GMPXB
        80ju9THQVn8dVrzVL7/VaMGfzk/CGyop1PAG8OF1DSx7x+VvmSPwXC7Mk65B8XSTSzx9O1
        CWPJzn5eba77Vl4Ws11XZKjzDyTk8AQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-WaXQMZBHM76t3-v7pXGm0Q-1; Wed, 06 Nov 2019 12:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19BAA1005500;
        Wed,  6 Nov 2019 17:21:07 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68341608B5;
        Wed,  6 Nov 2019 17:21:06 +0000 (UTC)
Date:   Wed, 6 Nov 2019 12:21:04 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/28] xfs: reclaim inodes from the LRU
Message-ID: <20191106172104.GB37080@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-25-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-25-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WaXQMZBHM76t3-v7pXGm0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:14AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Replace the AG radix tree walking reclaim code with a list_lru
> walker, giving us both node-aware and memcg-aware inode reclaim
> at the XFS level. This requires adding an inode isolation function to
> determine if the inode can be reclaim, and a list walker to
> dispose of the inodes that were isolated.
>=20
> We want the isolation function to be non-blocking. If we can't
> grab an inode then we either skip it or rotate it. If it's clean
> then we skip it, if it's dirty then we rotate to give it time to be
> cleaned before it is scanned again.
>=20
> This congregates the dirty inodes at the tail of the LRU, which
> means that if we start hitting a majority of dirty inodes either
> there are lots of unlinked inodes in the reclaim list or we've
> reclaimed all the clean inodes and we're looped back on the dirty
> inodes. Either way, this is an indication we should tell kswapd to
> back off.
>=20
> The non-blocking isolation function introduces a complexity for the
> filesystem shutdown case. When the filesystem is shut down, we want
> to free the inode even if it is dirty, and this may require
> blocking. We already hold the locks needed to do this blocking, so
> what we do is that we leave inodes locked - both the ILOCK and the
> flush lock - while they are sitting on the dispose list to be freed
> after the LRU walk completes.  This allows us to process the
> shutdown state outside the LRU walk where we can block safely.
>=20
> Because we now are reclaiming inodes from the context that it needs
> memory in (memcg and/or node), direct reclaim throttling within the
> high level reclaim code in now much more effective. Hence we don't
> wait on IO for either kswapd or direct reclaim. However, we have to
> tell kswapd to back off if we start hitting too many dirty inodes.
> This implies we've wrapped around the LRU and don't have many clean
> inodes left to reclaim, so it needs to wait a while for the AIL
> pushing to clean some of the remaining reclaimable inodes.
>=20
> Keep in mind we don't have to care about inode lock order or
> blocking with inode locks held here because a) we are using
> trylocks, and b) once marked with XFS_IRECLAIM they can't be found
> via the LRU and inode cache lookups will abort and retry. Hence
> nobody will try to lock them in any other context that might also be
> holding other inode locks.
>=20
> Also convert xfs_reclaim_all_inodes() to use a LRU walk to free all
> the reclaimable inodes in the filesystem.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Looks fundamentally sane. Some logic quibbles..

>  fs/xfs/xfs_icache.c | 404 +++++++++++++-------------------------------
>  fs/xfs/xfs_icache.h |  18 +-
>  fs/xfs/xfs_inode.h  |  18 ++
>  fs/xfs/xfs_super.c  |  46 ++++-
>  4 files changed, 190 insertions(+), 296 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 350f42e7730b..05dd292bfdb6 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -968,160 +968,110 @@ xfs_inode_ag_iterator_tag(
>  =09return last_error;
>  }
> =20
> -/*
> - * Grab the inode for reclaim.
> - *
> - * Return false if we aren't going to reclaim it, true if it is a reclai=
m
> - * candidate.
> - *
> - * If the inode is clean or unreclaimable, return 0 to tell the caller i=
t does
> - * not require flushing. Otherwise return the log item lsn of the inode =
so the
> - * caller can determine it's inode flush target.  If we get the clean/di=
rty
> - * state wrong then it will be sorted in xfs_reclaim_inode() once we hav=
e locks
> - * held.
> - */
> -STATIC bool
> -xfs_reclaim_inode_grab(
> -=09struct xfs_inode=09*ip,
> -=09int=09=09=09flags,
> -=09xfs_lsn_t=09=09*lsn)
> +enum lru_status
> +xfs_inode_reclaim_isolate(
> +=09struct list_head=09*item,
> +=09struct list_lru_one=09*lru,
> +=09spinlock_t=09=09*lru_lock,

Did we ever establish whether we should cycle the lru_lock during long
running scans?

> +=09void=09=09=09*arg)
>  {
> -=09ASSERT(rcu_read_lock_held());
> -=09*lsn =3D 0;
> +        struct xfs_ireclaim_args *ra =3D arg;
> +        struct inode=09=09*inode =3D container_of(item, struct inode,
> +=09=09=09=09=09=09      i_lru);
> +        struct xfs_inode=09*ip =3D XFS_I(inode);

Whitespace damage on the above lines (space indentation vs tabs).

> +=09enum lru_status=09=09ret;
> +=09xfs_lsn_t=09=09lsn =3D 0;
> +
> +=09/* Careful: inversion of iflags_lock and everything else here */
> +=09if (!spin_trylock(&ip->i_flags_lock))
> +=09=09return LRU_SKIP;
> +
> +=09/* if we are in shutdown, we'll reclaim it even if dirty */
> +=09ret =3D LRU_ROTATE;
> +=09if (!xfs_inode_clean(ip) && !__xfs_iflags_test(ip, XFS_ISTALE) &&
> +=09    !XFS_FORCED_SHUTDOWN(ip->i_mount)) {
> +=09=09lsn =3D ip->i_itemp->ili_item.li_lsn;
> +=09=09ra->dirty_skipped++;
> +=09=09goto out_unlock_flags;
> +=09}
> =20
> -=09/* quick check for stale RCU freed inode */
> -=09if (!ip->i_ino)
> -=09=09return false;
> +=09ret =3D LRU_SKIP;
> +=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
> +=09=09goto out_unlock_flags;
> =20
> -=09/*
> -=09 * Do unlocked checks to see if the inode already is being flushed or=
 in
> -=09 * reclaim to avoid lock traffic. If the inode is not clean, return t=
he
> -=09 * position in the AIL for the caller to push to.
> -=09 */
> -=09if (!xfs_inode_clean(ip)) {
> -=09=09*lsn =3D ip->i_itemp->ili_item.li_lsn;
> -=09=09return false;
> +=09if (!__xfs_iflock_nowait(ip)) {
> +=09=09lsn =3D ip->i_itemp->ili_item.li_lsn;

This looks like a potential crash vector if we ever got here with a
clean inode.

> +=09=09ra->dirty_skipped++;
> +=09=09goto out_unlock_inode;
>  =09}
> =20
> -=09if (__xfs_iflags_test(ip, XFS_IFLOCK | XFS_IRECLAIM))
> -=09=09return false;
> +=09if (XFS_FORCED_SHUTDOWN(ip->i_mount))
> +=09=09goto reclaim;
> =20
>  =09/*
> -=09 * The radix tree lock here protects a thread in xfs_iget from racing
> -=09 * with us starting reclaim on the inode.  Once we have the
> -=09 * XFS_IRECLAIM flag set it will not touch us.
> -=09 *
> -=09 * Due to RCU lookup, we may find inodes that have been freed and onl=
y
> -=09 * have XFS_IRECLAIM set.  Indeed, we may see reallocated inodes that
> -=09 * aren't candidates for reclaim at all, so we must check the
> -=09 * XFS_IRECLAIMABLE is set first before proceeding to reclaim.
> +=09 * Now the inode is locked, we can actually determine if it is dirty
> +=09 * without racing with anything.
>  =09 */
> -=09spin_lock(&ip->i_flags_lock);
> -=09if (!__xfs_iflags_test(ip, XFS_IRECLAIMABLE) ||
> -=09    __xfs_iflags_test(ip, XFS_IRECLAIM)) {
> -=09=09/* not a reclaim candidate. */
> -=09=09spin_unlock(&ip->i_flags_lock);
> -=09=09return false;
> +=09ret =3D LRU_ROTATE;
> +=09if (xfs_ipincount(ip)) {
> +=09=09ra->dirty_skipped++;

Hmm.. didn't we have an LSN check here?

Altogether, I think the logic in this function would be a lot more
simple if we had something like the following:

=09...
=09/* ret =3D=3D LRU_SKIP */
        if (!xfs_inode_clean(ip)) {
=09=09ret =3D LRU_ROTATE;
                lsn =3D ip->i_itemp->ili_item.li_lsn;
                ra->dirty_skipped++;
        }
        if (lsn && XFS_LSN_CMP(lsn, ra->lowest_lsn) < 0)
                ra->lowest_lsn =3D lsn;
        return ret;

... as the non-reclaim exit path. Then the earlier logic simply dictates
how we process the inode instead of conflating lru processing with
lsn/dirty checks. Otherwise for example (based on the current logic),
it's not really clear to me whether ->dirty_skipped cares about dirty
inodes or just the fact that we skipped an inode.

> +=09=09goto out_ifunlock;
> +=09}
> +=09if (!xfs_inode_clean(ip) && !__xfs_iflags_test(ip, XFS_ISTALE)) {
> +=09=09lsn =3D ip->i_itemp->ili_item.li_lsn;
> +=09=09ra->dirty_skipped++;
> +=09=09goto out_ifunlock;
>  =09}
> +
...
> @@ -1165,167 +1108,52 @@ xfs_reclaim_inode(
...
>  void
>  xfs_reclaim_all_inodes(
>  =09struct xfs_mount=09*mp)
>  {
...
> +=09while (list_lru_count(&mp->m_inode_lru)) {

It seems unnecessary to call this twice per-iter:

=09while ((to_free =3D list_lru_count(&mp->m_inode_lru))) {
=09=09...
=09}

Hm?

Brian

> +=09=09struct xfs_ireclaim_args ra;
> +=09=09long freed, to_free;
> +
> +=09=09xfs_ireclaim_args_init(&ra);
> +
> +=09=09to_free =3D list_lru_count(&mp->m_inode_lru);
> +=09=09freed =3D list_lru_walk(&mp->m_inode_lru,
> +=09=09=09=09      xfs_inode_reclaim_isolate, &ra, to_free);
> +=09=09xfs_dispose_inodes(&ra.freeable);
> +
> +=09=09if (freed =3D=3D 0) {
> +=09=09=09xfs_log_force(mp, XFS_LOG_SYNC);
> +=09=09=09xfs_ail_push_all(mp->m_ail);
> +=09=09} else if (ra.lowest_lsn !=3D NULLCOMMITLSN) {
> +=09=09=09xfs_ail_push_sync(mp->m_ail, ra.lowest_lsn);
> +=09=09}
> +=09=09cond_resched();
> +=09}
>  }
> =20
>  STATIC int
> diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
> index afd692b06c13..86e858e4a281 100644
> --- a/fs/xfs/xfs_icache.h
> +++ b/fs/xfs/xfs_icache.h
> @@ -49,8 +49,24 @@ int xfs_iget(struct xfs_mount *mp, struct xfs_trans *t=
p, xfs_ino_t ino,
>  struct xfs_inode * xfs_inode_alloc(struct xfs_mount *mp, xfs_ino_t ino);
>  void xfs_inode_free(struct xfs_inode *ip);
> =20
> +struct xfs_ireclaim_args {
> +=09struct list_head=09freeable;
> +=09xfs_lsn_t=09=09lowest_lsn;
> +=09unsigned long=09=09dirty_skipped;
> +};
> +
> +static inline void
> +xfs_ireclaim_args_init(struct xfs_ireclaim_args *ra)
> +{
> +=09INIT_LIST_HEAD(&ra->freeable);
> +=09ra->lowest_lsn =3D NULLCOMMITLSN;
> +=09ra->dirty_skipped =3D 0;
> +}
> +
> +enum lru_status xfs_inode_reclaim_isolate(struct list_head *item,
> +=09=09struct list_lru_one *lru, spinlock_t *lru_lock, void *arg);
> +void xfs_dispose_inodes(struct list_head *freeable);
>  void xfs_reclaim_all_inodes(struct xfs_mount *mp);
> -long xfs_reclaim_inodes_nr(struct xfs_mount *mp, int nr_to_scan);
> =20
>  void xfs_inode_set_reclaim_tag(struct xfs_inode *ip);
> =20
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index bcfb35a9c5ca..00145debf820 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -270,6 +270,15 @@ static inline int xfs_isiflocked(struct xfs_inode *i=
p)
> =20
>  extern void __xfs_iflock(struct xfs_inode *ip);
> =20
> +static inline int __xfs_iflock_nowait(struct xfs_inode *ip)
> +{
> +=09lockdep_assert_held(&ip->i_flags_lock);
> +=09if (ip->i_flags & XFS_IFLOCK)
> +=09=09return false;
> +=09ip->i_flags |=3D XFS_IFLOCK;
> +=09return true;
> +}
> +
>  static inline int xfs_iflock_nowait(struct xfs_inode *ip)
>  {
>  =09return !xfs_iflags_test_and_set(ip, XFS_IFLOCK);
> @@ -281,6 +290,15 @@ static inline void xfs_iflock(struct xfs_inode *ip)
>  =09=09__xfs_iflock(ip);
>  }
> =20
> +static inline void __xfs_ifunlock(struct xfs_inode *ip)
> +{
> +=09lockdep_assert_held(&ip->i_flags_lock);
> +=09ASSERT(ip->i_flags & XFS_IFLOCK);
> +=09ip->i_flags &=3D ~XFS_IFLOCK;
> +=09smp_mb();
> +=09wake_up_bit(&ip->i_flags, __XFS_IFLOCK_BIT);
> +}
> +
>  static inline void xfs_ifunlock(struct xfs_inode *ip)
>  {
>  =09ASSERT(xfs_isiflocked(ip));
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 98ffbe42f8ae..096ae31b5436 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -17,6 +17,7 @@
>  #include "xfs_alloc.h"
>  #include "xfs_fsops.h"
>  #include "xfs_trans.h"
> +#include "xfs_trans_priv.h"
>  #include "xfs_buf_item.h"
>  #include "xfs_log.h"
>  #include "xfs_log_priv.h"
> @@ -1772,23 +1773,54 @@ xfs_fs_mount(
>  }
> =20
>  static long
> -xfs_fs_nr_cached_objects(
> +xfs_fs_free_cached_objects(
>  =09struct super_block=09*sb,
>  =09struct shrink_control=09*sc)
>  {
> -=09/* Paranoia: catch incorrect calls during mount setup or teardown */
> -=09if (WARN_ON_ONCE(!sb->s_fs_info))
> -=09=09return 0;
> +=09struct xfs_mount=09*mp =3D XFS_M(sb);
> +=09struct xfs_ireclaim_args ra;
> +=09long=09=09=09freed;
> =20
> -=09return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
> +=09xfs_ireclaim_args_init(&ra);
> +
> +=09freed =3D list_lru_shrink_walk(&mp->m_inode_lru, sc,
> +=09=09=09=09=09xfs_inode_reclaim_isolate, &ra);
> +=09xfs_dispose_inodes(&ra.freeable);
> +
> +=09/*
> +=09 * Deal with dirty inodes. We will have the LSN of
> +=09 * the oldest dirty inode in our reclaim args if we skipped any.
> +=09 *
> +=09 * For kswapd, if we skipped too many dirty inodes (i.e. more dirty t=
han
> +=09 * we freed) then we need kswapd to back off once it's scan has been
> +=09 * completed. That way it will have some clean inodes once it comes b=
ack
> +=09 * and can make progress, but make sure we have inode cleaning in
> +=09 * progress.
> +=09 *
> +=09 * Direct reclaim will be throttled by the caller as it winds the
> +=09 * priority up. All we need to do is keep pushing on dirty inodes
> +=09 * in the background so when we come back progress will be made.
> +=09 */
> +=09if (current_is_kswapd() && ra.dirty_skipped >=3D freed) {
> +=09=09if (current->reclaim_state)
> +=09=09=09current->reclaim_state->need_backoff =3D true;
> +=09}
> +=09if (ra.lowest_lsn !=3D NULLCOMMITLSN)
> +=09=09xfs_ail_push(mp->m_ail, ra.lowest_lsn);
> +
> +=09return freed;
>  }
> =20
>  static long
> -xfs_fs_free_cached_objects(
> +xfs_fs_nr_cached_objects(
>  =09struct super_block=09*sb,
>  =09struct shrink_control=09*sc)
>  {
> -=09return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
> +=09/* Paranoia: catch incorrect calls during mount setup or teardown */
> +=09if (WARN_ON_ONCE(!sb->s_fs_info))
> +=09=09return 0;
> +
> +=09return list_lru_shrink_count(&XFS_M(sb)->m_inode_lru, sc);
>  }
> =20
>  static const struct super_operations xfs_super_operations =3D {
> --=20
> 2.24.0.rc0
>=20

