Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2463FB15EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 23:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfILViQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 17:38:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:29755 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbfILViN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:38:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2019 14:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179487181"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2019 14:31:45 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 3/3] fs/userfaultfd.c: wrap cheching huge page alignment into a helper
Date:   Fri, 13 Sep 2019 05:31:10 +0800
Message-Id: <20190912213110.3691-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912213110.3691-1-richardw.yang@linux.intel.com>
References: <20190912213110.3691-1-richardw.yang@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are three places checking whether one address is huge page
aligned.

This patch just makes a helper function to wrap it up.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 fs/userfaultfd.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 70c0e0ef01d7..d8665ffdd576 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1296,6 +1296,16 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma)
 		vma_is_shmem(vma);
 }
 
+static inline bool addr_huge_page_aligned(unsigned long addr,
+					  struct vm_area_struct *vma)
+{
+	unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
+
+	if (addr & (vma_hpagesize - 1))
+		return false;
+	return true;
+}
+
 static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
@@ -1363,12 +1373,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	 * If the first vma contains huge pages, make sure start address
 	 * is aligned to huge page size.
 	 */
-	if (is_vm_hugetlb_page(vma)) {
-		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
-
-		if (start & (vma_hpagesize - 1))
-			goto out_unlock;
-	}
+	if (is_vm_hugetlb_page(vma) && !addr_huge_page_aligned(start, vma))
+		goto out_unlock;
 
 	/*
 	 * Search for not compatible vmas.
@@ -1403,11 +1409,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * check alignment.
 		 */
 		if (end <= cur->vm_end && is_vm_hugetlb_page(cur)) {
-			unsigned long vma_hpagesize = vma_kernel_pagesize(cur);
-
 			ret = -EINVAL;
 
-			if (end & (vma_hpagesize - 1))
+			if (!addr_huge_page_aligned(end, cur))
 				goto out_unlock;
 		}
 
@@ -1551,12 +1555,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	 * If the first vma contains huge pages, make sure start address
 	 * is aligned to huge page size.
 	 */
-	if (is_vm_hugetlb_page(vma)) {
-		unsigned long vma_hpagesize = vma_kernel_pagesize(vma);
-
-		if (start & (vma_hpagesize - 1))
-			goto out_unlock;
-	}
+	if (is_vm_hugetlb_page(vma) && !addr_huge_page_aligned(start, vma))
+		goto out_unlock;
 
 	/*
 	 * Search for not compatible vmas.
-- 
2.17.1

