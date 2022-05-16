Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A5A528D34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 20:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbiEPSiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbiEPSiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 14:38:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77583E5CE;
        Mon, 16 May 2022 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652726293; x=1684262293;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7AM5k8AO/W2t+cZjnYYeeQP/HpRONzh9TN18QNX30k=;
  b=TpTZGeBLGJVrNWLoQHfPe41igvXv4XsuWYqhz8vl+iTqmdLGcg+Bv8fp
   2sQVwMh9QEHR2pDyUNOZJJnUxh0D93fjuInuVeH6DH4Jev3Z9SGrFLWlZ
   Iec0kOtso26cH6r/+a8SFy13C5Ou7WQA3y5fesLtfnm9i5cNYDK4tKJGZ
   zKk3drS1vkV/O3TcxxtQLgHcBNuTOf/aw6HdododakUP2w1P+sAZXKMqV
   A585lifCTxNVSx9NtGVy55N2toSHJw6PedNYrBv4zMUVUprUcjgtraqA1
   Rmg6t1qQXSbe+R0lX8Uz63kmjq9yUeAC0GOk3eimekrwmDOi+CxpJkYuE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="333974255"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="333974255"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:38:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="672478686"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 11:38:10 -0700
Subject: [PATCH v10 3/7] mce: fix set_mce_nospec to always unmap the whole
 page
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jane Chu <jane.chu@oracle.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Mon, 16 May 2022 11:38:10 -0700
Message-ID: <165272615484.103830.2563950688772226611.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <20220422224508.440670-4-jane.chu@oracle.com>
References: <20220422224508.440670-4-jane.chu@oracle.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>

The set_memory_uc() approach doesn't work well in all cases.
As Dan pointed out when "The VMM unmapped the bad page from
guest physical space and passed the machine check to the guest."
"The guest gets virtual #MC on an access to that page. When
the guest tries to do set_memory_uc() and instructs cpa_flush()
to do clean caches that results in taking another fault / exception
perhaps because the VMM unmapped the page from the guest."

Since the driver has special knowledge to handle NP or UC,
mark the poisoned page with NP and let driver handle it when
it comes down to repair.

Please refer to discussions here for more details.
https://lore.kernel.org/all/CAPcyv4hrXPb1tASBZUg-GgdVs0OOFKXMXLiHmktg_kFi7YBMyQ@mail.gmail.com/

Now since poisoned page is marked as not-present, in order to
avoid writing to a not-present page and trigger kernel Oops,
also fix pmem_do_write().

Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20220422224508.440670-4-jane.chu@oracle.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v9:
- Collect Tony's ack
- Rebase on [PATCH v11 2/7]:
https://lore.kernel.org/r/165272527328.90175.8336008202048685278.stgit@dwillia2-desk3.amr.corp.intel.com

 arch/x86/kernel/cpu/mce/core.c |    6 +++---
 arch/x86/mm/pat/set_memory.c   |   23 +++++++++++------------
 drivers/nvdimm/pmem.c          |   30 +++++++-----------------------
 include/linux/set_memory.h     |    4 ++--
 4 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 981496e6bc0e..fa67bb9d1afe 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -579,7 +579,7 @@ static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
 
 	pfn = mce->addr >> PAGE_SHIFT;
 	if (!memory_failure(pfn, 0)) {
-		set_mce_nospec(pfn, whole_page(mce));
+		set_mce_nospec(pfn);
 		mce->kflags |= MCE_HANDLED_UC;
 	}
 
@@ -1316,7 +1316,7 @@ static void kill_me_maybe(struct callback_head *cb)
 
 	ret = memory_failure(p->mce_addr >> PAGE_SHIFT, flags);
 	if (!ret) {
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
 		sync_core();
 		return;
 	}
@@ -1342,7 +1342,7 @@ static void kill_me_never(struct callback_head *cb)
 	p->mce_count = 0;
 	pr_err("Kernel accessed poison in user space at %llx\n", p->mce_addr);
 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, 0))
