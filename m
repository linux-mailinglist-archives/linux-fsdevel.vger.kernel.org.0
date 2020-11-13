Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9162B1353
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 01:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgKMAjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 19:39:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMAjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:39:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0YJlx079300;
        Fri, 13 Nov 2020 00:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Ls3C+uNNlHIbuho6jGERwpcS+sJKtiHr3wMQuYv16Ds=;
 b=YCeiW20RQFn8tEVQpgvHwULhb8qIGG/OzvhX65Yw1TO8cYMXXKMYn5Kn1UXLhdkyx9CI
 OfAVCgL4LBPS52h72FkHkPfgodq0zj1DnsZbfK0mriUPNDJl1/qdjfD0wB9Zr2ONYh6R
 jnOSSPn+HitKUy6LobCVKMnxy5hBMqzJP/dZWwAAekg27OGAm9Zlc7m6wDBLtXIuWdrZ
 qsiG7qLNpFQZGpq6SiIPlsvaQu9MpxBSkW9yBcTzA+n+vOfUXCRrG4nc2QvLUbNFQf9V
 ahgyPEpbxVtRMWSIXZUEpOhGvCUrbn+ZK1WUmqMY8Tntel8mM2GNFYIu7XweSHFtNXXl Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3b8hp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 00:38:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0aGTw113147;
        Fri, 13 Nov 2020 00:36:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34rtksp808-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 00:36:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AD0a3Br024500;
        Fri, 13 Nov 2020 00:36:03 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 16:36:03 -0800
Subject: Re: [External] Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-6-songmuchun@bytedance.com>
 <9dc62874-379f-b126-94a7-5bd477529407@oracle.com>
 <CAMZfGtV+_vP66N1WagwNfxs4r3QGwnrYoR60yimwutTs=awXag@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b7c16e3f-d906-1a11-dbd5-dc4199d70821@oracle.com>
Date:   Thu, 12 Nov 2020 16:35:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtV+_vP66N1WagwNfxs4r3QGwnrYoR60yimwutTs=awXag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=2 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/10/20 7:41 PM, Muchun Song wrote:
> On Wed, Nov 11, 2020 at 8:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 11/8/20 6:10 AM, Muchun Song wrote:
>> I am reading the code incorrectly it does not appear page->lru (of the huge
>> page) is being used for this purpose.  Is that correct?
>>
>> If it is correct, would using page->lru of the huge page make this code
>> simpler?  I am just missing the reason why you are using
>> page_huge_pte(page)->lru
> 
> For 1GB HugeTLB pages, we should pre-allocate more than one page
> table. So I use a linked list. The page_huge_pte(page) is the list head.
> Because the page->lru shares storage with page->pmd_huge_pte.

Sorry, but I do not understand the statement page->lru shares storage with
page->pmd_huge_pte.  Are you saying they are both in head struct page of
the huge page?

Here is what I was suggesting.  If we just use page->lru for the list
then vmemmap_pgtable_prealloc() could be coded like the following:

static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
{
	struct page *pte_page, *t_page;
	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);

	if (!nr)
		return 0;

	/* Store preallocated pages on huge page lru list */
	INIT_LIST_HEAD(&page->lru);

	while (nr--) {
		pte_t *pte_p;

		pte_p = pte_alloc_one_kernel(&init_mm);
		if (!pte_p)
			goto out;
		list_add(&virt_to_page(pte_p)->lru, &page->lru);
	}

	return 0;
out:
	list_for_each_entry_safe(pte_page, t_page, &page->lru, lru)
		pte_free_kernel(&init_mm, page_to_virt(pte_page));
	return -ENOMEM;
}

By doing this we could eliminate the routines,
vmemmap_pgtable_init()
vmemmap_pgtable_deposit()
vmemmap_pgtable_withdraw()
and simply use the list manipulation routines.

To me, that looks simpler than the proposed code in this patch.
-- 
Mike Kravetz
