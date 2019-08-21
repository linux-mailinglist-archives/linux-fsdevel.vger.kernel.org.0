Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72B17970C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 06:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfHUEHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 00:07:40 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18936 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfHUEHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:07:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5cc3870000>; Tue, 20 Aug 2019 21:07:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 20 Aug 2019 21:07:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 20 Aug 2019 21:07:34 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:07:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 04:07:33 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Aug 2019 04:07:33 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5cc3850004>; Tue, 20 Aug 2019 21:07:33 -0700
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
        John Hubbard <jhubbard@nvidia.com>,
        "Michal Hocko" <mhocko@kernel.org>
Subject: [PATCH v2 2/3] mm/gup: introduce FOLL_PIN flag for get_user_pages()
Date:   Tue, 20 Aug 2019 21:07:26 -0700
Message-ID: <20190821040727.19650-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190821040727.19650-1-jhubbard@nvidia.com>
References: <20190821040727.19650-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566360455; bh=vXTR5X576mO9cmS9xl7R7KR9+U7vJV56myFxKqNBdTs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=RJvMkiak0tzTwcCSvp33yG5WfqF9U4NOaOCVMZ5uYvRXjYdZi+/K97QTPP5ZrURvK
         6pM2OKGy8zZc3UvMYlHiZkLqER5IcaSP6qs5SX9frmczNM5fEsm3U952K6yieeJwc3
         51cP+GTW5WHrvhwdEl1aAW5PFlfR8EpZTqS/ZpX6Xbm+WNCXL24HWIcIdXQpMsUIzE
         D0mk89PmNnLoQ/PfiZYEPVRLmXeFy0q8pSqg+ZRSmJrlnOZOlOeqEm+z1UmZtcCw4b
         cuYh/n9t7lihEjNuAsyxPqaxrYCf5IK9OEPa4qnFsT2qQNmjWR/kFrIpk0teDK7KAa
         C/pGQVF0bsKTQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As explained in the newly added documentation for FOLL_PIN and
FOLL_LONGTERM, in every case where vaddr_pin_pages() is required,
FOLL_PIN must be set. That reason, plus a desire to keep FOLL_PIN
an internal (to get_user_pages() and follow_page()) detail, is why
vaddr_pin_pages() sets FOLL_PIN.

FOLL_LONGTERM, on the other hand, in only set in *some* cases, but
not all. For that reason, this patch moves the setting of FOLL_LONGTERM
out to the caller.

Also add fairly extensive documentation of the meaning and use
of both FOLL_PIN and FOLL_LONGTERM.

