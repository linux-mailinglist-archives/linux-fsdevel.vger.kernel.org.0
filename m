Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13652DC945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 23:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgLPWxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 17:53:09 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbgLPWxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:53:07 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMnwJl082082;
        Wed, 16 Dec 2020 22:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GWzfUJIU936fkGAX1MiiiDp/YR1yirB8QOBvoZtTBBk=;
 b=dSY3YZuNxSjZi3z5/7a8Jh1pLGdp8Chp+wAXG5EJLzjWD3Ptn8q96F2v50DN8jNyWFrw
 2KRG5b21NK4g6KXCs/mpjGUriJt1z46DuXFoozsyqJEE9lv4cesPuNIOTLa8Grwp4vJi
 tbx3N8vYeBsj86AUsq+IN7fy40Eo7ruGsWYhdK+FR5UZ5+KtIcNmjVOfE5uJGKzS/1jR
 VrkEuV3vp92CtJns7Lo0cnscysFXPPqQL2oNQvi2FiReuskxmBmioOW9mFWipJYB9KJ4
 OIcO1hf7RhFUn3/AW4KbQzcTbcBOZfdjcx34MopbTKo9M2XIMfBwEd252XgGxrz2DKB+ qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35cntmas5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 22:51:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BGMjHZW062482;
        Wed, 16 Dec 2020 22:49:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35d7eq52x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 22:49:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BGMndJP001074;
        Wed, 16 Dec 2020 22:49:39 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 14:49:38 -0800
Subject: Re: [PATCH v9 03/11] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20201213154534.54826-1-songmuchun@bytedance.com>
 <20201213154534.54826-4-songmuchun@bytedance.com>
 <5936a766-505a-eab0-42a6-59aab2585880@oracle.com>
 <20201216222549.GC3207@localhost.localdomain>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <49f6a0f1-c6fa-4642-2db0-69f090e8a392@oracle.com>
Date:   Wed, 16 Dec 2020 14:49:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201216222549.GC3207@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9837 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160142
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/16/20 2:25 PM, Oscar Salvador wrote:
> On Wed, Dec 16, 2020 at 02:08:30PM -0800, Mike Kravetz wrote:
>>> + * vmemmap_rmap_walk - walk vmemmap page table
>>> +
>>> +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>>> +			      unsigned long end, struct vmemmap_rmap_walk *walk)
>>> +{
>>> +	pte_t *pte;
>>> +
>>> +	pte = pte_offset_kernel(pmd, addr);
>>> +	do {
>>> +		BUG_ON(pte_none(*pte));
>>> +
>>> +		if (!walk->reuse)
>>> +			walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
>>
>> It may be just me, but I don't like the pte[-1] here.  It certainly does work
>> as designed because we want to remap all pages in the range to the page before
>> the range (at offset -1).  But, we do not really validate this 'reuse' page.
>> There is the BUG_ON(pte_none(*pte)) as a sanity check, but we do nothing similar
>> for pte[-1].  Based on the usage for HugeTLB pages, we can be confident that
>> pte[-1] is actually a pte.  In discussions with Oscar, you mentioned another
>> possible use for these routines.
> 
> Without giving it much of a thought, I guess we could duplicate the
> BUG_ON for the pte outside the loop, and add a new one for pte[-1].
> Also, since walk->reuse seems to not change once it is set, we can take
> it outside the loop? e.g:
> 
> 	pte *pte;
> 
> 	pte = pte_offset_kernel(pmd, addr);
> 	BUG_ON(pte_none(*pte));
> 	BUG_ON(pte_none(pte[VMEMMAP_TAIL_PAGE_REUSE]));
> 	walk->reuse = pte_page(pte[VMEMMAP_TAIL_PAGE_REUSE]);
> 	do {
> 		....
> 	} while...
> 
> Or I am not sure whether we want to keep it inside the loop in case
> future cases change walk->reuse during the operation.
> But to be honest, I do not think it is realistic of all future possible
> uses of this, so I would rather keep it simple for now.

I was thinking about possibly passing the 'reuse' address as another parameter
to vmemmap_remap_reuse().  We could add this addr to the vmemmap_rmap_walk
struct and set walk->reuse when we get to the pte for that address.  Of
course this would imply that the addr would need to be part of the range.

Ideally, we would walk the page table to get to the reuse page.  My concern
was not explicitly about adding the BUG_ON.  In more general use, *pte could
be the first entry on a pte page.  And, then pte[-1] may not even be a pte.

Again, I don't think this matters for the current HugeTLB use case.  Just a
little concerned if code is put to use for other purposes.
-- 
Mike Kravetz
