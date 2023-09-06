Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB85579366C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjIFHj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjIFHj2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:39:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D107CFF;
        Wed,  6 Sep 2023 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985965; x=1725521965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qvs+CfaaOcukCPcQ3yn99op16Cq3tmycYYGCo66m1aQ=;
  b=kwrZY6Ut+8R+95gMkpMAf2aMdCGH4KrJn+GQrVO3Xy6s4m09jDPWukG/
   RqgMRnLqvGGuVHvRkU4m+6JEsbjJTmiDTDAWSwgb2z9BCTXB07EWiWWkh
   l/0qUSJYMP5b85NjTH/dGOXz/4gvPACQeSFKGflZjfHsklCHouVya7ulc
   m0Q+F597laFR45zMMcWwzhjjp5alGiUVoK+nnbYrzFFR8WJNz2SdUDk7c
   6ghBOe9LEZivArtyB9A964u3XCU9hcZohCC/Mowve1iKmea7AtFmPq/M8
   GBHnKsbKzXy+vQYL1sbrADq0oxEDasPzOi32YbtYbIF0dquV+as2BNQE4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898449"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898449"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133789"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133789"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:20 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCH 1/3] proc/vmcore: Do not map unaccepted memory
Date:   Wed,  6 Sep 2023 10:39:00 +0300
Message-Id: <20230906073902.4229-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906073902.4229-1-adrian.hunter@intel.com>
References: <20230906073902.4229-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support for unaccepted memory was added recently, refer commit
dcdfdd40fa82 ("mm: Add support for unaccepted memory"), whereby
a virtual machine may need to accept memory before it can be used.

Do not map unaccepted memory because it can cause the guest to fail.

For /proc/vmcore, which is read-only, this means a read or mmap of
unaccepted memory will return zeros.

Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 fs/proc/vmcore.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..a28da2033ce8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -118,6 +118,13 @@ static bool pfn_is_ram(unsigned long pfn)
 	return ret;
 }
 
+static bool pfn_is_unaccepted_memory(unsigned long pfn)
+{
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
+
+	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
+}
+
 static int open_vmcore(struct inode *inode, struct file *file)
 {
 	spin_lock(&vmcore_cb_lock);
@@ -150,7 +157,7 @@ ssize_t read_from_oldmem(struct iov_iter *iter, size_t count,
 			nr_bytes = count;
 
 		/* If pfn is not ram, return zeros for sparse dump files */
-		if (!pfn_is_ram(pfn)) {
+		if (!pfn_is_ram(pfn) || pfn_is_unaccepted_memory(pfn)) {
 			tmp = iov_iter_zero(nr_bytes, iter);
 		} else {
 			if (encrypted)
@@ -511,7 +518,7 @@ static int remap_oldmem_pfn_checked(struct vm_area_struct *vma,
 	pos_end = pfn + (size >> PAGE_SHIFT);
 
 	for (pos = pos_start; pos < pos_end; ++pos) {
-		if (!pfn_is_ram(pos)) {
+		if (!pfn_is_ram(pos) || pfn_is_unaccepted_memory(pos)) {
 			/*
 			 * We hit a page which is not ram. Remap the continuous
 			 * region between pos_start and pos-1 and replace
@@ -552,6 +559,7 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 			    unsigned long from, unsigned long pfn,
 			    unsigned long size, pgprot_t prot)
 {
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
 	int ret, idx;
 
 	/*
@@ -559,7 +567,8 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 	 * pages without a reason.
 	 */
 	idx = srcu_read_lock(&vmcore_cb_srcu);
-	if (!list_empty(&vmcore_cb_list))
+	if (!list_empty(&vmcore_cb_list) ||
+	    range_contains_unaccepted_memory(paddr, paddr + size))
 		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
 	else
 		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);
-- 
2.34.1

