Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207302B9E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 00:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgKSXiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 18:38:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgKSXiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:38:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNYp1V138161;
        Thu, 19 Nov 2020 23:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=MszqefOJcdbabdMne6HpW6zW0+wj9g5wPcoppzWfBRw=;
 b=KbfS9xyoLYd9f+1tXyKP2N9pPIg5wIv5h1lEyTOCL9Zt0uZIPY/9ifXv92/ct+6eDVjV
 wHfLnCwUxx9Q1YOPRUsv+/lvjU7vKJo1iZ/jnXcfB8Y+BfGIeeUhSxbnpehYWlxSJLd+
 Q7hygayEZy8mt+KJsQHshVxJOT9ZQ1qklH7XDFpV6jpznoJp6VwMAXI/JQ7Z+ePVzXRD
 cvvlkISXBgM/kgJoL5P3cZh8TURAQrb4wx7Szl/3HjrNWJzr2TNd3iyPIJKuz4PnxPwv
 ImThZf+gpItUVMV441kI05KshfgnaF9Ul8bYtiCy3iZq36mzR1j8xppN7mYP07oxInQy Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vng7ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 23:37:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNZbnW195048;
        Thu, 19 Nov 2020 23:37:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34ts0ufh77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 23:37:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AJNbRN5010801;
        Thu, 19 Nov 2020 23:37:28 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 15:37:27 -0800
Subject: Re: [PATCH v4 05/21] mm/hugetlb: Introduce pgtable allocation/freeing
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
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b3cadba4-5cef-a1ba-418d-bd08af60c656@oracle.com>
Date:   Thu, 19 Nov 2020 15:37:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201113105952.11638-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=2 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190162
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/20 2:59 AM, Muchun Song wrote:
> On x86_64, vmemmap is always PMD mapped if the machine has hugepages
> support and if we have 2MB contiguos pages and PMD aligned. If we want
                             contiguous              alignment
> to free the unused vmemmap pages, we have to split the huge pmd firstly.
> So we should pre-allocate pgtable to split PMD to PTE.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb_vmemmap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h | 12 +++++++++
>  2 files changed, 85 insertions(+)

Thanks for the cleanup.

Oscar made some other comments.  I only have one additional minor comment
below.

With those minor cleanups,
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
...
> +int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> +{
> +	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> +
> +	/* Store preallocated pages on huge page lru list */

Let's expland the above comment to something like this:

	/*
	 * Use the huge page lru list to temporarily store the preallocated
	 * pages.  The preallocated pages are used and the list is emptied
	 * before the huge page is put into use.  When the huge page is put
	 * into use by prep_new_huge_page() the list will be reinitialized.
	 */

> +	INIT_LIST_HEAD(&page->lru);
> +
> +	while (nr--) {
> +		pte_t *pte_p;
> +
> +		pte_p = pte_alloc_one_kernel(&init_mm);
> +		if (!pte_p)
> +			goto out;
> +		list_add(&virt_to_page(pte_p)->lru, &page->lru);
> +	}
> +
> +	return 0;
> +out:
> +	vmemmap_pgtable_free(page);
> +	return -ENOMEM;
> +}

-- 
Mike Kravetz
