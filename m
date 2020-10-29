Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DDF29ECD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 14:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgJ2N0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 09:26:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:49534 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2N0c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:26:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B47C4AC77;
        Thu, 29 Oct 2020 13:26:30 +0000 (UTC)
Date:   Thu, 29 Oct 2020 14:26:27 +0100
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
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/19] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
Message-ID: <20201029132621.GA2842@linux>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145114.59424-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:50:59PM +0800, Muchun Song wrote:
> If the size of hugetlb page is 2MB, we need 512 struct page structures
> (8 pages) to be associated with it. As far as I know, we only use the
> first 4 struct page structures.

As Mike pointed out, better describe what those "4" mean.
 
> For tail pages, the value of compound_dtor is the same. So we can reuse

I might be missing something, but HUGETLB_PAGE_DTOR is only set on the
first tail, right?

> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +#define RESERVE_VMEMMAP_NR	2U

Although you can get that from the changelog, maybe a brief comment explaining
why RESERVE_VMEMMAP_NR == 2.
> +
> +static inline unsigned int nr_free_vmemmap(struct hstate *h)
> +{
> +	return h->nr_free_vmemmap_pages;
> +}

Better add this in the patch that is used?

> +	if (vmemmap_pages > RESERVE_VMEMMAP_NR)
> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> +	else
> +		h->nr_free_vmemmap_pages = 0;

Can we really have an scenario where we end up with vmemmap_pages < RESERVE_VMEMMAP_NR?

> +
> +	pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
> +		h->nr_free_vmemmap_pages, h->name);

I do not think this is useful unless debugging situations, so I would either
scratch that or make it pr_debug.


-- 
Oscar Salvador
SUSE L3
