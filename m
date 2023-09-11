Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2C79B886
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbjIKUwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbjIKLVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:21:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE45CDD;
        Mon, 11 Sep 2023 04:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431295; x=1725967295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zw3TazwdjRU8wNvK9+zXRRn6LyFt0jKcjaf9En8Up90=;
  b=DuBiQy9DYCe4DWIdG2Lq52ezZL8iy+a50JRM43SHBwqKCiSjPS1vkmNG
   px4jq/V36rnvtz4kE2f/iLmxaBpyz728tH9SFRSOvh7dmm1KaX72jRDbJ
   c6rjuB/jy2LiA6CbqyLEi29Y6Qkn9989LFgWr5hSI/kEAsVGffpx20fn5
   yD+m8p86AnRtGhIJU6GtT3IeOxm86q/XdrBhhz/+wcrGk/3l6rHCJkE9f
   QSt32wZkZ2gOqrCXaiHjTRm9EwsQCC2eaCmQE5/9ZPsNYphU8zbn+taUL
   Y4CvRBthIYVG1teV41WtazKXKdcOSGwtSfZ+NEpUwQUBH2gUJ7h/xmQ12
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358358414"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358358414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="778356397"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="778356397"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.216.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:21:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
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
Subject: [PATCH V2 1/2] efi/unaccepted: Do not let /proc/vmcore try to access unaccepted memory
Date:   Mon, 11 Sep 2023 14:21:13 +0300
Message-Id: <20230911112114.91323-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911112114.91323-1-adrian.hunter@intel.com>
References: <20230911112114.91323-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support for unaccepted memory was added recently, refer commit dcdfdd40fa82
("mm: Add support for unaccepted memory"), whereby a virtual machine may
need to accept memory before it can be used.

Do not let /proc/vmcore try to access unaccepted memory because it can
cause the guest to fail.

For /proc/vmcore, which is read-only, this means a read or mmap of
unaccepted memory will return zeros.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/firmware/efi/unaccepted_memory.c | 20 ++++++++++++++++++++
 include/linux/mm.h                       |  7 +++++++
 2 files changed, 27 insertions(+)


Changes in V2:

          Change patch subject and commit message
          Use vmcore_cb->.pfn_is_ram() instead of changing vmcore.c


diff --git a/drivers/firmware/efi/unaccepted_memory.c b/drivers/firmware/efi/unaccepted_memory.c
index 853f7dc3c21d..79ba576b22e3 100644
--- a/drivers/firmware/efi/unaccepted_memory.c
+++ b/drivers/firmware/efi/unaccepted_memory.c
@@ -3,6 +3,7 @@
 #include <linux/efi.h>
 #include <linux/memblock.h>
 #include <linux/spinlock.h>
+#include <linux/crash_dump.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap */
@@ -145,3 +146,22 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
 
 	return ret;
 }
+
+#ifdef CONFIG_PROC_VMCORE
+static bool unaccepted_memory_vmcore_pfn_is_ram(struct vmcore_cb *cb,
+						unsigned long pfn)
+{
+	return !pfn_is_unaccepted_memory(pfn);
+}
+
+static struct vmcore_cb vmcore_cb = {
+	.pfn_is_ram = unaccepted_memory_vmcore_pfn_is_ram,
+};
+
+static int __init unaccepted_memory_init_kdump(void)
+{
+	register_vmcore_cb(&vmcore_cb);
+	return 0;
+}
+core_initcall(unaccepted_memory_init_kdump);
+#endif /* CONFIG_PROC_VMCORE */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..86511150f1d4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4062,4 +4062,11 @@ static inline void accept_memory(phys_addr_t start, phys_addr_t end)
 
 #endif
 
+static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
+{
+	phys_addr_t paddr = pfn << PAGE_SHIFT;
+
+	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
+}
+
 #endif /* _LINUX_MM_H */
-- 
2.34.1

