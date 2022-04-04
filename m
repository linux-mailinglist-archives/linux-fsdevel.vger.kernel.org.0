Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4334F1AEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377457AbiDDVTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380405AbiDDUFA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:00 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE030576;
        Mon,  4 Apr 2022 13:03:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w21so9217259pgm.7;
        Mon, 04 Apr 2022 13:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1/S18NSrxN6AWy6KL3HCZnERr6pCTHzLQu/VSnzK2M=;
        b=Mwnt+Nq2EZKGxVmu8ajENw2WLVM+PMP8Pob4xNoQ9sJszM+9hd34t1sIDnV/JVKWc5
         aIDg3KNtFuuL8pds0a0t4HMMv6NdG8/Ob2k3eOaVEzLQu/lgBUbaSwJM8lQH851qPI2C
         Uvu2USNa1ts9IlrQGSu6wJ7ucpOBHLBcZogtcuYedGIWWrd56NR35kHqBt12SIP00A9W
         6K9FokVb73EcTl/zPpH9YSjS6HsTO1dCfJIFaweMLYOHR7XOoBohWAPOTz8QKw47pABm
         LXEX7pa4IRUch8OMc+3f+1TxlVdWQrjf/xVdlfeCiIUJaGvPRLBDiCy1GWcowr8GQ5qL
         cMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g1/S18NSrxN6AWy6KL3HCZnERr6pCTHzLQu/VSnzK2M=;
        b=xKHZgLMeQoEoNYVI/2Yz3rXV9Lwwhh6Y9i7jZiI2cr6Ug+wHjGOMmaGDoyk5hJ2l3Q
         ouWh78qMBrYt9ws2RExyPeRNF3jZxvaWvMOQP7g/PveIpbEPpYwpd9XD4cDZlZ5EpYdV
         79PfH0O8p1FL5ZbADQEdbRpQQvFXmIjRUyYqValFjeSZw++yfmKNfbIvTYzqYMAKP5CR
         FIpPgbpiJqRQQvImVdTYZq8q6GEMqXcVYlNadRKu1ml91c5V32L0ZPCjM9MgPMCkw1Ug
         xIEm6/aaYXf4H1pgdrvM7BvTxnafN/k31Ih9fq72JTqZyBjt9ivBKMrZl+yeXgAFnRcO
         i0iA==
X-Gm-Message-State: AOAM5330MWJYmo7eEH9F4JStnbeMg0I/havqO0dC3+6lesNHGgDPcGhV
        lM//JrDfNtoO3wmZzk3lFdE=
X-Google-Smtp-Source: ABdhPJzPk7RPw96v5iy70ANgZhWcNVAx23WdjIeS0iVP13r1Jp4hzjPAyCQz5SV25F0Q678GhpbdCQ==
X-Received: by 2002:a65:6d06:0:b0:399:1485:6288 with SMTP id bf6-20020a656d06000000b0039914856288mr1331167pgb.346.1649102582351;
        Mon, 04 Apr 2022 13:03:02 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:01 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
Date:   Mon,  4 Apr 2022 13:02:42 -0700
Message-Id: <20220404200250.321455-1-shy828301@gmail.com>
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
v3: * Register mm to khugepaged in common mmap path instead of touching
      filesystem code (patch 8/8) suggested by Ted.
    * New patch 7/8 cleaned up and renamed khugepaged_enter_vma_merge()
      to khugepaged_enter_vma().
    * Collected acked-by from Song Liu for patch 1 ~ 6.
    * Rebased on top of 5.18-rc1.
    * Excluded linux-xfs and linux-ext4 list since the series doesn't
      touch fs code anymore, but keep linux-fsdevel posted. 
v2: * Collected reviewed-by tags from Miaohe Lin.
    * Fixed build error for patch 4/8.

The readonly FS THP relies on khugepaged to collapse THP for suitable
vmas.  But it is kind of "random luck" for khugepaged to see the
readonly FS vmas (see report: https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/) since currently the vmas are registered to khugepaged when:
  - Anon huge pmd page fault
  - VMA merge
  - MADV_HUGEPAGE
  - Shmem mmap

If the above conditions are not met, even though khugepaged is enabled
it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
explicitly to tell khugepaged to collapse this area, but when khugepaged
mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
is not set.

So make sure readonly FS vmas are registered to khugepaged to make the
behavior more consistent.

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
      mm: khugepaged: move some khugepaged_* functions to khugepaged.c
      mm: khugepaged: introduce khugepaged_enter_vma() helper
      mm: mmap: register suitable readonly file vmas for khugepaged

 include/linux/huge_mm.h        | 14 ++++++++++++
 include/linux/khugepaged.h     | 59 ++++++++++++---------------------------------------
 include/linux/sched/coredump.h |  3 ++-
 kernel/fork.c                  |  4 +---
 mm/huge_memory.c               | 15 ++++---------
 mm/khugepaged.c                | 76 +++++++++++++++++++++++++++++++++++++-----------------------------
 mm/mmap.c                      | 14 ++++++++----
 mm/shmem.c                     | 12 -----------
 8 files changed, 88 insertions(+), 109 deletions(-)


