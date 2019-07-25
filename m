Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E6674610
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbfGYFsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 01:48:51 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58705 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfGYFsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:48:51 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 83A0560002;
        Thu, 25 Jul 2019 05:48:44 +0000 (UTC)
Subject: Re: [PATCH REBASE v4 05/14] arm64, mm: Make randomization selected by
 generic topdown mmap layout
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
 <20190724055850.6232-6-alex@ghiti.fr>
 <20190724171123.GV19023@42.do-not-panic.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <8dd7b018-7f17-0018-0fcf-d0257976d275@ghiti.fr>
Date:   Thu, 25 Jul 2019 07:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190724171123.GV19023@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/19 7:11 PM, Luis Chamberlain wrote:
> On Wed, Jul 24, 2019 at 01:58:41AM -0400, Alexandre Ghiti wrote:
>> diff --git a/mm/util.c b/mm/util.c
>> index 0781e5575cb3..16f1e56e2996 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -321,7 +321,15 @@ unsigned long randomize_stack_top(unsigned long stack_top)
>>   }
>>   
>>   #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>> -#ifdef CONFIG_ARCH_HAS_ELF_RANDOMIZE
>> +unsigned long arch_randomize_brk(struct mm_struct *mm)
>> +{
>> +	/* Is the current task 32bit ? */
>> +	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
>> +		return randomize_page(mm->brk, SZ_32M);
>> +
>> +	return randomize_page(mm->brk, SZ_1G);
>> +}
>> +
>>   unsigned long arch_mmap_rnd(void)
>>   {
>>   	unsigned long rnd;
>> @@ -335,7 +343,6 @@ unsigned long arch_mmap_rnd(void)
>>   
>>   	return rnd << PAGE_SHIFT;
>>   }
> So arch_randomize_brk is no longer ifdef'd around
> CONFIG_ARCH_HAS_ELF_RANDOMIZE either and yet the header
> still has it. Is that intentional?
>

Yes, CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT selects 
CONFIG_ARCH_HAS_ELF_RANDOMIZE, that's what's new about v4: the generic
functions proposed in this series come with elf randomization.


Alex


>    Luis
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
