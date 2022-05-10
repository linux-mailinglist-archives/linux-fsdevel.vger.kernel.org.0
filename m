Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9524A52257B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiEJUck (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiEJUcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:39 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BE613CA06;
        Tue, 10 May 2022 13:32:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d25so133184pfo.10;
        Tue, 10 May 2022 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZL8O1wtZrk4M8KM+4lA9arzBMXGuQKMerxUEh8SBcc=;
        b=Cm/LE0XiCVm4iQSaMhhk6SEWyk3ZLbJRizxoNhv2dwIoAGUW6OUbIlFpVRWFDVd+KJ
         tDijS4iL1LCE7RUxiQDG8ceLKIiFdpxoqOPKPsQ8fJ60COZnHB0TeV1gmiAUK1zO8lKu
         rGnqPBSroUwJb5DdX5+1NouNflwHRsycfhE+bADtLYEFf5MEwgVOJXV8GM7t4/X0rwy+
         vjhBDlFpMwpLXGSopSg3hnB052xRKpzZ1yWzTvaj7OUIykFEh1yqaxoSLXXgyPU6bpro
         R9ousnLqVT4M00SDc5iktQjVNk6XLtNeFpUCWD5BCbIecF5hlp8UNNlJBKDj+9p1t1kI
         KioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZL8O1wtZrk4M8KM+4lA9arzBMXGuQKMerxUEh8SBcc=;
        b=yewZtc7TWNC+xEZpxCo+WWMryayfkdWxlbEkkaZVKbX9IvmNQPXJBvc2eiy5xX+xWc
         xHKC8JnmpcTIcBx02r1ywmSSp/WuBxtCguZhJ0GiI8piuPeXw2j0YHifVQOmTwQhJ+g4
         Jaz5uR0yhnJUpVZzso9vKVZVuYTpuWHMlHAV0KE3fTtaHElxaHMAgCdrpeTnL6FT1N5q
         nqADtg5LaIu2zwjoAlC6RwLFHDMpHZg2UaXH6ex+djaVVwfwjonph8KK99jEMrj35TXG
         yaCTNM48uCiDlBLAwkIJEZjam1gOx4OSRutOC66G0bujmdZ6dQWEH22p30eY6GNm4gaA
         NZbw==
X-Gm-Message-State: AOAM5318qPzPtvzUV05IOgTeizF05IHjZ6iX8wpsejBwLMjPDQXra6cH
        CSFj430JTvMIaj6Co9e2U1w=
X-Google-Smtp-Source: ABdhPJzaY/yOQRxh5ZIcbkcP6xwI7OojJbecUuTOd0gyxPyzQS2tg1L3ZqW2mh63GX5keJtw5JdcuA==
X-Received: by 2002:a63:8543:0:b0:3ab:5afb:200c with SMTP id u64-20020a638543000000b003ab5afb200cmr17858732pgd.402.1652214757980;
        Tue, 10 May 2022 13:32:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:36 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [mm-unstable v4 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
Date:   Tue, 10 May 2022 13:32:14 -0700
Message-Id: <20220510203222.24246-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Changelog
v4: * Incorporated Vlastimil's comments for patch 6/8.
    * Reworked the commit log of patch 8/8 to make what the series fixed
      clearer.
    * Rebased onto mm-unstable tree.
    * Collected the acks from Vlastimil.
v3: * Register mm to khugepaged in common mmap path instead of touching
      filesystem code (patch 8/8).
    * New patch 7/8 cleaned up and renamed khugepaged_enter_vma_merge()
      to khugepaged_enter_vma().
    * Collected acked-by from Song Liu for patch 1 ~ 6.
    * Rebased on top of 5.18-rc1.
v2: * Collected reviewed-by tags from Miaohe Lin.
    * Fixed build error for patch 4/8.

The readonly FS THP relies on khugepaged to collapse THP for suitable
vmas.  But the behavior is inconsistent for "always" mode (https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/).

The "always" mode means THP allocation should be tried all the time and
khugepaged should try to collapse THP all the time. Of course the
allocation and collapse may fail due to other factors and conditions.

Currently file THP may not be collapsed by khugepaged even though all
the conditions are met. That does break the semantics of "always" mode.

So make sure readonly FS vmas are registered to khugepaged to fix the
break.

Registering suitable vmas in common mmap path, that could cover both
readonly FS vmas and shmem vmas, so removed the khugepaged calls in
shmem.c.

The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
The patch 8 is the real meat. 


Tested with khugepaged test in selftests and the testcase provided by
Vlastimil Babka in https://lore.kernel.org/lkml/df3b5d1c-a36b-2c73-3e27-99e74983de3a@suse.cz/
by commenting out MADV_HUGEPAGE call.


Yang Shi (8):
      sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
      mm: khugepaged: remove redundant check for VM_NO_KHUGEPAGED
      mm: khugepaged: skip DAX vma
      mm: thp: only regular file could be THP eligible
      mm: khugepaged: make khugepaged_enter() void function
      mm: khugepaged: make hugepage_vma_check() non-static
      mm: khugepaged: introduce khugepaged_enter_vma() helper
      mm: mmap: register suitable readonly file vmas for khugepaged

 include/linux/huge_mm.h        | 14 ++++++++++++++
 include/linux/khugepaged.h     | 44 ++++++++++++++++++--------------------------
 include/linux/sched/coredump.h |  3 ++-
 kernel/fork.c                  |  4 +---
 mm/huge_memory.c               | 15 ++++-----------
 mm/khugepaged.c                | 61 ++++++++++++++++++++++++++-----------------------------------
 mm/mmap.c                      | 18 ++++++++++++------
 mm/shmem.c                     | 12 ------------
 8 files changed, 77 insertions(+), 94 deletions(-)

