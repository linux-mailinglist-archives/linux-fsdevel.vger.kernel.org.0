Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5C69169D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 03:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjBJCRg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 21:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjBJCRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:17:35 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D28E;
        Thu,  9 Feb 2023 18:17:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id c26so7421834ejz.10;
        Thu, 09 Feb 2023 18:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1tqXg3lTHuYhO3PYxa8ckLfQP4DYSez0FfMlm1jO9M=;
        b=dFQ+1Njf9U3UFNMMYwcTahPoEGDw1vKDahTBV0JuMILGZkl14mr+DQt4Lc+m39ECJp
         qIPk4s39B4xKvLC2GT+7DAg+mg7VDRXYNy5nqs8DmdEgEjOwOcGLCfAUP4kzXKyZ4Kh2
         HPRkEUJapJZnJj3+DHV+5lhFABPrgXE7wa/gFe+mDOgchgQdJxgclQQT+/CVbmvpYqx3
         DGiK6bsKlhUz4U8hdhbTOoDIG6Ddx0R9MayHN87Pc7vR9URZxb9Cmgs8jns2vHVnlJTa
         +LA7bWftrMerrKsaYj0G8KAITb2/phExYzCNNdESb+MLjjb6u8J19mWBFBN0iXl1Qk8y
         AeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1tqXg3lTHuYhO3PYxa8ckLfQP4DYSez0FfMlm1jO9M=;
        b=SPtqIs2Mjc+psLfAzIXOQuaZ6Mdu4iecCY7QnO3QHUO7XN80UWkpK4EaLIt2AJIQnd
         o0lwT3g45pGdafXjpAkgx0VPkWq3kpJkEX1m2TatqHQE0a0TAGm9RhbYoPvfACj/M1cT
         kCj1qjZyAIodkPNgfQKJTsbl3V4jzMtvIndvemTrgTMChPmedMz1Sk54mbzn7m+LGgVB
         7C0MvRVhL93MHUHokJJsj3kR29JB8dtVNcrHtvbHsfeV6GM5OW0njubRcwslSq9HTh6o
         tLUJU41rBeZfUmGAqKiWE576cOH+/iGiuwQ6R2MAyNDhed/HOpMUBWvz5I20IzBZlviF
         CMMQ==
X-Gm-Message-State: AO0yUKVhoetzDYLrKXBQ8sSn1eoYzX226IadTn3PXJCPd77DXbBDTVc9
        Lcgc2gwiMzKUQuTzBjA54l88FcP1bXiSG9ynt88=
X-Google-Smtp-Source: AK7set+ilnXS/aCjnL5Jrl+9Iqi2dHQSIffms81BTs3qv/fQUX30Qz3E2s4n0587IxA/C0Ijcu6p5TPRjcBrALyhnbA=
X-Received: by 2002:a17:906:8455:b0:878:8103:985 with SMTP id
 e21-20020a170906845500b0087881030985mr944766ejy.10.1675995450824; Thu, 09 Feb
 2023 18:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20230207035139.272707-1-shiyn.lin@gmail.com> <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
