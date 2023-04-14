Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9CD6E2591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDNOYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDNOYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:24:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6193A84;
        Fri, 14 Apr 2023 07:24:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso4801373pjr.3;
        Fri, 14 Apr 2023 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482261; x=1684074261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLDZpwX/rnxh7wvus4iLYvr6Kw41bfVo1r+q2Drwt2c=;
        b=T+glq+ymF5gcgbFjZAvpQEsn0ZyIVezfJfGliW8ets9mw8l9+nmLiPuzXCNUZuZ5k0
         tFiQpiX4LU+S+/HWpZ2M/X7edr6KRb8IyAt/FK641TB1EV6ErFwnfPAQXEjzP86+AUKQ
         +sXPUnH7xCIC1YwuPSB5FX3b/acL7pSznZDebEI55BaQ4mDIf8QfbLNi6m6VPc5BX4to
         Gh/KfDxmVQGWjK5v7NuhJLXxsOzjHQOe3WsDPCtNrXQeWkjuTDNbbOJ9sQ07Fw/28QFq
         zDl/KkJZmweWRrxNGL8OKIPcDMF3C4qpTQhB9dTrkqQPMpytbEIlfFBgEOQsr6SShirW
         gjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482261; x=1684074261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLDZpwX/rnxh7wvus4iLYvr6Kw41bfVo1r+q2Drwt2c=;
        b=eYqP5ooAJ8lMKgAhxMyMl9INnZiQDrdJaBX7okQVJLpRBkO2ETP9ch+a7fkxp5F5Mw
         UDWBz2iOThHkSo/yW4Tt+URA+l9gla7Rca64I+bGWHD+5sbrUid7FQaIdgX6SKf0aWVX
         Su3UnCI9JomINwX8CUygsMc6e3Z9Dcr7DBbSdc0+p06EorSr5yQeMK2L75hlAFELVB5P
         6+1N/hnEz/ae8HDO+Fe6QDI3yvRBU28zStUbq3VzSe5VJNmsjRda22Yr41n1oUmRgGYv
         wFcAbBHE6iJd9XY3wa9P9j9x9TEmLHbqAOdaiCAN3dlBix9AmP+BjmWJeM1s+xnvTKxd
         ImRg==
X-Gm-Message-State: AAQBX9dxzbPVKNXgk6mgbuZTvbiHt73Rm6ArghGtA+AkIaB2ynz38jbo
        x3KG9N8kvO6Xy+W/ZsP7VFk=
X-Google-Smtp-Source: AKy350b7zOnHJA/MbH+TwreyPJVFtUg2DPanIi5ILYPj9Xf8QJfLXnnhyD+HbkEtJPYqE02GD6sgWQ==
X-Received: by 2002:a17:90a:3e41:b0:234:5d3c:b02b with SMTP id t1-20020a17090a3e4100b002345d3cb02bmr5548629pjm.42.1681482261057;
        Fri, 14 Apr 2023 07:24:21 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:24:20 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Juergen Gross <jgross@suse.com>, Peter Xu <peterx@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alex Sierra <alex.sierra@amd.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Gladkov <legion@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: [PATCH v5 00/17] Introduce Copy-On-Write to Page Table
Date:   Fri, 14 Apr 2023 22:23:24 +0800
Message-Id: <20230414142341.354556-1-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NOTE
====
This patch is primarily aimed at optimizing the memory usage of page
table in processes with large address space, which can potentailly lead
to improved the fork system calll latency under certain conditions.
However, we're planning to improve the fork latency in the future but
not in this patch.

---

v4 -> v5
- Split the present and non-present parts of zap_pte_range.
- Remove the incorrect assertion of mmap lock rwitability in handle_cow_pte_fault.
- In break COW PTe fault handler, to avoid the situation where someone may
  allocate the new PTE table due to clearing the pmd entry before duplicating
  COW-ed PTE, we update the pmd entry with new PTE table after we finish the
  duplication.
- Add a second chance to break COW PTE after the allocation fails at first time,
  if second time stil fails, kill the failed process by OOM killer.
- Extract the zap part of COW-ed PTE from break COW PTE fault commit.
- In zap part, clear the pmd entry which assigned to COW-ed PTE instead of
  clearing it in free page table part. Before this change, it was possible
  to access the COW-ed PTe after it had been zapped.
