Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3C2B44C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 14:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgKPNdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 08:33:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgKPNdV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:33:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D5E7AF0E;
        Mon, 16 Nov 2020 13:33:19 +0000 (UTC)
Date:   Mon, 16 Nov 2020 14:33:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 04/21] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
Message-ID: <20201116133310.GA32129@linux>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113105952.11638-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:59:35PM +0800, Muchun Song wrote:
> If the size of HugeTLB page is 2MB, we need 512 struct page structures
> (8 pages) to be associated with it. As far as I know, we only use the
> first 4 struct page structures. Use of first 4 struct page structures
> comes from HUGETLB_CGROUP_MIN_ORDER.

Once you mention 2MB HugeTLB page and its specific I would also mention
1GB HugeTLB pages, maybe something along these lines.
I would supress "As far as I know", we __know__ that we only use
the first 4 struct page structures to track metadata information.

> +/*
> + * There are 512 struct page structures(8 pages) associated with each 2MB
> + * hugetlb page. For tail pages, the value of compound_head is the same.
> + * So we can reuse first page of tail page structures. We map the virtual
> + * addresses of the remaining 6 pages of tail page structures to the first
> + * tail page struct, and then free these 6 pages. Therefore, we need to
> + * reserve at least 2 pages as vmemmap areas.
> + */
> +#define RESERVE_VMEMMAP_NR		2U

Either I would include 1GB specific there as well, or I would not add
any specifics at all and just go by saying that first two pages are used,
and the rest can be remapped to the first page that contains the tails.


> +void __init hugetlb_vmemmap_init(struct hstate *h)
> +{
> +	unsigned int order = huge_page_order(h);
> +	unsigned int vmemmap_pages;
> +
> +	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
> +	/*
> +	 * The head page and the first tail page are not to be freed to buddy
> +	 * system, the others page will map to the first tail page. So there
"the remaining pages" might be more clear.

> +	 * are (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
"that can be freed"

> +	 *
> +	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? This is
> +	 * not expected to happen unless the system is corrupted. So on the
> +	 * safe side, it is only a safety net.
> +	 */
> +	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> +	else
> +		h->nr_free_vmemmap_pages = 0;

This made think of something.
Since struct hstate hstates is global, all the fields should be defined to 0.
So, the following assignments in hugetlb_add_hstate:

        h->nr_huge_pages = 0;
        h->free_huge_pages = 0;

should not be needed.
Actually, we do not initialize other values like resv_huge_pages
or surplus_huge_pages.

If that is the case, the "else" could go.

Mike?

The changes itself look good to me.
I think that putting all the vemmap stuff into hugetlb-vmemmap.* was
the right choice.


-- 
Oscar Salvador
SUSE L3
