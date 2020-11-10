Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E362AE0C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgKJUdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 15:33:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJUdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:33:37 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKJm5L005825;
        Tue, 10 Nov 2020 20:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RT7z64OT2cF0627d3gcxVXgoifV1/qIO4IvouGljyV8=;
 b=ODHXo3gAY+hpzv3UOFyKd3WyR5o8AFJ8VSx2gWvhAvNL2+luZ6TLfSVQG9jLxjKOp8CF
 clpSSBNjYh0lms8yufqfoWlkCyhokg2iYz53m3/n7+7pDUaMyopS24GLg1aruuQD4QtR
 6Fg9gAr5rCXBFQo+c702nDjGwPS55IP5H8Lb2FJp3khPCcacNpDEcRsmWRJaJIAiK2C0
 nFESfPJ721kbXF2gWrxr5RWv4XAwma1lZwM3JDX0S/Ci22r4sXcGEFsPPDBriaLlfOqD
 OakRBX6TgA25Zx/eR2PiIzkALF0eHMv/QwXJynB7mtSCO5GN1QYRWJi+s1+tdMmtrNHV WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34nkhkwqhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 20:32:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKKBBa104831;
        Tue, 10 Nov 2020 20:30:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gxfsjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 20:30:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AAKUpEX003358;
        Tue, 10 Nov 2020 20:30:51 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 12:30:51 -0800
Subject: Re: [PATCH v3 03/21] mm/hugetlb: Introduce a new config
 HUGETLB_PAGE_FREE_VMEMMAP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20201108141113.65450-1-songmuchun@bytedance.com>
 <20201108141113.65450-4-songmuchun@bytedance.com>
 <20201109135215.GA4778@localhost.localdomain>
 <ef564084-ea73-d579-9251-ec0440df2b48@oracle.com>
 <20201110195025.GN17076@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2aec4539-a55d-4df3-7753-75a33250b6b8@oracle.com>
Date:   Tue, 10 Nov 2020 12:30:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201110195025.GN17076@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=2 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100138
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/10/20 11:50 AM, Matthew Wilcox wrote:
> On Tue, Nov 10, 2020 at 11:31:31AM -0800, Mike Kravetz wrote:
>> On 11/9/20 5:52 AM, Oscar Salvador wrote:
>>> On Sun, Nov 08, 2020 at 10:10:55PM +0800, Muchun Song wrote:
> 
> I don't like config options.  I like boot options even less.  I don't
> know how to describe to an end-user whether they should select this
> or not.  Is there a way to make this not a tradeoff?  Or make the
> tradeoff so minimal as to be not worth describing?  (do we have numbers
> for the worst possible situation when enabling this option?)

It is not exactly worst case, but Muchun provided some simple benchmarking
results in the cover letter.  Quick summary is that hugetlb page creation
and free time is "~2x slower".  At first glance, one would say that is
terrible.  However, remember that the majority of use cases create hugetlb
pages at or shortly after boot time and add them to the pool.  So, additional
overhead is at pool creation time.  There is no change to 'normal run time'
operations of getting a page from or returning a page to the pool (think
page fault/unmap).

> I haven't read through these patches in detail, so maybe we do this
> already, but when we free the pages to the buddy allocator, do we retain
> the third page to use for the PTEs (and free pages 3-7), or do we allocate
> a separate page for the PTES and free pages 2-7?

I haven't got there in this latest series.  But, in previous revisions the
code did allocate a separate page.
-- 
Mike Kravetz
