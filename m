Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A12AC147
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 17:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgKIQsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 11:48:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:48196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730467AbgKIQsf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:48:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 066FEAB95;
        Mon,  9 Nov 2020 16:48:33 +0000 (UTC)
Date:   Mon, 9 Nov 2020 17:48:29 +0100
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
Subject: Re: [PATCH v3 04/21] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
Message-ID: <20201109164825.GA17356@linux>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108141113.65450-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 08, 2020 at 10:10:56PM +0800, Muchun Song wrote:
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +/*
> + * There are 512 struct page structs(8 pages) associated with each 2MB
> + * hugetlb page. For tail pages, the value of compound_dtor is the same.
I gess you meant "For tail pages, the value of compound_head ...", right?

> + * So we can reuse first page of tail page structs. We map the virtual
> + * addresses of the remaining 6 pages of tail page structs to the first
> + * tail page struct, and then free these 6 pages. Therefore, we need to
> + * reserve at least 2 pages as vmemmap areas.
> + */
> +#define RESERVE_VMEMMAP_NR	2U
> +
> +static void __init hugetlb_vmemmap_init(struct hstate *h)
> +{
> +	unsigned int order = huge_page_order(h);
> +	unsigned int vmemmap_pages;
> +
> +	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
> +	/*
> +	 * The head page and the first tail page not free to buddy system,

"The head page and the first tail page are not to be freed to..." better?


> +	 * the others page will map to the first tail page. So there are
> +	 * (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
						      ^^^
                                                      that

> +	else
> +		h->nr_free_vmemmap_pages = 0;

I would specify that this is not expected to happen.
(At least I could not come up with a real scenario unless the system is
corrupted)
So, I would drop a brief comment pointing out that it is only a safety
net.


Unrelated to this patch but related in general, I am not sure about Mike but
would it be cleaner to move all the vmemmap functions to hugetlb_vmemmap.c?
hugetlb code is quite tricky, so I am not sure about stuffing more code
in there.

-- 
Oscar Salvador
SUSE L3
