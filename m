Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2590171C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfEHGhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 02:37:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42390 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHGhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 02:37:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so9581980pgh.9;
        Tue, 07 May 2019 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J3Hx7lSVa9RM+MD0YA/rEF6s5uTatvCcVY2i2Gn/sss=;
        b=JFV3/FXGM+GCW2YVoUUA+bHx+GLPJ/Z3Msw4ByDIiveU5hDHFfZ2f64kfLI2adIH4k
         rcn2KMQQjdk/QSumQijvmpGNjIiqWPis5a+II1J2W07gIlCbyG4ZGN1lGdkAA+OCwAtN
         Pf+TnF060OUxsb3lRb0gUiZe3TdDDCG8m9mIqmrttsML8exYQQPUG3y1f5Tw0iGWRISA
         uShOVEMzsaoHdlfNlUmAD0fzWx2dr5BDgXT8+VoPrWL7kTTKKmM/Rr77B357tiQfowde
         jYPlXOCi5aqATYseDyQy/cwMj7Ho24+muWkM/5iZhDulVD17xfRH3NFyN2Wp+2ZEGnx8
         1pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3Hx7lSVa9RM+MD0YA/rEF6s5uTatvCcVY2i2Gn/sss=;
        b=DpucksbV4ZTYTPjo+y4/xAuCkMrWvJTO1hww4jf0QHjIHFJuHlx684wbTcmbdlCpTz
         REuTVyIWyjr9SUBM8OYgn+rNvJHL6FSoCOEN0whrwNIYn/40QAWe6hiUeL92LL2ska1Y
         M90by+81/4BRpx0cNKtSwRT73vH++jucs/VYuQaNv1Uy9I1WuhOpp2Y/jy92pVn6npGg
         hRmVMh57CXslZNa2k8R3GW/mvbBuKME+R20pqO39baNeyJGLEWkYE2slDxidsk7AvqTo
         w1yQFguXq2zArs54EgHgZlIzZUU1E5LT6Bu8Eg9KpfJLXcoSVpkhdtIfpFV7KwXzyNz5
         370g==
X-Gm-Message-State: APjAAAXLUUL9P70NHgr6FziwFdgmswWQkRGiWK/mnJ9dacjFvf5fnBlN
        MkuDia340+BlJLLSJI0osI4=
X-Google-Smtp-Source: APXvYqw0gzLSbHulQeWoMVfizgAAIgQoAZJFjmdx0wP1nhNd2efgTW5t3I2EJjZ2TePecLQmZAQD7w==
X-Received: by 2002:aa7:93ba:: with SMTP id x26mr27860579pff.238.1557297438394;
        Tue, 07 May 2019 23:37:18 -0700 (PDT)
Received: from localhost ([2601:640:2:82fb:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id j16sm18660321pfi.58.2019.05.07.23.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 23:37:17 -0700 (PDT)
Date:   Tue, 7 May 2019 23:37:16 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs/proc: add VmTaskSize field to /proc/$$/status
Message-ID: <20190508063716.GA3096@yury-thinkpad>
References: <1557158023-23021-1-git-send-email-jsavitz@redhat.com>
 <20190507125430.GA31025@x230.aquini.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507125430.GA31025@x230.aquini.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 08:54:31AM -0400, Rafael Aquini wrote:
> On Mon, May 06, 2019 at 11:53:43AM -0400, Joel Savitz wrote:
> > There is currently no easy and architecture-independent way to find the
> > lowest unusable virtual address available to a process without
> > brute-force calculation. This patch allows a user to easily retrieve
> > this value via /proc/<pid>/status.
> > 
> > Using this patch, any program that previously needed to waste cpu cycles
> > recalculating a non-sensitive process-dependent value already known to
> > the kernel can now be optimized to use this mechanism.
> > 
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > ---
> >  Documentation/filesystems/proc.txt | 2 ++
> >  fs/proc/task_mmu.c                 | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> > index 66cad5c86171..1c6a912e3975 100644
> > --- a/Documentation/filesystems/proc.txt
> > +++ b/Documentation/filesystems/proc.txt
> > @@ -187,6 +187,7 @@ read the file /proc/PID/status:
> >    VmLib:      1412 kB
> >    VmPTE:        20 kb
> >    VmSwap:        0 kB
> > +  VmTaskSize:	137438953468 kB
> >    HugetlbPages:          0 kB
> >    CoreDumping:    0
> >    THP_enabled:	  1
> > @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
> >   VmPTE                       size of page table entries
> >   VmSwap                      amount of swap used by anonymous private data
> >                               (shmem swap usage is not included)
> > + VmTaskSize                  lowest unusable address in process virtual memory
> 
> Can we change this help text to "size of process' virtual address space memory" ?

Agree. Or go in other direction and make it VmEnd

> >   HugetlbPages                size of hugetlb memory portions
> >   CoreDumping                 process's memory is currently being dumped
> >                               (killing the process may lead to a corrupted core)
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 95ca1fe7283c..0af7081f7b19 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -74,6 +74,8 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
> >  	seq_put_decimal_ull_width(m,
> >  		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
> >  	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
> > +	seq_put_decimal_ull_width(m,
> > +		    " kB\nVmTaskSize:\t", mm->task_size >> 10, 8);
> >  	seq_puts(m, " kB\n");
> >  	hugetlb_report_usage(m, mm);
> >  }

I'm OK with technical part, but I still have questions not answered
(or wrongly answered) in v1 and v2. Below is the very detailed
description of the concerns I have.

1. What is the exact reason for it? Original version tells about some
test that takes so much time that you were able to drink a cup of
coffee before it was done. The test as you said implements linear
search to find the last page and so is of O(n). If it's only for some
random test, I think the kernel can survive without it. Do you have a
real example of useful programs that suffer without this information?


2. I have nothing against taking breaks and see nothing weird if
ineffective algorithms take time. On my system (x86, Ubuntu) the last
mapped region according to /proc/<pid>/maps is:
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0     [vsyscall]
So to find the required address, we have to inspect 2559 pages. With a
binary search it would take 12 iterations at max. If my calculation is
wrong or your environment is completely different - please elaborate.

3. As far as I can see, Linux currently does not support dynamic
TASK_SIZE. It means that for any platform+ABI combination VmTaskSize
will be always the same. So VmTaskSize would be effectively useless waste
of lines. In fact, TASK SIZE is compiler time information and should
be exposed to user in headers. In discussion to v2 Rafael Aquini answered
for this concern that TASK_SIZE is a runtime resolved macro. It's
true, but my main point is: GCC knows what type of binary it compiles
and is able to select proper value. We are already doing similar things
where appropriate. Refer for example to my arm64/ilp32 series:

arch/arm64/include/uapi/asm/bitsperlong.h:
-#define __BITS_PER_LONG 64
+#if defined(__LP64__)
+/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
+#  define __BITS_PER_LONG 64
+#elif defined(__ILP32__)
+#  define __BITS_PER_LONG 32
+#else
+#  error "Neither LP64 nor ILP32: unsupported ABI in asm/bitsperlong.h"
+#endif

__LP64__ and __ILP32__ are symbols provided by GCC to distinguish
between ABIs. So userspace is able to take proper __BITS_PER_LONG value
at compile time, not at runtime. I think, you can do the same thing for
TASK_SIZE. If there are real usecases of the proposed feature, I think
programs will benefit even more if they will be able to get this info
at compile time.

Thaks,
Yury
