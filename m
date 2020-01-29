Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2414D312
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 23:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgA2W0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 17:26:10 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10658 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgA2W0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:26:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e32066b0000>; Wed, 29 Jan 2020 14:25:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 14:26:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jan 2020 14:26:07 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 22:26:07 +0000
Subject: Re: [PATCH v2 1/8] mm: dump_page: print head page's refcount, for
 compound pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-2-jhubbard@nvidia.com>
 <20200129112510.ulims6u36ofk2qwa@box>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b74e8aa9-fcfd-0340-594c-61f185a0ae65@nvidia.com>
Date:   Wed, 29 Jan 2020 14:26:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129112510.ulims6u36ofk2qwa@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580336747; bh=vT9uxFbbz6DF2btxvxGbTDWBFc+B+qnQqK1QUiaY9dA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Dz5Fyqmghn2gdv9fiOoF2EJItBvYgfpf1FVruxmawrl5xbM8MC42s8WvRaeqLI8ai
         ovw+b4j8e0JsRONv4YVpXwflEV3+6jjUltIajFLfWGkRxbeUOfmBQRv9mnsHbtcvsy
         Oz6CMy3mq9AWMQlAES2oEyiGjg1QB4dDUaExFTf/S82o2w1k7iLGKewczsy7DntFlY
         ELr1p5gH08FkNFmfnzdKyfsTIZs+i+GFTzwUFeNXtlRHh5sORn2vkycNKJr0vv5rNl
         3rq3+dZ2Qvdfa2iD9lXhfs45PDzJETClGUbxgmDV2G8AkrHrUu6okIcFXVWaQbf6Sj
         APnbI4lkzMt5g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/29/20 3:25 AM, Kirill A. Shutemov wrote:
> On Tue, Jan 28, 2020 at 07:24:10PM -0800, John Hubbard wrote:
>> When debugging a problem that involves compound pages, it is extremely
>> helpful if dump_page() reports not only the page->_refcount, but also
>> the refcount of the head page of the compound page. That's because the
>> head page collects refcounts for the entire compound page.
>>
>> Therefore, enhance dump_page() so as to print out the refcount of the
>> head page of a compound page.
>>
>> This approach (printing information about a struct page that is not the
>> struct page that was passed into dump_page()) has a precedent:
>> compound_mapcount is already being printed.
> 
> refcount on a tail must always be 0. I think we should only print it when
> it is non-zero, emphasizing this fact with a standalone message.
> 

Hi Kirill,

Yes, good point, that sounds like just the right balance. And it avoids adding 
a new item to print in the common case, which is very nice. Here's what I've
changed it to for the next version (I'll also rewrite the commit description 
accordingly):


diff --git a/mm/debug.c b/mm/debug.c
index a90da5337c14..3a45e2b77de0 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -75,12 +75,17 @@ void __dump_page(struct page *page, const char *reason)
 	 */
 	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
 
-	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
+	if (PageCompound(page)) {
+		pr_warn("page:%px compound refcount:%d mapcount:%d mapping:%px "
+			"index:%#lx compound_mapcount:%d\n",
+			page, page_ref_count(compound_head(page)), mapcount,
 			page->mapping, page_to_pgoff(page),
 			compound_mapcount(page));
+
+		if (page != compound_head(page) && page_ref_count(page) != 0)
+			pr_warn("page:%px PROBLEM: non-zero refcount (==%d) on "
+				"this tail page\n", page, page_ref_count(page));
+	}
 	else
 		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
 			page, page_ref_count(page), mapcount,


thanks,
-- 
John Hubbard
NVIDIA
