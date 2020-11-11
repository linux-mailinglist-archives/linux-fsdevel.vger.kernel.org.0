Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF982AE51D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 01:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbgKKAr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 19:47:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57976 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbgKKArz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:47:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB0Z8o1041788;
        Wed, 11 Nov 2020 00:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wjw4jhHrEix2K0uxFHCF3PcVgyKd8xIKm8P3Sppl/AI=;
 b=DkRCRXVITd/K1iERo9l41LP7MOi6/hjrHQ8c6A2+ZBv45yqum2AkiJdZ8egI6mkvdNF4
 n8Ft9tj3RmOgiczEq6KOY4YbSNWM0vLgL60XowoHTWNXmbw32r0jhYnWAIbawWYESNI7
 bKHAiI9H18wzdCE4h328vGMOWc2ycqKLm99H0n4u6dHyJYgbi67Q90i0t1K7EfspfvCe
 bgIx1v6+igBRsvA6DjEQUGPqSY1EpX9ATIZ5tXheSryCOlPjxv0iC+wPcAYytu9FSI1I
 hPAXTe488hIp0F0cJnW70bWh6TXeHX12iSnCMqwPEXX/9ZCShYbPPs23gr3UxK9QH5Tc 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34nh3axw9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 00:47:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AB0Uqti171386;
        Wed, 11 Nov 2020 00:47:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34p5g12s9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 00:47:16 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AB0l6Su031556;
        Wed, 11 Nov 2020 00:47:07 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 16:47:05 -0800
Subject: Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable allocation/freeing
 helpers
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9dc62874-379f-b126-94a7-5bd477529407@oracle.com>
Date:   Tue, 10 Nov 2020 16:47:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201108141113.65450-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/8/20 6:10 AM, Muchun Song wrote:
> On x86_64, vmemmap is always PMD mapped if the machine has hugepages
> support and if we have 2MB contiguos pages and PMD aligned. If we want
> to free the unused vmemmap pages, we have to split the huge pmd firstly.
> So we should pre-allocate pgtable to split PMD to PTE.
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a0007902fafb..5c7be2ee7e15 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1303,6 +1303,108 @@ static inline void destroy_compound_gigantic_page(struct page *page,
...
> +static inline void vmemmap_pgtable_init(struct page *page)
> +{
> +	page_huge_pte(page) = NULL;
> +}
> +
> +static void vmemmap_pgtable_deposit(struct page *page, pgtable_t pgtable)
> +{
> +	/* FIFO */
> +	if (!page_huge_pte(page))
> +		INIT_LIST_HEAD(&pgtable->lru);
> +	else
> +		list_add(&pgtable->lru, &page_huge_pte(page)->lru);
> +	page_huge_pte(page) = pgtable;
> +}
> +
> +static pgtable_t vmemmap_pgtable_withdraw(struct page *page)
> +{
> +	pgtable_t pgtable;
> +
> +	/* FIFO */
> +	pgtable = page_huge_pte(page);
> +	page_huge_pte(page) = list_first_entry_or_null(&pgtable->lru,
> +						       struct page, lru);
> +	if (page_huge_pte(page))
> +		list_del(&pgtable->lru);
> +	return pgtable;
> +}
> +
> +static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> +{
> +	int i;
> +	pgtable_t pgtable;
> +	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +
> +	if (!nr)
> +		return 0;
> +
> +	vmemmap_pgtable_init(page);
> +
> +	for (i = 0; i < nr; i++) {
> +		pte_t *pte_p;
> +
> +		pte_p = pte_alloc_one_kernel(&init_mm);
> +		if (!pte_p)
> +			goto out;
> +		vmemmap_pgtable_deposit(page, virt_to_page(pte_p));
> +	}
> +
> +	return 0;
> +out:
> +	while (i-- && (pgtable = vmemmap_pgtable_withdraw(page)))
> +		pte_free_kernel(&init_mm, page_to_virt(pgtable));
> +	return -ENOMEM;
> +}
> +
> +static void vmemmap_pgtable_free(struct hstate *h, struct page *page)
> +{
> +	pgtable_t pgtable;
> +	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +
> +	if (!nr)
> +		return;
> +
> +	pgtable = page_huge_pte(page);
> +	if (!pgtable)
> +		return;
> +
> +	while (nr-- && (pgtable = vmemmap_pgtable_withdraw(page)))
> +		pte_free_kernel(&init_mm, page_to_virt(pgtable));
> +}

I may be confused.

In patch 9 of this series, the first call to vmemmap_pgtable_free() is made:

> @@ -1645,6 +1799,10 @@ void free_huge_page(struct page *page)
>  
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
> +	free_huge_page_vmemmap(h, page);
> +	/* Must be called before the initialization of @page->lru */
> +	vmemmap_pgtable_free(h, page);
> +
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>  	set_hugetlb_cgroup(page, NULL);

When I saw that comment in previous patch series, I assumed page->lru was
being used to store preallocated pages and pages to free.  However, unless
I am reading the code incorrectly it does not appear page->lru (of the huge
page) is being used for this purpose.  Is that correct?

If it is correct, would using page->lru of the huge page make this code
simpler?  I am just missing the reason why you are using
page_huge_pte(page)->lru

-- 
Mike Kravetz
