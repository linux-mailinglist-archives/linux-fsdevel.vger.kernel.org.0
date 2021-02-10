Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A6316B52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhBJQdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 11:33:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:11398 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhBJQcJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:32:09 -0500
IronPort-SDR: G7UyBZhyGrtCZogwkITdHzBXcN7nLRnC2vQoujfBWRrad7NqKKtmqR+Nni3GJ15D1rjZLOUSNJ
 Mnfd1MJnN/Zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="246169357"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="246169357"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:31:01 -0800
IronPort-SDR: 1Xc7jUb+VeYADI7/WZQPzN1E9a62iqQp23wqYhf0LGUiUfVbmHXGDogTuzVo+sk89BFZVdbGix
 j83fEgXIfp9Q==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="588011558"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 08:31:01 -0800
Date:   Wed, 10 Feb 2021 08:31:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        "hch@infradead.org" <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V2 4/8] mm/highmem: Add VM_BUG_ON() to mem*_page() calls
Message-ID: <20210210163101.GC3014244@iweiny-DESK2.sc.intel.com>
References: <20210210062221.3023586-1-ira.weiny@intel.com>
 <20210210062221.3023586-5-ira.weiny@intel.com>
 <BYAPR04MB4965E51F07F1AB084BC1FA84868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB4965E51F07F1AB084BC1FA84868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 06:57:30AM +0000, Chaitanya Kulkarni wrote:
> On 2/9/21 22:25, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Add VM_BUG_ON bounds checks to ensure the newly lifted and created page
> > memory operations do not result in corrupted data in neighbor pages and
> > to make them consistent with zero_user().[1][2]
> >
> I did not understand this, in my tree :-
> 
> zero_user()
>  -> zero_user_segments()
> 
> which uses BUG_ON(), the commit log says add VM_BUG_ON(), isn't that
> inconsistent withwhat is there in zero_user_segments() which uses BUG_ON() ?
> 
> Also, this patch uses BUG_ON() which doesn't match the commit log that says
> ADD VM_BUG_ON(),

Oops, yea that 'consistent with zero_user()' was carried over from the BUG_ON
commit comment in the original patch...

The comment should be deleted.

But I'm going to wait because Christoph prefers BUG_ON...

Ira

> 
> Did I interpret the commit log wrong ?
> 
> [1]
>  void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
> 365                 unsigned start2, unsigned end2)
> 366 {
> 367         unsigned int
> i;                                                                           
> 
> 368
> 369         BUG_ON(end1 > page_size(page) || end2 > page_size(page));
> 370
> 371         for (i = 0; i < compound_nr(page); i++) {
> 372                 void *kaddr = NULL;
> 373 
> 374                 if (start1 < PAGE_SIZE || start2 < PAGE_SIZE)
> 375                         kaddr = kmap_atomic(page + i);
> 376
> 377                 if (start1 >= PAGE_SIZE) {
> 378                         start1 -= PAGE_SIZE;
> 379                         end1 -= PAGE_SIZE;
> 380                 } else {
> 381                         unsigned this_end = min_t(unsigned, end1,
> PAGE_SIZE);
> 382        
> 383                         if (end1 > start1)
> 384                                 memset(kaddr + start1, 0, this_end -
> start1);
> 385                         end1 -= this_end;
> 386                         start1 = 0;
> 387                 }
> 388
> 389                 if (start2 >= PAGE_SIZE) {
> 390                         start2 -= PAGE_SIZE;
> 391                         end2 -= PAGE_SIZE;
> 392                 } else {
> 393                         unsigned this_end = min_t(unsigned, end2,
> PAGE_SIZE);
> 394 
> 395                         if (end2 > start2)
> 396                                 memset(kaddr + start2, 0, this_end -
> start2);
> 397                         end2 -= this_end;
> 398                         start2 = 0;
> 399                 }
> 400        
> 401                 if (kaddr) {
> 402                         kunmap_atomic(kaddr);
> 403                         flush_dcache_page(page + i);
> 404                 }
> 405        
> 406                 if (!end1 && !end2)
> 407                         break;
> 408         }
> 409        
> 410         BUG_ON((start1 | start2 | end1 | end2) != 0);
> 411 }
> 412 EXPORT_SYMBOL(zero_user_segments);
> 
> 
> 
