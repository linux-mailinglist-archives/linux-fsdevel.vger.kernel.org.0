Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6540A2869F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 23:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgJGVPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 17:15:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgJGVPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:15:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097L9wBI146673;
        Wed, 7 Oct 2020 21:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JPMWL4bTVnMXu+B6HCp8FDYPYl29laP2NiOsFFNS9QQ=;
 b=WGXPcwhBqra3r34fdmj2xTjTiiUtavQUyyv8t5oMMOoUDEPyghSyV6iBb+d3ispKtFmx
 MPzuM3HiJ0a1msA4SRyTRdNZV7rxFJjTF5m+EHxhobYPQipTTOsAxe517iy99bs/v6Ox
 2qlG49kEYwgIxRMtjrk7as3Adn7WyGVZ0Nq/ILuLmXEZ4dep0rIEP8QLt2yC+R/ALhEj
 q2uR53OjmSm7N9A3eEIKUXXprTkvxqARVAkAQPzKOGd8Kqcv5rOgzMmnqGYkQP/RXQh2
 Ai56OmPwrqCYkZAALrEzGOYS/oBK8XmoXV2djklH7arEv10e5HqFkwaYjV8jqeWDRgbA hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33ym34sgtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 21:15:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097LBKZG037135;
        Wed, 7 Oct 2020 21:13:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33y2vq0gpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 21:13:01 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 097LCnQm031393;
        Wed, 7 Oct 2020 21:12:49 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 14:12:49 -0700
Subject: Re: [RFC PATCH 00/24] mm/hugetlb: Free some vmemmap pages of hugetlb
 page
From:   Mike Kravetz <mike.kravetz@oracle.com>
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
 <31eac1d8-69ba-ed2f-8e47-d957d6bb908c@oracle.com>
Message-ID: <9d220de0-f06d-cb5b-363f-6ae97d5b4146@oracle.com>
Date:   Wed, 7 Oct 2020 14:12:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <31eac1d8-69ba-ed2f-8e47-d957d6bb908c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=2 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=2 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070137
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/20 2:58 PM, Mike Kravetz wrote:
> On 9/15/20 5:59 AM, Muchun Song wrote:
>> Hi all,
>>
>> This patch series will free some vmemmap pages(struct page structures)
>> associated with each hugetlbpage when preallocated to save memory.
> ...
>> The mapping of the first page(index 0) and the second page(index 1) is
>> unchanged. The remaining 6 pages are all mapped to the same page(index
>> 1). So we only need 2 pages for vmemmap area and free 6 pages to the
>> buddy system to save memory. Why we can do this? Because the content
>> of the remaining 7 pages are usually same except the first page.
>>
>> When a hugetlbpage is freed to the buddy system, we should allocate 6
>> pages for vmemmap pages and restore the previous mapping relationship.
>>
>> If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
>> substantial gain. On our server, run some SPDK applications which will
>> use 300GB hugetlbpage. With this feature enabled, we can save 4797MB
>> memory.

I had a hard time going through the patch series as it is currently
structured, and instead examined all the code together.  Muchun put in
much effort and the code does reduce memory usage.
- For 2MB hugetlb pages, we save 5 pages of struct pages
- For 1GB hugetlb pages, we save 4086 pages of struct pages

Code is even in pace to handle poisoned pages, although I have not looked
at this closely.  The code survives the libhugetlbfs and ltp huge page tests.

To date, nobody has asked the important question "Is the added complexity
worth the memory savings?".  I suppose it all depends on one's use case.
Obviously, the savings are more significant when one uses 1G huge pages but
that may not be the common case today.

> At a high level this seems like a reasonable optimization for hugetlb
> pages.  It is possible because hugetlb pages are 'special' and mostly
> handled differently than pages in normal mm paths.

Such an optimization only makes sense for something like hugetlb pages.  One
reason is the 'special' nature of hugetlbfs as stated above.  The other is
that this optimization mostly makes sense for huge pages that are created
once and stick around for a long time.  hugetlb pool pages are a perfect
example.  This is because manipulation of struct page mappings is done when
a huge page is created or destroyed.

> The majority of the new code is hugetlb specific, so it should not be
> of too much concern for the general mm code paths.

It is true that much of the code in this series was put in hugetlb.c.  However,
I would argue that there is a bunch of code that only deals with remapping
the memmap which should more generic and added to sparse-vmemmap.c.  This
would at least allow for easier reuse.

Before Muchun and myself put more effort into this series, I would really
like to get feedback on the whether or not this should move forward.
Specifically, is the memory savings worth added complexity?  Is the removing
of struct pages going to come back and cause issues for future features?
-- 
Mike Kravetz