- In zap part, we flush TLB and free the batched memory before we handle
  the COW-ed PTE. And, during zapping COW-ed PTE, we defer flushing TLB
  and freeing the batched memory until after we have cleared the pmd entry.
- Add the COW-ed PTE table sanity check to page table check.

v4: https://lore.kernel.org/linux-mm/20230207035139.272707-1-shiyn.lin@gmail.com/

v3 -> v4
- Add Kconfig, CONFIG_COW_PTE, since some of the architectures, e.g.,
  s390 and powerpc32, don't support the PMD entry and PTE table
  operations.
- Fix unmatch type of break_cow_pte_range() in
  migrate_vma_collect_pmd().
- Don’t break COW PTE in folio_referenced_one().
- Fix the wrong VMA range checking in break_cow_pte_range().
- Only break COW when we modify the soft-dirty bit in
  clear_refs_pte_range().
- Handle do_swap_page() with COW PTE in mm/memory.c and mm/khugepaged.c.
- Change the tlb flush from flush_tlb_mm_range() (x86 specific) to
  tlb_flush_pmd_range().
- Handle VM_DONTCOPY with COW PTE fork.
- Fix the wrong address and invalid vma in recover_pte_range().
- Fix the infinite page fault loop in GUP routine.
  In mm/gup.c:follow_pfn_pte(), instead of calling the break COW PTE
  handler, we return -EMLINK to let the GUP handles the page fault
  (call faultin_page() in __get_user_pages()).
- return not_found(pvmw) if the break COW PTE failed in
  page_vma_mapped_walk().
- Since COW PTE has the same result as the normal COW selftest, it
  probably passed the COW selftest.

	# [RUN] vmsplice() + unmap in child ... with hugetlb (2048 kB)
	not ok 33 No leak from parent into child
	# [RUN] vmsplice() + unmap in child with mprotect() optimization ... with hugetlb (2048 kB)
	not ok 44 No leak from parent into child
	# [RUN] vmsplice() before fork(), unmap in parent after fork() ... with hugetlb (2048 kB)
	not ok 55 No leak from child into parent
	# [RUN] vmsplice() + unmap in parent after fork() ... with hugetlb (2048 kB)
	not ok 66 No leak from child into parent

	Bail out! 4 out of 147 tests failed
	# Totals: pass:143 fail:4 xfail:0 xpass:0 skip:0 error:0
  See the more information about anon cow hugetlb tests:
    https://patchwork.kernel.org/project/linux-mm/patch/20220927110120.106906-5-david@redhat.com/


v3: https://lore.kernel.org/linux-mm/20221220072743.3039060-1-shiyn.lin@gmail.com/T/

RFC v2 -> v3
- Change the sysctl with PID to prctl(PR_SET_COW_PTE).
- Account all the COW PTE mapped pages in fork() instead of defer it to
  page fault (break COW PTE).
- If there is an unshareable mapped page (maybe pinned or private
  device), recover all the entries that are already handled by COW PTE
  fork, then copy to the new one.
- Remove COW_PTE_OWNER_EXCLUSIVE flag and handle the only case of GUP,
  follow_pfn_pte().
- Remove the PTE ownership since we don't need it.
- Use pte lock to protect the break COW PTE and free COW-ed PTE.
- Do TLB flushing in break COW PTE handler.
- Handle THP, KSM, madvise, mprotect, uffd and migrate device.
- Handle the replacement page of uprobe.
- Handle the clear_refs_write() of fs/proc.
- All of the benchmarks dropped since the accounting and pte lock.
  The benchmarks of v3 is worse than RFC v2, most of the cases are
  similar to the normal fork, but there still have an use case
  (TriforceAFL) is better than the normal fork version.

RFC v2: https://lore.kernel.org/linux-mm/20220927162957.270460-1-shiyn.lin@gmail.com/T/

RFC v1 -> RFC v2
- Change the clone flag method to sysctl with PID.
- Change the MMF_COW_PGTABLE flag to two flags, MMF_COW_PTE and
  MMF_COW_PTE_READY, for the sysctl.
