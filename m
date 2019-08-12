Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6961489544
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 03:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHLBu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 21:50:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41607 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfHLBu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 21:50:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so47106182pls.8;
        Sun, 11 Aug 2019 18:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JtiWY0w31kuQOtn3l4X+8CaJzkxiVZy5vK9oZwhAyM=;
        b=tN18OW3egtBoEIE9QN2L83YpkIuEmn8E/2vatlX2Rt8/d5Cz4UgSVajiq6e/mKLtaS
         Y249S8PkRKY1XNNQCc1ShRk2rwVcEYBgq5dc/KhKvRDosjYbqzTKzsXamCtfiXYDc9Xp
         e09h33F7vAARQiFw/FG8VCiqdIkvyyhBlY/mp3fdDfxf6u2KTJYoHRQkFO45IwfAa5bo
         gJG8IrKfVZKwLlhGy/t3ERaR2nPJMfzZ5Lyz1p0oex5y7bLt3zvVM2vRFJ5rXSFt80t5
         3snZBb+hSDGsUlRyup/QfXn5z03seNoHqcPJopyWhki+dM/QX6bD5iOeLfhwkSMlhTih
         Gj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JtiWY0w31kuQOtn3l4X+8CaJzkxiVZy5vK9oZwhAyM=;
        b=Wbw8fm51zM6+Z/vl5lKHDjQN3Y59AOd4sn6pZtN0WOw8imPTPeiG7cTMMo4KHaAus0
         dVhn7Iqg6x04BP1+95q+p/1JvNJJ/WlwMbEBNMv1RDzRyUP+0Z/kND/ZM6HUzLVIPGtI
         NHwYDUTJZjZKlwLHxxYOh3HebepGXJDwdR1SmEEoWOBG4nK5QXLBB/+vcdcw5UG2vwIT
         dorfDQ7aEPMU38t0F29rsS6R8En6vbSmy/NljkfUoaBlLjCshnfBtsnPEhgs1OLwLJUq
         GgoSa0AOaeut7w1PevjvvTFOTGUVzpRLVC1STjheZS7vc2YlPmABLRWrBNBqxUjFeuvX
         qEGQ==
X-Gm-Message-State: APjAAAVRkk8ukadmsDDEKmKl6OPedDj4d3rIjEH6QbD34MFA68Ir8tVa
        XJNUutLZbhRWGfzdrRbPPEY=
X-Google-Smtp-Source: APXvYqzBXwirWl6l+fEmHVCahvbTNzZTrBy2+Jlu3deIQj1LEMtfht+Rr+eRVfWYnMxSvK5SOCC2EQ==
X-Received: by 2002:a17:902:e311:: with SMTP id cg17mr3605017plb.183.1565574657941;
        Sun, 11 Aug 2019 18:50:57 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id j20sm100062363pfr.113.2019.08.11.18.50.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 18:50:57 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 2/2] mm/gup: introduce vaddr_pin_pages_remote()
Date:   Sun, 11 Aug 2019 18:50:44 -0700
Message-Id: <20190812015044.26176-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190812015044.26176-1-jhubbard@nvidia.com>
References: <20190812015044.26176-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

This is the "vaddr_pin_pages" corresponding variant to
get_user_pages_remote(), but with FOLL_PIN semantics: the implementation
sets FOLL_PIN. That, in turn, means that the pages must ultimately be
released by put_user_page*()--typically, via vaddr_unpin_pages*().

Note that the put_user_page*() requirement won't be truly
required until all of the call sites have been converted, and
the tracking of pages is actually activated.

Also introduce vaddr_unpin_pages(), in order to have a simpler
call for the error handling cases.

Use both of these new calls in the Infiniband drive, replacing
get_user_pages_remote() and put_user_pages().

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 15 +++++----
 include/linux/mm.h                 |  7 +++++
 mm/gup.c                           | 50 ++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 53085896d718..fdff034a8a30 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -534,7 +534,7 @@ static int ib_umem_odp_map_dma_single_page(
 	}
 
 out:
