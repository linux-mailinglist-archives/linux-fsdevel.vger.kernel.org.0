Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92827F2184
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 23:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKFWSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 17:18:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727109AbfKFWSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573078733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+yNCOx/XpllH8totIi2TAdOLihbfSV40uo15Q/PIQE=;
        b=FUZol9kZU+ckDrAoXOeXTYxRglGojVPkiTXZhGxDxBcIaB99nUjz3QEYoDvTmOCrRvy+pR
        RXr69Lvl4ijOkPEcULc16vXjp2o/ZbF9a3oVvGOMKv9b7dcdoiMjuHM+KQF4URoXM3mb7M
        VRMJhvvYnBDut1d1X67ujJTqXyIYuzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-WId1sO5bPGe9lynkroM0Ww-1; Wed, 06 Nov 2019 17:18:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B53E5107ACC3;
        Wed,  6 Nov 2019 22:18:48 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 119335C651;
        Wed,  6 Nov 2019 22:18:47 +0000 (UTC)
Date:   Wed, 6 Nov 2019 17:18:46 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/28] xfs: rework unreferenced inode lookups
Message-ID: <20191106221846.GE37080@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-29-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-29-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: WId1sO5bPGe9lynkroM0Ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:18AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Looking up an unreferenced inode in the inode cache is a bit hairy.
> We do this for inode invalidation and writeback clustering purposes,
> which is all invisible to the VFS. Hence we can't take reference
> counts to the inode and so must be very careful how we do it.
>=20
> There are several different places that all do the lookups and
> checks slightly differently. Fundamentally, though, they are all
> racy and inode reclaim has to block waiting for the inode lock if it
> loses the race. This is not very optimal given all the work we;ve
> already done to make reclaim non-blocking.
>=20
> We can make the reclaim process nonblocking with a couple of simple
> changes. If we define the unreferenced lookup process in a way that
> will either always grab an inode in a way that reclaim will notice
> and skip, or will notice a reclaim has grabbed the inode so it can
> skip the inode, then there is no need for reclaim to need to cycle
> the inode ILOCK at all.
>=20
> Selecting an inode for reclaim is already non-blocking, so if the
> ILOCK is held the inode will be skipped. If we ensure that reclaim
> holds the ILOCK until the inode is freed, then we can do the same
> thing in the unreferenced lookup to avoid inodes in reclaim. We can
> do this simply by holding the ILOCK until the RCU grace period
> expires and the inode freeing callback is run. As all unreferenced
> lookups have to hold the rcu_read_lock(), we are guaranteed that
> a reclaimed inode will be noticed as the trylock will fail.
>=20
...
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/mrlock.h     |  27 +++++++++
>  fs/xfs/xfs_icache.c |  88 +++++++++++++++++++++--------
>  fs/xfs/xfs_inode.c  | 131 +++++++++++++++++++++-----------------------
>  3 files changed, 153 insertions(+), 93 deletions(-)
>=20
> diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
> index 79155eec341b..1752a2592bcc 100644
> --- a/fs/xfs/mrlock.h
> +++ b/fs/xfs/mrlock.h
...
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 11bf4768d491..45ee3b5cd873 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -106,6 +106,7 @@ xfs_inode_free_callback(
>  =09=09ip->i_itemp =3D NULL;
>  =09}
> =20
> +=09mrunlock_excl_non_owner(&ip->i_lock);
>  =09kmem_zone_free(xfs_inode_zone, ip);
>  }
> =20
> @@ -132,6 +133,7 @@ xfs_inode_free(
>  =09 * free state. The ip->i_flags_lock provides the barrier against look=
up
>  =09 * races.
>  =09 */
> +=09mrupdate_non_owner(&ip->i_lock);

Can we tie these into the proper locking interface using flags? For
example, something like xfs_ilock(ip, XFS_ILOCK_EXCL|XFS_ILOCK_NONOWNER)
or xfs_ilock(ip, XFS_ILOCK_EXCL_NONOWNER) perhaps?

>  =09spin_lock(&ip->i_flags_lock);
>  =09ip->i_flags =3D XFS_IRECLAIM;
>  =09ip->i_ino =3D 0;
> @@ -295,11 +297,24 @@ xfs_iget_cache_hit(
>  =09=09}
> =20
>  =09=09/*
> -=09=09 * We need to set XFS_IRECLAIM to prevent xfs_reclaim_inode
> -=09=09 * from stomping over us while we recycle the inode. Remove it
> -=09=09 * from the LRU straight away so we can re-init the VFS inode.
> +=09=09 * Before we reinitialise the inode, we need to make sure
> +=09=09 * reclaim does not pull it out from underneath us. We already
> +=09=09 * hold the i_flags_lock, and because the XFS_IRECLAIM is not
> +=09=09 * set we know the inode is still on the LRU. However, the LRU
> +=09=09 * code may have just selected this inode to reclaim, so we need
> +=09=09 * to ensure we hold the i_flags_lock long enough for the
> +=09=09 * trylock in xfs_inode_reclaim_isolate() to fail. We do this by
> +=09=09 * removing the inode from the LRU, which will spin on the LRU
> +=09=09 * list locks until reclaim stops walking, at which point we
> +=09=09 * know there is no possible race between reclaim isolation and
> +=09=09 * this lookup.
> +=09=09 *

Somewhat related to my question about the lru_lock on the earlier patch.

> +=09=09 * We also set the XFS_IRECLAIM flag here while trying to do the
> +=09=09 * re-initialisation to prevent multiple racing lookups on this
> +=09=09 * inode from all landing here at the same time.
>  =09=09 */
>  =09=09ip->i_flags |=3D XFS_IRECLAIM;
> +=09=09list_lru_del(&mp->m_inode_lru, &inode->i_lru);
>  =09=09spin_unlock(&ip->i_flags_lock);
>  =09=09rcu_read_unlock();
> =20
...
> @@ -1022,19 +1076,7 @@ xfs_dispose_inode(
>  =09spin_unlock(&pag->pag_ici_lock);
>  =09xfs_perag_put(pag);
> =20
> -=09/*
> -=09 * Here we do an (almost) spurious inode lock in order to coordinate
> -=09 * with inode cache radix tree lookups.  This is because the lookup
> -=09 * can reference the inodes in the cache without taking references.
> -=09 *
> -=09 * We make that OK here by ensuring that we wait until the inode is
> -=09 * unlocked after the lookup before we go ahead and free it.
> -=09 *
> -=09 * XXX: need to check this is still true. Not sure it is.
> -=09 */
> -=09xfs_ilock(ip, XFS_ILOCK_EXCL);
>  =09xfs_qm_dqdetach(ip);
> -=09xfs_iunlock(ip, XFS_ILOCK_EXCL);

Ok, so I'm staring at this a bit more and think I'm missing something.
If we put aside the change to hold ilock until the inode is freed, we
basically have the following (simplified) flow as the inode goes from
isolation to disposal:

=09ilock=09(isolate)
=09iflock
=09set XFS_IRECLAIM
=09ifunlock (disposal)
=09iunlock
=09radix delete
=09ilock cycle (drain)
=09rcu free

What we're trying to eliminate is the ilock cycle to drain any
concurrent unreferenced lookups from accessing the inode once it is
freed. The free itself is still RCU protected.

Looking over at the ifree path, we now have something like this:

=09rcu_read_lock()
=09radix lookup
=09check XFS_IRECLAIM
=09ilock
=09if XFS_ISTALE, skip
=09set XFS_ISTALE
=09rcu_read_unlock()
=09iflock
=09/* return locked down inode */

Given that we set XFS_IRECLAIM under ilock, would we still need either
the ilock cycle or to hold ilock through the RCU free if the ifree side
(re)checked XFS_IRECLAIM after it has the ilock (but before it drops the
rcu read lock)? ISTM we should either have a non-reclaim inode with
ilock protection or a reclaim inode with RCU protection (so we can skip
it before it frees), but I could easily be missing something here..

> =20
>  =09__xfs_inode_free(ip);
>  }
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 33edb18098ca..5c0be82195fc 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2538,60 +2538,63 @@ xfs_ifree_get_one_inode(
>  =09if (!ip)
>  =09=09goto out_rcu_unlock;
> =20
> +

Extra whitespace here.

> +=09spin_lock(&ip->i_flags_lock);
> +=09if (!ip->i_ino || ip->i_ino !=3D inum ||
> +=09    __xfs_iflags_test(ip, XFS_IRECLAIM))
> +=09=09goto out_iflags_unlock;
> +
>  =09/*
> -=09 * because this is an RCU protected lookup, we could find a recently
> -=09 * freed or even reallocated inode during the lookup. We need to chec=
k
> -=09 * under the i_flags_lock for a valid inode here. Skip it if it is no=
t
> -=09 * valid, the wrong inode or stale.
> +=09 * We've got the right inode and it isn't in reclaim but it might be
> +=09 * locked by someone else.  In that case, we retry the inode rather t=
han
> +=09 * skipping it completely as we have to process it with the cluster
> +=09 * being freed.
>  =09 */
> -=09spin_lock(&ip->i_flags_lock);
> -=09if (ip->i_ino !=3D inum || __xfs_iflags_test(ip, XFS_ISTALE)) {
> +=09if (ip !=3D free_ip && !xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
>  =09=09spin_unlock(&ip->i_flags_lock);
> -=09=09goto out_rcu_unlock;
> +=09=09rcu_read_unlock();
> +=09=09delay(1);
> +=09=09goto retry;
>  =09}
> -=09spin_unlock(&ip->i_flags_lock);
> =20
>  =09/*
> -=09 * Don't try to lock/unlock the current inode, but we _cannot_ skip t=
he
> -=09 * other inodes that we did not find in the list attached to the buff=
er
> -=09 * and are not already marked stale. If we can't lock it, back off an=
d
> -=09 * retry.
> +=09 * Inode is now pinned against reclaim until we unlock it. If the ino=
de
> +=09 * is already marked stale, then it has already been flush locked and
> +=09 * attached to the buffer so we don't need to do anything more here.
>  =09 */
> -=09if (ip !=3D free_ip) {
> -=09=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> -=09=09=09rcu_read_unlock();
> -=09=09=09delay(1);
> -=09=09=09goto retry;
> -=09=09}
> -
> -=09=09/*
> -=09=09 * Check the inode number again in case we're racing with
> -=09=09 * freeing in xfs_reclaim_inode().  See the comments in that
> -=09=09 * function for more information as to why the initial check is
> -=09=09 * not sufficient.
> -=09=09 */
> -=09=09if (ip->i_ino !=3D inum) {
> +=09if (__xfs_iflags_test(ip, XFS_ISTALE)) {

Is there a correctness reason for why we move the stale check to under
ilock (in both iflush/ifree)?

> +=09=09if (ip !=3D free_ip)
>  =09=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -=09=09=09goto out_rcu_unlock;
> -=09=09}
> +=09=09goto out_iflags_unlock;
>  =09}
> +=09__xfs_iflags_set(ip, XFS_ISTALE);
> +=09spin_unlock(&ip->i_flags_lock);
>  =09rcu_read_unlock();
> =20
> +=09/*
> +=09 * The flush lock will now hold off inode reclaim until the buffer
> +=09 * completion routine runs the xfs_istale_done callback and unlocks t=
he
> +=09 * flush lock. Hence the caller can safely drop the ILOCK when it is
> +=09 * done attaching the inode to the cluster buffer.
> +=09 */
>  =09xfs_iflock(ip);
> -=09xfs_iflags_set(ip, XFS_ISTALE);
> =20
>  =09/*
> -=09 * We don't need to attach clean inodes or those only with unlogged
> -=09 * changes (which we throw away, anyway).
> +=09 * We don't need to attach clean inodes to the buffer - they are mark=
ed
> +=09 * stale in memory now and will need to be re-initialised by inode
> +=09 * allocation before they can be reused.
>  =09 */
>  =09if (!ip->i_itemp || xfs_inode_clean(ip)) {
>  =09=09ASSERT(ip !=3D free_ip);
>  =09=09xfs_ifunlock(ip);
> -=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +=09=09if (ip !=3D free_ip)
> +=09=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);

There's an assert against this case just above, though I suppose there's
nothing wrong with just keeping it and making the functional code more
cautious.

Brian

>  =09=09goto out_no_inode;
>  =09}
>  =09return ip;
> =20
> +out_iflags_unlock:
> +=09spin_unlock(&ip->i_flags_lock);
>  out_rcu_unlock:
>  =09rcu_read_unlock();
>  out_no_inode:
> @@ -3519,44 +3522,40 @@ xfs_iflush_cluster(
>  =09=09=09continue;
> =20
>  =09=09/*
> -=09=09 * because this is an RCU protected lookup, we could find a
> -=09=09 * recently freed or even reallocated inode during the lookup.
> -=09=09 * We need to check under the i_flags_lock for a valid inode
> -=09=09 * here. Skip it if it is not valid or the wrong inode.
> +=09=09 * See xfs_dispose_inode() for an explanation of the
> +=09=09 * tests here to avoid inode reclaim races.
>  =09=09 */
>  =09=09spin_lock(&cip->i_flags_lock);
>  =09=09if (!cip->i_ino ||
> -=09=09    __xfs_iflags_test(cip, XFS_ISTALE)) {
> +=09=09    __xfs_iflags_test(cip, XFS_IRECLAIM)) {
>  =09=09=09spin_unlock(&cip->i_flags_lock);
>  =09=09=09continue;
>  =09=09}
> =20
> -=09=09/*
> -=09=09 * Once we fall off the end of the cluster, no point checking
> -=09=09 * any more inodes in the list because they will also all be
> -=09=09 * outside the cluster.
> -=09=09 */
> +=09=09/* ILOCK will pin the inode against reclaim */
> +=09=09if (!xfs_ilock_nowait(cip, XFS_ILOCK_SHARED)) {
> +=09=09=09spin_unlock(&cip->i_flags_lock);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09if (__xfs_iflags_test(cip, XFS_ISTALE)) {
> +=09=09=09xfs_iunlock(cip, XFS_ILOCK_SHARED);
> +=09=09=09spin_unlock(&cip->i_flags_lock);
> +=09=09=09continue;
> +=09=09}
> +
> +=09=09/* Lookup can find inodes outside the cluster being flushed. */
>  =09=09if ((XFS_INO_TO_AGINO(mp, cip->i_ino) & mask) !=3D first_index) {
> +=09=09=09xfs_iunlock(cip, XFS_ILOCK_SHARED);
>  =09=09=09spin_unlock(&cip->i_flags_lock);
>  =09=09=09break;
>  =09=09}
>  =09=09spin_unlock(&cip->i_flags_lock);
> =20
>  =09=09/*
> -=09=09 * Do an un-protected check to see if the inode is dirty and
> -=09=09 * is a candidate for flushing.  These checks will be repeated
> -=09=09 * later after the appropriate locks are acquired.
> -=09=09 */
> -=09=09if (xfs_inode_clean(cip) && xfs_ipincount(cip) =3D=3D 0)
> -=09=09=09continue;
> -
> -=09=09/*
> -=09=09 * Try to get locks.  If any are unavailable or it is pinned,
> +=09=09 * If we can't get the flush lock now or the inode is pinned,
>  =09=09 * then this inode cannot be flushed and is skipped.
>  =09=09 */
> -
> -=09=09if (!xfs_ilock_nowait(cip, XFS_ILOCK_SHARED))
> -=09=09=09continue;
>  =09=09if (!xfs_iflock_nowait(cip)) {
>  =09=09=09xfs_iunlock(cip, XFS_ILOCK_SHARED);
>  =09=09=09continue;
> @@ -3567,22 +3566,9 @@ xfs_iflush_cluster(
>  =09=09=09continue;
>  =09=09}
> =20
> -
>  =09=09/*
> -=09=09 * Check the inode number again, just to be certain we are not
> -=09=09 * racing with freeing in xfs_reclaim_inode(). See the comments
> -=09=09 * in that function for more information as to why the initial
> -=09=09 * check is not sufficient.
> -=09=09 */
> -=09=09if (!cip->i_ino) {
> -=09=09=09xfs_ifunlock(cip);
> -=09=09=09xfs_iunlock(cip, XFS_ILOCK_SHARED);
> -=09=09=09continue;
> -=09=09}
> -
> -=09=09/*
> -=09=09 * arriving here means that this inode can be flushed.  First
> -=09=09 * re-check that it's dirty before flushing.
> +=09=09 * Arriving here means that this inode can be flushed. First
> +=09=09 * check that it's dirty before flushing.
>  =09=09 */
>  =09=09if (!xfs_inode_clean(cip)) {
>  =09=09=09int=09error;
> @@ -3596,6 +3582,7 @@ xfs_iflush_cluster(
>  =09=09=09xfs_ifunlock(cip);
>  =09=09}
>  =09=09xfs_iunlock(cip, XFS_ILOCK_SHARED);
> +=09=09/* unsafe to reference cip from here */
>  =09}
> =20
>  =09if (clcount) {
> @@ -3634,7 +3621,11 @@ xfs_iflush_cluster(
> =20
>  =09xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_INCORE);
> =20
> -=09/* abort the corrupt inode, as it was not attached to the buffer */
> +=09/*
> +=09 * Abort the corrupt inode, as it was not attached to the buffer. It =
is
> +=09 * unlocked, but still pinned against reclaim by the flush lock so it=
 is
> +=09 * safe to reference here until after the flush abort completes.
> +=09 */
>  =09xfs_iflush_abort(cip, false);
>  =09kmem_free(cilist);
>  =09xfs_perag_put(pag);
> --=20
> 2.24.0.rc0
>=20

