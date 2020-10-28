Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C203129DB36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 00:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgJ1XpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 19:45:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35284 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgJ1Xow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:44:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SNaDvZ096206;
        Wed, 28 Oct 2020 23:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/1wXhSK1jawzXDWDiFn4sD8tOMsMcHZuwRWttfEpsBo=;
 b=ujVTdN3aiA8l72vkEvBqXJykL6YBnFEbP3iBuB+HsFwFVzcgAGCImhQty8poCRjD3EIH
 5xFGOhihKgUnWcCjl+zTsnsnp6amXl3XFrbCxRZ+CoJYIdIVVo3S5RT6hDoenWyVyMwg
 ZHbkw5sYK4JMRKwl4iL+pviAEuWU+hcpFs+p23pocEtylwG4tg/NgXDNbXsc7vG1g402
 N/Ce6Bw77owwFFo0Ny2+vdjRO3B+qLeaoJaf5fgeks2dC7KmEJyiu4XD624ARPz4eF3k
 /2ygaiUnxd8+rVRsMb0FsiLNQMfwb9urmySe8sDphsYYEDwa3DGnsTD4kuoWxX19KjR7 Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm47tm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 23:44:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SNe76g041534;
        Wed, 28 Oct 2020 23:42:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34cx5ywkq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 23:42:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SNgGbb012295;
        Wed, 28 Oct 2020 23:42:16 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 16:42:15 -0700
Subject: Re: [External] Re: [PATCH v2 05/19] mm/hugetlb: Introduce pgtable
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
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
 <20201026145114.59424-6-songmuchun@bytedance.com>
 <81a7a7f0-fe0e-42e4-8de0-9092b033addc@oracle.com>
 <CAMZfGtVV5eZS-LFtU89WSdMGCib8WX0AojkL-4X+_5yvuMz2Ew@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d3e4cc32-ce07-4ce2-789a-3c1df093c270@oracle.com>
Date:   Wed, 28 Oct 2020 16:42:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtVV5eZS-LFtU89WSdMGCib8WX0AojkL-4X+_5yvuMz2Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=2 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280146
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/28/20 12:26 AM, Muchun Song wrote:
> On Wed, Oct 28, 2020 at 8:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> On 10/26/20 7:51 AM, Muchun Song wrote:
>>
>> I see the following routines follow the pattern for vmemmap manipulation
>> in dax.
> 
> Did you mean move those functions to mm/sparse-vmemmap.c?

No.  Sorry, that was mostly a not to myself.

>>> +static void vmemmap_pgtable_deposit(struct page *page, pte_t *pte_p)
>>> +{
>>> +     pgtable_t pgtable = virt_to_page(pte_p);
>>> +
>>> +     /* FIFO */
>>> +     if (!page_huge_pte(page))
>>> +             INIT_LIST_HEAD(&pgtable->lru);
>>> +     else
>>> +             list_add(&pgtable->lru, &page_huge_pte(page)->lru);
>>> +     page_huge_pte(page) = pgtable;
>>> +}
>>> +
>>> +static pte_t *vmemmap_pgtable_withdraw(struct page *page)
>>> +{
>>> +     pgtable_t pgtable;
>>> +
>>> +     /* FIFO */
>>> +     pgtable = page_huge_pte(page);
>>> +     if (unlikely(!pgtable))
>>> +             return NULL;
>>> +     page_huge_pte(page) = list_first_entry_or_null(&pgtable->lru,
>>> +                                                    struct page, lru);
>>> +     if (page_huge_pte(page))
>>> +             list_del(&pgtable->lru);
>>> +     return page_to_virt(pgtable);
>>> +}
>>> +
...
>>> @@ -1783,6 +1892,14 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
>>>       if (!page)
>>>               return NULL;
>>>
>>> +     if (vmemmap_pgtable_prealloc(h, page)) {
>>> +             if (hstate_is_gigantic(h))
>>> +                     free_gigantic_page(page, huge_page_order(h));
>>> +             else
>>> +                     put_page(page);
>>> +             return NULL;
>>> +     }
>>> +
>>
>> It seems a bit strange that we will fail a huge page allocation if
>> vmemmap_pgtable_prealloc fails.  Not sure, but it almost seems like we shold
>> allow the allocation and log a warning?  It is somewhat unfortunate that
>> we need to allocate a page to free pages.
> 
> Yeah, it seems unfortunate. But if we allocate success, we can free some
> vmemmap pages later. Like a compromise :) . If we can successfully allocate
> a huge page, I also prefer to be able to successfully allocate another one page.
> If we allow the allocation when vmemmap_pgtable_prealloc fails, we also
> need to mark this page that vmemmap has not been released. Seems
> increase complexity.

Yes, I think it is better to leave code as it is and avoid complexity.

-- 
Mike Kravetz
