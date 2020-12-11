Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9722D76B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 14:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgLKNho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 08:37:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:34168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732520AbgLKNhV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:37:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8CFAAE65;
        Fri, 11 Dec 2020 13:36:33 +0000 (UTC)
Date:   Fri, 11 Dec 2020 14:36:29 +0100
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
Subject: Re: [PATCH v8 07/12] mm/hugetlb: Set the PageHWPoison to the raw
 error page
Message-ID: <20201211133624.GA27050@linux>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-8-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210035526.38938-8-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:55:21AM +0800, Muchun Song wrote:
> +static inline void subpage_hwpoison_deliver(struct hstate *h, struct page *head)
> +{
> +	struct page *page = head;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return;
> +
> +	if (PageHWPoison(head))
> +		page = head + page_private(head + 4);
> +
> +	/*
> +	 * Move PageHWPoison flag from head page to the raw error page,
> +	 * which makes any subpages rather than the error page reusable.
> +	 */
> +	if (page != head) {
> +		SetPageHWPoison(page);
> +		ClearPageHWPoison(head);
> +	}
> +}

I would make the names coherent.
I am not definitely goot at names, but something like:
hwpoison_subpage_{foo,bar} looks better.

Also, could not subpage_hwpoison_deliver be rewritten like:

  static inline void subpage_hwpoison_deliver(struct hstate *h, struct page *head)
  {
       struct page *page;
  
       if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
               return;
  
       page = head + page_private(head + 4);
       /*
        * Move PageHWPoison flag from head page to the raw error page,
        * which makes any subpages rather than the error page reusable.
        */
       if (page != head) {
               SetPageHWPoison(page);
               ClearPageHWPoison(head);
       }
  }

I think it is better code-wise.

> +	 * Move PageHWPoison flag from head page to the raw error page,
> +	 * which makes any subpages rather than the error page reusable.
> +	 */
> +	if (page != head) {
> +		SetPageHWPoison(page);
> +		ClearPageHWPoison(head);
> +	}

I would put this in an else-if above:

	if (free_vmemmap_pages_per_hpage(h)) {
		set_page_private(head + 4, page - head);
	        return;
	} else if (page != head) {
		SetPageHWPoison(page);
		ClearPageHWPoison(head);
	}

or will we lose the optimization in case free_vmemmap_pages_per_hpage gets compiled out?


-- 
Oscar Salvador
SUSE L3
