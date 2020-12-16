Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A52DC9B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 00:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgLPXuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 18:50:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgLPXuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:50:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGNiO32178003;
        Wed, 16 Dec 2020 23:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=t+xg/WoW+Lcz45M9BqHGxWCcZtlzUk4JFO7sfQxB45g=;
 b=i3Cha5kpL4DqsDgi2QwPQYuwKIUzWCWeiMwhDMJ+XTV+OrC+uBBS6ahx/biDz5Cbpd8X
 VtgH2Fr97/lB0K/nSa0Zz8tLY8+OzFTOttvGOGYxPbOtePerjU8JcnedG+i3laEIDvkv
 AAwAqfksaCVOPjupTAHsa1tDfPwUccni/5APjrtEA/HTyzNz3tj7dDg/qeLweLkLB0fv
 CowUg8d0QqhLaAj9DR9kDaCyaaOJYaItGAv+N7GvP6cxu/fMcVjS4+dplCiuld9h07Zh
 Gx0mZMjB6kk+30GqyziKhr73J3eA7CgWH9NIhMSJ6vAdgED0cHQbmHLa1+QDyxPVcHH0 wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35cn9rjyrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 23:48:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGNjMNf192968;
        Wed, 16 Dec 2020 23:48:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35d7eq67qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 23:48:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BGNmNnp013213;
        Wed, 16 Dec 2020 23:48:24 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 15:48:23 -0800
Subject: Re: [PATCH v9 04/11] mm/hugetlb: Defer freeing of HugeTLB pages
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6b555fb8-6fd5-049a-49c1-4dc8a3f66766@oracle.com>
Date:   Wed, 16 Dec 2020 15:48:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201213154534.54826-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160147
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/20 7:45 AM, Muchun Song wrote:
> In the subsequent patch, we will allocate the vmemmap pages when free
> HugeTLB pages. But update_and_free_page() is called from a non-task
> context(and hold hugetlb_lock), so we can defer the actual freeing in
> a workqueue to prevent use GFP_ATOMIC to allocate the vmemmap pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

It is unfortunate we need to add this complexitty, but I can not think
of another way.  One small comment (no required change) below.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> ---
>  mm/hugetlb.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  mm/hugetlb_vmemmap.c | 12 --------
>  mm/hugetlb_vmemmap.h | 17 ++++++++++++
>  3 files changed, 88 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 140135fc8113..0ff9b90e524f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1292,15 +1292,76 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> -static void update_and_free_page(struct hstate *h, struct page *page)
> +static void __free_hugepage(struct hstate *h, struct page *page);
> +
> +/*
> + * As update_and_free_page() is be called from a non-task context(and hold
> + * hugetlb_lock), we can defer the actual freeing in a workqueue to prevent
> + * use GFP_ATOMIC to allocate a lot of vmemmap pages.
> + *
> + * update_hpage_vmemmap_workfn() locklessly retrieves the linked list of
> + * pages to be freed and frees them one-by-one. As the page->mapping pointer
> + * is going to be cleared in update_hpage_vmemmap_workfn() anyway, it is
> + * reused as the llist_node structure of a lockless linked list of huge
> + * pages to be freed.
> + */
> +static LLIST_HEAD(hpage_update_freelist);
> +
> +static void update_hpage_vmemmap_workfn(struct work_struct *work)
>  {
> -	int i;
> +	struct llist_node *node;
> +	struct page *page;
> +
> +	node = llist_del_all(&hpage_update_freelist);
>  
> +	while (node) {
> +		page = container_of((struct address_space **)node,
> +				     struct page, mapping);
> +		node = node->next;
> +		page->mapping = NULL;
> +		__free_hugepage(page_hstate(page), page);
> +
> +		cond_resched();
> +	}
> +}
> +static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
> +
> +static inline void __update_and_free_page(struct hstate *h, struct page *page)
> +{
> +	/* No need to allocate vmemmap pages */
> +	if (!free_vmemmap_pages_per_hpage(h)) {
> +		__free_hugepage(h, page);
> +		return;
> +	}
> +
> +	/*
> +	 * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap
> +	 * pages.
> +	 *
> +	 * Only call schedule_work() if hpage_update_freelist is previously
> +	 * empty. Otherwise, schedule_work() had been called but the workfn
> +	 * hasn't retrieved the list yet.
> +	 */
> +	if (llist_add((struct llist_node *)&page->mapping,
> +		      &hpage_update_freelist))
> +		schedule_work(&hpage_update_work);
> +}
> +
> +static void update_and_free_page(struct hstate *h, struct page *page)
> +{
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
>  	h->nr_huge_pages--;
>  	h->nr_huge_pages_node[page_to_nid(page)]--;
> +
> +	__update_and_free_page(h, page);
> +}
> +
> +static void __free_hugepage(struct hstate *h, struct page *page)
> +{
> +	int i;
> +

Can we add a comment here saying that this is where the call to allocate
vmemmmap pages will be inserted in a later patch.  Such a comment would
help a bit to understand the restructuring of the code.

-- 
Mike Kravetz

>  	for (i = 0; i < pages_per_huge_page(h); i++) {
>  		page[i].flags &= ~(1 << PG_locked | 1 << PG_error |
>  				1 << PG_referenced | 1 << PG_dirty |
> @@ -1313,13 +1374,17 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	set_page_refcounted(page);
>  	if (hstate_is_gigantic(h)) {
>  		/*
> -		 * Temporarily drop the hugetlb_lock, because
> -		 * we might block in free_gigantic_page().
> +		 * Temporarily drop the hugetlb_lock only when this type of
> +		 * HugeTLB page does not support vmemmap optimization (which
> +		 * contex do not hold the hugetlb_lock), because we might block
> +		 * in free_gigantic_page().
>  		 */
> -		spin_unlock(&hugetlb_lock);
> +		if (!free_vmemmap_pages_per_hpage(h))
> +			spin_unlock(&hugetlb_lock);
>  		destroy_compound_gigantic_page(page, huge_page_order(h));
>  		free_gigantic_page(page, huge_page_order(h));
> -		spin_lock(&hugetlb_lock);
> +		if (!free_vmemmap_pages_per_hpage(h))
> +			spin_lock(&hugetlb_lock);
>  	} else {
>  		__free_pages(page, huge_page_order(h));
>  	}