-		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
 }
 
 static void queue_task_work(struct mce *m, char *msg, void (*func)(struct callback_head *))
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 0caf4b0edcbc..44f0d4260bd8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1925,14 +1925,9 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
-/*
- * Prevent speculative access to the page by either unmapping
- * it (if we do not require access to any part of the page) or
- * marking it uncacheable (if we want to try to retrieve data
- * from non-poisoned lines in the page).
- */
+/* Prevent speculative access to a page by marking it not-present */
 #ifdef CONFIG_X86_64
-int set_mce_nospec(unsigned long pfn, bool unmap)
+int set_mce_nospec(unsigned long pfn)
 {
 	unsigned long decoy_addr;
 	int rc;
@@ -1954,19 +1949,23 @@ int set_mce_nospec(unsigned long pfn, bool unmap)
 	 */
 	decoy_addr = (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63));
 
-	if (unmap)
-		rc = set_memory_np(decoy_addr, 1);
-	else
-		rc = set_memory_uc(decoy_addr, 1);
+	rc = set_memory_np(decoy_addr, 1);
 	if (rc)
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
 	return rc;
 }
 
+static int set_memory_present(unsigned long *addr, int numpages)
+{
+	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_PRESENT), 0);
+}
+
 /* Restore full speculative operation to the pfn. */
 int clear_mce_nospec(unsigned long pfn)
 {
-	return set_memory_wb((unsigned long) pfn_to_kaddr(pfn), 1);
+	unsigned long addr = (unsigned long) pfn_to_kaddr(pfn);
+
+	return set_memory_present(&addr, 1);
 }
 EXPORT_SYMBOL_GPL(clear_mce_nospec);
 #endif /* CONFIG_X86_64 */
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..4aa17132a557 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -158,36 +158,20 @@ static blk_status_t pmem_do_write(struct pmem_device *pmem,
 			struct page *page, unsigned int page_off,
 			sector_t sector, unsigned int len)
 {
-	blk_status_t rc = BLK_STS_OK;
-	bool bad_pmem = false;
 	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
 	void *pmem_addr = pmem->virt_addr + pmem_off;
 
-	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
-		bad_pmem = true;
+	if (unlikely(is_bad_pmem(&pmem->bb, sector, len))) {
+		blk_status_t rc = pmem_clear_poison(pmem, pmem_off, len);
+
+		if (rc != BLK_STS_OK)
+			return rc;
+	}
 
-	/*
-	 * Note that we write the data both before and after
-	 * clearing poison.  The write before clear poison
-	 * handles situations where the latest written data is
-	 * preserved and the clear poison operation simply marks
-	 * the address range as valid without changing the data.
-	 * In this case application software can assume that an
-	 * interrupted write will either return the new good
-	 * data or an error.
-	 *
-	 * However, if pmem_clear_poison() leaves the data in an
-	 * indeterminate state we need to perform the write
-	 * after clear poison.
-	 */
 	flush_dcache_page(page);
 	write_pmem(pmem_addr, page, page_off, len);
-	if (unlikely(bad_pmem)) {
-		rc = pmem_clear_poison(pmem, pmem_off, len);
-		write_pmem(pmem_addr, page, page_off, len);
-	}
 
-	return rc;
+	return BLK_STS_OK;
 }
 
 static void pmem_submit_bio(struct bio *bio)
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 683a6c3f7179..369769ce7399 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -43,10 +43,10 @@ static inline bool can_set_direct_map(void)
 #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 
 #ifdef CONFIG_X86_64
-int set_mce_nospec(unsigned long pfn, bool unmap);
+int set_mce_nospec(unsigned long pfn);
 int clear_mce_nospec(unsigned long pfn);
 #else
-static inline int set_mce_nospec(unsigned long pfn, bool unmap)
+static inline int set_mce_nospec(unsigned long pfn)
 {
 	return 0;
 }

