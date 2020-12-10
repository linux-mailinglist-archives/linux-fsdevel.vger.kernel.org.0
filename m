Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF92D597C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 12:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbgLJLlG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 06:41:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:38766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgLJLlF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:41:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 913DCACC6;
        Thu, 10 Dec 2020 11:40:21 +0000 (UTC)
Date:   Thu, 10 Dec 2020 11:15:26 +0100
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
Subject: Re: [PATCH v8 10/12] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
Message-ID: <20201210101526.GA4525@localhost.localdomain>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210035526.38938-11-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:55:24AM +0800, Muchun Song wrote:
> +void __init hugetlb_vmemmap_init(struct hstate *h)
> +{
> +	unsigned int nr_pages = pages_per_huge_page(h);
> +	unsigned int vmemmap_pages;
> +
> +	/* We cannot optimize if a "struct page" crosses page boundaries. */
> +	if (!is_power_of_2(sizeof(struct page)))
> +		return;
> +
> +	if (!hugetlb_free_vmemmap_enabled)
> +		return;

I think it would make sense to squash the last patch and this one.
As per the last patch, if "struct page" is not power of 2,
early_hugetlb_free_vmemmap_param() does not set
hugetlb_free_vmemmap_enabled, so the "!is_power_of_2" check from above
would become useless here.
We know that in order for hugetlb_free_vmemmap_enabled to become true,
the is_power_of_2 must have succeed early on when calling the early_
function.

-- 
Oscar Salvador
SUSE L3
