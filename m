Return-Path: <linux-fsdevel+bounces-12863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52333867F9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 19:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB671F24EB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F712F368;
	Mon, 26 Feb 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyatrNgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BFB12EBE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971167; cv=none; b=TQ3I9qWLiwtzu/Ujuu987TQXF2ZcjzBGh8+HCiy3n9akDYdksbzKuuvOmtTNbnAvIdFqgpuybvcRMYQ7p9cVs1AljelnRaYzmEfOUmC6ZuxbOqwrUdLiX/qFrHFfxF9fdoW3WoRsRCX4wwJrWKIwDqm98AJH6McTB87gAV9K1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971167; c=relaxed/simple;
	bh=JjiamXOaFf38heEaX0UljyoMbvk9N31R6tKYa5+2bFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3jAYXkxskKaMXghn+i8mGXb3p4y33Ts5fuuxOGIIHm1HHol499HHg1CuSKso9WOcP0CkMo8nYt4s86L9n2Q0504Q/HSE6oB1rd4dyl2rLQVSEOjN2OyKqs0yl+dAJLcaP271A42CN7FSAbnWyaK+3sX7BXH2B/+GGiFw/g0L1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyatrNgF; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c19dd9ade5so468731b6e.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 10:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708971164; x=1709575964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5YNT7nyxvHVOm/5xBJakeWXPPB8u9koe5KvGa6UoMQ=;
        b=iyatrNgF4NXfD0FosMeZXn04rD/O+NOlfZM9PouC7PWn0CmAWi9pZWWxPSny8h+RgW
         6tuBypCwc+AsrwBdgdXqutHwvwzDXMeZnchyST70EK6k0mpWBwQXEop5AqklhYQwhZrd
         MBgugRvww4AMEjMQOifCa9cFXUHiDWliIz1qtIcdjlHWSnKgYr1zYIhma+YVPz1qHfDD
         pfxRUGO17qllv1benHvJvZBlX8v1BFMmgpOa3EgktbPdSgdF/s6YVSaOqdm+yqcAt79k
         508RW5ZOt43mEK9repSg2DLGbj1lu6sWTgMc7PRFZCkewLXGrgsE0TJI+exa7baEm4pG
         zL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971164; x=1709575964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5YNT7nyxvHVOm/5xBJakeWXPPB8u9koe5KvGa6UoMQ=;
        b=vGda+1S56/RsN3Klvz3UCw8wtXFP8hIrOwHV28vBG7O1Kf1O+4lSwgha45PXlOwP0u
         fI7okzna6VS9Jt00atcZbWGDrI2/s/HV/wawBpH40ZbDfP/Rl8osq1U1rVvg1zNgOsez
         KxxcTfQkivdhU4wlQ1sqLY7uiEeIMkhiXQUQYxi773KGo2nmLml1bCO6PSPe1yIGHN6x
         9S/vAacD5UXkzU4tZD902wxJqD8sUR+B/AAM3bjTRNPqSTTDuY6gF+gzLiO/Rc87xULn
         DTBNeOljURYbE3C8zU4uhBO55mcJCrQtANp6qd9Is7JBiraKcP4nZqx+9GtrM00KjwUA
         XS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5Ga12YVm/h1lCaeP63cDDADLny4jCNONYObhKMlyiPVS1KduHs7RMJxQyZt1Dl2YRWJFPP5p2JegeAAX7X86M8DSUvHmHLP8VByf6xw==
X-Gm-Message-State: AOJu0YwYa6wOSzmsBJ5sU68gKIqYCWUgYNXdTl6k7qCap1xRv3AhXGRq
	vE5HFnwXPoVpHBLeg04Gy+KE09EVi/wqCdyEBFVa08A0GFovrlBjYjxaodrJ0STF0u/lD1cz4nl
	hq5DCTjj+4IisDgA4g7DawojRy7d0hAcdZA/w
