Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49732CBC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 06:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhCDFN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 00:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhCDFNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:13:34 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49452C061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Mar 2021 21:12:54 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p8so20577873ejb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Mar 2021 21:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ds8qjN6BO4rtyMPbdTpH68zawknLVz+099mA7/o5jLk=;
        b=gN+4zHFJuS6FEmfRB33Ln68UDsl5aSWUTDvwKwG0vTa8Tyw+nD19KkhvyAAoSfErGg
         +9VLIEIEaUlQL+erJO3tx1dWuon3VO6O3p0Co2Ot17gPDDqIF67DDjGL5v3EjqQcoEfb
         Ly2l4gP2v7agtxR9PriNCzkNQjJca+a0DcFrQFz8l8l+BBmt5PslfaEQR0YUdgwYVuzv
         a7xAY8UbndP3W3aEE+yLqFApvwUnbzbEuQ2yxwb6GOKmm9anzClwKJBQtGavjFrE90+b
         XtSk1z9du7SlFAE3ohnTO+sM0+GywQV1Lln6fpspSF7HvDue4up7zdp7q9WL6q1PvsDK
         XJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ds8qjN6BO4rtyMPbdTpH68zawknLVz+099mA7/o5jLk=;
        b=f4n32SqG7YyaeubwOwSJwDgjzTpSxsfnGl00u1jTf95PIgY/KklwVjz5fz8Jg8b+um
         E/vupLcECU/qyYMoKR4eJtUhQqVfPIED7MOxOCZn4NO2boBz5nhmn7+7oetl0ysigCxJ
         eGt+I7UQV6ZCObZyP5xzh0bGa4JSWleSSZ5inEdB0BCFRGBETi6j8ucHojkp9IDuDKVf
         ZxF2/g1MOz0BNSH1UW9rVgKhiGal4ZSpADbK7u+WvcRN4zRz13+MNKhXB84s/2NQqouP
         6abvdsxdeGAWK5cbkdYwFBz7zapgTDwv4xMaH/UXszK7mTPSVIJXyXs6gOoBe55UL4hH
         pJpQ==
X-Gm-Message-State: AOAM531SHv9gXo6rXJ/vKSFpEV9/ihZzC0eHMTuHvWg/j3lbaX6VSMfv
        GuRJ/fzTO4yddn0cMp3luAbS/dFBKbNm+Bm6QWiu
X-Google-Smtp-Source: ABdhPJy0YNIcdbFR5VHmBT3qCCwcO3W2bB+u0XKWLv43enBWsdPkS2QXJcfaXVxtifGJeT7lk/yNiFvDf5ONR8WcX2w=
X-Received: by 2002:a17:906:128e:: with SMTP id k14mr2209490ejb.427.1614834772868;
 Wed, 03 Mar 2021 21:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20210223115048.435-1-xieyongji@bytedance.com> <20210223115048.435-7-xieyongji@bytedance.com>
 <573ab913-55ce-045a-478f-1200bd78cf7b@redhat.com>
In-Reply-To: <573ab913-55ce-045a-478f-1200bd78cf7b@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 4 Mar 2021 13:12:41 +0800
Message-ID: <CACycT3sVhDKKu4zGbt1Lw-uWfKDAWs=O=C7kXXcuSnePohmBdQ@mail.gmail.com>
Subject: Re: Re: [RFC v4 06/11] vduse: Implement an MMU-based IOMMU driver
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 4, 2021 at 12:21 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2021/2/23 7:50 =E4=B8=8B=E5=8D=88, Xie Yongji wrote:
> > This implements a MMU-based IOMMU driver to support mapping
> > kernel dma buffer into userspace. The basic idea behind it is
> > treating MMU (VA->PA) as IOMMU (IOVA->PA). The driver will set
> > up MMU mapping instead of IOMMU mapping for the DMA transfer so
> > that the userspace process is able to use its virtual address to
> > access the dma buffer in kernel.
> >
> > And to avoid security issue, a bounce-buffering mechanism is
> > introduced to prevent userspace accessing the original buffer
> > directly.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vdpa/vdpa_user/iova_domain.c | 486 ++++++++++++++++++++++++++=
+++++++++
> >   drivers/vdpa/vdpa_user/iova_domain.h |  61 +++++
> >   2 files changed, 547 insertions(+)
> >   create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
> >   create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
> >
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_u=
ser/iova_domain.c
> > new file mode 100644
> > index 000000000000..9285d430d486
> > --- /dev/null
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> > @@ -0,0 +1,486 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * MMU-based IOMMU implementation
> > + *
> > + * Copyright (C) 2020 Bytedance Inc. and/or its affiliates. All rights=
 reserved.
