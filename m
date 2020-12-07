Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0252D10A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLGMiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbgLGMiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607344597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIx/GuOwLH7KKTYFdh//bNTfPEG2vhibcsgFFH2/VrU=;
        b=BauclSzIfP2KEbQAN+dMFl/9ZzoZbvIQYEQhCY9/Avvn3EX4lq+CCZ04tV4Xz9UeTqPMOV
        YpgnxsF4IGRMuNGMKVcc+mKbbsW0/Z6pP6DgZeGgQv8gxiid416eHBs6zu8XzX2RQXSXGl
        C3AH4pLg9Tc47gOvqEQZNeBJy5LsnsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-l1kDTieHNCSMQ4hMxtShqA-1; Mon, 07 Dec 2020 07:36:33 -0500
X-MC-Unique: l1kDTieHNCSMQ4hMxtShqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3FDD800D55;
        Mon,  7 Dec 2020 12:36:29 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF5DA60BE2;
        Mon,  7 Dec 2020 12:36:23 +0000 (UTC)
Subject: Re: [PATCH v7 04/15] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <20201130151838.11208-5-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8505f01c-ad26-e571-b464-aedfd1bd9280@redhat.com>
Date:   Mon, 7 Dec 2020 13:36:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130151838.11208-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.11.20 16:18, Muchun Song wrote:
> Every HugeTLB has more than one struct page structure. The 2M HugeTLB
> has 512 struct page structure and 1G HugeTLB has 4096 struct page
> structures. We __know__ that we only use the first 4(HUGETLB_CGROUP_MIN_ORDER)
> struct page structures to store metadata associated with each HugeTLB.
> 
> There are a lot of struct page structures(8 page frames for 2MB HugeTLB
> page and 4096 page frames for 1GB HugeTLB page) associated with each
> HugeTLB page. For tail pages, the value of compound_head is the same.
> So we can reuse first page of tail page structures. We map the virtual
> addresses of the remaining pages of tail page structures to the first
> tail page struct, and then free these page frames. Therefore, we need
> to reserve two pages as vmemmap areas.
> 
> So we introduce a new nr_free_vmemmap_pages field in the hstate to
> indicate how many vmemmap pages associated with a HugeTLB page that we
> can free to buddy system.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h |   3 ++
>  mm/Makefile             |   1 +
>  mm/hugetlb.c            |   3 ++
>  mm/hugetlb_vmemmap.c    | 129 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h    |  20 ++++++++
>  5 files changed, 156 insertions(+)
>  create mode 100644 mm/hugetlb_vmemmap.c
>  create mode 100644 mm/hugetlb_vmemmap.h
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ebca2ef02212..4efeccb7192c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -492,6 +492,9 @@ struct hstate {
>  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +	unsigned int nr_free_vmemmap_pages;
> +#endif
>  #ifdef CONFIG_CGROUP_HUGETLB
>  	/* cgroup control files */
>  	struct cftype cgroup_files_dfl[7];
> diff --git a/mm/Makefile b/mm/Makefile
> index ed4b88fa0f5e..056801d8daae 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_FRONTSWAP)	+= frontswap.o
>  obj-$(CONFIG_ZSWAP)	+= zswap.o
>  obj-$(CONFIG_HAS_DMA)	+= dmapool.o
>  obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
> +obj-$(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)	+= hugetlb_vmemmap.o
>  obj-$(CONFIG_NUMA) 	+= mempolicy.o
>  obj-$(CONFIG_SPARSEMEM)	+= sparse.o
>  obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f3bf1710b66..25f9e8e9fc4a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -42,6 +42,7 @@
>  #include <linux/userfaultfd_k.h>
>  #include <linux/page_owner.h>
>  #include "internal.h"
> +#include "hugetlb_vmemmap.h"
>  
>  int hugetlb_max_hstate __read_mostly;
>  unsigned int default_hstate_idx;
> @@ -3206,6 +3207,8 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
>  					huge_page_size(h)/1024);
>  
> +	hugetlb_vmemmap_init(h);
> +
>  	parsed_hstate = h;
>  }
>  
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> new file mode 100644
> index 000000000000..51152e258f39
> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Free some vmemmap pages of HugeTLB
> + *
> + * Copyright (c) 2020, Bytedance. All rights reserved.
> + *
> + *     Author: Muchun Song <songmuchun@bytedance.com>
> + *
> + * The struct page structures (page structs) are used to describe a physical
> + * page frame. By default, there is a one-to-one mapping from a page frame to
> + * it's corresponding page struct.
> + *
> + * The HugeTLB pages consist of multiple base page size pages and is supported
> + * by many architectures. See hugetlbpage.rst in the Documentation directory
> + * for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
> + * are currently supported. Since the base page size on x86 is 4KB, a 2MB
> + * HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> + * 4096 base pages. For each base page, there is a corresponding page struct.
> + *
> + * Within the HugeTLB subsystem, only the first 4 page structs are used to
> + * contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
> + * provides this upper limit. The only 'useful' information in the remaining
> + * page structs is the compound_head field, and this field is the same for all
> + * tail pages.
> + *
> + * By removing redundant page structs for HugeTLB pages, memory can returned to
> + * the buddy allocator for other uses.
> + *
> + * When the system boot up, every 2M HugeTLB has 512 struct page structs which
> + * size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).


You should try to generalize all descriptions regarding differing base
page sizes. E.g., arm64 supports 4k, 16k, and 64k base pages.

[...]

> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Free some vmemmap pages of HugeTLB
> + *
> + * Copyright (c) 2020, Bytedance. All rights reserved.
> + *
> + *     Author: Muchun Song <songmuchun@bytedance.com>
> + */
> +#ifndef _LINUX_HUGETLB_VMEMMAP_H
> +#define _LINUX_HUGETLB_VMEMMAP_H
> +#include <linux/hugetlb.h>
> +
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +void __init hugetlb_vmemmap_init(struct hstate *h);
> +#else
> +static inline void hugetlb_vmemmap_init(struct hstate *h)
> +{
> +}
> +#endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
> +#endif /* _LINUX_HUGETLB_VMEMMAP_H */
> 

This patch as it stands is rather sub-optimal. I mean, all it does is
add documentation and print what could be done.

Can we instead introduce the basic infrastructure and enable it via this
patch on top, where we glue all the pieces together? Or is there
something I am missing?

-- 
Thanks,

David / dhildenb

