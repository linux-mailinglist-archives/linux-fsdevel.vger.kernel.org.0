Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3402B9E26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 00:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKSXYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 18:24:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgKSXYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:24:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNJi8S109296;
        Thu, 19 Nov 2020 23:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GfpuRBjcGPdXLBnfKyBS75dHIdLZ8ysgivpC94EPeoo=;
 b=oAErOylkGBKb/WjMroHHPzf3cqVSD59FmuTWCdrVLMC7TB9PEopmMWYRvj+99daHeS/H
 QRrFAhHP1UUogJEHyqZ7joTr3cGYY+nkBAR/gc+c4arMXrnpSUN8VFkz0D95vWKYWp20
 E2T/X0oYGBaTFd9S5Y6exzJcgLL/fJ7z4g9ZTEMEhrnZGVU/XP2N3+PDLbdQl4H6fp94
 wbuRBPZwrXcVDrY2IfxXEoj8QFT077A7iWb04AvKcOwNZt1zjZTcbVTuEKccbTbhGgrY
 cs0yK0FACAXctJZEucQ0jzwfEbwckygRctQggaxOtdbzCaQgINgiQj30CyTNK0nVr56t gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vng6m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 23:21:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJNJax9156353;
        Thu, 19 Nov 2020 23:21:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ts0uew3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 23:21:52 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AJNLaVH011344;
        Thu, 19 Nov 2020 23:21:36 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 15:21:35 -0800
Subject: Re: [External] Re: [PATCH v4 05/21] mm/hugetlb: Introduce pgtable
 allocation/freeing helpers
To:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>
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
        Michal Hocko <mhocko@suse.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-6-songmuchun@bytedance.com>
 <20201117150604.GA15679@linux>
 <CAMZfGtW=Oyaoooow9_i+R1LkvGpcFoUjBxYzGqBZsOa-t-sFsg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <44efc25e-525b-9e51-60e4-da20deb25ded@oracle.com>
Date:   Thu, 19 Nov 2020 15:21:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtW=Oyaoooow9_i+R1LkvGpcFoUjBxYzGqBZsOa-t-sFsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=2 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190160
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 10:17 PM, Muchun Song wrote:
> On Tue, Nov 17, 2020 at 11:06 PM Oscar Salvador <osalvador@suse.de> wrote:
>>
>> On Fri, Nov 13, 2020 at 06:59:36PM +0800, Muchun Song wrote:
>>> +#define page_huge_pte(page)          ((page)->pmd_huge_pte)
>>
>> Seems you do not need this one anymore.
>>
>>> +void vmemmap_pgtable_free(struct page *page)
>>> +{
>>> +     struct page *pte_page, *t_page;
>>> +
>>> +     list_for_each_entry_safe(pte_page, t_page, &page->lru, lru) {
>>> +             list_del(&pte_page->lru);
>>> +             pte_free_kernel(&init_mm, page_to_virt(pte_page));
>>> +     }
>>> +}
>>> +
>>> +int vmemmap_pgtable_prealloc(struct hstate *h, struct page *page)
>>> +{
>>> +     unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
>>> +
>>> +     /* Store preallocated pages on huge page lru list */
>>> +     INIT_LIST_HEAD(&page->lru);
>>> +
>>> +     while (nr--) {
>>> +             pte_t *pte_p;
>>> +
>>> +             pte_p = pte_alloc_one_kernel(&init_mm);
>>> +             if (!pte_p)
>>> +                     goto out;
>>> +             list_add(&virt_to_page(pte_p)->lru, &page->lru);
>>> +     }
>>
>> Definetely this looks better and easier to handle.
>> Btw, did you explore Matthew's hint about instead of allocating a new page,
>> using one of the ones you are going to free to store the ptes?
>> I am not sure whether it is feasible at all though.
> 
> Hi Oscar and Matthew,
> 
> I have started an investigation about this. Finally, I think that it
> may not be feasible. If we use a vmemmap page frame as a
> page table when we split the PMD table firstly, in this stage,
> we need to set 512 pte entry to the vmemmap page frame. If
> someone reads the tail struct page struct of the HugeTLB,
> it can get the arbitrary value (I am not sure it actually exists,
> maybe the memory compaction module can do this). So on
> the safe side, I think that allocating a new page is a good
> choice.

Thanks for looking into this.

If I understand correctly, the issue is that you need the pte page to set
up the new mappings.  In your current code, this is done before removing
the pages of struct pages.  This keeps everything 'consistent' as things
are remapped.

If you want to use one of the 'pages of struct pages' for the new pte
page, then there will be a period of time when things are inconsistent.
Before setting up the mapping, some code could potentially access that
pages of struct pages.

I tend to agree that allocating allocating a new page is the safest thing
to do here.  Or, perhaps someone can think of a way make this safe.
-- 
Mike Kravetz
