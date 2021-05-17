Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3901F3824B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 08:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhEQGuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 02:50:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3707 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhEQGuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 02:50:05 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fk8mC5c9Kz16QxW;
        Mon, 17 May 2021 14:46:03 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 14:48:47 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 14:48:47 +0800
Subject: Re: [PATCH] mm/memory-failure: make sure wait for page writeback in
 memory_failure
To:     Oscar Salvador <osalvador@suse.de>, Jan Kara <jack@suse.cz>,
        <naoya.horiguchi@nec.com>
CC:     <naoya.horiguchi@nec.com>, <akpm@linux-foundation.org>,
        <viro@zeniv.linux.org.uk>, <tytso@mit.edu>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, <houtao1@huawei.com>, <yebin10@huawei.com>
References: <20210511070329.2002597-1-yangerkun@huawei.com>
 <20210511084600.GG24154@quack2.suse.cz>
 <YJpPj3dGxk4TFL4b@localhost.localdomain>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <4803a723-666f-c710-3ad4-2579390e4a9d@huawei.com>
Date:   Mon, 17 May 2021 14:48:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YJpPj3dGxk4TFL4b@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/5/11 17:34, Oscar Salvador 写道:
> On Tue, May 11, 2021 at 10:46:00AM +0200, Jan Kara wrote:
>> We definitely need to wait for writeback of these pages and the change you
>> suggest makes sense to me. I'm just not sure whether the only problem with
>> these "pages in the process of being munlocked()" cannot confuse the state
>> machinery in memory_failure() also in some other way. Also I'm not sure if
>> are really allowed to call wait_on_page_writeback() on just any page that
>> hits memory_failure() - there can be slab pages, anon pages, completely
>> unknown pages given out by page allocator to device drivers etc. That needs
>> someone more familiar with these MM details than me.
> 
> I am not really into mm/writeback stuff, but:
> 
> shake_page() a few lines before tries to identifiy the page, and
> make those sitting in lruvec real PageLRU, and then we take page's lock.
> 
> I thought that such pages (pages on writeback) are stored in the file
> LRU, and maybe the code was written with that in mind? And given that
> we are under the PageLock, such state could not have changed.

Hi,


Crash of this bug show we can clear page LRU without lock_page by follow 
stack. So this page_lock in memory_failure seems useless to prevent this 
BUG.

do_mmap->mmap_region->do_munmap->munlock_vma_pages_range->__munlock_pagevec

static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
{
     ...
     for (i = 0; i < nr; i++) {
         struct page *page = pvec->pages[i];

         if (TestClearPageMlocked(page)) {
             if (TestClearPageLRU(page)) { <=== clear LRU flag
                 ...
             }
             ...
         }
         ...
     }
     ...
}


> 
> But if such pages are allowed to not be in the LRU (maybe they are taken
> off before initiating the writeback?), I guess the change is correct.
> Checking wait_on_page_writeback(), it seems it first checks for
> Writeback bit, and since that bit is not "shared" and only being set
> in mm/writeback code, it should be fine to call that.
> 
> But alternatively, we could also modify the check and go with:
> 
> if (!PageTransTail(p) && !PageLRU(p) && !PageWriteBack(p))
> 		goto identify_page_state;

I have no idea should we process this page with such state. But it seems 
reasonable to add some comments to clarify our change.

Thanks,
Kun.

> 
> and stating why a page under writeback might not be in the LRU, as I
> think the code assumes.
> 
> AFAUI, mm/writeback locks the page before setting the bit, and since we
> hold the lock, we could not race here.
> 
