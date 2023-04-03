Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556586D4326
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 13:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjDCLOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjDCLNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:13:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 190281A95E;
        Mon,  3 Apr 2023 04:13:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE3F1063;
        Mon,  3 Apr 2023 04:14:01 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.57.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33EB73F6C4;
        Mon,  3 Apr 2023 04:13:15 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Price <steven.price@arm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] smaps: Fix defined but not used smaps_shmem_walk_ops
Date:   Mon,  3 Apr 2023 12:12:55 +0100
Message-Id: <20230403111255.141623-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When !CONFIG_SHMEM smaps_shmem_walk_ops is defined but not used,
triggering a compiler warning. Surround the definition with an #ifdef to
keep the compiler happy.

Fixes: 7b86ac3371b7 ("pagewalk: separate function pointers from iterator data")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304031749.UiyJpxzF-lkp@intel.com/
Signed-off-by: Steven Price <steven.price@arm.com>
---
 fs/proc/task_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6a96e1713fd5..3d4f8859dac1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -761,11 +761,13 @@ static const struct mm_walk_ops smaps_walk_ops = {
 	.hugetlb_entry		= smaps_hugetlb_range,
 };
 
+#ifdef CONFIG_SHMEM
 static const struct mm_walk_ops smaps_shmem_walk_ops = {
 	.pmd_entry		= smaps_pte_range,
 	.hugetlb_entry		= smaps_hugetlb_range,
 	.pte_hole		= smaps_pte_hole,
 };
+#endif
 
 /*
  * Gather mem stats from @vma with the indicated beginning
-- 
2.34.1

