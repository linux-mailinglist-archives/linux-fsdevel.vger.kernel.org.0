Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53595B071
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 17:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF3Pe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 11:34:59 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43203 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfF3Pe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 11:34:58 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9122DE0004;
        Sun, 30 Jun 2019 15:34:41 +0000 (UTC)
Subject: Re: [PATCH v4 00/14] Provide generic top-down mmap layout functions
From:   Alex Ghiti <alex@ghiti.fr>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190526134746.9315-1-alex@ghiti.fr>
 <bfb1565d-0468-8ea8-19f9-b862faa4f1d4@ghiti.fr>
Message-ID: <c4049021-50fd-32e5-7052-24d58b31e072@ghiti.fr>
Date:   Sun, 30 Jun 2019 11:34:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bfb1565d-0468-8ea8-19f9-b862faa4f1d4@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: sv-FI
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/13/19 1:29 AM, Alex Ghiti wrote:
> On 5/26/19 9:47 AM, Alexandre Ghiti wrote:
>> This series introduces generic functions to make top-down mmap layout
>> easily accessible to architectures, in particular riscv which was
>> the initial goal of this series.
>> The generic implementation was taken from arm64 and used successively
>> by arm, mips and finally riscv.
>>
>> Note that in addition the series fixes 2 issues:
>> - stack randomization was taken into account even if not necessary.
>> - [1] fixed an issue with mmap base which did not take into account
>>    randomization but did not report it to arm and mips, so by moving
>>    arm64 into a generic library, this problem is now fixed for both
>>    architectures.
>>
>> This work is an effort to factorize architecture functions to avoid
>> code duplication and oversights as in [1].
>>
>> [1]: 
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html
>>
>> Changes in v4:
>>    - Make ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT select 
>> ARCH_HAS_ELF_RANDOMIZE
>>      by default as suggested by Kees,
>>    - ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT depends on MMU and defines 
>> the
>>      functions needed by ARCH_HAS_ELF_RANDOMIZE => architectures that 
>> use
>>      the generic mmap topdown functions cannot have 
>> ARCH_HAS_ELF_RANDOMIZE
>>      selected without MMU, but I think it's ok since randomization 
>> without
>>      MMU does not add much security anyway.
>>    - There is no common API to determine if a process is 32b, so I 
>> came up with
>>      !IS_ENABLED(CONFIG_64BIT) || is_compat_task() in [PATCH v4 12/14].
>>    - Mention in the change log that x86 already takes care of not 
>> offseting mmap
>>      base address if the task does not want randomization.
>>    - Re-introduce a comment that should not have been removed.
>>    - Add Reviewed/Acked-By from Paul, Christoph and Kees, thank you 
>> for that.
>>    - I tried to minimize the changes from the commits in v3 in order 
>> to make
>>      easier the review of the v4, the commits changed or added are:
>>      - [PATCH v4 5/14]
>>      - [PATCH v4 8/14]
>>      - [PATCH v4 11/14]
>>      - [PATCH v4 12/14]
>>      - [PATCH v4 13/14]
>
> Hi Paul,
>
> Compared to the previous version you already acked, patches 11, 12 and 13
> would need your feedback, do you have time to take a look at them ?
>
> Hope I don't bother you,
>
> Thanks,
>
> Alex
>

Hi Paul,

Would you have time to give your feedback on patches 11, 12 and 13 ?

Thanks,

Alex


>
>>
>> Changes in v3:
>>    - Split into small patches to ease review as suggested by Christoph
>>      Hellwig and Kees Cook
>>    - Move help text of new config as a comment, as suggested by 
>> Christoph
>>    - Make new config depend on MMU, as suggested by Christoph
>>
>> Changes in v2 as suggested by Christoph Hellwig:
>>    - Preparatory patch that moves randomize_stack_top
>>    - Fix duplicate config in riscv
>>    - Align #if defined on next line => this gives rise to a checkpatch
>>      warning. I found this pattern all around the tree, in the same 
>> proportion
>>      as the previous pattern which was less pretty:
>>      git grep -C 1 -n -P "^#if defined.+\|\|.*\\\\$"
>>
>> Alexandre Ghiti (14):
>>    mm, fs: Move randomize_stack_top from fs to mm
>>    arm64: Make use of is_compat_task instead of hardcoding this test
>>    arm64: Consider stack randomization for mmap base only when necessary
>>    arm64, mm: Move generic mmap layout functions to mm
>>    arm64, mm: Make randomization selected by generic topdown mmap layout
>>    arm: Properly account for stack randomization and stack guard gap
>>    arm: Use STACK_TOP when computing mmap base address
>>    arm: Use generic mmap top-down layout and brk randomization
>>    mips: Properly account for stack randomization and stack guard gap
>>    mips: Use STACK_TOP when computing mmap base address
>>    mips: Adjust brk randomization offset to fit generic version
>>    mips: Replace arch specific way to determine 32bit task with generic
>>      version
>>    mips: Use generic mmap top-down layout and brk randomization
>>    riscv: Make mmap allocation top-down by default
>>
>>   arch/Kconfig                       |  11 +++
>>   arch/arm/Kconfig                   |   2 +-
>>   arch/arm/include/asm/processor.h   |   2 -
>>   arch/arm/kernel/process.c          |   5 --
>>   arch/arm/mm/mmap.c                 |  52 --------------
>>   arch/arm64/Kconfig                 |   2 +-
>>   arch/arm64/include/asm/processor.h |   2 -
>>   arch/arm64/kernel/process.c        |   8 ---
>>   arch/arm64/mm/mmap.c               |  72 -------------------
>>   arch/mips/Kconfig                  |   2 +-
>>   arch/mips/include/asm/processor.h  |   5 --
>>   arch/mips/mm/mmap.c                |  84 ----------------------
>>   arch/riscv/Kconfig                 |  11 +++
>>   fs/binfmt_elf.c                    |  20 ------
>>   include/linux/mm.h                 |   2 +
>>   kernel/sysctl.c                    |   6 +-
>>   mm/util.c                          | 107 ++++++++++++++++++++++++++++-
>>   17 files changed, 137 insertions(+), 256 deletions(-)
>>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
