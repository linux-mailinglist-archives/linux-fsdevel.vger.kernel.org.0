Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC84190C16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 04:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfHQCY0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 22:24:26 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2664 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfHQCYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:24:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5765610000>; Fri, 16 Aug 2019 19:24:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 16 Aug 2019 19:24:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 16 Aug 2019 19:24:22 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Aug
 2019 02:24:21 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 17 Aug 2019 02:24:21 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5765550002>; Fri, 16 Aug 2019 19:24:21 -0700
From:   <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC PATCH v2 2/3] mm/gup: introduce FOLL_PIN flag for get_user_pages()
Date:   Fri, 16 Aug 2019 19:24:18 -0700
Message-ID: <20190817022419.23304-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190817022419.23304-1-jhubbard@nvidia.com>
References: <20190817022419.23304-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>
DKIM-Signature: v a a-sha256; claxed/relaxed; d idia.com; s;
	t66008674; bhMai0va6k/z2enpQJ4Nfvbj5WByFxGAO1JwdIBbXio	h PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type;
	b�UDSde9XF/IsNteBaYOBWeKiHhWmeU9ekUJNvCviHssBDCtw0T+M/2TlEPEzomIT
	 fGXzIQNlGN6MXFbaBoyBmF/zjCu02TmTNExbVJ3/5N6PTyOuJFCx9ZN1/5gXsB11m1
	 xAHIWE+VOZs4qqDeHDBqKZq+FaxQHNvGz0j6lyVBA70TfseNoZqZZrSil8uvaKJwKd
	 TQ1ht+AGWbw9p610JmaPb4u6o/eV6Ns8Sl3EVnjWWu94T6ISNIaWCiC6wQQF6L1YCH
	 G5Pjn+0rEjhk6XG4TyLudi5lWp3IVBHd8+WlWlnl+bvLCC55RUAjPJLn7LaVyVdh0F
	 nLHwm3bN2Jotg
FOLL_PIN is set by callers of vaddr_pin_pages(). This is different
than FOLL_LONGTERM, because even short term page pins need a new kind
of tracking, if those pinned pages' data is going to potentially
be modified.

This situation is described in more detail in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

FOLL_PIN is added now, rather than waiting until there is code that
takes action based on FOLL_PIN. That's because having FOLL_PIN in
the code helps to highlight the differences between:

    a) get_user_pages(): soon to be deprecated. Used to pin pages,
       but without awareness of file systems that might use those
       pages,

    b) The original vaddr_pin_pages(): intended only for
       FOLL_LONGTERM and DAX use cases. This assumes direct IO
       and therefore is not applicable the most of the other
       callers of get_user_pages(), and

Also add fairly extensive documentation of the meaning and use
of both FOLL_PIN and FOLL_LONGTERM.

Thanks to Jan Kara and Vlastimil Babka for explaining the 4 cases
in this documentation. (I've reworded it and expanded on it slightly.)

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h | 56 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc675e94ddf8..6e7de424bf5e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2644,6 +2644,8 @@ static inline vm_fault_t vmf_error(int err)
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 			 unsigned int foll_flags);
 
+/* Flags for follow_page(), get_user_pages ("GUP"), and vaddr_pin_pages(): */
+
 #define FOLL_WRITE	0x01	/* check pte is writable */
 #define FOLL_TOUCH	0x02	/* mark page accessed */
 #define FOLL_GET	0x04	/* do get_page on page */
@@ -2663,13 +2665,15 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_ANON	0x8000	/* don't do file mappings */
 #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below */
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
+#define FOLL_PIN	0x40000	/* pages must be released via put_user_page() */
 
 /*
- * NOTE on FOLL_LONGTERM:
+ * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
+ * other. Here is what they mean, and how to use them:
  *
  * FOLL_LONGTERM indicates that the page will be held for an indefinite time
- * period _often_ under userspace control.  This is contrasted with
- * iov_iter_get_pages() where usages which are transient.
+ * period _often_ under userspace control.  This is in contrast to
+ * iov_iter_get_pages(), where usages which are transient.
  *
  * FIXME: For pages which are part of a filesystem, mappings are subject to the
  * lifetime enforced by the filesystem and we need guarantees that longterm
@@ -2684,11 +2688,51 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
  * Currently only get_user_pages() and get_user_pages_fast() support this flag
  * and calls to get_user_pages_[un]locked are specifically not allowed.  This
  * is due to an incompatibility with the FS DAX check and
- * FAULT_FLAG_ALLOW_RETRY
+ * FAULT_FLAG_ALLOW_RETRY.
  *
- * In the CMA case: longterm pins in a CMA region would unnecessarily fragment
- * that region.  And so CMA attempts to migrate the page before pinning when
+ * In the CMA case: long term pins in a CMA region would unnecessarily fragment
+ * that region.  And so, CMA attempts to migrate the page before pinning, when
  * FOLL_LONGTERM is specified.
+ *
+ * FOLL_PIN indicates that a special kind of tracking (not just page->_refcount,
+ * but an additional pin counting system) will be invoked. This is intended for
+ * anything that gets a page reference and then touches page data (for example,
+ * Direct IO). This lets the filesystem know that some non-file-system entity is
+ * potentially changing the pages' data. FOLL_PIN pages must be released,
+ * ultimately, by a call to put_user_page(). Typically that will be via one of
+ * the vaddr_unpin_pages() variants.
+ *
+ * FIXME: note that this special tracking is not in place yet. However, the
+ * pages should still be released by put_user_page().
+ *
+ * When and where to use each flag:
+ *
+ * CASE 1: Direct IO (DIO). There are GUP references to pages that are serving
+ * as DIO buffers. These buffers are needed for a relatively short time (so they
+ * are not "long term"). No special synchronization with page_mkclean() or
+ * munmap() is provided. Therefore, flags to set at the call site are:
+ *
+ *     FOLL_PIN
+ *
+ * CASE 2: RDMA. There are GUP references to pages that are serving as DMA
+ * buffers. These buffers are needed for a long time ("long term"). No special
+ * synchronization with page_mkclean() or munmap() is provided. Therefore, flags
+ * to set at the call site are:
+ *
+ *     FOLL_PIN | FOLL_LONGTERM
+ *
+ * There is also a special case when the pages are DAX pages: in addition to the
+ * above flags, the caller needs a file lease. This is provided via the struct
+ * vaddr_pin argument to vaddr_pin_pages().
+ *
+ * CASE 3: ODP (Mellanox/Infiniband On Demand Paging: the hardware supports
+ * replayable page faulting). There are GUP references to pages serving as DMA
+ * buffers. For ODP, MMU notifiers are used to synchronize with page_mkclean()
+ * and munmap(). Therefore, normal GUP calls are sufficient, so neither flag
+ * needs to be set.
+ *
+ * CASE 4: pinning for struct page manipulation only. Here, normal GUP calls are
+ * sufficient, so neither flag needs to be set.
  */
 
 static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
-- 
2.22.1

