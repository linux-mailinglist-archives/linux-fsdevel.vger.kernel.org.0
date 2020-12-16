Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB62DC0BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgLPNGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 08:06:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:42356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgLPNGx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:06:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B785AC7B;
        Wed, 16 Dec 2020 13:06:11 +0000 (UTC)
Date:   Wed, 16 Dec 2020 14:06:07 +0100
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
Subject: Re: [PATCH v9 03/11] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20201216130602.GA29394@linux>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213154534.54826-4-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 11:45:26PM +0800, Muchun Song wrote:
> +
> +/*
> + * vmemmap_rmap_walk - walk vmemmap page table
> + *
> + * @rmap_pte:		called for each non-empty PTE (lowest-level) entry.
> + * @reuse:		the page which is reused for the tail vmemmap pages.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + */
> +struct vmemmap_rmap_walk {
> +	void (*rmap_pte)(pte_t *pte, unsigned long addr,
> +			 struct vmemmap_rmap_walk *walk);
> +	struct page *reuse;
> +	struct list_head *vmemmap_pages;
> +};

Why did you chose this approach in this version?
Earlier versions of this patchset had a single vmemmap_to_pmd() function
which returned the PMD, and now we have serveral vmemmap_{levels}_range
and a vmemmap_rmap_walk.
A brief explanation about why this change was introduced would have been nice.

I guess it is because ealier versions were too oriented for the usecase
this patchset presents, while the new versions tries to be more broad
about future re-uses of the interface?


-- 
Oscar Salvador
SUSE L3
