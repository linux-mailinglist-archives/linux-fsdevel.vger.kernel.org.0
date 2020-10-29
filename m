Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523BD29F750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 23:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJ2WAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 18:00:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50690 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:00:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLmgbf077581;
        Thu, 29 Oct 2020 22:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XWdcZ+Pbn49CLGGJqAYpuz7TYLachaVcKO2a3xTTLpM=;
 b=tAGyw8A2JcHD1uhixpy/d2ZbaUBwuIOnnuWgRg1IgyPDRCvkwoZCamcVk+PGibSoO0Sp
 f8gv+WfwrWpc7DTnEf/i53ZKBEIMgs1EdWausomCm8Eat3W74fqIpdvnCf3m9l4GQLP3
 3BIQ+QjJUmOW2sTURvQcOnJp3mbvJwrNN45R/PDjMvVXEGQMS9AeP2ND+lmOG7QzHEq7
 5CZ9LhuX5lAvfGD56QP+vPVgTwLFijTFlkopFa7RvwJNBYroRlgbyAU77sNWEiSnUe/q
 s5BpbF/rth65WH8I4JSo5/WTUo2YyMDlmWu/LS17giAJ4JlJ3XQ0nNMR2glCnJMwQvy3 TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34dgm4cv0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 22:00:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TLiXke085642;
        Thu, 29 Oct 2020 21:59:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34cwuq98t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 21:59:59 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TLxpcG020021;
        Thu, 29 Oct 2020 21:59:52 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 14:59:49 -0700
Subject: Re: [External] Re: [PATCH v2 07/19] mm/hugetlb: Free the vmemmap
 pages associated with each hugetlb page
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
 <20201026145114.59424-8-songmuchun@bytedance.com>
 <8658f431-56c4-9774-861a-9c3b54d1910a@oracle.com>
 <CAMZfGtUUkkkeENXOOLPacverqyudxntTenMKrtpfHnLOBJaX5Q@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <21ea37f2-38ca-ce5f-6039-0ee388092f1d@oracle.com>
Date:   Thu, 29 Oct 2020 14:59:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUUkkkeENXOOLPacverqyudxntTenMKrtpfHnLOBJaX5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290150
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/28/20 11:13 PM, Muchun Song wrote:
> On Thu, Oct 29, 2020 at 7:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 10/26/20 7:51 AM, Muchun Song wrote:
>>> +
>>> +static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
>>> +{
>>> +     static DEFINE_SPINLOCK(pgtable_lock);
>>> +
>>> +     return &pgtable_lock;
>>> +}
>>
>> This is just a global lock.  Correct?  And hugetlb specific?
> 
> Yes, it is a global lock. Originally, I wanted to use the pmd lock(e.g.
> pmd_lockptr()). But we need to allocate memory for the spinlock and
> initialize it when ALLOC_SPLIT_PTLOCKS. It may increase the
> complexity.
> 
> And I think that here alloc/free hugetlb pages is not a frequent operation.
> So I finally use a global lock. Maybe it is enough.
> 
>>
>> It should be OK as the page table entries for huegtlb pages will not
>> overlap with other entries.
> 
> Does "hugetlb specific" mean the pmd lock? or per hugetlb lock?
> If it is pmd lock, this is fine to me. If not, it may not be enough.
> Because the lock also guards the splitting of pmd pgtable.

By "hugetlb specific", I was trying to say that only hugetlb code would
use this lock.  It is not a concern now.  However, there has been talk
about other code doing something similar to remove struct pages.  If that
ever happens then we will need a different locking scheme.

Disregard my statement about there being no overlap.  I was confusing
page tables for huge pages with page tables for mappings mmap entries
of huge pages.
-- 
Mike Kravetz
