Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307B8746D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfGYGJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 02:09:20 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40071 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfGYGJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:09:20 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 761F0E0008;
        Thu, 25 Jul 2019 06:09:11 +0000 (UTC)
Subject: Re: [PATCH REBASE v4 12/14] mips: Replace arch specific way to
 determine 32bit task with generic version
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190724055850.6232-1-alex@ghiti.fr>
 <20190724055850.6232-13-alex@ghiti.fr>
 <20190724171648.GW19023@42.do-not-panic.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <17fa5d60-2417-70cb-36b0-203b30b27624@ghiti.fr>
Date:   Thu, 25 Jul 2019 08:09:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190724171648.GW19023@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/19 7:16 PM, Luis Chamberlain wrote:
> On Wed, Jul 24, 2019 at 01:58:48AM -0400, Alexandre Ghiti wrote:
>> Mips uses TASK_IS_32BIT_ADDR to determine if a task is 32bit, but
>> this define is mips specific and other arches do not have it: instead,
>> use !IS_ENABLED(CONFIG_64BIT) || is_compat_task() condition.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/mips/mm/mmap.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
>> index faa5aa615389..d4eafbb82789 100644
>> --- a/arch/mips/mm/mmap.c
>> +++ b/arch/mips/mm/mmap.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/sched/signal.h>
>>   #include <linux/sched/mm.h>
>>   #include <linux/sizes.h>
>> +#include <linux/compat.h>
>>   
>>   unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
>>   EXPORT_SYMBOL(shm_align_mask);
>> @@ -191,7 +192,7 @@ static inline unsigned long brk_rnd(void)
>>   
>>   	rnd = rnd << PAGE_SHIFT;
>>   	/* 32MB for 32bit, 1GB for 64bit */
>> -	if (TASK_IS_32BIT_ADDR)
>> +	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
>>   		rnd = rnd & SZ_32M;
>>   	else
>>   		rnd = rnd & SZ_1G;
>> -- 
> Since there are at least two users why not just create an inline for
> this which describes what we are looking for and remove the comments?


Actually this is a preparatory patch, this will get merged with the 
generic version in the next patch.

Alex


>
>    Luis
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
