Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AEAF03BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 18:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389346AbfKERFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 12:05:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59829 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388958AbfKERFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572973518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IsOu4q2X4kFfjJDkAgnsGgmj0ZxKuSVx1mHE6HO+CpA=;
        b=fIIxn6BXpTgXlRT4QRrrmkeWtikCp2cxKF9rm2k4qMoXwVGTBoBOhz8nhFgEa2R9PfVvOG
        ffMH4/EHsUNVHnZgWfGmoUdtUUeaHK/sPh3U6Pb/lCA/eI9I42dhSra3e+9N0svzQl0Uhf
        s34ksOcvRLHe6amSpLBAI01QGDtfDl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-OAqz_rIDNxGv8KLlhjQsQQ-1; Tue, 05 Nov 2019 12:05:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6949E107ACC3;
        Tue,  5 Nov 2019 17:05:14 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD02B608AC;
        Tue,  5 Nov 2019 17:05:13 +0000 (UTC)
Date:   Tue, 5 Nov 2019 12:05:12 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/28] xfs: reduce kswapd blocking on inode locking.
Message-ID: <20191105170512.GC28493@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-20-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-20-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OAqz_rIDNxGv8KLlhjQsQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:09AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> When doing async node reclaiming, we grab a batch of inodes that we
> are likely able to reclaim and ignore those that are already
> flushing. However, when we actually go to reclaim them, the first
> thing we do is lock the inode. If we are racing with something
> else reclaiming the inode or flushing it because it is dirty,
> we block on the inode lock. Hence we can still block kswapd here.
>=20
> Further, if we flush an inode, we also cluster all the other dirty
> inodes in that cluster into the same IO, flush locking them all.
> However, if the workload is operating on sequential inodes (e.g.
> created by a tarball extraction) most of these inodes will be
> sequntial in the cache and so in the same batch
> we've already grabbed for reclaim scanning.
>=20
> As a result, it is common for all the inodes in the batch to be
> dirty and it is common for the first inode flushed to also flush all
> the inodes in the reclaim batch. In which case, they are now all
> going to be flush locked and we do not want to block on them.
>=20
> Hence, for async reclaim (SYNC_TRYLOCK) make sure we always use
> trylock semantics and abort reclaim of an inode as quickly as we can
> without blocking kswapd. This will be necessary for the upcoming
> conversion to LRU lists for inode reclaim tracking.
>=20
> Found via tracing and finding big batches of repeated lock/unlock
> runs on inodes that we just flushed by write clustering during
> reclaim.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_icache.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index edcc3f6bb3bf..189cf423fe8f 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -1104,11 +1104,23 @@ xfs_reclaim_inode(
> =20
>  restart:
>  =09error =3D 0;
> -=09xfs_ilock(ip, XFS_ILOCK_EXCL);
> -=09if (!xfs_iflock_nowait(ip)) {
> -=09=09if (!(sync_mode & SYNC_WAIT))
> +=09/*
> +=09 * Don't try to flush the inode if another inode in this cluster has
> +=09 * already flushed it after we did the initial checks in
> +=09 * xfs_reclaim_inode_grab().
> +=09 */
> +=09if (sync_mode & SYNC_TRYLOCK) {
> +=09=09if (!xfs_ilock_nowait(ip, XFS_ILOCK_EXCL))
>  =09=09=09goto out;
> -=09=09xfs_iflock(ip);
> +=09=09if (!xfs_iflock_nowait(ip))
> +=09=09=09goto out_unlock;
> +=09} else {
> +=09=09xfs_ilock(ip, XFS_ILOCK_EXCL);
> +=09=09if (!xfs_iflock_nowait(ip)) {
> +=09=09=09if (!(sync_mode & SYNC_WAIT))
> +=09=09=09=09goto out_unlock;
> +=09=09=09xfs_iflock(ip);
> +=09=09}
>  =09}
> =20
>  =09if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
> @@ -1215,9 +1227,10 @@ xfs_reclaim_inode(
> =20
>  out_ifunlock:
>  =09xfs_ifunlock(ip);
> +out_unlock:
> +=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  out:
>  =09xfs_iflags_clear(ip, XFS_IRECLAIM);
> -=09xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  =09/*
>  =09 * We could return -EAGAIN here to make reclaim rescan the inode tree=
 in
>  =09 * a short while. However, this just burns CPU time scanning the tree
> --=20
> 2.24.0.rc0
>=20

