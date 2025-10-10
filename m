Return-Path: <linux-fsdevel+bounces-63815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E88BCEAB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 00:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4834E4ED076
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94AC27146A;
	Fri, 10 Oct 2025 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+9ilTYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEF326D4D7
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133942; cv=none; b=geDNYkM8g3H72ytgee3t4updFmrwb7MilxSticNDlm9AniTRtQE3H38TA4cQahf/ZXXAFCQwb1sq/auigYbAlqYBSY1+9qkBd539NjCHIQtqoNzaB7hBC8rHgoBfDIhR6LNPeCI2pJbJCjET0LY60brETZZy4JTUmQrZYSFFcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133942; c=relaxed/simple;
	bh=TA43UXpcWuPU1IJdmkL/yMa05LOguj7JbaFH+3HKUZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja41Vu97d5+aLeGco5ZVz6ErcQExqxuuQlXc/qf9hn2rZ6ByCzgNMTqHCB+Z/JIJhYr8N89XXDS3CygcBj3cY3GpDfQep6oOAtY86GfT1nsPa0pqbJOPUuRWhWrni3vyunxxcnEl97OGIWeZKmvRsdydCO7Md801k++6etHgkoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+9ilTYx; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42f8a966fe8so56535ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760133938; x=1760738738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmnSUvmSdY4ZiZ6tEp0Ci04V3l//Wrt4QcDb6RPwaK4=;
        b=O+9ilTYxjs0RHrdnccGbOIwFEbZ1Uoom543cQHk0OeaAW2G0FdnEvJPNwsZsVW/KLT
         +hakSvZACKyDn8b0lZLtPBd3irII7CONAGygdbAUZWUMVCU8mGZMVekAIt+Ei5zoFjUs
         Uqu+jVJ24D6wuEfsdIBhB1mEtlFeIJcevwnoJN1a1F5xFLbr4Pq7Yj8i2NPpsxNW/ezV
         zXoSEnlgnjy0pXGhAlMshw3+2e7L2Ul+pZRV8S2kWbd/3ocY9ZOOSSxwZz+Ae/nGXHHT
         0E5gnxZeHRUA0FASgmho1zZkif8BCdvo0EaJMxzPF+l8h7cDIa00PoSlFqRFjieAZQ8Q
         D0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760133938; x=1760738738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmnSUvmSdY4ZiZ6tEp0Ci04V3l//Wrt4QcDb6RPwaK4=;
        b=kEwTfEjJfobOb94awC4fm4daKl89kSdS4VVAQ+8GNuxNvBnITFVGD9cGeN6G9iJet4
         pbWnqoVtoZAEXR1fCVriRama04NvVwO3C0pLMNoqgo8/dg5BHIAFeGVw2TlAGb6uGRnL
         XGAlxV/YtCVmB71+W0/ekcgmV3rEKaAx18TY0lD3fQrQS7SDgIlDUvFS5Wv7YfzpIN/3
         uNo9ajoDeUxeaSWHtggB/fZkKMR01N2fLCdKB23fxVbUBwgGDlI5JJKzKshazFUOTWb+
         7Mtc/i30GQRsJOKvl0A7QCnhdB/ZmmODryRYz8LB6HEc8fx6ak/Ezrr37L0NEQeIOk0s
         jOkw==
X-Forwarded-Encrypted: i=1; AJvYcCV/F5Bt5lhLRssjxNtIoPHPQrmeQeSrU4PrMBI9EaQzqcWRzgfgmAGV6orikyjbID62oWb5e3r/K4cnrLkP@vger.kernel.org
X-Gm-Message-State: AOJu0YwMs24a3Z9zNF0uYVa4++YQZxXI1nDbj2Z0/CiWmoWWAiV6vD7o
	PgxCmyb1TCJcIuam4VymemNEH6U88IgjHfqXUV0aP/dCQESHyhpQ2F0AonX+QBvZ9XoPbcKk+/F
	5geEEJmMpJrOzOnjoJJYxea6wuiZYG4W7GWAsFcQu