From:   Chih-En Lin <shiyn.lin@gmail.com>
Date:   Fri, 10 Feb 2023 10:17:19 +0800
Message-ID: <CANOhDtU3J8SUCzKtKvPPPrUHyo+LV5npNObHtYP_AK4W3LomDw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 2:16 AM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Mon, Feb 6, 2023 at 10:52 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
> >
> > v3 -> v4
> > - Add Kconfig, CONFIG_COW_PTE, since some of the architectures, e.g.,
> >   s390 and powerpc32, don't support the PMD entry and PTE table
> >   operations.
> > - Fix unmatch type of break_cow_pte_range() in
> >   migrate_vma_collect_pmd().
> > - Don=E2=80=99t break COW PTE in folio_referenced_one().
> > - Fix the wrong VMA range checking in break_cow_pte_range().
> > - Only break COW when we modify the soft-dirty bit in
> >   clear_refs_pte_range().
> > - Handle do_swap_page() with COW PTE in mm/memory.c and mm/khugepaged.c=
.
> > - Change the tlb flush from flush_tlb_mm_range() (x86 specific) to
> >   tlb_flush_pmd_range().
> > - Handle VM_DONTCOPY with COW PTE fork.
> > - Fix the wrong address and invalid vma in recover_pte_range().
> > - Fix the infinite page fault loop in GUP routine.
> >   In mm/gup.c:follow_pfn_pte(), instead of calling the break COW PTE
> >   handler, we return -EMLINK to let the GUP handles the page fault
> >   (call faultin_page() in __get_user_pages()).
> > - return not_found(pvmw) if the break COW PTE failed in
> >   page_vma_mapped_walk().
> > - Since COW PTE has the same result as the normal COW selftest, it
> >   probably passed the COW selftest.
> >
> >         # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
> >         not ok 33 No leak from parent into child
> >         # [RUN] vmsplice() + unmap in child with mprotect() optimizatio=
n ... with hugetlb (2048 kB)
> >         not ok 44 No leak from parent into child
> >         # [RUN] vmsplice() before fork(), unmap in parent after fork() =
... with hugetlb (2048 kB)
> >         not ok 55 No leak from child into parent
> >         # [RUN] vmsplice() + unmap in parent after fork() ... with huge=
tlb (2048 kB)
> >         not ok 66 No leak from child into parent
> >
> >         Bail out! 4 out of 147 tests failed
> >         # Totals: pass:143 fail:4 xfail:0 xpass:0 skip:0 error:0
> >   See the more information about anon cow hugetlb tests:
> >     https://patchwork.kernel.org/project/linux-mm/patch/20220927110120.=
106906-5-david@redhat.com/
> >
> >
> > v3: https://lore.kernel.org/linux-mm/20221220072743.3039060-1-shiyn.lin=
@gmail.com/T/
> >
> > RFC v2 -> v3
> > - Change the sysctl with PID to prctl(PR_SET_COW_PTE).
> > - Account all the COW PTE mapped pages in fork() instead of defer it to
> >   page fault (break COW PTE).
> > - If there is an unshareable mapped page (maybe pinned or private
> >   device), recover all the entries that are already handled by COW PTE
> >   fork, then copy to the new one.
> > - Remove COW_PTE_OWNER_EXCLUSIVE flag and handle the only case of GUP,
> >   follow_pfn_pte().
> > - Remove the PTE ownership since we don't need it.
> > - Use pte lock to protect the break COW PTE and free COW-ed PTE.
> > - Do TLB flushing in break COW PTE handler.
> > - Handle THP, KSM, madvise, mprotect, uffd and migrate device.
> > - Handle the replacement page of uprobe.
> > - Handle the clear_refs_write() of fs/proc.
> > - All of the benchmarks dropped since the accounting and pte lock.
> >   The benchmarks of v3 is worse than RFC v2, most of the cases are
> >   similar to the normal fork, but there still have an use case
> >   (TriforceAFL) is better than the normal fork version.
> >
> > RFC v2: https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.=
lin@gmail.com/T/
> >
> > RFC v1 -> RFC v2
> > - Change the clone flag method to sysctl with PID.
> > - Change the MMF_COW_PGTABLE flag to two flags, MMF_COW_PTE and
> >   MMF_COW_PTE_READY, for the sysctl.
> > - Change the owner pointer to use the folio padding.
> > - Handle all the VMAs that cover the PTE table when doing the break COW=
 PTE.
> > - Remove the self-defined refcount to use the _refcount for the page
> >   table page.
> > - Add the exclusive flag to let the page table only own by one task in
> >   some situations.
> > - Invalidate address range MMU notifier and start the write_seqcount
> >   when doing the break COW PTE.
> > - Handle the swap cache and swapoff.
> >
> > RFC v1: https://lore.kernel.org/all/20220519183127.3909598-1-shiyn.lin@=
gmail.com/
> >
> > ---
> >
> > Currently, copy-on-write is only used for the mapped memory; the child
> > process still needs to copy the entire page table from the parent
> > process during forking. The parent process might take a lot of time and
> > memory to copy the page table when the parent has a big page table
> > allocated. For example, the memory usage of a process after forking wit=
h
> > 1 GB mapped memory is as follows:
>
> For some reason, I was not able to reproduce performance improvements
> with a simple fork() performance measurement program. The results that
> I saw are the following:
>
> Base:
> Fork latency per gigabyte: 0.004416 seconds
> Fork latency per gigabyte: 0.004382 seconds
> Fork latency per gigabyte: 0.004442 seconds
> COW kernel:
> Fork latency per gigabyte: 0.004524 seconds
> Fork latency per gigabyte: 0.004764 seconds
> Fork latency per gigabyte: 0.004547 seconds
>
> AMD EPYC 7B12 64-Core Processor
> Base:
> Fork latency per gigabyte: 0.003923 seconds
> Fork latency per gigabyte: 0.003909 seconds
> Fork latency per gigabyte: 0.003955 seconds
> COW kernel:
> Fork latency per gigabyte: 0.004221 seconds
> Fork latency per gigabyte: 0.003882 seconds
> Fork latency per gigabyte: 0.003854 seconds
>
> Given, that page table for child is not copied, I was expecting the
> performance to be better with COW kernel, and also not to depend on
> the size of the parent.