X-Google-Smtp-Source: AGHT+IHQOJWhsjjesHv5Q26dN44a+Uf/FgxPiAaXNGl1z3AyUjyO/bCagZeT9XVoiHOm+PDR1d7X+DX6QuPg88Vd35M=
X-Received: by 2002:a05:6870:9454:b0:21f:f34b:dcc5 with SMTP id
 e20-20020a056870945400b0021ff34bdcc5mr4518298oal.10.1708971163308; Mon, 26
 Feb 2024 10:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220214558.3377482-1-souravpanda@google.com> <20240220214558.3377482-2-souravpanda@google.com>
In-Reply-To: <20240220214558.3377482-2-souravpanda@google.com>
From: Wei Xu <weixugc@google.com>
Date: Mon, 26 Feb 2024 10:12:32 -0800
Message-ID: <CAAPL-u-0RekH-ptg9U2pzPJxCAR+jMTxKTZU49LR_isjNkSPWg@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 1:46=E2=80=AFPM Sourav Panda <souravpanda@google.co=
m> wrote:
>
> Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> to /proc/meminfo. This information can be used by users to see how
> much memory is being used by per-page metadata, which can vary
> depending on build configuration, machine architecture, and system
> use.

/proc/vmstat also has the system-wide nr_memmap and nr_memmap_boot.
Given that nr_memmap in /proc/vmstat provides the same info (in
different units) as Memmap in /proc/meminfo, it would be better to
remove Memmap from /proc/meminfo to avoid duplication and confusion.

> Per-page metadata is the amount of memory that Linux needs in order to
> manage memory at the page granularity. The majority of such memory is
> used by "struct page" and "page_ext" data structures. In contrast to
> most other memory consumption statistics, per-page metadata might not
> be included in MemTotal. For example, MemTotal does not include memblock
> allocations but includes buddy allocations. In this patch, exported
> field nr_memmap in /sys/devices/system/node/nodeN/vmstat would
> exclusively track buddy allocations while nr_memmap_boot would
> exclusively track memblock allocations. Furthermore, Memmap in
> /proc/meminfo would exclusively track buddy allocations allowing it to
> be compared against MemTotal.
>
> This memory depends on build configurations, machine architectures, and
> the way system is used:
>
> Build configuration may include extra fields into "struct page",
> and enable / disable "page_ext"
> Machine architecture defines base page sizes. For example 4K x86,
> 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> overhead is smaller on machines with larger page sizes.
> System use can change per-page overhead by using vmemmap
> optimizations with hugetlb pages, and emulated pmem devdax pages.
> Also, boot parameters can determine whether page_ext is needed
> to be allocated. This memory can be part of MemTotal or be outside
> MemTotal depending on whether the memory was hot-plugged, booted with,
> or hugetlb memory was returned back to the system.
>
> Utility for userspace:
>
> Application Optimization: Depending on the kernel version and command
> line options, the kernel would relinquish a different number of pages
> (that contain struct pages) when a hugetlb page is reserved (e.g., 0, 6
> or 7 for a 2MB hugepage). The userspace application would want to know
> the exact savings achieved through page metadata deallocation without
> dealing with the intricacies of the kernel.
>
> Observability: Struct page overhead can only be calculated on-paper at
> boot time (e.g., 1.5% machine capacity). Beyond boot once hugepages are
> reserved or memory is hotplugged, the computation becomes complex.
> Per-page metrics will help explain part of the system memory overhead,
> which shall help guide memory optimizations and memory cgroup sizing.
>
> Debugging: Tracking the changes or absolute value in struct pages can
> help detect anomalies as they can be correlated with other metrics in
> the machine (e.g., memtotal, number of huge pages, etc).
>
> page_ext overheads: Some kernel features such as page_owner
> page_table_check that use page_ext can be optionally enabled via kernel
> parameters. Having the total per-page metadata information helps users
> precisely measure impact.
>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Sourav Panda <souravpanda@google.com>
> ---
>  Documentation/filesystems/proc.rst |  3 +++
>  fs/proc/meminfo.c                  |  4 ++++
>  include/linux/mmzone.h             |  4 ++++
>  include/linux/vmstat.h             |  4 ++++
>  mm/hugetlb_vmemmap.c               | 17 ++++++++++++----
>  mm/mm_init.c                       |  3 +++
>  mm/page_alloc.c                    |  1 +
>  mm/page_ext.c                      | 32 +++++++++++++++++++++---------
>  mm/sparse-vmemmap.c                |  8 ++++++++
>  mm/sparse.c                        |  7 ++++++-
>  mm/vmstat.c                        | 26 +++++++++++++++++++++++-
>  11 files changed, 94 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 104c6d047d9b..c9b4de65f162 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -993,6 +993,7 @@ Example output. You may not have all of these fields.
>      AnonPages:       4654780 kB
>      Mapped:           266244 kB
>      Shmem:              9976 kB
> +    Memmap:           513419 kB
>      KReclaimable:     517708 kB
>      Slab:             660044 kB
>      SReclaimable:     517708 kB
> @@ -1095,6 +1096,8 @@ Mapped
>                files which have been mmapped, such as libraries
>  Shmem
>                Total memory used by shared memory (shmem) and tmpfs
> +Memmap
> +              Memory used for per-page metadata
>  KReclaimable
>                Kernel allocations that the kernel will attempt to reclaim
>                under memory pressure. Includes SReclaimable (below), and =
other
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 45af9a989d40..3d3db55cfeab 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -39,6 +39,7 @@ static int meminfo_proc_show(struct seq_file *m, void *=
v)
>         long available;
>         unsigned long pages[NR_LRU_LISTS];
>         unsigned long sreclaimable, sunreclaim;
> +       unsigned long nr_memmap;
>         int lru;
>
>         si_meminfo(&i);
> @@ -57,6 +58,8 @@ static int meminfo_proc_show(struct seq_file *m, void *=
v)
>         sreclaimable =3D global_node_page_state_pages(NR_SLAB_RECLAIMABLE=
_B);
>         sunreclaim =3D global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE=
_B);
>
> +       nr_memmap =3D global_node_page_state_pages(NR_MEMMAP);
> +
>         show_val_kb(m, "MemTotal:       ", i.totalram);
>         show_val_kb(m, "MemFree:        ", i.freeram);
>         show_val_kb(m, "MemAvailable:   ", available);
> @@ -104,6 +107,7 @@ static int meminfo_proc_show(struct seq_file *m, void=
 *v)
