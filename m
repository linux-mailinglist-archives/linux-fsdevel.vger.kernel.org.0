Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF026D79E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbjDEKij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDEKii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:38:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B252349F9;
        Wed,  5 Apr 2023 03:38:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A73451684;
        Wed,  5 Apr 2023 03:39:20 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.94.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 684223F73F;
        Wed,  5 Apr 2023 03:38:34 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Price <steven.price@arm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] smaps: Fix defined but not used smaps_shmem_walk_ops
Date:   Wed,  5 Apr 2023 11:38:19 +0100
Message-Id: <20230405103819.151246-1-steven.price@arm.com>
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
triggering a compiler warning. To avoid the warning remove the #ifdef
around the usage. This has no effect because shmem_mapping() is a stub
returning false when !CONFIG_SHMEM so the code will be compiled out,
however we now need to also provide a stub for shmem_swap_usage().

Fixes: 7b86ac3371b7 ("pagewalk: separate function pointers from iterator data")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304031749.UiyJpxzF-lkp@intel.com/
Signed-off-by: Steven Price <steven.price@arm.com>
---
I've implemented Jason's suggestion of removing the #ifdef around the
usage and prodiving a stub for shmem_swap_usage() instead.

 fs/proc/task_mmu.c       | 3 +--
 include/linux/shmem_fs.h | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6a96e1713fd5..cb49479acd2e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -782,7 +782,6 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 	if (start >= vma->vm_end)
 		return;
 
-#ifdef CONFIG_SHMEM
 	if (vma->vm_file && shmem_mapping(vma->vm_file->f_mapping)) {
 		/*
 		 * For shared or readonly shmem mappings we know that all
@@ -803,7 +802,7 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 			ops = &smaps_shmem_walk_ops;
 		}
 	}
-#endif
+
 	/* mmap_lock is held in m_start */
 	if (!start)
 		walk_page_vma(vma, ops, mss);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 103d1000a5a2..762c37b32bd4 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -94,7 +94,14 @@ int shmem_unuse(unsigned int type);
 
 extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
 			  struct mm_struct *mm, unsigned long vm_flags);
+#ifdef CONFIG_SHMEM
 extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
+#else
+static inline unsigned long shmem_swap_usage(struct vm_area_struct *vma)
+{
+	return 0;
+}
+#endif
 extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
 						pgoff_t start, pgoff_t end);
 
-- 
2.34.1

