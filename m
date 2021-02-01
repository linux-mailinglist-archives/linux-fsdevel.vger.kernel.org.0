Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA330B267
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 22:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBAV5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 16:57:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35158 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhBAV5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:57:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111Lhe1d010539;
        Mon, 1 Feb 2021 21:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nrB0BDQrm9Y7qegX3IoXuQO4TNIMzndqSgItjadNh+c=;
 b=LcH1DSJtRqbrjo4Y2Y0I/htfoTE6yTk17JFWwpFmNgC9EvLS5Ai4ugNKEgr8KdR9Jmzc
 BwgeY6qAJlOP8SBzQqU0ustwoC4k5tX8MuwWL2+/d3WpIT4qBef/+UCSyDP4LZ4eJBkE
 2r1J8J1Tf1vuziwGkHvH9rLiUirCJ712DO6SGBLjfCu1NkyK+8a0yL9Hd97Q1uoaPOre
 REyPbe5t3ecsswYoNvnUYp3UTQoQ2cZ+8fhR73r1zh7TLhZRW/L/fnKJus9g2KBGt1+0
 PR6MymW9wCx+EDXAIZtaURoWlZfMZhvW1KeMYmDlcMdXeCffdcPLIJI5F1XWVkzfLd+Y PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyar077-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 21:55:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111LitZs036311;
        Mon, 1 Feb 2021 21:53:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 36dhbx8ya9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 21:53:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 111LrH19001686;
        Mon, 1 Feb 2021 21:53:17 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Feb 2021 13:53:17 -0800
Subject: Re: [PATCH v4 1/9] hugetlb: Pass vma into huge_pte_alloc()
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210128224819.2651899-2-axelrasmussen@google.com>
 <20210128234242.2677079-1-axelrasmussen@google.com>
 <67fc15f3-3182-206b-451b-1622f6657092@oracle.com>
Message-ID: <f1afa616-c4f5-daaa-6865-8bbc3c93b71a@oracle.com>
Date:   Mon, 1 Feb 2021 13:53:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <67fc15f3-3182-206b-451b-1622f6657092@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/1/21 1:38 PM, Mike Kravetz wrote:
> On 1/28/21 3:42 PM, Axel Rasmussen wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> It is a preparation work to be able to behave differently in the per
>> architecture huge_pte_alloc() according to different VMA attributes.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> [axelrasmussen@google.com: fixed typo in arch/mips/mm/hugetlbpage.c]
>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> ---
>>  arch/arm64/mm/hugetlbpage.c   | 2 +-
>>  arch/ia64/mm/hugetlbpage.c    | 3 ++-
>>  arch/mips/mm/hugetlbpage.c    | 4 ++--
>>  arch/parisc/mm/hugetlbpage.c  | 2 +-
>>  arch/powerpc/mm/hugetlbpage.c | 3 ++-
>>  arch/s390/mm/hugetlbpage.c    | 2 +-
>>  arch/sh/mm/hugetlbpage.c      | 2 +-
>>  arch/sparc/mm/hugetlbpage.c   | 2 +-
>>  include/linux/hugetlb.h       | 2 +-
>>  mm/hugetlb.c                  | 6 +++---
>>  mm/userfaultfd.c              | 2 +-
>>  11 files changed, 16 insertions(+), 14 deletions(-)
> 
> Sorry for the delay in reviewing.
> 
> huge_pmd_share() will do a find_vma() to get the vma.  So, it would be
> 'possible' to not add an extra argument to huge_pmd_alloc() and simply
> do the uffd_disable_huge_pmd_share() check inside vma_shareable.  This
> would reduce the amount of modified code, but would not be as efficient.
> I prefer passing the vma argument as is done here.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>


Another thought.

We should pass the vma to huge_pmd_share to avoid the find_vma.

-- 
Mike Kravetz
