Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFA22EA402
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 04:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAEDqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 22:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAEDqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:46:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A52C061574;
        Mon,  4 Jan 2021 19:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=LL0n5x3ZKQKBeJnSSJSM66PM0K/AJjwB+1HmKM1hr8U=; b=vqHQHb729MK/QOY1e4fmVZYfud
        /TD9vGo4S6EN6UBI+d2ADvQfqXa3B0+lr1/RL8oNt4hJto7ltzwc/+KwiFIxBi0ukO1d+E/O6ryKc
        Zwt7vKpdx69+TBSZLxxY7ZYbMzVj1tEmhkQO30zFGsZH7kQzEFWwiLRlP1oVDc/e2RGHwJCDnUilt
        lNs3AgC8+Msq9m4ryKAY3Nie/F51/2kCM0Nuf6Urnkka/a3bZS16Z5HICp7iqi9Wc2zQoG1uQfjDi
        r1hNWwUQH/e/pA8RC31LjXXerP46hcx0TayKREjnmGNFx6LT31RXQaVCXIVhEmqriQ94csQVnDN5t
        7iyMVmOA==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwdEH-000pgb-Q7; Tue, 05 Jan 2021 03:42:36 +0000
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupts@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
References: <20210101042914.5313-1-rdunlap@infradead.org>
 <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f7803685-e255-7cfe-5259-e2a7dc5ab581@infradead.org>
Date:   Mon, 4 Jan 2021 19:41:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/4/21 12:13 PM, Dan Williams wrote:
> On Thu, Dec 31, 2020 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> fs/dax.c uses copy_user_page() but ARC does not provide that interface,
>> resulting in a build error.
>>
>> Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
>> add <asm/page.h> to fs/dax.c to fix the build error.
>>
>> ../fs/dax.c: In function 'copy_cow_page_dax':
>> ../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]
>>
>> Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Acked-by: Vineet Gupta <vgupts@synopsys.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-nvdimm@lists.01.org
>> ---
>> v2: rebase, add more Cc:
>>
>>  arch/arc/include/asm/page.h |    1 +
>>  fs/dax.c                    |    1 +
>>  2 files changed, 2 insertions(+)
>>
>> --- lnx-511-rc1.orig/fs/dax.c
>> +++ lnx-511-rc1/fs/dax.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/sizes.h>
>>  #include <linux/mmu_notifier.h>
>>  #include <linux/iomap.h>
>> +#include <asm/page.h>
> 
> I would expect this to come from one of the linux/ includes like
> linux/mm.h. asm/ headers are implementation linux/ headers are api.
> 
> Once you drop that then the subject of this patch can just be "arc:
> add a copy_user_page() implementation", and handled by the arc
> maintainer (or I can take it with Vineet's ack).

Got it. Thanks.
Vineet is copied. I expect that he will take the v3 patch.

>>  #include <asm/pgalloc.h>
> 
> Yes, this one should have a linux/ api header to front it, but that's
> a cleanup for another day.

That line is only part of the contextual diff in this patch.
I guess you are just commenting in general, along with your earlier
paragraph.

>>
>>  #define CREATE_TRACE_POINTS
>> --- lnx-511-rc1.orig/arch/arc/include/asm/page.h
>> +++ lnx-511-rc1/arch/arc/include/asm/page.h
>> @@ -10,6 +10,7 @@
>>  #ifndef __ASSEMBLY__
>>
>>  #define clear_page(paddr)              memset((paddr), 0, PAGE_SIZE)
>> +#define copy_user_page(to, from, vaddr, pg)    copy_page(to, from)
>>  #define copy_page(to, from)            memcpy((to), (from), PAGE_SIZE)
>>
>>  struct vm_area_struct;


-- 
~Randy

