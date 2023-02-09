Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC269102F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBISQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 13:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBISQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:16:36 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB35643F6
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 10:16:33 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id u16so1591355qvp.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D17ul6Jv4BBsV+2Jo6JXzyrGGRmbOMiujl+Liy7jNKU=;
        b=Ym+CXKOtcv8hciunQy57PF9+Z0g9lkZnEGbxg0LeHnfu/JqGR+eXCyBLaJNHe2a1gB
         RA77v7i9vAW3zCN/HYYrnibeS1rILcYRPWFAbU/mBmjZZm0l8+f1M417b/mqwPOPVQDY
         uEBxLZpogxT1gue/5pPtX+xiHXuqlEuy0Coi0J2u3USmPmA2W9cOU8/XpJiJk8CS852B
         ejQEBszFP3wzyp+8Lac5VDTaDfGAB/M4Zb6goMSfStqcOGEDTpf01j+sYhEPjGl/1mXf
         CTXdW8E+gSiGAe4/HkAr13WDVdah+jTZsJw2drmrwOJQy4C5Ul9NJJMndD3aDclHNkBe
         Hk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D17ul6Jv4BBsV+2Jo6JXzyrGGRmbOMiujl+Liy7jNKU=;
        b=Ew3efh+B7GQjmVQSJ7hMrbT8yDHf7NUedSpyVVTCr3qKwhcbHazZu5ayRc3adsU5Fd
         XQopSoJnsiAXoOogGGsYU788/kVVFWqlVKrU5kwz7GB1WTWU0L0dytlXQj8VLWrax1Nh
         Q2Db4ocZ49h9R9Yp/G+2oE4Ip5wuNbvLb4Bx79OSToawpen2GVX2BEjL9rMHaR4qSeVx
         KCQT55DGw0iX0ZSsfBfTysWKp8xvCel7/GwaKfDORmHsWMUFowAXu2lyPCmjshvPgzyV
         MuRdwYm2Xb3gsnKwX7t7OVWEteehopaUEAQlaRwqYYu8Knb7TwkJyWZjKIhTKTyn1Uju
         XfwQ==
X-Gm-Message-State: AO0yUKUkRprWKhxexFbVoe7kaqz4z19qtFzGF/wP+hgDrf6zoqVy9zoc
        1Wktu+yPXf7H3rmlUHGxeAJE5IBB1CVANby+kd1F3A==
X-Google-Smtp-Source: AK7set9/asfDGBIlS6FIxPCSSF0J5s4zfbRpUSo/lPaWYG0FFjA+m1JuZQPdJzdk/PLzyIx6cdEIqfKndQA7GHYwaXM=
X-Received: by 2002:a0c:f302:0:b0:56e:8d82:742d with SMTP id
 j2-20020a0cf302000000b0056e8d82742dmr49876qvl.34.1675966592638; Thu, 09 Feb
 2023 10:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
