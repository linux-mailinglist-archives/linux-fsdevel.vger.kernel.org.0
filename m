Return-Path: <linux-fsdevel+bounces-1892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5BC7DFDF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 03:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311F1281CFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6AC1386;
	Fri,  3 Nov 2023 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cAbl1kuh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C81119
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 02:24:27 +0000 (UTC)
X-Greylist: delayed 85234 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 19:24:22 PDT
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC421A6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 19:24:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698978259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9/VPgyaLf8vtjFLzOdwo/aZIdvsY7+k8Vu6QF0xkFg=;
	b=cAbl1kuhwQ72/mejanEc0Eetvs1/vE10XjHfiaO1Eif42+2aTNM6HDJDgh+z4qqZscDylk
	yI2NWYKfft+8man5CWeC01QJcPGj9NQRRTPNNstOJuV4Z82risctzBPsLUqNhBL8S9JYSH
	eUf3rdWki11RbrxOdFBW6cymUCxQjtc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v4 1/1] mm: report per-page metadata information
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CANruzcTEOY76dmR=W9eN8d=Qk4rYH6rTsCuYSbF172sHVW2z1Q@mail.gmail.com>
Date: Fri, 3 Nov 2023 10:23:31 +0800
Cc: Jonathan Corbet <corbet@lwn.net>,
 Greg KH <gregkh@linuxfoundation.org>,
 rafael@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 chenlinxuan@uniontech.com,
 yang.yang29@zte.com.cn,
 tomas.mudrunka@gmail.com,
 bhelgaas@google.com,
 ivan@cloudflare.com,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeelb@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 adobriyan@gmail.com,
 Vlastimil Babka <vbabka@suse.cz>,
 Liam.Howlett@oracle.com,
 surenb@google.com,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>,
 weixugc@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <82F25A75-1A1C-4DAF-B754-EFDAF144C15E@linux.dev>
References: <20231031223846.827173-1-souravpanda@google.com>
 <20231031223846.827173-2-souravpanda@google.com>
 <4a1de79e-a3e8-2544-e975-e17cad0d2f8a@linux.dev>
 <CANruzcTT=FmLJ+B=p8VbrbrVhogp867F2BhQTfHPp6hpCuO+1A@mail.gmail.com>
 <C9DFF65B-EACF-4D88-A175-DE9A10E8C1E9@linux.dev>
 <CANruzcTEOY76dmR=W9eN8d=Qk4rYH6rTsCuYSbF172sHVW2z1Q@mail.gmail.com>
To: Sourav Panda <souravpanda@google.com>
X-Migadu-Flow: FLOW_OUT



