Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68B12ADF38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKJTYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 14:24:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJTYe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:24:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJDvZS057934;
        Tue, 10 Nov 2020 19:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hskX2IMa6OLM+WYtFTf4ZdQp9KepgaAyhRXkCDxO6/w=;
 b=z73iRLJWpn/4KDkrExD6ueb2jXSTe7lyxqeEsa+gpXkDBBENBoYlU09w2Uw8/qUIRTeW
 1qmQV+hiteHHzgINWVCwqBaXrD50uVgSRqTuuQ7dNOlFqScO5tBFr+TmHCNT/VJc63Nd
 Q4GTU77nXJNAfvgst2wzp23trVTIwJkHXp9VJdVIrDJgJl2VYGJ8Mj7S9SKTvXu27Y+O
 DEXnZS/9rjvpeVCj9n6QhpICA37lgmK3wvRu1Pj1JROHlPWE+FJkOlTg2jt//slgg3mZ
 6jSD0ciHzSr96eJ7oZBBAvZj3j3BOHv22hAsZTJGHICpnb6eOKIEyCO/FwxlytjBeO6x OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhkwe22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 19:23:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAJF5Q1174773;
        Tue, 10 Nov 2020 19:23:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34qgp7a0rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 19:23:38 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AAJNVjR000816;
        Tue, 10 Nov 2020 19:23:31 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 11:23:31 -0800
Subject: Re: [PATCH v3 00/21] Free some vmemmap pages of hugetlb page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20201108141113.65450-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <78b4cb8b-6511-d50e-7018-ea52c50e4b07@oracle.com>
Date:   Tue, 10 Nov 2020 11:23:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=2 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=2 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100131
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Thanks for continuing to work this Muchun!

On 11/8/20 6:10 AM, Muchun Song wrote:
...
> For tail pages, the value of compound_head is the same. So we can reuse
> first page of tail page structs. We map the virtual addresses of the
> remaining 6 pages of tail page structs to the first tail page struct,
> and then free these 6 pages. Therefore, we need to reserve at least 2
> pages as vmemmap areas.
> 
> When a hugetlbpage is freed to the buddy system, we should allocate six
> pages for vmemmap pages and restore the previous mapping relationship.
> 
> If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
> substantial gain.

Is that 4095 number accurate?  Are we not using two pages of struct pages
as in the 2MB case?

Also, because we are splitting the huge page mappings in the vmemmap
additional PTE pages will need to be allocated.  Therefore, some additional
page table pages may need to be allocated so that we can free the pages
of struct pages.  The net savings may be less than what is stated above.

Perhaps this should mention that allocation of additional page table pages
may be required?

...
> Because there are vmemmap page tables reconstruction on the freeing/allocating
> path, it increases some overhead. Here are some overhead analysis.
> 
> 1) Allocating 10240 2MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.166s
>    user     0m0.000s
>    sys      0m0.166s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [8K, 16K)           8360 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [16K, 32K)          1868 |@@@@@@@@@@@                                         |
>    [32K, 64K)            10 |                                                    |
>    [64K, 128K)            2 |                                                    |
> 
>    b) Without this patch series:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.066s
>    user     0m0.000s
>    sys      0m0.066s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)           10176 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)             62 |                                                    |
>    [16K, 32K)             2 |                                                    |
> 
>    Summarize: this feature is about ~2x slower than before.
> 
> 2) Freeing 10240 @MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.004s
>    user     0m0.000s
>    sys      0m0.002s
> 
>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [16K, 32K)         10240 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> 
>    b) Without this patch series:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.077s
>    user     0m0.001s
>    sys      0m0.075s
> 
>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)            9950 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)            287 |@                                                   |
>    [16K, 32K)             3 |                                                    |
> 
>    Summarize: The overhead of __free_hugepage is about ~2-4x slower than before.
>               But according to the allocation test above, I think that here is
> 	      also ~2x slower than before.
> 
>               But why the 'real' time of patched is smaller than before? Because
> 	      In this patch series, the freeing hugetlb is asynchronous(through
> 	      kwoker).
> 
> Although the overhead has increased. But the overhead is not on the
> allocating/freeing of each hugetlb page, it is only once when we reserve
> some hugetlb pages through /proc/sys/vm/nr_hugepages. Once the reservation
> is successful, the subsequent allocating, freeing and using are the same
> as before (not patched). So I think that the overhead is acceptable.

Thank you for benchmarking.  There are still some instances where huge pages
are allocated 'on the fly' instead of being pulled from the pool.  Michal
pointed out the case of page migration.  It is also possible for someone to
use hugetlbfs without pre-allocating huge pages to the pool.  I remember the
use case pointed out in commit 099730d67417.  It says, "I have a hugetlbfs
user which is never explicitly allocating huge pages with 'nr_hugepages'.
They only set 'nr_overcommit_hugepages' and then let the pages be allocated
from the buddy allocator at fault time."  In this case, I suspect they were
using 'page fault' allocation for initialization much like someone using
/proc/sys/vm/nr_hugepages.  So, the overhead may not be as noticeable.

-- 
Mike Kravetz
