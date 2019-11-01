Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39C64EC273
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 13:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfKAMFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 08:05:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55966 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728162AbfKAMFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572609920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGDftV3Cms7wFSvWoR03p6Dc2RRKcomCEzYNrgPl5Qc=;
        b=V+rma+KvUdWeZiBjw8BBlKjad99mqWyKTmzTVIjagSgeveLXiZ50+OljO72feZHbPiGwLo
        YyF8X+I3u/sVPOrVH6T6hbqBb/NDrTVzld5S5NlHfxB0P9Z5Hd4Vu/nesxImrPYbwQr/zC
        4ySuJOjb27Yw7L3e9Gegn1U+B1X0orE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-UOBXAZjoOIywgB2hI5UtlA-1; Fri, 01 Nov 2019 08:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 151E62EDA;
        Fri,  1 Nov 2019 12:05:16 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77B7F1001B09;
        Fri,  1 Nov 2019 12:05:15 +0000 (UTC)
Date:   Fri, 1 Nov 2019 08:05:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/28] xfs: Improve metadata buffer reclaim accountability
Message-ID: <20191101120513.GD59146@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-5-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-5-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UOBXAZjoOIywgB2hI5UtlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:45:54AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> The buffer cache shrinker frees more than just the xfs_buf slab
> objects - it also frees the pages attached to the buffers. Make sure
> the memory reclaim code accounts for this memory being freed
> correctly, similar to how the inode shrinker accounts for pages
> freed from the page cache due to mapping invalidation.
>=20
> We also need to make sure that the mm subsystem knows these are
> reclaimable objects. We provide the memory reclaim subsystem with a
> a shrinker to reclaim xfs_bufs, so we should really mark the slab
> that way.
>=20
> We also have a lot of xfs_bufs in a busy system, spread them around
> like we do inodes.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

I still don't see why we wouldn't set the spread flag on the bli cache
as well, but afaict it doesn't matter in most cases unless the spread
knob is enabled. Unless I'm misunderstanding how that works, I think the
commit log could be improved to describe that since to me it implies the
flag by itself has an effect, but otherwise the change seems fine:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/xfs/xfs_buf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 1e63dd3d1257..d34e5d2edacd 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -324,6 +324,9 @@ xfs_buf_free(
> =20
>  =09=09=09__free_page(page);
>  =09=09}
> +=09=09if (current->reclaim_state)
> +=09=09=09current->reclaim_state->reclaimed_slab +=3D
> +=09=09=09=09=09=09=09bp->b_page_count;
>  =09} else if (bp->b_flags & _XBF_KMEM)
>  =09=09kmem_free(bp->b_addr);
>  =09_xfs_buf_free_pages(bp);
> @@ -2061,7 +2064,8 @@ int __init
>  xfs_buf_init(void)
>  {
>  =09xfs_buf_zone =3D kmem_zone_init_flags(sizeof(xfs_buf_t), "xfs_buf",
> -=09=09=09=09=09=09KM_ZONE_HWALIGN, NULL);
> +=09=09=09KM_ZONE_HWALIGN | KM_ZONE_SPREAD | KM_ZONE_RECLAIM,
> +=09=09=09NULL);
>  =09if (!xfs_buf_zone)
>  =09=09goto out;
> =20
> --=20
> 2.24.0.rc0
>=20