> On Nov 3, 2023, at 01:37, Sourav Panda <souravpanda@google.com> wrote:
>=20
>=20
>=20
> On Wed, Nov 1, 2023 at 7:43=E2=80=AFPM Muchun Song =
<muchun.song@linux.dev> wrote:
>=20
>=20
> > On Nov 2, 2023, at 06:58, Sourav Panda <souravpanda@google.com> =
wrote:
> >=20
> >=20
> >=20
> > On Tue, Oct 31, 2023 at 8:38=E2=80=AFPM Muchun Song =
<muchun.song@linux.dev> wrote:
> >=20
> >=20
> > On 2023/11/1 06:38, Sourav Panda wrote:
> > > Adds a new per-node PageMetadata field to
> > > /sys/devices/system/node/nodeN/meminfo
> > > and a global PageMetadata field to /proc/meminfo. This information =
can
> > > be used by users to see how much memory is being used by per-page
> > > metadata, which can vary depending on build configuration, machine
> > > architecture, and system use.
> > >
> > > Per-page metadata is the amount of memory that Linux needs in =
order to
> > > manage memory at the page granularity. The majority of such memory =
is
> > > used by "struct page" and "page_ext" data structures. In contrast =
to
> > > most other memory consumption statistics, per-page metadata might =
not
> > > be included in MemTotal. For example, MemTotal does not include =
memblock
> > > allocations but includes buddy allocations. While on the other =
hand,
> > > per-page metadata would include both memblock and buddy =
allocations.
> > >
> > > This memory depends on build configurations, machine =
architectures, and
> > > the way system is used:
> > >
> > > Build configuration may include extra fields into "struct page",
> > > and enable / disable "page_ext"
> > > Machine architecture defines base page sizes. For example 4K x86,
> > > 8K SPARC, 64K ARM64 (optionally), etc. The per-page metadata
> > > overhead is smaller on machines with larger page sizes.
> > > System use can change per-page overhead by using vmemmap
> > > optimizations with hugetlb pages, and emulated pmem devdax pages.
> > > Also, boot parameters can determine whether page_ext is needed
> > > to be allocated. This memory can be part of MemTotal or be outside
> > > MemTotal depending on whether the memory was hot-plugged, booted =
with,
> > > or hugetlb memory was returned back to the system.
> > >
> > > Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Signed-off-by: Sourav Panda <souravpanda@google.com>
> > > ---
> > >   Documentation/filesystems/proc.rst |  3 +++
> > >   drivers/base/node.c                |  2 ++
> > >   fs/proc/meminfo.c                  |  7 +++++++
> > >   include/linux/mmzone.h             |  3 +++
> > >   include/linux/vmstat.h             |  4 ++++
> > >   mm/hugetlb.c                       | 11 ++++++++--
> > >   mm/hugetlb_vmemmap.c               |  8 ++++++--
> > >   mm/mm_init.c                       |  3 +++
> > >   mm/page_alloc.c                    |  1 +
> > >   mm/page_ext.c                      | 32 =
+++++++++++++++++++++---------
> > >   mm/sparse-vmemmap.c                |  3 +++
> > >   mm/sparse.c                        |  7 ++++++-
> > >   mm/vmstat.c                        | 24 ++++++++++++++++++++++
> > >   13 files changed, 94 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/proc.rst =
b/Documentation/filesystems/proc.rst
> > > index 2b59cff8be17..c121f2ef9432 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -987,6 +987,7 @@ Example output. You may not have all of these =
fields.
> > >       AnonPages:       4654780 kB
> > >       Mapped:           266244 kB
> > >       Shmem:              9976 kB
> > > +    PageMetadata:     513419 kB
> > >       KReclaimable:     517708 kB
> > >       Slab:             660044 kB
> > >       SReclaimable:     517708 kB
> > > @@ -1089,6 +1090,8 @@ Mapped
> > >                 files which have been mmapped, such as libraries
> > >   Shmem
> > >                 Total memory used by shared memory (shmem) and =
tmpfs
> > > +PageMetadata
> > > +              Memory used for per-page metadata
> > >   KReclaimable
> > >                 Kernel allocations that the kernel will attempt to =
reclaim
> > >                 under memory pressure. Includes SReclaimable =
(below), and other
> > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > index 493d533f8375..da728542265f 100644
> > > --- a/drivers/base/node.c
> > > +++ b/drivers/base/node.c
> > > @@ -428,6 +428,7 @@ static ssize_t node_read_meminfo(struct device =
*dev,
> > >                            "Node %d Mapped:         %8lu kB\n"
> > >                            "Node %d AnonPages:      %8lu kB\n"
> > >                            "Node %d Shmem:          %8lu kB\n"
> > > +                          "Node %d PageMetadata:   %8lu kB\n"
> > >                            "Node %d KernelStack:    %8lu kB\n"
> > >   #ifdef CONFIG_SHADOW_CALL_STACK
> > >                            "Node %d ShadowCallStack:%8lu kB\n"
> > > @@ -458,6 +459,7 @@ static ssize_t node_read_meminfo(struct device =
*dev,
> > >                            nid, K(node_page_state(pgdat, =
NR_FILE_MAPPED)),
> > >                            nid, K(node_page_state(pgdat, =
NR_ANON_MAPPED)),
> > >                            nid, K(i.sharedram),
> > > +                          nid, K(node_page_state(pgdat, =
NR_PAGE_METADATA)),
> > >                            nid, node_page_state(pgdat, =
NR_KERNEL_STACK_KB),
> > >   #ifdef CONFIG_SHADOW_CALL_STACK
> > >                            nid, node_page_state(pgdat, =
NR_KERNEL_SCS_KB),
> > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > index 45af9a989d40..f141bb2a550d 100644
> > > --- a/fs/proc/meminfo.c
> > > +++ b/fs/proc/meminfo.c
> > > @@ -39,7 +39,9 @@ static int meminfo_proc_show(struct seq_file *m, =
void *v)
> > >       long available;
> > >       unsigned long pages[NR_LRU_LISTS];
> > >       unsigned long sreclaimable, sunreclaim;
> > > +     unsigned long nr_page_metadata;
> > >       int lru;
> > > +     int nid;
> > >  =20
> > >       si_meminfo(&i);
> > >       si_swapinfo(&i);
> > > @@ -57,6 +59,10 @@ static int meminfo_proc_show(struct seq_file =
*m, void *v)
> > >       sreclaimable =3D =
global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B);
> > >       sunreclaim =3D =
global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B);
> > >  =20
> > > +     nr_page_metadata =3D 0;
> > > +     for_each_online_node(nid)
> > > +             nr_page_metadata +=3D =
node_page_state(NODE_DATA(nid), NR_PAGE_METADATA);
> > > +
> > >       show_val_kb(m, "MemTotal:       ", i.totalram);
> > >       show_val_kb(m, "MemFree:        ", i.freeram);
> > >       show_val_kb(m, "MemAvailable:   ", available);
> > > @@ -104,6 +110,7 @@ static int meminfo_proc_show(struct seq_file =
*m, void *v)
> > >       show_val_kb(m, "Mapped:         ",
> > >                   global_node_page_state(NR_FILE_MAPPED));
> > >       show_val_kb(m, "Shmem:          ", i.sharedram);
> > > +     show_val_kb(m, "PageMetadata:   ", nr_page_metadata);
> > >       show_val_kb(m, "KReclaimable:   ", sreclaimable +
> > >                   =
global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE));
> > >       show_val_kb(m, "Slab:           ", sreclaimable + =
sunreclaim);
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 4106fbc5b4b3..dda1ad522324 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -207,6 +207,9 @@ enum node_stat_item {
> > >       PGPROMOTE_SUCCESS,      /* promote successfully */
> > >       PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> > >   #endif
> > > +     NR_PAGE_METADATA,       /* Page metadata size (struct page =
and page_ext)
> > > +                              * in pages
> > > +                              */
> > >       NR_VM_NODE_STAT_ITEMS
> > >   };
> > >  =20
> > > diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> > > index fed855bae6d8..af096a881f03 100644
> > > --- a/include/linux/vmstat.h
> > > +++ b/include/linux/vmstat.h
> > > @@ -656,4 +656,8 @@ static inline void =
lruvec_stat_sub_folio(struct folio *folio,
> > >   {
> > >       lruvec_stat_mod_folio(folio, idx, -folio_nr_pages(folio));
> > >   }
> > > +
> > > +void __init mod_node_early_perpage_metadata(int nid, long delta);
> > > +void __init store_early_perpage_metadata(void);
> > > +
> > >   #endif /* _LINUX_VMSTAT_H */
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 1301ba7b2c9a..cd3158a9c7f3 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1790,6 +1790,9 @@ static void =
__update_and_free_hugetlb_folio(struct hstate *h,
> > >               destroy_compound_gigantic_folio(folio, =
huge_page_order(h));
> > >               free_gigantic_folio(folio, huge_page_order(h));
> > >       } else {
> > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > +             __node_stat_sub_folio(folio, NR_PAGE_METADATA);
> > > +#endif
> > >               __free_pages(&folio->page, huge_page_order(h));
> > >       }
> > >   }
> > > @@ -2125,6 +2128,7 @@ static struct folio =
*alloc_buddy_hugetlb_folio(struct hstate *h,
> > >       struct page *page;
> > >       bool alloc_try_hard =3D true;
> > >       bool retry =3D true;
> > > +     struct folio *folio;
> > >  =20
> > >       /*
> > >        * By default we always try hard to allocate the page with
> > > @@ -2175,9 +2179,12 @@ static struct folio =
*alloc_buddy_hugetlb_folio(struct hstate *h,
> > >               __count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
> > >               return NULL;
> > >       }
> > > -
> > > +     folio =3D page_folio(page);
> > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > +     __node_stat_add_folio(folio, NR_PAGE_METADATA)
> >=20
> > Seems you have not tested this patch with CONFIG_SPARSEMEM_VMEMMAP =
disabled.
> > You missed ";" in the end.
> >=20
> > Thanks for reviewing this patch. I will submit v5 by testing against =
FLATMEM and
> > SPARSEMEM (VMEMMAP disabled) memory model on ARM32. This error was =
introduced
> > in v4.
> >=20
> > =20
> > > +#endif
> >=20
> > I am curious why we should account HugeTLB pages as metadata.
> >=20
> > When HugeTLB pages are reserved, memory pertaining to redundant =
`struct page` are
> > returned to the buddy allocator for other uses. This essentially =
reflects the change in the
>=20
> Why the `struct page` are returned to the buddy when =
CONFIG_SPARSEMEM_VMEMMAP
> is disabled? Why it is added with a PAGE_SIZE?
>=20
> Thank you again!=20
>=20
> I see both your points. I believe the solution is to remove updates to =
NR_PAGE_METADATA
> when CONFIG_SPARSEMEM_VMEMMAP is disabled. I shall do this in v6 if =
you agree.
>=20
> Why is it added with a PAGE_SIZE?
> - You are correct. First of all we should not even update it when =
CONFIG_SPARSEMEM_VMEMMAP
>    is disabled. Furthermore, even if we did, we should have done it by =
a factor of=20
>    huge_page_order(h) instead of folio_nr_pages(folio).

Actually, I think we should remove this counting from this path =
regardless of
whether CONFIG_SPARSEMEM_VMEMMAP is enabled or not. The metadata (aka =
page structure)
is not allocated from here, it is allocated from where the vmemmap areas =
are
initialized during boot time. You should count there.

> - This error was introduced in v4 as we switched from=20
>   __mod_node_page_state(pg_dat, NR_PAGE_METADATA, huge_page_order(h)) =
to
>   __node_stat_sub_folio(folio, NR_PAGE_METADATA).
> - huge_page_order(h) returns 9 for each 2 MB HugeTLB page allocation =
while
>   folio_nr_pages(folio), which is called in __node_stat_sub_folio =
returns 512.=20
> - Removing updates to NR_PAGE_METADATA when CONFIG_SPARSEMEM_VMEMMAP =
is
>   disabled shall fix this problem.
> =20
>=20
> > amount of `struct pages` when HugeTLB pages are reserved and free'd.
> > =20
> > >       __count_vm_event(HTLB_BUDDY_PGALLOC);
> > > -     return page_folio(page);
> > > +     return folio;
> > >   }
> > >  =20
> > >   /*
> > > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > > index 4b9734777f69..804a93d18cab 100644
> > > --- a/mm/hugetlb_vmemmap.c
> > > +++ b/mm/hugetlb_vmemmap.c
> > > @@ -214,6 +214,7 @@ static inline void free_vmemmap_page(struct =
page *page)
> > >               free_bootmem_page(page);
> > >       else
> > >               __free_page(page);
> > > +     __mod_node_page_state(page_pgdat(page), NR_PAGE_METADATA, =
-1);
> > >   }
> > >  =20
> > >   /* Free a list of the vmemmap pages */
> > > @@ -336,6 +337,7 @@ static int vmemmap_remap_free(unsigned long =
start, unsigned long end,
> > >                         (void *)walk.reuse_addr);
> > >               list_add(&walk.reuse_page->lru, &vmemmap_pages);
> > >       }
> > > +     __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA, 1);
> >=20
> > What if allocation of walk.reuse_page fails?
> >=20
> > Thank you for pointing this out. I will move the NR_PAGE_METADATA =
update within the=20
> > if ( walk.reuse_page ) clause to cover the case where =
walk.reuse_page fails.
> > =20
> > >  =20
> > >       /*
> > >        * In order to make remapping routine most efficient for the =
huge pages,
> > > @@ -381,14 +383,16 @@ static int alloc_vmemmap_page_list(unsigned =
long start, unsigned long end,
> > >                                  struct list_head *list)
> > >   {
> > >       gfp_t gfp_mask =3D GFP_KERNEL | __GFP_RETRY_MAYFAIL | =
__GFP_THISNODE;
> > > -     unsigned long nr_pages =3D (end - start) >> PAGE_SHIFT;
> > > +     unsigned long nr_pages =3D DIV_ROUND_UP(end - start, =
PAGE_SIZE);
> >=20
> > "end - start" is always multiple of PAGE_SIZE, why we need =
DIV_ROUND_UP=20
> > here?
> >=20
> > Thank you. I agree with this and will revert this change in v5.
> > =20
> > >       int nid =3D page_to_nid((struct page *)start);
> > >       struct page *page, *next;
> > > +     int i;
> > >  =20
> > > -     while (nr_pages--) {
> > > +     for (i =3D 0; i < nr_pages; i++) {
> > >               page =3D alloc_pages_node(nid, gfp_mask, 0);
> > >               if (!page)
> > >                       goto out;
> > > +             __mod_node_page_state(page_pgdat(page), =
NR_PAGE_METADATA, 1);
> > >               list_add_tail(&page->lru, list);
> > >       }
> >=20
> > Count one by ine is really inefficient. Can't we count *nr_pages* at
> > one time?
> >=20
> > Thanks for suggesting this optimization. I will modify the =
implementation to update the
> > metadata once as opposed to every iteration.
> > =20
> > >  =20
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 50f2f34745af..6997bf00945b 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -26,6 +26,7 @@
> > >   #include <linux/pgtable.h>
> > >   #include <linux/swap.h>
> > >   #include <linux/cma.h>
> > > +#include <linux/vmstat.h>
> > >   #include "internal.h"
> > >   #include "slab.h"
> > >   #include "shuffle.h"
> > > @@ -1656,6 +1657,8 @@ static void __init alloc_node_mem_map(struct =
pglist_data *pgdat)
> > >                       panic("Failed to allocate %ld bytes for node =
%d memory map\n",
> > >                             size, pgdat->node_id);
> > >               pgdat->node_mem_map =3D map + offset;
> > > +             mod_node_early_perpage_metadata(pgdat->node_id,
> > > +                                             DIV_ROUND_UP(size, =
PAGE_SIZE));
> > >       }
> > >       pr_debug("%s: node %d, pgdat %08lx, node_mem_map %08lx\n",
> > >                               __func__, pgdat->node_id, (unsigned =
long)pgdat,
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 85741403948f..522dc0c52610 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5443,6 +5443,7 @@ void __init setup_per_cpu_pageset(void)
> > >       for_each_online_pgdat(pgdat)
> > >               pgdat->per_cpu_nodestats =3D
> > >                       alloc_percpu(struct per_cpu_nodestat);
> > > +     store_early_perpage_metadata();
> > >   }
> > >  =20
> > >   __meminit void zone_pcp_init(struct zone *zone)
> > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > index 4548fcc66d74..d8d6db9c3d75 100644
> > > --- a/mm/page_ext.c
> > > +++ b/mm/page_ext.c
> > > @@ -201,6 +201,8 @@ static int __init alloc_node_page_ext(int nid)
> > >               return -ENOMEM;
> > >       NODE_DATA(nid)->node_page_ext =3D base;
> > >       total_usage +=3D table_size;
> > > +     __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > > +                           DIV_ROUND_UP(table_size, PAGE_SIZE));
> > >       return 0;
> > >   }
> > >  =20
> > > @@ -255,12 +257,15 @@ static void *__meminit alloc_page_ext(size_t =
size, int nid)
> > >       void *addr =3D NULL;
> > >  =20
> > >       addr =3D alloc_pages_exact_nid(nid, size, flags);
> > > -     if (addr) {
> > > +     if (addr)
> > >               kmemleak_alloc(addr, size, 1, flags);
> > > -             return addr;
> > > -     }
> > > +     else
> > > +             addr =3D vzalloc_node(size, nid);
> > >  =20
> > > -     addr =3D vzalloc_node(size, nid);
> > > +     if (addr) {
> > > +             mod_node_page_state(NODE_DATA(nid), =
NR_PAGE_METADATA,
> > > +                                 DIV_ROUND_UP(size, PAGE_SIZE));
> > > +     }
> > >  =20
> > >       return addr;
> > >   }
> > > @@ -303,18 +308,27 @@ static int __meminit =
init_section_page_ext(unsigned long pfn, int nid)
> > >  =20
> > >   static void free_page_ext(void *addr)
> > >   {
> > > +     size_t table_size;
> > > +     struct page *page;
> > > +     struct pglist_data *pgdat;
> > > +
> > > +     table_size =3D page_ext_size * PAGES_PER_SECTION;
> > > +
> > >       if (is_vmalloc_addr(addr)) {
> > > +             page =3D vmalloc_to_page(addr);
> > > +             pgdat =3D page_pgdat(page);
> > >               vfree(addr);
> > >       } else {
> > > -             struct page *page =3D virt_to_page(addr);
> > > -             size_t table_size;
> > > -
> > > -             table_size =3D page_ext_size * PAGES_PER_SECTION;
> > > -
> > > +             page =3D virt_to_page(addr);
> > > +             pgdat =3D page_pgdat(page);
> > >               BUG_ON(PageReserved(page));
> > >               kmemleak_free(addr);
> > >               free_pages_exact(addr, table_size);
> > >       }
> > > +
> > > +     __mod_node_page_state(pgdat, NR_PAGE_METADATA,
> > > +                           -1L * (DIV_ROUND_UP(table_size, =
PAGE_SIZE)));
> > > +
> > >   }
> > >  =20
> > >   static void __free_page_ext(unsigned long pfn)
> > > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > > index a2cbe44c48e1..2bc67b2c2aa2 100644
> > > --- a/mm/sparse-vmemmap.c
> > > +++ b/mm/sparse-vmemmap.c
> > > @@ -469,5 +469,8 @@ struct page * __meminit =
__populate_section_memmap(unsigned long pfn,
> > >       if (r < 0)
> > >               return NULL;
> > >  =20
> > > +     __mod_node_page_state(NODE_DATA(nid), NR_PAGE_METADATA,
> > > +                           DIV_ROUND_UP(end - start, PAGE_SIZE));
> > > +
> > >       return pfn_to_page(pfn);
> > >   }
> > > diff --git a/mm/sparse.c b/mm/sparse.c
> > > index 77d91e565045..7f67b5486cd1 100644
> > > --- a/mm/sparse.c
> > > +++ b/mm/sparse.c
> > > @@ -14,7 +14,7 @@
> > >   #include <linux/swap.h>
> > >   #include <linux/swapops.h>
> > >   #include <linux/bootmem_info.h>
> > > -
> > > +#include <linux/vmstat.h>
> > >   #include "internal.h"
> > >   #include <asm/dma.h>
> > >  =20
> > > @@ -465,6 +465,9 @@ static void __init sparse_buffer_init(unsigned =
long size, int nid)
> > >        */
> > >       sparsemap_buf =3D memmap_alloc(size, section_map_size(), =
addr, nid, true);
> > >       sparsemap_buf_end =3D sparsemap_buf + size;
> > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > +     mod_node_early_perpage_metadata(nid, DIV_ROUND_UP(size, =
PAGE_SIZE));
> > > +#endif
> > >   }
> > >  =20
> > >   static void __init sparse_buffer_fini(void)
> > > @@ -641,6 +644,8 @@ static void depopulate_section_memmap(unsigned =
long pfn, unsigned long nr_pages,
> > >       unsigned long start =3D (unsigned long) pfn_to_page(pfn);
> > >       unsigned long end =3D start + nr_pages * sizeof(struct =
page);
> > >  =20
> > > +     __mod_node_page_state(page_pgdat(pfn_to_page(pfn)), =
NR_PAGE_METADATA,
> > > +                           -1L * (DIV_ROUND_UP(end - start, =
PAGE_SIZE)));
> > >       vmemmap_free(start, end, altmap);
> > >   }
> > >   static void free_map_bootmem(struct page *memmap)
> > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > index 00e81e99c6ee..070d2b3d2bcc 100644
> > > --- a/mm/vmstat.c
> > > +++ b/mm/vmstat.c
> > > @@ -1245,6 +1245,7 @@ const char * const vmstat_text[] =3D {
> > >       "pgpromote_success",
> > >       "pgpromote_candidate",
> > >   #endif
> > > +     "nr_page_metadata",
> > >  =20
> > >       /* enum writeback_stat_item counters */
> > >       "nr_dirty_threshold",
> > > @@ -2274,4 +2275,27 @@ static int __init extfrag_debug_init(void)
> > >   }
> > >  =20
> > >   module_init(extfrag_debug_init);
> > > +
> > >   #endif
> > > +
> > > +/*
> > > + * Page metadata size (struct page and page_ext) in pages
> > > + */
> > > +static unsigned long early_perpage_metadata[MAX_NUMNODES] =
__initdata;
> > > +
> > > +void __init mod_node_early_perpage_metadata(int nid, long delta)
> > > +{
> > > +     early_perpage_metadata[nid] +=3D delta;
> > > +}
> > > +
> > > +void __init store_early_perpage_metadata(void)
> > > +{
> > > +     int nid;
> > > +     struct pglist_data *pgdat;
> > > +
> > > +     for_each_online_pgdat(pgdat) {
> > > +             nid =3D pgdat->node_id;
> > > +             __mod_node_page_state(NODE_DATA(nid), =
NR_PAGE_METADATA,
> > > +                                   early_perpage_metadata[nid]);
> > > +     }
> > > +}



