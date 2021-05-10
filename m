Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB41378406
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 12:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhEJKsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 06:48:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:33584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhEJKqg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 06:46:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2313AD21;
        Mon, 10 May 2021 10:45:30 +0000 (UTC)
Date:   Mon, 10 May 2021 12:45:24 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v23 6/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210510104524.GD22664@linux>
References: <20210510030027.56044-1-songmuchun@bytedance.com>
 <20210510030027.56044-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510030027.56044-7-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 11:00:24AM +0800, Muchun Song wrote:
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1376,6 +1376,39 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  	h->nr_huge_pages_node[nid]--;
>  }
>  
> +static void add_hugetlb_page(struct hstate *h, struct page *page,
> +			     bool adjust_surplus)
> +{
> +	int zeroed;
> +	int nid = page_to_nid(page);
> +
> +	VM_BUG_ON_PAGE(!HPageVmemmapOptimized(page), page);
> +
> +	lockdep_assert_held(&hugetlb_lock);
> +
> +	INIT_LIST_HEAD(&page->lru);
> +	h->nr_huge_pages++;
> +	h->nr_huge_pages_node[nid]++;
> +
> +	if (adjust_surplus) {
> +		h->surplus_huge_pages++;
> +		h->surplus_huge_pages_node[nid]++;
> +	}
> +
> +	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> +	set_page_private(page, 0);

I think this has already been discused, so sorry about this.

The only reason to need the set_page_private() is because of the dissolving
function right? add_hugetlb_page() can only get reached via free_huge_page(),
or dissolve_free_huge_page, and while the former clears the flags, the latter
it does not.

I think this function would benefit from some renaming. add_hugetlb_page() gives
me no hint of what is this about, although I can figure it out reading the code.

With that: Reviewed-by: Oscar Salvador <osalvador@suse.de>




-- 
Oscar Salvador
SUSE L3
