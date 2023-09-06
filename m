Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20341793675
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 09:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjIFHjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjIFHjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:39:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344ABE6;
        Wed,  6 Sep 2023 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693985974; x=1725521974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fgNzEeiwp6pBaULO4mpRILdHhEu7rh3ebMJew1dYykw=;
  b=PnKs9o5qIPXRpbt5VN3AXHE+wHvUR7zFx4VtAIvhTT9jZs1aavCfd8WL
   35gyUSGaoBIvNCEd01Gbj9xVN34jxhaSCP7z9YXx8FpNZfHy8oD3IsWXP
   4jlY/UkFLbRyRW3ytp6rIdwaKwJPmblXUX1QdwkCl+3yg4s5K0XPnJ38l
   hl8vliZIBSLpm6A66Es9qRnl8k+jGBc6HVcMIMPCBlvoFW+S9qC88B9f3
   qRICwlVwI7Fg6LTNhtlbiKP6gnQQia0yTk3Jb2crx46xf+S7xabRCIvtL
   Ru9yd9fmeTQBuM6PN44fdGhMcLviNuF63jgnnyGtmd6XW6XpS9j/k8/k6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375898479"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375898479"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="988133806"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="988133806"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.60.154])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:39:29 -0700
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
Subject: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Date:   Wed,  6 Sep 2023 10:39:02 +0300
Message-Id: <20230906073902.4229-4-adrian.hunter@intel.com>
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

For /dev/mem, this means a read of unaccepted memory will return zeros,
a write to unaccepted memory will be ignored, but an mmap of unaccepted
memory will return an error.

Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/char/mem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 1052b0f2d4cf..1a7c5728783c 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -147,7 +147,8 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 			goto failed;
 
 		err = -EFAULT;
-		if (allowed == 2) {
+		if (allowed == 2 ||
+		    range_contains_unaccepted_memory(p, p + sz)) {
 			/* Show zeros for restricted memory. */
 			remaining = clear_user(buf, sz);
 		} else {
@@ -226,7 +227,8 @@ static ssize_t write_mem(struct file *file, const char __user *buf,
 			return -EPERM;
 
 		/* Skip actual writing when a page is marked as restricted. */
-		if (allowed == 1) {
+		if (allowed == 1 &&
+		    !range_contains_unaccepted_memory(p, p + sz)) {
 			/*
 			 * On ia64 if a page has been mapped somewhere as
 			 * uncached, then it must also be accessed uncached
@@ -378,6 +380,9 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 						&vma->vm_page_prot))
 		return -EINVAL;
 
+	if (range_contains_unaccepted_memory(offset, offset + size))
+		return -EINVAL;
+
 	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
 						 size,
 						 vma->vm_page_prot);
-- 
2.34.1

