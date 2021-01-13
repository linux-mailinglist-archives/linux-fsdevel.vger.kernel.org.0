Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318DF2F56E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 02:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbhANBzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 20:55:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49158 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbhAMXyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:54:24 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DNKDqt129605;
        Wed, 13 Jan 2021 23:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8nhKPkft+xGSN2PyfovUj+WldoTS6Xrgzrpgzt8e86w=;
 b=v7VHxdffCnMUVJhbIDNMJ1Qfr5ZAv7MJdvUqMKSTY+fc5MnCU2qmENSBaH8P4invXRwW
 CjIeWdV+IZ19P8Yx/8a+NO9hRB9DQQZRjQFBn2fsKrcf068dC0C204nl2J69hC/DpG5m
 btY56Kg9qqZp5c7bVJKfehNq6b8PkiJiQZ27EnraZnXgsmPRU3cLgL6VH2kNH/baSBXf
 pUW/+fOVRL+Z/+/P7sXoz3ETcHTEAKbSCWt/PH0fQLKLaAgQD2Cx7bpwlqcNqRRJKOQA
 fZT710NseYt6navd9ZlhGqNV0SUVFZo1UCHLye1wpHjSeRQJliDze4X0uDH+/bI2mZVW XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcyx1v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 23:27:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DNKBki145808;
        Wed, 13 Jan 2021 23:27:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 360kf1dy53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 23:27:39 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10DNRZCb002460;
        Wed, 13 Jan 2021 23:27:35 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 15:27:34 -0800
Subject: Re: [External] Re: [PATCH v12 04/13] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>
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
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-5-songmuchun@bytedance.com>
 <20210112080453.GA10895@linux>
 <CAMZfGtUqN2BZH28i9VJhRJ3VH3OGKBQ7hDUuX1-F5LcwbKk+4A@mail.gmail.com>
 <20210113092028.GB24816@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a9baf18c-22c7-4946-9778-678f6bc808dc@oracle.com>
Date:   Wed, 13 Jan 2021 15:27:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210113092028.GB24816@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130141
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/13/21 1:20 AM, Oscar Salvador wrote:
> On Tue, Jan 12, 2021 at 07:33:33PM +0800, Muchun Song wrote:
>>> It seems a bit odd to only pass "start" for the BUG_ON.
>>> Also, I kind of dislike the "addr += PAGE_SIZE" in vmemmap_pte_range.
>>>
>>> I wonder if adding a ".remap_start_addr" would make more sense.
>>> And adding it here with the vmemmap_remap_walk init.
>>
>> How about introducing a new function which aims to get the reuse
>> page? In this case, we can drop the BUG_ON() and "addr += PAGE_SIZE"
>> which is in vmemmap_pte_range. The vmemmap_remap_range only
>> does the remapping.
> 
> How would that look? 
> It might be good, dunno, but the point is, we should try to make the rules as
> simple as possible, dropping weird assumptions.
> 
> Callers of vmemmap_remap_free should know three things:
> 
> - Range to be remapped
> - Addr to remap to
> - Current implemantion needs addr to be remap to to be part of the complete
>   range
> 
> right?

And, current implementation needs must have remap addr be the first in the
complete range.  This is just because of the way the page tables are walked
for remapping.  The remap/reuse page must be found first so that the following
pages can be remapped to it.

That implementation seems to be the 'most efficient' for hugetlb pages where
we want vmemmap pages n+3 and beyond mapped to n+2.

In a more general purpose vmemmap_remap_free implementation, the reuse/remap
address would not necessarily need to be related to the range.  However, this
would require a separate page table walk/validation for the reuse address
independent of the range.  This may be what Muchun was proposing for 'a new
function which aims to get the reuse page'.

IMO, the decision on how to implement depends on the intended use case.
- If this is going to be hugetlb only (or perhaps generic huge page only)
  functionality, then I am OK with an efficient implementation that has
  some restrictions.
- If we see this being used for more general purpose remapping, then we
  should go with a more general purpose implementation.

Again, just my opinion.
-- 
Mike Kravetz