>         show_val_kb(m, "Mapped:         ",
>                     global_node_page_state(NR_FILE_MAPPED));
>         show_val_kb(m, "Shmem:          ", i.sharedram);
> +       show_val_kb(m, "Memmap:         ", nr_memmap);
>         show_val_kb(m, "KReclaimable:   ", sreclaimable +
>                     global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
>         show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a497f189d988..59b244092325 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -214,6 +214,10 @@ enum node_stat_item {
>         PGDEMOTE_KSWAPD,
>         PGDEMOTE_DIRECT,
>         PGDEMOTE_KHUGEPAGED,
> +       NR_MEMMAP,              /* Page metadata size (struct page and pa=
ge_ext)
> +                                * in pages
> +                                */
> +       NR_MEMMAP_BOOT,         /* NR_MEMMAP for bootmem */
>         NR_VM_NODE_STAT_ITEMS
>  };
>
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 343906a98d6e..c3785fdd3668 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -632,4 +632,8 @@ static inline void lruvec_stat_sub_folio(struct folio=
 *folio,
>  {
>         lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
>  }
> +
> +void __meminit mod_node_early_perpage_metadata(int nid, long delta);
> +void __meminit store_early_perpage_metadata(void);
> +
>  #endif /* _LINUX_VMSTAT_H */
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index da177e49d956..2da8689aeb93 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -184,10 +184,13 @@ static int vmemmap_remap_range(unsigned long start,=
 unsigned long end,
>   */
>  static inline void free_vmemmap_page(struct page *page)
>  {
> -       if (PageReserved(page))
> +       if (PageReserved(page)) {
>                 free_bootmem_page(page);
> -       else
> +               mod_node_page_state(page_pgdat(page), NR_MEMMAP_BOOT, -1)=
;
> +       } else {
>                 __free_page(page);
> +               mod_node_page_state(page_pgdat(page), NR_MEMMAP, -1);
> +       }
>  }
>
>  /* Free a list of the vmemmap pages */
> @@ -338,6 +341,7 @@ static int vmemmap_remap_free(unsigned long start, un=
signed long end,
>                 copy_page(page_to_virt(walk.reuse_page),
>                           (void *)walk.reuse_addr);
>                 list_add(&walk.reuse_page->lru, vmemmap_pages);
> +               mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, 1);
>         }
>
>         /*
> @@ -384,14 +388,19 @@ static int alloc_vmemmap_page_list(unsigned long st=
art, unsigned long end,
>         unsigned long nr_pages =3D (end - start) >> PAGE_SHIFT;
>         int nid =3D page_to_nid((struct page *)start);
>         struct page *page, *next;
> +       int i;
>
> -       while (nr_pages--) {
> +       for (i =3D 0; i < nr_pages; i++) {
>                 page =3D alloc_pages_node(nid, gfp_mask, 0);
> -               if (!page)
> +               if (!page) {
> +                       mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i)=
;
>                         goto out;
> +               }
>                 list_add(&page->lru, list);
>         }
>
> +       mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
> +
>         return 0;
>  out:
>         list_for_each_entry_safe(page, next, list, lru)
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2c19f5515e36..b61372431b7d 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -27,6 +27,7 @@
>  #include <linux/swap.h>
>  #include <linux/cma.h>
>  #include <linux/crash_dump.h>
> +#include <linux/vmstat.h>
>  #include "internal.h"
>  #include "slab.h"
>  #include "shuffle.h"
> @@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct pglist=
_data *pgdat)
>                 panic("Failed to allocate %ld bytes for node %d memory ma=
p\n",
>                       size, pgdat->node_id);
>         pgdat->node_mem_map =3D map + offset;
> +       mod_node_early_perpage_metadata(pgdat->node_id,
> +                                       DIV_ROUND_UP(size, PAGE_SIZE));
>         pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
>                  __func__, pgdat->node_id, (unsigned long)pgdat,
>                  (unsigned long)pgdat->node_mem_map);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 150d4f23b010..236cfdf5a8fa 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5635,6 +5635,7 @@ void __init setup_per_cpu_pageset(void)
>         for_each_online_pgdat(pgdat)
>                 pgdat->per_cpu_nodestats =3D
>                         alloc_percpu(struct per_cpu_nodestat);
> +       store_early_perpage_metadata();
>  }
>
>  __meminit void zone_pcp_init(struct zone *zone)
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 4548fcc66d74..c1e324a1427e 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
>                 return -ENOMEM;
>         NODE_DATA(nid)->node_page_ext =3D base;
>         total_usage +=3D table_size;
> +       mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
> +                           DIV_ROUND_UP(table_size, PAGE_SIZE));
>         return 0;
>  }
>
> @@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t size, =
int nid)
>         void *addr =3D NULL;
>
>         addr =3D alloc_pages_exact_nid(nid, size, flags);
> -       if (addr) {
> +       if (addr)
>                 kmemleak_alloc(addr, size, 1, flags);
> -               return addr;
> -       }
> +       else
> +               addr =3D vzalloc_node(size, nid);
>
> -       addr =3D vzalloc_node(size, nid);
> +       if (addr) {
> +               mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
> +                                   DIV_ROUND_UP(size, PAGE_SIZE));
> +       }
>
>         return addr;
>  }
> @@ -303,18 +308,27 @@ static int __meminit init_section_page_ext(unsigned=
 long pfn, int nid)
>
>  static void free_page_ext(void *addr)
>  {
> +       size_t table_size;
> +       struct page *page;
> +       struct pglist_data *pgdat;
> +
> +       table_size =3D page_ext_size * PAGES_PER_SECTION;
> +
>         if (is_vmalloc_addr(addr)) {
> +               page =3D vmalloc_to_page(addr);
> +               pgdat =3D page_pgdat(page);
>                 vfree(addr);
>         } else {
> -               struct page *page =3D virt_to_page(addr);
> -               size_t table_size;
> -
> -               table_size =3D page_ext_size * PAGES_PER_SECTION;
> -
> +               page =3D virt_to_page(addr);
> +               pgdat =3D page_pgdat(page);
>                 BUG_ON(PageReserved(page));
>                 kmemleak_free(addr);
>                 free_pages_exact(addr, table_size);
>         }
> +
> +       mod_node_page_state(pgdat, NR_MEMMAP,
> +                           -1L * (DIV_ROUND_UP(table_size, PAGE_SIZE)));
> +
>  }
>
>  static void __free_page_ext(unsigned long pfn)
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index a2cbe44c48e1..1dda6c53370b 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -469,5 +469,13 @@ struct page * __meminit __populate_section_memmap(un=
signed long pfn,
>         if (r < 0)
>                 return NULL;
>
> +       if (system_state =3D=3D SYSTEM_BOOTING) {
> +               mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(end - s=
tart,
> +                                                                 PAGE_SI=
ZE));
> +       } else {
> +               mod_node_page_state(NODE_DATA(nid), NR_MEMMAP,
> +                                   DIV_ROUND_UP(end - start, PAGE_SIZE))=
;
> +       }
> +
>         return pfn_to_page(pfn);
>  }
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 338cf946dee8..eb2aeb4e226b 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -14,7 +14,7 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/bootmem_info.h>
> -
> +#include <linux/vmstat.h>
>  #include "internal.h"
>  #include <asm/dma.h>
>
> @@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned long s=
ize, int nid)
>          */
>         sparsemap_buf =3D memmap_alloc(size, section_map_size(), addr, ni=
d, true);
>         sparsemap_buf_end =3D sparsemap_buf + size;
> +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> +       mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, PAGE_SIZE=
));
> +#endif
>  }
>
>  static void __init sparse_buffer_fini(void)
> @@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned long p=
fn, unsigned long nr_pages,
>         unsigned long start =3D (unsigned long) pfn_to_page(pfn);
>         unsigned long end =3D start + nr_pages * sizeof(struct page);
>
> +       mod_node_page_state(page_pgdat(pfn_to_page(pfn)), NR_MEMMAP,
> +                           -1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)))=
;
>         vmemmap_free(start, end, altmap);
>  }
>  static void free_map_bootmem(struct page *memmap)
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index db79935e4a54..79466450040e 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1252,7 +1252,8 @@ const char * const vmstat_text[] =3D {
>         "pgdemote_kswapd",
>         "pgdemote_direct",
>         "pgdemote_khugepaged",
> -
> +       "nr_memmap",
> +       "nr_memmap_boot",
>         /* enum writeback_stat_item counters */
>         "nr_dirty_threshold",
>         "nr_dirty_background_threshold",
> @@ -2279,4 +2280,27 @@ static int __init extfrag_debug_init(void)
>  }
>
>  module_init(extfrag_debug_init);
> +
>  #endif
> +
> +/*
> + * Page metadata size (struct page and page_ext) in pages
> + */
> +static unsigned long early_perpage_metadata[MAX_NUMNODES] __meminitdata;
> +
> +void __meminit mod_node_early_perpage_metadata(int nid, long delta)
> +{
> +       early_perpage_metadata[nid] +=3D delta;
> +}
> +
> +void __meminit store_early_perpage_metadata(void)
> +{
> +       int nid;
> +       struct pglist_data *pgdat;
> +
> +       for_each_online_pgdat(pgdat) {
> +               nid =3D pgdat->node_id;
> +               mod_node_page_state(NODE_DATA(nid), NR_MEMMAP_BOOT,
> +                                   early_perpage_metadata[nid]);
> +       }
> +}
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