> > + *
> > + * Author: Xie Yongji <xieyongji@bytedance.com>
> > + *
> > + */
> > +
> > +#include <linux/slab.h>
> > +#include <linux/file.h>
> > +#include <linux/anon_inodes.h>
> > +#include <linux/highmem.h>
> > +
> > +#include "iova_domain.h"
> > +
> > +#define IOVA_START_PFN 1
> > +#define IOVA_ALLOC_ORDER 12
> > +#define IOVA_ALLOC_SIZE (1 << IOVA_ALLOC_ORDER)
> > +
> > +static inline struct page *
> > +vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iov=
a)
> > +{
> > +     u64 index =3D iova >> PAGE_SHIFT;
> > +
> > +     return domain->bounce_pages[index];
> > +}
> > +
> > +static inline void
> > +vduse_domain_set_bounce_page(struct vduse_iova_domain *domain,
> > +                             u64 iova, struct page *page)
> > +{
> > +     u64 index =3D iova >> PAGE_SHIFT;
> > +
> > +     domain->bounce_pages[index] =3D page;
> > +}
> > +
> > +static enum dma_data_direction perm_to_dir(int perm)
> > +{
> > +     enum dma_data_direction dir;
> > +
> > +     switch (perm) {
> > +     case VHOST_MAP_WO:
> > +             dir =3D DMA_FROM_DEVICE;
> > +             break;
> > +     case VHOST_MAP_RO:
> > +             dir =3D DMA_TO_DEVICE;
> > +             break;
> > +     case VHOST_MAP_RW:
> > +             dir =3D DMA_BIDIRECTIONAL;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return dir;
> > +}
> > +
> > +static int dir_to_perm(enum dma_data_direction dir)
> > +{
> > +     int perm =3D -EFAULT;
> > +
> > +     switch (dir) {
> > +     case DMA_FROM_DEVICE:
> > +             perm =3D VHOST_MAP_WO;
> > +             break;
> > +     case DMA_TO_DEVICE:
> > +             perm =3D VHOST_MAP_RO;
> > +             break;
> > +     case DMA_BIDIRECTIONAL:
> > +             perm =3D VHOST_MAP_RW;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return perm;
> > +}
>
>
> Let's move the above two helpers to vhost_iotlb.h so they could be used
> by other driver e.g (vpda_sim)
>

Sure.

>
> > +
> > +static void do_bounce(phys_addr_t orig, void *addr, size_t size,
> > +                     enum dma_data_direction dir)
> > +{
> > +     unsigned long pfn =3D PFN_DOWN(orig);
> > +
> > +     if (PageHighMem(pfn_to_page(pfn))) {
> > +             unsigned int offset =3D offset_in_page(orig);
> > +             char *buffer;
> > +             unsigned int sz =3D 0;
> > +             unsigned long flags;
> > +
> > +             while (size) {
> > +                     sz =3D min_t(size_t, PAGE_SIZE - offset, size);
> > +
> > +                     local_irq_save(flags);
> > +                     buffer =3D kmap_atomic(pfn_to_page(pfn));
> > +                     if (dir =3D=3D DMA_TO_DEVICE)
> > +                             memcpy(addr, buffer + offset, sz);
> > +                     else
> > +                             memcpy(buffer + offset, addr, sz);
> > +                     kunmap_atomic(buffer);
> > +                     local_irq_restore(flags);
>
>
> I wonder why we need to deal with highmem and irq flags explicitly like
> this. Doesn't kmap_atomic() will take care all of those?
>

Yes, irq flags is useless here. Will remove it.

>
> > +
> > +                     size -=3D sz;
> > +                     pfn++;
> > +                     addr +=3D sz;
> > +                     offset =3D 0;
> > +             }
> > +     } else if (dir =3D=3D DMA_TO_DEVICE) {
> > +             memcpy(addr, phys_to_virt(orig), size);
> > +     } else {
> > +             memcpy(phys_to_virt(orig), addr, size);
> > +     }
> > +}
> > +
> > +static struct page *
> > +vduse_domain_get_mapping_page(struct vduse_iova_domain *domain, u64 io=
va)
> > +{
> > +     u64 start =3D iova & PAGE_MASK;
> > +     u64 last =3D start + PAGE_SIZE - 1;
> > +     struct vhost_iotlb_map *map;
> > +     struct page *page =3D NULL;
> > +
> > +     spin_lock(&domain->iotlb_lock);
> > +     map =3D vhost_iotlb_itree_first(domain->iotlb, start, last);
> > +     if (!map)
> > +             goto out;
> > +
> > +     page =3D pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIF=
T);
> > +     get_page(page);
> > +out:
> > +     spin_unlock(&domain->iotlb_lock);
> > +
> > +     return page;
> > +}
> > +
> > +static struct page *
> > +vduse_domain_alloc_bounce_page(struct vduse_iova_domain *domain, u64 i=
ova)
> > +{
> > +     u64 start =3D iova & PAGE_MASK;
> > +     u64 last =3D start + PAGE_SIZE - 1;
> > +     struct vhost_iotlb_map *map;
> > +     struct page *page =3D NULL, *new_page =3D alloc_page(GFP_KERNEL);
> > +
> > +     if (!new_page)
> > +             return NULL;
> > +
> > +     spin_lock(&domain->iotlb_lock);
> > +     if (!vhost_iotlb_itree_first(domain->iotlb, start, last)) {
> > +             __free_page(new_page);
> > +             goto out;
> > +     }
> > +     page =3D vduse_domain_get_bounce_page(domain, iova);
> > +     if (page) {
> > +             get_page(page);
> > +             __free_page(new_page);
> > +             goto out;
> > +     }
> > +     vduse_domain_set_bounce_page(domain, iova, new_page);
> > +     get_page(new_page);
> > +     page =3D new_page;
> > +
> > +     for (map =3D vhost_iotlb_itree_first(domain->iotlb, start, last);=
 map;
> > +          map =3D vhost_iotlb_itree_next(map, start, last)) {
> > +             unsigned int src_offset =3D 0, dst_offset =3D 0;
> > +             phys_addr_t src;
> > +             void *dst;
> > +             size_t sz;
> > +
> > +             if (perm_to_dir(map->perm) =3D=3D DMA_FROM_DEVICE)
> > +                     continue;
> > +
> > +             if (start > map->start)
> > +                     src_offset =3D start - map->start;
> > +             else
> > +                     dst_offset =3D map->start - start;
> > +
> > +             src =3D map->addr + src_offset;
> > +             dst =3D page_address(page) + dst_offset;
> > +             sz =3D min_t(size_t, map->size - src_offset,
> > +                             PAGE_SIZE - dst_offset);
> > +             do_bounce(src, dst, sz, DMA_TO_DEVICE);
> > +     }
> > +out:
> > +     spin_unlock(&domain->iotlb_lock);
> > +
> > +     return page;
> > +}
> > +
> > +static void
> > +vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain,
> > +                             u64 iova, size_t size)
> > +{
> > +     struct page *page;
> > +
> > +     spin_lock(&domain->iotlb_lock);
> > +     if (WARN_ON(vhost_iotlb_itree_first(domain->iotlb, iova,
> > +                                             iova + size - 1)))
> > +             goto out;
> > +
> > +     while (size > 0) {
> > +             page =3D vduse_domain_get_bounce_page(domain, iova);
> > +             if (page) {
> > +                     vduse_domain_set_bounce_page(domain, iova, NULL);
> > +                     __free_page(page);
> > +             }
> > +             size -=3D PAGE_SIZE;
> > +             iova +=3D PAGE_SIZE;
> > +     }
> > +out:
> > +     spin_unlock(&domain->iotlb_lock);
> > +}
> > +
> > +static void vduse_domain_bounce(struct vduse_iova_domain *domain,
> > +                             dma_addr_t iova, phys_addr_t orig,
> > +                             size_t size, enum dma_data_direction dir)
> > +{
> > +     unsigned int offset =3D offset_in_page(iova);
> > +
> > +     while (size) {
> > +             struct page *p =3D vduse_domain_get_bounce_page(domain, i=
ova);
> > +             size_t sz =3D min_t(size_t, PAGE_SIZE - offset, size);
> > +
> > +             WARN_ON(!p && dir =3D=3D DMA_FROM_DEVICE);
> > +
> > +             if (p)
> > +                     do_bounce(orig, page_address(p) + offset, sz, dir=
);
> > +
> > +             size -=3D sz;
> > +             orig +=3D sz;
> > +             iova +=3D sz;
> > +             offset =3D 0;
> > +     }
> > +}
> > +
> > +static dma_addr_t vduse_domain_alloc_iova(struct iova_domain *iovad,
> > +                             unsigned long size, unsigned long limit)
> > +{
> > +     unsigned long shift =3D iova_shift(iovad);
> > +     unsigned long iova_len =3D iova_align(iovad, size) >> shift;
> > +     unsigned long iova_pfn;
> > +
> > +     if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> > +             iova_len =3D roundup_pow_of_two(iova_len);
> > +     iova_pfn =3D alloc_iova_fast(iovad, iova_len, limit >> shift, tru=
e);
> > +
> > +     return iova_pfn << shift;
> > +}
> > +
> > +static void vduse_domain_free_iova(struct iova_domain *iovad,
> > +                             dma_addr_t iova, size_t size)
> > +{
> > +     unsigned long shift =3D iova_shift(iovad);
> > +     unsigned long iova_len =3D iova_align(iovad, size) >> shift;
> > +
> > +     free_iova_fast(iovad, iova >> shift, iova_len);
> > +}
> > +
> > +dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
> > +                             struct page *page, unsigned long offset,
> > +                             size_t size, enum dma_data_direction dir,
> > +                             unsigned long attrs)
> > +{
> > +     struct iova_domain *iovad =3D &domain->stream_iovad;
> > +     unsigned long limit =3D domain->bounce_size - 1;
> > +     phys_addr_t pa =3D page_to_phys(page) + offset;
> > +     dma_addr_t iova =3D vduse_domain_alloc_iova(iovad, size, limit);
> > +     int ret;
> > +
> > +     if (!iova)
> > +             return DMA_MAPPING_ERROR;
> > +
> > +     spin_lock(&domain->iotlb_lock);
> > +     ret =3D vhost_iotlb_add_range(domain->iotlb, (u64)iova,
> > +                                 (u64)iova + size - 1,
> > +                                 pa, dir_to_perm(dir));
> > +     spin_unlock(&domain->iotlb_lock);
> > +     if (ret) {
> > +             vduse_domain_free_iova(iovad, iova, size);
> > +             return DMA_MAPPING_ERROR;
> > +     }
> > +     if (dir =3D=3D DMA_TO_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL)
> > +             vduse_domain_bounce(domain, iova, pa, size, DMA_TO_DEVICE=
);
> > +
> > +     return iova;
> > +}
> > +
> > +void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
> > +                     dma_addr_t dma_addr, size_t size,
> > +                     enum dma_data_direction dir, unsigned long attrs)
> > +{
> > +     struct iova_domain *iovad =3D &domain->stream_iovad;
> > +     struct vhost_iotlb_map *map;
> > +     phys_addr_t pa;
> > +
> > +     spin_lock(&domain->iotlb_lock);
> > +     map =3D vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
> > +                                   (u64)dma_addr + size - 1);
> > +     if (WARN_ON(!map)) {
> > +             spin_unlock(&domain->iotlb_lock);
> > +             return;
> > +     }
> > +     pa =3D map->addr;
> > +     vhost_iotlb_map_free(domain->iotlb, map);
> > +     spin_unlock(&domain->iotlb_lock);
> > +
> > +     if (dir =3D=3D DMA_FROM_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL)
> > +             vduse_domain_bounce(domain, dma_addr, pa,
> > +                                     size, DMA_FROM_DEVICE);
> > +
> > +     vduse_domain_free_iova(iovad, dma_addr, size);
> > +}
> > +
> > +void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
> > +                             size_t size, dma_addr_t *dma_addr,
> > +                             gfp_t flag, unsigned long attrs)
> > +{
> > +     struct iova_domain *iovad =3D &domain->consistent_iovad;
> > +     unsigned long limit =3D domain->iova_limit;
> > +     dma_addr_t iova =3D vduse_domain_alloc_iova(iovad, size, limit);
> > +     void *orig =3D alloc_pages_exact(size, flag);
> > +     int ret;
> > +
> > +     if (!iova || !orig)
> > +             goto err;
> > +
> > +     spin_lock(&domain->iotlb_lock);
> > +     ret =3D vhost_iotlb_add_range(domain->iotlb, (u64)iova,
> > +                                 (u64)iova + size - 1,
> > +                                 virt_to_phys(orig), VHOST_MAP_RW);
> > +     spin_unlock(&domain->iotlb_lock);
> > +     if (ret)
> > +             goto err;
> > +
> > +     *dma_addr =3D iova;
> > +
> > +     return orig;
> > +err:
> > +     *dma_addr =3D DMA_MAPPING_ERROR;
> > +     if (orig)
> > +             free_pages_exact(orig, size);
> > +     if (iova)
> > +             vduse_domain_free_iova(iovad, iova, size);
> > +
> > +     return NULL;
> > +}
> > +
> > +void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size=
_t size,
> > +                             void *vaddr, dma_addr_t dma_addr,
> > +                             unsigned long attrs)
> > +{
> > +     struct iova_domain *iovad =3D &domain->consistent_iovad;
> > +     struct vhost_iotlb_map *map;
> > +     phys_addr_t pa;
> > +
> > +     spin_lock(&domain->iotlb_lock);
> > +     map =3D vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
> > +                                   (u64)dma_addr + size - 1);
> > +     if (WARN_ON(!map)) {
> > +             spin_unlock(&domain->iotlb_lock);
> > +             return;
> > +     }
> > +     pa =3D map->addr;
> > +     vhost_iotlb_map_free(domain->iotlb, map);
> > +     spin_unlock(&domain->iotlb_lock);
> > +
> > +     vduse_domain_free_iova(iovad, dma_addr, size);
> > +     free_pages_exact(phys_to_virt(pa), size);
> > +}
> > +
> > +static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
> > +{
> > +     struct vduse_iova_domain *domain =3D vmf->vma->vm_private_data;
> > +     unsigned long iova =3D vmf->pgoff << PAGE_SHIFT;
> > +     struct page *page;
> > +
> > +     if (!domain)
> > +             return VM_FAULT_SIGBUS;
> > +
> > +     if (iova < domain->bounce_size)
> > +             page =3D vduse_domain_alloc_bounce_page(domain, iova);
> > +     else
> > +             page =3D vduse_domain_get_mapping_page(domain, iova);
> > +
> > +     if (!page)
> > +             return VM_FAULT_SIGBUS;
> > +
> > +     vmf->page =3D page;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct vm_operations_struct vduse_domain_mmap_ops =3D {
> > +     .fault =3D vduse_domain_mmap_fault,
> > +};
> > +
> > +static int vduse_domain_mmap(struct file *file, struct vm_area_struct =
*vma)
> > +{
> > +     struct vduse_iova_domain *domain =3D file->private_data;
> > +
> > +     vma->vm_flags |=3D VM_DONTDUMP | VM_DONTEXPAND;
> > +     vma->vm_private_data =3D domain;
> > +     vma->vm_ops =3D &vduse_domain_mmap_ops;
> > +
> > +     return 0;
> > +}
> > +
> > +static int vduse_domain_release(struct inode *inode, struct file *file=
)
> > +{
> > +     struct vduse_iova_domain *domain =3D file->private_data;
> > +
> > +     vduse_domain_free_bounce_pages(domain, 0, domain->bounce_size);
> > +     put_iova_domain(&domain->stream_iovad);
> > +     put_iova_domain(&domain->consistent_iovad);
> > +     vhost_iotlb_free(domain->iotlb);
> > +     vfree(domain->bounce_pages);
> > +     kfree(domain);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations vduse_domain_fops =3D {
> > +     .mmap =3D vduse_domain_mmap,
> > +     .release =3D vduse_domain_release,
> > +};
> > +
> > +void vduse_domain_destroy(struct vduse_iova_domain *domain)
> > +{
> > +     fput(domain->file);
> > +}
> > +
> > +struct vduse_iova_domain *
> > +vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
> > +{
> > +     struct vduse_iova_domain *domain;
> > +     struct file *file;
> > +     unsigned long bounce_pfns =3D PAGE_ALIGN(bounce_size) >> PAGE_SHI=
FT;
> > +
> > +     if (iova_limit <=3D bounce_size)
> > +             return NULL;
> > +
> > +     domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > +     if (!domain)
> > +             return NULL;
> > +
> > +     domain->iotlb =3D vhost_iotlb_alloc(0, 0);
> > +     if (!domain->iotlb)
> > +             goto err_iotlb;
> > +
> > +     domain->iova_limit =3D iova_limit;
> > +     domain->bounce_size =3D PAGE_ALIGN(bounce_size);
> > +     domain->bounce_pages =3D vzalloc(bounce_pfns * sizeof(struct page=
 *));
> > +     if (!domain->bounce_pages)
> > +             goto err_page;
> > +
> > +     file =3D anon_inode_getfile("[vduse-domain]", &vduse_domain_fops,
> > +                             domain, O_RDWR);
> > +     if (IS_ERR(file))
> > +             goto err_file;
> > +
> > +     domain->file =3D file;
> > +     spin_lock_init(&domain->iotlb_lock);
> > +     init_iova_domain(&domain->stream_iovad,
> > +                     IOVA_ALLOC_SIZE, IOVA_START_PFN);
> > +     init_iova_domain(&domain->consistent_iovad,
> > +                     PAGE_SIZE, bounce_pfns);
> > +
> > +     return domain;
> > +err_file:
> > +     vfree(domain->bounce_pages);
> > +err_page:
> > +     vhost_iotlb_free(domain->iotlb);
> > +err_iotlb:
> > +     kfree(domain);
> > +     return NULL;
> > +}
> > +
> > +int vduse_domain_init(void)
> > +{
> > +     return iova_cache_get();
> > +}
> > +
> > +void vduse_domain_exit(void)
> > +{
> > +     iova_cache_put();
> > +}
> > diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_u=
ser/iova_domain.h
> > new file mode 100644
> > index 000000000000..9c85d8346626
> > --- /dev/null
> > +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> > @@ -0,0 +1,61 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * MMU-based IOMMU implementation
> > + *
> > + * Copyright (C) 2020 Bytedance Inc. and/or its affiliates. All rights=
 reserved.
> > + *
> > + * Author: Xie Yongji <xieyongji@bytedance.com>
> > + *
> > + */
> > +
> > +#ifndef _VDUSE_IOVA_DOMAIN_H
> > +#define _VDUSE_IOVA_DOMAIN_H
> > +
> > +#include <linux/iova.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/vhost_iotlb.h>
> > +
> > +struct vduse_iova_domain {
> > +     struct iova_domain stream_iovad;
> > +     struct iova_domain consistent_iovad;
> > +     struct page **bounce_pages;
> > +     size_t bounce_size;
> > +     unsigned long iova_limit;
> > +     struct vhost_iotlb *iotlb;
>
>
> Sorry if I've asked this before.
>
> But what's the reason for maintaing a dedicated IOTLB here? I think we
> could reuse vduse_dev->iommu since the device can not be used by both
> virtio and vhost in the same time or use vduse_iova_domain->iotlb for
> set_map().
>

The main difference between domain->iotlb and dev->iotlb is the way to
deal with bounce buffer. In the domain->iotlb case, bounce buffer
needs to be mapped each DMA transfer because we need to get the bounce
pages by an IOVA during DMA unmapping. In the dev->iotlb case, bounce
buffer only needs to be mapped once during initialization, which will
be used to tell userspace how to do mmap().

> Also, since vhost IOTLB support per mapping token (opauqe), can we use
> that instead of the bounce_pages *?
>

Sorry, I didn't get you here. Which value do you mean to store in the
opaque pointer=EF=BC=9F

Thanks,
Yongji
