Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188D2258B52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 11:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgIAJTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 05:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAJTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:19:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24507C061245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 02:19:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so275943pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKDhu57eucllC3stfGqQp1RE01bX+WGNmYWYWmVH8uA=;
        b=RXZgt6M0hedr66aPYeE2aauHPij9YS02v77RUWGPdFoRPTmaHiWoV2/ZHZGvh2s+PH
         z8B4C/jKSh6jqgfT68oeMtzuwAbB17NiYecsPX6EPenPw5YQNEJIot+4EXtvBiVDIUYj
         wAnkzO7OHtxYdN/UTr1YslXdsXWMtlhFSqNjPPRoEE21Y3vbuhXzaiWig/GqXceOHNrn
         4FrFXHeqnQojl9FcQNEmRS6zxtRZTp6PcYdWrZnD6u+GS9TEt5HDI/8LtOkgSs0DP1W/
         ebBBKVWfe7ZAjjC+FCpWfpjBoMZeTrcb4ERxEorsNO2Co7B0GJ4o1kROXApEH3lLX0yG
         8Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKDhu57eucllC3stfGqQp1RE01bX+WGNmYWYWmVH8uA=;
        b=szcwiiKbJTEzVYwww5SnuEEgYpGiwe3oY72y+IZlTC6zyfO4N2Op+Qg5VM2rHU6YN1
         h17uSSvbHUqE3XXZhb4o0Th2pw+S1TFyG1Tg3+6SGkZHJpF/zCoGpq+YbHVAKykbVpfr
         cKGECovsmHdap27mqrn7Ziu04JDVvd3cV4UzhsGKdJNyfhI5OZyczwICImiY4QWkN0UT
         duH5NOd0DhM2I8/47a/iizca8apcRbXUUoK/k0pibJknT7Cqfi3LhnrUfP5jwFfQHYQa
         puaTqENx0mkFrnFOw4FuOiLXT2twZtk0ffFDHoUFvXE4lgTHyDBMJVgfc7LhKCAt8GK0
         Gh2w==
X-Gm-Message-State: AOAM531J5/qTWqUpf8c38PBu4MH/1Y6TtEVKl1D2nzRvx3ZetbYASEha
        kAOB9SyRzFBw1TknK55Kt3h6ow==
X-Google-Smtp-Source: ABdhPJxNhlDc7MD1X6GJIQAMM12QfFMgW/k9pVSpFNWL3PeQOJU5cYC3DaCNmL0oO3FG1jrng2zvKw==
X-Received: by 2002:a17:90a:e98f:: with SMTP id v15mr684361pjy.41.1598951957568;
        Tue, 01 Sep 2020 02:19:17 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id u191sm1337707pgu.56.2020.09.01.02.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:19:16 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Colin Cross <ccross@google.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michel Lespinasse <walken@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        chenqiwu <chenqiwu@xiaomi.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Cedeno <thomascedeno@google.com>,
        linux-fsdevel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v6 0/3] Anonymous VMA naming patches
Date:   Tue,  1 Sep 2020 14:48:58 +0530
Message-Id: <20200901091901.19779-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Version v4 of these patches was sent by Colin Cross a long time ago [1]
and [2]. At the time, these patches were not merged, and it looks like they
just fell off the radar since.

In our efforts to run Android on mainline kernels, we realised that since past
some time, this patchset is needed for Android to boot, hence I am re-posting
it to try and get these discussed and hopefully merged.

For v5, I rebased these for v5.9-rc3 and fixed minor updates as required.

---
v6: Rebased to v5.9-rc3 and addressed review comments:
    - added missing callers in fs/userfaultd.c
    - simplified the union
    - use the new access_remote_vm_locked() in show_map_vma() since that
       already holds mmap_lock

[1]: https://lore.kernel.org/linux-mm/1383170047-21074-1-git-send-email-ccross@android.com/
[2]: https://lore.kernel.org/linux-mm/1383170047-21074-2-git-send-email-ccross@android.com/

Best,
Sumit.

Colin Cross (2):
  mm: rearrange madvise code to allow for reuse
  mm: add a field to store names for private anonymous memory

Sumit Semwal (1):
  mm: memory: Add access_remote_vm_locked variant

 Documentation/filesystems/proc.rst |   2 +
 fs/proc/task_mmu.c                 |  24 +-
 fs/userfaultfd.c                   |   7 +-
 include/linux/mm.h                 |   7 +-
 include/linux/mm_types.h           |  25 +-
 include/uapi/linux/prctl.h         |   3 +
 kernel/sys.c                       |  32 +++
 mm/interval_tree.c                 |   2 +-
 mm/madvise.c                       | 356 +++++++++++++++++------------
 mm/memory.c                        |  49 +++-
 mm/mempolicy.c                     |   3 +-
 mm/mlock.c                         |   2 +-
 mm/mmap.c                          |  38 +--
 mm/mprotect.c                      |   2 +-
 14 files changed, 374 insertions(+), 178 deletions(-)

-- 
2.28.0

