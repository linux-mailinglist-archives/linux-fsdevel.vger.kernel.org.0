Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0117248D74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHRRqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 13:46:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14412 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgHRRqe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:46:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWJHm6yfkz9vCpm;
        Tue, 18 Aug 2020 19:46:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PUJiHemN8w2H; Tue, 18 Aug 2020 19:46:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWJHm57LBz9vCpk;
        Tue, 18 Aug 2020 19:46:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 98DFD8B7EC;
        Tue, 18 Aug 2020 19:46:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 23Wk_hhLKoET; Tue, 18 Aug 2020 19:46:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D7D58B7D7;
        Tue, 18 Aug 2020 19:46:29 +0200 (CEST)
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200817073212.830069-1-hch@lst.de>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <319d15b1-cb4a-a7b4-3082-12bb30eb5143@csgroup.eu>
Date:   Tue, 18 Aug 2020 19:46:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817073212.830069-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 17/08/2020 à 09:32, Christoph Hellwig a écrit :
> Hi all,
> 
> this series removes the last set_fs() used to force a kernel address
> space for the uaccess code in the kernel read/write/splice code, and then
> stops implementing the address space overrides entirely for x86 and
> powerpc.
> 
> The file system part has been posted a few times, and the read/write side
> has been pretty much unchanced.  For splice this series drops the
> conversion of the seq_file and sysctl code to the iter ops, and thus loses
> the splice support for them.  The reasons for that is that it caused a lot
> of churn for not much use - splice for these small files really isn't much
> of a win, even if existing userspace uses it.  All callers I found do the
> proper fallback, but if this turns out to be an issue the conversion can
> be resurrected.

I like this series.

I gave it a go on my powerpc mpc832x. I tested it on top of my newest 
series that reworks the 32 bits signal handlers (see 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=196278) 
with the microbenchmark test used is that series.

With KUAP activated, on top of signal32 rework, performance is boosted 
as system time for the microbenchmark goes from 1.73s down to 1.56s, 
that is 10% quicker

Surprisingly, with the kernel as is today without my signal's series, 
your series degrades performance slightly (from 2.55s to 2.64s ie 3.5% 
slower).


I also observe, in both cases, a degradation on

	dd if=/dev/zero of=/dev/null count=1M

Without your series, it runs in 5.29 seconds.
With your series, it runs in 5.82 seconds, that is 10% more time.

Christophe


> 
> Besides x86 and powerpc I plan to eventually convert all other
> architectures, although this will be a slow process, starting with the
> easier ones once the infrastructure is merged.  The process to convert
> architectures is roughtly:
> 
>   - ensure there is no set_fs(KERNEL_DS) left in arch specific code
>   - implement __get_kernel_nofault and __put_kernel_nofault
>   - remove the arch specific address limitation functionality
> 
> Diffstat:
>   arch/Kconfig                           |    3
>   arch/alpha/Kconfig                     |    1
>   arch/arc/Kconfig                       |    1
>   arch/arm/Kconfig                       |    1
>   arch/arm64/Kconfig                     |    1
>   arch/c6x/Kconfig                       |    1
>   arch/csky/Kconfig                      |    1
>   arch/h8300/Kconfig                     |    1
>   arch/hexagon/Kconfig                   |    1
>   arch/ia64/Kconfig                      |    1
>   arch/m68k/Kconfig                      |    1
>   arch/microblaze/Kconfig                |    1
>   arch/mips/Kconfig                      |    1
>   arch/nds32/Kconfig                     |    1
>   arch/nios2/Kconfig                     |    1
>   arch/openrisc/Kconfig                  |    1
>   arch/parisc/Kconfig                    |    1
>   arch/powerpc/include/asm/processor.h   |    7 -
>   arch/powerpc/include/asm/thread_info.h |    5 -
>   arch/powerpc/include/asm/uaccess.h     |   78 ++++++++-----------
>   arch/powerpc/kernel/signal.c           |    3
>   arch/powerpc/lib/sstep.c               |    6 -
>   arch/riscv/Kconfig                     |    1
>   arch/s390/Kconfig                      |    1
>   arch/sh/Kconfig                        |    1
>   arch/sparc/Kconfig                     |    1
>   arch/um/Kconfig                        |    1
>   arch/x86/ia32/ia32_aout.c              |    1
>   arch/x86/include/asm/page_32_types.h   |   11 ++
>   arch/x86/include/asm/page_64_types.h   |   38 +++++++++
>   arch/x86/include/asm/processor.h       |   60 ---------------
>   arch/x86/include/asm/thread_info.h     |    2
>   arch/x86/include/asm/uaccess.h         |   26 ------
>   arch/x86/kernel/asm-offsets.c          |    3
>   arch/x86/lib/getuser.S                 |   28 ++++---
>   arch/x86/lib/putuser.S                 |   21 +++--
>   arch/xtensa/Kconfig                    |    1
>   drivers/char/mem.c                     |   16 ----
>   drivers/misc/lkdtm/bugs.c              |    2
>   drivers/misc/lkdtm/core.c              |    4 +
>   drivers/misc/lkdtm/usercopy.c          |    2
>   fs/read_write.c                        |   69 ++++++++++-------
>   fs/splice.c                            |  130 +++------------------------------
>   include/linux/fs.h                     |    2
>   include/linux/uaccess.h                |   18 ++++
>   lib/test_bitmap.c                      |   10 ++
>   46 files changed, 235 insertions(+), 332 deletions(-)
> 
