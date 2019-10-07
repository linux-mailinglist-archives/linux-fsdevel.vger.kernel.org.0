Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5D9CDE06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfJGJLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 05:11:48 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56809 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfJGJLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:11:48 -0400
X-Originating-IP: 81.185.168.108
Received: from [192.168.43.237] (108.168.185.81.rev.sfr.net [81.185.168.108])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E44E71BF20D;
        Mon,  7 Oct 2019 09:11:35 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 14/14] riscv: Make mmap allocation top-down by default
References: <20190808061756.19712-1-alex@ghiti.fr>
 <20190808061756.19712-15-alex@ghiti.fr>
 <208433f810b5b07b1e679d7eedb028697dff851b.camel@wdc.com>
Message-ID: <60b52f20-a2c7-dee9-7cf3-a727f07400b9@ghiti.fr>
Date:   Mon, 7 Oct 2019 05:11:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <208433f810b5b07b1e679d7eedb028697dff851b.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/19 10:12 PM, Atish Patra wrote:
> On Thu, 2019-08-08 at 02:17 -0400, Alexandre Ghiti wrote:
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
>> Acked-by: Paul Walmsley <paul.walmsley@sifive.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   arch/riscv/Kconfig | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 59a4727ecd6c..87dc5370becb 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -54,6 +54,18 @@ config RISCV
>>   	select EDAC_SUPPORT
>>   	select ARCH_HAS_GIGANTIC_PAGE
>>   	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>> +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>> +	select HAVE_ARCH_MMAP_RND_BITS
>> +
>> +config ARCH_MMAP_RND_BITS_MIN
>> +	default 18 if 64BIT
>> +	default 8
>> +
>> +# max bits determined by the following formula:
>> +#  VA_BITS - PAGE_SHIFT - 3
>> +config ARCH_MMAP_RND_BITS_MAX
>> +	default 24 if 64BIT # SV39 based
>> +	default 17
>>   
>>   config MMU
>>   	def_bool y
> With this patch, I am not able to boot a Fedora Linux(a Gnome desktop
> image) on RISC-V hardware (Unleashed + Microsemi Expansion board). The
> booting gets stuck right after systemd starts.
>
> https://paste.fedoraproject.org/paste/TOrUMqqKH-pGFX7CnfajDg
>
> Reverting just this patch allow to boot Fedora successfully on specific
> RISC-V hardware. I have not root caused the issue but it looks like it
> might have messed userpsace mapping.

It might have messed userspace mapping but not enough to make userspace 
completely broken
as systemd does some things. I would try to boot in legacy layout: if 
you can try to set sysctl legacy_va_layout
at boottime, it will map userspace as it was before (bottom-up). If that 
does not work, the problem could
be the randomization that is activated by default now.
Anyway, it's weird since userspace should not depend on how the mapping is.

If you can identify the program that stalls, that would be fantastic :)

As the code is common to mips and arm now and I did not hear from them, 
I imagine the problem comes
from us.

Alex
>
