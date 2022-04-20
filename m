Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB9B5089D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 15:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379214AbiDTNzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 09:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354174AbiDTNzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:55:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6276A3ED27;
        Wed, 20 Apr 2022 06:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D021B81D6E;
        Wed, 20 Apr 2022 13:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFDEC385A0;
        Wed, 20 Apr 2022 13:52:53 +0000 (UTC)
Message-ID: <6f56d0d6-6d0d-f0c9-87df-f3ff25b26fc5@linux-m68k.org>
Date:   Wed, 20 Apr 2022 23:52:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Regression with v5.18-rc1 tag on STM32F7 and STM32H7 based boards
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, mpatocka@redhat.com,
        lczerner@redhat.com, djwong@kernel.org, hch@lst.de,
        zkabelac@redhat.com, miklos@szeredi.hu, bp@suse.de,
        akpm@linux-foundation.org,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Russell King <linux@armlinux.org.uk>
References: <481a13f8-d339-f726-0418-ab4258228e91@foss.st.com>
 <95a0d1dd-bcce-76c7-97b9-8374c9913321@google.com>
 <7f2993a9-adc5-2b90-9218-c4ca8239c3e@google.com>
 <3695dc2a-7518-dee4-a647-821c7cda4a0f@foss.st.com>
 <2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hugh,

On 16/4/22 10:58, Hugh Dickins wrote:
> On Wed, 6 Apr 2022, Patrice CHOTARD wrote:
>> On 4/6/22 08:22, Hugh Dickins wrote:
>>> Asking Arnd and others below: should noMMU arches have a good ZERO_PAGE?
>>>
>>> On Tue, 5 Apr 2022, Hugh Dickins wrote:
>>>> On Tue, 5 Apr 2022, Patrice CHOTARD wrote:
>>>>>
>>>>> We found an issue with last kernel tag v5.18-rc1 on stm32f746-disco and
>>>>> stm32h743-disco boards (ARMV7-M SoCs).
>>>>>
>>>>> Kernel hangs when executing SetPageUptodate(ZERO_PAGE(0)); in mm/filemap.c.
>>>>>
>>>>> By reverting commit 56a8c8eb1eaf ("tmpfs: do not allocate pages on read"),
>>>>> kernel boots without any issue.
>>>>
>>>> Sorry about that, thanks a lot for finding.
>>>>
>>>> I see that arch/arm/configs/stm32_defconfig says CONFIG_MMU is not set:
>>>> please confirm that is the case here.
>>>>
>>>> Yes, it looks as if NOMMU platforms are liable to have a bogus (that's my
>>>> reading, but it may be unfair) definition for ZERO_PAGE(vaddr), and I was
>>>> walking on ice to touch it without regard for !CONFIG_MMU.
>>>>
>>>> CONFIG_SHMEM depends on CONFIG_MMU, so that PageUptodate is only needed
>>>> when CONFIG_MMU.
>>>>
>>>> Easily fixed by an #ifdef CONFIG_MMU there in mm/filemap.c, but I'll hunt
>>>> around (again) for a better place to do it - though I won't want to touch
>>>> all the architectures for it.  I'll post later today.
>>>
>>> I could put #ifdef CONFIG_MMU around the SetPageUptodate(ZERO_PAGE(0))
>>> added to pagecache_init(); or if that's considered distasteful, I could
>>> skip making it potentially useful to other filesystems, revert the change
>>> to pagecache_init(), and just do it in mm/shmem.c's CONFIG_SHMEM (hence
>>> CONFIG_MMU) instance of shmem_init().
>>>
>>> But I wonder if it's safe for noMMU architectures to go on without a
>>> working ZERO_PAGE(0).  It has uses scattered throughout the tree, in
>>> drivers, fs, crypto and more, and it's not at all obvious (to me) that
>>> they all depend on CONFIG_MMU.  Some might cause (unreported) crashes,
>>> some might use an unzeroed page in place of a pageful of zeroes.
>>>
>>> arm noMMU and h8300 noMMU and m68k noMMU each has
>>> #define ZERO_PAGE(vaddr)	(virt_to_page(0))
>>> which seems riskily wrong to me.
>>>
>>> h8300 and m68k actually go to the trouble of allocating an empty_zero_page
>>> for this, but then forget to link it up to the ZERO_PAGE(vaddr) definition,
>>> which is what all the common code uses.
>>>
>>> arm noMMU does not presently allocate such a page; and I do not feel
>>> entitled to steal a page from arm noMMU platforms, for a hypothetical
>>> case, without agreement.
>>>
>>> But here's an unbuilt and untested patch for consideration - which of
>>> course should be split in three if agreed (and perhaps the h8300 part
>>> quietly forgotten if h8300 is already on its way out).
>>>
>>> (Yes, arm uses empty_zero_page in a different way from all the other
>>> architectures; but that's okay, and I think arm's way, with virt_to_page()
>>> already baked in, is better than the others; but I've no wish to get into
>>> changing them.)
>>>
>>> Patrice, does this patch build and run for you? I have no appreciation
>>> of arm early startup issues, and may have got it horribly wrong.
>>
>> This patch is okay on my side on both boards (STM32F7 and STM32H7), boot are OK.
>>
>> Thanks for your reactivity ;-)
>> Patrice
> 
> Just to wrap up this thread: the tentative arch/ patches below did not
> go into 5.18-rc2, but 5.18-rc3 will contain
> 1bdec44b1eee ("tmpfs: fix regressions from wider use of ZERO_PAGE")
> which fixes a further issue, and deletes the line which gave you trouble.
> 
> With arch/h8300 removed from linux-next, and arch/arm losing a page by
> the patch below, I don't think it's worth my arguing for those changes.
> I'd still prefer arch/m68k to expose its empty_zero_page in ZERO_PAGE(),
> or else not allocate it; but I won't be pursuing this further.

Thanks for pointing this out. It certainly does look wrong to me for
the m68k nommu case. I am not aware of any existing issues caused by
this - but there is no good reason not to fix it.

So I propose this change. Build and run tested on my m68knommu targets.

Regards
Greg


 From f809fb8fbca9e5e637b8fda380955bd799bb3926 Mon Sep 17 00:00:00 2001
From: Greg Ungerer <gerg@linux-m68k.org>
Date: Wed, 20 Apr 2022 23:27:47 +1000
Subject: [PATCH] m68knommu: set ZERO_PAGE() allocated zeroed page

The non-MMU m68k pagetable ZERO_PAGE() macro is being set to the
somewhat non-sensical value of "virt_to_page(0)". The zeroth page
is not in any way guaranteed to be a page full of "0". So the result
is that ZERO_PAGE() will almost certainly contain random values.

We already allocate a real "empty_zero_page" in the mm setup code shared
between MMU m68k and non-MMU m68k. It is just not hooked up to the
ZERO_PAGE() macro for the non-MMU m68k case.

Fix ZERO_PAGE() to use the allocated "empty_zero_page" pointer.

I am not aware of any specific issues caused by the old code.

Link: https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#t
Reported-by: Hugh Dickens <hughd@google.com>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
  arch/m68k/include/asm/pgtable_no.h | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index 87151d67d91e..bce5ca56c388 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -42,7 +42,8 @@ extern void paging_init(void);
   * ZERO_PAGE is a global shared page that is always zero: used
   * for zero-mapped memory areas etc..
   */
-#define ZERO_PAGE(vaddr)	(virt_to_page(0))
+extern void *empty_zero_page;
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
  
  /*
   * All 32bit addresses are effectively valid for vmalloc...
-- 
2.25.1

