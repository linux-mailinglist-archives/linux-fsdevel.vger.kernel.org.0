Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88D386D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 00:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404258AbfHHW7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 18:59:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10694 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390006AbfHHW7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:59:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4ca94e0002>; Thu, 08 Aug 2019 15:59:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 15:59:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 15:59:16 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 22:59:15 +0000
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
 <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
Date:   Thu, 8 Aug 2019 15:59:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565305166; bh=M49TAEp0rF+Rj/ENVh2GXbZ42kgeSpTrxkT20El97xE=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qK96gYx06tpkH2q4CcpF6OFBCFRxcA8XFBMTGsGorSI049/l40m06bHRMJx1tJDS8
         DAxdC1uODwBgaSWpMv4if5Iqt5i6qp+oDs/yhJULQwcTTRKfkWpB4SnYndw1nTt5km
         1xsWvHi7FBF0yo5mOFnYaowlOnPQGpSB0fYDx8KBQ1ve/x25U7+7434V1pzCwlvZIk
         g3hlON18SJuJ2D/c0ndQmqy+GqYV484LBuFviFDcSWUg4RE4xEoQGHJIHzlfkY/R0f
         OLytPdbTTAL5LajiZx2D0leH8axGGC7GmnAFDCpEVhyRNyBbECyjZ/GMFaZn0/VRiJ
         mrtUWi75zSo4g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/19 12:20 PM, John Hubbard wrote:
> On 8/8/19 4:09 AM, Vlastimil Babka wrote:
>> On 8/8/19 8:21 AM, Michal Hocko wrote:
>>> On Wed 07-08-19 16:32:08, John Hubbard wrote:
>>>> On 8/7/19 4:01 AM, Michal Hocko wrote:
>>>>> On Mon 05-08-19 15:20:17, john.hubbard@gmail.com wrote:
>>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>>> Actually, I think follow_page_mask() gets all the pages, right? And the
>>>> get_page() in __munlock_pagevec_fill() is there to allow a pagevec_release() 
>>>> later.
>>>
>>> Maybe I am misreading the code (looking at Linus tree) but munlock_vma_pages_range
>>> calls follow_page for the start address and then if not THP tries to
>>> fill up the pagevec with few more pages (up to end), do the shortcut
>>> via manual pte walk as an optimization and use generic get_page there.
>>
> 
> Yes, I see it finally, thanks. :)  
> 
>> That's true. However, I'm not sure munlocking is where the
>> put_user_page() machinery is intended to be used anyway? These are
>> short-term pins for struct page manipulation, not e.g. dirtying of page
>> contents. Reading commit fc1d8e7cca2d I don't think this case falls
>> within the reasoning there. Perhaps not all GUP users should be
>> converted to the planned separate GUP tracking, and instead we should
>> have a GUP/follow_page_mask() variant that keeps using get_page/put_page?
>>  
> 
> Interesting. So far, the approach has been to get all the gup callers to
> release via put_user_page(), but if we add in Jan's and Ira's vaddr_pin_pages()
> wrapper, then maybe we could leave some sites unconverted.
> 
> However, in order to do so, we would have to change things so that we have
> one set of APIs (gup) that do *not* increment a pin count, and another set
> (vaddr_pin_pages) that do. 
> 
> Is that where we want to go...?
> 

Oh, and meanwhile, I'm leaning toward a cheap fix: just use gup_fast() instead
of get_page(), and also fix the releasing code. So this incremental patch, on
top of the existing one, should do it:

diff --git a/mm/mlock.c b/mm/mlock.c
index b980e6270e8a..2ea272c6fee3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -318,18 +318,14 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
                /*
                 * We won't be munlocking this page in the next phase
                 * but we still need to release the follow_page_mask()
-                * pin. We cannot do it under lru_lock however. If it's
-                * the last pin, __page_cache_release() would deadlock.
+                * pin.
                 */
-               pagevec_add(&pvec_putback, pvec->pages[i]);
+               put_user_page(pages[i]);
                pvec->pages[i] = NULL;
        }
        __mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
        spin_unlock_irq(&zone->zone_pgdat->lru_lock);
 
-       /* Now we can release pins of pages that we are not munlocking */
-       pagevec_release(&pvec_putback);
-
        /* Phase 2: page munlock */
        for (i = 0; i < nr; i++) {
                struct page *page = pvec->pages[i];
@@ -394,6 +390,8 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
        start += PAGE_SIZE;
        while (start < end) {
                struct page *page = NULL;
+               int ret;
+
                pte++;
                if (pte_present(*pte))
                        page = vm_normal_page(vma, start, *pte);
@@ -411,7 +409,13 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
                if (PageTransCompound(page))
                        break;
 
-               get_page(page);
+               /*
+                * Use get_user_pages_fast(), instead of get_page() so that the
+                * releasing code can unconditionally call put_user_page().
+                */
+               ret = get_user_pages_fast(start, 1, 0, &page);
+               if (ret != 1)
+                       break;
                /*
                 * Increase the address that will be returned *before* the
                 * eventual break due to pvec becoming full by adding the page


thanks,
-- 
John Hubbard
NVIDIA
