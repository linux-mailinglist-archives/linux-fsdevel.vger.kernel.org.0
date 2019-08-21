Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D30970AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 06:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHUEEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 00:04:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18775 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHUEEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:04:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5cc2ad0004>; Tue, 20 Aug 2019 21:03:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Aug 2019 21:03:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Aug 2019 21:03:58 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:03:57 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:03:57 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Aug 2019 04:03:57 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5cc2ad0000>; Tue, 20 Aug 2019 21:03:57 -0700
From:   John Hubbard <jhubbard@nvidia.com>
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
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/4] mm/gup: introduce vaddr_pin_pages_remote(), and invoke it
Date:   Tue, 20 Aug 2019 21:03:55 -0700
Message-ID: <20190821040355.19566-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190821040355.19566-1-jhubbard@nvidia.com>
References: <20190821040355.19566-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566360238; bh=84bhj2PTobIrNB4qrJQexuzhd7TgFsVEFFO7B0hh5tU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=nhL1HSK2U4WrKC5vGw3005UMictu1E4EM+yEDzDmb6ZkyWfRgLvFtM7196fevI5sV
         GXmipG5tsboszbdoEPIJy0512aMsw78D+8KclfySfhJeY74wtgtdl9tzr9YvK03S0F
         d9PC4sNf31/PgrnlUlmK0M1k1S7zdRM39LPfT2OkKqrNba4Kewa1lGY2MxXQE16M9i
         yPtAlQWhCfrDDRKVlTvz3MH9E+1UzGRAevREc/6foOp3DNrMo31pgLtt+1Br8HvKPn
         RX4BTFbIm2RUzGmbp9kDWvkaiGUYHSV5AQ/XpeX0xE0Y3fOw18V/JdP7PqrECgIl86
         PeNFAAGpzLlNQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vaddr_pin_user_pages_remote() is the "vaddr_pin_pages" corresponding
variant to get_user_pages_remote(): it adds the ability to handle
FOLL_PIN, FOLL_LONGTERM, or both.

Note that the put_user_page*() requirement won't be truly required until
all of the call sites have been converted, and the tracking of pages is
activated.

Also, change process_vm_rw_single_vec() to invoke the new function.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h     |  5 +++++
 mm/gup.c               | 33 +++++++++++++++++++++++++++++++++
 mm/process_vm_access.c | 23 ++++++++++++++---------
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6e7de424bf5e..849b509e9f89 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1606,6 +1606,11 @@ int __account_locked_vm(struct mm_struct *mm, unsign=
ed long pages, bool inc,
 long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
 		     unsigned int gup_flags, struct page **pages,
 		     struct vaddr_pin *vaddr_pin);
+long vaddr_pin_user_pages_remote(struct task_struct *tsk, struct mm_struct=
 *mm,
+				 unsigned long start, unsigned long nr_pages,
+				 unsigned int gup_flags, struct page **pages,
+				 struct vm_area_struct **vmas, int *locked,
+				 struct vaddr_pin *vaddr_pin);
 void vaddr_unpin_pages(struct page **pages, unsigned long nr_pages,
 		       struct vaddr_pin *vaddr_pin, bool make_dirty);
 bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *pa=
ge);
diff --git a/mm/gup.c b/mm/gup.c
index e49096d012ea..d7ce9b38178f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2522,3 +2522,36 @@ void vaddr_unpin_pages(struct page **pages, unsigned=
 long nr_pages,
 	__put_user_pages_dirty_lock(pages, nr_pages, make_dirty, vaddr_pin);
 }
 EXPORT_SYMBOL(vaddr_unpin_pages);
+
+/**
+ * vaddr_pin_user_pages_remote() - pin pages by virtual address and return=
 the
+ * pages to the user.
+ *
+ * @tsk:	the task_struct to use for page fault accounting, or
+ *		NULL if faults are not to be recorded.
+ * @mm:		mm_struct of target mm
+ * @addr:	start address
+ * @nr_pages:	number of pages to pin
+ * @gup_flags:	flags to use for the pin. Please see FOLL_* documentation i=
n
+ *		mm.h.
+ * @pages:	array of pages returned
+ * @vaddr_pin:  If FOLL_LONGTERM is set, then vaddr_pin should point to an
+ * initialized struct that contains the owning mm and file. Otherwise, vad=
dr_pin
+ * should be set to NULL.
+ *
+ * This is the "vaddr_pin_pages" corresponding variant to
+ * get_user_pages_remote(), but with the ability to handle FOLL_PIN,
+ * FOLL_LONGTERM, or both.
+ */
+long vaddr_pin_user_pages_remote(struct task_struct *tsk, struct mm_struct=
 *mm,
+				 unsigned long start, unsigned long nr_pages,
+				 unsigned int gup_flags, struct page **pages,
+				 struct vm_area_struct **vmas, int *locked,
+				 struct vaddr_pin *vaddr_pin)
+{
+	gup_flags |=3D FOLL_TOUCH | FOLL_REMOTE;
+
+	return __get_user_pages_locked(tsk, mm, start, nr_pages, pages, vmas,
+				       locked, gup_flags, vaddr_pin);
+}
+EXPORT_SYMBOL(vaddr_pin_user_pages_remote);
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 357aa7bef6c0..e08c1f760ad4 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -96,7 +96,7 @@ static int process_vm_rw_single_vec(unsigned long addr,
 		flags |=3D FOLL_WRITE;
=20
 	while (!rc && nr_pages && iov_iter_count(iter)) {
-		int pages =3D min(nr_pages, max_pages_per_loop);
+		int pinned_pages =3D min(nr_pages, max_pages_per_loop);
 		int locked =3D 1;
 		size_t bytes;
=20
@@ -106,14 +106,18 @@ static int process_vm_rw_single_vec(unsigned long add=
r,
 		 * current/current->mm
 		 */
 		down_read(&mm->mmap_sem);
-		pages =3D get_user_pages_remote(task, mm, pa, pages, flags,
-					      process_pages, NULL, &locked);
+
+		flags |=3D FOLL_PIN;
+		pinned_pages =3D vaddr_pin_user_pages_remote(task, mm, pa,
+							   pinned_pages, flags,
+							   process_pages, NULL,
+							   &locked, NULL);
 		if (locked)
 			up_read(&mm->mmap_sem);
-		if (pages <=3D 0)
+		if (pinned_pages <=3D 0)
 			return -EFAULT;
=20
-		bytes =3D pages * PAGE_SIZE - start_offset;
+		bytes =3D pinned_pages * PAGE_SIZE - start_offset;
 		if (bytes > len)
 			bytes =3D len;
=20
@@ -122,10 +126,11 @@ static int process_vm_rw_single_vec(unsigned long add=
r,
 					 vm_write);
 		len -=3D bytes;
 		start_offset =3D 0;
-		nr_pages -=3D pages;
-		pa +=3D pages * PAGE_SIZE;
-		while (pages)
-			put_page(process_pages[--pages]);
+		nr_pages -=3D pinned_pages;
+		pa +=3D pinned_pages * PAGE_SIZE;
+
+		/* If vm_write is set, the pages need to be made dirty: */
+		vaddr_unpin_pages(process_pages, pinned_pages, NULL, vm_write);
 	}
=20
 	return rc;
--=20
2.22.1

