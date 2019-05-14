Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEF91C328
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 08:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfENGRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 02:17:50 -0400
Received: from ozlabs.org ([203.11.71.1]:38889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENGRu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 02:17:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4536tL62z0z9s00;
        Tue, 14 May 2019 16:17:46 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Rafael Aquini <aquini@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
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
In-Reply-To: <20190510072500.GA1520@yury-thinkpad>
References: <1557158023-23021-1-git-send-email-jsavitz@redhat.com> <20190507125430.GA31025@x230.aquini.net> <20190508063716.GA3096@yury-thinkpad> <87k1ezugqh.fsf@concordia.ellerman.id.au> <20190510072500.GA1520@yury-thinkpad>
Date:   Tue, 14 May 2019 16:17:46 +1000
Message-ID: <87k1ettv91.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yury Norov <yury.norov@gmail.com> writes:
> On Fri, May 10, 2019 at 01:32:22PM +1000, Michael Ellerman wrote:
>> Yury Norov <yury.norov@gmail.com> writes:
>> > On Tue, May 07, 2019 at 08:54:31AM -0400, Rafael Aquini wrote:
>> >> On Mon, May 06, 2019 at 11:53:43AM -0400, Joel Savitz wrote:
>> >> > There is currently no easy and architecture-independent way to find the
>> >> > lowest unusable virtual address available to a process without
>> >> > brute-force calculation. This patch allows a user to easily retrieve
>> >> > this value via /proc/<pid>/status.
>> >> > 
>> >> > Using this patch, any program that previously needed to waste cpu cycles
>> >> > recalculating a non-sensitive process-dependent value already known to
>> >> > the kernel can now be optimized to use this mechanism.
>> >> > 
>> >> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> >> > ---
>> >> >  Documentation/filesystems/proc.txt | 2 ++
>> >> >  fs/proc/task_mmu.c                 | 2 ++
>> >> >  2 files changed, 4 insertions(+)
>> >> > 
>> >> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
>> >> > index 66cad5c86171..1c6a912e3975 100644
>> >> > --- a/Documentation/filesystems/proc.txt
>> >> > +++ b/Documentation/filesystems/proc.txt
>> >> > @@ -187,6 +187,7 @@ read the file /proc/PID/status:
>> >> >    VmLib:      1412 kB
>> >> >    VmPTE:        20 kb
>> >> >    VmSwap:        0 kB
>> >> > +  VmTaskSize:	137438953468 kB
>> >> >    HugetlbPages:          0 kB
>> >> >    CoreDumping:    0
>> >> >    THP_enabled:	  1
>> >> > @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
>> >> >   VmPTE                       size of page table entries
>> >> >   VmSwap                      amount of swap used by anonymous private data
>> >> >                               (shmem swap usage is not included)
>> >> > + VmTaskSize                  lowest unusable address in process virtual memory
>> >> 
>> >> Can we change this help text to "size of process' virtual address space memory" ?
>> >
>> > Agree. Or go in other direction and make it VmEnd
>> 
>> Yeah I think VmEnd would be clearer to folks who aren't familiar with
>> the kernel's usage of the TASK_SIZE terminology.
>> 
>> >> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> >> > index 95ca1fe7283c..0af7081f7b19 100644
>> >> > --- a/fs/proc/task_mmu.c
>> >> > +++ b/fs/proc/task_mmu.c
>> >> > @@ -74,6 +74,8 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
>> >> >  	seq_put_decimal_ull_width(m,
>> >> >  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
>> >> >  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
>> >> > +	seq_put_decimal_ull_width(m,
>> >> > +		    " kB\nVmTaskSize:\t", mm->task_size >> 10, 8);
>> >> >  	seq_puts(m, " kB\n");
>> >> >  	hugetlb_report_usage(m, mm);
>> >> >  }
>> >
>> > I'm OK with technical part, but I still have questions not answered
>> > (or wrongly answered) in v1 and v2. Below is the very detailed
>> > description of the concerns I have.
>> >
>> > 1. What is the exact reason for it? Original version tells about some
>> > test that takes so much time that you were able to drink a cup of
>> > coffee before it was done. The test as you said implements linear
>> > search to find the last page and so is of O(n). If it's only for some
>> > random test, I think the kernel can survive without it. Do you have a
>> > real example of useful programs that suffer without this information?
>> >
>> >
>> > 2. I have nothing against taking breaks and see nothing weird if
>> > ineffective algorithms take time. On my system (x86, Ubuntu) the last
>> > mapped region according to /proc/<pid>/maps is:
>> > ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0     [vsyscall]
>> > So to find the required address, we have to inspect 2559 pages. With a
>> > binary search it would take 12 iterations at max. If my calculation is
>> > wrong or your environment is completely different - please elaborate.
>> 
>> I agree it should not be hard to calculate, but at the same time it's
>> trivial for the kernel to export the information so I don't see why the
>> kernel shouldn't.
>
> Kernel shouldn't do it unless there will be real users of the feature.
> Otherwise it's pure bloating.

A single line or two of code to print a value that's useful information
for userspace is hardly "bloat".

I agree it's good to have users for things, but this seems like it's so
trivial that we should just add it and someone will find a use for it.

> One possible user of it that I can imagine is mmap(MAP_FIXED). The
> documentation is very clear about it:
>
>    Furthermore,  this  option  is  extremely  hazardous (when used on its own),
>    because it forcibly removes preexisting mappings, making it easy for a 
>    multithreaded  process  to corrupt its own address space.
>
> VmEnd provided by kernel may encourage people to solve their problems
> by using MAP_FIXED which is potentially dangerous.

There's MAP_FIXED_NOREPLACE now which is not dangerous.

Using MAX_FIXED_NOREPLACE and VmEnd would make it relatively easy to do
a userspace ASLR implementation, so that actually is an argument in
favour IMHO.

> Another scenario of VmEnd is to understand how many top bits of address will
> be always zero to allocate them for user's purpose, like smart pointers. It
> worth to discuss this usecase with compiler people. If they have interest,
> I think it's more straightforward to give them something like:
>    int preserve_top_bits(int nbits);

You mean a syscall?

With things like hardware pointer tagging / colouring coming along I
think you're right that using VmEnd and assuming the top bits are never
used is a bad idea, an explicit interface would be better.

cheers