Yes, the child won't duplicate the page table, but fork will still
traverse all the page table entries to do the accounting.
And, since this patch expends the COW to the PTE table level, it's not
the mapped page (page table entry) grained anymore, so we have to
guarantee that all the mapped page is available to do COW mapping in
the such page table.
This kind of checking also costs some time.
As a result, since the accounting and the checking, the COW PTE fork
still depends on the size of the parent so the improvement might not
be significant.

Actually, at the RFC v1 and v2, we proposed the version of skipping
those works, and we got a significant improvement. You can see the
number from RFC v2 cover letter [1]:
"In short, with 512 MB mapped memory, COW PTE decreases latency by 93%
for normal fork"

However, it might break the existing logic of the refcount/mapcount of
the page and destabilize the system.

[1] https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.lin@gmai=
l.com/T/#me2340d963c2758a2561c39cb3baf42c478dfe548
[2] https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.lin@gmai=
l.com/T/#mbc33221f00c7cf3d71839b45fc23862a5dac3014

> Test program:
>
> #include <time.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/time.h>
> #include <sys/mman.h>
> #include <sys/types.h>
>
> #define USEC    1000000
> #define GIG     (1ul << 30)
> #define NGIG    32
> #define SIZE    (NGIG * GIG)
> #define NPROC   16
>
> void main() {
>         int page_size =3D getpagesize();
>         struct timeval start, end;
>         long duration, i;
>         char *p;
>
>         p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (p =3D=3D MAP_FAILED) {
>                 perror("mmap");
>                 exit(1);
>         }
>         madvise(p, SIZE, MADV_NOHUGEPAGE);
>
>         /* Touch every page */
>         for (i =3D 0; i < SIZE; i +=3D page_size)
>                 p[i] =3D 0;
>
>         gettimeofday(&start, NULL);
>         for (i =3D 0; i < NPROC; i++) {
>                 int pid =3D fork();
>
>                 if (pid =3D=3D 0) {
>                         sleep(30);
>                         exit(0);
>                 }
>         }
>         gettimeofday(&end, NULL);
>         /* Normolize per proc and per gig */
>         duration =3D ((end.tv_sec - start.tv_sec) * USEC
>                 + (end.tv_usec - start.tv_usec)) / NPROC / NGIG;
>         printf("Fork latency per gigabyte: %ld.%06ld seconds\n",
>                 duration / USEC, duration % USEC);
> }

I'm not sure only taking the few testing is enough.
So, I rewrite your test program to run multiple times but focus on a
single fork, and get the average time:
fork.log: 0.000498
odfork.log: 0.000469

Test program:

#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <sys/prctl.h>

#define USEC 1000000
#define GIG (1ul << 30)
#define NGIG 4
#define SIZE (NGIG * GIG)
#define NPROC 16

