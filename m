Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAEF78593A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjHWN15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbjHWN1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:27:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F2C410CF;
        Wed, 23 Aug 2023 06:27:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC2FD169C;
        Wed, 23 Aug 2023 06:17:09 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866CD3F740;
        Wed, 23 Aug 2023 06:16:23 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC 22/37] mm: shmem: Allocate metadata storage for in-memory filesystems
Date:   Wed, 23 Aug 2023 14:13:35 +0100
Message-Id: <20230823131350.114942-23-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823131350.114942-1-alexandru.elisei@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set __GFP_TAGGED when a new page is faulted in, so the page allocator
reserves the corresponding metadata storage.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 mm/shmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..0b772ec34caa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -81,6 +81,8 @@ static struct vfsmount *shm_mnt;
 
 #include <linux/uaccess.h>
 
+#include <asm/memory_metadata.h>
+
 #include "internal.h"
 
 #define BLOCKS_PER_PAGE  (PAGE_SIZE/512)
@@ -1530,7 +1532,7 @@ static struct folio *shmem_swapin(swp_entry_t swap, gfp_t gfp,
  */
 static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 {
-	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
+	gfp_t allowflags = __GFP_IO | __GFP_FS | __GFP_RECLAIM | __GFP_TAGGED;
 	gfp_t denyflags = __GFP_NOWARN | __GFP_NORETRY;
 	gfp_t zoneflags = limit_gfp & GFP_ZONEMASK;
 	gfp_t result = huge_gfp & ~(allowflags | GFP_ZONEMASK);
@@ -1941,6 +1943,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		goto alloc_nohuge;
 
 	huge_gfp = vma_thp_gfp_mask(vma);
+	if (vma_has_metadata(vma))
+		huge_gfp |= __GFP_TAGGED;
 	huge_gfp = limit_gfp_mask(huge_gfp, gfp);
 	folio = shmem_alloc_and_acct_folio(huge_gfp, inode, index, true);
 	if (IS_ERR(folio)) {
@@ -2101,6 +2105,10 @@ static vm_fault_t shmem_fault(struct vm_fault *vmf)
 	int err;
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
+	/* Fixup gfp flags for metadata enabled VMAs. */
+	if (vma_has_metadata(vma))
+		gfp |= __GFP_TAGGED;
+
 	/*
 	 * Trinity finds that probing a hole which tmpfs is punching can
 	 * prevent the hole-punch from ever completing: which in turn
-- 
2.41.0