Thanks to Jan Kara and Vlastimil Babka for explaining the 4 cases
in this documentation. (I've reworded it and expanded on it slightly.)

The motivation behind moving away from "bare" get_user_pages() calls
is described in more detail in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jan Kara <jack@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem.c |  1 +
 include/linux/mm.h             | 56 ++++++++++++++++++++++++++++++----
 mm/gup.c                       |  2 +-
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index e69eecb0023f..d84f1bfb8d21 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -300,6 +300,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, uns=
igned long addr,
=20
 	while (npages) {
 		down_read(&mm->mmap_sem);
+		gup_flags |=3D FOLL_LONGTERM;
 		ret =3D vaddr_pin_pages(cur_base,
 				     min_t(unsigned long, npages,
 					   PAGE_SIZE / sizeof (struct page *)),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc675e94ddf8..6e7de424bf5e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2644,6 +2644,8 @@ static inline vm_fault_t vmf_error(int err)
 struct page *follow_page(struct vm_area_struct *vma, unsigned long address=
,
 			 unsigned int foll_flags);
=20
+/* Flags for follow_page(), get_user_pages ("GUP"), and vaddr_pin_pages():=
 */
+
 #define FOLL_WRITE	0x01	/* check pte is writable */
 #define FOLL_TOUCH	0x02	/* mark page accessed */
 #define FOLL_GET	0x04	/* do get_page on page */
@@ -2663,13 +2665,15 @@ struct page *follow_page(struct vm_area_struct *vma=
, unsigned long address,
 #define FOLL_ANON	0x8000	/* don't do file mappings */
 #define FOLL_LONGTERM	0x10000	/* mapping lifetime is indefinite: see below=
 */
 #define FOLL_SPLIT_PMD	0x20000	/* split huge pmd before returning */
+#define FOLL_PIN	0x40000	/* pages must be released via put_user_page() */
=20
 /*
- * NOTE on FOLL_LONGTERM:
+ * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with eac=
h
+ * other. Here is what they mean, and how to use them:
  *
  * FOLL_LONGTERM indicates that the page will be held for an indefinite ti=
me
- * period _often_ under userspace control.  This is contrasted with
- * iov_iter_get_pages() where usages which are transient.
+ * period _often_ under userspace control.  This is in contrast to
+ * iov_iter_get_pages(), where usages which are transient.
  *
  * FIXME: For pages which are part of a filesystem, mappings are subject t=
o the
  * lifetime enforced by the filesystem and we need guarantees that longter=
m
@@ -2684,11 +2688,51 @@ struct page *follow_page(struct vm_area_struct *vma=
, unsigned long address,
  * Currently only get_user_pages() and get_user_pages_fast() support this =
flag
  * and calls to get_user_pages_[un]locked are specifically not allowed.  T=
his
  * is due to an incompatibility with the FS DAX check and
- * FAULT_FLAG_ALLOW_RETRY
+ * FAULT_FLAG_ALLOW_RETRY.
  *
- * In the CMA case: longterm pins in a CMA region would unnecessarily frag=
ment
- * that region.  And so CMA attempts to migrate the page before pinning wh=
en
+ * In the CMA case: long term pins in a CMA region would unnecessarily fra=
gment
+ * that region.  And so, CMA attempts to migrate the page before pinning, =
when
  * FOLL_LONGTERM is specified.
+ *
+ * FOLL_PIN indicates that a special kind of tracking (not just page->_ref=
count,
+ * but an additional pin counting system) will be invoked. This is intende=
d for
+ * anything that gets a page reference and then touches page data (for exa=
mple,
+ * Direct IO). This lets the filesystem know that some non-file-system ent=
ity is
+ * potentially changing the pages' data. FOLL_PIN pages must be released,
+ * ultimately, by a call to put_user_page(). Typically that will be via on=
e of
+ * the vaddr_unpin_pages() variants.
+ *
+ * FIXME: note that this special tracking is not in place yet. However, th=
e
+ * pages should still be released by put_user_page().
+ *
+ * When and where to use each flag:
+ *
+ * CASE 1: Direct IO (DIO). There are GUP references to pages that are ser=
ving
+ * as DIO buffers. These buffers are needed for a relatively short time (s=
o they
+ * are not "long term"). No special synchronization with page_mkclean() or
+ * munmap() is provided. Therefore, flags to set at the call site are:
+ *
+ *     FOLL_PIN
+ *
+ * CASE 2: RDMA. There are GUP references to pages that are serving as DMA
+ * buffers. These buffers are needed for a long time ("long term"). No spe=
cial
+ * synchronization with page_mkclean() or munmap() is provided. Therefore,=
 flags
+ * to set at the call site are:
+ *
+ *     FOLL_PIN | FOLL_LONGTERM
+ *
+ * There is also a special case when the pages are DAX pages: in addition =
to the
+ * above flags, the caller needs a file lease. This is provided via the st=
ruct
+ * vaddr_pin argument to vaddr_pin_pages().
+ *
+ * CASE 3: ODP (Mellanox/Infiniband On Demand Paging: the hardware support=
s
+ * replayable page faulting). There are GUP references to pages serving as=
 DMA
+ * buffers. For ODP, MMU notifiers are used to synchronize with page_mkcle=
an()
+ * and munmap(). Therefore, normal GUP calls are sufficient, so neither fl=
ag
+ * needs to be set.
+ *
+ * CASE 4: pinning for struct page manipulation only. Here, normal GUP cal=
ls are
+ * sufficient, so neither flag needs to be set.
  */
=20
 static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
diff --git a/mm/gup.c b/mm/gup.c
index e49096d012ea..ba316d960d7a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2490,7 +2490,7 @@ long vaddr_pin_pages(unsigned long addr, unsigned lon=
g nr_pages,
 {
 	long ret;
=20
-	gup_flags |=3D FOLL_LONGTERM;
+	gup_flags |=3D FOLL_PIN;
=20
 	if (!vaddr_pin || (!vaddr_pin->mm && !vaddr_pin->f_owner))
 		return -EINVAL;
--=20
2.22.1