int main(void)
{
    unsigned int i =3D 0;
    unsigned long j =3D 0;
    int pid, page_size =3D getpagesize();
    struct timeval start, end;
    long duration;
    char *p;

    prctl(65, 0, 0, 0, 0);

    for (i =3D 0; i < NPROC; i++) {
p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (p =3D=3D MAP_FAILED) {
            perror("mmap");
            exit(1);
        }
        madvise(p, SIZE, MADV_NOHUGEPAGE);
        /* Touch every page */
        for (j =3D 0; j < SIZE; j +=3D page_size)
            p[j] =3D 0;

        gettimeofday(&start, NULL);
        pid =3D fork();
        switch (pid) {
        case -1:
            perror("fork");
    exit(1);
        case 0: /* child */
            return 0;
default: /* parent */
            gettimeofday(&end, NULL);
            duration =3D ((end.tv_sec - start.tv_sec) * USEC +
                        (end.tv_usec - start.tv_usec)) /
                       NPROC / NGIG;
            // seconds
            printf("%ld.%06ld\n", duration / USEC, duration % USEC);
            waitpid(pid, NULL, 0);
            munmap(p, SIZE);
    p =3D NULL;
        }
    }
}

Script:

import numpy

def calc_mean(file):
    np_tmp =3D numpy.loadtxt(file, usecols=3Drange(0,1))
    print("{}: {:6f}".format(file, np_tmp.mean()))

calc_mean("fork.log")
calc_mean("odfork.log")

I didn't make the memory size and process number bigger because it ran
on my laptop, and I can't access my server for some reason.

Thanks,
Chih-En Lin

On Fri, Feb 10, 2023 at 2:16 AM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Mon, Feb 6, 2023 at 10:52 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
> >
> > v3 -> v4
> > - Add Kconfig, CONFIG_COW_PTE, since some of the architectures, e.g.,
> >   s390 and powerpc32, don't support the PMD entry and PTE table
> >   operations.
> > - Fix unmatch type of break_cow_pte_range() in
> >   migrate_vma_collect_pmd().
> > - Don=E2=80=99t break COW PTE in folio_referenced_one().
> > - Fix the wrong VMA range checking in break_cow_pte_range().
> > - Only break COW when we modify the soft-dirty bit in
> >   clear_refs_pte_range().
> > - Handle do_swap_page() with COW PTE in mm/memory.c and mm/khugepaged.c=
.
> > - Change the tlb flush from flush_tlb_mm_range() (x86 specific) to
> >   tlb_flush_pmd_range().
> > - Handle VM_DONTCOPY with COW PTE fork.
> > - Fix the wrong address and invalid vma in recover_pte_range().
> > - Fix the infinite page fault loop in GUP routine.
> >   In mm/gup.c:follow_pfn_pte(), instead of calling the break COW PTE
> >   handler, we return -EMLINK to let the GUP handles the page fault
> >   (call faultin_page() in __get_user_pages()).
> > - return not_found(pvmw) if the break COW PTE failed in
> >   page_vma_mapped_walk().
> > - Since COW PTE has the same result as the normal COW selftest, it
> >   probably passed the COW selftest.
> >
> >         # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
> >         not ok 33 No leak from parent into child
> >         # [RUN] vmsplice() + unmap in child with mprotect() optimizatio=
n ... with hugetlb (2048 kB)
> >         not ok 44 No leak from parent into child
> >         # [RUN] vmsplice() before fork(), unmap in parent after fork() =
... with hugetlb (2048 kB)
> >         not ok 55 No leak from child into parent
> >         # [RUN] vmsplice() + unmap in parent after fork() ... with huge=
tlb (2048 kB)
> >         not ok 66 No leak from child into parent
> >
> >         Bail out! 4 out of 147 tests failed
> >         # Totals: pass:143 fail:4 xfail:0 xpass:0 skip:0 error:0
> >   See the more information about anon cow hugetlb tests:
> >     https://patchwork.kernel.org/project/linux-mm/patch/20220927110120.=
106906-5-david@redhat.com/
> >
> >
> > v3: https://lore.kernel.org/linux-mm/20221220072743.3039060-1-shiyn.lin=
@gmail.com/T/
> >
> > RFC v2 -> v3
> > - Change the sysctl with PID to prctl(PR_SET_COW_PTE).
> > - Account all the COW PTE mapped pages in fork() instead of defer it to
> >   page fault (break COW PTE).
> > - If there is an unshareable mapped page (maybe pinned or private
> >   device), recover all the entries that are already handled by COW PTE
> >   fork, then copy to the new one.
> > - Remove COW_PTE_OWNER_EXCLUSIVE flag and handle the only case of GUP,
> >   follow_pfn_pte().
> > - Remove the PTE ownership since we don't need it.
> > - Use pte lock to protect the break COW PTE and free COW-ed PTE.
> > - Do TLB flushing in break COW PTE handler.
> > - Handle THP, KSM, madvise, mprotect, uffd and migrate device.
> > - Handle the replacement page of uprobe.
> > - Handle the clear_refs_write() of fs/proc.
> > - All of the benchmarks dropped since the accounting and pte lock.
> >   The benchmarks of v3 is worse than RFC v2, most of the cases are
> >   similar to the normal fork, but there still have an use case
> >   (TriforceAFL) is better than the normal fork version.
> >
> > RFC v2: https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.=
lin@gmail.com/T/
> >
> > RFC v1 -> RFC v2
> > - Change the clone flag method to sysctl with PID.
> > - Change the MMF_COW_PGTABLE flag to two flags, MMF_COW_PTE and
> >   MMF_COW_PTE_READY, for the sysctl.
> > - Change the owner pointer to use the folio padding.
> > - Handle all the VMAs that cover the PTE table when doing the break COW=
 PTE.
