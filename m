Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7423F9FED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhH0TUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhH0TU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:20:29 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87134C0612A5
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:19:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d202-20020a3768d3000000b003d30722c98fso161780qkc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RRkML5aaLpabtiv7lMTsCxfjkz2roCtfewQM+FW/noA=;
        b=sHNZLIBtukDKX17un4BpyKt9o/NbkOKdeGKhtEUC+VIhW+JR5IRHL/MeI5m4UiRgqZ
         23gqGbl9Sb7h5tWJhUjmXAenuxo7to0hGDzQrIWaCF8ZzLqPlesKPZxXUDSeQxvUTGmc
         Y2q4AfRIF7k7FcPTgS069D4hyRgQrpknm3wcTyXWeNlENvMKkdvKWpiP4biyfRWVb59v
         B91dhUVE/mHPNPBjNK4ZRgRdi5t9QmrSgUOwyv/flhMGooimzka+r5zb/ibMZ1WhvfaB
         MXQaZMd3mgBtEhejxWPzQM+aR6bjI65i/DIQJhV7XR5fILiAOHJva5SMoP1jY3C5UH3J
         il3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RRkML5aaLpabtiv7lMTsCxfjkz2roCtfewQM+FW/noA=;
        b=mHsl+O/lFLfKqUOOgy7lDZupCLI12gtzz9+DIG25MccWfTq7Qce3r8DQeO0V/1VjWw
         lSjGWR2/52AbJ2c+I4xeFwakWdN7PHVOW1rpoBWMbSeiaLKt24uqKmRFUNrPoJVa7yA3
         gyUofcsAK/OuopDQMTekXyeVLvL47sP0zg2GHAqa4wLzexCABCeMjMYQpeiMgpyCPolJ
         Bdm+yG+/V3x1q5ubFwjc2HvwRwyxUQ4MDR00mbyme6UjAITMbjj3kdEghkROlspO2At7
         Ay2hvccEIoUUzA56tj3BQZyO35p4pMNJINYxlCJlQ8t2CUrhPsPSPxYdkm/WKExZNau2
         vRTA==
X-Gm-Message-State: AOAM533qaOd7f3Kg+W5t8pi1cnLylauI3LuCf2R/ZRhuKXMGHs1HkmCj
        SXNdErSCoLtSUH2+5q9KqLjg8nwvXw0=
X-Google-Smtp-Source: ABdhPJwlVMTSP3mPPLPB1FcLBEO5KECbnVlvJAx1zWj/a6b3fF2DC7neWZh9xHOrwjaAJJ+ycpZ/93uH+YM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:fd8e:f32b:a64b:dd89])
 (user=surenb job=sendgmr) by 2002:a05:6214:922:: with SMTP id
 dk2mr11208979qvb.36.1630091945639; Fri, 27 Aug 2021 12:19:05 -0700 (PDT)
Date:   Fri, 27 Aug 2021 12:18:55 -0700
Message-Id: <20210827191858.2037087-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v8 0/3] Anonymous VMA naming patches
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, kaleshsingh@google.com, peterx@redhat.com,
        rppt@kernel.org, peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There were a number of previous attempts to upstream support for anonymous
VMA naming. The original submission by Colin Cross [1] implemented a
dictionary of refcounted names to reuse same name strings. Dave Hansen
suggested [2] to use userspace pointers instead and the patch was rewritten
that way. The last v7 version of this patch was posted by Sumit Semwal [3]
and a very similar patch has been used in Android to name anonymous VMAs
for a number of years. Concerns about this patch were raised by Kees Cook
[4] noting the lack of string sanitization and the use of userspace
pointers from the kernel. In conclusion [5], it was suggested to
strndup_user the strings from userspace, perform appropriate checks and
store a copy as a vm_area_struct member. Performance impact from
additional strdup's during fork() should be measured by allocating a large
number (64k) of VMAs with longest names and timing fork()s.

This patchset implements the suggested approach in the first 2 patches and
the 3rd patch implements simple refcounting to avoid strdup'ing the names
during fork() and minimize the regression.

Proposed test was conducted on an ARM64 Android device with CPU frequency
locked at 2.4GHz, performance governor and Android system being stopped
(adb shell stop) to minimize the noise. Test includes 3 different
scenarios. In each scenario a process with 64K named anonymous VMAs forks
children 1000 times while timing each fork and reporting the average time.
The scenarios differ in the VMA content:

1. VMAs are not populated with any data (not realistic scenario but
helps in emphasizing the regression).
2. Each VMA contains 1 page populated with random data.
3. Each VMA contains 10 pages populated with random data.

With the first 2 patches implementing strdup approach, the average fork()
times are:

                              unnamed VMAs      named VMAs      REGRESSION
Unpopulated VMAs              16.73ms           23.34ms         39.51%
VMAs with 1 page of data      51.98ms           59.94ms         15.31%
VMAs with 10 pages of data    66.86ms           76.31ms         14.13%

From the perf results, the regression can be attributed to strlen() and
strdup() calls. The regression shrinking with the increased amount of
populated data can be attributed mostly to anon_vma_fork() and
copy_page_range() consuming more time during fork().

After the refcounting implemented in the last patch of this series the
results are:

                              unnamed VMAs      named VMAs      REGRESSION
Unpopulated VMAs              16.36ms           18.35ms         12.16%%
VMAs with 1 page of data      48.16ms           51.30ms         6.52%
VMAs with 10 pages of data    64.23ms           67.69ms         5.39%

From the perf results, the regression can be attributed to
refcount_inc_checked() (called from kref_get()).

While there is obviously a measurable regression, 64K named anonymous VMAs
is truly a worst case scenario. In the real usage, the only current user of
this feature, namely Android, rarely has processes with the number of VMAs
reaching 4000 (that's the highest I've measured). The regression of forking
a process with that number of VMAs is at the noise level.

1. https://lore.kernel.org/linux-mm/1372901537-31033-1-git-send-email-ccross@android.com/
2. https://lore.kernel.org/linux-mm/51DDFA02.9040707@intel.com/
3. https://lore.kernel.org/linux-mm/20200901161459.11772-1-sumit.semwal@linaro.org/
4. https://lore.kernel.org/linux-mm/202009031031.D32EF57ED@keescook/
5. https://lore.kernel.org/linux-mm/5d0358ab-8c47-2f5f-8e43-23b89d6a8e95@intel.com/

Colin Cross (2):
  mm: rearrange madvise code to allow for reuse
  mm: add a field to store names for private anonymous memory

Suren Baghdasaryan (1):
  mm: add anonymous vma name refcounting

 Documentation/filesystems/proc.rst |   2 +
 fs/proc/task_mmu.c                 |  14 +-
 fs/userfaultfd.c                   |   7 +-
 include/linux/mm.h                 |  13 +-
 include/linux/mm_types.h           |  55 +++-
 include/uapi/linux/prctl.h         |   3 +
 kernel/fork.c                      |   2 +
 kernel/sys.c                       |  48 ++++
 mm/madvise.c                       | 447 +++++++++++++++++++----------
 mm/mempolicy.c                     |   3 +-
 mm/mlock.c                         |   2 +-
 mm/mmap.c                          |  38 +--
 mm/mprotect.c                      |   2 +-
 13 files changed, 462 insertions(+), 174 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

