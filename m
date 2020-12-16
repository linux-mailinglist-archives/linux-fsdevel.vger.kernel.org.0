Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4D2DC179
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgLPNol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 08:44:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:53314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgLPNol (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:44:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 621CCAC7F;
        Wed, 16 Dec 2020 13:43:59 +0000 (UTC)
Date:   Wed, 16 Dec 2020 14:43:54 +0100
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
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 09/11] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
Message-ID: <20201216134354.GD29394@linux>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213154534.54826-10-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 11:45:32PM +0800, Muchun Song wrote:
> All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
> field in the hstate to indicate how many vmemmap pages associated with
> a HugeTLB page that we can free to buddy allocator. And initialize it
"can be freed to buddy allocator"

> in the hugetlb_vmemmap_init(). This patch is actual enablement of the
> feature.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

With below nits addressed you can add:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

>  static int __init early_hugetlb_free_vmemmap_param(char *buf)
>  {
> +	/* We cannot optimize if a "struct page" crosses page boundaries. */
> +	if (!is_power_of_2(sizeof(struct page)))
> +		return 0;
> +

I wonder if we should report a warning in case someone wants to enable this
feature and stuct page size it not power of 2.
In case someone wonders why it does not work for him/her.

> +void __init hugetlb_vmemmap_init(struct hstate *h)
> +{
> +	unsigned int nr_pages = pages_per_huge_page(h);
> +	unsigned int vmemmap_pages;
> +
> +	if (!hugetlb_free_vmemmap_enabled)
> +		return;
> +
> +	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
> +	/*
> +	 * The head page and the first tail page are not to be freed to buddy
> +	 * system, the others page will map to the first tail page. So there
> +	 * are the remaining pages that can be freed.
"the other pages will map to the first tail page, so they can be freed."
> +	 *
> +	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
> +	 * on some architectures (e.g. aarch64). See Documentation/arm64/
> +	 * hugetlbpage.rst for more details.
> +	 */
> +	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> +
> +	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
> +		h->name);

Maybe specify this is hugetlb code:

pr_info("%s: blabla", __func__, ...)
or
pr_info("hugetlb: blalala", ...);

although I am not sure whether we need that at all, or maybe just use
pr_debug().

-- 
Oscar Salvador
SUSE L3
