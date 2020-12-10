Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D822D5982
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 12:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgLJLmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 06:42:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:47610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbgLJLlz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:41:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0079EAF16;
        Thu, 10 Dec 2020 11:41:06 +0000 (UTC)
Date:   Thu, 10 Dec 2020 11:04:54 +0100
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
Subject: Re: [PATCH v8 09/12] mm/hugetlb: Add a kernel parameter
 hugetlb_free_vmemmap
Message-ID: <20201210100454.GB3613@localhost.localdomain>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210035526.38938-10-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:55:23AM +0800, Muchun Song wrote:
> +hugetlb_free_vmemmap
> +	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
> +	unused vmemmap pages associated each HugeTLB page.
                                      ^^^ with

> -	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
> +	if (is_hugetlb_free_vmemmap_enabled())
> +		err = vmemmap_populate_basepages(start, end, node, NULL);
> +	else if (end - start < PAGES_PER_SECTION * sizeof(struct page))
>  		err = vmemmap_populate_basepages(start, end, node, NULL);

Not sure if joining those in an OR makes se.se

>  	else if (boot_cpu_has(X86_FEATURE_PSE))
>  		err = vmemmap_populate_hugepages(start, end, node, altmap);
> @@ -1610,7 +1613,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
>  		}
>  		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
>  
> -		if (!boot_cpu_has(X86_FEATURE_PSE)) {
> +		if (!boot_cpu_has(X86_FEATURE_PSE) ||
> +		    is_hugetlb_free_vmemmap_enabled()) {

I would add a variable at the beginning called "basepages_populated"
that holds the result of those two conditions.
I am not sure if it slightly improves the code as the conditions do
not need to be rechecked, but the readibility a bit.

> +bool hugetlb_free_vmemmap_enabled;
> +
> +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	/* We cannot optimize if a "struct page" crosses page boundaries. */

I think this comment belongs to the last patch.


-- 
Oscar Salvador
SUSE L3