- Change the owner pointer to use the folio padding.
- Handle all the VMAs that cover the PTE table when doing the break COW PTE.
- Remove the self-defined refcount to use the _refcount for the page
  table page.
- Add the exclusive flag to let the page table only own by one task in
  some situations.
- Invalidate address range MMU notifier and start the write_seqcount
  when doing the break COW PTE.
- Handle the swap cache and swapoff.

RFC v1: https://lore.kernel.org/all/20220519183127.3909598-1-shiyn.lin@gmail.com/

---

Currently, copy-on-write is only used for the mapped memory; the child
process still needs to copy the entire page table from the parent
process during forking. The parent process might take a lot of time and
memory to copy the page table when the parent has a big page table
allocated. For example, the memory usage of a process after forking with
1 GB mapped memory is as follows:

              DEFAULT FORK
          parent         child
VmRSS:   1049688 kB    1048688 kB
VmPTE:      2096 kB       2096 kB

This patch introduces copy-on-write (COW) for the PTE level page tables.
COW PTE conditionally improves performance in the situation where the
user needs copies of the program to run on isolated environments.
Feedback-based fuzzers (e.g., AFL) and serverless/microservice frameworks
are two major examples. For instance, COW PTE achieves a 1.03x throughput
increase when running TriforceAFL.

After applying COW to PTE, the memory usage after forking is as follows:

                 COW PTE
          parent         child
VmRSS:	 1049968 kB       2576 kB
VmPTE:	    2096 kB         44 kB

The results show that this patch significantly decreases memory usage.
The other number of latencies are discussed later.

Real-world application benchmarks
=================================

We run benchmarks of fuzzing and VM cloning. The experiments were
done with the normal fork or the fork with COW PTE.

With AFL (LLVM mode) and SQLite, COW PTE (52.15 execs/sec) is a
little bit worse than the normal fork version (53.50 execs/sec).

                   fork
       execs_per_sec     unix_time        time
count    28.000000  2.800000e+01   28.000000
mean     53.496786  1.671270e+09   96.107143
std       3.625060  7.194717e+01   71.947172
min      35.350000  1.671270e+09    0.000000
25%      53.967500  1.671270e+09   33.750000
50%      54.235000  1.671270e+09   92.000000
75%      54.525000  1.671270e+09  149.250000
max      55.100000  1.671270e+09  275.000000

                 COW PTE
       execs_per_sec     unix_time        time
count    34.000000  3.400000e+01   34.000000
mean     52.150000  1.671268e+09  103.323529
std       3.218271  7.507682e+01   75.076817
min      34.250000  1.671268e+09    0.000000
25%      52.500000  1.671268e+09   42.250000
50%      52.750000  1.671268e+09   94.500000
75%      52.952500  1.671268e+09  150.750000
max      53.680000  1.671268e+09  285.000000


With TriforceAFL which is for kernel fuzzing with QEMU, COW PTE
(105.54 execs/sec) achieves a 1.05x throughput increase over the
normal fork version (102.30 execs/sec).

                   fork
     execs_per_sec     unix_time        time
count    38.000000  3.800000e+01   38.000000
mean    102.299737  1.671269e+09  156.289474
std      20.139268  8.717113e+01   87.171130
min       6.600000  1.671269e+09    0.000000
25%      95.657500  1.671269e+09   82.250000
50%     109.950000  1.671269e+09  176.500000
75%     113.972500  1.671269e+09  223.750000
max     118.790000  1.671269e+09  281.000000

                 COW PTE
     execs_per_sec     unix_time        time
count    42.000000  4.200000e+01   42.000000
mean    105.540714  1.671269e+09  163.476190
std      19.443517  8.858845e+01   88.588453
min       6.200000  1.671269e+09    0.000000
25%      96.585000  1.671269e+09  123.500000
50%     113.925000  1.671269e+09  180.500000
75%     116.940000  1.671269e+09  233.500000
max     121.090000  1.671269e+09  286.000000

Microbenchmark - syscall latency
================================

We run microbenchmarks to measure the latency of a fork syscall with
sizes of mapped memory ranging from 0 to 512 MB. The results show that
the latency of a normal fork reaches 10 ms. The latency of a fork with
COW PTE is also around 10 ms.

Microbenchmark - page fault latency
====================================

