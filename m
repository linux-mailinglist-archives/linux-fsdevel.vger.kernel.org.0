Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC905A2D47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbiHZRSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344740AbiHZRST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:18:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09369E094B;
        Fri, 26 Aug 2022 10:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534296; x=1693070296;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LsOnSwP3WX7FSaGrxr4QTRIs8WWv2jITSkmOpyZ+1Mk=;
  b=eM+noYHh599y1a2VsBERvsO2Iudt2ebpLoNRoAPpq/+ok3M3f2uwN1KI
   3sft2Lvl79y6fOebAYuCpNOqNmLHX/FM8Vt7koH2R8hFNbTDvRPUWSwSy
   48o4P98CG30dCsNg4m09HjdggBhvRi/9v2e/8k4VJj8UrWojMu7tC7cv/
   /D+9Y/YiusM1tKaM2tc3jFA/DXPZjHU2yPnEPB0U832nmIVSVqCfGQT48
   NWnq4q3u62HsPin/l/2bZtmgKa9pH6PZy5QfCf57kmEk/MogWK+18MCSg
   ztLDK+z6RN9Yv0iqpj/r91yYeGZHh1GLOhtZUhDgJ9qTq6Tty4vakRVyL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="320659876"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320659876"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:18:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="678933461"
Received: from jodirobx-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.108.22])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:18:14 -0700
Subject: [PATCH 4/4] mm/memory-failure: Fall back to vma_address() when
 ->notify_failure() fails
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org, djwong@kernel.org
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Christoph Hellwig <hch@lst.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Jane Chu <jane.chu@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 26 Aug 2022 10:18:14 -0700
Message-ID: <166153429427.2758201.14605968329933175594.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
References: <166153426798.2758201.15108211981034512993.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the case where a filesystem is polled to take over the memory failure
and receives -EOPNOTSUPP it indicates that page->index and page->mapping
are valid for reverse mapping the failure address. Introduce
FSDAX_INVALID_PGOFF to distinguish when add_to_kill() is being called
from mf_dax_kill_procs() by a filesytem vs the typical memory_failure()
path.

Otherwise, vma_pgoff_address() is called with an invalid fsdax_pgoff
which then trips this failing signature:

 kernel BUG at mm/memory-failure.c:319!
 invalid opcode: 0000 [#1] PREEMPT SMP PTI
 CPU: 13 PID: 1262 Comm: dax-pmd Tainted: G           OE    N 6.0.0-rc2+ #62
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 RIP: 0010:add_to_kill.cold+0x19d/0x209
 [..]
 Call Trace:
  <TASK>
  collect_procs.part.0+0x2c4/0x460
  memory_failure+0x71b/0xba0
  ? _printk+0x58/0x73
  do_madvise.part.0.cold+0xaf/0xc5

Fixes: c36e20249571 ("mm: introduce mf_dax_kill_procs() for fsdax case")
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ritesh Harjani <riteshh@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/memory-failure.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8a4294afbfa0..e424a9dac749 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -345,13 +345,17 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
  * not much we can do.	We just print a message and ignore otherwise.
  */
 
+#define FSDAX_INVALID_PGOFF ULONG_MAX
+
 /*
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
  *
- * Notice: @fsdax_pgoff is used only when @p is a fsdax page.
- *   In other cases, such as anonymous and file-backend page, the address to be
- *   killed can be caculated by @p itself.
+ * Note: @fsdax_pgoff is used only when @p is a fsdax page and a
+ * filesystem with a memory failure handler has claimed the
+ * memory_failure event. In all other cases, page->index and
+ * page->mapping are sufficient for mapping the page back to its
+ * corresponding user virtual address.
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
 			pgoff_t fsdax_pgoff, struct vm_area_struct *vma,
@@ -367,11 +371,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 
 	tk->addr = page_address_in_vma(p, vma);
 	if (is_zone_device_page(p)) {
-		/*
-		 * Since page->mapping is not used for fsdax, we need
-		 * calculate the address based on the vma.
-		 */
-		if (p->pgmap->type == MEMORY_DEVICE_FS_DAX)
+		if (fsdax_pgoff != FSDAX_INVALID_PGOFF)
 			tk->addr = vma_pgoff_address(fsdax_pgoff, 1, vma);
 		tk->size_shift = dev_pagemap_mapping_shift(vma, tk->addr);
 	} else
@@ -523,7 +523,8 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, 0, vma, to_kill);
+				add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma,
+					    to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -559,7 +560,8 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, 0, vma, to_kill);
+				add_to_kill(t, page, FSDAX_INVALID_PGOFF, vma,
+					    to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);

