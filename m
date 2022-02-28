Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C314B4C7ECC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiB1X6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiB1X6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:58:39 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A781B37BDF;
        Mon, 28 Feb 2022 15:57:58 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z2so12067234plg.8;
        Mon, 28 Feb 2022 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0sCSJGBWDN5mRT7aBgm8yBHFMNHKb8Jl03bv/QDMQY=;
        b=GujjR472ePh+4ybziZIBTl5oJqLyn60Vy/wWd2iruPDB8ietcm6zd0dPOqrAvbbVzg
         lu1rmIwMX1tX718vXxLYWh6HqAjNXf6Nt481UeNh7PTTVZnqLMfiLohrXOzMrndT/tF9
         xF7yFEDCllEofZ/7wPRZvgRtjdnb6wT7kJB+cBCSAL+TJqyT67dxGGFriY4zwEms1cL6
         WN3+St0LOh9HKPTqu+svRT/jobZW1/t3wxrwPM0+GURK/tdO/Ks0HXIFu5S6voTDBrJ9
         kNKyUyoKks4IOeFQIC0M34I8we8kcEOXlJjYbXD7Pcj7TYN5u3X7MekovnN3yraE6PkT
         MPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0sCSJGBWDN5mRT7aBgm8yBHFMNHKb8Jl03bv/QDMQY=;
        b=xg+KBZqw8NwaGr78vw/7LBc5VVeNrK++qBd8Qn2grmB7p8i23qjFUnxYC7MNMJOYIx
         dKqqvZYBI0qcov5KnFCTLu25Ryo0BWH7jdDKcacA07/4VZPWPC6+Pf+EQtrej+dBDJtk
         DRpBEotOf54naOCfF7pvzEtsKhTWKySHCOI4IsdsrOBwPtlItyg9tguHeWGY8K6kc4TV
         PksvMASawFFwPup3b5/yCBetWV+GnxDeFkZd26xnnmvfN8ZoCJfEIABsLs7XpLC+G7DO
         OjgI56W6RC8JSE3otczCmf3aNGGJxZsnxYexr+lLyH3MJ5zITuvk7bQzHeOhUGCZ5+Zp
         Yt7Q==
X-Gm-Message-State: AOAM533ceOkqyGab/R/efvZrXhhqfr3xvuvErt6S9fqwJ4wSglk7s2E0
        eAoVyv6GGddgPfx293fVA7A=
X-Google-Smtp-Source: ABdhPJzD9SKtkQ8vuX0qPac1DGv6DOmMazBubWiEtu4ddPmWBpE6VIc64Q3TkV9smEiRbog2V++tHA==
X-Received: by 2002:a17:903:2c7:b0:14f:522c:d33c with SMTP id s7-20020a17090302c700b0014f522cd33cmr23162298plk.143.1646092678136;
        Mon, 28 Feb 2022 15:57:58 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:57:57 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
Date:   Mon, 28 Feb 2022 15:57:33 -0800
Message-Id: <20220228235741.102941-1-shy828301@gmail.com>
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

Registering the vmas in mmap path seems more preferred from performance
point of view since page fault path is definitely hot path.


The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
but I'd like to hear some comments before doing that.


Tested with khugepaged test in selftests and the testcase provided by
Vlastimil Babka in https://lore.kernel.org/lkml/df3b5d1c-a36b-2c73-3e27-99e74983de3a@suse.cz/
by commenting out MADV_HUGEPAGE call.


 b/fs/ext4/file.c                 |    4 +++
 b/fs/xfs/xfs_file.c              |    4 +++
 b/include/linux/huge_mm.h        |    9 +++++++
 b/include/linux/khugepaged.h     |   69 +++++++++++++++++++++----------------------------------------
 b/include/linux/sched/coredump.h |    3 +-
 b/kernel/fork.c                  |    4 ---
 b/mm/huge_memory.c               |   15 +++----------
 b/mm/khugepaged.c                |   71 ++++++++++++++++++++++++++++++++++++++++++++-------------------
 b/mm/shmem.c                     |   14 +++---------
 9 files changed, 102 insertions(+), 91 deletions(-)