We conducted some microbenchmarks to measure page fault latency with
different patterns of accesses to a 512 MB memory buffer after forking.

In the first experiment, the program accesses the entire 512 MB memory
by writing to all the pages consecutively. The experiment is done with
normal fork, fork with COW PTE and calculates the single access average
latency. COW PTE page fault latency (0.000795 ms) and the normal fork
fault latency (0.000770 ms). Here are the raw numbers:

Page fault - Access to the entire 512 MB memory

fork mean: 0.000770 ms
fork median: 0.000769 ms
fork std: 0.000010 ms

COW PTE mean: 0.000795 ms
COW PTE median: 0.000795 ms
COW PTE std: 0.000009 ms

The second experiment simulates real-world applications with sparse
accesses. The program randomly accesses the memory by writing to one
random page 1 million times and calculates the average access time,
after that, we run both 100 times to get the averages. The result shows
that COW PTE (0.000029 ms) is similar to the normal fork (0.000026 ms).

Page fault - Random access

fork mean: 0.000026 ms
fork median: 0.000025 ms
fork std: 0.000002 ms

COW PTE mean: 0.000029 ms
COW PTE median: 0.000026 ms
COW PTE std: 0.000004 ms

All the tests were run with QEMU and the kernel was built with
the x86_64 default config (v3 patch set).

Summary
=======

In summary, COW PTE reduces the memory footprint of processes and
conditionally improve the latency of fork syscall.

This patch is based on the paper "On-demand-fork: a microsecond fork
for memory-intensive and latency-sensitive applications" [1] from
Purdue University.

Any comments and suggestions are welcome.

Thanks,
Chih-En Lin

---

[1] https://dl.acm.org/doi/10.1145/3447786.3456258

This patch is based on v6.3-rc6.

---

Chih-En Lin (17):
  mm: Split out the present cases from zap_pte_range()
  mm: Allow user to control COW PTE via prctl
  mm: Add Copy-On-Write PTE to fork()
  mm: Add break COW PTE fault and helper functions
  mm: Handle COW-ed PTE during zapping
  mm/rmap: Break COW PTE in rmap walking
  mm/khugepaged: Break COW PTE before scanning pte
  mm/ksm: Break COW PTE before modify shared PTE
  mm/madvise: Handle COW-ed PTE with madvise()
  mm/gup: Trigger break COW PTE before calling follow_pfn_pte()
  mm/mprotect: Break COW PTE before changing protection
  mm/userfaultfd: Support COW PTE
  mm/migrate_device: Support COW PTE
  fs/proc: Support COW PTE with clear_refs_write
  events/uprobes: Break COW PTE before replacing page
  mm: fork: Enable COW PTE to fork system call
  mm: Check the unexpected modification of COW-ed PTE

 arch/x86/include/asm/pgtable.h     |   1 +
 fs/proc/task_mmu.c                 |   5 +
 include/linux/mm.h                 |  37 ++
 include/linux/page_table_check.h   |  62 ++
 include/linux/pgtable.h            |   6 +
 include/linux/rmap.h               |   2 +
 include/linux/sched/coredump.h     |  13 +-
 include/trace/events/huge_memory.h |   1 +
 include/uapi/linux/prctl.h         |   6 +
 kernel/events/uprobes.c            |   2 +-
 kernel/fork.c                      |   7 +
 kernel/sys.c                       |  11 +
 mm/Kconfig                         |   9 +
 mm/gup.c                           |   8 +-
 mm/khugepaged.c                    |  35 +-
 mm/ksm.c                           |   4 +-
 mm/madvise.c                       |  13 +
 mm/memory.c                        | 926 ++++++++++++++++++++++++++---
 mm/migrate.c                       |   3 +-
 mm/migrate_device.c                |   2 +
 mm/mmap.c                          |   4 +
 mm/mprotect.c                      |   9 +
 mm/mremap.c                        |   2 +
 mm/page_table_check.c              |  58 ++
 mm/page_vma_mapped.c               |   4 +
 mm/rmap.c                          |   9 +-
 mm/swapfile.c                      |   2 +
 mm/userfaultfd.c                   |   6 +
 mm/vmscan.c                        |   3 +-
 29 files changed, 1149 insertions(+), 101 deletions(-)

-- 
2.34.1

