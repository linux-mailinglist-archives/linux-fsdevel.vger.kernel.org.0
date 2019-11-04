Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE438EE914
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 20:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfKDT7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 14:59:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728392AbfKDT7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572897540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pnAnOiSISyBRjKpYkfJOeRgEbJYhiafx0UfFa6VVec=;
        b=EtU3IfLA4oFbe+pTDqx8rEau2UMxxxKOSqqHuG3cqzN4VRlL1FxFfajCP5M2xC51J9eltb
        0oAdtkv7Gag4WLoc/y7pdHi2LeTW9z1HG6CC95LyutFDFj+VFqjQBqyElwiNkZmMhOb/Ph
        PZdNx6Vm2JUdTot92oVsbtHnftIxAr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-XtrCkztJO8OTl5evsKXb9w-1; Mon, 04 Nov 2019 14:58:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58B7D477;
        Mon,  4 Nov 2019 19:58:55 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B68EC19C58;
        Mon,  4 Nov 2019 19:58:54 +0000 (UTC)
Date:   Mon, 4 Nov 2019 14:58:53 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/28] mm: kswapd backoff for shrinkers
Message-ID: <20191104195853.GG10665@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-17-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-17-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XtrCkztJO8OTl5evsKXb9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:06AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> When kswapd reaches the end of the page LRU and starts hitting dirty
> pages, the logic in shrink_node() allows it to back off and wait for
> IO to complete, thereby preventing kswapd from scanning excessively
> and driving the system into swap thrashing and OOM conditions.
>=20
> When we have inode cache heavy workloads on XFS, we have exactly the
> same problem with reclaim inodes. The non-blocking kswapd reclaim
> will keep putting pressure onto the inode cache which is unable to
> make progress. When the system gets to the point where there is no
> pages in the LRU to free, there is no swap left and there are no
> clean inodes that can be freed, it will OOM. This has a specific
> signature in OOM:
>=20
> [  110.841987] Mem-Info:
> [  110.842816] active_anon:241 inactive_anon:82 isolated_anon:1
>                 active_file:168 inactive_file:143 isolated_file:0
>                 unevictable:2621523 dirty:1 writeback:8 unstable:0
>                 slab_reclaimable:564445 slab_unreclaimable:420046
>                 mapped:1042 shmem:11 pagetables:6509 bounce:0
>                 free:77626 free_pcp:2 free_cma:0
>=20
> In this case, we have about 500-600 pages left in teh LRUs, but we
> have ~565000 reclaimable slab pages still available for reclaim.
> Unfortunately, they are mostly dirty inodes, and so we really need
> to be able to throttle kswapd when shrinker progress is limited due
> to reaching the dirty end of the LRU...
>=20
> So, add a flag into the reclaim_state so if the shrinker decides it
> needs kswapd to back off and wait for a while (for whatever reason)
> it can do so.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  include/linux/swap.h |  1 +
>  mm/vmscan.c          | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index da0913e14bb9..76fc28f0e483 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -133,6 +133,7 @@ struct reclaim_state {
>  =09unsigned long=09reclaimed_pages;=09/* pages freed by shrinkers */
>  =09unsigned long=09scanned_objects;=09/* quantity of work done */=20
>  =09unsigned long=09deferred_objects;=09/* work that wasn't done */
> +=09bool=09=09need_backoff;=09=09/* tell kswapd to slow down */
>  };
> =20
>  /*
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 13c11e10c9c5..0f7d35820057 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2949,8 +2949,16 @@ static bool shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
>  =09=09=09 * implies that pages are cycling through the LRU
>  =09=09=09 * faster than they are written so also forcibly stall.
>  =09=09=09 */
> -=09=09=09if (sc->nr.immediate)
> +=09=09=09if (sc->nr.immediate) {
>  =09=09=09=09congestion_wait(BLK_RW_ASYNC, HZ/10);
> +=09=09=09} else if (reclaim_state && reclaim_state->need_backoff) {
> +=09=09=09=09/*
> +=09=09=09=09 * Ditto, but it's a slab cache that is cycling
> +=09=09=09=09 * through the LRU faster than they are written
> +=09=09=09=09 */
> +=09=09=09=09congestion_wait(BLK_RW_ASYNC, HZ/10);
> +=09=09=09=09reclaim_state->need_backoff =3D false;
> +=09=09=09}

Seems reasonable from a functional standpoint, but why not plug in to
the existing stall instead of duplicate it? E.g., add a corresponding
->nr_immediate field to reclaim_state rather than a bool, then transfer
that to the scan_control earlier in the function where we already check
for reclaim_state and handle transferring fields (or alternatively just
leave the bool and use it to bump the scan_control field). That seems a
bit more consistent with the page processing code, keeps the
reclaim_state resets in one place and also wouldn't leave us with an
if/else here for the same stall. Hm?

Brian

>  =09=09}
> =20
>  =09=09/*
> --=20
> 2.24.0.rc0
>=20

