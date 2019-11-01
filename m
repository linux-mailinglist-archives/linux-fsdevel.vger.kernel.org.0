Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3220EC274
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 13:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfKAMF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 08:05:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30230 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727806AbfKAMF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572609926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1O8jc4gRNIn2XbZkYZH1M/cxWaYMIfFuZZqbFPKTLI=;
        b=eEqsderZS1CwIritfvdpXPhmxtHV0MN9JkfSwad3mh7ZrGhN+iWv39P1XSMWQt/p+xIb3N
        TPFfyLItUhwBg1FeJypxAP8VhRjcMTUjHF6BjbcRZEZjF2H+17XV/06IBRrTfr8fL8zeuX
        DJk4SsEdTDk+K2u6S+EpL2CUT7bhLjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-y9T4hczZO8G-CQ-pvReLoA-1; Fri, 01 Nov 2019 08:05:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEE67800EB6;
        Fri,  1 Nov 2019 12:05:23 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C2315D9CD;
        Fri,  1 Nov 2019 12:05:23 +0000 (UTC)
Date:   Fri, 1 Nov 2019 08:05:21 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/28] xfs: factor inode lookup from xfs_ifree_cluster
Message-ID: <20191101120521.GE59146@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-9-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-9-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: y9T4hczZO8G-CQ-pvReLoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:45:58AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> There's lots of indent in this code which makes it a bit hard to
> follow. We are also going to completely rework the inode lookup code
> as part of the inode reclaim rework, so factor out the inode lookup
> code from the inode cluster freeing code.
>=20
> Based on prototype code from Christoph Hellwig.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_inode.c | 152 +++++++++++++++++++++++++--------------------
>  1 file changed, 84 insertions(+), 68 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index e9e4f444f8ce..33edb18098ca 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2516,6 +2516,88 @@ xfs_iunlink_remove(
>  =09return error;
>  }
> =20
> +/*
> + * Look up the inode number specified and mark it stale if it is found. =
If it is
> + * dirty, return the inode so it can be attached to the cluster buffer s=
o it can
> + * be processed appropriately when the cluster free transaction complete=
s.
> + */
> +static struct xfs_inode *
> +xfs_ifree_get_one_inode(
> +=09struct xfs_perag=09*pag,
> +=09struct xfs_inode=09*free_ip,
> +=09int=09=09=09inum)
> +{
> +=09struct xfs_mount=09*mp =3D pag->pag_mount;
> +=09struct xfs_inode=09*ip;
> +
> +retry:
> +=09rcu_read_lock();
> +=09ip =3D radix_tree_lookup(&pag->pag_ici_root, XFS_INO_TO_AGINO(mp, inu=
m));
> +
> +=09/* Inode not in memory, nothing to do */
> +=09if (!ip)
> +=09=09goto out_rcu_unlock;
> +
> +=09/*
> +=09 * because this is an RCU protected lookup, we could find a recently
> +=09 * freed or even reallocated inode during the lookup. We need to chec=
k
> +=09 * under the i_flags_lock for a valid inode here. Skip it if it is no=
t
> +=09 * valid, the wrong inode or stale.
> +=09 */
> +=09spin_lock(&ip->i_flags_lock);
> +=09if (ip->i_ino !=3D inum || __xfs_iflags_test(ip, XFS_ISTALE)) {
> +=09=09spin_unlock(&ip->i_flags_lock);
> +=09=09goto out_rcu_unlock;
> +=09}
> +=09spin_unlock(&ip->i_flags_lock);
> +
> +=09/*
> +=09 * Don't try to lock/unlock the current inode, but we _cannot_ skip t=
he
> +=09 * other inodes that we did not find in the list attached to the buff=
er
> +=09 * and are not already marked stale. If we can't lock it, back off an=
d
> +=09 * retry.
> +=09 */
> +=09if (ip !=3D free_ip) {
> +=09=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> +=09=09=09rcu_read_unlock();
> +=09=09=09delay(1);
> +=09=09=09goto retry;
> +=09=09}
> +
> +=09=09/*
> +=09=09 * Check the inode number again in case we're racing with
> +=09=09 * freeing in xfs_reclaim_inode().  See the comments in that
> +=09=09 * function for more information as to why the initial check is
> +=09=09 * not sufficient.
> +=09=09 */
> +=09=09if (ip->i_ino !=3D inum) {
> +=09=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +=09=09=09goto out_rcu_unlock;
> +=09=09}
> +=09}
> +=09rcu_read_unlock();
> +
> +=09xfs_iflock(ip);
> +=09xfs_iflags_set(ip, XFS_ISTALE);
> +
> +=09/*
> +=09 * We don't need to attach clean inodes or those only with unlogged
> +=09 * changes (which we throw away, anyway).
> +=09 */
> +=09if (!ip->i_itemp || xfs_inode_clean(ip)) {
> +=09=09ASSERT(ip !=3D free_ip);
> +=09=09xfs_ifunlock(ip);
> +=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +=09=09goto out_no_inode;
> +=09}
> +=09return ip;
> +
> +out_rcu_unlock:
> +=09rcu_read_unlock();
> +out_no_inode:
> +=09return NULL;
> +}
> +
>  /*
>   * A big issue when freeing the inode cluster is that we _cannot_ skip a=
ny
>   * inodes that are in memory - they all must be marked stale and attache=
d to
> @@ -2616,77 +2698,11 @@ xfs_ifree_cluster(
>  =09=09 * even trying to lock them.
>  =09=09 */
>  =09=09for (i =3D 0; i < igeo->inodes_per_cluster; i++) {
> -retry:
> -=09=09=09rcu_read_lock();
> -=09=09=09ip =3D radix_tree_lookup(&pag->pag_ici_root,
> -=09=09=09=09=09XFS_INO_TO_AGINO(mp, (inum + i)));
> -
> -=09=09=09/* Inode not in memory, nothing to do */
> -=09=09=09if (!ip) {
> -=09=09=09=09rcu_read_unlock();
> +=09=09=09ip =3D xfs_ifree_get_one_inode(pag, free_ip, inum + i);
> +=09=09=09if (!ip)
>  =09=09=09=09continue;
> -=09=09=09}
> -
> -=09=09=09/*
> -=09=09=09 * because this is an RCU protected lookup, we could
> -=09=09=09 * find a recently freed or even reallocated inode
> -=09=09=09 * during the lookup. We need to check under the
> -=09=09=09 * i_flags_lock for a valid inode here. Skip it if it
> -=09=09=09 * is not valid, the wrong inode or stale.
> -=09=09=09 */
> -=09=09=09spin_lock(&ip->i_flags_lock);
> -=09=09=09if (ip->i_ino !=3D inum + i ||
> -=09=09=09    __xfs_iflags_test(ip, XFS_ISTALE)) {
> -=09=09=09=09spin_unlock(&ip->i_flags_lock);
> -=09=09=09=09rcu_read_unlock();
> -=09=09=09=09continue;
> -=09=09=09}
> -=09=09=09spin_unlock(&ip->i_flags_lock);
> -
> -=09=09=09/*
> -=09=09=09 * Don't try to lock/unlock the current inode, but we
> -=09=09=09 * _cannot_ skip the other inodes that we did not find
> -=09=09=09 * in the list attached to the buffer and are not
> -=09=09=09 * already marked stale. If we can't lock it, back off
> -=09=09=09 * and retry.
> -=09=09=09 */
> -=09=09=09if (ip !=3D free_ip) {
> -=09=09=09=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL)) {
> -=09=09=09=09=09rcu_read_unlock();
> -=09=09=09=09=09delay(1);
> -=09=09=09=09=09goto retry;
> -=09=09=09=09}
> -
> -=09=09=09=09/*
> -=09=09=09=09 * Check the inode number again in case we're
> -=09=09=09=09 * racing with freeing in xfs_reclaim_inode().
> -=09=09=09=09 * See the comments in that function for more
> -=09=09=09=09 * information as to why the initial check is
> -=09=09=09=09 * not sufficient.
> -=09=09=09=09 */
> -=09=09=09=09if (ip->i_ino !=3D inum + i) {
> -=09=09=09=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -=09=09=09=09=09rcu_read_unlock();
> -=09=09=09=09=09continue;
> -=09=09=09=09}
> -=09=09=09}
> -=09=09=09rcu_read_unlock();
> =20
> -=09=09=09xfs_iflock(ip);
> -=09=09=09xfs_iflags_set(ip, XFS_ISTALE);
> -
> -=09=09=09/*
> -=09=09=09 * we don't need to attach clean inodes or those only
> -=09=09=09 * with unlogged changes (which we throw away, anyway).
> -=09=09=09 */
>  =09=09=09iip =3D ip->i_itemp;
> -=09=09=09if (!iip || xfs_inode_clean(ip)) {
> -=09=09=09=09ASSERT(ip !=3D free_ip);
> -=09=09=09=09xfs_ifunlock(ip);
> -=09=09=09=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -=09=09=09=09continue;
> -=09=09=09}
> -
>  =09=09=09iip->ili_last_fields =3D iip->ili_fields;
>  =09=09=09iip->ili_fields =3D 0;
>  =09=09=09iip->ili_fsync_fields =3D 0;
> --=20
> 2.24.0.rc0
>=20

