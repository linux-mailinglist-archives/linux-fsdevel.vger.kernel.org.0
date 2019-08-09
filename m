Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423AF87682
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406199AbfHIJp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 05:45:56 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35101 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406138AbfHIJp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:56 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 732B46000D;
        Fri,  9 Aug 2019 09:45:51 +0000 (UTC)
Subject: Re: [PATCH v6 11/14] mips: Adjust brk randomization offset to fit
 generic version
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
 <20190808061756.19712-12-alex@ghiti.fr>
 <68ec5cf6-6ba3-68ab-aa01-668b701c642f@cogentembedded.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <7b7e256d-5106-3022-9ded-0af4193b6b8b@ghiti.fr>
Date:   Fri, 9 Aug 2019 11:45:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <68ec5cf6-6ba3-68ab-aa01-668b701c642f@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/19 11:19 AM, Sergei Shtylyov wrote:
> Hello!
>
> On 08.08.2019 9:17, Alexandre Ghiti wrote:
>
>> This commit simply bumps up to 32MB and 1GB the random offset
>> of brk, compared to 8MB and 256MB, for 32bit and 64bit respectively.
>>
>> Suggested-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Acked-by: Paul Burton <paul.burton@mips.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   arch/mips/mm/mmap.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
>> index a7e84b2e71d7..ff6ab87e9c56 100644
>> --- a/arch/mips/mm/mmap.c
>> +++ b/arch/mips/mm/mmap.c
> [...]
>> @@ -189,11 +190,11 @@ static inline unsigned long brk_rnd(void)
>>       unsigned long rnd = get_random_long();
>>         rnd = rnd << PAGE_SHIFT;
>> -    /* 8MB for 32bit, 256MB for 64bit */
>> +    /* 32MB for 32bit, 1GB for 64bit */
>>       if (TASK_IS_32BIT_ADDR)
>> -        rnd = rnd & 0x7ffffful;
>> +        rnd = rnd & (SZ_32M - 1);
>>       else
>> -        rnd = rnd & 0xffffffful;
>> +        rnd = rnd & (SZ_1G - 1);
>
>    Why not make these 'rnd &= SZ_* - 1', while at it anyways?


You're right, I could have. Again, this code gets removed afterwards, so 
I think it's ok
to leave it as is.

Anyway, thanks for your remarks Sergei !

Alex


>
> [...]
>
> MBR, Sergei
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
