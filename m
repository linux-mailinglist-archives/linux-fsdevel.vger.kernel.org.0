Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785C814D665
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 07:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgA3G0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 01:26:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17654 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgA3G0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:26:13 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3276cf0000>; Wed, 29 Jan 2020 22:25:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 22:26:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 Jan 2020 22:26:11 -0800
Received: from [10.2.165.69] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 06:26:10 +0000
Subject: Re: [PATCH v2 1/8] mm: dump_page: print head page's refcount, for
 compound pages
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <b74e8aa9-fcfd-0340-594c-61f185a0ae65@nvidia.com>
 <20200129225957.GH6615@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a0d66400-96a2-f94e-311d-a94f75e72d65@nvidia.com>
Date:   Wed, 29 Jan 2020 22:23:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129225957.GH6615@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580365520; bh=JHRJR+nRNJ+fPdKgdhNh0UpV2gT6YF7QTq3XuI/pnwo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BQDWkRnLH1j0+3TFcqwPmncBEuhinrmCw80Gb5nfjCWCm7Q+eTszuPPxdRdT/9ncI
         x3vf//wCgavyZ2zurvNKovAxI/vZkKZclk357DNkl6D/x0aJAzNgqEhRFJp40iDBED
         blM/4jKRxhuyVU/WLFsXsLkxawG9WIwlVDfIJ1gmdL52WG4s3jP21Q+xONM74akxo2
         o3rwO1ZZPh/0w73Q2KfxYhHRtPrL4ctXCQQyM51KBuG20kGnsUbBy868Exg0yU1S/h
         uGFVs4y/C8Uwpoh/bi+N1dF2g3hx5+SVKe+Fwn5Npk5ECCkzzyiD+r1UvShA2fyeI4
         td4jAMZ7SAJdw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/29/20 2:59 PM, Matthew Wilcox wrote:
...
> I have a hunk in my current tree which looks like this:
> 
> @@ -77,6 +77,11 @@ void __dump_page(struct page *page, const char *reason)
>                  pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx
> \n",
>                          page, page_ref_count(page), mapcount,
>                          page->mapping, page_to_pgoff(page));
> +       if (PageTail(page)) {
> +               struct page *head = compound_head(page);
> +               pr_warn("head:%px mapping:%px index:%#lx\n",
> +                       head, head->mapping, page_to_pgoff(head));
> +       }
>          if (PageKsm(page))
>                  pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
>          else if (PageAnon(page))
> 
> I wonder if we can combine these two patches in some more useful way?
> 
> I also think we probably want a sanity check that 'head' and 'page'
> are within a sane range of each other (ie head < page and head +
> MAX_ORDER_NR_PAGES > page) to protect against a struct page that contains
> complete garbage.
> 

OK, here's a go at combining those. I like the observation, implicit in your
diffs, that PageTail rather than PageCompound is the key differentiator in
deciding what to print. How's this look:

diff --git a/mm/debug.c b/mm/debug.c
index a90da5337c14..944652843e7b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -75,12 +75,31 @@ void __dump_page(struct page *page, const char *reason)
  	 */
  	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
  
-	if (PageCompound(page))
-		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
-			"index:%#lx compound_mapcount: %d\n",
-			page, page_ref_count(page), mapcount,
-			page->mapping, page_to_pgoff(page),
-			compound_mapcount(page));
+	if (PageTail(page)) {
+		struct page *head = compound_head(page);
+
+		if ((page < head) || (page >= head + MAX_ORDER_NR_PAGES)) {
+			/*
+			 * Page is hopelessly corrupted, so limit any reporting
+			 * to information about the page itself. Do not attempt
+			 * to look at the head page.
+			 */
+			pr_warn("page:%px refcount:%d mapcount:%d mapping:%px "
+				"index:%#lx (corrupted tail page case)\n",
+				page, page_ref_count(page), mapcount,
+				page->mapping, page_to_pgoff(page));
+		} else {
+			pr_warn("page:%px compound refcount:%d mapcount:%d "
+				"mapping:%px index:%#lx compound_mapcount:%d\n",
+				page, page_ref_count(head),
+				mapcount, head->mapping, page_to_pgoff(head),
+				compound_mapcount(page));
+
+			if (page_ref_count(page) != 0)
+				pr_warn("page:%px PROBLEM: non-zero refcount (==%d) on "
+					"this tail page\n", page, page_ref_count(page));
+		}
+	}
  	else
  		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
  			page, page_ref_count(page), mapcount,

?

Here's sample output for a normal page, a tail page, and a tail page with a bad
(non-zero) refcount:

============
Normal page:
============
[   38.572084] page:ffffea0011465880 refcount:2 mapcount:1 mapping:ffff888454d99001 index:0xb2
[   38.579256] anon flags: 0x17ffe0000080036(referenced|uptodate|lru|active|swapbacked)
[   38.585799] raw: 017ffe0000080036 ffffea0011460fc8 ffffea0011466d08 ffff888454d99001
[   38.592350] raw: 00000000000000b2 0000000000000000 0000000200000000 0000000000000000
[   38.598885] page dumped because: test dump page


==========
Tail page:
==========
[   38.436384] page:ffffea0010aa0280 compound refcount:503 mapcount:1 mapping:ffff888455fb3399 index:0xa8 compound_mapcount:1
[   38.446350] anon flags: 0x17ffe0000000000()
[   38.449661] raw: 017ffe0000000000 ffffea0010aa0001 ffffea0010aa0288 dead000000000400
[   38.456228] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   38.462794] page dumped because: test dump page

============================
Tail page with bad refcount:
============================
[   38.466088] page:ffffea0010aa0b40 compound refcount:468 mapcount:1 mapping:ffff888455fb3399 index:0xa8 compound_mapcount:1
[   38.475967] page:ffffea0010aa0b40 PROBLEM: non-zero refcount (==2) on this tail page
[   38.482490] anon flags: 0x17ffe0000000000()
[   38.485432] raw: 017ffe0000000000 ffffea0010aa0001 ffffea0010aa0b48 dead000000000400
[   38.491996] raw: 0000000000000000 0000000000000000 00000002ffffffff 0000000000000000
[   38.498532] page dumped because: test bad tail page refcount



thanks,
-- 
John Hubbard
NVIDIA
