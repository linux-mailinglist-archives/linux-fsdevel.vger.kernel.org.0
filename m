Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5656DB43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfD2EyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:28441 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfD2EyI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566289"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:07 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 04/10] WIP: mm/gup: Ensure F_LONGTERM lease is held on GUP pages
Date:   Sun, 28 Apr 2019 21:53:53 -0700
Message-Id: <20190429045359.8923-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429045359.8923-1-ira.weiny@intel.com>
References: <20190429045359.8923-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Honestly I think I should remove this patch.  It is removed later in the
series and ensuring the lease is there at GUP time does not guarantee
the lease is held.  The user could remove the lease???

Regardless the code in GUP to take the lease holds it even if the user
does try to remove it and will take the lease back if they race and the
lease is remove prior to the GUP getting a reference to it...

So pretty much anyway you slice it this patch is not needed...

FOLL_LONGTERM pins are currently disabled for GUP calls which map to FS
DAX files.  As an alternative allow these files to be mapped if the user
has taken a F_LONGTERM lease on the file.

The intention is that the user is aware of the dangers of file
truncated/hole punch and accepts

file which has been mapped this way (such as is done
with RDMA) and they have taken this lease to indicate they will accept
the behavior if the filesystem needs to take action.

Example user space pseudocode for a user using RDMA and reacting to a
lease break of this type would look like this:

    lease_break() {
    ...
            if (sigio.fd == rdma_fd) {
                    ibv_dereg_mr(mr);
                    close(rdma_fd);
            }
    }

    foo() {
            rdma_fd = open()
            fcntl(rdma_fd, F_SETLEASE, F_LONGTERM);
            sigaction(SIGIO, ...  lease_break ...);
            ptr = mmap(rdma_fd, ...);
            mr = ibv_reg_mr(ptr, ...);
    }

Failure to process the SIGIO as above will result in a SIGBUS being
given to the process.  SIGBUS is implemented in later patches.

This patch X of Y fails the FOLL_LONGTERM pin if the FL_LONGTERM lease
is not held.
---
 fs/locks.c         | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h |  2 ++
 mm/gup.c           | 13 +++++++++++++
 mm/huge_memory.c   | 20 ++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 8ea1c5713e6a..31c8b761a578 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2939,3 +2939,50 @@ static int __init filelock_init(void)
 	return 0;
 }
 core_initcall(filelock_init);
+
+// FIXME what about GUP calls to Device DAX???
+// I believe they will still return true for *_devmap
+//
+// return true if the page has a LONGTERM lease associated with it's file.
+bool mapping_inode_has_longterm(struct page *page)
+{
+	bool ret;
+	struct inode *inode;
+	struct file_lock *fl;
+	struct file_lock_context *ctx;
+
+	/*
+	 * should never be here unless we are a "page cache" page without a
+	 * page cache.
+	 */
+	if (WARN_ON(PageAnon(page)))
+		return false;
+	if (WARN_ON(!page))
+		return false;
+	if (WARN_ON(!page->mapping))
+		return false;
+	if (WARN_ON(!page->mapping->host))
+		return false;
+
+	/* Ensure page->mapping isn't freed while we look at it */
+	/* FIXME mm lock is held here I think?  so is this really needed? */
+	rcu_read_lock();
+	inode = page->mapping->host;
+
+	ctx = locks_get_lock_context(inode, F_RDLCK);
+
+	ret = false;
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+		if (fl->fl_flags & FL_LONGTERM) {
+			ret = true;
+			break;
+		}
+	}
+	spin_unlock(&ctx->flc_lock);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mapping_inode_has_longterm);
+
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e34ec5dfbe..cde359e71b7b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1572,6 +1572,8 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 int get_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 
+bool mapping_inode_has_longterm(struct page *page);
+
 /* Container for pinned pfns / pages */
 struct frame_vector {
 	unsigned int nr_allocated;	/* Number of frames we have space for */
diff --git a/mm/gup.c b/mm/gup.c
index a8ac75bc1452..5ae1dd31a58d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -292,6 +292,12 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			page = pte_page(pte);
 		else
 			goto no_page;
+
+		if (unlikely(flags & FOLL_LONGTERM) &&
+		    !mapping_inode_has_longterm(page)) {
+			page = ERR_PTR(-EINVAL);
+			goto out;
+		}
 	} else if (unlikely(!page)) {
 		if (flags & FOLL_DUMP) {
 			/* Avoid special (like zero) pages in core dumps */
@@ -1869,6 +1875,13 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
+
+		if (unlikely(flags & FOLL_LONGTERM) &&
+		    !mapping_inode_has_longterm(page)) {
+			undo_dev_pagemap(nr, nr_start, pages);
+			return 0;
+		}
+
 		if (get_gup_pin_page(page)) {
 			undo_dev_pagemap(nr, nr_start, pages);
 			return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 404acdcd0455..8819624c740f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -910,6 +910,16 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
+
+	// Check for Layout lease.
+	// FIXME combine logic
+	if (unlikely(flags & FOLL_LONGTERM)) {
+		WARN_ON_ONCE(PageAnon(page));
+		if (!mapping_inode_has_longterm(page)) {
+			return NULL;
+		}
+	}
+
 	get_page(page);
 
 	return page;
@@ -1050,6 +1060,16 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
+
+	// Check for LONGTERM lease.
+	// FIXME combine logic remove Warn
+	if (unlikely(flags & FOLL_LONGTERM)) {
+		WARN_ON_ONCE(PageAnon(page));
+		if (!mapping_inode_has_longterm(page)) {
+			return NULL;
+		}
+	}
+
 	get_page(page);
 
 	return page;
-- 
2.20.1

