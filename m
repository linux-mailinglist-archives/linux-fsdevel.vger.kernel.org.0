Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D198866F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 00:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfHIW7G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:59:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:23377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfHIW7F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:59:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:05 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="176932450"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:04 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
Date:   Fri,  9 Aug 2019 15:58:29 -0700
Message-Id: <20190809225833.6657-16-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The addition of FOLL_LONGTERM has taken on additional meaning for CMA
pages.

In addition subsystems such as RDMA require new information to be passed
to the GUP interface to track file owning information.  As such a simple
FOLL_LONGTERM flag is no longer sufficient for these users to pin pages.

Introduce a new GUP like call which takes the newly introduced vaddr_pin
information.  Failure to pass the vaddr_pin object back to a vaddr_put*
call will result in a failure if pins were created on files during the
pin operation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from list:
	Change to vaddr_put_pages_dirty_lock
	Change to vaddr_unpin_pages_dirty_lock

 include/linux/mm.h |  5 ++++
 mm/gup.c           | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 657c947bda49..90c5802866df 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1603,6 +1603,11 @@ int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
 
+long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
+		     unsigned int gup_flags, struct page **pages,
+		     struct vaddr_pin *vaddr_pin);
+void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
+				  struct vaddr_pin *vaddr_pin, bool make_dirty);
 bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *page);
 
 /* Container for pinned pfns / pages */
diff --git a/mm/gup.c b/mm/gup.c
index eeaa0ddd08a6..6d23f70d7847 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2536,3 +2536,62 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(get_user_pages_fast);
+
+/**
+ * vaddr_pin_pages pin pages by virtual address and return the pages to the
+ * user.
+ *
+ * @addr, start address
+ * @nr_pages, number of pages to pin
+ * @gup_flags, flags to use for the pin
+ * @pages, array of pages returned
+ * @vaddr_pin, initalized meta information this pin is to be associated
+ * with.
+ *
+ * NOTE regarding vaddr_pin:
+ *
+ * Some callers can share pins via file descriptors to other processes.
+ * Callers such as this should use the f_owner field of vaddr_pin to indicate
+ * the file the fd points to.  All other callers should use the mm this pin is
+ * being made against.  Usually "current->mm".
+ *
+ * Expects mmap_sem to be read locked.
+ */
+long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
+		     unsigned int gup_flags, struct page **pages,
+		     struct vaddr_pin *vaddr_pin)
+{
+	long ret;
+
+	gup_flags |= FOLL_LONGTERM;
+
+	if (!vaddr_pin || (!vaddr_pin->mm && !vaddr_pin->f_owner))
+		return -EINVAL;
+
+	ret = __gup_longterm_locked(current,
+				    vaddr_pin->mm,
+				    addr, nr_pages,
+				    pages, NULL, gup_flags,
+				    vaddr_pin);
+	return ret;
+}
+EXPORT_SYMBOL(vaddr_pin_pages);
+
+/**
+ * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
+ *
+ * @pages, array of pages returned
+ * @nr_pages, number of pages in pages
+ * @vaddr_pin, same information passed to vaddr_pin_pages
+ * @make_dirty: whether to mark the pages dirty
+ *
+ * The semantics are similar to put_user_pages_dirty_lock but a vaddr_pin used
+ * in vaddr_pin_pages should be passed back into this call for propper
+ * tracking.
+ */
+void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
+				  struct vaddr_pin *vaddr_pin, bool make_dirty)
+{
+	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
+}
+EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
-- 
2.20.1