X-Gm-Gg: ASbGncvFzTbfUUiI0ymu3z8JpkwXfYfXvdctfL8zDLSBNxcoAADwtCqk3YEE/+74pbF
	NNrr5yAAsMHvbqAmUH6dQI9Fu+OGVot9SUmptcAT8MWeEFnf89ZCl2R+F4oegzYnZ97WCZTCgws
	ht9BCgLnRKiBoks3Vrn3u66fVIAlTHKRjeTswdAMSs4V8unvT4YMQo96+xui/AZlJaDLP3MmrwI
	bHxuZQAnT9wtAD/AfqWXKvv4s2Pwy8fEVIyfq5X0A==
X-Google-Smtp-Source: AGHT+IHCgMkdadEhJ/jLB5zDZaBKV4+r/ra7hoXzHWxkTC/o79Mi8mibHtRi6YFL7dAUvHxtQsbnMdQktOK3DWxK4l0=
X-Received: by 2002:a05:622a:215:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4e6eab925c3mr22771281cf.8.1760133937208; Fri, 10 Oct 2025
 15:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-8-surenb@google.com> <20251010211101.59275-1-sj@kernel.org>
In-Reply-To: <20251010211101.59275-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 10 Oct 2025 15:05:26 -0700
X-Gm-Features: AS18NWApOnI13PqYYNoCkBzZIV6oPMv1-Ts98EufkX_D7igi4FK4fCru8Io3ADs
Message-ID: <CAJuCfpG_aA7Fw+4=1Twh-EhQ1BshyH_aTj_99R400s2UY+yfTw@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: introduce GCMA
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, willy@infradead.org, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, hannes@cmpxchg.org, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 2:11=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hello Suren,
>
> On Thu,  9 Oct 2025 18:19:50 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > From: Minchan Kim <minchan@google.com>
> >
> > This patch introduces GCMA (Guaranteed Contiguous Memory Allocator)
> > cleacache backend which reserves some amount of memory at the boot
> > and then donates it to store clean file-backed pages in the cleancache.
> > GCMA aims to guarantee contiguous memory allocation success as well as
> > low and deterministic allocation latency.
> >
> > Notes:
> > Originally, the idea was posted by SeongJae Park and Minchan Kim [1].
> > Later Minchan reworked it to be used in Android as a reference for
> > Android vendors to use [2].
> >
> > [1] https://lwn.net/Articles/619865/
> > [2] https://android-review.googlesource.com/q/topic:%22gcma_6.12%22
> >
> > Signed-off-by: Minchan Kim <minchan@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  MAINTAINERS          |   2 +
> >  include/linux/gcma.h |  36 +++++++
> >  mm/Kconfig           |  15 +++
> >  mm/Makefile          |   1 +
> >  mm/gcma.c            | 231 +++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 285 insertions(+)
> >  create mode 100644 include/linux/gcma.h
> >  create mode 100644 mm/gcma.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 441e68c94177..95b5ad26ec11 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16361,6 +16361,7 @@ F:    Documentation/admin-guide/mm/
> >  F:   Documentation/mm/
> >  F:   include/linux/cma.h
> >  F:   include/linux/dmapool.h
> > +F:   include/linux/gcma.h
> >  F:   include/linux/ioremap.h
> >  F:   include/linux/memory-tiers.h
> >  F:   include/linux/page_idle.h
> > @@ -16372,6 +16373,7 @@ F:    mm/dmapool.c
> >  F:   mm/dmapool_test.c
> >  F:   mm/early_ioremap.c
> >  F:   mm/fadvise.c
> > +F:   mm/gcma.c
> >  F:   mm/ioremap.c
> >  F:   mm/mapping_dirty_helpers.c
> >  F:   mm/memory-tiers.c
> > diff --git a/include/linux/gcma.h b/include/linux/gcma.h
> > new file mode 100644
> > index 000000000000..20b2c85de87b
> > --- /dev/null
> > +++ b/include/linux/gcma.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __GCMA_H__
> > +#define __GCMA_H__
> > +
> > +#include <linux/types.h>
> > +
> > +#ifdef CONFIG_GCMA
> > +
> > +int gcma_register_area(const char *name,
> > +                    unsigned long start_pfn, unsigned long count);
> > +
> > +/*
> > + * NOTE: allocated pages are still marked reserved and when freeing th=
em
> > + * the caller should ensure they are isolated and not referenced by an=
yone
> > + * other than the caller.
> > + */
> > +int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp=
_t gfp);
> > +int gcma_free_range(unsigned long start_pfn, unsigned long count);
> > +
> > +#else /* CONFIG_GCMA */
> > +
> > +static inline int gcma_register_area(const char *name,
> > +                                  unsigned long start_pfn,
> > +                                  unsigned long count)
> > +             { return -EOPNOTSUPP; }
> > +static inline int gcma_alloc_range(unsigned long start_pfn,
> > +                                unsigned long count, gfp_t gfp)
> > +             { return -EOPNOTSUPP; }
> > +
> > +static inline int gcma_free_range(unsigned long start_pfn,
> > +                                unsigned long count)
> > +             { return -EOPNOTSUPP; }
> > +
> > +#endif /* CONFIG_GCMA */
> > +
> > +#endif /* __GCMA_H__ */
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 9f4da8a848f4..41ce5ef8db55 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1013,6 +1013,21 @@ config CMA_AREAS
> >
> >         If unsure, leave the default value "8" in UMA and "20" in NUMA.
> >
> > +config GCMA
> > +       bool "GCMA (Guaranteed Contiguous Memory Allocator)"
> > +       depends on CLEANCACHE
> > +     help
> > +       This enables the Guaranteed Contiguous Memory Allocator to allo=
w
> > +       low latency guaranteed contiguous memory allocations. Memory
> > +       reserved by GCMA is donated to cleancache to be used as pagecac=
he
> > +       extension. Once GCMA allocation is requested, necessary pages a=
re
> > +       taken back from the cleancache and used to satisfy the request.
> > +       Cleancache guarantees low latency successful allocation as long
> > +       as the total size of GCMA allocations does not exceed the size =
of
> > +       the memory donated to the cleancache.
> > +
> > +       If unsure, say "N".
> > +
> >  #
> >  # Select this config option from the architecture Kconfig, if availabl=
e, to set
> >  # the max page order for physically contiguous allocations.
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 845841a140e3..05aee66a8b07 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -149,3 +149,4 @@ obj-$(CONFIG_TMPFS_QUOTA) +=3D shmem_quota.o
> >  obj-$(CONFIG_PT_RECLAIM) +=3D pt_reclaim.o
> >  obj-$(CONFIG_CLEANCACHE) +=3D cleancache.o
> >  obj-$(CONFIG_CLEANCACHE_SYSFS)       +=3D cleancache_sysfs.o
> > +obj-$(CONFIG_GCMA)   +=3D gcma.o
> > diff --git a/mm/gcma.c b/mm/gcma.c
> > new file mode 100644
> > index 000000000000..3ee0e1340db3
> > --- /dev/null
> > +++ b/mm/gcma.c
> > @@ -0,0 +1,231 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * GCMA (Guaranteed Contiguous Memory Allocator)
> > + *
> > + */
> > +
> > +#define pr_fmt(fmt) "gcma: " fmt
> > +
> > +#include <linux/cleancache.h>
> > +#include <linux/gcma.h>
> > +#include <linux/hashtable.h>
> > +#include <linux/highmem.h>
> > +#include <linux/idr.h>
> > +#include <linux/slab.h>
> > +#include <linux/xarray.h>
> > +#include "internal.h"
> > +
> > +#define MAX_GCMA_AREAS               64
> > +#define GCMA_AREA_NAME_MAX_LEN       32
> > +
> > +struct gcma_area {
> > +     int pool_id;
> > +     unsigned long start_pfn;
> > +     unsigned long end_pfn;
> > +     char name[GCMA_AREA_NAME_MAX_LEN];
> > +};
> > +
> > +static struct gcma_area areas[MAX_GCMA_AREAS];
> > +static atomic_t nr_gcma_area =3D ATOMIC_INIT(0);
> > +static DEFINE_SPINLOCK(gcma_area_lock);
> > +
> > +static int free_folio_range(struct gcma_area *area,
> > +                          unsigned long start_pfn, unsigned long end_p=
fn)
> > +{
> > +     unsigned long scanned =3D 0;
> > +     struct folio *folio;
> > +     unsigned long pfn;
> > +
> > +     for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
> > +             int err;
> > +
> > +             if (!(++scanned % XA_CHECK_SCHED))
> > +                     cond_resched();
> > +
> > +             folio =3D pfn_folio(pfn);
> > +             err =3D cleancache_backend_put_folio(area->pool_id, folio=
);
>
> Why don't you use pfn_folio() directly, like alloc_folio_range() does?

Yes, that would be better. Will change.

>
> > +             if (WARN(err, "PFN %lu: folio is still in use\n", pfn))
> > +                     return -EINVAL;
>
> Why don't you return err, like alloc_folio_range() does?

Ack. In my earlier version cleancache_backend_put_folio() was
returning bool, so I had to convert it to int here. But now we can
return err directly. Will change.

>
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int alloc_folio_range(struct gcma_area *area,
> > +                           unsigned long start_pfn, unsigned long end_=
pfn,
> > +                           gfp_t gfp)
> > +{
> > +     unsigned long scanned =3D 0;
> > +     unsigned long pfn;
> > +
> > +     for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
> > +             int err;
> > +
> > +             if (!(++scanned % XA_CHECK_SCHED))
> > +                     cond_resched();
> > +
> > +             err =3D cleancache_backend_get_folio(area->pool_id, pfn_f=
olio(pfn));
> > +             if (err) {
> > +                     free_folio_range(area, start_pfn, pfn);
> > +                     return err;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct gcma_area *find_area(unsigned long start_pfn, unsigned l=
ong end_pfn)
> > +{
> > +     int nr_area =3D atomic_read_acquire(&nr_gcma_area);
> > +     int i;
> > +
> > +     for (i =3D 0; i < nr_area; i++) {
> > +             struct gcma_area *area =3D &areas[i];
> > +
> > +             if (area->end_pfn <=3D start_pfn)
> > +                     continue;
> > +
> > +             if (area->start_pfn > end_pfn)
> > +                     continue;
> > +
> > +             /* The entire range should belong to a single area */
> > +             if (start_pfn < area->start_pfn || end_pfn > area->end_pf=
n)
> > +                     break;
> > +
> > +             /* Found the area containing the entire range */
> > +             return area;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +int gcma_register_area(const char *name,
> > +                    unsigned long start_pfn, unsigned long count)
> > +{
> > +     LIST_HEAD(folios);
> > +     int i, pool_id;
> > +     int nr_area;
> > +     int ret =3D 0;
> > +
> > +     pool_id =3D cleancache_backend_register_pool(name);
> > +     if (pool_id < 0)
> > +             return pool_id;
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             struct folio *folio;
> > +
> > +             folio =3D pfn_folio(start_pfn + i);
> > +             folio_clear_reserved(folio);
> > +             folio_set_count(folio, 0);
> > +             list_add(&folio->lru, &folios);
> > +     }
> > +
> > +     cleancache_backend_put_folios(pool_id, &folios);
> > +
> > +     spin_lock(&gcma_area_lock);
> > +
> > +     nr_area =3D atomic_read(&nr_gcma_area);
> > +     if (nr_area < MAX_GCMA_AREAS) {
> > +             struct gcma_area *area =3D &areas[nr_area];
> > +
> > +             area->pool_id =3D pool_id;
> > +             area->start_pfn =3D start_pfn;
> > +             area->end_pfn =3D start_pfn + count;
> > +             strscpy(area->name, name);
> > +             /* Ensure above stores complete before we increase the co=
unt */
> > +             atomic_set_release(&nr_gcma_area, nr_area + 1);
> > +     } else {
> > +             ret =3D -ENOMEM;
> > +     }
> > +
> > +     spin_unlock(&gcma_area_lock);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(gcma_register_area);
> > +
> > +int gcma_alloc_range(unsigned long start_pfn, unsigned long count, gfp=
_t gfp)
> > +{
> > +     unsigned long end_pfn =3D start_pfn + count;
> > +     struct gcma_area *area;
> > +     struct folio *folio;
> > +     int err, order =3D 0;
> > +
> > +     gfp =3D current_gfp_context(gfp);
> > +     if (gfp & __GFP_COMP) {
> > +             if (!is_power_of_2(count))
> > +                     return -EINVAL;
> > +
> > +             order =3D ilog2(count);
> > +             if (order >=3D MAX_PAGE_ORDER)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     area =3D find_area(start_pfn, end_pfn);
> > +     if (!area)
> > +             return -EINVAL;
> > +
> > +     err =3D alloc_folio_range(area, start_pfn, end_pfn, gfp);
> > +     if (err)
> > +             return err;
> > +
> > +     /*
> > +      * GCMA returns pages with refcount 1 and expects them to have
> > +      * the same refcount 1 when they are freed.
> > +      */
> > +     if (order) {
> > +             folio =3D pfn_folio(start_pfn);
> > +             set_page_count(&folio->page, 1);
> > +             prep_compound_page(&folio->page, order);
> > +     } else {
> > +             for (unsigned long pfn =3D start_pfn; pfn < end_pfn; pfn+=
+) {
> > +                     folio =3D pfn_folio(pfn);
> > +                     set_page_count(&folio->page, 1);
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(gcma_alloc_range);
>
> I'm wondering if the rule of exporting symbols only for in-tree modules t=
hat
> use the symbols should be applied here or not, and why.

In Android we use gcma_alloc_range() in vendor-defined dmabuf-heap
modules. That's why I need this API to be exported.

>
> > +
> > +int gcma_free_range(unsigned long start_pfn, unsigned long count)
> > +{
> > +     unsigned long end_pfn =3D start_pfn + count;
> > +     struct gcma_area *area;
> > +     struct folio *folio;
> > +
> > +     area =3D find_area(start_pfn, end_pfn);
> > +     if (!area)
> > +             return -EINVAL;
> > +
> > +     folio =3D pfn_folio(start_pfn);
> > +     if (folio_test_large(folio)) {
> > +             int expected =3D folio_nr_pages(folio);
>
> folio_nr_pages() return 'unsigned long'.  Would it be better to match the=
 type?

Yes! Ack.

>
> > +
> > +             if (WARN(count !=3D expected, "PFN %lu: count %lu !=3D ex=
pected %d\n",
> > +                       start_pfn, count, expected))
> > +                     return -EINVAL;
> > +
> > +             if (WARN(!folio_ref_dec_and_test(folio),
> > +                      "PFN %lu: invalid folio refcount when freeing\n"=
, start_pfn))
> > +                     return -EINVAL;
> > +
> > +             free_pages_prepare(&folio->page, folio_order(folio));
> > +     } else {
> > +             for (unsigned long pfn =3D start_pfn; pfn < end_pfn; pfn+=
+) {
> > +                     folio =3D pfn_folio(pfn);
> > +                     if (folio_nr_pages(folio) =3D=3D 1)
> > +                             count--;
> > +
> > +                     if (WARN(!folio_ref_dec_and_test(folio),
> > +                              "PFN %lu: invalid folio refcount when fr=
eeing\n", pfn))
> > +                             return -EINVAL;
>
> Don't we need to increase the previously decreased folio refcounts?

Yes, you are right. If any folio refcount is incorrect here (folio is
still in use), we should restore the refcount for all folios that we
have already processed. I think I'll also need to do 2 passes here:
first drop and check the refcount on all folios, then call
free_pages_prepare() if all folios are unused.

And also need to remove all these WARN()'s which I had for
debugging... Will remove in the next version.

>
> > +
> > +                     free_pages_prepare(&folio->page, 0);
> > +             }
> > +             WARN(count !=3D 0, "%lu pages are still in use!\n", count=
);
>
> Is WARN() but not returning error here ok?

No. I'll rework this loop to perform 2 passes as I mentioned before
and if the first pass detects any mistake, it will restore previous
refcounts and return an error.

>
> Also, why don't you warn earlier above if 'folio_nr_pages(folio) !=3D 1' =
?

I'll remove all these warnings and change the code to fail and restore
folios if any folio in the range does not meet our expectations.

>
> > +     }
> > +
> > +     return free_folio_range(area, start_pfn, end_pfn);
> > +}
> > +EXPORT_SYMBOL_GPL(gcma_free_range);
>
> Like the gcma_alloc_range() case, I'm curious if this symbol exporting is
> somewhat intended and the intention is explained.

Same reasons. Vendor-provided dmabuf heap modules might use it.

Thanks,
Suren.

>
> > --
> > 2.51.0.740.g6adb054d12-goog
>
>
> Thanks,
> SJ