In-Reply-To: <20230207035139.272707-1-shiyn.lin@gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 9 Feb 2023 13:15:56 -0500
Message-ID: <CA+CK2bBt0Gujv9BdhghVkbFRirAxCYXbpH-nquccPsKGnGwOBQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Introduce Copy-On-Write to Page Table
To:     Chih-En Lin <shiyn.lin@gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 6, 2023 at 10:52 PM Chih-En Lin <shiyn.lin@gmail.com> wrote:
>
> v3 -> v4
> - Add Kconfig, CONFIG_COW_PTE, since some of the architectures, e.g.,
>   s390 and powerpc32, don't support the PMD entry and PTE table
>   operations.
> - Fix unmatch type of break_cow_pte_range() in
>   migrate_vma_collect_pmd().
> - Don=E2=80=99t break COW PTE in folio_referenced_one().
> - Fix the wrong VMA range checking in break_cow_pte_range().
> - Only break COW when we modify the soft-dirty bit in
>   clear_refs_pte_range().
> - Handle do_swap_page() with COW PTE in mm/memory.c and mm/khugepaged.c.
> - Change the tlb flush from flush_tlb_mm_range() (x86 specific) to
>   tlb_flush_pmd_range().
> - Handle VM_DONTCOPY with COW PTE fork.
> - Fix the wrong address and invalid vma in recover_pte_range().
> - Fix the infinite page fault loop in GUP routine.
>   In mm/gup.c:follow_pfn_pte(), instead of calling the break COW PTE
>   handler, we return -EMLINK to let the GUP handles the page fault
>   (call faultin_page() in __get_user_pages()).
> - return not_found(pvmw) if the break COW PTE failed in
>   page_vma_mapped_walk().
> - Since COW PTE has the same result as the normal COW selftest, it
>   probably passed the COW selftest.
>
>         # [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
>         not ok 33 No leak from parent into child
>         # [RUN] vmsplice() + unmap in child with mprotect() optimization =
... with hugetlb (2048 kB)
>         not ok 44 No leak from parent into child
>         # [RUN] vmsplice() before fork(), unmap in parent after fork() ..=
. with hugetlb (2048 kB)
>         not ok 55 No leak from child into parent
>         # [RUN] vmsplice() + unmap in parent after fork() ... with hugetl=
b (2048 kB)
>         not ok 66 No leak from child into parent
>
>         Bail out! 4 out of 147 tests failed
>         # Totals: pass:143 fail:4 xfail:0 xpass:0 skip:0 error:0
>   See the more information about anon cow hugetlb tests:
>     https://patchwork.kernel.org/project/linux-mm/patch/20220927110120.10=
6906-5-david@redhat.com/
>
>
> v3: https://lore.kernel.org/linux-mm/20221220072743.3039060-1-shiyn.lin@g=
mail.com/T/
>
> RFC v2 -> v3
> - Change the sysctl with PID to prctl(PR_SET_COW_PTE).
> - Account all the COW PTE mapped pages in fork() instead of defer it to
>   page fault (break COW PTE).
> - If there is an unshareable mapped page (maybe pinned or private
>   device), recover all the entries that are already handled by COW PTE
>   fork, then copy to the new one.
> - Remove COW_PTE_OWNER_EXCLUSIVE flag and handle the only case of GUP,
>   follow_pfn_pte().
> - Remove the PTE ownership since we don't need it.
> - Use pte lock to protect the break COW PTE and free COW-ed PTE.
> - Do TLB flushing in break COW PTE handler.
> - Handle THP, KSM, madvise, mprotect, uffd and migrate device.
> - Handle the replacement page of uprobe.
> - Handle the clear_refs_write() of fs/proc.
> - All of the benchmarks dropped since the accounting and pte lock.
>   The benchmarks of v3 is worse than RFC v2, most of the cases are
>   similar to the normal fork, but there still have an use case
>   (TriforceAFL) is better than the normal fork version.
>
> RFC v2: https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.li=
n@gmail.com/T/
>
> RFC v1 -> RFC v2
> - Change the clone flag method to sysctl with PID.
> - Change the MMF_COW_PGTABLE flag to two flags, MMF_COW_PTE and
>   MMF_COW_PTE_READY, for the sysctl.
> - Change the owner pointer to use the folio padding.
> - Handle all the VMAs that cover the PTE table when doing the break COW P=
TE.
> - Remove the self-defined refcount to use the _refcount for the page
>   table page.
> - Add the exclusive flag to let the page table only own by one task in
>   some situations.
> - Invalidate address range MMU notifier and start the write_seqcount
>   when doing the break COW PTE.
> - Handle the swap cache and swapoff.
>
> RFC v1: https://lore.kernel.org/all/20220519183127.3909598-1-shiyn.lin@gm=
ail.com/
>
> ---
>
> Currently, copy-on-write is only used for the mapped memory; the child
> process still needs to copy the entire page table from the parent
> process during forking. The parent process might take a lot of time and
> memory to copy the page table when the parent has a big page table
> allocated. For example, the memory usage of a process after forking with
> 1 GB mapped memory is as follows:

For some reason, I was not able to reproduce performance improvements
with a simple fork() performance measurement program. The results that
I saw are the following:

Base:
Fork latency per gigabyte: 0.004416 seconds
Fork latency per gigabyte: 0.004382 seconds
Fork latency per gigabyte: 0.004442 seconds
COW kernel:
Fork latency per gigabyte: 0.004524 seconds
Fork latency per gigabyte: 0.004764 seconds
Fork latency per gigabyte: 0.004547 seconds

AMD EPYC 7B12 64-Core Processor
Base:
Fork latency per gigabyte: 0.003923 seconds
Fork latency per gigabyte: 0.003909 seconds
Fork latency per gigabyte: 0.003955 seconds
COW kernel:
Fork latency per gigabyte: 0.004221 seconds
Fork latency per gigabyte: 0.003882 seconds
Fork latency per gigabyte: 0.003854 seconds

Given, that page table for child is not copied, I was expecting the
performance to be better with COW kernel, and also not to depend on
the size of the parent.

Test program:

#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <sys/types.h>

#define USEC    1000000
#define GIG     (1ul << 30)
#define NGIG    32
#define SIZE    (NGIG * GIG)
#define NPROC   16

void main() {
        int page_size =3D getpagesize();
        struct timeval start, end;
        long duration, i;
        char *p;

        p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        if (p =3D=3D MAP_FAILED) {
                perror("mmap");
                exit(1);
        }
        madvise(p, SIZE, MADV_NOHUGEPAGE);

        /* Touch every page */
        for (i =3D 0; i < SIZE; i +=3D page_size)
                p[i] =3D 0;

        gettimeofday(&start, NULL);
        for (i =3D 0; i < NPROC; i++) {
                int pid =3D fork();

                if (pid =3D=3D 0) {
                        sleep(30);
                        exit(0);
                }
        }
        gettimeofday(&end, NULL);
        /* Normolize per proc and per gig */
        duration =3D ((end.tv_sec - start.tv_sec) * USEC
                + (end.tv_usec - start.tv_usec)) / NPROC / NGIG;
        printf("Fork latency per gigabyte: %ld.%06ld seconds\n",
                duration / USEC, duration % USEC);
}
