Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A76F03CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 18:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389383AbfKERG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 12:06:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388875AbfKERG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572973616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5gX8G0vnfueKdPpJcGj776JikjvLmPzMcNuP6rkJHg=;
        b=W4Xu64sY0AhxE4SQ/M8MpVxO7rzVUGrikC71I5CKOf9oamjVPu37MWGhby9DnFnqN5Asb5
        TQEwlV0blE/0VQpmL2Fyir5N0TNDgvDxrebmUR5tmviviWzj8TiondNvt4kPAM515McQFF
        Hx0b06gtki/UM6mnfdamb5cNrxnyCcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-HPAS1klHPlioZDfIRul_cQ-1; Tue, 05 Nov 2019 12:06:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 658418017DD;
        Tue,  5 Nov 2019 17:06:51 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C92ED5D9C9;
        Tue,  5 Nov 2019 17:06:50 +0000 (UTC)
Date:   Tue, 5 Nov 2019 12:06:49 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/28] xfs: use AIL pushing for inode reclaim IO
Message-ID: <20191105170649.GE28493@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-22-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-22-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HPAS1klHPlioZDfIRul_cQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:11AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Inode reclaim currently issues it's own inode IO when it comes
> across dirty inodes. This is used to throttle direct reclaim down to
> the rate at which we can reclaim dirty inodes. Failure to throttle
> in this manner results in the OOM killer being trivial to trigger
> even when there is lots of free memory available.
>=20
> However, having direct reclaimers issue IO causes an amount of
> IO thrashing to occur. We can have up to the number of AGs in the
> filesystem concurrently issuing IO, plus the AIL pushing thread as
> well. This means we can many competing sources of IO and they all
> end up thrashing and competing for the request slots in the block
> device.
>=20
> Similar to dirty page throttling and the BDI flusher thread, we can
> use the AIL pushing thread the sole place we issue inode writeback
> from and everything else waits for it to make progress. To do this,
> reclaim will skip over dirty inodes, but in doing so will record the
> lowest LSN of all the dirty inodes it skips. It will then push the
> AIL to this LSN and wait for it to complete that work.
>=20
> In doing so, we block direct reclaim on the IO of at least one IO,
> thereby providing some level of throttling for when we encounter
> dirty inodes. However we gain the ability to scan and reclaim clean
> inodes in a non-blocking fashion.
>=20
> Hence direct reclaim will be throttled directly by the rate at which
> dirty inodes are cleaned by AIL pushing, rather than by delays
> caused by competing IO submissions. This allows us to reduce the
> locking that limits direct reclaim concurrency to just protecting
> the reclaim cursor state, hence greatly simplifying the inode
> reclaim code as it now just skips dirty inodes.
>=20
> Note: this patch by itself isn't completely able to throttle direct
> reclaim sufficiently to prevent OOM killer madness. We can't do that
> until we change the way we index reclaimable inodes in the next
> patch and can feed back state to the mm core sanely.  However, we
> can't change the way we index reclaimable inodes until we have
> IO-less non-blocking reclaim for both direct reclaim and kswapd
> reclaim.  Catch-22...
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

A couple random nits and a question...

>  fs/xfs/xfs_icache.c | 218 ++++++++++++++++++--------------------------
>  1 file changed, 89 insertions(+), 129 deletions(-)
>=20
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index 7e175304e146..ff8ae32614a6 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
...
> @@ -1262,9 +1227,13 @@ xfs_reclaim_inodes_ag(
>  =09=09=09for (i =3D 0; i < nr_found; i++) {
>  =09=09=09=09struct xfs_inode *ip =3D batch[i];
> =20
> -=09=09=09=09if (done || xfs_reclaim_inode_grab(ip, flags))
> +=09=09=09=09if (done ||
> +=09=09=09=09    !xfs_reclaim_inode_grab(ip, flags, &lsn))
>  =09=09=09=09=09batch[i] =3D NULL;

Doesn't look like we can get here with done !=3D 0.

> =20
> +=09=09=09=09if (lsn && XFS_LSN_CMP(lsn, lowest_lsn) < 0)
> +=09=09=09=09=09lowest_lsn =3D lsn;
> +

This should probably have the same NULLCOMMITLSN treatment as the
similar check below.

>  =09=09=09=09/*
>  =09=09=09=09 * Update the index for the next lookup. Catch
>  =09=09=09=09 * overflows into the next AG range which can
> @@ -1289,41 +1258,34 @@ xfs_reclaim_inodes_ag(
...
> =20
> -=09/*
> -=09 * if we skipped any AG, and we still have scan count remaining, do
> -=09 * another pass this time using blocking reclaim semantics (i.e
> -=09 * waiting on the reclaim locks and ignoring the reclaim cursors). Th=
is
> -=09 * ensure that when we get more reclaimers than AGs we block rather
> -=09 * than spin trying to execute reclaim.
> -=09 */
> -=09if (skipped && (flags & SYNC_WAIT) && *nr_to_scan > 0) {
> -=09=09trylock =3D 0;
> -=09=09goto restart;
> -=09}
> -=09return last_error;
> +=09if ((flags & SYNC_WAIT) && lowest_lsn !=3D NULLCOMMITLSN)
> +=09=09xfs_ail_push_sync(mp->m_ail, lowest_lsn);
> +
> +=09return freed;

Hm, this should have always been returning a free count instead of an
error code right? If so, I'd normally suggest to fix this as an
independent patch, but it's probably not worth splitting up at this
point.

The aforementioned nits seem harmless and the code is going away, so:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  }
> =20
>  int
> @@ -1331,9 +1293,7 @@ xfs_reclaim_inodes(
>  =09xfs_mount_t=09*mp,
>  =09int=09=09mode)
>  {
> -=09int=09=09nr_to_scan =3D INT_MAX;
> -
> -=09return xfs_reclaim_inodes_ag(mp, mode, &nr_to_scan);
> +=09return xfs_reclaim_inodes_ag(mp, mode, INT_MAX);
>  }
> =20
>  /*
> @@ -1350,7 +1310,7 @@ xfs_reclaim_inodes_nr(
>  =09struct xfs_mount=09*mp,
>  =09int=09=09=09nr_to_scan)
>  {
> -=09int=09=09=09sync_mode =3D SYNC_TRYLOCK;
> +=09int=09=09=09sync_mode =3D 0;
> =20
>  =09/*
>  =09 * For kswapd, we kick background inode writeback. For direct
> @@ -1362,7 +1322,7 @@ xfs_reclaim_inodes_nr(
>  =09else
>  =09=09sync_mode |=3D SYNC_WAIT;
> =20
> -=09return xfs_reclaim_inodes_ag(mp, sync_mode, &nr_to_scan);
> +=09return xfs_reclaim_inodes_ag(mp, sync_mode, nr_to_scan);
>  }
> =20
>  /*
> --=20
> 2.24.0.rc0
>=20

