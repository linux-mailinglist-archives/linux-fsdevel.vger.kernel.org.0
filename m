Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19207EE90A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfKDT6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 14:58:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26929 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728602AbfKDT6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572897491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX0Im6ez8fONq6vZ1zCe7AGoAcurOkQ0kqYgRpSpeq0=;
        b=W+hTgELXNrMynbj7Bdlt9tjEQolLMDYRQyxMFMlXaGF96dyPwW3FUIiv40yRdUhhLgknuI
        XnRpfzW9WV1r8qAU0Zz3t09TZZMEdT5O79KyWYqJ02wjl7CKUxijKyijmz0AommcInOxlO
        JlVbMcJpy5yeOKze6uKmT5vlyttQsX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-3OxW0jTKP_-hNyjL7dQDdA-1; Mon, 04 Nov 2019 14:58:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 774391800D53;
        Mon,  4 Nov 2019 19:58:07 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9BE15D9E5;
        Mon,  4 Nov 2019 19:58:06 +0000 (UTC)
Date:   Mon, 4 Nov 2019 14:58:05 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/28] mm: reclaim_state records pages reclaimed, not
 slabs
Message-ID: <20191104195805.GE10665@bfoster>
References: <20191031234618.15403-1-david@fromorbit.com>
 <20191031234618.15403-15-david@fromorbit.com>
MIME-Version: 1.0
In-Reply-To: <20191031234618.15403-15-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3OxW0jTKP_-hNyjL7dQDdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:46:04AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>=20
> Add a wrapper to account for page freeing in shrinker reclaim so
> that the high level scanning accounts for all the memory freed
> during a shrinker scan.
>=20
> No logic changes, just replacing open coded checks with a simple
> wrapper.
>=20
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---

Looks straightforward:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/inode.c           |  3 +--
>  fs/xfs/xfs_buf.c     |  4 +---
>  include/linux/swap.h | 20 ++++++++++++++++++--
>  mm/slab.c            |  3 +--
>  mm/slob.c            |  4 +---
>  mm/slub.c            |  3 +--
>  mm/vmscan.c          |  4 ++--
>  7 files changed, 25 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/inode.c b/fs/inode.c
> index fef457a42882..a77caf216659 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -764,8 +764,7 @@ static enum lru_status inode_lru_isolate(struct list_=
head *item,
>  =09=09=09=09__count_vm_events(KSWAPD_INODESTEAL, reap);
>  =09=09=09else
>  =09=09=09=09__count_vm_events(PGINODESTEAL, reap);
> -=09=09=09if (current->reclaim_state)
> -=09=09=09=09current->reclaim_state->reclaimed_slab +=3D reap;
> +=09=09=09current_reclaim_account_pages(reap);
>  =09=09}
>  =09=09iput(inode);
>  =09=09spin_lock(lru_lock);
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index d34e5d2edacd..55b082bc53b3 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -324,9 +324,7 @@ xfs_buf_free(
> =20
>  =09=09=09__free_page(page);
>  =09=09}
> -=09=09if (current->reclaim_state)
> -=09=09=09current->reclaim_state->reclaimed_slab +=3D
> -=09=09=09=09=09=09=09bp->b_page_count;
> +=09=09current_reclaim_account_pages(bp->b_page_count);
>  =09} else if (bp->b_flags & _XBF_KMEM)
>  =09=09kmem_free(bp->b_addr);
>  =09_xfs_buf_free_pages(bp);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 063c0c1e112b..72b855fe20b0 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -126,12 +126,28 @@ union swap_header {
> =20
>  /*
>   * current->reclaim_state points to one of these when a task is running
> - * memory reclaim
> + * memory reclaim. It is typically used by shrinkers to return reclaim
> + * information back to the main vmscan loop.
>   */
>  struct reclaim_state {
> -=09unsigned long reclaimed_slab;
> +=09unsigned long=09reclaimed_pages;=09/* pages freed by shrinkers */
>  };
> =20
> +/*
> + * When code frees a page that may be run from a memory reclaim context,=
 it
> + * needs to account for the pages it frees so memory reclaim can track t=
hem.
> + * Slab memory that is freed is accounted via this mechanism, so this is=
 not
> + * necessary for slab or heap memory being freed. However, if the object=
 being
> + * freed frees pages directly, then those pages should be accounted as w=
ell when
> + * in memory reclaim. This helper function takes care accounting for the=
 pages
> + * being reclaimed when it is required.
> + */
> +static inline void current_reclaim_account_pages(int nr_pages)
> +{
> +=09if (current->reclaim_state)
> +=09=09current->reclaim_state->reclaimed_pages +=3D nr_pages;
> +}
> +
>  #ifdef __KERNEL__
> =20
>  struct address_space;
> diff --git a/mm/slab.c b/mm/slab.c
> index 66e5d8032bae..419be005f41a 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1395,8 +1395,7 @@ static void kmem_freepages(struct kmem_cache *cache=
p, struct page *page)
>  =09page_mapcount_reset(page);
>  =09page->mapping =3D NULL;
> =20
> -=09if (current->reclaim_state)
> -=09=09current->reclaim_state->reclaimed_slab +=3D 1 << order;
> +=09current_reclaim_account_pages(1 << order);
>  =09uncharge_slab_page(page, order, cachep);
>  =09__free_pages(page, order);
>  }
> diff --git a/mm/slob.c b/mm/slob.c
> index fa53e9f73893..c54a7eeee86d 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -211,9 +211,7 @@ static void slob_free_pages(void *b, int order)
>  {
>  =09struct page *sp =3D virt_to_page(b);
> =20
> -=09if (current->reclaim_state)
> -=09=09current->reclaim_state->reclaimed_slab +=3D 1 << order;
> -
> +=09current_reclaim_account_pages(1 << order);
>  =09mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE,
>  =09=09=09    -(1 << order));
>  =09__free_pages(sp, order);
> diff --git a/mm/slub.c b/mm/slub.c
> index b25c807a111f..478554082079 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1746,8 +1746,7 @@ static void __free_slab(struct kmem_cache *s, struc=
t page *page)
>  =09__ClearPageSlab(page);
> =20
>  =09page->mapping =3D NULL;
> -=09if (current->reclaim_state)
> -=09=09current->reclaim_state->reclaimed_slab +=3D pages;
> +=09current_reclaim_account_pages(pages);
>  =09uncharge_slab_page(page, order, s);
>  =09__free_pages(page, order);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7a8256322150..967e3d3c7748 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2870,8 +2870,8 @@ static bool shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>  =09=09} while ((memcg =3D mem_cgroup_iter(root, memcg, NULL)));
> =20
>  =09=09if (reclaim_state) {
> -=09=09=09sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> -=09=09=09reclaim_state->reclaimed_slab =3D 0;
> +=09=09=09sc->nr_reclaimed +=3D reclaim_state->reclaimed_pages;
> +=09=09=09reclaim_state->reclaimed_pages =3D 0;
>  =09=09}
> =20
>  =09=09/* Record the subtree's reclaim efficiency */
> --=20
> 2.24.0.rc0
>=20

