Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41A27F556
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgI3WnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 18:43:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48950 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgI3WnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:43:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UMZTe5075222;
        Wed, 30 Sep 2020 22:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QxSTjWUBwbndFPhMD0Pu8VbFrWz1EUUHjkxEADBt03w=;
 b=S+piuall3XH/UJ3/r83kO5qOH6cP1qI5BykZuJekLNJhHQdUEC4mClJ+NrOGOQGoqNGh
 leeLg93oOLLJbm/6CynaLEHz5fTZvQQXVnXrGgVHYq12utIFOxnMZHWNtenS6axdzI1C
 vkKqMy7c/mLlEXKMW7XxziHYr40FHtZ7xbRNgbJ+1549qLybUboP38etN/K/4YAaIFDl
 1QccPISX63SsGuKhYz9DWvSbVjQDgABb7wUL7ObCme5HhMUN95Vw64rL62DhxRlCytnM
 xcM0R/c8hhqbU4eMLjdkFR1iAucEtNCQvRD+i6GpUW0z5qKLpsWIEciei66UfQvxOrBQ vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33sx9nb1eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 22:41:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UMenIp165255;
        Wed, 30 Sep 2020 22:41:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33tfdur3ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 22:41:39 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08UMfVfS007055;
        Wed, 30 Sep 2020 22:41:31 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 15:41:31 -0700
Subject: Re: [RFC PATCH 05/24] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20200915125947.26204-1-songmuchun@bytedance.com>
 <20200915125947.26204-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b2811679-cd90-4685-2284-64490e7dfb7e@oracle.com>
Date:   Wed, 30 Sep 2020 15:41:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915125947.26204-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300181
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/15/20 5:59 AM, Muchun Song wrote:
> If the size of hugetlb page is 2MB, we need 512 struct page structures
> (8 pages) to be associated with it. As far as I know, we only use the
> first 3 struct page structures and only read the compound_dtor members

Actually, the first 4 pages can be used if CONFIG_CGROUP_HUGETLB.
/*
 * Minimum page order trackable by hugetlb cgroup.
 * At least 4 pages are necessary for all the tracking information.
 * The second tail page (hpage[2]) is the fault usage cgroup.
 * The third tail page (hpage[3]) is the reservation usage cgroup.
 */
#define HUGETLB_CGROUP_MIN_ORDER        2

However, this still easily fits within the first page of struct page
structures.

> of the remaining struct page structures. For tail page, the value of
> compound_dtor is the same. So we can reuse first tail page. We map the
> virtual addresses of the remaining 6 tail pages to the first tail page,
> and then free these 6 pages. Therefore, we need to reserve at least 2
> pages as vmemmap areas.

I got confused the first time I read the above sentences.  Perhaps it
should be more explicit with something like:

For tail pages, the value of compound_dtor is the same. So we can reuse
first page of tail page structs. We map the virtual addresses of the
remaining 6 pages of tail page structs to the first tail page struct,
and then free these 6 pages. Therefore, we need to reserve at least 2
pages as vmemmap areas.

It still does not sound great, but hopefully avoids some confusion.
-- 
Mike Kravetz

> So we introduce a new nr_free_vmemmap_pages field in the hstate to
> indicate how many vmemmap pages associated with a hugetlb page that we
> can free to buddy system.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d5cc5f802dd4..eed3dd3bd626 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -492,6 +492,9 @@ struct hstate {
>  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +	unsigned int nr_free_vmemmap_pages;
> +#endif
>  #ifdef CONFIG_CGROUP_HUGETLB
>  	/* cgroup control files */
>  	struct cftype cgroup_files_dfl[7];
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 81a41aa080a5..f1b2b733b49b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1292,6 +1292,39 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +#define RESERVE_VMEMMAP_NR	2U
> +
> +static inline unsigned int nr_free_vmemmap(struct hstate *h)
> +{
> +	return h->nr_free_vmemmap_pages;
> +}
> +
> +static void __init hugetlb_vmemmap_init(struct hstate *h)
> +{
> +	unsigned int order = huge_page_order(h);
> +	unsigned int vmemmap_pages;
> +
> +	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
> +	/*
> +	 * The head page and the first tail page not free to buddy system,
> +	 * the others page will map to the first tail page. So there are
> +	 * (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
> +	 */
> +	if (vmemmap_pages > RESERVE_VMEMMAP_NR)
> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
> +	else
> +		h->nr_free_vmemmap_pages = 0;
> +
> +	pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
> +		h->nr_free_vmemmap_pages, h->name);
> +}
> +#else
> +static inline void hugetlb_vmemmap_init(struct hstate *h)
> +{
> +}
> +#endif
> +
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
> @@ -3285,6 +3318,8 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
>  					huge_page_size(h)/1024);
>  
> +	hugetlb_vmemmap_init(h);
> +
>  	parsed_hstate = h;
>  }
>  
> 
