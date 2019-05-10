Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AF19727
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 05:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfEJDc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 23:32:28 -0400
Received: from ozlabs.org ([203.11.71.1]:37975 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfEJDc2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 23:32:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 450bPL6bGSz9sBp;
        Fri, 10 May 2019 13:32:22 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs/proc: add VmTaskSize field to /proc/$$/status
In-Reply-To: <20190508063716.GA3096@yury-thinkpad>
References: <1557158023-23021-1-git-send-email-jsavitz@redhat.com> <20190507125430.GA31025@x230.aquini.net> <20190508063716.GA3096@yury-thinkpad>
Date:   Fri, 10 May 2019 13:32:22 +1000
Message-ID: <87k1ezugqh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:
> On Tue, May 07, 2019 at 08:54:31AM -0400, Rafael Aquini wrote:
>> On Mon, May 06, 2019 at 11:53:43AM -0400, Joel Savitz wrote:
>> > There is currently no easy and architecture-independent way to find the
>> > lowest unusable virtual address available to a process without
>> > brute-force calculation. This patch allows a user to easily retrieve
>> > this value via /proc/<pid>/status.
>> > 
>> > Using this patch, any program that previously needed to waste cpu cycles
>> > recalculating a non-sensitive process-dependent value already known to
>> > the kernel can now be optimized to use this mechanism.
>> > 
>> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> > ---
>> >  Documentation/filesystems/proc.txt | 2 ++
>> >  fs/proc/task_mmu.c                 | 2 ++
>> >  2 files changed, 4 insertions(+)
>> > 
>> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
>> > index 66cad5c86171..1c6a912e3975 100644
>> > --- a/Documentation/filesystems/proc.txt
>> > +++ b/Documentation/filesystems/proc.txt
>> > @@ -187,6 +187,7 @@ read the file /proc/PID/status:
>> >    VmLib:      1412 kB
>> >    VmPTE:        20 kb
>> >    VmSwap:        0 kB
>> > +  VmTaskSize:	137438953468 kB
>> >    HugetlbPages:          0 kB
>> >    CoreDumping:    0
>> >    THP_enabled:	  1
>> > @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
>> >   VmPTE                       size of page table entries
>> >   VmSwap                      amount of swap used by anonymous private data
>> >                               (shmem swap usage is not included)
>> > + VmTaskSize                  lowest unusable address in process virtual memory
>> 
>> Can we change this help text to "size of process' virtual address space memory" ?
>
> Agree. Or go in other direction and make it VmEnd

Yeah I think VmEnd would be clearer to folks who aren't familiar with
the kernel's usage of the TASK_SIZE terminology.

>> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> > index 95ca1fe7283c..0af7081f7b19 100644
>> > --- a/fs/proc/task_mmu.c
>> > +++ b/fs/proc/task_mmu.c
>> > @@ -74,6 +74,8 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>> >  	seq_put_decimal_ull_width(m,
>> >  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
>> >  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
>> > +	seq_put_decimal_ull_width(m,
>> > +		    " kB\nVmTaskSize:\t", mm->task_size >> 10, 8);
>> >  	seq_puts(m, " kB\n");
>> >  	hugetlb_report_usage(m, mm);
>> >  }
>
> I'm OK with technical part, but I still have questions not answered
> (or wrongly answered) in v1 and v2. Below is the very detailed
> description of the concerns I have.
>
> 1. What is the exact reason for it? Original version tells about some
> test that takes so much time that you were able to drink a cup of
> coffee before it was done. The test as you said implements linear
> search to find the last page and so is of O(n). If it's only for some
> random test, I think the kernel can survive without it. Do you have a
> real example of useful programs that suffer without this information?
>
>
> 2. I have nothing against taking breaks and see nothing weird if
> ineffective algorithms take time. On my system (x86, Ubuntu) the last
> mapped region according to /proc/<pid>/maps is:
> ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0     [vsyscall]
> So to find the required address, we have to inspect 2559 pages. With a
> binary search it would take 12 iterations at max. If my calculation is
> wrong or your environment is completely different - please elaborate.

I agree it should not be hard to calculate, but at the same time it's
trivial for the kernel to export the information so I don't see why the
kernel shouldn't.

> 3. As far as I can see, Linux currently does not support dynamic
> TASK_SIZE. It means that for any platform+ABI combination VmTaskSize
> will be always the same. So VmTaskSize would be effectively useless waste
> of lines. In fact, TASK SIZE is compiler time information and should
> be exposed to user in headers. In discussion to v2 Rafael Aquini answered
> for this concern that TASK_SIZE is a runtime resolved macro. It's
> true, but my main point is: GCC knows what type of binary it compiles
> and is able to select proper value. We are already doing similar things
> where appropriate. Refer for example to my arm64/ilp32 series:
>
> arch/arm64/include/uapi/asm/bitsperlong.h:
> -#define __BITS_PER_LONG 64
> +#if defined(__LP64__)
> +/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
> +#  define __BITS_PER_LONG 64
> +#elif defined(__ILP32__)
> +#  define __BITS_PER_LONG 32
> +#else
> +#  error "Neither LP64 nor ILP32: unsupported ABI in asm/bitsperlong.h"
> +#endif
>
> __LP64__ and __ILP32__ are symbols provided by GCC to distinguish
> between ABIs. So userspace is able to take proper __BITS_PER_LONG value
> at compile time, not at runtime. I think, you can do the same thing for
> TASK_SIZE.

No you can't do it at compile time for TASK_SIZE.

On powerpc a 64-bit program might run on a kernel built with 4K pages
where TASK_SIZE is 64TB, and that same program can run on a kernel built
with 64K pages where TASK_SIZE is 4PB.

And it's not just determined by PAGE_SIZE, that same program might also
run on an older kernel where TASK_SIZE with 64K pages was 512TB.

cheers