-	put_user_page(page);
+	vaddr_unpin_pages(&page, 1, &umem_odp->umem.vaddr_pin);
 
 	if (remove_existing_mapping) {
 		ib_umem_notifier_start_account(umem_odp);
@@ -635,9 +635,10 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 		 * complex (and doesn't gain us much performance in most use
 		 * cases).
 		 */
-		npages = get_user_pages_remote(owning_process, owning_mm,
+		npages = vaddr_pin_pages_remote(owning_process, owning_mm,
 				user_virt, gup_num_pages,
-				flags, local_page_list, NULL, NULL);
+				flags, local_page_list, NULL, NULL,
+				&umem_odp->umem.vaddr_pin);
 		up_read(&owning_mm->mmap_sem);
 
 		if (npages < 0) {
@@ -657,7 +658,8 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 					ret = -EFAULT;
 					break;
 				}
-				put_user_page(local_page_list[j]);
+				vaddr_unpin_pages(&local_page_list[j], 1,
+						  &umem_odp->umem.vaddr_pin);
 				continue;
 			}
 
@@ -684,8 +686,9 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 			 * ib_umem_odp_map_dma_single_page().
 			 */
 			if (npages - (j + 1) > 0)
-				put_user_pages(&local_page_list[j+1],
-					       npages - (j + 1));
+				vaddr_unpin_pages(&local_page_list[j+1],
+						  npages - (j + 1),
+						  &umem_odp->umem.vaddr_pin);
 			break;
 		}
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 61b616cd9243..2bd76ad8787e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1606,6 +1606,13 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
 		     unsigned int gup_flags, struct page **pages,
 		     struct vaddr_pin *vaddr_pin);
+long vaddr_pin_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
+			    unsigned long start, unsigned long nr_pages,
+			    unsigned int gup_flags, struct page **pages,
+			    struct vm_area_struct **vmas, int *locked,
+			    struct vaddr_pin *vaddr_pin);
+void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
+		       struct vaddr_pin *vaddr_pin);
 void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
 				  struct vaddr_pin *vaddr_pin, bool make_dirty);
 bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *page);
diff --git a/mm/gup.c b/mm/gup.c
index 85f09958fbdc..bb95adfaf9b6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2518,6 +2518,38 @@ long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
 }
 EXPORT_SYMBOL(vaddr_pin_pages);
 
+/**
+ * vaddr_pin_pages pin pages by virtual address and return the pages to the
+ * user.
+ *
+ * @tsk:	the task_struct to use for page fault accounting, or
+ *		NULL if faults are not to be recorded.
+ * @mm:		mm_struct of target mm
+ * @addr:	start address
+ * @nr_pages:	number of pages to pin
+ * @gup_flags:	flags to use for the pin
+ * @pages:	array of pages returned
+ * @vaddr_pin:	initialized meta information this pin is to be associated
+ * with.
+ *
+ * This is the "vaddr_pin_pages" corresponding variant to
+ * get_user_pages_remote(), but with FOLL_PIN semantics: the implementation sets
+ * FOLL_PIN. That, in turn, means that the pages must ultimately be released
+ * by put_user_page().
+ */
+long vaddr_pin_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
+			    unsigned long start, unsigned long nr_pages,
+			    unsigned int gup_flags, struct page **pages,
+			    struct vm_area_struct **vmas, int *locked,
+			    struct vaddr_pin *vaddr_pin)
+{
+	gup_flags |= FOLL_TOUCH | FOLL_REMOTE | FOLL_PIN;
+
+	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
+				       locked, gup_flags, vaddr_pin);
+}
+EXPORT_SYMBOL(vaddr_pin_pages_remote);
+
 /**
  * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
  *
@@ -2536,3 +2568,21 @@ void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
 	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
 }
 EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
+
+/**
+ * vaddr_unpin_pages - simple, non-dirtying counterpart to vaddr_pin_pages
+ *
+ * @pages: array of pages returned
+ * @nr_pages: number of pages in pages
+ * @vaddr_pin: same information passed to vaddr_pin_pages
+ *
+ * Like vaddr_unpin_pages_dirty_lock, but for non-dirty pages. Useful in putting
+ * back pages in an error case: they were never made dirty.
+ */
+void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
+		       struct vaddr_pin *vaddr_pin)
+{
+	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, false);
+}
+EXPORT_SYMBOL(vaddr_unpin_pages);
+
-- 
2.22.0

