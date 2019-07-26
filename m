Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB8764CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 13:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfGZLsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 07:48:16 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51067 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfGZLsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:48:15 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3CAE81BF207;
        Fri, 26 Jul 2019 11:48:08 +0000 (UTC)
Subject: Re: [PATCH REBASE v4 14/14] riscv: Make mmap allocation top-down by
 default
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org,
        Daniel Cashman <dcashman@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20190724055850.6232-1-alex@ghiti.fr>
 <20190724055850.6232-15-alex@ghiti.fr>
 <alpine.DEB.2.21.9999.1907251655310.32766@viisi.sifive.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <6b2b45a5-0ac4-db73-8f50-ab182a0cb621@ghiti.fr>
Date:   Fri, 26 Jul 2019 13:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1907251655310.32766@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/26/19 2:20 AM, Paul Walmsley wrote:
> Hi Alexandre,
>
> I have a few questions about this patch.  Sorry to be dense here ...
>
> On Wed, 24 Jul 2019, Alexandre Ghiti wrote:
>
>> In order to avoid wasting user address space by using bottom-up mmap
>> allocation scheme, prefer top-down scheme when possible.
>>
>> Before:
>> root@qemuriscv64:~# cat /proc/self/maps
>> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
>> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
>> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
>> 00018000-00039000 rw-p 00000000 00:00 0          [heap]
>> 1555556000-155556d000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
>> 155556d000-155556e000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
>> 155556e000-155556f000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
>> 155556f000-1555570000 rw-p 00000000 00:00 0
>> 1555570000-1555572000 r-xp 00000000 00:00 0      [vdso]
>> 1555574000-1555576000 rw-p 00000000 00:00 0
>> 1555576000-1555674000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
>> 1555674000-1555678000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
>> 1555678000-155567a000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
>> 155567a000-15556a0000 rw-p 00000000 00:00 0
>> 3fffb90000-3fffbb1000 rw-p 00000000 00:00 0      [stack]
>>
>> After:
>> root@qemuriscv64:~# cat /proc/self/maps
>> 00010000-00016000 r-xp 00000000 fe:00 6389       /bin/cat.coreutils
>> 00016000-00017000 r--p 00005000 fe:00 6389       /bin/cat.coreutils
>> 00017000-00018000 rw-p 00006000 fe:00 6389       /bin/cat.coreutils
>> 2de81000-2dea2000 rw-p 00000000 00:00 0          [heap]
>> 3ff7eb6000-3ff7ed8000 rw-p 00000000 00:00 0
>> 3ff7ed8000-3ff7fd6000 r-xp 00000000 fe:00 7187   /lib/libc-2.28.so
>> 3ff7fd6000-3ff7fda000 r--p 000fd000 fe:00 7187   /lib/libc-2.28.so
>> 3ff7fda000-3ff7fdc000 rw-p 00101000 fe:00 7187   /lib/libc-2.28.so
>> 3ff7fdc000-3ff7fe2000 rw-p 00000000 00:00 0
>> 3ff7fe4000-3ff7fe6000 r-xp 00000000 00:00 0      [vdso]
>> 3ff7fe6000-3ff7ffd000 r-xp 00000000 fe:00 7193   /lib/ld-2.28.so
>> 3ff7ffd000-3ff7ffe000 r--p 00016000 fe:00 7193   /lib/ld-2.28.so
>> 3ff7ffe000-3ff7fff000 rw-p 00017000 fe:00 7193   /lib/ld-2.28.so
>> 3ff7fff000-3ff8000000 rw-p 00000000 00:00 0
>> 3fff888000-3fff8a9000 rw-p 00000000 00:00 0      [stack]
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>   arch/riscv/Kconfig | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 59a4727ecd6c..6a63973873fd 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -54,6 +54,17 @@ config RISCV
>>   	select EDAC_SUPPORT
>>   	select ARCH_HAS_GIGANTIC_PAGE
>>   	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>> +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>> +	select HAVE_ARCH_MMAP_RND_BITS
>> +
>> +config ARCH_MMAP_RND_BITS_MIN
>> +	default 18
> Could you help me understand the rationale behind this constant?


Indeed, I took that from arm64 code and I did not think enough about it: 
that's
great you spotted this because that's a way too large value for 32 bits 
as it would,
at minimum, make mmap random offset go up to 1GB (18 + 12), which is a 
big hole for
this small address space :)

arm and mips propose 8 as default value for 32bits systems which is 1MB 
offset at minimum.


>
>> +
>> +# max bits determined by the following formula:
>> +#  VA_BITS - PAGE_SHIFT - 3
> I realize that these lines are probably copied from arch/arm64/Kconfig.
> But the rationale behind the "- 3" is not immediately obvious.  This
> apparently originates from commit 8f0d3aa9de57 ("arm64: mm: support
> ARCH_MMAP_RND_BITS"). Can you provide any additional context here?


The formula comes from commit d07e22597d1d ("mm: mmap: add new /proc tunable
for mmap_base ASLR"), where the author states that "generally a 3-4 bits 
less than the
number of bits in the user-space accessible virtual address space 
[allows to] give the greatest
flexibility without generating an invalid mmap_base address".

In practice, that limits the mmap random offset to at maximum 1/8 (for - 
3) of the total address space.


>
>> +config ARCH_MMAP_RND_BITS_MAX
>> +	default 33 if 64BIT # SV48 based
> The rationale here is clear for Sv48, per the above formula:
>
>     (48 - 12 - 3) = 33
>
>> +	default 18
> However, here it is less clear to me.  For Sv39, shouldn't this be
>
>     (39 - 12 - 3) = 24
>
> ?  And what about Sv32?


You're right. Is there a way to distinguish between sv39 and sv48 here ?

Thanks Paul,

Alex

>   
>
> - Paul
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
