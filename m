Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2648766F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406054AbfHIJoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 05:44:46 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34063 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbfHIJop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:44:45 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5865C6000D;
        Fri,  9 Aug 2019 09:44:39 +0000 (UTC)
Subject: Re: [PATCH v6 09/14] mips: Properly account for stack randomization
 and stack guard gap
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        James Hogan <jhogan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20190808061756.19712-1-alex@ghiti.fr>
 <20190808061756.19712-10-alex@ghiti.fr>
 <bd67507e-8a5b-34b5-1a33-5500bbb724b2@cogentembedded.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <91e31484-b268-2c90-1dd1-98cec349af6c@ghiti.fr>
Date:   Fri, 9 Aug 2019 11:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bd67507e-8a5b-34b5-1a33-5500bbb724b2@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/19 11:16 AM, Sergei Shtylyov wrote:
> Hello!
>
> On 08.08.2019 9:17, Alexandre Ghiti wrote:
>
>> This commit takes care of stack randomization and stack guard gap when
>> computing mmap base address and checks if the task asked for 
>> randomization.
>>
>> This fixes the problem uncovered and not fixed for arm here:
>> https://lkml.kernel.org/r/20170622200033.25714-1-riel@redhat.com
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Acked-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Paul Burton <paul.burton@mips.com>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   arch/mips/mm/mmap.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
>> index d79f2b432318..f5c778113384 100644
>> --- a/arch/mips/mm/mmap.c
>> +++ b/arch/mips/mm/mmap.c
>> @@ -21,8 +21,9 @@ unsigned long shm_align_mask = PAGE_SIZE - 1;    /* 
>> Sane caches */
>>   EXPORT_SYMBOL(shm_align_mask);
>>     /* gap between mmap and stack */
>> -#define MIN_GAP (128*1024*1024UL)
>> -#define MAX_GAP ((TASK_SIZE)/6*5)
>> +#define MIN_GAP        (128*1024*1024UL)
>> +#define MAX_GAP        ((TASK_SIZE)/6*5)
>
>    Could add spaces around *, while touching this anyway? And parens
> around TASK_SIZE shouldn't be needed...
>

I did not fix checkpatch warnings here since this code gets removed 
afterwards.


>> +#define STACK_RND_MASK    (0x7ff >> (PAGE_SHIFT - 12))
>>     static int mmap_is_legacy(struct rlimit *rlim_stack)
>>   {
>> @@ -38,6 +39,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
>>   static unsigned long mmap_base(unsigned long rnd, struct rlimit 
>> *rlim_stack)
>>   {
>>       unsigned long gap = rlim_stack->rlim_cur;
>> +    unsigned long pad = stack_guard_gap;
>> +
>> +    /* Account for stack randomization if necessary */
>> +    if (current->flags & PF_RANDOMIZE)
>> +        pad += (STACK_RND_MASK << PAGE_SHIFT);
>
>    Parens not needed here.


Belt and braces approach here as I'm never sure about priorities.

Thanks for your time,

Alex


>
>> +
>> +    /* Values close to RLIM_INFINITY can overflow. */
>> +    if (gap + pad > gap)
>> +        gap += pad;
>>         if (gap < MIN_GAP)
>>           gap = MIN_GAP;
>>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
