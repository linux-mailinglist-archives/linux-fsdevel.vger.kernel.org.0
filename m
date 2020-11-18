Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081672B88C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 00:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKRXuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 18:50:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgKRXuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:50:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AINYHOq061811;
        Wed, 18 Nov 2020 23:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uRHTvOodH1mIHk5g2WkcEMXXolC1TDvf8JtI5v8vUTc=;
 b=IkJ/nguKxMKhJRll0ykO01eIJqDprV4JkQ+qzy+I6A4e6Q7BEMr9nqN8gT/Za9sQa5P6
 zud2dqQT0dR6ZcDewo1tBke+6JFZyyOTjCXpEJogmnurq3JW1Q9QT/5KwMySNBUHvlvP
 Pb7Ob5H+jUMlee/ElKsFnZTXOnr1HUauXR9MRrKcUA4mh0HyPcoxNf/3LQ4LuT7pHH4q
 eMIlq0tc3JJiC6ozapJe9Q5nJnY1fkHVvj2syVC7v/VsjsD0F5ySYu6An/KfQ1Bumz37
 o8rq+w05bUDv4bPZGyRkUo91XFTZSTTu0WjQ0ji3NA7zubIf9brX7jKHv8kYCr7xhxr8 oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vnas0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 23:48:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AINZWUJ182125;
        Wed, 18 Nov 2020 23:48:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ts0syvne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 23:48:31 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AINmOJD005166;
        Wed, 18 Nov 2020 23:48:25 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 15:48:24 -0800
Subject: Re: [PATCH v4 04/21] mm/hugetlb: Introduce nr_free_vmemmap_pages in
 the struct hstate
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
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <88af8545-14b7-08de-f121-e12295d5d5b9@oracle.com>
Date:   Wed, 18 Nov 2020 15:48:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20201113105952.11638-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=2 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180163
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/13/20 2:59 AM, Muchun Song wrote:
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> new file mode 100644
> index 000000000000..a6c9948302e2
> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Free some vmemmap pages of HugeTLB
> + *
> + * Copyright (c) 2020, Bytedance. All rights reserved.
> + *
> + *     Author: Muchun Song <songmuchun@bytedance.com>
> + *

Oscar has already made some suggestions to change comments.  I would suggest
changing the below text to something like the following.

> + * Nowadays we track the status of physical page frames using struct page
> + * structures arranged in one or more arrays. And here exists one-to-one
> + * mapping between the physical page frame and the corresponding struct page
> + * structure.
> + *
> + * The HugeTLB support is built on top of multiple page size support that
> + * is provided by most modern architectures. For example, x86 CPUs normally
> + * support 4K and 2M (1G if architecturally supported) page sizes. Every
> + * HugeTLB has more than one struct page structure. The 2M HugeTLB has 512
> + * struct page structure and 1G HugeTLB has 4096 struct page structures. But
> + * in the core of HugeTLB only uses the first 4 (Use of first 4 struct page
> + * structures comes from HUGETLB_CGROUP_MIN_ORDER.) struct page structures to
> + * store metadata associated with each HugeTLB. The rest of the struct page
> + * structures are usually read the compound_head field which are all the same
> + * value. If we can free some struct page memory to buddy system so that we
> + * can save a lot of memory.
> + *

struct page structures (page structs) are used to describe a physical page
frame.  By default, there is a one-to-one mapping from a page frame to
it's corresponding page struct.

HugeTLB pages consist of multiple base page size pages and is supported by
many architectures. See hugetlbpage.rst in the Documentation directory for
more details.  On the x86 architecture, HugeTLB pages of size 2MB and 1GB
are currently supported.  Since the base page size on x86 is 4KB, a 2MB
HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
4096 base pages.  For each base page, there is a corresponding page struct.

Within the HugeTLB subsystem, only the first 4 page structs are used to
contain unique information about a HugeTLB page.  HUGETLB_CGROUP_MIN_ORDER
provides this upper limit.  The only 'useful' information in the remaining
page structs is the compound_head field, and this field is the same for all
tail pages.

By removing redundant page structs for HugeTLB pages, memory can returned
to the buddy allocator for other uses.

> + * When the system boot up, every 2M HugeTLB has 512 struct page structures
> + * which size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> + *
> + *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> + * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> + * |           |                     |     0     | -------------> |     0     |
> + * |           |                     |     1     | -------------> |     1     |
> + * |           |                     |     2     | -------------> |     2     |
> + * |           |                     |     3     | -------------> |     3     |
> + * |           |                     |     4     | -------------> |     4     |
> + * |     2M    |                     |     5     | -------------> |     5     |
> + * |           |                     |     6     | -------------> |     6     |
> + * |           |                     |     7     | -------------> |     7     |
> + * |           |                     +-----------+                +-----------+
> + * |           |
> + * |           |
> + * +-----------+
> + *
> + *

I think we want the description before the next diagram.

Reworded description here:

The value of compound_head is the same for all tail pages.  The first page of
page structs (page 0) associated with the HugeTLB page contains the 4 page
structs necessary to describe the HugeTLB.  The only use of the remaining pages
of page structs (page 1 to page 7) is to point to compound_head.  Therefore,
we can remap pages 2 to 7 to page 1.  Only 2 pages of page structs will be used
for each HugeTLB page.  This will allow us to free the remaining 6 pages to 
the buddy allocator.  

Here is how things look after remapping.

> + *
> + *    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
> + * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> + * |           |                     |     0     | -------------> |     0     |
> + * |           |                     |     1     | -------------> |     1     |
> + * |           |                     |     2     | -------------> +-----------+
> + * |           |                     |     3     | -----------------^ ^ ^ ^ ^
> + * |           |                     |     4     | -------------------+ | | |
> + * |     2M    |                     |     5     | ---------------------+ | |
> + * |           |                     |     6     | -----------------------+ |
> + * |           |                     |     7     | -------------------------+
> + * |           |                     +-----------+
> + * |           |
> + * |           |
> + * +-----------+

-- 
Mike Kravetz