> > - Remove the self-defined refcount to use the _refcount for the page
> >   table page.
> > - Add the exclusive flag to let the page table only own by one task in
> >   some situations.
> > - Invalidate address range MMU notifier and start the write_seqcount
> >   when doing the break COW PTE.
> > - Handle the swap cache and swapoff.
> >
> > RFC v1: https://lore.kernel.org/all/20220519183127.3909598-1-shiyn.lin@=
gmail.com/
> >
> > ---
> >
> > Currently, copy-on-write is only used for the mapped memory; the child
> > process still needs to copy the entire page table from the parent
> > process during forking. The parent process might take a lot of time and
> > memory to copy the page table when the parent has a big page table
> > allocated. For example, the memory usage of a process after forking wit=
h
> > 1 GB mapped memory is as follows:
>
> For some reason, I was not able to reproduce performance improvements
> with a simple fork() performance measurement program. The results that
> I saw are the following:
>
> Base:
> Fork latency per gigabyte: 0.004416 seconds
> Fork latency per gigabyte: 0.004382 seconds
> Fork latency per gigabyte: 0.004442 seconds
> COW kernel:
> Fork latency per gigabyte: 0.004524 seconds
> Fork latency per gigabyte: 0.004764 seconds
> Fork latency per gigabyte: 0.004547 seconds
>
> AMD EPYC 7B12 64-Core Processor
> Base:
> Fork latency per gigabyte: 0.003923 seconds
> Fork latency per gigabyte: 0.003909 seconds
> Fork latency per gigabyte: 0.003955 seconds
> COW kernel:
> Fork latency per gigabyte: 0.004221 seconds
> Fork latency per gigabyte: 0.003882 seconds
> Fork latency per gigabyte: 0.003854 seconds
>
> Given, that page table for child is not copied, I was expecting the
> performance to be better with COW kernel, and also not to depend on
> the size of the parent.
>
> Test program:
>
> #include <time.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/time.h>
> #include <sys/mman.h>
> #include <sys/types.h>
>
> #define USEC    1000000
> #define GIG     (1ul << 30)
> #define NGIG    32
> #define SIZE    (NGIG * GIG)
> #define NPROC   16
>
> void main() {
>         int page_size =3D getpagesize();
>         struct timeval start, end;
>         long duration, i;
>         char *p;
>
>         p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         if (p =3D=3D MAP_FAILED) {
>                 perror("mmap");
>                 exit(1);
>         }
>         madvise(p, SIZE, MADV_NOHUGEPAGE);
>
>         /* Touch every page */
>         for (i =3D 0; i < SIZE; i +=3D page_size)
>                 p[i] =3D 0;
>
>         gettimeofday(&start, NULL);
>         for (i =3D 0; i < NPROC; i++) {
>                 int pid =3D fork();
>
>                 if (pid =3D=3D 0) {
>                         sleep(30);
>                         exit(0);
>                 }
>         }
>         gettimeofday(&end, NULL);
>         /* Normolize per proc and per gig */
>         duration =3D ((end.tv_sec - start.tv_sec) * USEC
>                 + (end.tv_usec - start.tv_usec)) / NPROC / NGIG;
>         printf("Fork latency per gigabyte: %ld.%06ld seconds\n",
>                 duration / USEC, duration % USEC);
> }
