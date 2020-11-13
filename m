Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC12B13A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 02:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKMBDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 20:03:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50456 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgKMBDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:03:09 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0s0Xm113957;
        Fri, 13 Nov 2020 01:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=A+yROxOeZMxSIj57WnkMpxlM1xxqGLo7/Ocbao+mSa4=;
 b=GtFpgr+A9E/huD3eJ55I5RGk8VjGiDcihl56B+TSv/k3eTo9Z+ZnY/VxrCCO+D8KeCln
 D2MmNw75g/nwlYGOAhutmpqS30efgbLBfchtOt3tkan4hZNZ+FpiU7cEQyP76AtpLm/p
 bDHqmQRctlbTWnwYIUNeboHyvXG5H70Htb3+O1WW/u6ImgDs5V1c/4FZrBX+Kncy/Gpr
 Aozs85oqCFU8px9g3KIZ2vr/3KGGDrfDCw/DRdFOREiX4ifMep6JbVq4aVQlUD2xcQmC
 wIHnm5ZTbC3koigE2l1ARPcYt4P2iTJgdQAy3y8w7rPM4snHvYZ96LMuXavUhY/y9U8/ 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3b8k5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 01:02:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD0tCms182230;
        Fri, 13 Nov 2020 01:02:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34rt56yg8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 01:02:42 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AD12dlr017570;
        Fri, 13 Nov 2020 01:02:39 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 17:02:39 -0800
Subject: Re: [External] Re: [PATCH v3 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
From:   Mike Kravetz <mike.kravetz@oracle.com>
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
 <b7c16e3f-d906-1a11-dbd5-dc4199d70821@oracle.com>
Message-ID: <0f22bb94-478c-c1a4-7033-fbc6aca2404f@oracle.com>
Date:   Thu, 12 Nov 2020 17:02:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b7c16e3f-d906-1a11-dbd5-dc4199d70821@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=2 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130002
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/20 4:35 PM, Mike Kravetz wrote:
> On 11/10/20 7:41 PM, Muchun Song wrote:
>> On Wed, Nov 11, 2020 at 8:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 11/8/20 6:10 AM, Muchun Song wrote:
>>> I am reading the code incorrectly it does not appear page->lru (of the huge
>>> page) is being used for this purpose.  Is that correct?
>>>
>>> If it is correct, would using page->lru of the huge page make this code
>>> simpler?  I am just missing the reason why you are using
>>> page_huge_pte(page)->lru
>>
>> For 1GB HugeTLB pages, we should pre-allocate more than one page
>> table. So I use a linked list. The page_huge_pte(page) is the list head.
>> Because the page->lru shares storage with page->pmd_huge_pte.
> 
> Sorry, but I do not understand the statement page->lru shares storage with
> page->pmd_huge_pte.  Are you saying they are both in head struct page of
> the huge page?
> 
> Here is what I was suggesting.  If we just use page->lru for the list
> then vmemmap_pgtable_prealloc() could be coded like the following:
> 
> static int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
> {
> 	struct page *pte_page, *t_page;
> 	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
> 
> 	if (!nr)
> 		return 0;
> 
> 	/* Store preallocated pages on huge page lru list */
> 	INIT_LIST_HEAD(&page->lru);
> 
> 	while (nr--) {
> 		pte_t *pte_p;
> 
> 		pte_p = pte_alloc_one_kernel(&init_mm);
> 		if (!pte_p)
> 			goto out;
> 		list_add(&virt_to_page(pte_p)->lru, &page->lru);
> 	}
> 
> 	return 0;
> out:
> 	list_for_each_entry_safe(pte_page, t_page, &page->lru, lru)

Forgot the list_del(&pte_page->lru)
Perhaps it is not simpler after all. :)
-- 
Mike Kravetz

> 		pte_free_kernel(&init_mm, page_to_virt(pte_page));
> 	return -ENOMEM;
> }
> 
> By doing this we could eliminate the routines,
> vmemmap_pgtable_init()
> vmemmap_pgtable_deposit()
> vmemmap_pgtable_withdraw()
> and simply use the list manipulation routines.
> 
> To me, that looks simpler than the proposed code in this patch.
> 
