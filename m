Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BF509F40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382891AbiDUMF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 08:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382859AbiDUMFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:05:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A21FD0;
        Thu, 21 Apr 2022 05:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16556B821B8;
        Thu, 21 Apr 2022 12:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB4BC385A5;
        Thu, 21 Apr 2022 12:02:27 +0000 (UTC)
Message-ID: <7d576466-0004-f644-7973-844c997a1503@linux-m68k.org>
Date:   Thu, 21 Apr 2022 22:02:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Regression with v5.18-rc1 tag on STM32F7 and STM32H7 based boards
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, zkabelac@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Russell King <linux@armlinux.org.uk>
References: <481a13f8-d339-f726-0418-ab4258228e91@foss.st.com>
 <95a0d1dd-bcce-76c7-97b9-8374c9913321@google.com>
 <7f2993a9-adc5-2b90-9218-c4ca8239c3e@google.com>
 <3695dc2a-7518-dee4-a647-821c7cda4a0f@foss.st.com>
 <2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com>
 <6f56d0d6-6d0d-f0c9-87df-f3ff25b26fc5@linux-m68k.org>
 <CAMuHMdWA7n588XUKy2yondnZpAw_afFBz8DHxH0Q3Tt53HHsHg@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <CAMuHMdWA7n588XUKy2yondnZpAw_afFBz8DHxH0Q3Tt53HHsHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Geert,

On 21/4/22 00:44, Geert Uytterhoeven wrote:
> On Wed, Apr 20, 2022 at 3:53 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 16/4/22 10:58, Hugh Dickins wrote:
>>> Just to wrap up this thread: the tentative arch/ patches below did not
>>> go into 5.18-rc2, but 5.18-rc3 will contain
>>> 1bdec44b1eee ("tmpfs: fix regressions from wider use of ZERO_PAGE")
>>> which fixes a further issue, and deletes the line which gave you trouble.
>>>
>>> With arch/h8300 removed from linux-next, and arch/arm losing a page by
>>> the patch below, I don't think it's worth my arguing for those changes.
>>> I'd still prefer arch/m68k to expose its empty_zero_page in ZERO_PAGE(),
>>> or else not allocate it; but I won't be pursuing this further.
>>
>> Thanks for pointing this out. It certainly does look wrong to me for
>> the m68k nommu case. I am not aware of any existing issues caused by
>> this - but there is no good reason not to fix it.
>>
>> So I propose this change. Build and run tested on my m68knommu targets.
>>
>> Regards
>> Greg
>>
>>
>>   From f809fb8fbca9e5e637b8fda380955bd799bb3926 Mon Sep 17 00:00:00 2001
>> From: Greg Ungerer <gerg@linux-m68k.org>
>> Date: Wed, 20 Apr 2022 23:27:47 +1000
>> Subject: [PATCH] m68knommu: set ZERO_PAGE() allocated zeroed page
>>
>> The non-MMU m68k pagetable ZERO_PAGE() macro is being set to the
>> somewhat non-sensical value of "virt_to_page(0)". The zeroth page
>> is not in any way guaranteed to be a page full of "0". So the result
>> is that ZERO_PAGE() will almost certainly contain random values.
>>
>> We already allocate a real "empty_zero_page" in the mm setup code shared
>> between MMU m68k and non-MMU m68k. It is just not hooked up to the
>> ZERO_PAGE() macro for the non-MMU m68k case.
>>
>> Fix ZERO_PAGE() to use the allocated "empty_zero_page" pointer.
>>
>> I am not aware of any specific issues caused by the old code.
>>
>> Link: https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#t
>> Reported-by: Hugh Dickens <hughd@google.com>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>> ---
>>    arch/m68k/include/asm/pgtable_no.h | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
>> index 87151d67d91e..bce5ca56c388 100644
>> --- a/arch/m68k/include/asm/pgtable_no.h
>> +++ b/arch/m68k/include/asm/pgtable_no.h
>> @@ -42,7 +42,8 @@ extern void paging_init(void);
>>     * ZERO_PAGE is a global shared page that is always zero: used
>>     * for zero-mapped memory areas etc..
>>     */
>> -#define ZERO_PAGE(vaddr)       (virt_to_page(0))
>> +extern void *empty_zero_page;
>> +#define ZERO_PAGE(vaddr)       (virt_to_page(empty_zero_page))
>>
>>    /*
>>     * All 32bit addresses are effectively valid for vmalloc...
> 
> And after that (or combined with this?), this can be factored
> out from arch/m68k/include/asm/pgtable_{mm,no}.h into
> arch/m68k/include/asm/pgtable.h.

I think a new patch to do that work on top of this one would be best.
I will work on that.

Regards
Greg



> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
